report 53051 "Ficheiro CGA Nova Versão"
{
    // //-------------------------------------------------------
    //               Ficheiro da CGA
    // //--------------------------------------------------------
    //   É um ficheiro que deve ser entregue mensalmente pela empresa
    //   com os rendimentos e descontos dos empregados à CGA.
    // 
    //   Este mapa deve sair em formato txt e como tal numa primeira fase
    //   exporta os dados para uma tabela criada para este tipo de mapas
    //   (Tabela Temp Ficheiro Texto) e depois corre um dataport (Temp Ficheiro Texto)
    //   para criar o ficheiro txt
    // 
    // //-------------------------------------------------------

    UsageCategory = Tasks;
    ApplicationArea = HumanResourcesAppArea;

    Permissions = TableData "Tabela Temp Ficheiros Texto" = rimd;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(Empregado; Empregado)
        {
            DataItemTableView = SORTING("No.") WHERE("Subsccritor CGA" = CONST(true));
            dataitem("Hist. Linhas Movs. Empregado"; "Hist. Linhas Movs. Empregado")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Employee No.", "Data Registo", "Cód. Situação", "Cód. Movimento") WHERE("Tipo Processamento" = FILTER(Vencimentos | SubNatal | SubFerias));

                trigger OnAfterGetRecord()
                var
                    encontrou: Boolean;
                begin
                    //19.03.06 - Em vez de usarmos as rubricas salariais vamos apanhar todos os registos que têm cod. situação preenchido
                    encontrou := false;
                    if "Hist. Linhas Movs. Empregado"."Cód. Situação" <> '' then
                        encontrou := true;
                    if encontrou = false then
                        CurrReport.Skip;

                    // Group Footer OnPostSection

                    //************************************************************************************
                    //Isto é um Group por: EMP, DATA EFEITO, COD SITUAÇÃO
                    //só entra para o grupo se for um registo do tipo processamento e com incidencia CGA
                    //************************************************************************************

                    //Limpar variáveis a cada empregado
                    ValorRemuneracao := 0;
                    ValorDesconto := 0;
                    Clear(NhorasSem);
                    Clear(NhorasDocencia);
                    Clear(NCGA);

                    if ("Hist. Linhas Movs. Empregado".Valor <> 0) or
                      (("Hist. Linhas Movs. Empregado".Valor = 0) and ("Hist. Linhas Movs. Empregado"."Cód. Situação" = '50'))
                      then begin //2008.10.10 licenças sem vencimento tem de aparecer a zero
                                 //---------------------
                                 //Valor da remuneração
                                 //---------------------
                        ValorRemuneracao := Round("Hist. Linhas Movs. Empregado".Valor, 0.01);

                        //2008.05.04 - agora vai buscar o Nº Horas semanais ao Hist.
                        TabHistCabMovEmp.Reset;
                        TabHistCabMovEmp.SetRange(TabHistCabMovEmp."Cód. Processamento", "Hist. Linhas Movs. Empregado"."Cód. Processamento");
                        TabHistCabMovEmp.SetRange(TabHistCabMovEmp."Tipo Processamento", "Hist. Linhas Movs. Empregado"."Tipo Processamento");
                        TabHistCabMovEmp.SetRange(TabHistCabMovEmp."Employee No.", "Hist. Linhas Movs. Empregado"."Employee No.");
                        if TabHistCabMovEmp.FindFirst then begin
                            NhorasSem := TabHistCabMovEmp."No. Horas Semanais";
                            NhorasSemanaisTotais := TabHistCabMovEmp."Nº Horas Semanais Totais";
                            NhorasDocencia := TabHistCabMovEmp."Nº Horas Docência Calc. Desct.";
                            NCGA := TabHistCabMovEmp."Nº CGA";
                            if StrLen(Format(NCGA)) > 7 then
                                Error(Text0001, TabHistCabMovEmp."Employee No.");
                            Nivel := TabHistCabMovEmp."Grau Função";
                        end;
                        //19.03.07 - Se for cod. situação 01 tem de subtrair o valor das faltas ou seja
                        //todas os codigos de situação do tipo perdas efectivas

                        if "Hist. Linhas Movs. Empregado"."Cód. Situação" = '01' then begin
                            TabCodigosSituacao.Reset;
                            TabCodigosSituacao.SetRange(TabCodigosSituacao."Perdas Efectivas", true);
                            if TabCodigosSituacao.FindSet then begin
                                repeat
                                    TabHistMovEmp.Reset;
                                    TabHistMovEmp.SetRange(TabHistMovEmp."Data Registo", DataIni, DataFim);
                                    TabHistMovEmp.SetRange(TabHistMovEmp."Employee No.", Empregado."No.");
                                    TabHistMovEmp.SetRange(TabHistMovEmp."Tipo Processamento", TabHistMovEmp."Tipo Processamento"::Vencimentos);
                                    TabHistMovEmp.SetRange(TabHistMovEmp."Cód. Situação", TabCodigosSituacao."Cód. Situação");
                                    if TabHistMovEmp.Find('-') then begin
                                        repeat
                                            ValorRemuneracao := ValorRemuneracao - Abs(TabHistMovEmp.Valor);
                                        until TabHistMovEmp.Next = 0;
                                    end;
                                until TabCodigosSituacao.Next = 0;
                            end;
                            ValorRemuneracao := Round(ValorRemuneracao, 0.01);
                        end;

                        //27.04.07 e 30.04.07 - Ter em conta o nº horas de docencia e não o nº de horas semanais
                        if Empregado."Nº Horas Docência Calc. Desct." <> 0 then begin
                            //13.08.2008 - quando é horário parcial as contas são feitas pelos dias esperados
                            if Empregado."Regime Duração Trabalho" = Empregado."Regime Duração Trabalho"::"1" then begin
                                //HG 2008.10.23 - se a pessoa ganha acima da tabela e tem 22 ou menos então tem de se fazer
                                //a regra dos dias esperados pelo valor da tabela e não pelo valor do ordenado
                                GrauFuncao.Reset;
                                if GrauFuncao.Get(Nivel) then begin
                                    if (ValorRemuneracao > GrauFuncao."Max Value") and (NhorasSem <= 22) then begin
                                        ValorRemuneracao := GrauFuncao."Max Value" / NhorasSem * NhorasDocencia; //C+ 2008.05.04
                                        ValorRemuneracao := Round(ValorRemuneracao, 0.01);
                                    end;
                                    //2008.11.24 -Existem duas pessoas que ganham acima da tabela
                                    //Uma: porque em vez de ter 22 horas lectivas tem mais e então ganha mais
                                    //Outra: ganha efectivamente acima da tabela para o nº de horas que faz
                                    //Neste segundo caso temos de descontar só sobbre o valor da tabela
                                    if ValorRemuneracao > (GrauFuncao."Valor Hora Semanal" * NhorasSem) then begin
                                        ValorRemuneracao := Round(GrauFuncao."Max Value");
                                        ValorRemuneracao := Round(ValorRemuneracao, 0.01);
                                    end else begin
                                        //2009.12.02 Como usam complemento de vencimento, isto n faz sentido
                                        //ValorRemuneracao := ValorRemuneracao / NhorasSem * NhorasDocencia; //C+ 2008.05.04
                                        ValorRemuneracao := Round(ValorRemuneracao, 0.01);
                                    end;
                                end;
                            end;
                            if Empregado."Regime Duração Trabalho" = Empregado."Regime Duração Trabalho"::"2" then begin
                                GrauFuncao.Reset;
                                if GrauFuncao.Get(Nivel) then begin
                                    //2008.10.23 - tem de ser os horaslectivas
                                    ValorRemuneracao := Round((NhorasSem * 30 / 22), 0.001) * GrauFuncao."Max Value" / 30;
                                    ValorRemuneracao := Round(ValorRemuneracao, 0.01);
                                end;
                            end;
                        end;
                        //27.04.07 - Fim
                        //---------------------
                        //Ir buscar a Tabela Hist 2008.07.01
                        //---------------------
                        TabHistCabMovEmp.Reset;
                        TabHistCabMovEmp.SetRange(TabHistCabMovEmp."Cód. Processamento", "Hist. Linhas Movs. Empregado"."Cód. Processamento");
                        TabHistCabMovEmp.SetRange(TabHistCabMovEmp."Tipo Processamento", "Hist. Linhas Movs. Empregado"."Tipo Processamento");
                        TabHistCabMovEmp.SetRange(TabHistCabMovEmp."Employee No.", "Hist. Linhas Movs. Empregado"."Employee No.");
                        if TabHistCabMovEmp.FindFirst then begin
                            NhorasSemanaisTotais := TabHistCabMovEmp."Nº Horas Semanais Totais";
                            Nivel := TabHistCabMovEmp."Grau Função";
                        end;
                        //---------------------
                        //Numero de Dias 2008.07.01
                        //---------------------
                        DecNumDias := 0;
                        if "Hist. Linhas Movs. Empregado"."Cód. Situação" = '01' then begin
                            if Empregado."Regime Duração Trabalho" = Empregado."Regime Duração Trabalho"::"1" then begin
                                DecNumDias := 30;
                                //2008.10.23 - a partir de agora as faltas têm de ser abatidas ao 01
                                //vimos isto com Anabela em 23.10.2008
                                TabCodigosSituacao.Reset;
                                TabCodigosSituacao.SetRange(TabCodigosSituacao."Perdas Efectivas", true);
                                if TabCodigosSituacao.FindSet then begin
                                    repeat
                                        TabHistMovEmp.Reset;
                                        TabHistMovEmp.SetRange(TabHistMovEmp."Data Registo", DataIni, DataFim);
                                        TabHistMovEmp.SetRange(TabHistMovEmp."Employee No.", Empregado."No.");
                                        TabHistMovEmp.SetRange(TabHistMovEmp."Tipo Processamento", TabHistMovEmp."Tipo Processamento"::Vencimentos);
                                        TabHistMovEmp.SetRange(TabHistMovEmp."Cód. Situação", TabCodigosSituacao."Cód. Situação");
                                        if TabHistMovEmp.Find('-') then begin
                                            repeat
                                                DecNumDias := DecNumDias - Abs(TabHistMovEmp.Quantity);
                                            until TabHistMovEmp.Next = 0;
                                        end;
                                    until TabCodigosSituacao.Next = 0;
                                end;
                                //2008.10.23 - fim
                            end;
                            if Empregado."Regime Duração Trabalho" = Empregado."Regime Duração Trabalho"::"2" then
                                //DecNumDias := ROUND(30 * NhorasSemanaisTotais / 22,0.001); //22 será o horário completo para os parciais
                                //2008.10.23 - no caso dos parciais temos de ir ler às horas lectivas, porque as totais podem passam das 22
                                DecNumDias := Round(30 * NhorasSem / 22, 0.001, '<'); //22 será o horário completo para os parciais
                        end;

                        if ("Hist. Linhas Movs. Empregado"."Cód. Situação" = '49') or
                            ("Hist. Linhas Movs. Empregado"."Cód. Situação" = '56') or
                            ("Hist. Linhas Movs. Empregado"."Cód. Situação" = '58') then begin

                            //ver se a falta está em dias ou horas
                            TabConfUnidadeMedida.Reset;
                            if TabConfUnidadeMedida.Get("Hist. Linhas Movs. Empregado"."Unit of Measure") then begin
                                if TabConfUnidadeMedida."Designação Interna" = TabConfUnidadeMedida."Designação Interna"::Dia then begin
                                    if Empregado."Regime Duração Trabalho" = Empregado."Regime Duração Trabalho"::"1" then
                                        DecNumDias := Abs("Hist. Linhas Movs. Empregado".Quantity);
                                    if Empregado."Regime Duração Trabalho" = Empregado."Regime Duração Trabalho"::"2" then
                                        DecNumDias := Round(30 *
                                        (NhorasSemanaisTotais / Empregado."No. dias de Trabalho Semanal" * Abs("Hist. Linhas Movs. Empregado".Quantity))
                                          / 88, 0.001, '<');
                                end;
                                if TabConfUnidadeMedida."Designação Interna" = TabConfUnidadeMedida."Designação Interna"::Hora then begin
                                    if Empregado."Regime Duração Trabalho" = Empregado."Regime Duração Trabalho"::"1" then
                                        DecNumDias := Abs("Hist. Linhas Movs. Empregado".Quantity);
                                    if Empregado."Regime Duração Trabalho" = Empregado."Regime Duração Trabalho"::"2" then
                                        DecNumDias := Round(30 * Abs("Hist. Linhas Movs. Empregado".Quantity) / 88, 0.001, '<'); //
                                end;
                            end;
                        end;
                        //---------------------
                        //Horario parcial 2008.07.01
                        //---------------------
                        if ("Hist. Linhas Movs. Empregado"."Cód. Situação" = '00') then begin
                            if Empregado."Regime Duração Trabalho" = Empregado."Regime Duração Trabalho"::"2" then begin
                                HorParcial := Round(NhorasSemanaisTotais, 0.1);
                                //2009.02.11
                                HorCompleto := Round(22.0, 0.1)
                            end else begin
                                HorParcial := 0.0;
                                HorCompleto := 0.0;
                            end;
                        end else begin
                            HorParcial := 0.0;
                            HorCompleto := 0.0;
                        end;
                        //---------------------
                        //Categoria 2008.07.01
                        //---------------------
                        if ("Hist. Linhas Movs. Empregado"."Cód. Situação" = '00') then begin
                            TabCatProfQPEmpregado.Reset;
                            TabCatProfQPEmpregado.SetRange(TabCatProfQPEmpregado."Employee No.", Empregado."No.");
                            TabCatProfQPEmpregado.SetFilter(TabCatProfQPEmpregado."Promotion Reason", '<>%1', 0);
                            if TabCatProfQPEmpregado.Find('+') then
                                Cat := CopyStr(TabCatProfQPEmpregado.Description, 1, 25)
                            else
                                Cat := '';
                        end else
                            Cat := '';
                        //---------------------
                        //Nivel 2008.07.01
                        //---------------------
                        if ("Hist. Linhas Movs. Empregado"."Cód. Situação" = '00') then begin
                            Nivel := Nivel;
                        end else
                            Nivel := '';
                        //---------------------
                        //Valor do desconto
                        //---------------------
                        //07-02-2008 - Para nao contar com os professores de acumuação
                        if TabEmpregado.Get("Hist. Linhas Movs. Empregado"."Employee No.") and not TabEmpregado."Professor Acumulação" then
                            ValorDesconto := Round(ValorRemuneracao * ConfRH."Taxa Contributiva Empregado" / 100, 0.01);

                        //---------------------
                        //Perdas Efectivas
                        //---------------------
                        TabCodigosSituacao.Reset;
                        TabCodigosSituacao.SetRange(TabCodigosSituacao."Cód. Situação", "Hist. Linhas Movs. Empregado"."Cód. Situação");
                        if TabCodigosSituacao.Find('-') then begin
                            if TabCodigosSituacao."Perdas Efectivas" = false then
                                PerdasEfectivas := 0
                            else begin
                                //19.03.07 - correcção das faltas
                                ValorDesconto := 0;
                                ValorRemuneracao := 0;
                                PerdasEfectivas := Abs("Hist. Linhas Movs. Empregado".Quantity);
                                //19.03.07 - fim
                            end;
                        end;
                        //13032008 para nao aparecer valores negativos no mapa... fiz assim para nao estar alterar o calculo
                        if ValorRemuneracao < 0 then begin
                            ValorRemuneracao := 0;
                            ValorDesconto := 0;
                        end;
                        TotalDesconto := TotalDesconto + ValorDesconto;
                        //---------------------
                        //Número de Diuturnidades
                        //---------------------
                        TabCodigosSituacao.Reset;
                        TabCodigosSituacao.SetRange(TabCodigosSituacao."Cód. Situação", "Hist. Linhas Movs. Empregado"."Cód. Situação");
                        if TabCodigosSituacao.FindFirst then
                            if not TabCodigosSituacao.Diuturnidades then
                                NumeroDiuturnidades := 0
                            else
                                NumeroDiuturnidades := "Hist. Linhas Movs. Empregado".Quantity;
                        //---------------------
                        //Nome Empregado
                        //---------------------
                        Nome := "Hist. Linhas Movs. Empregado"."Designação Empregado";
                        if StrPos(Nome, ' de ') <> 0 then
                            Nome := CopyStr(Nome, 1, StrPos(Nome, ' de ') - 1) + CopyStr(Nome, StrPos(Nome, ' de ') + 3);

                        if StrPos(Nome, ' do ') <> 0 then
                            Nome := CopyStr(Nome, 1, StrPos(Nome, ' do ') - 1) + CopyStr(Nome, StrPos(Nome, ' do ') + 3);

                        if StrPos(Nome, ' da ') <> 0 then
                            Nome := CopyStr(Nome, 1, StrPos(Nome, ' da ') - 1) + CopyStr(Nome, StrPos(Nome, ' da ') + 3);

                        if StrPos(Nome, ' e ') <> 0 then
                            Nome := CopyStr(Nome, 1, StrPos(Nome, ' e ') - 1) + CopyStr(Nome, StrPos(Nome, ' e ') + 2);

                        Nome := Conv.Ascii2Ascii7bit(Nome);

                        //--------Obrigatoriedade dos campos-------------------
                        ConfRH.TestField(ConfRH."Nº Serviço");
                        if DataIni = 0D then
                            Error(Text53035);
                        if DataFim = 0D then
                            Error(Text53036);
                        "Hist. Linhas Movs. Empregado".TestField("Hist. Linhas Movs. Empregado"."Cód. Situação");
                        ConfRH.TestField(ConfRH."Nome Serviço");
                        //------------------------------------------------------
                        //Cod. Movimento
                        //---------------------
                        //2008.10.30
                        CodMovimento := "Hist. Linhas Movs. Empregado"."Cód. Movimento";
                        //2008.10.23 - Se o Cod. Situação for um código de Saída a Data efeito deve ser Fim do mês
                        //----------------- Se o Cod. Situação não for um código de Saída a Data efeito deve ser Inicio do mês
                        //Esta regra foi dita pela CGA Marisa Correia em mail de 13.10.2008
                        if ("Hist. Linhas Movs. Empregado"."Cód. Situação" = '43') or
                          ("Hist. Linhas Movs. Empregado"."Cód. Situação" = '45') or
                          ("Hist. Linhas Movs. Empregado"."Cód. Situação" = '47') or
                          ("Hist. Linhas Movs. Empregado"."Cód. Situação" = '48') then
                            varDataEfeito := DataFim
                        else
                            varDataEfeito := DataIni;

                        //2008.11.26 - Se o cod. movimento for 9 a dataefeito é o dia 1 do mês a que se refere a falta
                        //se o cod. mov for 6 ou 7, então a dataefeito é o que o utilizadpr escrever no campo ""Data a que se refere mov"
                        if "Hist. Linhas Movs. Empregado"."Cód. Movimento" > 0 then begin
                            TabHistAbonDescExtra.Reset;
                            TabHistAbonDescExtra.SetRange(TabHistAbonDescExtra.Data, DataIni, DataFim);
                            TabHistAbonDescExtra.SetRange(TabHistAbonDescExtra."Payroll Item Code", "Hist. Linhas Movs. Empregado"."Payroll Item Code");
                            TabHistAbonDescExtra.SetRange(TabHistAbonDescExtra."Employee No.", Empregado."No.");//2008.12.11
                            if TabHistAbonDescExtra.FindSet then begin
                                repeat
                                    if ("Hist. Linhas Movs. Empregado"."Cód. Situação" = '49') or
                                      ("Hist. Linhas Movs. Empregado"."Cód. Situação" = '56') or
                                      ("Hist. Linhas Movs. Empregado"."Cód. Situação" = '58') then
                                        DecNumDias := TabHistAbonDescExtra.Quantity
                                    else
                                        DecNumDias := 0.0;

                                    if "Hist. Linhas Movs. Empregado"."Cód. Movimento" <> 1 then
                                        ValorRemuneracao := TabHistAbonDescExtra."Valor Total"
                                    else
                                        ValorRemuneracao := 0;

                                    if "Hist. Linhas Movs. Empregado"."Cód. Movimento" = 1 then
                                        varDataEfeito := DMY2Date(1, Date2DMY(TabHistAbonDescExtra."Reference Date", 2),
                                                          Date2DMY(TabHistAbonDescExtra."Reference Date", 3))
                                    else
                                        varDataEfeito := TabHistAbonDescExtra."Reference Date";

                                    //>>>>>>  LINHA TIPO2 - Registo Movimento da RD >>>>>>>>>>>>>>>>>>>>>>>>>>
                                    TabTempFichTexto.Init;
                                    TabTempFichTexto."Tipo Ficheiro" := TabTempFichTexto."Tipo Ficheiro"::CGA;
                                    vNLinha := vNLinha + 1;
                                    TabTempFichTexto.NLinha := vNLinha;
                                    TabTempFichTexto.Data := WorkDate;
                                    TabTempFichTexto.Texto1 :=
                                    PadStr('0', 6 - StrLen(Format(ConfRH."Nº Serviço")), '0') + Format(ConfRH."Nº Serviço")           //Nº Serviço
                                    + Format("Hist. Linhas Movs. Empregado"."Data Registo", 0, '<Year4><Month,2>')                  //Data RD
                                    + '2'                                                                                         //Tipo de Registo
                                    + PadStr('0', 7 - StrLen(Format(NCGA)), '0') + Format(NCGA)                                        //Nº Subscritor
                                    + PadStr(Nome, 50, ' ')                                                                          //Nome Subscritor
                                    + PadStr("Hist. Linhas Movs. Empregado"."Cód. Situação", 2, ' ')                                 //Cod Siituação
                                    + PadStr(Format(CodMovimento), 1, ' ')                                                           //Cod Movimento
                                    + Format(varDataEfeito, 0, '<Year4><Month,2><Day,2>')                                            //Data efeito
                                    + DelChr(ConvertStr(Format(ValorRemuneracao, 9, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',') //Valor Remuneração
                                    + DelChr(ConvertStr(Format(DecNumDias, 6, '<Sign><Integer><Decimals,4>'), ' ', '0'), '=', ',')       //Numero Dias 2008.07.1
                                    + DelChr(ConvertStr(Format(HorParcial, 5, '<Sign><Integer><Decimals,2>'), ' ', '0'), '=', ',')       //HorParcial 2008.07.1
                                    + DelChr(ConvertStr(Format(HorCompleto, 5, '<Sign><Integer><Decimals,2>'), ' ', '0'), '=', ',')      //Horcompleto 2008.07.1
                                    + PadStr(Cat, 25, ' ')                                                                           //Categoria2008.07.1
                                    + PadStr(Nivel, 3, ' ')                                                                          //Nivel 2008.07.1
                                    + PadStr("Observações Tipo2", 30, ' ');                                                          //Obs 2008.07.1
                                    TabTempFichTexto."Employee No." := Empregado."No.";
                                    TabTempFichTexto."Cod. Situacao" := "Hist. Linhas Movs. Empregado"."Cód. Situação";
                                    TabTempFichTexto.Valor := ValorRemuneracao;
                                    TabTempFichTexto.NDias := DecNumDias;
                                    TabTempFichTexto.Insert;
                                    TotalRegistos := TotalRegistos + 1;

                                until TabHistAbonDescExtra.Next = 0;
                            end;
                        end else begin
                            //>>>>>>  LINHA TIPO2 - Registo Movimento da RD >>>>>>>>>>>>>>>>>>>>>>>>>>
                            //2007.04.03 - Criei este IF pq Se faltou o mês todo (ValorRemuneracao =0) não deve aparecer a linha 01
                            if (ValorRemuneracao <> 0) or ("Hist. Linhas Movs. Empregado"."Cód. Situação" <> '01') then begin
                                TabTempFichTexto.Reset;
                                TabTempFichTexto.SetRange(TabTempFichTexto."Tipo Ficheiro", TabTempFichTexto."Tipo Ficheiro"::CGA);
                                TabTempFichTexto.SetRange(TabTempFichTexto."Employee No.", Empregado."No.");
                                TabTempFichTexto.SetRange(TabTempFichTexto."Cod. Situacao", "Hist. Linhas Movs. Empregado"."Cód. Situação");
                                if not TabTempFichTexto.FindSet then begin
                                    TabTempFichTexto.Init;
                                    TabTempFichTexto."Tipo Ficheiro" := TabTempFichTexto."Tipo Ficheiro"::CGA;
                                    vNLinha := vNLinha + 1;
                                    TabTempFichTexto.NLinha := vNLinha;
                                    TabTempFichTexto.Data := WorkDate;
                                    TabTempFichTexto.Texto1 :=
                                    PadStr('0', 6 - StrLen(Format(ConfRH."Nº Serviço")), '0') + Format(ConfRH."Nº Serviço")           //Nº Serviço
                                    + Format("Hist. Linhas Movs. Empregado"."Data Registo", 0, '<Year4><Month,2>')                  //Data RD
                                    + '2'                                                                                         //Tipo de Registo
                                    + PadStr('0', 7 - StrLen(Format(NCGA)), '0') + Format(NCGA)                                        //Nº Subscritor
                                    + PadStr(Nome, 50, ' ')                                                                          //Nome Subscritor
                                    + PadStr("Hist. Linhas Movs. Empregado"."Cód. Situação", 2, ' ')                                 //Cod Siituação
                                    + PadStr(Format(CodMovimento), 1, ' ')                                                           //Cod Movimento
                                    + Format(varDataEfeito, 0, '<Year4><Month,2><Day,2>')                                            //Data efeito
                                    + DelChr(ConvertStr(Format(ValorRemuneracao, 9, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',') //Valor Remuneração
                                    + DelChr(ConvertStr(Format(DecNumDias, 6, '<Sign><Integer><Decimals,4>'), ' ', '0'), '=', ',')       //Numero Dias 2008.07.1
                                    + DelChr(ConvertStr(Format(HorParcial, 5, '<Sign><Integer><Decimals,2>'), ' ', '0'), '=', ',')       //HorParcial 2008.07.1
                                    + DelChr(ConvertStr(Format(HorCompleto, 5, '<Sign><Integer><Decimals,2>'), ' ', '0'), '=', ',')      //Horcompleto 2008.07.1
                                    + PadStr(Cat, 25, ' ')                                                                           //Categoria2008.07.1
                                    + PadStr(Nivel, 3, ' ')                                                                          //Nivel 2008.07.1
                                    + PadStr("Observações Tipo2", 30, ' ');                                                          //Obs 2008.07.1
                                    TabTempFichTexto."Employee No." := Empregado."No.";
                                    TabTempFichTexto."Cod. Situacao" := "Hist. Linhas Movs. Empregado"."Cód. Situação";
                                    TabTempFichTexto.Valor := ValorRemuneracao;
                                    TabTempFichTexto.NDias := DecNumDias;
                                    TabTempFichTexto.Insert;
                                    TotalRegistos := TotalRegistos + 1;
                                end else begin
                                    ValorRemuneracao := ValorRemuneracao + TabTempFichTexto.Valor;
                                    DecNumDias := DecNumDias + TabTempFichTexto.NDias;
                                    if DecNumDias > 30 then DecNumDias := 30; //IT003 - 2017.02.06 - nao pode passar dos 30
                                    TabTempFichTexto.Texto1 :=
                                    PadStr('0', 6 - StrLen(Format(ConfRH."Nº Serviço")), '0') + Format(ConfRH."Nº Serviço")           //Nº Serviço
                                    + Format("Hist. Linhas Movs. Empregado"."Data Registo", 0, '<Year4><Month,2>')                  //Data RD
                                    + '2'                                                                                         //Tipo de Registo
                                    + PadStr('0', 7 - StrLen(Format(NCGA)), '0') + Format(NCGA)                                        //Nº Subscritor
                                    + PadStr(Nome, 50, ' ')                                                                          //Nome Subscritor
                                    + PadStr("Hist. Linhas Movs. Empregado"."Cód. Situação", 2, ' ')                                 //Cod Siituação
                                    + PadStr(Format(CodMovimento), 1, ' ')                                                           //Cod Movimento
                                    + Format(varDataEfeito, 0, '<Year4><Month,2><Day,2>')                                            //Data efeito
                                    + DelChr(ConvertStr(Format(ValorRemuneracao, 9, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',') //Valor Remuneração
                                    + DelChr(ConvertStr(Format(DecNumDias, 6, '<Sign><Integer><Decimals,4>'), ' ', '0'), '=', ',')       //Numero Dias 2008.07.1
                                    + DelChr(ConvertStr(Format(HorParcial, 5, '<Sign><Integer><Decimals,2>'), ' ', '0'), '=', ',')       //HorParcial 2008.07.1
                                    + DelChr(ConvertStr(Format(HorCompleto, 5, '<Sign><Integer><Decimals,2>'), ' ', '0'), '=', ',')      //Horcompleto 2008.07.1
                                    + PadStr(Cat, 25, ' ')                                                                           //Categoria2008.07.1
                                    + PadStr(Nivel, 3, ' ')                                                                          //Nivel 2008.07.1
                                    + PadStr("Observações Tipo2", 30, ' ');                                                          //Obs 2008.07.1
                                    TabTempFichTexto.Modify;
                                end;
                            end;
                        end;
                    end;
                    // Group Footer OnPostSection
                end;

                trigger OnPreDataItem()
                begin
                    "Hist. Linhas Movs. Empregado".SetRange("Hist. Linhas Movs. Empregado"."Data Registo", DataIni, DataFim);
                end;
            }

            trigger OnAfterGetRecord()
            var
                TabHistAboDesExtra: Record "Histórico Abonos - Desc. Extra";
                TempTabHistAboDesExtra: Record "Histórico Abonos - Desc. Extra" temporary;
                Encontrou: Boolean;
            begin
                //--------------------------------
                //Nome - tirar os: de, da, do, e
                //--------------------------------
                Nome := Empregado.Name;
                if StrPos(Nome, ' de ') <> 0 then
                    Nome := CopyStr(Nome, 1, StrPos(Nome, ' de ') - 1) + CopyStr(Nome, StrPos(Nome, ' de ') + 3);

                if StrPos(Nome, ' do ') <> 0 then
                    Nome := CopyStr(Nome, 1, StrPos(Nome, ' do ') - 1) + CopyStr(Nome, StrPos(Nome, ' do ') + 3);

                if StrPos(Nome, ' da ') <> 0 then
                    Nome := CopyStr(Nome, 1, StrPos(Nome, ' da ') - 1) + CopyStr(Nome, StrPos(Nome, ' da ') + 3);

                if StrPos(Nome, ' e ') <> 0 then
                    Nome := CopyStr(Nome, 1, StrPos(Nome, ' e ') - 1) + CopyStr(Nome, StrPos(Nome, ' e ') + 2);

                Nome := Conv.Ascii2Ascii7bit(Nome);
                NCGA := Empregado."Nº CGA";
                //2008.07.03 - Sempre que houver alteração de vencimento base, ou Cat prof, ou Nº horas lectivas tem de ser criada uma linha 00
                Clear(ValorRemuneracao);
                Clear(Nivel);
                TabHistCabMesActual.Reset;
                TabHistCabMesActual.SetRange(TabHistCabMesActual."Data Registo", DataIni, DataFim);
                TabHistCabMesActual.SetRange(TabHistCabMesActual."Employee No.", Empregado."No.");
                TabHistCabMesActual.SetRange(TabHistCabMesActual."Tipo Processamento", TabHistCabMesActual."Tipo Processamento"::Vencimentos);
                if TabHistCabMesActual.FindFirst then begin
                    TabHistLinhasMesActual.Reset;
                    TabHistLinhasMesActual.SetRange(TabHistLinhasMesActual."Cód. Processamento", TabHistCabMesActual."Cód. Processamento");
                    TabHistLinhasMesActual.SetRange(TabHistLinhasMesActual."Tipo Processamento", TabHistCabMesActual."Tipo Processamento");
                    TabHistLinhasMesActual.SetRange(TabHistLinhasMesActual."Employee No.", TabHistCabMesActual."Employee No.");
                    TabHistLinhasMesActual.SetRange(TabHistLinhasMesActual."Cód. Situação", '01');
                    if TabHistLinhasMesActual.FindFirst then
                        VencimentoMesActual := TabHistLinhasMesActual.Valor;
                    //---------------------
                    //Nome do Empregado
                    //---------------------
                    Nome := TabHistCabMesActual."Designação Empregado";
                    if StrPos(Nome, ' de ') <> 0 then
                        Nome := CopyStr(Nome, 1, StrPos(Nome, ' de ') - 1) + CopyStr(Nome, StrPos(Nome, ' de ') + 3);

                    if StrPos(Nome, ' do ') <> 0 then
                        Nome := CopyStr(Nome, 1, StrPos(Nome, ' do ') - 1) + CopyStr(Nome, StrPos(Nome, ' do ') + 3);

                    if StrPos(Nome, ' da ') <> 0 then
                        Nome := CopyStr(Nome, 1, StrPos(Nome, ' da ') - 1) + CopyStr(Nome, StrPos(Nome, ' da ') + 3);

                    if StrPos(Nome, ' e ') <> 0 then
                        Nome := CopyStr(Nome, 1, StrPos(Nome, ' e ') - 1) + CopyStr(Nome, StrPos(Nome, ' e ') + 2);

                    Nome := Conv.Ascii2Ascii7bit(Nome);
                    //2008.10.23 - O que tem de aparecer no campo da Remuneração é o valor correspondente ao Nivel, independentemente
                    //de ela trabalhar mais ou menos que 22 horas e independentemente do que estiver no Nº Horas Docência Calc. Desct.
                    GrauFuncao.Reset;
                    GrauFuncao.SetRange(GrauFuncao.Código, TabHistCabMesActual."Grau Função");
                    if GrauFuncao.FindFirst then
                        ValorRemuneracao := Round(GrauFuncao."Max Value", 0.01);
                    //---------------------
                    //Horario parcial 2008.07.01
                    //---------------------
                    if Empregado."Regime Duração Trabalho" = Empregado."Regime Duração Trabalho"::"2" then begin
                        HorParcial := Round(TabHistCabMesActual."Nº Horas Semanais Totais", 0.1);
                        HorCompleto := Round(22.0, 0.1);
                    end else begin
                        HorParcial := 0.0;
                        HorCompleto := 0.0;
                    end;
                    //---------------------
                    //Categoria 2008.07.01
                    //---------------------
                    Cat := CopyStr(Conv.Ascii2Ascii7bit(TabHistCabMesActual."Descrição Cat Prof QP"), 1, 25);
                    //---------------------
                    //Nivel 2008.07.01
                    //---------------------
                    Nivel := TabHistCabMesActual."Grau Função";

                    TabHistCabMesAnterior.Reset;
                    TabHistCabMesAnterior.SetRange(TabHistCabMesAnterior."Data Registo", CalcDate('-1M', DataIni), CalcDate('-1D', DataIni));
                    TabHistCabMesAnterior.SetRange(TabHistCabMesAnterior."Employee No.", Empregado."No.");
                    TabHistCabMesAnterior.SetRange(TabHistCabMesAnterior."Tipo Processamento",
                                                TabHistCabMesAnterior."Tipo Processamento"::Vencimentos);
                    if TabHistCabMesAnterior.FindFirst then begin
                        TabHistLinhasMesAnterior.Reset;
                        TabHistLinhasMesAnterior.SetRange(TabHistLinhasMesAnterior."Cód. Processamento", TabHistCabMesAnterior."Cód. Processamento");
                        TabHistLinhasMesAnterior.SetRange(TabHistLinhasMesAnterior."Tipo Processamento", TabHistCabMesAnterior."Tipo Processamento");
                        TabHistLinhasMesAnterior.SetRange(TabHistLinhasMesAnterior."Employee No.", TabHistCabMesAnterior."Employee No.");
                        TabHistLinhasMesAnterior.SetRange(TabHistLinhasMesAnterior."Cód. Situação", '01');
                        if TabHistLinhasMesAnterior.FindFirst then
                            VencimentoMesAnterior := TabHistLinhasMesAnterior.Valor;
                        if VencimentoMesActual <> VencimentoMesAnterior then
                            InserirLinha00
                        else begin
                            if (TabHistCabMesActual."No. Horas Semanais" <> TabHistCabMesAnterior."No. Horas Semanais") and
                              (Empregado."Regime Duração Trabalho" = Empregado."Regime Duração Trabalho"::"2") then begin
                                InserirLinha00;
                            end else begin
                                if (TabHistCabMesActual."Descrição Cat Prof QP" <> TabHistCabMesAnterior."Descrição Cat Prof QP") then begin
                                    TabCatProfQPEmpregado.Reset;
                                    TabCatProfQPEmpregado.SetRange(TabCatProfQPEmpregado."Employee No.", Empregado."No.");
                                    TabCatProfQPEmpregado.SetRange(TabCatProfQPEmpregado.Description,
                                                                  TabHistCabMesActual."Descrição Cat Prof QP");
                                    TabCatProfQPEmpregado.SetFilter(TabCatProfQPEmpregado."Promotion Reason", '<>%1', 0);
                                    if TabCatProfQPEmpregado.FindFirst then
                                        InserirLinha00;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(DataIni; DataIni)
                {

                    Caption = 'Start Date';
                }
                field(DataFim; DataFim)
                {

                    Caption = 'End Date';
                }
                field("Observações Tipo1"; "Observações Tipo1")
                {

                    Caption = 'Observações Tipo 1';
                }
                field("Observações Tipo2"; "Observações Tipo2")
                {

                    Caption = 'Observações Tipo 2';
                }
                field("Observações Tipo3"; "Observações Tipo3")
                {

                    Caption = 'Observações Tipo 3';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        TotalRegistos := TotalRegistos + 1;

        //>>>>>>  LINHA TIPO3 - Registo Totais da RD >>>>>>>>>>>>>>>>>>>>>>>>>>
        TabTempFichTexto.Init;
        TabTempFichTexto."Tipo Ficheiro" := TabTempFichTexto."Tipo Ficheiro"::CGA;
        vNLinha := vNLinha + 1;
        TabTempFichTexto.NLinha := vNLinha;
        TabTempFichTexto.Data := WorkDate;
        TabTempFichTexto.Texto1 :=
          PadStr('0', 6 - StrLen(Format(ConfRH."Nº Serviço")), '0') + Format(ConfRH."Nº Serviço")  //Nº Serviço
        + Format(DataIni, 0, '<Year4><Month,2>')                                                 //Data RD
        + '3'                                                                                  //Tipo de Registo
        + '9999999'
        + PadStr('0', 6 - StrLen(Format(TotalRegistos)), '0') + Format(TotalRegistos)                    //Total de Registos
        + PadStr("Observações Tipo3", 134, ' ');                                                       //Obs
        TabTempFichTexto.Insert;

        //Correr o Dataport para exportar da Tabela Temp Ficheiro Texto para o Ficheiro
        //-------------------------------------------------------------------------------
        Commit;
        TabTempFichTexto.Reset;
        TabTempFichTexto.SetRange(TabTempFichTexto."Tipo Ficheiro", TabTempFichTexto."Tipo Ficheiro"::CGA);
        if TabTempFichTexto.Find('-') then
            XMLPORT.Run(53044, true, false, TabTempFichTexto);
    end;

    trigger OnPreReport()
    var

    begin

        InfEmpresa.Get;
        ConfRH.Get;

        TabTempFichTexto.Reset;
        TabTempFichTexto.SetRange(TabTempFichTexto."Tipo Ficheiro", TabTempFichTexto."Tipo Ficheiro"::CGA);
        if TabTempFichTexto.Find('-') then
            TabTempFichTexto.DeleteAll;

        //--------Obrigatoriedade dos campos-------------------
        ConfRH.TestField(ConfRH."Nº Serviço");
        ConfRH.TestField(ConfRH."Nome Serviço");
        if DataIni = 0D then
            Error(Text53035);
        if DataFim = 0D then
            Error(Text53036);
        //------------------------------------------------------

        //>>>>>>  LINHA TIPO1 - Registo Identificação da RD >>>>>>>>>>>>>>>>>>>>>>>>>>
        TabTempFichTexto.Init;
        TabTempFichTexto."Tipo Ficheiro" := TabTempFichTexto."Tipo Ficheiro"::CGA;
        vNLinha := vNLinha + 1;
        TabTempFichTexto.NLinha := vNLinha;
        TabTempFichTexto.Data := WorkDate;
        TabTempFichTexto.Texto1 :=
          PadStr('0', 6 - StrLen(Format(ConfRH."Nº Serviço")), '0') + Format(ConfRH."Nº Serviço")  //Nº Serviço
        + Format(DataIni, 0, '<Year4><Month,2>')                                                 //Data RD
        + '1'                                                                                  //Tipo de Registo
        + '0000000'
        + PadStr(Conv.Ascii2Ascii7bit(ConfRH."Nome Serviço"), 60, ' ')      //Nome Serviço

        + 'EUR'                                                                             //Unid. Monetária
        + PadStr(InfEmpresa."VAT Registration No.", 9, ' ')                                   //NIF 2008.06.29
        + PadStr(Conv.Ascii2Ascii7bit(InfEmpresa.Name), 66, ' ')            //Razão 2008.07.1
        + PadStr("Observações Tipo1", 2, ' ');                                                //Reservado
        TabTempFichTexto.Insert;
        TotalRegistos := TotalRegistos + 1;
    end;

    var
        TotalFor: Label 'Total de ';
        DataIni: Date;
        DataFim: Date;
        TabTempFichTexto: Record "Tabela Temp Ficheiros Texto";
        InfEmpresa: Record "Company Information";
        ConfRH: Record "Config. Recursos Humanos";
        "Observações Tipo1": Text[77];
        "Observações Tipo2": Text[25];
        "Observações Tipo3": Text[124];
        vNLinha: Integer;
        ValorRemuneracao: Decimal;
        ValorDesconto: Decimal;
        TabCodigosSituacao: Record "Códigos Situação";
        PerdasEfectivas: Decimal;
        NumeroDiuturnidades: Integer;
        Nome: Text[120];
        TotalRegistos: Integer;
        TotalDesconto: Decimal;
        Conv: Codeunit "Funções RH";
        TabRubrica: Record "Payroll Item";
        TabRubricaLinhas: Record "Rubrica Salarial Linhas";
        TabRubricaEmpregado: Record "Rubrica Salarial Empregado";
        TabHistMovEmp: Record "Hist. Linhas Movs. Empregado";
        TabEmpregado: Record Empregado;
        TabDisCC: Record "Distribuição Custos";
        NhorasSem: Decimal;
        TabHistCabMovEmp: Record "Hist. Cab. Movs. Empregado";
        NhorasDocencia: Integer;
        NCGA: Text[30];
        NumDias: Text[30];
        DecNumDias: Decimal;
        HorParcial: Decimal;
        HorCompleto: Decimal;
        Cat: Text[25];
        Nivel: Text[20];
        NhorasSemanaisTotais: Decimal;
        TabCatProfQPEmpregado: Record "Cat. Prof. QP Empregado";
        TabHistCabMesActual: Record "Hist. Cab. Movs. Empregado";
        TabHistCabMesAnterior: Record "Hist. Cab. Movs. Empregado";
        TabHistLinhasMesActual: Record "Hist. Linhas Movs. Empregado";
        TabHistLinhasMesAnterior: Record "Hist. Linhas Movs. Empregado";
        TabHistLinhasMovs: Record "Hist. Linhas Movs. Empregado";
        VencimentoMesActual: Decimal;
        VencimentoMesAnterior: Decimal;
        TabConfUnidadeMedida: Record "Unid. Medida Recursos Humanos";
        GrauFuncao: Record "Grau Função";
        varDataEfeito: Date;
        NumDiasFalta: Decimal;
        CodMovimento: Option " ","9","6","7";
        TabHistAbonDescExtra: Record "Histórico Abonos - Desc. Extra";
        Text0001: Label 'Empregado %1: o Nº CGA não pode ter mais de 7 caracteres.';
        Text53035: Label 'The Initial Date field must be populated.';
        Text53036: Label 'The End Date field must be populated.';


    procedure InserirLinha00()
    begin
        //>>>>>>  LINHA TIPO2 - Registo Movimento da RD >>>>>>>>>>>>>>>>>>>>>>>>>>
        TabTempFichTexto.Init;
        TabTempFichTexto."Tipo Ficheiro" := TabTempFichTexto."Tipo Ficheiro"::CGA;
        vNLinha := vNLinha + 1;
        TabTempFichTexto.NLinha := vNLinha;
        TabTempFichTexto.Data := WorkDate;
        TabTempFichTexto.Texto1 :=
        PadStr('0', 6 - StrLen(Format(ConfRH."Nº Serviço")), '0') + Format(ConfRH."Nº Serviço")                     //Nº Serviço
        + Format(TabHistCabMesActual."Data Registo", 0, '<Year4><Month,2>')                                    //Data RD
        + '2'                                                                                                   //Tipo de Registo
        + PadStr('0', 7 - StrLen(Format(TabHistCabMesActual."Nº CGA")), '0') +
          Format(TabHistCabMesActual."Nº CGA")                                                               //Nº Subscritor
        + PadStr(Nome, 50, ' ')                                                                                //Nome Subscritor
        + '00'                                                                                                //Cod Situação
        + ' '                                                                                                 //Cod Movimento
        + Format(DataIni, 0, '<Year4><Month,2><Day,2>')                                                         //Data efeito
        + DelChr(ConvertStr(Format(ValorRemuneracao, 9, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')        //Valor Remuneração
        + DelChr(ConvertStr(Format(0.0, 6, '<Sign><Integer><Decimals,4>'), ' ', '0'), '=', ',')            //Numero Dias 2008.07.1
        + DelChr(ConvertStr(Format(HorParcial, 5, '<Sign><Integer><Decimals,2>'), ' ', '0'), '=', ',')           //HorParcial 2008.07.1
        + DelChr(ConvertStr(Format(HorCompleto, 5, '<Sign><Integer><Decimals,2>'), ' ', '0'), '=', ',')          //Horcompleto 2008.07.1
        + PadStr(Cat, 25, ' ')                                                          //Categoria2008.07.1
        + PadStr(Nivel, 3, ' ')                                                                                   //Nivel 2008.07.1
        + PadStr("Observações Tipo2", 30, ' ');                                                                   //Obs 2008.07.1
        TabTempFichTexto."Employee No." := Empregado."No.";
        TabTempFichTexto."Cod. Situacao" := '00';
        TabTempFichTexto.Valor := ValorRemuneracao;
        TabTempFichTexto.NDias := 0;
        TabTempFichTexto.Insert;
        TotalRegistos := TotalRegistos + 1;
    end;
}

