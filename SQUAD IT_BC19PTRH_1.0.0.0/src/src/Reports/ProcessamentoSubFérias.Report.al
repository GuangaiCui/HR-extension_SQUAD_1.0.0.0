report 53041 "Processamento Sub. Férias"
{
    // //-------------------------------------------------------
    //               Processamento Sub. Férias
    // //--------------------------------------------------------
    //   Este é o report responsável pelo processamento do Sub. Férias
    //   quando este é feito à parte do Processamento mensal do ordenado.
    //   Está disponível a partir do Processamento Anual.
    // //-------------------------------------------------------

    UsageCategory = Tasks;
    ApplicationArea = HumanResourcesAppArea;
    Permissions = TableData "Histórico Ausências" = rimd,
                  TableData "Histórico Horas Extra" = rimd,
                  TableData "Histórico Abonos - Desc. Extra" = rimd,
                  TableData "Hist. Cab. Movs. Empregado" = rimd,
                  TableData "Hist. Linhas Movs. Empregado" = rimd,
                  TableData "Historico Empregado" = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Periodos Processamento"; "Periodos Processamento")
        {
            DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento");

            trigger OnAfterGetRecord()
            begin
                if "Periodos Processamento".Estado = 1 then Error(Text0001);
                if "Periodos Processamento"."Tipo Processamento" <> 3 then Error(Text0002);

                TabConfRH.Get();
            end;

            trigger OnPreDataItem()
            begin
                SetFilter("Cód. Processamento", PeriodoCode);
            end;
        }
        dataitem(Empregado; Empregado)
        {
            DataItemTableView = WHERE(Status = CONST(Active), "Tipo Contribuinte" = FILTER(<> "Trabalhador Independente"));
            RequestFilterFields = "No.", "Tipo Contribuinte";
            dataitem("Abonos - Descontos Extra"; "Abonos - Descontos Extra")
            {
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("No. Mov.");

                trigger OnAfterGetRecord()
                begin
                    //No Sub. Natal também tem de ser possivel lançar abonos ou descontos extra, para poder por exemplo
                    //abater um desconto judicial.
                    if ("Abonos - Descontos Extra".Data >= "Periodos Processamento"."Data Inicio Processamento") and
                      ("Abonos - Descontos Extra".Data <= "Periodos Processamento"."Data Fim Processamento") then begin
                        if TabRubricaSalarial.Get("Abonos - Descontos Extra"."Cód. Rubrica") then begin
                            "Abonos - Descontos Extra"."Abono - Desconto Bloqueado" := true;
                            "Abonos - Descontos Extra".Modify;
                            TempRubricaEmpregado.Init;
                            TempRubricaEmpregado."No. Empregado" := Empregado."No.";
                            NLinha := NLinha + 10000;
                            TempRubricaEmpregado."No. Linha" := NLinha;
                            TempRubricaEmpregado."Cód. Rúbrica Salarial" := "Abonos - Descontos Extra"."Cód. Rubrica";
                            TempRubricaEmpregado."Tipo Rubrica" := "Abonos - Descontos Extra"."Tipo Rubrica";
                            TempRubricaEmpregado."Descrição Rubrica" := "Abonos - Descontos Extra"."Descrição Rubrica";
                            TempRubricaEmpregado."No. Conta a Debitar" := TabRubricaSalarial."No. Conta a Debitar";
                            TempRubricaEmpregado."No. Conta a Creditar" := TabRubricaSalarial."No. Conta a Creditar";
                            TempRubricaEmpregado.Quantidade := "Abonos - Descontos Extra".Quantidade;
                            TempRubricaEmpregado.UnidadeMedida := "Abonos - Descontos Extra".UnidadeMedida;//2008.10.30
                            TempRubricaEmpregado."Valor Unitário" := "Abonos - Descontos Extra"."Valor Unitário";
                            if "Abonos - Descontos Extra"."Tipo Rubrica" = "Abonos - Descontos Extra"."Tipo Rubrica"::Abono then
                                TempRubricaEmpregado."Valor Total" := Abs("Abonos - Descontos Extra"."Valor Total")
                            else
                                TempRubricaEmpregado."Valor Total" := -"Abonos - Descontos Extra"."Valor Total";

                            TempRubricaEmpregado.Ordenação := 300;
                            TempRubricaEmpregado."Cód. Situação" := TabRubricaSalarial."Cód. Situação";
                            TempRubricaEmpregado."Cód. Movimento" := TabRubricaSalarial."Cód. Movimento";
                            TempRubricaEmpregado."Data Efeito" := "Periodos Processamento"."Data Fim Processamento";
                            TempRubricaEmpregado.Tabela := DATABASE::"Abonos - Descontos Extra";
                            TempRubricaEmpregado.NLinhaRubSalEmp := "Abonos - Descontos Extra"."No. Mov.";
                            TempRubricaEmpregado."Global Dimension 1 Code" := "Abonos - Descontos Extra"."Global Dimension 1 Code";
                            TempRubricaEmpregado."Global Dimension 2 Code" := "Abonos - Descontos Extra"."Global Dimension 2 Code";
                            TempRubricaEmpregado.Insert;
                        end;
                    end;
                end;
            }
            dataitem(Abonos; "Rubrica Salarial Empregado")
            {
                DataItemLink = "No. Empregado" = FIELD("No."), "Data Início" = FIELD("Data Filtro Inicio"), "Data Fim" = FIELD("Data Filtro Fim");
                DataItemTableView = SORTING("No. Empregado", "Ordenação", "Cód. Rúbrica Salarial") WHERE("Tipo Rubrica" = CONST(Abono));

                trigger OnAfterGetRecord()
                var
                    auxpercentagem: Decimal;
                    TabAusencias: Record "Histórico Ausências";
                    TabMotivoAus: Record "Absence Reason";
                    UNidMedidaRH: Record "Unid. Medida Recursos Humanos";
                    TotalDiasFalta: Decimal;
                begin
                    //*******************************************************************************
                    //Pega em cada Abono parametrizado na tabela Rubrica salarial empregado
                    //e envia para a tabela temporária RubricaSalaEmpregado2 já com o valor calculado
                    //*******************************************************************************
                    TabRubricaSalarial.Reset;
                    TabRubricaSalarial.SetRange(TabRubricaSalarial.Código, Abonos."Cód. Rúbrica Salarial");
                    TabRubricaSalarial.SetRange(TabRubricaSalarial.NATREM, 2);
                    TabRubricaSalarial.SetFilter(TabRubricaSalarial.Genero, '<>%1', TabRubricaSalarial.Genero::DuoSF);
                    if TabRubricaSalarial.Find('-') then begin
                        TempRubricaEmpregado.Init;
                        TempRubricaEmpregado := Abonos;
                        NLinha := NLinha + 10000;
                        TempRubricaEmpregado."No. Linha" := NLinha;
                        TempRubricaEmpregado.NLinhaRubSalEmp := Abonos."No. Linha";
                        TempRubricaEmpregado.Tabela := DATABASE::"Rubrica Salarial Empregado";

                        AuxTabRubricaSalarial.Reset;
                        AuxTabRubricaSalarial.SetRange(AuxTabRubricaSalarial.Genero, AuxTabRubricaSalarial.Genero::CGA);
                        if AuxTabRubricaSalarial.Find('-') then begin
                            AuxTabRubricaEmpregado.Reset;
                            AuxTabRubricaEmpregado.SetRange(AuxTabRubricaEmpregado."No. Empregado", Empregado."No.");
                            AuxTabRubricaEmpregado.SetRange(AuxTabRubricaEmpregado."Cód. Rúbrica Salarial", AuxTabRubricaSalarial.Código);
                            if AuxTabRubricaEmpregado.Find('-') then begin
                                AuxTabRubricaSalLinhas.Reset;
                                AuxTabRubricaSalLinhas.SetRange(AuxTabRubricaSalLinhas."Cód. Rubrica", AuxTabRubricaSalarial.Código);
                                AuxTabRubricaSalLinhas.SetRange(AuxTabRubricaSalLinhas."Cód. Rubrica Filha", Abonos."Cód. Rúbrica Salarial");
                                if AuxTabRubricaSalLinhas.Find('-') then begin
                                    TempRubricaEmpregado."Cód. Situação" := Abonos."Cód. Situação";
                                    TempRubricaEmpregado."Cód. Movimento" := Abonos."Cód. Movimento";
                                    TempRubricaEmpregado."Data Efeito" := Abonos."Data Efeito";
                                end;
                            end;
                        end;

                        //Ver se há rubricas salariais que dependam desta
                        RubricaSalariaLinhas.Reset;
                        RubricaSalariaLinhas.SetRange(RubricaSalariaLinhas."Cód. Rubrica", Abonos."Cód. Rúbrica Salarial");
                        if RubricaSalariaLinhas.FindSet then begin
                            repeat
                                RubricaSalaEmpregado.Reset;
                                RubricaSalaEmpregado.SetRange(RubricaSalaEmpregado."No. Empregado", Abonos."No. Empregado");
                                RubricaSalaEmpregado.SetRange(RubricaSalaEmpregado."Cód. Rúbrica Salarial", RubricaSalariaLinhas."Cód. Rubrica Filha");
                                RubricaSalaEmpregado.SetFilter(RubricaSalaEmpregado."Data Início", '<=%1',
                                                                "Periodos Processamento"."Data Fim Processamento");
                                RubricaSalaEmpregado.SetFilter(RubricaSalaEmpregado."Data Fim", '>=%1|=%2',
                                                                "Periodos Processamento"."Data Inicio Processamento", 0D);
                                if RubricaSalaEmpregado.FindFirst then begin
                                    RubricaSalariaLinhas2.Reset;
                                    RubricaSalariaLinhas2.SetRange(RubricaSalariaLinhas2."Cód. Rubrica", RubricaSalariaLinhas."Cód. Rubrica Filha");
                                    if RubricaSalariaLinhas2.FindSet then begin
                                        repeat
                                            RubricaSalaEmpregado2.Reset;
                                            RubricaSalaEmpregado2.SetRange(RubricaSalaEmpregado2."No. Empregado", Abonos."No. Empregado");
                                            RubricaSalaEmpregado2.SetRange(RubricaSalaEmpregado2."Cód. Rúbrica Salarial",
                                            RubricaSalariaLinhas2."Cód. Rubrica Filha");
                                            RubricaSalaEmpregado2.SetFilter(RubricaSalaEmpregado2."Data Início", '<=%1',
                                            "Periodos Processamento"."Data Fim Processamento");
                                            RubricaSalaEmpregado2.SetFilter(RubricaSalaEmpregado2."Data Fim", '>=%1|=%2',
                                            "Periodos Processamento"."Data Inicio Processamento", 0D);
                                            if RubricaSalaEmpregado2.FindFirst then
                                                TempRubricaEmpregado."Valor Total" := Round(
                                                                          TempRubricaEmpregado."Valor Total" +
                                                                          ((RubricaSalaEmpregado2."Valor Total" * RubricaSalariaLinhas2.Percentagem / 100)),
                                                                              0.01);
                                        until RubricaSalariaLinhas2.Next = 0;
                                    end else begin

                                        //SubFerias e Proporcionais
                                        //*********************************************************
                                        //Um empregado que entrou em anos anteriores recebe o SUB Ferias por inteiro independentemente do tipo de contrato
                                        //Um empregado que entrou no presente ano, recebe o Sub. Férias desde a data de entrada até a data corrente:
                                        //entradas a dia 1 tem direito a 2 dias por cada mês trabalhado
                                        //entradas posteriores a dia 1, nesse mês têm direito somente a 1 dia

                                        Clear(DataFimProcSubFerias);
                                        if (TabRubricaSalarial.NATREM = TabRubricaSalarial.NATREM::"Cód. Sub. Férias") then begin
                                            NumDias := 22;

                                            //novas regras para o processamento Sub. Férias
                                            // 2 dias para quem trabalha 30 dias no mês
                                            // 1 dia para quem trabalha entre 29 e 15 dias
                                            // 0 dias para quem trabalha menos de 15 dias.
                                            // o processamento é feito a 1/8 mas só querem pagar até 31/7

                                            //Entrou no presente Ano vai ver os meses trabalhos para abater ao num dias
                                            if Date2DMY(Empregado."Employment Date", 3) = Date2DMY("Periodos Processamento"."Data Registo", 3) then begin
                                                //Saber qts dias trabalha no mes de admissão
                                                DiasTrabMesAdmissao := CalcDate('PM', Empregado."Employment Date") - Empregado."Employment Date" + 1;

                                                if DiasTrabMesAdmissao >= 30 then
                                                    NumDias := 2 * (Date2DMY("Periodos Processamento"."Data Registo", 2) - Date2DMY(Empregado."Employment Date", 2))
                                                else
                                                    if DiasTrabMesAdmissao < 15 then
                                                        NumDias := 2 * (Date2DMY("Periodos Processamento"."Data Registo", 2) - Date2DMY(Empregado."Employment Date", 2)) - 2
                                                    else
                                                        NumDias := 2 * (Date2DMY("Periodos Processamento"."Data Registo", 2) - Date2DMY(Empregado."Employment Date", 2)) - 1;

                                                if NumDias < 0 then NumDias := 0;
                                                if NumDias > 10 then NumDias := 10;
                                            end;


                                            //ABATER AO SUB Férias AS FALTAS SUPERIORES A 1 MES
                                            //------------------------------------------------
                                            if TabConfRH."Limite dias falta abate SN/F" <> 0 then begin
                                                Clear(TotalDiasFalta);
                                                UNidMedidaRH.Reset;
                                                UNidMedidaRH.SetRange(UNidMedidaRH."Designação Interna", UNidMedidaRH."Designação Interna"::Dia);
                                                if UNidMedidaRH.FindFirst then begin
                                                    TabAusencias.Reset;
                                                    TabAusencias.SetCurrentKey("Employee No.", "From Date");
                                                    TabAusencias.SetRange(TabAusencias."Employee No.", Empregado."No.");
                                                    //As baixa são relativas ao ano transacto
                                                    TabAusencias.SetRange(TabAusencias."From Date",
                                                      DMY2Date(1, 1, Date2DMY("Periodos Processamento"."Data Fim Processamento", 3) - 1),
                                                      DMY2Date(31, 12, Date2DMY("Periodos Processamento"."Data Fim Processamento", 3) - 1));
                                                    TabAusencias.SetRange(TabAusencias."Unit of Measure Code", UNidMedidaRH.Code);
                                                    if TabAusencias.FindSet then begin
                                                        repeat
                                                            TabMotivoAus.Reset;
                                                            TabMotivoAus.SetRange(TabMotivoAus."Holiday Subsidy Influence", true);
                                                            TabMotivoAus.SetRange(TabMotivoAus.Code, TabAusencias."Cause of Absence Code");
                                                            if TabMotivoAus.FindFirst then
                                                                TotalDiasFalta := TotalDiasFalta + TabAusencias.Quantity

                                                        until TabAusencias.Next = 0;
                                                        if TotalDiasFalta > TabConfRH."Limite dias falta abate SN/F" then
                                                            NumDias := NumDias - (Round(TotalDiasFalta / TabConfRH."Limite dias falta abate SN/F", 1, '<') * 2);
                                                    end;
                                                end;
                                            end;

                                            RubricaSalaEmpregado."Valor Total" := RubricaSalaEmpregado."Valor Total" * NumDias / 22;
                                        end;


                                        //TAXA IRS SUB FERIAS
                                        //**********************
                                        ValorTotalSubFerias := Round(ValorTotalSubFerias + RubricaSalaEmpregado."Valor Total", 0.01);

                                        TempRubricaEmpregado.Quantidade := NumDias;

                                        TempRubricaEmpregado."Valor Total" := Round(
                                                                            TempRubricaEmpregado."Valor Total" +
                                                                            (RubricaSalaEmpregado."Valor Total" * (RubricaSalariaLinhas.Percentagem / 100)),
                                                                              0.01);

                                    end;
                                end;
                            until RubricaSalariaLinhas.Next = 0;
                        end;
                        TempRubricaEmpregado.Insert;
                    end;
                end;
            }
            dataitem(Descontos; "Rubrica Salarial Empregado")
            {
                DataItemLink = "No. Empregado" = FIELD("No."), "Data Início" = FIELD("Data Filtro Inicio"), "Data Fim" = FIELD("Data Filtro Fim");
                DataItemTableView = SORTING("No. Empregado", "Ordenação", "Cód. Rúbrica Salarial") WHERE("Tipo Rubrica" = CONST(Desconto));

                trigger OnAfterGetRecord()
                begin
                    //*******************************************************************************
                    //Pega em cada Desconto parametrizado na tabela Rubrica salarial empregado
                    //e envia para a tabela temporária TempRubricaEmpregado2 já com o valor calculado
                    //*******************************************************************************

                    //Testa para cada rubrica,segundo a periodicidade e mês de inicio da mesma,
                    //se para este processamento (Data) esta rubrica é para processar
                    TabRubricaSalarial.Reset;
                    TabRubricaSalarial.SetRange(TabRubricaSalarial.Código, Descontos."Cód. Rúbrica Salarial");
                    if TabRubricaSalarial.FindFirst then begin
                        if (TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::"IRS Sub. Férias")
                          or (TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::SS)
                          or (TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::CGA)
                          or (TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::ADSE) then begin

                            //é para processar
                            TempRubricaEmpregado2.Init;
                            TempRubricaEmpregado2 := Descontos;
                            NLinha := NLinha + 10000;
                            TempRubricaEmpregado2."No. Linha" := NLinha;
                            TempRubricaEmpregado.NLinhaRubSalEmp := Descontos."No. Linha";
                            TempRubricaEmpregado.Tabela := DATABASE::"Rubrica Salarial Empregado";

                            RubricaSalariaLinhas.Reset;
                            RubricaSalariaLinhas.SetRange(RubricaSalariaLinhas."Cód. Rubrica", Descontos."Cód. Rúbrica Salarial");
                            if RubricaSalariaLinhas.FindSet then begin
                                repeat
                                    TempRubricaEmpregado.Reset;
                                    TempRubricaEmpregado.SetRange(TempRubricaEmpregado."No. Empregado", Descontos."No. Empregado");
                                    TempRubricaEmpregado.SetRange(TempRubricaEmpregado."Cód. Rúbrica Salarial", RubricaSalariaLinhas."Cód. Rubrica Filha");
                                    TempRubricaEmpregado.SetFilter(TempRubricaEmpregado."Data Início", '<=%1',
                                                                    "Periodos Processamento"."Data Fim Processamento");
                                    TempRubricaEmpregado.SetFilter(TempRubricaEmpregado."Data Fim", '>=%1|=%2',
                                                                    "Periodos Processamento"."Data Inicio Processamento", 0D);
                                    if TempRubricaEmpregado.FindSet then begin
                                        repeat
                                            //Existe um limite máximo
                                            if RubricaSalariaLinhas."Valor Limite Máximo" <> 0.0 then
                                                VarValorLimite := Round(TempRubricaEmpregado.Quantidade * RubricaSalariaLinhas."Valor Limite Máximo", 0.01)
                                            else
                                                VarValorLimite := 0;

                                            //Exceção para a % da CGA ou ADSE
                                            if ((TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::CGA) or
                                               (TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::ADSE)) then begin
                                                GrauFuncaoEmpregado.Reset;
                                                GrauFuncaoEmpregado.SetRange(GrauFuncaoEmpregado."No. Empregado", Empregado."No.");
                                                GrauFuncaoEmpregado.SetFilter(GrauFuncaoEmpregado."Data Inicio Grau Função",
                                                                              '<=%1', "Periodos Processamento"."Data Registo");
                                                GrauFuncaoEmpregado.SetFilter(GrauFuncaoEmpregado."Data Fim Grau Função",
                                                                              '>=%1|%2', "Periodos Processamento"."Data Registo", 0D);
                                                if GrauFuncaoEmpregado.FindFirst then
                                                    Nivel := GrauFuncaoEmpregado."Cód. Grau Função";

                                                // se a pessoa ganha acima da tabela e tem 22 ou menos entÆo tem de se fazer
                                                //a regra dos dias esperados pelo valor da tabela e nÆo pelo valor do ordenado
                                                GrauFuncao.Reset;
                                                if GrauFuncao.Get(Nivel) then begin
                                                    //Tem de calcular a CGA sobre os 50% Suf. Ferias e Natal
                                                    if (TempRubricaEmpregado."Cód. Situação" = '30') or (TempRubricaEmpregado."Cód. Situação" = '32') then begin
                                                        if Empregado."Valor Vencimento Base" > GrauFuncao."Max Value" then
                                                            TempRubricaEmpregado."Valor Total" := TempRubricaEmpregado."Valor Total" *
                                                                                                GrauFuncao."Max Value" / Empregado."Valor Vencimento Base";
                                                    end else begin
                                                        //se a pessoa ganha acima da tabela entÆo desconta sobre o valor tabela
                                                        if TempRubricaEmpregado."Valor Total" > GrauFuncao."Max Value" then begin
                                                            TempRubricaEmpregado."Valor Total" := Round(GrauFuncao."Max Value");
                                                            TempRubricaEmpregado."Valor Total" := Round(TempRubricaEmpregado."Valor Total", 0.01);
                                                        end;
                                                    end;
                                                end;
                                                TempRubricaEmpregado2."Valor Total" := Round(TempRubricaEmpregado2."Valor Total" +
                                                    ((TempRubricaEmpregado."Valor Total" - VarValorLimite) * RubricaSalariaLinhas.Percentagem / 100), 0.01);

                                            end else begin
                                                //Calculo normal para os restantes casos
                                                TempRubricaEmpregado2."Valor Total" := Round(TempRubricaEmpregado2."Valor Total" +
                                                          ((TempRubricaEmpregado."Valor Total" - VarValorLimite) * RubricaSalariaLinhas.Percentagem / 100), 0.01);
                                                TempRubricaEmpregado2.Quantidade := RubricaSalariaLinhas.Percentagem;
                                            end;
                                        until TempRubricaEmpregado.Next = 0;
                                    end;
                                until RubricaSalariaLinhas.Next = 0;
                            end;

                            //************************************************
                            //****************IRS*****************************
                            //************************************************
                            if TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::"IRS Sub. Férias" then begin
                                ValorIncidenciaIRS := ValorIncidenciaIRS + TempRubricaEmpregado2."Valor Total";
                                ValorEscalaoSobretaxa := Empregado."Valor Vencimento Base";
                                if Empregado."IRS % Fixa" = 0.0 then begin
                                    IRSTaxa := FuncoesRH.CalcularTaxaIRS(ValorIncidenciaIRS, Empregado,
                                                                        Date2DMY("Periodos Processamento"."Data Registo", 3));
                                    TempRubricaEmpregado2."Valor Total" := Round(TempRubricaEmpregado2."Valor Total" * IRSTaxa / 100, 1, '<');//HG arred IRS
                                    TempRubricaEmpregado2.Quantidade := IRSTaxa;
                                end else begin
                                    TempRubricaEmpregado2."Valor Total" := Round((TempRubricaEmpregado2."Valor Total")
                                                                            * Empregado."IRS % Fixa" / 100, 1, '<');
                                    TempRubricaEmpregado2.Quantidade := Empregado."IRS % Fixa";
                                end;
                            end;

                            //************************************************
                            //****************SS*****************************
                            //************************************************
                            if TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::SS then begin
                                TabRegimeSS.Reset;
                                if TabRegimeSS.Get(Empregado."Cod. Regime SS") then begin
                                    VarValorTotal := TempRubricaEmpregado2."Valor Total";
                                    TempRubricaEmpregado2."Valor Total" := Round(VarValorTotal * TabRegimeSS."Taxa Contributiva Empregado" / 100, 0.01);
                                    TempRubricaEmpregado2.Quantidade := TabRegimeSS."Taxa Contributiva Empregado";
                                    if Empregado."Subscritor SS" then
                                        Empregado.TestField(Empregado."Cód. Rúbrica Enc. Seg. Social");
                                    ProcessarEncSociais(VarValorTotal, TabRegimeSS."Taxa Contributiva Ent Patronal",
                                                        Empregado."Cód. Rúbrica Enc. Seg. Social");
                                end;
                            end;

                            //************************************************
                            //****************CGA*****************************
                            //************************************************
                            if TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::CGA then begin
                                VarValorTotal := TempRubricaEmpregado2."Valor Total";
                                if not Empregado."Professor Acumulação" then begin
                                    TempRubricaEmpregado2."Valor Total" := Round(VarValorTotal * TabConfRH."Taxa Contributiva Empregado" / 100, 0.01);
                                    TempRubricaEmpregado2.Quantidade := TabConfRH."Taxa Contributiva Empregado";
                                end else begin
                                    TempRubricaEmpregado2."Valor Total" := 0;
                                    TempRubricaEmpregado2.Quantidade := 0;
                                end;
                                if Empregado."Subsccritor CGA" then
                                    Empregado.TestField(Empregado."Cód. Rúbrica Enc. CGA");
                                if not Empregado."CGA - Requisição" then
                                    ProcessarEncSociais(VarValorTotal, TabConfRH."Taxa Contributiva Ent Patronal", Empregado."Cód. Rúbrica Enc. CGA")
                                else
                                    ProcessarEncSociais(VarValorTotal, 0, Empregado."Cód. Rúbrica Enc. CGA");
                            end;

                            //************************************************
                            //****************ADSE****************************
                            //************************************************
                            if TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::ADSE then begin
                                VarValorTotal := TempRubricaEmpregado2."Valor Total";
                                //se o empregado faltar o mes todo este valor vem a negativo e como tal passo-o para 0
                                if VarValorTotal < 0 then
                                    VarValorTotal := 0;
                                TempRubricaEmpregado2."Valor Total" := Round(VarValorTotal * TabConfRH."Taxa Contr. Empregado ADSE" / 100, 0.01);
                                TempRubricaEmpregado2.Quantidade := TabConfRH."Taxa Contr. Empregado ADSE";
                            end;

                            TempRubricaEmpregado2."Valor Total" := -TempRubricaEmpregado2."Valor Total";
                            TempRubricaEmpregado2.Insert;
                        end;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    //************************************************************
                    //Copia as rúbricas da tabela temporária TempRubricaEmpregado para TempRubricaEmpregado2
                    //************************************************************
                    TempRubricaEmpregado.Reset;
                    TempRubricaEmpregado.SetRange(TempRubricaEmpregado."No. Empregado", Empregado."No.");
                    if TempRubricaEmpregado.FindSet then
                        repeat
                            TempRubricaEmpregado2.Init;
                            TempRubricaEmpregado2.TransferFields(TempRubricaEmpregado);
                            TempRubricaEmpregado2.Insert;
                        until TempRubricaEmpregado.Next = 0;
                end;
            }
            dataitem(Empregado2; Empregado)
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("No.");

                trigger OnAfterGetRecord()
                var
                    CatProfQPEmpregado: Record "Cat. Prof. QP Empregado";
                    GrauFuncaoEmpregado: Record "Grau Função Empregado";
                    l_RubSal: Record "Rubrica Salarial";
                begin
                    //***************************************************************************************
                    //Envia para as tabelas Cab. Mov e Linhas Mov. empregado este processamento que está
                    //na tabela temporária TempRubricaEmpregado2
                    //***************************************************************************************
                    NLinha := 0;
                    NLinha2 := 0;
                    Clear(VarCodRubrica);
                    CabMovEmpregado.Init;
                    CabMovEmpregado."Cód. Processamento" := "Periodos Processamento"."Cód. Processamento";
                    CabMovEmpregado."Tipo Processamento" := "Periodos Processamento"."Tipo Processamento";
                    CabMovEmpregado."No. Empregado" := Empregado2."No.";
                    CabMovEmpregado."Designação Empregado" := Empregado2.Name;
                    CabMovEmpregado."Data Registo" := "Periodos Processamento"."Data Registo";
                    CabMovEmpregado."Usa Transferência Bancária" := Empregado."Usa Transf. Bancária";
                    CabMovEmpregado."Cód. Banco Transf." := Empregado."Cód. Banco Transf.";
                    CabMovEmpregado."No. Segurança Social" := Empregado."No. Segurança Social";
                    CabMovEmpregado."No. Contribuinte" := Empregado."No. Contribuinte";
                    CabMovEmpregado.IBAN := Empregado.IBAN;
                    CabMovEmpregado.Seguradora := Empregado.Seguradora;
                    CabMovEmpregado."No. Apólice" := Empregado."No. Apólice";
                    CabMovEmpregado."Nº CGA" := Empregado."Nº CGA";

                    GrauFuncaoEmpregado.Reset;
                    GrauFuncaoEmpregado.SetRange(GrauFuncaoEmpregado."No. Empregado", Empregado."No.");
                    GrauFuncaoEmpregado.SetFilter(GrauFuncaoEmpregado."Data Inicio Grau Função", '<=%1', "Periodos Processamento"."Data Registo");
                    GrauFuncaoEmpregado.SetFilter(GrauFuncaoEmpregado."Data Fim Grau Função", '>=%1|%2', "Periodos Processamento"."Data Registo", 0D);
                    if GrauFuncaoEmpregado.FindFirst then
                        CabMovEmpregado."Grau Função" := GrauFuncaoEmpregado."Cód. Grau Função";

                    CatProfQPEmpregado.Reset;
                    CatProfQPEmpregado.SetRange(CatProfQPEmpregado."No. Empregado", Empregado."No.");
                    CatProfQPEmpregado.SetFilter(CatProfQPEmpregado."Data Inicio Cat. Prof.", '<=%1', "Periodos Processamento"."Data Registo");
                    CatProfQPEmpregado.SetFilter(CatProfQPEmpregado."Data Fim Cat. Prof.", '>=%1|%2', "Periodos Processamento"."Data Registo", 0D);
                    if CatProfQPEmpregado.FindFirst then
                        CabMovEmpregado."Descrição Cat Prof QP" := CatProfQPEmpregado.Description;
                    CabMovEmpregado."Valor Vencimento Base" := FuncoesRH.CalcularVencimentoBase("Periodos Processamento"."Data Registo", Empregado);
                    if Empregado."No. Horas Semanais" <> 0.0 then
                        CabMovEmpregado."Valor Hora" := FuncoesRH.CalcularValorHora(CabMovEmpregado."Valor Vencimento Base", Empregado)
                    else
                        CabMovEmpregado."Valor Hora" := 0;
                    CabMovEmpregado."No. Horas Semanais" := Empregado."No. Horas Semanais";
                    CabMovEmpregado."Nº Horas Semanais Totais" := Empregado."No. Horas Semanais Totais";
                    CabMovEmpregado."Nº Horas Docência Calc. Desct." := Empregado."Nº Horas Docência Calc. Desct.";
                    CabMovEmpregado."Valor Incidência IRS" := ValorIncidenciaIRS; //2013.01.14
                    CabMovEmpregado."Valor para Escalão Sobretaxa" := ValorEscalaoSobretaxa; //2016.01.08 - Sobretaxa 2016
                    CabMovEmpregado.Insert;

                    TempRubricaEmpregado2.SetCurrentKey(TempRubricaEmpregado2."No. Empregado",
                    TempRubricaEmpregado2.Ordenação, TempRubricaEmpregado2."Cód. Rúbrica Salarial");
                    if TempRubricaEmpregado2.FindSet then begin
                        repeat
                            if TempRubricaEmpregado2."Valor Total" <> 0 then begin
                                if VarCodRubrica <> TempRubricaEmpregado2."Cód. Rúbrica Salarial" then begin
                                    NLinha := NLinha + 10000;
                                    LinhaMovEmpregado.Init;
                                    LinhaMovEmpregado."Cód. Processamento" := "Periodos Processamento"."Cód. Processamento";
                                    LinhaMovEmpregado."Tipo Processamento" := "Periodos Processamento"."Tipo Processamento";
                                    LinhaMovEmpregado."No. Empregado" := Empregado2."No.";
                                    LinhaMovEmpregado."No. Linha" := NLinha;
                                    LinhaMovEmpregado."Data Registo" := "Periodos Processamento"."Data Registo";
                                    LinhaMovEmpregado."Designação Empregado" := Empregado2.Name;
                                    LinhaMovEmpregado."Cód. Rubrica" := TempRubricaEmpregado2."Cód. Rúbrica Salarial";
                                    LinhaMovEmpregado."Descrição Rubrica" := TempRubricaEmpregado2."Descrição Rubrica";
                                    LinhaMovEmpregado."Tipo Rubrica" := TempRubricaEmpregado2."Tipo Rubrica";
                                    LinhaMovEmpregado."No. Conta a Debitar" := TempRubricaEmpregado2."No. Conta a Debitar";
                                    LinhaMovEmpregado."No. Conta a Creditar" := TempRubricaEmpregado2."No. Conta a Creditar";
                                    LinhaMovEmpregado.Quantidade := TempRubricaEmpregado2.Quantidade;
                                    LinhaMovEmpregado."Valor Unitário" := TempRubricaEmpregado2."Valor Unitário";
                                    LinhaMovEmpregado.Valor := TempRubricaEmpregado2."Valor Total";
                                    LinhaMovEmpregado."Tipo Rendimento" := Empregado2."Tipo Rendimento";
                                    LinhaMovEmpregado."Cód. Situação" := TempRubricaEmpregado2."Cód. Situação";
                                    LinhaMovEmpregado."Cód. Movimento" := TempRubricaEmpregado2."Cód. Movimento";
                                    LinhaMovEmpregado."Data Efeito" := TempRubricaEmpregado2."Data Efeito";
                                    TabRubSal.Reset;
                                    if TabRubSal.Get(TempRubricaEmpregado2."Cód. Rúbrica Salarial") then
                                        LinhaMovEmpregado.NATREM := TabRubSal.NATREM;
                                    LinhaMovEmpregado."Global Dimension 1 Code" := TempRubricaEmpregado."Global Dimension 1 Code";
                                    LinhaMovEmpregado."Global Dimension 2 Code" := TempRubricaEmpregado."Global Dimension 2 Code";
                                    l_RubSal.Reset;
                                    if l_RubSal.Get(TempRubricaEmpregado2."Cód. Rúbrica Salarial") then begin
                                        LinhaMovEmpregado."Tipo Rendimento Cat.A" := l_RubSal."Tipo Rendimento Cat.A";
                                    end;
                                    LinhaMovEmpregado.Insert;
                                end else begin
                                    LinhaMovEmpregado.Quantidade := LinhaMovEmpregado.Quantidade + TempRubricaEmpregado2.Quantidade;
                                    LinhaMovEmpregado.Valor := LinhaMovEmpregado.Valor + TempRubricaEmpregado2."Valor Total";
                                    LinhaMovEmpregado.Modify;
                                end;
                            end;
                            VarCodRubrica := TempRubricaEmpregado2."Cód. Rúbrica Salarial";
                        until TempRubricaEmpregado2.Next = 0;
                    end;
                end;
            }
            dataitem(Penhora; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                trigger OnAfterGetRecord()
                var
                    FlagPenhora: Boolean;
                    rPenhora: Record Penhoras;
                    rCabMovEmp: Record "Cab. Movs. Empregado";
                    rLinhaMovEmp: Record "Linhas Movs. Empregado";
                    ValorImpenhoravel: Decimal;
                    ValorPenhoravel: Decimal;
                    ValorAPenhorar: Decimal;
                begin
                    FlagPenhora := false;
                    Clear(ValorAPenhorar);
                    rPenhora.Reset;
                    rPenhora.SetRange(rPenhora."Employee No.", Empregado."No.");
                    rPenhora.SetRange(rPenhora.Status, rPenhora.Status::Active);
                    if rPenhora.FindFirst then begin
                        FlagPenhora := true;

                    end else begin
                        rPenhora.Reset;
                        rPenhora.SetRange(rPenhora."Employee No.", Empregado."No.");
                        rPenhora.SetRange(rPenhora.Status, rPenhora.Status::Pending);
                        if rPenhora.FindFirst then
                            FlagPenhora := true;
                    end;

                    if FlagPenhora then begin
                        rCabMovEmp.Reset;
                        rCabMovEmp.SetRange(rCabMovEmp."Tipo Processamento", rCabMovEmp."Tipo Processamento"::SubFerias);
                        rCabMovEmp.SetRange("No. Empregado", Empregado."No.");
                        if rCabMovEmp.FindFirst then begin
                            rCabMovEmp.CalcFields(Valor);
                            if rCabMovEmp.Valor > TabConfRH."Ordenado Mínimo" then begin
                                rPenhora.TestField("Garnishment Rubric");
                                rPenhora.CalcFields("Amount Already Garnishment");
                                if rPenhora."Garnishment Coefficient" = rPenhora."Garnishment Coefficient"::"1/3" then begin
                                    ValorImpenhoravel := rCabMovEmp.Valor / 3 * 2;
                                    ValorPenhoravel := rCabMovEmp.Valor / 3;
                                end else begin
                                    ValorImpenhoravel := rCabMovEmp.Valor / 6 * 2;
                                    ValorPenhoravel := rCabMovEmp.Valor / 6;
                                end;
                                if (rPenhora."Garnishment Amount" - rPenhora."Amount Already Garnishment") > ValorPenhoravel then begin
                                    ValorAPenhorar := ValorPenhoravel;
                                    if ValorImpenhoravel > TabConfRH."Ordenado Mínimo" * 3 then begin
                                        ValorAPenhorar := TabConfRH."Ordenado Mínimo" - (TabConfRH."Ordenado Mínimo" * 3);
                                        if ValorAPenhorar > (rPenhora."Garnishment Amount" - rPenhora."Amount Already Garnishment") then
                                            ValorAPenhorar := (rPenhora."Garnishment Amount" - rPenhora."Amount Already Garnishment");
                                    end;
                                end else
                                    ValorAPenhorar := (rPenhora."Garnishment Amount" - rPenhora."Amount Already Garnishment");

                                NLinha := NLinha + 10000;
                                rLinhaMovEmp.Init;
                                rLinhaMovEmp."Cód. Processamento" := "Periodos Processamento"."Cód. Processamento";
                                rLinhaMovEmp."Tipo Processamento" := rLinhaMovEmp."Tipo Processamento"::SubFerias;
                                rLinhaMovEmp.Validate("No. Empregado", Empregado."No.");
                                rLinhaMovEmp."No. Linha" := NLinha;
                                rLinhaMovEmp."Data Registo" := "Periodos Processamento"."Data Registo";
                                rLinhaMovEmp.Validate("Cód. Rubrica", rPenhora."Garnishment Rubric");
                                ;
                                rLinhaMovEmp.Quantidade := 1;
                                rLinhaMovEmp.Valor := Round(ValorAPenhorar, 0.01) * -1;
                                rLinhaMovEmp."Garnishmen No." := rPenhora."Garnishmen No.";
                                rLinhaMovEmp.Insert;
                                if rPenhora.Status <> rPenhora.Status::Closed then begin
                                    rPenhora.Status := rPenhora.Status::Active;
                                    rPenhora.Modify;
                                end;
                            end;
                        end;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                DiasTrabMesAdmissao := 0;

                //*******************************
                //Limpar as tabelas temporárias
                //*******************************
                TempRubricaEmpregado.Reset;
                TempRubricaEmpregado2.Reset;
                TempRubricaEmpregado.DeleteAll;
                TempRubricaEmpregado2.DeleteAll;
                NLinha := 0;
                NLinha2 := 0;
                ValorTotalSubFerias := 0;
                ValorIncidenciaIRS := 0;
                ValorEscalaoSobretaxa := 0;

                //***************************************************************************************
                //Ver se já existe processamento para esse empregado para esse periodo (Cod Processamento)
                //Caso exista, pergunta ao utilizador se quer substituir
                //***************************************************************************************
                CabMovEmpregado.Reset;
                CabMovEmpregado.SetRange(CabMovEmpregado."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                CabMovEmpregado.SetFilter(CabMovEmpregado."Tipo Processamento", '%1|%2',
                CabMovEmpregado."Tipo Processamento"::SubFerias, CabMovEmpregado."Tipo Processamento"::Encargos);
                CabMovEmpregado.SetRange(CabMovEmpregado."No. Empregado", Empregado."No.");
                if CabMovEmpregado.Find('-') then begin
                    if not first then begin
                        if Confirm(Text0006, true) then begin
                            CabMovEmpregado.DeleteAll;
                            LinhaMovEmpregado.SetRange(LinhaMovEmpregado."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                            LinhaMovEmpregado.SetFilter(LinhaMovEmpregado."Tipo Processamento", '%1|%2',
                            LinhaMovEmpregado."Tipo Processamento"::SubFerias, LinhaMovEmpregado."Tipo Processamento"::Encargos);
                            LinhaMovEmpregado.SetRange(LinhaMovEmpregado."No. Empregado", Empregado."No.");
                            if LinhaMovEmpregado.Find('-') then begin
                                LinhaMovEmpregado.DeleteAll;
                            end;
                        end else
                            CurrReport.Skip;
                        first := true;
                    end else begin
                        CabMovEmpregado.DeleteAll;
                        LinhaMovEmpregado.SetRange(LinhaMovEmpregado."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                        LinhaMovEmpregado.SetFilter(LinhaMovEmpregado."Tipo Processamento", '%1|%2',
                        LinhaMovEmpregado."Tipo Processamento"::SubFerias, LinhaMovEmpregado."Tipo Processamento"::Encargos);
                        LinhaMovEmpregado.SetRange(LinhaMovEmpregado."No. Empregado", Empregado."No.");
                        if LinhaMovEmpregado.Find('-') then begin
                            LinhaMovEmpregado.DeleteAll;
                        end;
                    end;
                end;

                i += 1;
                window.Update(1, Round(i * 100 / counts * 100, 1));
            end;

            trigger OnPostDataItem()
            begin
                //***************************************************************************************
                //Ver se já existe processamento para esse empregado para esse periodo (Cod Processamento)
                //Apagar os processamentos para um determinado num de empregados filtrado no request form
                //***************************************************************************************
                if ApagaEmp <> '' then begin
                    CabMovEmpregado.Reset;
                    CabMovEmpregado.SetRange(CabMovEmpregado."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                    CabMovEmpregado.SetFilter(CabMovEmpregado."Tipo Processamento", '%1|%2',
                    CabMovEmpregado."Tipo Processamento"::SubFerias, CabMovEmpregado."Tipo Processamento"::Encargos);
                    ApagaEmp := CopyStr(ApagaEmp, 1, StrLen(ApagaEmp) - 1);
                    CabMovEmpregado.SetFilter(CabMovEmpregado."No. Empregado", ApagaEmp);
                    if CabMovEmpregado.Find('-') then begin
                        if Confirm(Text0007, true, ApagaEmp) then begin
                            CabMovEmpregado.DeleteAll;
                            LinhaMovEmpregado.SetRange(LinhaMovEmpregado."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                            LinhaMovEmpregado.SetFilter(LinhaMovEmpregado."Tipo Processamento", '%1|%2',
                            LinhaMovEmpregado."Tipo Processamento"::SubFerias, LinhaMovEmpregado."Tipo Processamento"::Encargos);
                            LinhaMovEmpregado.SetFilter(LinhaMovEmpregado."No. Empregado", ApagaEmp);
                            if LinhaMovEmpregado.Find('-') then LinhaMovEmpregado.DeleteAll;
                        end;
                    end;
                end;
                window.Close;
            end;

            trigger OnPreDataItem()
            begin
                SetFilter("Data Filtro Inicio", '<=%1', "Periodos Processamento"."Data Fim Processamento");
                SetFilter("Data Filtro Fim", '>=%1|=%2', "Periodos Processamento"."Data Inicio Processamento", 0D);
                //Apagar todos os empregados
                if apagaTodosEmp then begin
                    CabMovEmpregado.Reset;
                    CabMovEmpregado.SetRange(CabMovEmpregado."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                    CabMovEmpregado.SetFilter(CabMovEmpregado."Tipo Processamento", '%1|%2',
                    CabMovEmpregado."Tipo Processamento"::SubFerias, CabMovEmpregado."Tipo Processamento"::Encargos);
                    if CabMovEmpregado.Find('-') then begin
                        if Confirm(Text0025, true) then begin
                            CabMovEmpregado.DeleteAll;
                            LinhaMovEmpregado.Reset;
                            LinhaMovEmpregado.SetRange(LinhaMovEmpregado."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                            LinhaMovEmpregado.SetFilter(LinhaMovEmpregado."Tipo Processamento", '%1|%2',
                            LinhaMovEmpregado."Tipo Processamento"::SubFerias, LinhaMovEmpregado."Tipo Processamento"::Encargos);
                            if LinhaMovEmpregado.Find('-') then begin
                                LinhaMovEmpregado.DeleteAll;
                            end;
                        end;
                    end;
                    Commit;
                    CurrReport.Quit;
                end;
                counts := Empregado.Count;
                window.Open(Text0005);
                first := false;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Periodo Processamento")
                {
                    Caption = 'Periodo Processamento';
                    field(PeriodoCode; PeriodoCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Periodo Processamento';
                        TableRelation = "Periodos Processamento";
                    }
                }
                group("Apagar Processamento de Empregado")
                {
                    Caption = 'Apagar Processamento de Empregado';
                    field(ApagaEmp; ApagaEmp)
                    {
                        ApplicationArea = All;
                        Caption = 'Nº Empregado a apagar';
                        TableRelation = Empregado;
                    }
                    field(apagaTodosEmp; apagaTodosEmp)
                    {
                        ApplicationArea = All;
                        Caption = 'Apagar Todos os Empregados';
                    }
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
        Message('%1', Text0004);
    end;

    var
        Text0001: Label 'Este Processamento encontra-se Fechado.';
        Text0002: Label 'Deve escolher um processamento do tipo SubFérias.';
        RubricaSalaEmpregado: Record "Rubrica Salarial Empregado";
        RubricaSalariaLinhas: Record "Rubrica Salarial Linhas";
        TempRubricaEmpregado: Record "Rubrica Salarial Empregado" temporary;
        TempRubricaEmpregado2: Record "Rubrica Salarial Empregado" temporary;
        CabMovEmpregado: Record "Cab. Movs. Empregado";
        LinhaMovEmpregado: Record "Linhas Movs. Empregado";
        NLinha: Integer;
        Text0003: Label 'Já existe um processamento para o Empregado %1 para este periodo. Deseja substituí-lo?';
        NLinha2: Integer;
        FuncoesRH: Codeunit "Funções RH";
        TabRubricaSalarial: Record "Rubrica Salarial";
        TabRegimeSS: Record "Regime Seg. Social";
        TabConfRH: Record "Config. Recursos Humanos";
        QtdAProcessar: Decimal;
        ValorVencimentoBase: Decimal;
        VarCodRubrica: Code[20];
        VarOrdenacao: Integer;
        IRSTaxa: Decimal;
        VarValorLimite: Decimal;
        VarAbateSubAlimentacao: Integer;
        VarValorTotal: Decimal;
        Text0004: Label 'Processamento terminado.';
        Text0005: Label 'Barra de Progresso @1@@@@@@@@@';
        counts: Integer;
        i: Integer;
        window: Dialog;
        ApagaEmp: Text[250];
        Text0006: Label 'Já existe processamentos dos empregados para este período, deseja substituí-los?';
        Text0007: Label 'Tem a certeza que deseja apagar o processamento para os seguintes Empregados: %1 para este período?';
        TabRubSal: Record "Rubrica Salarial";
        first: Boolean;
        AuxTabRubricaSalarial: Record "Rubrica Salarial";
        AuxTabRubricaSalLinhas: Record "Rubrica Salarial Linhas";
        AuxTabRubricaEmpregado: Record "Rubrica Salarial Empregado";
        RubricaSalariaLinhas2: Record "Rubrica Salarial Linhas";
        RubricaSalaEmpregado2: Record "Rubrica Salarial Empregado";
        apagaTodosEmp: Boolean;
        Text0025: Label 'Tem a certeza que deseja apagar o processamento para todos os empregados?';
        GrauFuncaoEmpregado: Record "Grau Função Empregado";
        GrauFuncao: Record "Grau Função";
        Nivel: Code[20];
        ContratoEmp: Record "Contrato Empregado";
        DataUltAcertoSF: Date;
        DataFimProcSubFerias: Date;
        Text0031: Label 'O emprgado %1 não tem um contrato activo, como tal não é possível o calculo automático do Subsídio.';
        ValorTotalSubFerias: Decimal;
        NumLinha: Integer;
        ValorIncidenciaIRS: Decimal;
        NumDias: Integer;
        PeriodoCode: Code[10];
        ValorEscalaoSobretaxa: Decimal;
        DiasTrabMesAdmissao: Integer;


    procedure ProcessarEncSociais(Valor: Decimal; VarTaxa: Decimal; VarCodRubrica: Code[20])
    var
        TabCabMovEmpregado: Record "Cab. Movs. Empregado";
        TabLinhaMovEmpregado: Record "Linhas Movs. Empregado";
        TabRubSalarial: Record "Rubrica Salarial";
        recRubSalarialEmp: Record "Rubrica Salarial Empregado";
        recRubSalarial: Record "Rubrica Salarial";
        Flag: Boolean;
    begin
        //****************************************************
        //****** Processamento dos Encargos Sociais **********
        //****************************************************
        TabRubSalarial.Reset;
        TabRubSalarial.SetRange(TabRubSalarial.Código, VarCodRubrica);
        if TabRubSalarial.FindSet then begin
            TabCabMovEmpregado.Reset;
            TabCabMovEmpregado.SetRange(TabCabMovEmpregado."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
            TabCabMovEmpregado.SetRange(TabCabMovEmpregado."Tipo Processamento", TabCabMovEmpregado."Tipo Processamento"::Encargos);
            TabCabMovEmpregado.SetRange(TabCabMovEmpregado."No. Empregado", Empregado."No.");
            if not TabCabMovEmpregado.FindFirst then begin
                TabCabMovEmpregado.Init;
                TabCabMovEmpregado."Cód. Processamento" := "Periodos Processamento"."Cód. Processamento";
                TabCabMovEmpregado."Tipo Processamento" := TabCabMovEmpregado."Tipo Processamento"::Encargos;
                TabCabMovEmpregado."No. Empregado" := Empregado."No.";
                TabCabMovEmpregado."Designação Empregado" := Empregado.Name;
                TabCabMovEmpregado."Data Registo" := "Periodos Processamento"."Data Registo";
                TabCabMovEmpregado.Insert;
            end;

            NLinha := NLinha + 10000;
            TabLinhaMovEmpregado.Init;
            TabLinhaMovEmpregado."Cód. Processamento" := "Periodos Processamento"."Cód. Processamento";
            TabLinhaMovEmpregado."Tipo Processamento" := TabCabMovEmpregado."Tipo Processamento"::Encargos;
            TabLinhaMovEmpregado."No. Empregado" := Empregado."No.";
            TabLinhaMovEmpregado."No. Linha" := NLinha; //NLinha2; 2009.03.03
            TabLinhaMovEmpregado."Data Registo" := "Periodos Processamento"."Data Registo";
            TabLinhaMovEmpregado."Designação Empregado" := Empregado.Name;
            TabLinhaMovEmpregado."Cód. Rubrica" := TabRubSalarial.Código;
            TabLinhaMovEmpregado."Descrição Rubrica" := TabRubSalarial.Descrição;
            TabLinhaMovEmpregado."Tipo Rubrica" := TabRubSalarial."Tipo Rubrica";
            TabLinhaMovEmpregado."No. Conta a Debitar" := TabRubSalarial."No. Conta a Debitar";
            TabLinhaMovEmpregado."No. Conta a Creditar" := TabRubSalarial."No. Conta a Creditar";
            TabLinhaMovEmpregado.Quantidade := VarTaxa;
            TabLinhaMovEmpregado.Valor := Round(Valor * VarTaxa / 100, 0.01);
            TabLinhaMovEmpregado."Tipo Rendimento" := Empregado."Tipo Rendimento";
            if TabRubSalarial.Genero = 12 then begin
                TabLinhaMovEmpregado."Cód. Situação" := Descontos."Cód. Situação";
                TabLinhaMovEmpregado."Cód. Movimento" := Descontos."Cód. Movimento";
                if Descontos."Data Efeito" <> 0D then
                    TabLinhaMovEmpregado."Data Efeito" := Descontos."Data Efeito"
                else
                    TabLinhaMovEmpregado."Data Efeito" := "Periodos Processamento"."Data Fim Processamento";
            end;
            TabLinhaMovEmpregado.NATREM := TabRubSalarial.NATREM;
            TabLinhaMovEmpregado.Insert;
        end;
    end;
}

