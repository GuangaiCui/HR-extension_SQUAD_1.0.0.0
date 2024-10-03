report 53052 "Mapa CGA - Aberto"
{
    // //-------------------------------------------------------
    //               Mapa da CGA
    // //--------------------------------------------------------
    //   É um ficheiro que deve ser entregue mensalmente pela empresa
    //   com os rendimentos e descontos dos empregados à CGA.
    // 
    //   Este mapa deve sair em formato txt e como tal numa primeira fase
    //   exporta os dados para uma tabela criada para este tipo de mapas
    //   (Tabela Temp Ficheiro Texto) e depois corre um dataport (Temp Ficheiro Texto)
    //   para criar o ficheiro txt
    // //-------------------------------------------------------
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\MapaCGAAberto.rdl';

    Permissions = TableData "Tabela Temp Ficheiros Texto" = rimd;
    PreviewMode = PrintLayout;
    ProcessingOnly = false;
    UseRequestPage = true;

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            DataItemTableView = SORTING("Primary Key") ORDER(Ascending);
            column(Name_Cinfo; Name)
            {
            }
            column(Name2_Cinfo; "Name 2")
            {
            }
            column(Address_Cinfo; Address)
            {
            }
            column(Post_Code_Cinfo; "Post Code")
            {
            }
            column(City_Cinfo; City)
            {
            }
            column(Phone_No_Cinfo; "Phone No.")
            {
            }
            column(VATRegistrationNo_Cinfo; "VAT Registration No.")
            {
            }
            column(Date_Formated; Format(Today, 0, 4))
            {
            }
            column(UserID; UserId)
            {
            }
            column(Nome_Servico_ConfRH; ConfRH."Nome Serviço")
            {
            }
            column(Num_Servico_ConfRH; ConfRH."Nº Serviço")
            {
            }
            column(Picture_Cinfo; Picture)
            {
            }
            column(EconomicYear; 'Ano económico de ' + Format(Date2DMY(DataIni, 3)) + ' do Mês de ' + Format(DataIni, 0, '<month text>'))
            {
            }
        }
        dataitem(Empregado; Empregado)
        {
            DataItemTableView = SORTING("No.") WHERE("Subsccritor CGA" = CONST(true));
            dataitem("Linhas Movs. Empregado"; "Linhas Movs. Empregado")
            {
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("No. Empregado", "Data Registo", "Cód. Situação", "Cód. Movimento") WHERE("Tipo Processamento" = FILTER(Vencimentos | SubNatal | SubFerias));

                trigger OnAfterGetRecord()
                var
                    encontrou: Boolean;
                begin
                    //19.03.06 - Em vez de usarmos as rubricas salariais vamos apanhar todos os registos que têm cod. situação preenchido
                    encontrou := false;
                    if "Linhas Movs. Empregado"."Cód. Situação" <> '' then
                        encontrou := true;
                    if not encontrou then
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
                    Clear(DescEmp);
                    Clear(DescEntPat);
                    // Cálcular Descontos Empregado e Empresa
                    if ("Cód. Situação" = '01') and (not FLAG) then begin
                        FLAG := true;
                        recRubricaSalarial.Reset;
                        recRubricaSalarial.SetRange(recRubricaSalarial.Genero, recRubricaSalarial.Genero::CGA);
                        if recRubricaSalarial.FindSet then begin
                            repeat
                                recHistLinMovEmp.Reset;
                                recHistLinMovEmp.SetRange(recHistLinMovEmp."Data Registo", DataIni, DataFim);
                                recHistLinMovEmp.SetRange("Cód. Rubrica", recRubricaSalarial.Código);
                                recHistLinMovEmp.SetRange(recHistLinMovEmp."No. Empregado", "Linhas Movs. Empregado"."No. Empregado");
                                if recHistLinMovEmp.FindSet then begin
                                    repeat   //2017.12.18-Correcção aos descontos CGA quando se tira o mapa para mais que 1 proc.
                                        DescEmp := DescEmp + recHistLinMovEmp.Valor;
                                    until recHistLinMovEmp.Next = 0;
                                end;
                            until recRubricaSalarial.Next = 0;
                        end;
                        recRubricaSalarial.Reset;
                        recRubricaSalarial.SetRange(recRubricaSalarial.Genero, recRubricaSalarial.Genero::"Enc. CGA");
                        if recRubricaSalarial.FindSet then begin
                            repeat
                                recHistLinMovEmp.Reset;
                                recHistLinMovEmp.SetRange(recHistLinMovEmp."Data Registo", DataIni, DataFim);
                                recHistLinMovEmp.SetRange("Cód. Rubrica", recRubricaSalarial.Código);
                                recHistLinMovEmp.SetRange(recHistLinMovEmp."No. Empregado", "Linhas Movs. Empregado"."No. Empregado");
                                if recHistLinMovEmp.FindSet then begin
                                    repeat    //2017.12.18-Correcção aos descontos CGA quando se tira o mapa para mais que 1 proc.
                                        DescEntPat := DescEntPat + recHistLinMovEmp.Valor;
                                    until recHistLinMovEmp.Next = 0;
                                end;
                            until recRubricaSalarial.Next = 0;
                        end;
                    end;

                    if ("Linhas Movs. Empregado".Valor <> 0) or
                        (("Linhas Movs. Empregado".Valor = 0) and ("Linhas Movs. Empregado"."Cód. Situação" = '50')) then begin
                        //2008.10.10 licenças sem vencimento tem de aparecer a zero
                        //---------------------
                        //Valor da remuneração
                        //---------------------
                        ValorRemuneracao := Round("Linhas Movs. Empregado".Valor, 0.01);
                        //2008.05.04 - agora vai buscar o Nº Horas semanais ao Hist.
                        TabHistCabMovEmp.Reset;
                        TabHistCabMovEmp.SetRange(TabHistCabMovEmp."Cód. Processamento", "Linhas Movs. Empregado"."Cód. Processamento");
                        TabHistCabMovEmp.SetRange(TabHistCabMovEmp."Tipo Processamento", "Linhas Movs. Empregado"."Tipo Processamento");
                        TabHistCabMovEmp.SetRange(TabHistCabMovEmp."No. Empregado", "Linhas Movs. Empregado"."No. Empregado");
                        if TabHistCabMovEmp.FindFirst then begin
                            NhorasSem := TabHistCabMovEmp."No. Horas Semanais";
                            NhorasSemanaisTotais := TabHistCabMovEmp."Nº Horas Semanais Totais";
                            NhorasDocencia := TabHistCabMovEmp."Nº Horas Docência Calc. Desct.";
                            NCGA := TabHistCabMovEmp."Nº CGA";
                            if StrLen(Format(NCGA)) > 7 then Error(Text0001, TabHistCabMovEmp."No. Empregado");
                            Nivel := TabHistCabMovEmp."Grau Função";
                        end;
                        //19.03.07 - Se for cod. situação 01 tem de subtrair o valor das faltas ou seja
                        //todas os codigos de situação do tipo perdas efectivas
                        if "Linhas Movs. Empregado"."Cód. Situação" = '01' then begin
                            TabCodigosSituacao.Reset;
                            TabCodigosSituacao.SetRange(TabCodigosSituacao."Perdas Efectivas", true);
                            if TabCodigosSituacao.FindSet then begin
                                repeat
                                    TabHistMovEmp.Reset;
                                    TabHistMovEmp.SetRange(TabHistMovEmp."Data Registo", DataIni, DataFim);
                                    TabHistMovEmp.SetRange(TabHistMovEmp."No. Empregado", Empregado."No.");
                                    TabHistMovEmp.SetRange(TabHistMovEmp."Tipo Processamento", TabHistMovEmp."Tipo Processamento"::Vencimentos);
                                    TabHistMovEmp.SetRange(TabHistMovEmp."Cód. Situação", TabCodigosSituacao."Cód. Situação");
                                    if TabHistMovEmp.FindSet then begin
                                        repeat
                                            ValorRemuneracao := ValorRemuneracao - Abs(TabHistMovEmp.Valor);
                                        until TabHistMovEmp.Next = 0;
                                    end;
                                until TabCodigosSituacao.Next = 0;
                            end;
                            ValorRemuneracao := Round(ValorRemuneracao, 0.01);
                        end;
                        //19.03.07 - fim
                        //27.04.07 e 30.04.07 - Ter em conta o nº horas de docencia e não o nº de horas semanais
                        if Empregado."Nº Horas Docência Calc. Desct." <> 0 then begin
                            //13.08.2008 - quando é horário parcial as contas são feitas pelos dias esperados
                            if Empregado."Regime Duração Trabalho" = Empregado."Regime Duração Trabalho"::"1" then begin
                                //2008.10.23 - se a pessoa ganha acima da tabela e tem 22 ou menos então tem de se fazer
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
                                    //ValorRemuneracao  := (NhorasSemanaisTotais * 30 /22) * GrauFuncao."Valor Max" /30;
                                    //2008.10.23 - tem de ser os horaslectivas
                                    ValorRemuneracao := Round((NhorasSem * 30 / 22), 0.001) * GrauFuncao."Max Value" / 30;
                                    ValorRemuneracao := Round(ValorRemuneracao, 0.01);
                                end;
                            end;
                        end;
                        //---------------------
                        //Ir buscar a Tabela Hist 2008.07.01
                        //---------------------
                        TabHistCabMovEmp.Reset;
                        TabHistCabMovEmp.SetRange(TabHistCabMovEmp."Cód. Processamento", "Linhas Movs. Empregado"."Cód. Processamento");
                        TabHistCabMovEmp.SetRange(TabHistCabMovEmp."Tipo Processamento", "Linhas Movs. Empregado"."Tipo Processamento");
                        TabHistCabMovEmp.SetRange(TabHistCabMovEmp."No. Empregado", "Linhas Movs. Empregado"."No. Empregado");
                        if TabHistCabMovEmp.FindFirst then begin
                            NhorasSemanaisTotais := TabHistCabMovEmp."Nº Horas Semanais Totais";
                            Nivel := TabHistCabMovEmp."Grau Função";
                        end;
                        //---------------------
                        //Numero de Dias 2008.07.01
                        //---------------------
                        DecNumDias := 0;
                        if "Linhas Movs. Empregado"."Cód. Situação" = '01' then begin
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
                                        TabHistMovEmp.SetRange(TabHistMovEmp."No. Empregado", Empregado."No.");
                                        TabHistMovEmp.SetRange(TabHistMovEmp."Tipo Processamento", TabHistMovEmp."Tipo Processamento"::Vencimentos);
                                        TabHistMovEmp.SetRange(TabHistMovEmp."Cód. Situação", TabCodigosSituacao."Cód. Situação");
                                        if TabHistMovEmp.FindSet then begin
                                            repeat
                                                DecNumDias := DecNumDias - Abs(TabHistMovEmp.Quantidade);
                                            until TabHistMovEmp.Next = 0;
                                        end;
                                    until TabCodigosSituacao.Next = 0;
                                end;
                            end;
                            if Empregado."Regime Duração Trabalho" = Empregado."Regime Duração Trabalho"::"2" then
                                //DecNumDias := ROUND(30 * NhorasSemanaisTotais / 22,0.001); //22 será o horário completo para os parciais
                                //2008.10.23 - no caso dos parciais temos de ir ler às horas lectivas, porque as totais podem passam das 22
                                DecNumDias := Round(30 * NhorasSem / 22, 0.001, '<'); //22 será o horário completo para os parciais
                        end;
                        if ("Linhas Movs. Empregado"."Cód. Situação" = '49') or
                            ("Linhas Movs. Empregado"."Cód. Situação" = '56') or
                            ("Linhas Movs. Empregado"."Cód. Situação" = '58') then begin
                            //ver se a falta está em dias ou horas
                            TabConfUnidadeMedida.Reset;
                            if TabConfUnidadeMedida.Get("Linhas Movs. Empregado".UnidadeMedida) then begin
                                if TabConfUnidadeMedida."Designação Interna" = TabConfUnidadeMedida."Designação Interna"::Dia then begin
                                    if Empregado."Regime Duração Trabalho" = Empregado."Regime Duração Trabalho"::"1" then
                                        DecNumDias := Abs("Linhas Movs. Empregado".Quantidade);
                                    if Empregado."Regime Duração Trabalho" = Empregado."Regime Duração Trabalho"::"2" then
                                        DecNumDias := Round(30 *
                                        (NhorasSemanaisTotais / Empregado."No. dias de Trabalho Semanal" * Abs("Linhas Movs. Empregado".Quantidade))
                                          / 88, 0.001, '<');
                                end;
                                if TabConfUnidadeMedida."Designação Interna" = TabConfUnidadeMedida."Designação Interna"::Hora then begin
                                    if Empregado."Regime Duração Trabalho" = Empregado."Regime Duração Trabalho"::"1" then
                                        DecNumDias := Abs("Linhas Movs. Empregado".Quantidade);
                                    if Empregado."Regime Duração Trabalho" = Empregado."Regime Duração Trabalho"::"2" then
                                        DecNumDias := Round(30 * Abs("Linhas Movs. Empregado".Quantidade) / 88, 0.001, '<'); //
                                end;
                            end;
                        end;
                        //---------------------
                        //Horario parcial 2008.07.01
                        //---------------------
                        if ("Linhas Movs. Empregado"."Cód. Situação" = '00') then begin
                            if Empregado."Regime Duração Trabalho" = Empregado."Regime Duração Trabalho"::"2" then begin
                                HorParcial := Round(NhorasSemanaisTotais, 0.1);
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
                        if ("Linhas Movs. Empregado"."Cód. Situação" = '00') then begin
                            TabCatProfQPEmpregado.Reset;
                            TabCatProfQPEmpregado.SetRange(TabCatProfQPEmpregado."No. Empregado", Empregado."No.");
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
                        if ("Linhas Movs. Empregado"."Cód. Situação" = '00') then
                            Nivel := Nivel
                        else
                            Nivel := '';
                        //---------------------
                        //Valor do desconto
                        //---------------------
                        //07-02-2008 - Para nao contar com os professores de acumuação
                        if TabEmpregado.Get("Linhas Movs. Empregado"."No. Empregado") and not TabEmpregado."Professor Acumulação" then
                            ValorDesconto := Round(ValorRemuneracao * ConfRH."Taxa Contributiva Empregado" / 100, 0.01);
                        //---------------------
                        //Perdas Efectivas
                        //---------------------
                        TabCodigosSituacao.Reset;
                        TabCodigosSituacao.SetRange(TabCodigosSituacao."Cód. Situação", "Linhas Movs. Empregado"."Cód. Situação");
                        if TabCodigosSituacao.FindFirst then begin
                            if TabCodigosSituacao."Perdas Efectivas" = false then
                                PerdasEfectivas := 0
                            else begin
                                //19.03.07 - correcção das faltas
                                ValorDesconto := 0;
                                ValorRemuneracao := 0;
                                PerdasEfectivas := Abs("Linhas Movs. Empregado".Quantidade);
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
                        TabCodigosSituacao.SetRange(TabCodigosSituacao."Cód. Situação", "Linhas Movs. Empregado"."Cód. Situação");
                        if TabCodigosSituacao.FindFirst then begin
                            if not TabCodigosSituacao.Diuturnidades then
                                NumeroDiuturnidades := 0
                            else
                                NumeroDiuturnidades := "Linhas Movs. Empregado".Quantidade;
                        end;
                        //---------------------
                        //Nome Empregado
                        //---------------------
                        Nome := "Linhas Movs. Empregado"."Designação Empregado";
                        if StrPos(Nome, ' de ') <> 0 then
                            Nome := CopyStr(Nome, 1, StrPos(Nome, ' de ') - 1) + CopyStr(Nome, StrPos(Nome, ' de ') + 3);

                        if StrPos(Nome, ' do ') <> 0 then
                            Nome := CopyStr(Nome, 1, StrPos(Nome, ' do ') - 1) + CopyStr(Nome, StrPos(Nome, ' do ') + 3);

                        if StrPos(Nome, ' da ') <> 0 then
                            Nome := CopyStr(Nome, 1, StrPos(Nome, ' da ') - 1) + CopyStr(Nome, StrPos(Nome, ' da ') + 3);

                        if StrPos(Nome, ' e ') <> 0 then
                            Nome := CopyStr(Nome, 1, StrPos(Nome, ' e ') - 1) + CopyStr(Nome, StrPos(Nome, ' e ') + 2);

                        Nome := Nome;
                        //--------Obrigatoriedade dos campos-------------------
                        ConfRH.TestField(ConfRH."Nº Serviço");
                        if DataIni = 0D then
                            Error(Text53035);
                        if DataFim = 0D then
                            Error(Text53036);
                        "Linhas Movs. Empregado".TestField("Linhas Movs. Empregado"."Cód. Situação");
                        ConfRH.TestField(ConfRH."Nome Serviço");
                        //------------------------------------------------------
                        //Cod. Movimento
                        //---------------------
                        CodMovimento := "Linhas Movs. Empregado"."Cód. Movimento";
                        //2008.10.23 - Se o Cod. Situação for um código de Saída a Data efeito deve ser Fim do mês
                        //----------------- Se o Cod. Situação não for um código de Saída a Data efeito deve ser Inicio do mês
                        if ("Linhas Movs. Empregado"."Cód. Situação" = '43') or
                           ("Linhas Movs. Empregado"."Cód. Situação" = '45') or
                           ("Linhas Movs. Empregado"."Cód. Situação" = '47') or
                           ("Linhas Movs. Empregado"."Cód. Situação" = '48') then
                            varDataEfeito := DataFim
                        else
                            varDataEfeito := DataIni;

                        //2008.11.26 - Se o cod. movimento for 9 a dataefeito é o dia 1 do mês a que se refere a falta
                        //se o cod. mov for 6 ou 7, então a dataefeito é o que o utilizadpr escrever no campo ""Data a que se refere mov"
                        if "Linhas Movs. Empregado"."Cód. Movimento" > 0 then begin
                            TabHistAbonDescExtra.Reset;
                            TabHistAbonDescExtra.SetRange(TabHistAbonDescExtra.Data, DataIni, DataFim);
                            TabHistAbonDescExtra.SetRange(TabHistAbonDescExtra."Cód. Rubrica", "Linhas Movs. Empregado"."Cód. Rubrica");
                            TabHistAbonDescExtra.SetRange(TabHistAbonDescExtra."No. Empregado", Empregado."No.");//2008.12.11
                            if TabHistAbonDescExtra.FindSet then begin
                                repeat
                                    if ("Linhas Movs. Empregado"."Cód. Situação" = '49') or
                                       ("Linhas Movs. Empregado"."Cód. Situação" = '56') or
                                       ("Linhas Movs. Empregado"."Cód. Situação" = '58') then
                                        DecNumDias := TabHistAbonDescExtra.Quantidade
                                    else
                                        DecNumDias := 0.0;

                                    if "Linhas Movs. Empregado"."Cód. Movimento" <> 1 then
                                        ValorRemuneracao := TabHistAbonDescExtra."Valor Total"
                                    else
                                        ValorRemuneracao := 0;

                                    if "Linhas Movs. Empregado"."Cód. Movimento" = 1 then
                                        varDataEfeito := DMY2Date(1, Date2DMY(TabHistAbonDescExtra."Data a que se refere o Mov.", 2),
                                                          Date2DMY(TabHistAbonDescExtra."Data a que se refere o Mov.", 3))
                                    else
                                        varDataEfeito := TabHistAbonDescExtra."Data a que se refere o Mov.";

                                    //>>>>>>  LINHA TIPO2 - Registo Movimento da RD >>>>>>>>>>>>>>>>>>>>>>>>>>
                                    TabTempFichTexto.Init;
                                    TabTempFichTexto."Tipo Ficheiro" := TabTempFichTexto."Tipo Ficheiro"::CGA;
                                    vNLinha := vNLinha + 1;
                                    TabTempFichTexto.NLinha := vNLinha;
                                    TabTempFichTexto.Data := WorkDate;
                                    TabTempFichTexto.Texto1 :=
                                    PadStr('0', 6 - StrLen(Format(ConfRH."Nº Serviço")), '0') + Format(ConfRH."Nº Serviço")           //Nº Serviço
                                    + Format("Linhas Movs. Empregado"."Data Registo", 0, '<Year4><Month,2>')                  //Data RD
                                    + '2'                                                                                         //Tipo de Registo
                                    + PadStr('0', 7 - StrLen(Format(NCGA)), '0') + Format(NCGA)                                        //Nº Subscritor
                                    + PadStr(Nome, 50, ' ')                                                                          //Nome Subscritor
                                    + PadStr("Linhas Movs. Empregado"."Cód. Situação", 2, ' ')                                 //Cod Siituação
                                    + PadStr(Format(CodMovimento), 1, ' ')                                                           //Cod Movimento
                                    + Format(varDataEfeito, 0, '<Year4><Month,2><Day,2>')                                            //Data efeito
                                    + DelChr(ConvertStr(Format(ValorRemuneracao, 9, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',') //Valor Remuneração
                                    + DelChr(ConvertStr(Format(DecNumDias, 6, '<Sign><Integer><Decimals,4>'), ' ', '0'), '=', ',')       //Numero Dias 2008.07.1
                                    + DelChr(ConvertStr(Format(HorParcial, 5, '<Sign><Integer><Decimals,2>'), ' ', '0'), '=', ',')       //HorParcial 2008.07.1
                                    + DelChr(ConvertStr(Format(HorCompleto, 5, '<Sign><Integer><Decimals,2>'), ' ', '0'), '=', ',')      //Horcompleto 2008.07.1
                                    + PadStr(Cat, 25, ' ')                                                                           //Categoria2008.07.1
                                    + PadStr(Nivel, 3, ' ')                                                                          //Nivel 2008.07.1
                                    + PadStr("Observações Tipo2", 30, ' ');                                                          //Obs 2008.07.1
                                    TabTempFichTexto."No. Empregado" := Empregado."No.";
                                    TabTempFichTexto."Cod. Situacao" := "Linhas Movs. Empregado"."Cód. Situação";
                                    TabTempFichTexto.Valor := ValorRemuneracao;
                                    TabTempFichTexto.NDias := DecNumDias;
                                    TabTempFichTexto.Texto2 := Format(DescEmp) + ' ' + Format(DescEntPat);
                                    TabTempFichTexto.Insert;
                                    TotalRegistos := TotalRegistos + 1;
                                until TabHistAbonDescExtra.Next = 0;
                            end;
                        end else begin
                            //>>>>>>  LINHA TIPO2 - Registo Movimento da RD >>>>>>>>>>>>>>>>>>>>>>>>>>
                            //2007.04.03 - Criei este IF pq Se faltou o mês todo (ValorRemuneracao =0) não deve aparecer a linha 01
                            if (ValorRemuneracao <> 0) or ("Linhas Movs. Empregado"."Cód. Situação" <> '01') then begin
                                TabTempFichTexto.Reset;
                                TabTempFichTexto.SetRange(TabTempFichTexto."Tipo Ficheiro", TabTempFichTexto."Tipo Ficheiro"::CGA);
                                TabTempFichTexto.SetRange(TabTempFichTexto."No. Empregado", Empregado."No.");
                                TabTempFichTexto.SetRange(TabTempFichTexto."Cod. Situacao", "Linhas Movs. Empregado"."Cód. Situação");
                                if not TabTempFichTexto.FindFirst then begin
                                    TabTempFichTexto.Init;
                                    TabTempFichTexto."Tipo Ficheiro" := TabTempFichTexto."Tipo Ficheiro"::CGA;
                                    vNLinha := vNLinha + 1;
                                    TabTempFichTexto.NLinha := vNLinha;
                                    TabTempFichTexto.Data := WorkDate;
                                    TabTempFichTexto.Texto1 :=
                                    PadStr('0', 6 - StrLen(Format(ConfRH."Nº Serviço")), '0') + Format(ConfRH."Nº Serviço")           //Nº Serviço
                                    + Format("Linhas Movs. Empregado"."Data Registo", 0, '<Year4><Month,2>')                  //Data RD
                                    + '2'                                                                                         //Tipo de Registo
                                    + PadStr('0', 7 - StrLen(Format(NCGA)), '0') + Format(NCGA)                                        //Nº Subscritor
                                    + PadStr(Nome, 50, ' ')                                                                          //Nome Subscritor
                                    + PadStr("Linhas Movs. Empregado"."Cód. Situação", 2, ' ')                                 //Cod Siituação
                                    + PadStr(Format(CodMovimento), 1, ' ')                                                           //Cod Movimento
                                    + Format(varDataEfeito, 0, '<Year4><Month,2><Day,2>')                                            //Data efeito
                                    + DelChr(ConvertStr(Format(ValorRemuneracao, 9, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',') //Valor Remuneração
                                    + DelChr(ConvertStr(Format(DecNumDias, 6, '<Sign><Integer><Decimals,4>'), ' ', '0'), '=', ',')       //Numero Dias 2008.07.1
                                    + DelChr(ConvertStr(Format(HorParcial, 5, '<Sign><Integer><Decimals,2>'), ' ', '0'), '=', ',')       //HorParcial 2008.07.1
                                    + DelChr(ConvertStr(Format(HorCompleto, 5, '<Sign><Integer><Decimals,2>'), ' ', '0'), '=', ',')      //Horcompleto 2008.07.1
                                    + PadStr(Cat, 25, ' ')                                                                           //Categoria2008.07.1
                                    + PadStr(Nivel, 3, ' ')                                                                          //Nivel 2008.07.1
                                    + PadStr("Observações Tipo2", 30, ' ');                                                          //Obs 2008.07.1
                                    TabTempFichTexto."No. Empregado" := Empregado."No.";
                                    TabTempFichTexto."Cod. Situacao" := "Linhas Movs. Empregado"."Cód. Situação";
                                    TabTempFichTexto.Valor := ValorRemuneracao;
                                    TabTempFichTexto.NDias := DecNumDias;
                                    TabTempFichTexto.Texto2 := Format(DescEmp) + ' ' + Format(DescEntPat);
                                    TabTempFichTexto.Insert;
                                    TotalRegistos := TotalRegistos + 1;
                                end else begin
                                    ValorRemuneracao := ValorRemuneracao + TabTempFichTexto.Valor;
                                    DecNumDias := DecNumDias + TabTempFichTexto.NDias;
                                    if DecNumDias > 30 then DecNumDias := 30; //IT003 - 2017.02.06 - nao pode passar dos 30
                                    TabTempFichTexto.Texto1 :=
                                    PadStr('0', 6 - StrLen(Format(ConfRH."Nº Serviço")), '0') + Format(ConfRH."Nº Serviço")           //Nº Serviço
                                    + Format("Linhas Movs. Empregado"."Data Registo", 0, '<Year4><Month,2>')                  //Data RD
                                    + '2'                                                                                         //Tipo de Registo
                                    + PadStr('0', 7 - StrLen(Format(NCGA)), '0') + Format(NCGA)                                        //Nº Subscritor
                                    + PadStr(Nome, 50, ' ')                                                                          //Nome Subscritor
                                    + PadStr("Linhas Movs. Empregado"."Cód. Situação", 2, ' ')                                 //Cod Siituação
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
                    //Filtro de Data
                    "Linhas Movs. Empregado".SetRange("Linhas Movs. Empregado"."Data Registo", DataIni, DataFim);
                end;
            }

            trigger OnAfterGetRecord()
            var
                TabHistAboDesExtra: Record "Abonos - Descontos Extra";
                TempTabHistAboDesExtra: Record "Abonos - Descontos Extra" temporary;
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

                Nome := Nome;
                NCGA := Empregado."Nº CGA";

                //2008.07.03 - Sempre que houver alteração de vencimento base, ou Cat prof, ou Nº horas lectivas tem de ser criada uma linha 00

                Clear(ValorRemuneracao);
                Clear(Nivel);

                TabHistCabMesActual.Reset;
                TabHistCabMesActual.SetRange(TabHistCabMesActual."Data Registo", DataIni, DataFim);
                TabHistCabMesActual.SetRange(TabHistCabMesActual."No. Empregado", Empregado."No.");
                TabHistCabMesActual.SetRange(TabHistCabMesActual."Tipo Processamento", TabHistCabMesActual."Tipo Processamento"::Vencimentos);
                if TabHistCabMesActual.FindFirst then begin
                    TabHistLinhasMesActual.Reset;
                    TabHistLinhasMesActual.SetRange(TabHistLinhasMesActual."Cód. Processamento", TabHistCabMesActual."Cód. Processamento");
                    TabHistLinhasMesActual.SetRange(TabHistLinhasMesActual."Tipo Processamento", TabHistCabMesActual."Tipo Processamento");
                    TabHistLinhasMesActual.SetRange(TabHistLinhasMesActual."No. Empregado", TabHistCabMesActual."No. Empregado");
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

                    Nome := Nome;
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
                    Cat := CopyStr(TabHistCabMesActual."Descrição Cat Prof QP", 1, 25);
                    //---------------------
                    //Nivel 2008.07.01
                    //---------------------
                    Nivel := TabHistCabMesActual."Grau Função";
                    TabHistCabMesAnterior.Reset;
                    TabHistCabMesAnterior.SetRange(TabHistCabMesAnterior."Data Registo", CalcDate('-1M', DataIni), CalcDate('-1D', DataIni));
                    TabHistCabMesAnterior.SetRange(TabHistCabMesAnterior."No. Empregado", Empregado."No.");
                    TabHistCabMesAnterior.SetRange(TabHistCabMesAnterior."Tipo Processamento", TabHistCabMesAnterior."Tipo Processamento"::Vencimentos);
                    if TabHistCabMesAnterior.FindFirst then begin
                        TabHistLinhasMesAnterior.Reset;
                        TabHistLinhasMesAnterior.SetRange(TabHistLinhasMesAnterior."Cód. Processamento", TabHistCabMesAnterior."Cód. Processamento");
                        TabHistLinhasMesAnterior.SetRange(TabHistLinhasMesAnterior."Tipo Processamento", TabHistCabMesAnterior."Tipo Processamento");
                        TabHistLinhasMesAnterior.SetRange(TabHistLinhasMesAnterior."No. Empregado", TabHistCabMesAnterior."No. Empregado");
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
                                    TabCatProfQPEmpregado.SetRange(TabCatProfQPEmpregado."No. Empregado", Empregado."No.");
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
                FLAG := false;
            end;
        }
        dataitem("Tabela Temp Ficheiros Texto"; "Tabela Temp Ficheiros Texto")
        {
            DataItemTableView = SORTING("Tipo Ficheiro", NLinha);
            column(NCGA; CopyStr("Tabela Temp Ficheiros Texto".Texto1, 14, 7))
            {
            }
            column(Nome; CopyStr("Tabela Temp Ficheiros Texto".Texto1, 21, 50))
            {
            }
            column(CodSit; CopyStr("Tabela Temp Ficheiros Texto".Texto1, 71, 2))
            {
            }
            column(CodMov; CopyStr("Tabela Temp Ficheiros Texto".Texto1, 73, 1))
            {
            }
            column(DataEfeito; CopyStr("Tabela Temp Ficheiros Texto".Texto1, 74, 8))
            {
            }
            column(Remuner; remuneracao)
            {
            }
            column(NDias; DecNumDias)
            {
            }
            column(HorParcial; HorParcial)
            {
            }
            column(HorComp; HorCompleto)
            {
            }
            column(Categoria; CopyStr("Tabela Temp Ficheiros Texto".Texto1, 103, 25))
            {
            }
            column(Nivel; CopyStr("Tabela Temp Ficheiros Texto".Texto1, 128, 3))
            {
            }
            column(NLinha; NLinha)
            {
            }
            column(DescEmp; DescEmp)
            {
            }
            column(DescEntPat; DescEntPat)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Dias dividir por 1000
                if Evaluate(DecNumDias, CopyStr("Tabela Temp Ficheiros Texto".Texto1, 90, 5)) then
                    DecNumDias := DecNumDias / 1000;
                //Horas dividir por 10
                if Evaluate(HorParcial, CopyStr("Tabela Temp Ficheiros Texto".Texto1, 95, 4)) then
                    HorParcial := HorParcial / 10;
                if Evaluate(HorCompleto, CopyStr("Tabela Temp Ficheiros Texto".Texto1, 99, 4)) then
                    HorCompleto := HorCompleto / 10;
                //remuneração dividir por 100
                if Evaluate(remuneracao, CopyStr("Tabela Temp Ficheiros Texto".Texto1, 82, 8)) then
                    remuneracao := remuneracao / 100;


                Clear(DescEmp);
                Clear(DescEntPat);

                if Evaluate(DescEmp, CopyStr(Texto2, 1, StrPos(Texto2, ' '))) then
                    if DescEmp < 0 then
                        DescEmp := DescEmp * -1;
                if Evaluate(DescEntPat, CopyStr(Texto2, StrPos(Texto2, ' ') + 1)) then
                    if DescEntPat < 0 then
                        DescEntPat := DescEntPat * -1;
            end;

            trigger OnPreDataItem()
            begin
                "Tabela Temp Ficheiros Texto".SetRange("Tabela Temp Ficheiros Texto"."Tipo Ficheiro", "Tabela Temp Ficheiros Texto"."Tipo Ficheiro"::CGA);
                "Tabela Temp Ficheiros Texto".SetFilter("Tabela Temp Ficheiros Texto".NLinha, '<>%1', 1);
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
        PageLbl = 'Page';
        MapName = 'Mapa da Caixa Geral de Aposentações';
        ServiceLbl = 'Service';
        CodeLbl = 'Code';
        CGANoLbl = 'CGA No.';
        NameLbl = 'Name';
        SitCodeLbl = 'Sit. Code';
        MoveCodeLbl = 'Mov. Code';
        EfectDateLbl = 'Efect Date';
        DaysNoLbl = 'Days No.';
        ParcialHrLbl = 'Parcial Hor.';
        CompHrLbl = 'Comp. Hor.';
        CategoryLbl = 'Category';
        LevelLbl = 'Level';
        TotaisDescontoLbl = 'Discount Total';
        EmpLbl = 'Emp.';
        EmployerLbl = 'Employer';
        ProcByPCLbl = 'Processed by Computer';
        RemunLbl = 'Remuner.';
        PhoneLbl = 'Phone No.';
        VatRegNoLbl = 'Vat Registration No.';
        TotalLbl = 'Total:';
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
    end;

    trigger OnPreReport()

    begin
        InfEmpresa.Get;
        ConfRH.Get;

        TabTempFichTexto.Reset;
        TabTempFichTexto.SetRange(TabTempFichTexto."Tipo Ficheiro", TabTempFichTexto."Tipo Ficheiro"::CGA);
        if TabTempFichTexto.FindFirst then
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
        + PadStr(ConfRH."Nome Serviço", 60, ' ')      //Nome Serviço
        + 'EUR'                                                                             //Unid. Monetária
        + PadStr(InfEmpresa."VAT Registration No.", 9, ' ')                                   //NIF 2008.06.29
        + PadStr(InfEmpresa.Name, 66, ' ')            //Razão 2008.07.1
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
        vNLinha: Integer;
        "Observações Tipo1": Text[77];
        "Observações Tipo2": Text[25];
        "Observações Tipo3": Text[124];
        ValorRemuneracao: Decimal;
        ValorDesconto: Decimal;
        TabCodigosSituacao: Record "Códigos Situação";
        PerdasEfectivas: Decimal;
        NumeroDiuturnidades: Integer;
        Nome: Text[120];
        TotalRegistos: Integer;
        TotalDesconto: Decimal;
        Conv: Codeunit "Funções RH";
        TabRubrica: Record "Rubrica Salarial";
        TabRubricaLinhas: Record "Rubrica Salarial Linhas";
        TabRubricaEmpregado: Record "Rubrica Salarial Empregado";
        TabHistMovEmp: Record "Linhas Movs. Empregado";
        TabEmpregado: Record Empregado;
        TabDisCC: Record "Distribuição Custos";
        NhorasSem: Decimal;
        TabHistCabMovEmp: Record "Cab. Movs. Empregado";
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
        TabHistCabMesActual: Record "Cab. Movs. Empregado";
        TabHistCabMesAnterior: Record "Cab. Movs. Empregado";
        TabHistLinhasMesActual: Record "Linhas Movs. Empregado";
        TabHistLinhasMesAnterior: Record "Linhas Movs. Empregado";
        TabHistLinhasMovs: Record "Linhas Movs. Empregado";
        VencimentoMesActual: Decimal;
        VencimentoMesAnterior: Decimal;
        TabConfUnidadeMedida: Record "Unid. Medida Recursos Humanos";
        GrauFuncao: Record "Grau Função";
        varDataEfeito: Date;
        NumDiasFalta: Decimal;
        CodMovimento: Option " ","9","6","7";
        TabHistAbonDescExtra: Record "Abonos - Descontos Extra";
        Text0001: Label 'Empregado %1: o Nº CGA não pode ter mais de 7 caracteres.';
        remuneracao: Decimal;
        recRubricaSalarial: Record "Rubrica Salarial";
        recHistLinMovEmp: Record "Linhas Movs. Empregado";
        DescEmp: Decimal;
        DescEntPat: Decimal;
        FLAG: Boolean;
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
        //2008.10.23 - tem de ser data de inicio
        + Format(DataIni, 0, '<Year4><Month,2><Day,2>')                                                         //Data efeito
        + DelChr(ConvertStr(Format(ValorRemuneracao, 9, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')        //Valor Remuneração
        + DelChr(ConvertStr(Format(0.0, 6, '<Sign><Integer><Decimals,4>'), ' ', '0'), '=', ',')
        //Numero Dias 2008.07.1
        + DelChr(ConvertStr(Format(HorParcial, 5, '<Sign><Integer><Decimals,2>'), ' ', '0'), '=', ',')           //HorParcial 2008.07.1
        + DelChr(ConvertStr(Format(HorCompleto, 5, '<Sign><Integer><Decimals,2>'), ' ', '0'), '=', ',')          //Horcompleto 2008.07.1
        + PadStr(Cat, 25, ' ')
        //Categoria2008.07.1
        + PadStr(Nivel, 3, ' ')                                                                                   //Nivel 2008.07.1
        + PadStr("Observações Tipo2", 30, ' ');                                                                   //Obs 2008.07.1
        TabTempFichTexto.Insert;
        TotalRegistos := TotalRegistos + 1;
    end;
}

