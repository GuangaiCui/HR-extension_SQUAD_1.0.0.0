report 53037 "Processamento Vencimentos"
{
    // //-------------------------------------------------------
    //               Processamento de Vencimentos
    // //--------------------------------------------------------
    //     Este é o report principal para fazer o processamento dos
    //     vencimentos dos vários empregados.
    //     Está disponível a partir do Processamento Mensal.
    // //-------------------------------------------------------
    // 
    // IT001 - JTP - 2020.06.08 - Contemplar férias não gozadas de anos diferentes
    // IT002 - JTP - 2020.07.21 - Descontar subs. alimentação na admissão
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
                if "Periodos Processamento".Estado = 1 then
                    Error(Text0001);
                if "Periodos Processamento"."Tipo Processamento" <> 0 then
                    Error(Text0002);

                TabConfRH.Get;
            end;

            trigger OnPreDataItem()
            begin
                SetFilter("Cód. Processamento", PeriodoCode);
            end;
        }
        dataitem(Empregado; Empregado)
        {
            DataItemTableView = WHERE(Status = CONST(Active));
            RequestFilterFields = "No.", "Tipo Contribuinte";
            dataitem("Ausência Empregado"; "Ausência Empregado")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Employee No.", "From Date")
                WHERE("Com Perda de Remuneração" = CONST(true));

                trigger OnAfterGetRecord()
                begin
                    //Só apanhar as ausências cujo campo ("A partir da data" >= Data Inicio de Processamento
                    //e "A partir da data" <= Data Fim de Processamento) ou
                    //( "À data" >= Data Inicio de Processamento e À data" <= Data Fim de Processamento)
                    if (("Ausência Empregado"."From Date" >= FiltroDataInicioFalta) and
                      ("Ausência Empregado"."From Date" <= FiltroDataFimFalta)) or
                      (("Ausência Empregado"."To Date" >= FiltroDataInicioFalta) and
                      ("Ausência Empregado"."To Date" <= FiltroDataFimFalta)) then begin

                        //Processa a ausência por inteiro
                        if "Ausência Empregado"."To Date" <= FiltroDataFimFalta then begin
                            QtdAProcessar := -"Ausência Empregado"."Quantity (Base)";
                            QtdAProcessarRecVen := -"Ausência Empregado".Quantity;
                            "Ausência Empregado"."Quantidade Pendente" := 0;
                            "Ausência Empregado"."Ausência Bloqueada" := true;
                            if "Ausência Empregado"."Com Perda Sub. Alimentação" then
                                VarAbateSubAlimentacao := VarAbateSubAlimentacao + "Ausência Empregado"."Qtd. Perda Sub. Alimentação";
                        end;
                        //Processa parte da ausência
                        if "Ausência Empregado"."To Date" > FiltroDataFimFalta then begin
                            QtdAProcessar := Round("Ausência Empregado"."Quantity (Base)" /
                            (("Ausência Empregado"."From Date" - "Ausência Empregado"."To Date") + 1) *
                            ((FiltroDataFimFalta - "Ausência Empregado"."From Date") + 1), 0.01);
                            QtdAProcessarRecVen := Round("Ausência Empregado".Quantity /
                            (("Ausência Empregado"."From Date" - "Ausência Empregado"."To Date") + 1) *
                            ((FiltroDataFimFalta - "Ausência Empregado"."From Date") + 1), 0.01);
                            "Ausência Empregado"."Quantidade Pendente" := "Ausência Empregado"."Quantity (Base)" - QtdAProcessar;
                            if "Ausência Empregado"."Com Perda Sub. Alimentação" then
                                VarAbateSubAlimentacao := VarAbateSubAlimentacao + Abs(QtdAProcessar);
                        end;

                        if TabRubricaSalarial.Get("Ausência Empregado"."Payroll Item Code") then begin
                            //Actualizar a tabela ausencias
                            "Ausência Empregado".Modify;
                            //Actualizar o Vencimento Base, Valor Dia e Valor Hora
                            ValorVencimentoBase := FuncoesRH.CalcularVencimentoBaseFaltas
                                                  ("Periodos Processamento"."Data Inicio Processamento", Empregado);
                            Empregado."Valor Vencimento Base" := ValorVencimentoBase;
                            Empregado."Valor Dia" := FuncoesRH.CalcularValorDia(ValorVencimentoBase, Empregado);
                            Empregado."Valor Hora" := FuncoesRH.CalcularValorHora(ValorVencimentoBase, Empregado);
                            Empregado.Modify;

                            TempRubricaEmpregado.Init;
                            TempRubricaEmpregado."Employee No." := Empregado."No.";
                            NLinha := NLinha + 10000;
                            TempRubricaEmpregado."Line No." := NLinha;
                            TempRubricaEmpregado."Cód. Rúbrica Salarial" := "Ausência Empregado"."Payroll Item Code";
                            TempRubricaEmpregado."Payroll Item Type" := TabRubricaSalarial."Payroll Item Type";
                            TempRubricaEmpregado."Payroll Item Description" := TabRubricaSalarial.Descrição;
                            TempRubricaEmpregado."Debit Acc. No." := TabRubricaSalarial."Debit Acc. No.";
                            TempRubricaEmpregado."Credit Acc. No." := TabRubricaSalarial."Credit Acc. No.";
                            TempRubricaEmpregado.Validate(TempRubricaEmpregado.Quantity, QtdAProcessar);
                            TempRubricaEmpregado."Quatidade Recibo Vencimentos" := QtdAProcessarRecVen;
                            TempRubricaEmpregado."Unit of Measure" := "Ausência Empregado"."Unit of Measure Code";
                            //Ausencias registadas em Dia --> valor unitário da ausência = Valor Dia Empregado da ficha do Empregado
                            //Ausencias registadas em Hora --> valor unitário da ausência = Valor hora Empregado da ficha do Empregado
                            if "Ausência Empregado"."Novo Valor Ausencia" = 0 then begin
                                if UnidMedidaRH.Get("Ausência Empregado"."Unit of Measure Code") then begin
                                    if UnidMedidaRH."Internal Designation" = UnidMedidaRH."Internal Designation"::Day then begin
                                        TempRubricaEmpregado.Validate(TempRubricaEmpregado."Unit Value", Empregado."Valor Dia");
                                        TempRubricaEmpregado."Total Amount" := Round(Empregado."Valor Dia" * QtdAProcessarRecVen, 0.01);
                                    end;
                                    if UnidMedidaRH."Internal Designation" = UnidMedidaRH."Internal Designation"::Hour then begin
                                        TempRubricaEmpregado.Validate(TempRubricaEmpregado."Unit Value", Empregado."Valor Hora");
                                        TempRubricaEmpregado."Total Amount" := Round(Empregado."Valor Hora" * QtdAProcessarRecVen, 0.01);
                                    end;
                                end else
                                    Error(Text0030, "Ausência Empregado"."From Date", Empregado."No.");
                            end else begin
                                //para colocar um valor ausencia diferente. Ex: refere-se a mes anterior
                                TempRubricaEmpregado."Total Amount" := -"Ausência Empregado"."Novo Valor Ausencia";
                            end;
                            TempRubricaEmpregado.Sort := 100;
                            TempRubricaEmpregado."Cód. Situação" := TabRubricaSalarial."Cód. Situação";
                            TempRubricaEmpregado."Cód. Movimento" := TabRubricaSalarial."Cód. Movimento";
                            TempRubricaEmpregado."Data Efeito" := "Periodos Processamento"."Data Fim Processamento";
                            TempRubricaEmpregado."Data a que se refere o mov" := "Ausência Empregado"."From Date";
                            TempRubricaEmpregado.Table := DATABASE::"Ausência Empregado";
                            TempRubricaEmpregado.NLinhaRubSalEmp := "Ausência Empregado"."Entry No.";
                            TempRubricaEmpregado.Insert;
                        end;
                    end;
                end;

                trigger OnPostDataItem()
                begin
                    //Actualizar o Vencimento Base, Valor Dia e Valor Hora
                    ValorVencimentoBase := FuncoesRH.CalcularVencimentoBase("Periodos Processamento"."Data Registo", Empregado);
                    Empregado."Valor Vencimento Base" := ValorVencimentoBase;
                    Empregado."Valor Dia" := FuncoesRH.CalcularValorDia(ValorVencimentoBase, Empregado);
                    Empregado."Valor Hora" := FuncoesRH.CalcularValorHora(ValorVencimentoBase, Empregado);
                    Empregado.Modify;
                end;
            }
            dataitem("Horas Extra Empregado"; "Horas Extra Empregado")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.");

                trigger OnAfterGetRecord()
                begin
                    if ("Horas Extra Empregado".Data >= "Periodos Processamento"."Data Inicio Processamento") and
                      ("Horas Extra Empregado".Data <= "Periodos Processamento"."Data Fim Processamento") then begin

                        if TabRubricaSalarial.Get("Horas Extra Empregado"."Payroll Item Code") then begin
                            //Actualizar a tabela Hora Extra
                            "Horas Extra Empregado"."Hora Extra Bloqueada" := true;
                            "Horas Extra Empregado".Modify;
                            //Actualizar o Vencimento Base, Valor Hora
                            ValorVencimentoBase := FuncoesRH.CalcularVencimentoBase("Periodos Processamento"."Data Inicio Processamento", Empregado);
                            Empregado."Valor Vencimento Base" := ValorVencimentoBase;
                            Empregado."Valor Hora" := FuncoesRH.CalcularValorHora(ValorVencimentoBase, Empregado);
                            Empregado.Modify;
                            TabConfRH.Get;
                            TempRubricaEmpregado.Init;
                            TempRubricaEmpregado."Employee No." := Empregado."No.";
                            NLinha := NLinha + 10000;
                            TempRubricaEmpregado."Line No." := NLinha;
                            TempRubricaEmpregado."Cód. Rúbrica Salarial" := "Horas Extra Empregado"."Payroll Item Code";
                            TempRubricaEmpregado."Payroll Item Type" := TabRubricaSalarial."Payroll Item Type";
                            TempRubricaEmpregado."Payroll Item Description" := TabRubricaSalarial.Descrição;
                            TempRubricaEmpregado."Debit Acc. No." := TabRubricaSalarial."Debit Acc. No.";
                            TempRubricaEmpregado."Credit Acc. No." := TabRubricaSalarial."Credit Acc. No.";
                            TempRubricaEmpregado.Validate(TempRubricaEmpregado.Quantity, "Horas Extra Empregado".Quantity);
                            if "Horas Extra Empregado"."Unit Value" = 0.0 then
                                TempRubricaEmpregado.Validate(TempRubricaEmpregado."Unit Value", Round(Empregado."Valor Hora" *
                                "Horas Extra Empregado".Factor, 0.01))
                            else
                                TempRubricaEmpregado.Validate(TempRubricaEmpregado."Unit Value", Round("Horas Extra Empregado"."Unit Value" *
                                "Horas Extra Empregado".Factor, 0.01));

                            TempRubricaEmpregado.Sort := 200;
                            //preencher os campos da CGA
                            TempRubricaEmpregado."Cód. Situação" := TabRubricaSalarial."Cód. Situação";
                            TempRubricaEmpregado."Cód. Movimento" := TabRubricaSalarial."Cód. Movimento";
                            TempRubricaEmpregado."Data Efeito" := "Periodos Processamento"."Data Fim Processamento";
                            //preencher os campos que vão ligar à Analitica
                            TempRubricaEmpregado.Table := DATABASE::"Horas Extra Empregado";
                            TempRubricaEmpregado.NLinhaRubSalEmp := "Horas Extra Empregado"."Entry No.";
                            //preencher as dimensões das horas extra
                            TempRubricaEmpregado."Global Dimension 1 Code" := "Horas Extra Empregado"."Global Dimension 1 Code";
                            TempRubricaEmpregado."Global Dimension 2 Code" := "Horas Extra Empregado"."Global Dimension 2 Code";
                            TempRubricaEmpregado.Insert;
                        end;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    //Só apanhar as Horas Extra cujo campo ("data" >= Data Inicio de Processamento
                    //e Data <= Data Fim de Processamento)
                end;
            }
            dataitem("Abonos - Descontos Extra"; "Abonos - Descontos Extra")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.");

                trigger OnAfterGetRecord()
                var
                    l_Rubrica: Record "Payroll Item";
                    l_ValorVencimentoBase: Decimal;
                begin
                    if ("Abonos - Descontos Extra".Date >= "Periodos Processamento"."Data Inicio Processamento") and
                      ("Abonos - Descontos Extra".Date <= "Periodos Processamento"."Data Fim Processamento") then begin

                        if TabRubricaSalarial.Get("Abonos - Descontos Extra"."Payroll Item Code") then begin
                            //Actualizar a tabela Hora Extra
                            "Abonos - Descontos Extra"."Earning - Blocked Deduction" := true;
                            "Abonos - Descontos Extra".Modify;

                            VarAbateSubAlimentacao := VarAbateSubAlimentacao + "Abonos - Descontos Extra"."Qty. Food Subsidy Loss";

                            //Fecho de contas
                            //se o fecho de contas tem uma rubrica de Proporcional de SF então o IRS de SF tem de ser processado
                            if TabRubricaSalarial."Genero Rubrica Fecho" = TabRubricaSalarial."Genero Rubrica Fecho"::"Proporcional Sub. Férias" then
                                FlagSF := true;

                            //Se tiver só sub. férias tb tem de mudar
                            if TabRubricaSalarial."Genero Rubrica Fecho" = TabRubricaSalarial."Genero Rubrica Fecho"::"Sub. Férias Ano Anterior" then
                                FlagSF := true;

                            //Se o fecho de contas tem uma rubrica de Proporcional de SN então o IRS de SN tem de ser processado
                            if TabRubricaSalarial."Genero Rubrica Fecho" =
                              TabRubricaSalarial."Genero Rubrica Fecho"::"Proporcional Sub. Natal" then
                                FlagSN := true;

                            TempRubricaEmpregado.Init;
                            TempRubricaEmpregado."Employee No." := Empregado."No.";
                            NLinha := NLinha + 10000;
                            TempRubricaEmpregado."Line No." := NLinha;
                            TempRubricaEmpregado."Cód. Rúbrica Salarial" := "Abonos - Descontos Extra"."Payroll Item Code";
                            TempRubricaEmpregado."Payroll Item Type" := "Abonos - Descontos Extra"."Payroll Item Type";
                            TempRubricaEmpregado."Payroll Item Description" := "Abonos - Descontos Extra"."Payroll Item Description";
                            TempRubricaEmpregado."Debit Acc. No." := TabRubricaSalarial."Debit Acc. No.";
                            TempRubricaEmpregado."Credit Acc. No." := TabRubricaSalarial."Credit Acc. No.";
                            TempRubricaEmpregado.Quantity := "Abonos - Descontos Extra".Quantity;
                            TempRubricaEmpregado."Unit of Measure" := "Abonos - Descontos Extra"."Unit of Measure";
                            if ("Abonos - Descontos Extra"."Unit Value" = 0) and ("Abonos - Descontos Extra"."Total Amount" = 0) and
                                 (TabRubricaSalarial."Sobretaxa em Sede de IRS" = false) then begin
                                if UnidMedidaRH.Get("Abonos - Descontos Extra"."Unit of Measure") then begin
                                    if (l_Rubrica.Get("Abonos - Descontos Extra"."Payroll Item Code")) and
                                       (l_Rubrica.Genero = l_Rubrica.Genero::"Admissão-Demissão") then begin
                                        l_ValorVencimentoBase := FuncoesRH.CalcularVencimentoBaseFaltas("Periodos Processamento"."Data Inicio Processamento", Empregado);
                                        "Abonos - Descontos Extra".Validate("Abonos - Descontos Extra"."Unit Value", FuncoesRH.CalcularValorDia(l_ValorVencimentoBase, Empregado));
                                    end else begin
                                        if UnidMedidaRH."Internal Designation" = UnidMedidaRH."Internal Designation"::Day then
                                            "Abonos - Descontos Extra".Validate("Abonos - Descontos Extra"."Unit Value", Empregado."Valor Dia");
                                        if UnidMedidaRH."Internal Designation" = UnidMedidaRH."Internal Designation"::Hour then
                                            "Abonos - Descontos Extra".Validate("Abonos - Descontos Extra"."Unit Value", Empregado."Valor Hora");
                                    end;
                                end else
                                    Error(Text0033);
                            end;

                            TempRubricaEmpregado."Unit Value" := "Abonos - Descontos Extra"."Unit Value";
                            if "Abonos - Descontos Extra"."Payroll Item Type" = "Abonos - Descontos Extra"."Payroll Item Type"::Abono then
                                TempRubricaEmpregado."Total Amount" := Abs(Round("Abonos - Descontos Extra"."Total Amount", 0.01))
                            else
                                TempRubricaEmpregado."Total Amount" := -Round("Abonos - Descontos Extra"."Total Amount", 0.01);
                            TempRubricaEmpregado.Sort := 300;
                            TempRubricaEmpregado."Cód. Situação" := TabRubricaSalarial."Cód. Situação";
                            TempRubricaEmpregado."Cód. Movimento" := TabRubricaSalarial."Cód. Movimento";
                            TempRubricaEmpregado."Data Efeito" := "Periodos Processamento"."Data Fim Processamento";
                            TempRubricaEmpregado.Table := DATABASE::"Abonos - Descontos Extra";
                            TempRubricaEmpregado.NLinhaRubSalEmp := "Abonos - Descontos Extra"."Entry No.";
                            TempRubricaEmpregado."Global Dimension 1 Code" := "Abonos - Descontos Extra"."Global Dimension 1 Code";
                            TempRubricaEmpregado."Global Dimension 2 Code" := "Abonos - Descontos Extra"."Global Dimension 2 Code";
                            TempRubricaEmpregado."Garnishmen No." := "Abonos - Descontos Extra"."Garnishment No.";
                            //IF (TabRubricaSalarial.NATREM = TabRubricaSalarial.NATREM::"Cód. Sub. Férias") OR
                            //  (TabRubricaSalarial.NATREM = TabRubricaSalarial.NATREM::"Cód. Sub. Natal") THEN
                            //JTP
                            //IT001 - JTP - 2020.06.08
                            //TempRubricaEmpregado."Data a que se refere o mov" := "Periodos Processamento"."Data Registo";
                            TempRubricaEmpregado."Data a que se refere o mov" := "Abonos - Descontos Extra"."Reference Date";
                            TempRubricaEmpregado.Insert;
                        end;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    //Só apanhar as Abonose descontos cujo campo ("data" >= Data Inicio de Processamento
                    //e Data <= Data Fim de Processamento)
                end;
            }
            dataitem(Abonos; "Rubrica Salarial Empregado")
            {
                DataItemLink = "Employee No." = FIELD("No."),
                                "Data Início" = FIELD("Data Filtro Inicio"), "Data Fim" = FIELD("Data Filtro Fim");
                DataItemTableView = SORTING("Employee No.", sort, "Cód. Rúbrica Salarial")
                                    WHERE("Payroll Item Type" = CONST(Abono));

                trigger OnAfterGetRecord()
                var
                    auxpercentagem: Decimal;
                    TabHisAusencias: Record "Histórico Ausências";
                    TabAusencias: Record "Ausência Empregado";
                    TabMotivoAus: Record "Absence Reason";
                    TotalDiasFalta: Decimal;
                    l_RubSalEmp: Record "Rubrica Salarial Empregado";
                    flag: Boolean;
                begin
                    //*******************************************************************************
                    //Pega em cada Abono parametrizado na tabela Rubrica salarial empregado
                    //e envia para a tabela temporária TempRubricaEmpregado já com o valor calculado
                    //*******************************************************************************

                    VarAbateSubAlimentacao := GuardaAbateSubAlim;

                    TabRubricaSalarial.Reset;
                    TabRubricaSalarial.SetRange(TabRubricaSalarial.Código, Abonos."Cód. Rúbrica Salarial");
                    if TabRubricaSalarial.Find('-') then begin
                        //SubFerias
                        //*********
                        //Este if é para mudar o mês de processamento de férias caso o empregado tenha um mês definido na sua ficha
                        if (TabRubricaSalarial."Mês Início Periocidade" <> 0) and (Empregado."Mês Proc. Sub. Férias" <> 0) and
                           (TabRubricaSalarial.NATREM = TabRubricaSalarial.NATREM::"Cód. Sub. Férias") then
                            TabRubricaSalarial."Mês Início Periocidade" := Empregado."Mês Proc. Sub. Férias";

                        //SUB Férias em Duodécimos
                        //*************************
                        if TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::DuoSF then
                            TabRubricaSalarial."Mês Início Periocidade" := Date2DMY("Periodos Processamento"."Data Registo", 2);

                        //Proporcionais Sub. Férias
                        //*************************
                        //Se nas  configurações de RH estiver parametrizado o presente mês como sendo um mês de acerto, então
                        //tem de actualizar o campo "Mês Início Periodicidade". Salvo se já tiver pago a totalidade, nesse caso já n faz acerto
                        if TabRubricaSalarial.NATREM = TabRubricaSalarial.NATREM::"Cód. Sub. Férias" then begin
                            if (TabConfRH."Mês Acerto Sub. Férias" = Date2DMY("Periodos Processamento"."Data Fim Processamento", 2)) and
                               (Empregado."Última data Proc. Sub. Férias" < "Periodos Processamento"."Data Fim Processamento") then
                                TabRubricaSalarial."Mês Início Periocidade" := Date2DMY("Periodos Processamento"."Data Fim Processamento", 2)
                        end;

                        //Fecho Contas
                        //************
                        //Se o empregado for sair da empresa (Processamento de Terminação -> Data Fim <>0D), e esse mês é mês
                        //de processamento de sub. Férias ou Natal, não pode deixar processar, pois estes abonos já estão no fecho
                        if (TabRubricaSalarial."Mês Início Periocidade" =
                                Date2DMY("Periodos Processamento"."Data Inicio Processamento", 2)) and
                           (Empregado."End Date" <> 0D) and
                           ((TabRubricaSalarial.NATREM = TabRubricaSalarial.NATREM::"Cód. Sub. Natal") or
                           (TabRubricaSalarial.NATREM = TabRubricaSalarial.NATREM::"Cód. Sub. Férias")) then
                            TabRubricaSalarial."Mês Início Periocidade" := 0;

                        if FuncoesRH.GetPeriodicidade(TabRubricaSalarial, "Periodos Processamento"."Data Inicio Processamento") then begin
                            TempRubricaEmpregado.Init;
                            TempRubricaEmpregado := Abonos;
                            NLinha := NLinha + 10000;
                            TempRubricaEmpregado."Line No." := NLinha;
                            TempRubricaEmpregado.NLinhaRubSalEmp := Abonos."Line No.";
                            TempRubricaEmpregado.Table := DATABASE::"Rubrica Salarial Empregado";

                            AuxTabRubricaSalarial.Reset;
                            AuxTabRubricaSalarial.SetRange(AuxTabRubricaSalarial.Genero, AuxTabRubricaSalarial.Genero::CGA);
                            if AuxTabRubricaSalarial.Find('-') then begin

                                AuxTabRubricaEmpregado.Reset;
                                AuxTabRubricaEmpregado.SetRange(AuxTabRubricaEmpregado."Employee No.", Empregado."No.");
                                AuxTabRubricaEmpregado.SetRange(AuxTabRubricaEmpregado."Cód. Rúbrica Salarial", AuxTabRubricaSalarial.Código);
                                if AuxTabRubricaEmpregado.FindFirst then begin
                                    AuxTabRubricaSalLinhas.Reset;
                                    AuxTabRubricaSalLinhas.SetRange(AuxTabRubricaSalLinhas."Payroll Item Code", AuxTabRubricaSalarial.Código);
                                    AuxTabRubricaSalLinhas.SetRange(AuxTabRubricaSalLinhas."Cód. Rubrica Filha", Abonos."Cód. Rúbrica Salarial");
                                    if AuxTabRubricaSalLinhas.FindFirst then begin
                                        TempRubricaEmpregado."Cód. Situação" := Abonos."Cód. Situação";
                                        TempRubricaEmpregado."Cód. Movimento" := Abonos."Cód. Movimento";
                                        TempRubricaEmpregado."Data Efeito" := Abonos."Data Efeito";
                                    end;
                                end;
                            end;

                            //Abater o Sub. Alimentação por causa das faltas
                            if TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::"Sub. Alimentação" then begin
                                //Abater o sub de Alimentação nos casos de faltas não remuneradas
                                TabAusenciasNRemun.Reset;
                                TabAusenciasNRemun.SetRange(TabAusenciasNRemun."Employee No.", Empregado."No.");
                                TabAusenciasNRemun.SetFilter(TabAusenciasNRemun."Com Perda de Remuneração", '%1', false);
                                TabAusenciasNRemun.SetFilter(TabAusenciasNRemun."Com Perda Sub. Alimentação", '%1', true);
                                if TabAusenciasNRemun.FindSet then begin
                                    repeat
                                        if ((TabAusenciasNRemun."From Date" >= FiltroDataInicioFalta) and
                                           (TabAusenciasNRemun."From Date" <= FiltroDataFimFalta)) or
                                           ((TabAusenciasNRemun."To Date" >= FiltroDataInicioFalta) and
                                           (TabAusenciasNRemun."To Date" <= FiltroDataFimFalta)) then begin
                                            VarAbateSubAlimentacao := VarAbateSubAlimentacao + TabAusenciasNRemun."Qtd. Perda Sub. Alimentação";
                                        end;
                                    until TabAusenciasNRemun.Next = 0;
                                end;


                                //Abater o Sub. Alimentação no mes do pagamento Sub Férias e no Mês de Acerto Sub. Férias
                                if Empregado.Intern = false then begin
                                    if (Date2DMY("Periodos Processamento"."Data Registo", 2) = TabConfRH."Mês Abate Sub. Alimentação") then begin

                                        //O sub. alimentação tem de ser abatido consoante o numero de dias de sub. ferias pago
                                        //logo as regras são as mesmas que o calculo do sub. ferias
                                        // 2 dias para quem trabalha 30 dias no mês
                                        // 1 dia para quem trabalha entre 29 e 15 dias
                                        // 0 dias para quem trabalha menos de 15 dias.

                                        //Saber qts dias trabalha no mes de admissão
                                        DiasTrabMesAdmissao := CalcDate('CM', Empregado."Employment Date") - Empregado."Employment Date" + 1;

                                        if DiasTrabMesAdmissao >= 30 then
                                            DiasDesc := 2 * (Date2DMY("Periodos Processamento"."Data Registo", 2) - Date2DMY(Empregado."Employment Date", 2) + 1)
                                        else
                                            if DiasTrabMesAdmissao < 15 then
                                                DiasDesc := 2 * (Date2DMY("Periodos Processamento"."Data Registo", 2) - Date2DMY(Empregado."Employment Date", 2) + 1) - 2
                                            else
                                                DiasDesc := 2 * (Date2DMY("Periodos Processamento"."Data Registo", 2) - Date2DMY(Empregado."Employment Date", 2) + 1) - 1;

                                        if DiasDesc < 0 then DiasDesc := 0;
                                        if DiasDesc > 10 then DiasDesc := 10;

                                        if Date2DMY(Empregado."Employment Date", 3) < Date2DMY("Periodos Processamento"."Data Registo", 3) then
                                            VarAbateSubAlimentacao := VarAbateSubAlimentacao + 22
                                        else
                                            VarAbateSubAlimentacao := VarAbateSubAlimentacao + DiasDesc;
                                    end;

                                    if Date2DMY("Periodos Processamento"."Data Registo", 2) = TabConfRH."Mês Acerto Sub. Férias" then begin
                                        if Empregado."Última data Proc. Sub. Férias" <> 0D then
                                            VarAbateSubAlimentacao := VarAbateSubAlimentacao + (2 * (Date2DMY("Periodos Processamento"."Data Registo", 2) -
                                                       Date2DMY(Empregado."Última data Proc. Sub. Férias", 2)))
                                        else begin
                                            //O sub. alimentação tem de ser abatido consoante o numero de dias de sub. ferias pago
                                            //logo as regras são as mesmas que o calculo do sub. ferias
                                            DiasTrabMesAdmissao := CalcDate('<CM>', Empregado."Employment Date") - Empregado."Employment Date" + 1;

                                            if DiasTrabMesAdmissao >= 30 then
                                                DiasDesc := 2 * (Date2DMY("Periodos Processamento"."Data Registo", 2) - Date2DMY(Empregado."Employment Date", 2) + 1)
                                            else
                                                if DiasTrabMesAdmissao < 15 then
                                                    DiasDesc := 2 * (Date2DMY("Periodos Processamento"."Data Registo", 2) - Date2DMY(Empregado."Employment Date", 2) + 1) - 2
                                                else
                                                    DiasDesc := 2 * (Date2DMY("Periodos Processamento"."Data Registo", 2) - Date2DMY(Empregado."Employment Date", 2) + 1) - 1;

                                            if DiasDesc < 0 then DiasDesc := 0;
                                            VarAbateSubAlimentacao := VarAbateSubAlimentacao + DiasDesc;
                                        end;
                                    end;
                                end;


                                //Usar a tabela feriados para o cálculo do Sub. Alimentação
                                if TabConfRH."Use Holidays to Calc Lunch Sub" = true then begin
                                    TempRubricaEmpregado.Validate(TempRubricaEmpregado.Quantity, FuncoesRH.CalcularDiasUteisMes(Empregado.Estabelecimento,
                                                                  "Periodos Processamento"."Data Inicio Processamento",
                                                                  "Periodos Processamento"."Data Fim Processamento") - VarAbateSubAlimentacao);
                                end else
                                    TempRubricaEmpregado.Validate(TempRubricaEmpregado.Quantity, TempRubricaEmpregado.Quantity - VarAbateSubAlimentacao);

                                //se faltou o mês todo, abater todo o Sub. de alimentação
                                if TempRubricaEmpregado.Quantity < 0 then
                                    TempRubricaEmpregado.Validate(TempRubricaEmpregado.Quantity, 0);
                            end;

                            //Ver se há rubricas salariais que dependam desta
                            RubricaSalariaLinhas.Reset;
                            RubricaSalariaLinhas.SetRange(RubricaSalariaLinhas."Payroll Item Code", Abonos."Cód. Rúbrica Salarial");
                            if RubricaSalariaLinhas.FindSet then begin
                                repeat
                                    RubricaSalaEmpregado.Reset;
                                    RubricaSalaEmpregado.SetRange(RubricaSalaEmpregado."Employee No.", Abonos."Employee No.");
                                    RubricaSalaEmpregado.SetRange(RubricaSalaEmpregado."Cód. Rúbrica Salarial", RubricaSalariaLinhas."Cód. Rubrica Filha");
                                    RubricaSalaEmpregado.SetFilter(RubricaSalaEmpregado."Data Início", '<=%1', "Periodos Processamento"."Data Fim Processamento");
                                    RubricaSalaEmpregado.SetFilter(RubricaSalaEmpregado."Data Fim", '>=%1|=%2',
                                                                   "Periodos Processamento"."Data Inicio Processamento", 0D);

                                    if RubricaSalaEmpregado.FindSet then begin
                                        repeat
                                            // RubricaSalariaLinhas2.Reset;
                                            // RubricaSalariaLinhas2.SetRange(RubricaSalariaLinhas2."Payroll Item Code", RubricaSalariaLinhas."Cód. Rubrica Filha");
                                            // if RubricaSalariaLinhas2.Find('-') then begin
                                            //     repeat
                                            //         RubricaSalaEmpregado2.Reset;
                                            //         RubricaSalaEmpregado2.SetRange(RubricaSalaEmpregado2."Employee No.", Abonos."Employee No.");
                                            //         RubricaSalaEmpregado2.SetRange(RubricaSalaEmpregado2."Cód. Rúbrica Salarial",
                                            //           RubricaSalariaLinhas2."Cód. Rubrica Filha");
                                            //         RubricaSalaEmpregado2.SetFilter(RubricaSalaEmpregado2."Data Início", '<=%1',
                                            //           "Periodos Processamento"."Data Fim Processamento");
                                            //         RubricaSalaEmpregado2.SetFilter(RubricaSalaEmpregado2."Data Fim", '>=%1|=%2',
                                            //           "Periodos Processamento"."Data Inicio Processamento", 0D);

                                            //ALERT: RubricaSalaEmpregado2 para RubricaSalaEmpregado
                                            //O código percorria os "filhos dos filhos". Comentado para referência. ^^^
                                            if RubricaSalaEmpregado.FindFirst then begin
                                                //se for iva, tem de ir buscar a percentagem à ficha do empregado e não à filha
                                                TabRubricaSalAux.Reset;
                                                if TabRubricaSalAux.Get(RubricaSalariaLinhas."Payroll Item Code") then;
                                                if TabRubricaSalAux.Genero <> TabRubricaSalAux.Genero::IVA then begin
                                                    TempRubricaEmpregado."Total Amount" := Round(TempRubricaEmpregado."Total Amount" +
                                                                        ((RubricaSalaEmpregado."Total Amount" * RubricaSalariaLinhas.Percentagem / 100)), 0.01);

                                                end else begin
                                                    //****************IVA*****************************
                                                    TempRubricaEmpregado."Total Amount" := Round(TempRubricaEmpregado."Total Amount" +
                                                                                          ((RubricaSalaEmpregado."Total Amount" * Empregado."IVA %" / 100)), 0.01);
                                                    TempRubricaEmpregado.Quantity := Empregado."IVA %";
                                                end;
                                                //end;
                                                //until RubricaSalariaLinhas2.Next = 0;
                                            end else begin
                                                //se for iva, tem de ir buscar a percentagem à ficha do empregado e não à filha
                                                TabRubricaSalAux.Reset;
                                                if TabRubricaSalAux.Get(RubricaSalariaLinhas."Payroll Item Code") then;
                                                if TabRubricaSalAux.Genero <> TabRubricaSalAux.Genero::IVA then begin


                                                    //Proporcionais SubFerias e Natal
                                                    //*********************************************************
                                                    Clear(DataFimProcSubFerias);
                                                    if ((TabRubricaSalarial.NATREM = TabRubricaSalarial.NATREM::"Cód. Sub. Férias") or
                                                       (TabRubricaSalarial.NATREM = TabRubricaSalarial.NATREM::"Cód. Sub. Natal")) and
                                                       (TabRubricaSalarial.Genero <> TabRubricaSalarial.Genero::DuoSF) and
                                                       (TabRubricaSalarial.Genero <> TabRubricaSalarial.Genero::DuoSN)
                                                       then begin
                                                        //Férias
                                                        //******************
                                                        if (TabRubricaSalarial.NATREM = TabRubricaSalarial.NATREM::"Cód. Sub. Férias") then begin
                                                            //Se o empregado entrou no mesmo ano, paga o proporcional desde que entou até esse mês,
                                                            //ou desde o ultimo acerto até esse mês.
                                                            //Se o empregado entrou no ano transacto, não faz nada, ou seja, paga 100%

                                                            NumDias := 22;

                                                            if Date2DMY(Empregado."Employment Date", 3) = Date2DMY("Periodos Processamento"."Data Registo", 3) then begin
                                                                //Processamento Sub. Férias
                                                                // 2 dias para quem trabalha 30 dias no mês
                                                                // 1 dia para quem trabalha entre 29 e 15 dias
                                                                // 0 dias para quem trabalha menos de 15 dias.

                                                                if Empregado."Última data Proc. Sub. Férias" <> 0D then
                                                                    NumDias := 2 * (Date2DMY("Periodos Processamento"."Data Fim Processamento", 2) -
                                                                               Date2DMY(Empregado."Última data Proc. Sub. Férias", 2))
                                                                else begin
                                                                    //Saber qts dias trabalha no mes de admissão
                                                                    DiasTrabMesAdmissao := 0;
                                                                    DiasTrabMesAdmissao := CalcDate('<CM>', Empregado."Employment Date") - Empregado."Employment Date" + 1;

                                                                    if DiasTrabMesAdmissao >= 30 then
                                                                        NumDias := 2 * (Date2DMY("Periodos Processamento"."Data Registo", 2) -
                                                                                      Date2DMY(Empregado."Employment Date", 2) + 1)
                                                                    else
                                                                        if DiasTrabMesAdmissao < 15 then
                                                                            NumDias := 2 * (Date2DMY("Periodos Processamento"."Data Registo", 2) -
                                                                                          Date2DMY(Empregado."Employment Date", 2))
                                                                        else
                                                                            NumDias := 2 * (Date2DMY("Periodos Processamento"."Data Registo", 2) -
                                                                                          Date2DMY(Empregado."Employment Date", 2)) + 1;
                                                                end;
                                                            end;
                                                            if NumDias < 0 then NumDias := 0;


                                                            //ABATER AO SUB Férias AS FALTAS SUPERIORES A 1 MES
                                                            //------------------------------------------------
                                                            if TabConfRH."Limite dias falta abate SN/F" <> 0 then begin
                                                                Clear(TotalDiasFalta);
                                                                UnidMedidaRH.Reset;
                                                                UnidMedidaRH.SetRange(UnidMedidaRH."Internal Designation", UnidMedidaRH."Internal Designation"::Day);
                                                                if UnidMedidaRH.Find('-') then begin
                                                                    TabAusencias.Reset;
                                                                    TabAusencias.SetCurrentKey("Employee No.", "From Date");
                                                                    TabAusencias.SetRange(TabAusencias."Employee No.", Empregado."No.");
                                                                    TabAusencias.SetRange(TabAusencias."From Date",
                                                                      DMY2Date(1, 1, Date2DMY("Periodos Processamento"."Data Fim Processamento", 3)),
                                                                      DMY2Date(31, 12, Date2DMY("Periodos Processamento"."Data Fim Processamento", 3)));
                                                                    TabAusencias.SetRange(TabAusencias."Unit of Measure Code", UnidMedidaRH.Code);
                                                                    if TabAusencias.Find('-') then begin
                                                                        repeat
                                                                            TabMotivoAus.Reset;
                                                                            TabMotivoAus.SetRange(TabMotivoAus."Holiday Subsidy Influence", true);
                                                                            TabMotivoAus.SetRange(TabMotivoAus.Code, TabAusencias."Cause of Absence Code");
                                                                            if TabMotivoAus.Find('-') then
                                                                                TotalDiasFalta := TotalDiasFalta + TabAusencias.Quantity

                                                                        until TabAusencias.Next = 0;
                                                                        if TotalDiasFalta > TabConfRH."Limite dias falta abate SN/F" then
                                                                            NumDias := NumDias - (Round(TotalDiasFalta / TabConfRH."Limite dias falta abate SN/F", 1, '<') * 2);
                                                                    end;
                                                                end;
                                                            end;

                                                            //Os acertos do Sub. Férias tem de ser pelo valor do Venc. Base a 31 de julho
                                                            if Date2DMY("Periodos Processamento"."Data Registo", 2) = TabConfRH."Mês Acerto Sub. Férias" then begin
                                                                l_RubSalEmp.Reset;
                                                                l_RubSalEmp.SetRange(l_RubSalEmp."Employee No.", Abonos."Employee No.");
                                                                l_RubSalEmp.SetRange(l_RubSalEmp."Cód. Rúbrica Salarial", RubricaSalariaLinhas."Cód. Rubrica Filha");
                                                                l_RubSalEmp.SetFilter(l_RubSalEmp."Data Início", '<=%1',
                                                                            DMY2Date(31, 7, Date2DWY("Periodos Processamento"."Data Fim Processamento", 3)));
                                                                l_RubSalEmp.SetFilter(l_RubSalEmp."Data Fim", '>=%1|=%2',
                                                                            DMY2Date(31, 7, Date2DWY("Periodos Processamento"."Data Inicio Processamento", 3)), 0D);
                                                                if l_RubSalEmp.FindFirst then
                                                                    RubricaSalaEmpregado."Total Amount" := l_RubSalEmp."Total Amount" * NumDias / 22;
                                                            end else
                                                                RubricaSalaEmpregado."Total Amount" := RubricaSalaEmpregado."Total Amount" * NumDias / 22;
                                                            TempRubricaEmpregado.Quantity := NumDias;
                                                        end;

                                                        //Natal
                                                        //**********************
                                                        if (TabRubricaSalarial.NATREM = TabRubricaSalarial.NATREM::"Cód. Sub. Natal") then begin
                                                            //Se o empregado entrou no mesmo ano, paga o proporcional desde que entrou até ao fim ano
                                                            //Se o empregado entrou no ano transacto, não faz nada, ou seja, paga 100%

                                                            //NumDias := 30;
                                                            MesesTrabalhados := 12;

                                                            //Entrou no presente Ano vai ver os meses completos + dias trabalhos
                                                            if Date2DMY(Empregado."Employment Date", 3) =
                                                               Date2DMY("Periodos Processamento"."Data Registo", 3) then begin
                                                                // NumDias := 2.5*(DATE2DMY("Periodos Processamento"."Data Registo",2) -
                                                                //                 DATE2DMY(Empregado."Employment Date",2) +1)
                                                                MesesTrabalhados := Round(12 - Date2DMY(Empregado."Employment Date", 2) +
                                                                          (30 - Date2DMY(Empregado."Employment Date", 1) + 1) / 30, 0.01);

                                                            end;

                                                            //ABATER AO SUB Natal AS FALTAS SUPERIORES A 1 MES
                                                            //------------------------------------------------
                                                            if TabConfRH."Limite dias falta abate SN/F" <> 0 then begin
                                                                Clear(TotalDiasFalta);
                                                                UnidMedidaRH.Reset;
                                                                UnidMedidaRH.SetRange(UnidMedidaRH."Internal Designation", UnidMedidaRH."Internal Designation"::Day);
                                                                if UnidMedidaRH.Find('-') then begin
                                                                    TabAusencias.Reset;
                                                                    TabAusencias.SetCurrentKey("Employee No.", "From Date");
                                                                    TabAusencias.SetRange(TabAusencias."Employee No.", Empregado."No.");
                                                                    TabAusencias.SetRange(TabAusencias."From Date",
                                                                      DMY2Date(1, 1, Date2DMY("Periodos Processamento"."Data Fim Processamento", 3)),
                                                                      DMY2Date(31, 12, Date2DMY("Periodos Processamento"."Data Fim Processamento", 3)));
                                                                    TabAusencias.SetRange(TabAusencias."Unit of Measure Code", UnidMedidaRH.Code);
                                                                    if TabAusencias.Find('-') then begin
                                                                        repeat
                                                                            TabMotivoAus.Reset;
                                                                            TabMotivoAus.SetRange(TabMotivoAus."Christmas Subsidy Influence", true);
                                                                            TabMotivoAus.SetRange(TabMotivoAus.Code, TabAusencias."Cause of Absence Code");
                                                                            if TabMotivoAus.Find('-') then
                                                                                TotalDiasFalta := TotalDiasFalta + TabAusencias.Quantity

                                                                        until TabAusencias.Next = 0;
                                                                        if TotalDiasFalta > TabConfRH."Limite dias falta abate SN/F" then
                                                                            //NumDias := NumDias - (ROUND(TotalDiasFalta/TabConfRH."Limite dias falta abate SN/F",1,'<')*2.5);
                                                                            MesesTrabalhados := MesesTrabalhados -
                                                                        Round(TotalDiasFalta / TabConfRH."Limite dias falta abate SN/F", 1, '<');
                                                                    end;
                                                                end;
                                                            end;

                                                            RubricaSalaEmpregado."Total Amount" := RubricaSalaEmpregado."Total Amount" / 12 * MesesTrabalhados;
                                                            TempRubricaEmpregado.Quantity := Round(MesesTrabalhados * 30 / 12, 0.01);

                                                        end;
                                                    end;


                                                    //TAXA IRS SUB FERIAS
                                                    //**********************
                                                    ValorTotalSubFerias := Round(ValorTotalSubFerias + (RubricaSalaEmpregado."Total Amount" * (auxpercentagem / 100)), 0.01);
                                                    TempRubricaEmpregado."Total Amount" := Round(TempRubricaEmpregado."Total Amount" +
                                                                                  (RubricaSalaEmpregado."Total Amount" * (RubricaSalariaLinhas.Percentagem / 100)), 0.01);

                                                end else begin
                                                    // ****************IVA*****************************                //
                                                    TempRubricaEmpregado."Total Amount" := TempRubricaEmpregado."Total Amount" +
                                                                                           RubricaSalaEmpregado."Total Amount";
                                                    TempRubricaEmpregado.Quantity := Empregado."IVA %";
                                                end;
                                            end;

                                        until RubricaSalaEmpregado.Next = 0;
                                    end;
                                until RubricaSalariaLinhas.Next = 0;
                            end;

                            //Guardar of valores totais
                            TabRubricaSalAux.Reset;
                            //if ((TabRubricaSalarial.NATREM = TabRubricaSalarial.NATREM::"Cód. Sub. Férias") or
                            //(TabRubricaSalarial.NATREM = TabRubricaSalarial.NATREM::"Cód. Sub. Natal")) then begin
                            //TempRubricaEmpregado
                            //TODO: REVER!
                            if TabRubricaSalAux.Get(RubricaSalariaLinhas."Payroll Item Code") then begin
                                TempRubricaEmpregadoValorTotalSemPercentagem."Employee No." := RubricaSalaEmpregado."Employee No.";
                                TempRubricaEmpregadoValorTotalSemPercentagem."Total Amount" := RubricaSalaEmpregado."Total Amount";
                                TempRubricaEmpregadoValorTotalSemPercentagem."Line No." := NLinha;
                                TempRubricaEmpregadoValorTotalSemPercentagem."Cód. Rúbrica Salarial" := TempRubricaEmpregado."Cód. Rúbrica Salarial";
                                TempRubricaEmpregadoValorTotalSemPercentagem.Insert();
                                //end;
                            end;

                            //Para corrigir o problema do calculo do IVA. Quando um empregado tem várias
                            //linhas de honorários o IVA só estava a ser calculado sobre a primeira. assim junta as 3 e só depois calcula o IVA
                            Clear(TabRubricaSalAux);
                            TabRubricaSalAux.Reset;
                            if TabRubricaSalAux.Get(RubricaSalariaLinhas."Payroll Item Code") then begin
                                if TabRubricaSalAux.Genero = TabRubricaSalAux.Genero::IVA then
                                    TempRubricaEmpregado."Total Amount" := Round((TempRubricaEmpregado."Total Amount" * Empregado."IVA %" / 100), 0.01);
                            end;

                            TempRubricaEmpregado."Data a que se refere o mov" := "Periodos Processamento"."Data Registo";
                            TempRubricaEmpregado.Insert;
                        end;
                    end;

                    //Validar se é IRS
                    if RubricaSalariaLinhas.FindSet() then
                        repeat
                            TabRubricaSalAux.Reset;
                            if TabRubricaSalAux.Get(RubricaSalariaLinhas."Payroll Item Code") then begin
                                if (TabRubricaSalAux.Genero <> TabRubricaSalAux.Genero::IRS) or
                                (TabRubricaSalAux.Genero <> TabRubricaSalAux.Genero::"IRS Sub. Férias") or
                                (TabRubricaSalAux.Genero <> TabRubricaSalAux.Genero::"IRS Sub. Natal") then begin
                                    ValorTotalAbonosBrutoIRS := ValorTotalAbonosBrutoIRS + TempRubricaEmpregado."Total Amount";
                                    break;
                                end;
                            end;

                        until RubricaSalariaLinhas.Next() = 0;
                end;

                trigger OnPreDataItem()
                begin
                    GuardaAbateSubAlim := VarAbateSubAlimentacao;
                end;
            }
            dataitem(Descontos; "Rubrica Salarial Empregado")
            {
                DataItemLink = "Employee No." = FIELD("No."), "Data Início" = FIELD("Data Filtro Inicio"),
                                "Data Fim" = FIELD("Data Filtro Fim");
                DataItemTableView = SORTING("Employee No.", sort, "Cód. Rúbrica Salarial")
                                    WHERE("Payroll Item Type" = CONST(Desconto));

                trigger OnAfterGetRecord()
                var
                    rRubricaSalarialLinhas: Record "Rubrica Salarial Linhas";
                    rRubricaSalarial: Record "Payroll Item";
                    Text001: Label 'A rubrica %1 nao tem o campo NATREN preenchido.';
                    TabContratoEmp: Record "Contrato Empregado";
                    AnosdeCasa: Integer;
                    MesesdeCasa: Integer;
                    lRubricaSalarial: Record "Payroll Item";
                begin
                    //*******************************************************************************
                    //Pega em cada Desconto parametrizado na tabela Rubrica salarial empregado
                    //e envia para a tabela temporária TempRubricaEmpregado2 já com o valor calculado
                    //*******************************************************************************

                    TabRubricaSalarial.Reset;
                    TabRubricaSalarial.SetRange(TabRubricaSalarial.Código, Descontos."Cód. Rúbrica Salarial");
                    if TabRubricaSalarial.FindFirst then begin
                        //Fundo Compensação
                        //*****************
                        if TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::"FCT-FGCT" then
                            CurrReport.Skip;

                        //IRS SubFerias
                        //**************
                        //Este if é para mudar o mês de processamento de férias caso o empregado tenha um mês definido na sua ficha
                        if (TabRubricaSalarial."Mês Início Periocidade" <> 0) and (Empregado."Mês Proc. Sub. Férias" <> 0) and
                           (TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::"IRS Sub. Férias") then
                            TabRubricaSalarial."Mês Início Periocidade" := Empregado."Mês Proc. Sub. Férias";

                        //IRS SubFerias Duodécimo
                        //**************
                        //Este if é para mudar o mês de processamento de férias caso o empregado tenha um mês definido na sua ficha
                        if (TabRubricaSalarial.Periodicidade = TabRubricaSalarial.Periodicidade::Mensal) and
                           (TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::"IRS Sub. Férias") then
                            TabRubricaSalarial."Mês Início Periocidade" := Date2DMY("Periodos Processamento"."Data Registo", 2);


                        //Fecho Contas
                        //*************************
                        //se o fecho de contas tem uma rubrica de Proporcional de SF então o IRS de SF tem de ser processado
                        if (TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::"IRS Sub. Férias") and (FlagSF) then
                            TabRubricaSalarial."Mês Início Periocidade" := Date2DMY("Periodos Processamento"."Data Registo", 2);
                        //se o fecho de contas tem uma rubrica de Proporcional de SN então o IRS de SN tem de ser processado
                        if (TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::"IRS Sub. Natal") and (FlagSN) then
                            TabRubricaSalarial."Mês Início Periocidade" := Date2DMY("Periodos Processamento"."Data Registo", 2);

                        //Proporcionais Sub. Férias
                        //********************************
                        //Se nas  configurações de RH estiver parametrizado o presente mês como sendo um mês de acerto, então
                        //tem de actualizar o campo "Mês Início Periocidade"
                        if TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::"IRS Sub. Férias" then begin
                            if TabConfRH."Mês Acerto Sub. Férias" = Date2DMY("Periodos Processamento"."Data Fim Processamento", 2) then
                                //Este if serve para se já pagou a totalidade então já não faz acerto
                                if Empregado."Última data Proc. Sub. Férias" < "Periodos Processamento"."Data Fim Processamento" then
                                    TabRubricaSalarial."Mês Início Periocidade" := Date2DMY("Periodos Processamento"."Data Fim Processamento", 2)
                        end;

                        if FuncoesRH.GetPeriodicidade(TabRubricaSalarial, "Periodos Processamento"."Data Inicio Processamento") then begin
                            TempRubricaEmpregado2.Init;
                            TempRubricaEmpregado2 := Descontos;
                            NLinha := NLinha + 10000;
                            TempRubricaEmpregado2."Line No." := NLinha;
                            TempRubricaEmpregado2.NLinhaRubSalEmp := Descontos."Line No.";
                            TempRubricaEmpregado2.Table := DATABASE::"Rubrica Salarial Empregado";

                            //Ver se há rubricas salariais que dependam desta
                            RubricaSalariaLinhas.Reset;
                            RubricaSalariaLinhas.SetRange(RubricaSalariaLinhas."Payroll Item Code", Descontos."Cód. Rúbrica Salarial");
                            if RubricaSalariaLinhas.FindSet then begin
                                repeat
                                    TempRubricaEmpregado.Reset;
                                    TempRubricaEmpregado.SetRange(TempRubricaEmpregado."Employee No.", Descontos."Employee No.");
                                    TempRubricaEmpregado.SetRange(TempRubricaEmpregado."Cód. Rúbrica Salarial", RubricaSalariaLinhas."Cód. Rubrica Filha");
                                    TempRubricaEmpregado.SetFilter(TempRubricaEmpregado."Data Início", '<=%1',
                                                                   "Periodos Processamento"."Data Fim Processamento");
                                    TempRubricaEmpregado.SetFilter(TempRubricaEmpregado."Data Fim", '>=%1|=%2',
                                                                   "Periodos Processamento"."Data Inicio Processamento", 0D);
                                    if TempRubricaEmpregado.FindSet then begin
                                        repeat
                                        //Fecho Contas
                                        //**************************
                                        //Calcular o limite máximo da indemnização para efeitos de IRS
                                        /*
                                        rRubricaSalarial.RESET;
                                        IF (rRubricaSalarial.GET(RubricaSalariaLinhas."Cód. Rubrica Filha")) AND
                                           ((rRubricaSalarial."Genero Rubrica Fecho" =
                                             rRubricaSalarial."Genero Rubrica Fecho"::"Indem. Mútuo Acordo ou Despedimento") OR
                                           (rRubricaSalarial."Genero Rubrica Fecho" =
                                            rRubricaSalarial."Genero Rubrica Fecho"::"Compensação fim contrato")) THEN BEGIN
                                          TabContratoEmp.RESET;
                                          TabContratoEmp.SETRANGE(TabContratoEmp."Cód. Empregado",Empregado."No.");
                                          TabContratoEmp.SETFILTER(TabContratoEmp."Data Inicio Contrato", '<=%1',Empregado."End Date");
                                          TabContratoEmp.SETFILTER(TabContratoEmp."Data Fim Contrato",'>=%1|%2',Empregado."End Date",0D);
                                          IF TabContratoEmp.FIND('-') THEN BEGIN
                                            IF TabContratoEmp."Tipo Contrato" = TabContratoEmp."Tipo Contrato"::"Sem Termo" THEN
                                               AnosdeCasa :=  ROUND((Empregado."End Date" - Empregado."Employment Date") /365,1,'>')
                                            ELSE BEGIN
                                              MesesdeCasa :=  ROUND((Empregado."End Date" - Empregado."Employment Date") /30,1,'>');
                                              IF MesesdeCasa < 12 THEN
                                                AnosdeCasa := 1
                                              ELSE
                                                AnosdeCasa := ROUND(MesesdeCasa/12,1,'>');
                                            END;
                                          END;
                                          VarValorLimite := Empregado."Valor Vencimento Base" * AnosdeCasa * 1.5;
                                          //se o limite é superior, então é tudo isento
                                          IF VarValorLimite > TempRubricaEmpregado."Total Amount" THEN
                                             VarValorLimite := TempRubricaEmpregado."Total Amount";

                                        END ELSE*/
                                        begin

                                            // Fecho Contas - fim
                                            //Existe um limite máximo
                                            if RubricaSalariaLinhas."Valor Limite Máximo" <> 0.0 then begin
                                                VarValorLimite := Round(TempRubricaEmpregado.Quantity * RubricaSalariaLinhas."Valor Limite Máximo", 0.01);
                                                if TempRubricaEmpregado."Total Amount" < 0 then
                                                    VarValorLimite := VarValorLimite * -1;
                                            end else
                                                VarValorLimite := 0;

                                        end;
                                        //como agora o novo codigo contributivo deixa lancar valores no ficheiro SS a negativo
                                        //(ex: reposição de um subsidio alimentação ou reposição de ajudas de custo) e nestes casos estes abonos são
                                        //lançados como descontos estes valores caem aqui. Contudo se se tratar de rubricas que tem valor
                                        //limite temos de ter esse valor em conta
                                        //Assim sendo foi criado um novo campo para guardar só o valor em que incide SS.
                                        if TempRubricaEmpregado."Total Amount" > 0 then
                                            TempRubricaEmpregado."Valor Incidência SS" := TempRubricaEmpregado."Total Amount" - Abs(VarValorLimite)
                                        else
                                            TempRubricaEmpregado."Valor Incidência SS" := (Abs(TempRubricaEmpregado."Total Amount") - Abs(VarValorLimite)) * -1;
                                        TempRubricaEmpregado.Modify;
                                        //Excepção para a % da CGA e ADSE
                                        if ((TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::CGA) or
                                            (TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::ADSE)) and
                                           (Empregado."Nº Horas Docência Calc. Desct." <> 0) then begin
                                            //As rubricas que são consideradas acertos (Ficha rubrica - tab CGA - Acertos)
                                            //não podem ser influenciadas pelo nº horas docencia mas sim pelo nº de horas semanais
                                            //Exemplo: Retroactivos de Vencimento
                                            TabRubSal2.Reset;
                                            TabRubSal2.SetRange(TabRubSal2.Código, TempRubricaEmpregado."Cód. Rúbrica Salarial");
                                            if TabRubSal2.FindFirst then begin
                                                if not TabRubSal2.Acertos then begin
                                                    //saber o grau de função
                                                    GrauFuncaoEmpregado.Reset;
                                                    GrauFuncaoEmpregado.SetRange(GrauFuncaoEmpregado."Employee No.", Empregado."No.");
                                                    GrauFuncaoEmpregado.SetFilter(GrauFuncaoEmpregado."Data Inicio Grau Função",
                                                                                  '<=%1', "Periodos Processamento"."Data Registo");
                                                    GrauFuncaoEmpregado.SetFilter(GrauFuncaoEmpregado."Data Fim Grau Função",
                                                                                '>=%1|%2', "Periodos Processamento"."Data Registo", 0D);
                                                    if GrauFuncaoEmpregado.FindFirst then
                                                        Nivel := GrauFuncaoEmpregado."Cód. Grau Função";

                                                    GrauFuncao.Reset;
                                                    if GrauFuncao.Get(Nivel) then begin
                                                        //Duodécimos
                                                        //Tem de calcular a CGA sobre os duodécimos Suf. Ferias e Natal
                                                        if (TempRubricaEmpregado."Cód. Situação" = '30') or
                                                            (TempRubricaEmpregado."Cód. Situação" = '32') then begin
                                                            if Empregado."Valor Vencimento Base" > GrauFuncao."Max Value" then
                                                                TempRubricaEmpregado."Total Amount" := TempRubricaEmpregado."Total Amount" *
                                                                                                        GrauFuncao."Max Value" /
                                                                                                        Empregado."Valor Vencimento Base";
                                                        end else begin
                                                            // se a pessoa ganha acima da tabela então desconta sobre o valor tabela
                                                            if TempRubricaEmpregado."Total Amount" > GrauFuncao."Max Value" then begin
                                                                TempRubricaEmpregado."Total Amount" := Round(GrauFuncao."Max Value");
                                                                TempRubricaEmpregado."Total Amount" := Round(TempRubricaEmpregado."Total Amount", 0.01);
                                                            end;
                                                        end;
                                                    end;
                                                    TempRubricaEmpregado2."Total Amount" := Round(TempRubricaEmpregado2."Total Amount" +
                                                          (TempRubricaEmpregado."Total Amount" - VarValorLimite)
                                                          , 0.01);
                                                end else
                                                    TempRubricaEmpregado2."Total Amount" := Round(TempRubricaEmpregado2."Total Amount" +
                                                           ((TempRubricaEmpregado."Total Amount" - VarValorLimite)
                                                           * 100 * Empregado."No. Horas Semanais" / Empregado."No. Horas Semanais"
                                                           / 100), 0.01);
                                            end;
                                        end else begin
                                            //Calculo normal para os restantes casos
                                            TempRubricaEmpregado2."Total Amount" := Round(TempRubricaEmpregado2."Total Amount" +
                                                      ((TempRubricaEmpregado."Total Amount" - VarValorLimite)
                                                      * RubricaSalariaLinhas.Percentagem / 100), 0.01);
                                            //para aparecer a % do desconto na coluna quantidade
                                            //TempRubricaEmpregado2.Quantity := RubricaSalariaLinhas.Percentagem ;
                                            TempRubricaEmpregado2.Quantity := 1;
                                            //Para aparecer a mesma QTD no desconto Sub. Alimentação
                                            lRubricaSalarial.Reset;
                                            if (lRubricaSalarial.Get(RubricaSalariaLinhas."Cód. Rubrica Filha")) and
                                               (lRubricaSalarial.Genero = rRubricaSalarial.Genero::"Sub. Alimentação") then
                                                TempRubricaEmpregado2.Quantity := TempRubricaEmpregado.Quantity;
                                        end;
                                        until TempRubricaEmpregado.Next = 0;
                                    end;
                                until RubricaSalariaLinhas.Next = 0;
                            end;
                            //************************************************
                            //****************IRS*****************************
                            //************************************************
                            if (TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::IRS) or
                               (TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::"IRS Sub. Férias") or
                               (TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::"IRS Sub. Natal") then begin
                                if ValorDesc1 <> 0 then
                                    TempRubricaEmpregado2."Total Amount" := TempRubricaEmpregado2."Total Amount" - ValorDesc1;

                                // Sobretaxa - guarda o valor sobre o qual indice IRS
                                ValorIncidenciaIRS := ValorIncidenciaIRS + TempRubricaEmpregado2."Total Amount";

                                //Sobretaxa 2016  - guarda o valor sobre o qual indice IRS para apurar o escalão
                                if TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::IRS then
                                    ValorEscalaoSobretaxa := ValorEscalaoSobretaxa + TempRubricaEmpregado2."Total Amount";

                                if Empregado."IRS % Fixa" = 0.0 then begin
                                    //Proporcionais SubFerias
                                    //********************************************

                                    //PASSAR VALOR TOTAL PARA EFEITOS DE CALCULO
                                    TempRubricaEmpregadoValorTotalSemPercentagem.Reset();
                                    TempRubricaEmpregadoValorTotalSemPercentagem.SetFilter("Employee No.", TempRubricaEmpregado."Employee No.");
                                    TempRubricaEmpregadoValorTotalSemPercentagem.SetFilter("Cód. Rúbrica Salarial", Format(TempRubricaEmpregado."Cód. Rúbrica Salarial"));

                                    //Obter o valor total sem - % IRS. Temporario, usado como var auxiliar.
                                    TempRubricaEmpregadoDeducts."Total Amount" := TempRubricaEmpregado2."Total Amount";

                                    if TempRubricaEmpregadoValorTotalSemPercentagem.FindFirst() then begin
                                        //se está aqui é em %
                                        IRSTaxa := FuncoesRH.CalcularTaxaIRS2024(TempRubricaEmpregadoValorTotalSemPercentagem."Total Amount" - DescTaxaIRS, Empregado, "Periodos Processamento"."Data Registo", DeductValue);
                                        //Descontos que estejam relacionados com o IRS jovem.
                                        TempRubricaEmpregado2."Total Amount" := DescontosIRSJovemSeAplicavel(Empregado, TempRubricaEmpregado."Total Amount", TempRubricaEmpregadoValorTotalSemPercentagem."Total Amount");
                                        //Recalcular o deductvalue com base no percentual:
                                        //DeductValue := Round(DeductValue * TempRubricaEmpregadoDeducts."Total Amount" / TempRubricaEmpregadoValorTotalSemPercentagem."Total Amount", 0.01);
                                        DeductValue := DeductValue * TempRubricaEmpregadoDeducts."Total Amount" / TempRubricaEmpregadoValorTotalSemPercentagem."Total Amount";
                                    end else begin
                                        IRSTaxa := FuncoesRH.CalcularTaxaIRS2024(TempRubricaEmpregado2."Total Amount" - DescTaxaIRS, Empregado, "Periodos Processamento"."Data Registo", DeductValue);
                                        //Descontos que estejam relacionados com o IRS jovem.
                                        TempRubricaEmpregado2."Total Amount" := DescontosIRSJovemSeAplicavel(Empregado, TempRubricaEmpregado."Total Amount", TempRubricaEmpregado."Total Amount");
                                    end;

                                    //Taxa IRS
                                    TempRubricaEmpregado2."Total Amount" := TempRubricaEmpregado2."Total Amount" * IRSTaxa / 100;

                                    //Remove do valor total o valor de dedução das parcelas a abater
                                    if Empregado."IRS Jovem" <> true then begin
                                        TempRubricaEmpregado2."Total Amount" := TempRubricaEmpregado2."Total Amount" - DeductValue;
                                    end else begin
                                        TempRubricaEmpregado2."Total Amount" := TempRubricaEmpregado2."Total Amount" - DeductValue;
                                        //DeductValue := 0; //zerar deduct value quando é IRS jovem, não há parcela a abater neste caso.
                                    end;

                                    //PODE SER MENOR QUE ZERO PORCAUSA DO DEDUCT VALUE!!
                                    if TempRubricaEmpregado2."Total Amount" <= 0 then begin
                                        TempRubricaEmpregado2."Total Amount" := 0;
                                    end;

                                    TempRubricaEmpregadoDeducts."Total Amount" := Abs(TempRubricaEmpregado2."Total Amount" / TempRubricaEmpregadoDeducts."Total Amount" * 100);
                                    TempRubricaEmpregado2.Quantity := IRSTaxa;

                                    //Arredondar quando é tipo B
                                    if Empregado."Tipo Rendimento" = Empregado."Tipo Rendimento"::B then begin
                                        TempRubricaEmpregado2."Total Amount" := Round(TempRubricaEmpregado2."Total Amount", 0.01, '=')
                                    end else begin
                                        TempRubricaEmpregado2."Total Amount" := Round(TempRubricaEmpregado2."Total Amount", 1, '<');
                                    end;

                                    //Insere as deducst para apresentar. Taxas a abater.
                                    TempRubricaEmpregadoDeducts."Employee No." := TempRubricaEmpregado."Employee No.";
                                    TempRubricaEmpregadoDeducts."Line No." := TempRubricaEmpregado2."Line No.";
                                    TempRubricaEmpregadoDeducts.Quantity := DeductValue;
                                    TempRubricaEmpregadoDeducts.Insert();

                                    //IRS Retroactivos
                                    //Procura a tabela de IRS relativa ao ano de processamento
                                    TabIRS.Reset;
                                    TabIRS.SetRange(TabIRS.Ano, Date2DMY("Periodos Processamento"."Data Registo", 3));
                                    if TabIRS.FindFirst then begin
                                        //o codigo acima tinha um senão, caso o empregado entrasse a meio do ano a aplicação detectava que
                                        //ainda não tinha feito Retroactivos e então ia fazer
                                        if TabConfRH."Retroactivos Processados" = false then begin
                                            TabHistLinhaMovEmp.Reset;
                                            TabHistLinhaMovEmp.SetFilter(TabHistLinhaMovEmp."Data Registo", '%1..%2',
                                                                       DMY2Date(1, 1, Date2DMY("Periodos Processamento"."Data Registo", 3)),
                                                                       TabConfRH."Data Importação Tabela IRS");
                                            TabHistLinhaMovEmp.SetRange(TabHistLinhaMovEmp."Employee No.", Empregado."No.");
                                            if TabHistLinhaMovEmp.FindFirst then begin
                                                //varCriarRetroactivo := TRUE;
                                                TempRubricaEmpregado3 := Descontos;
                                            end;
                                        end;
                                    end;

                                    //IRS Retroactivos - Fim
                                end else begin
                                    //para os Empregados da categoria B o arredondamento é 0.01 (centimo mais proximo)
                                    if Empregado."Tipo Rendimento" = Empregado."Tipo Rendimento"::B then
                                        TempRubricaEmpregado2."Total Amount" := Round(TempRubricaEmpregado2."Total Amount" * Empregado."IRS % Fixa" / 100, 0.01, '=')
                                    else
                                        TempRubricaEmpregado2."Total Amount" := Round((TempRubricaEmpregado2."Total Amount") * Empregado."IRS % Fixa" / 100
                                                                                   , 1, '<'); //Arred IRS
                                    TempRubricaEmpregado2.Quantity := Empregado."IRS % Fixa";
                                end;
                            end;
                            //************************************************
                            //****************SS*****************************
                            //************************************************
                            if TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::SS then begin
                                //Valida se todas as filhas da Seg. social têm o Natrem preenchido
                                rRubricaSalarialLinhas.Reset;
                                rRubricaSalarialLinhas.SetFilter("Payroll Item Code", TabRubricaSalarial.Código);
                                if rRubricaSalarialLinhas.FindSet then begin
                                    repeat
                                        if rRubricaSalarial.Get(rRubricaSalarialLinhas."Cód. Rubrica Filha") then
                                            if rRubricaSalarial.NATREM = rRubricaSalarial.NATREM::" " then
                                                Error(Text001, rRubricaSalarial.Código);
                                    until rRubricaSalarialLinhas.Next = 0;
                                end;
                                Empregado.TestField(Empregado."Cod. Regime SS");
                                TabRegimeSS.Reset;
                                if TabRegimeSS.Get(Empregado."Cod. Regime SS") then begin
                                    if ValorDescSS <> 0 then begin
                                        VarValorTotal := TempRubricaEmpregado2."Total Amount" - ValorDescSS;
                                    end else
                                        VarValorTotal := TempRubricaEmpregado2."Total Amount";

                                    //Orgãos Sociais
                                    /*Em desenvolvimento
                                    IF (Empregado."Orgão Social" = TRUE) AND (TabRegimeSS.Majorante <> 0) THEN BEGIN
                                       MESSAGE('%1', VarValorTotal);
                                       TempVarValorTotal := VarValorTotal;
                                       IF VarValorTotal > TabRegimeSS.Majorante THEN
                                         VarValorTotal := TabRegimeSS.Majorante;
                                    END;
                                    */

                                    TempRubricaEmpregado2."Total Amount" := Round(VarValorTotal * TabRegimeSS."Taxa Contributiva Empregado" / 100, 0.01);
                                    TempRubricaEmpregado2.Quantity := TabRegimeSS."Taxa Contributiva Empregado";

                                    if Empregado."Subscritor SS" = true then Empregado.TestField(Empregado."Cód. Rúbrica Enc. Seg. Social");
                                    ProcessarEncSociais(VarValorTotal, TabRegimeSS."Taxa Contributiva Ent Patronal",
                                                        Empregado."Cód. Rúbrica Enc. Seg. Social", '', '');
                                    // Orgãos Sociais
                                    /* Em desenvolvimento
                                    IF (Empregado."Orgão Social" = TRUE) AND (TabRegimeSS.Majorante <> 0) THEN
                                       VarValorTotal := TempVarValorTotal;
                                    */
                                end;
                            end;
                            //************************************************
                            //****************CGA*****************************
                            //************************************************
                            if (TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::CGA) or
                               (TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::"Enc. CGA") then begin
                                if ValorDescCGA <> 0 then begin
                                    VarValorTotal := TempRubricaEmpregado2."Total Amount" - ValorDescCGA;
                                end else
                                    VarValorTotal := TempRubricaEmpregado2."Total Amount";

                                //se o empregado faltar o mes todo este valor vem a negativo e como tal passo-o para 0
                                if VarValorTotal < 0 then VarValorTotal := 0;

                                //Se for professor de acumulação não desconta
                                if Empregado."Professor Acumulação" = false then begin
                                    TempRubricaEmpregado2."Total Amount" := Round(VarValorTotal * TabConfRH."Taxa Contributiva Empregado" / 100, 0.01);
                                    TempRubricaEmpregado2.Quantity := TabConfRH."Taxa Contributiva Empregado";
                                end else begin
                                    TempRubricaEmpregado2."Total Amount" := 0;
                                    TempRubricaEmpregado2.Quantity := 0;
                                end;

                                AuxTabRubricaEmpregado.Reset;
                                AuxTabRubricaEmpregado.SetRange("Employee No.", Descontos."Employee No.");
                                AuxTabRubricaEmpregado.SetRange("Cód. Rúbrica Salarial", TabRubricaSalarial.Código);
                                if AuxTabRubricaEmpregado.Find('-') then begin
                                    TempRubricaEmpregado2."Cód. Situação" := AuxTabRubricaEmpregado."Cód. Situação";
                                    TempRubricaEmpregado2."Cód. Movimento" := AuxTabRubricaEmpregado."Cód. Movimento";
                                    if AuxTabRubricaEmpregado."Data Efeito" <> 0D then
                                        TempRubricaEmpregado2."Data Efeito" := AuxTabRubricaEmpregado."Data Efeito"
                                    else
                                        TempRubricaEmpregado2."Data Efeito" := "Periodos Processamento"."Data Fim Processamento";
                                end;


                                if Empregado."Subsccritor CGA" = true then Empregado.TestField(Empregado."Cód. Rúbrica Enc. CGA");

                                if Empregado."CGA - Requisição" = false then
                                    ProcessarEncSociais(VarValorTotal, TabConfRH."Taxa Contributiva Ent Patronal",
                                                        Empregado."Cód. Rúbrica Enc. CGA", '', '')
                                else
                                    ProcessarEncSociais(VarValorTotal, 0,
                                                        Empregado."Cód. Rúbrica Enc. CGA", '', '');
                            end;
                            //************************************************
                            //****************ADSE****************************
                            //************************************************
                            if TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::ADSE then begin
                                Empregado.TestField(Empregado."Subscritor ADSE");
                                if ValorDescADSE <> 0 then
                                    VarValorTotal := TempRubricaEmpregado2."Total Amount" - ValorDescADSE
                                else
                                    VarValorTotal := TempRubricaEmpregado2."Total Amount";

                                //se o empregado faltar o mes todo este valor vem a negativo e como tal passo-o para 0
                                if VarValorTotal < 0 then
                                    VarValorTotal := 0;

                                TempRubricaEmpregado2."Total Amount" := Round(VarValorTotal * TabConfRH."Taxa Contr. Empregado ADSE" / 100, 0.01);
                                TempRubricaEmpregado2.Quantity := TabConfRH."Taxa Contr. Empregado ADSE";
                                ProcessarEncSociais(VarValorTotal, TabConfRH."Contribui. Ent. Patronal ADSE", Empregado."Cód. Rúbrica Enc. ADSE", '', '');
                            end;

                            //************************************************
                            //****************IVA*****************************
                            //************************************************
                            if TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::IVA then begin
                                VarValorTotal := TempRubricaEmpregado2."Total Amount";
                                TempRubricaEmpregado2."Total Amount" := Round(VarValorTotal * Empregado."IVA %" / 100, 0.01);
                                TempRubricaEmpregado2.Quantity := Empregado."IVA %";
                            end;

                            TempRubricaEmpregado2."Total Amount" := -TempRubricaEmpregado2."Total Amount";

                            if (TabRubricaSalarial.Genero <> TabRubricaSalarial.Genero::IVA) and
                               (TabRubricaSalarial.Genero <> TabRubricaSalarial.Genero::ADSE) and
                               (TabRubricaSalarial.Genero <> TabRubricaSalarial.Genero::"Enc. ADSE") and
                               (TabRubricaSalarial.Genero <> TabRubricaSalarial.Genero::CGA) and
                               (TabRubricaSalarial.Genero <> TabRubricaSalarial.Genero::"Enc. CGA") and
                               (TabRubricaSalarial.Genero <> TabRubricaSalarial.Genero::IRS) and
                               (TabRubricaSalarial.Genero <> TabRubricaSalarial.Genero::"IRS Sub. Férias") and
                               (TabRubricaSalarial.Genero <> TabRubricaSalarial.Genero::"IRS Sub. Natal") and
                               (TabRubricaSalarial.Genero <> TabRubricaSalarial.Genero::SS) and
                               (TabRubricaSalarial.Genero <> TabRubricaSalarial.Genero::"Enc. SS") then begin
                                TempRubricaEmpregado2."Data a que se refere o mov" := "Periodos Processamento"."Data Registo";
                            end;
                            TempRubricaEmpregado2.Insert;


                            //************************************************
                            //************RETROACTIVOS IRS********************
                            //************************************************
                            if varCriarRetroactivo then begin
                                Clear(VarValorTotal2);
                                Clear(VarValorTotal3);
                                TabRubSal.Reset;
                                TabRubSal.SetRange(TabRubSal.Código, Descontos."Cód. Rúbrica Salarial");
                                TabRubSal.SetRange(TabRubSal.Genero, TabRubSal.Genero::IRS);
                                if TabRubSal.FindSet then begin
                                    repeat
                                        TabHistLinhaMovEmp.Reset;
                                        TabHistLinhaMovEmp.SetCurrentKey(TabHistLinhaMovEmp."Employee No.", TabHistLinhaMovEmp."Data Registo");
                                        TabHistLinhaMovEmp.SetRange(TabHistLinhaMovEmp."Employee No.", Empregado."No.");
                                        TabHistLinhaMovEmp.SetRange(TabHistLinhaMovEmp."Payroll Item Code", TabRubSal.Código);
                                        TabHistLinhaMovEmp.SetFilter(TabHistLinhaMovEmp."Data Registo", '%1..%2',
                                                                         DMY2Date(1, 1, Date2DMY("Periodos Processamento"."Data Registo", 3)),
                                                                         DMY2Date(31, 12, Date2DMY("Periodos Processamento"."Data Registo", 3)));
                                        if TabHistLinhaMovEmp.FindSet then begin
                                            repeat
                                                Clear(VarValorTotal2);
                                                TabHistLinhaMovEmp2.Reset;
                                                TabHistLinhaMovEmp2.SetRange(TabHistLinhaMovEmp2."Employee No.", Empregado."No.");
                                                TabHistLinhaMovEmp2.SetRange(TabHistLinhaMovEmp2."Data Registo", TabHistLinhaMovEmp."Data Registo");
                                                if TabHistLinhaMovEmp2.Find('-') then begin
                                                    repeat
                                                        TabRubSalLinha.Reset;
                                                        TabRubSalLinha.SetRange(TabRubSalLinha."Payroll Item Code", TabRubSal.Código);
                                                        TabRubSalLinha.SetRange(TabRubSalLinha."Cód. Rubrica Filha", TabHistLinhaMovEmp2."Payroll Item Code");
                                                        if TabRubSalLinha.Find('-') then begin

                                                            if TabRubSalLinha."Valor Limite Máximo" <> 0.0 then
                                                                VarValorLimite := Round(TabHistLinhaMovEmp2.Quantity * TabRubSalLinha."Valor Limite Máximo", 0.01)
                                                            else
                                                                VarValorLimite := 0;

                                                            //Retirei uns rounds para ser identicos às linhas do empregado e podermos comparar
                                                            VarValorTotal2 := VarValorTotal2 + ((TabHistLinhaMovEmp2.Valor - VarValorLimite)
                                                                                                 * TabRubSalLinha.Percentagem / 100);
                                                        end;
                                                    until TabHistLinhaMovEmp2.Next = 0;


                                                    //Guardar valor de abono
                                                    ValorTotalSemDeduct := VarValorTotal3;

                                                    IRSTaxa := FuncoesRH.CalcularTaxaIRS2024(VarValorTotal2, Empregado,
                                                                                "Periodos Processamento"."Data Registo", DeductValue);
                                                    //para os Empregados da categoria B o arredondamento é 0.01 (centimo mais proximo)
                                                    if Empregado."Tipo Rendimento" = Empregado."Tipo Rendimento"::B then
                                                        VarValorTotal2 := Round(VarValorTotal2 * (IRSTaxa / 100), 0.01, '=')
                                                    else
                                                        VarValorTotal2 := Round(VarValorTotal2 * (IRSTaxa / 100), 1, '<');

                                                    VarValorTotal3 := (Abs(TabHistLinhaMovEmp.Valor) - VarValorTotal2);

                                                    //Remove do valor total o valor de dedução das parcelas a abater
                                                    VarValorTotal3 := VarValorTotal3 - DeductValue;
                                                end;
                                                //Vai criar a linha de retroactivo para cada mês
                                                TempRubricaEmpregado2.Init;
                                                TempRubricaEmpregado2 := TempRubricaEmpregado3;
                                                //Fixo p não ter de criar mais rubricas e a data é para saber o mês do retroactivo
                                                TempRubricaEmpregado2."Cód. Rúbrica Salarial" := 'IRS Retro' +
                                                                                                 Format(TabHistLinhaMovEmp."Data Registo", 0, '<Month text>');
                                                TempRubricaEmpregado2."Payroll Item Description" := TempRubricaEmpregado3."Cód. Rúbrica Salarial";//truque
                                                NLinha := NLinha + 10000;
                                                TempRubricaEmpregado2."Line No." := NLinha;
                                                TempRubricaEmpregado2."Total Amount" := VarValorTotal3;
                                                //se o empregado tem dinheiro a receber então tem de trocar as contas
                                                if VarValorTotal3 > 0 then begin
                                                    TempRubricaEmpregado2."Debit Acc. No." := TempRubricaEmpregado3."Credit Acc. No.";
                                                    TempRubricaEmpregado2."Credit Acc. No." := TempRubricaEmpregado3."Debit Acc. No.";
                                                    //Se o empregado receber dinheiro então deve ser abono
                                                    TempRubricaEmpregado2."Payroll Item Type" := TempRubricaEmpregado2."Payroll Item Type"::Abono;
                                                    TempRubricaEmpregado2.Sort := 99;
                                                end;
                                                TempRubricaEmpregado2.Quantity := IRSTaxa;
                                                TempRubricaEmpregado2.Insert;
                                            until TabHistLinhaMovEmp.Next = 0;
                                        end;
                                    until TabRubSal.Next = 0;
                                end;
                            end;
                            //***************************************************
                            //Fim de retroactivo IRS
                        end;
                    end;
                end;

                trigger OnPreDataItem()
                var
                    l_rubSalarial: Record "Payroll Item";
                begin
                    //************************************************************
                    //Copia as rúbricas da tabela temporária TempRubricaEmpregado para TempRubricaEmpregado2
                    //************************************************************
                    DescTaxaIRS := 0;
                    TempRubricaEmpregado.Reset;
                    TempRubricaEmpregado.SetRange(TempRubricaEmpregado."Employee No.", Empregado."No.");
                    if TempRubricaEmpregado.FindSet then
                        repeat
                            TempRubricaEmpregado2.Init;
                            TempRubricaEmpregado2.TransferFields(TempRubricaEmpregado);
                            //Taxa IRS das Horas Extra
                            l_rubSalarial.Reset;
                            l_rubSalarial.SetRange(l_rubSalarial.Código, TempRubricaEmpregado."Cód. Rúbrica Salarial");
                            l_rubSalarial.SetRange(l_rubSalarial.Genero, l_rubSalarial.Genero::"Hora Extra");
                            if l_rubSalarial.FindFirst then
                                DescTaxaIRS := DescTaxaIRS + TempRubricaEmpregado."Total Amount";
                            TempRubricaEmpregado2.Insert;

                        // TempRubricaEmpregadoValorTotalSemPercentagem.Reset();
                        // if TempRubricaEmpregadoValorTotalSemPercentagem.Get("Cód. Rúbrica Salarial", TempRubricaEmpregado."Cód. Rúbrica Salarial") then begin
                        //     TempRubricaEmpregadoValorTotalSemPercentagem."Cód. Rúbrica Salarial":= 
                        // end;

                        until TempRubricaEmpregado.Next = 0;

                    //*******************************************************************************************************************
                    // Neste momento, vou tentar determinar se este empregado tem descontos que possam influenciar o valor do vencimento
                    // Para depois juntamente com os abonos calculados em cima, determinar qual o valor do IRS e respectivo SS
                    //*******************************************************************************************************************
                    ValorDesc1 := 0;
                    ValorDescSS := 0;
                    ValorDescCGA := 0;
                    ValorDescADSE := 0;
                    Rubrica := '';
                    Rubrica2 := '';
                    Rubrica3 := '';
                    Rubrica4 := '';
                    Rubrica5 := '';
                    Rubrica6 := '';
                    FIltroRubricas := '';

                    RubricaSalaEmpregado.Reset;
                    RubricaSalaEmpregado.SetCurrentKey("Employee No.", "Line No.");
                    RubricaSalaEmpregado.SetRange("Payroll Item Type", RubricaSalaEmpregado."Payroll Item Type"::Desconto);
                    RubricaSalaEmpregado.SetRange("Employee No.", Empregado."No.");
                    RubricaSalaEmpregado.SetFilter(RubricaSalaEmpregado."Data Início", '<=%1',
                                                   "Periodos Processamento"."Data Fim Processamento");
                    RubricaSalaEmpregado.SetFilter(RubricaSalaEmpregado."Data Fim", '>=%1|=%2',
                                                   "Periodos Processamento"."Data Inicio Processamento", 0D);
                    TabRubSal.Reset;
                    TabRubSal.SetFilter(Genero, '%1|%2|%3|%4|%5|%6', TabRubSal.Genero::IRS, TabRubSal.Genero::"IRS Sub. Férias",
                                                                 TabRubSal.Genero::"IRS Sub. Natal", TabRubSal.Genero::SS, TabRubSal.Genero::CGA,
                                                                 TabRubSal.Genero::ADSE);
                    TabRubSal.SetFilter(Código, '<>%1', '');
                    if TabRubSal.FindSet then
                        repeat
                            if TabRubSal.Genero = TabRubSal.Genero::CGA then begin
                                Rubrica := TabRubSal.Código;
                                if FIltroRubricas <> '' then
                                    FIltroRubricas := FIltroRubricas + '&<>' + Rubrica
                                else
                                    FIltroRubricas := FIltroRubricas + '<>' + Rubrica
                            end;

                            if TabRubSal.Genero = TabRubSal.Genero::SS then begin
                                Rubrica2 := TabRubSal.Código;
                                if FIltroRubricas <> '' then
                                    FIltroRubricas := FIltroRubricas + '&<>' + Rubrica2
                                else
                                    FIltroRubricas := FIltroRubricas + '<>' + Rubrica2;
                            end;

                            if TabRubSal.Genero = TabRubSal.Genero::IRS then begin
                                Rubrica3 := TabRubSal.Código;
                                if FIltroRubricas <> '' then
                                    FIltroRubricas := FIltroRubricas + '&<>' + Rubrica3
                                else
                                    FIltroRubricas := FIltroRubricas + '<>' + Rubrica3;
                            end;

                            if TabRubSal.Genero = TabRubSal.Genero::"IRS Sub. Férias" then begin
                                Rubrica4 := TabRubSal.Código;
                                if FIltroRubricas <> '' then
                                    FIltroRubricas := FIltroRubricas + '&<>' + Rubrica4
                                else
                                    FIltroRubricas := FIltroRubricas + '<>' + Rubrica4;
                            end;

                            if TabRubSal.Genero = TabRubSal.Genero::"IRS Sub. Natal" then begin
                                Rubrica5 := TabRubSal.Código;
                                if FIltroRubricas <> '' then
                                    FIltroRubricas := FIltroRubricas + '&<>' + Rubrica5
                                else
                                    FIltroRubricas := FIltroRubricas + '<>' + Rubrica5;
                            end;
                            if TabRubSal.Genero = TabRubSal.Genero::ADSE then begin
                                Rubrica6 := TabRubSal.Código;
                                if FIltroRubricas <> '' then
                                    FIltroRubricas := FIltroRubricas + '&<>' + Rubrica6
                                else
                                    FIltroRubricas := FIltroRubricas + '<>' + Rubrica6;
                            end;
                        until TabRubSal.Next = 0;

                    RubricaSalaEmpregado.SetFilter("Cód. Rúbrica Salarial", FIltroRubricas);
                    if RubricaSalaEmpregado.FindSet then
                        repeat
                            //Descontos que estejam relacionados com o IRS
                            TabRubSal.Reset;
                            TabRubSal.SetRange(Genero, TabRubSal.Genero::IRS);
                            if TabRubSal.Find('-') then begin
                                RubricaSalariaLinhas.Reset;
                                RubricaSalariaLinhas.SetRange("Payroll Item Code", TabRubSal.Código);
                                RubricaSalariaLinhas.SetRange("Cód. Rubrica Filha", RubricaSalaEmpregado."Cód. Rúbrica Salarial");
                                if RubricaSalariaLinhas.Find('-') then
                                    ValorDesc1 := ValorDesc1 + Abs(RubricaSalaEmpregado."Total Amount");
                            end;

                            //Descontos que estejam relacionados com a SS
                            TabRubSal.Reset;
                            TabRubSal.SetRange(Genero, TabRubSal.Genero::SS);
                            if TabRubSal.FindFirst then begin
                                RubricaSalariaLinhas.Reset;
                                RubricaSalariaLinhas.SetRange("Payroll Item Code", TabRubSal.Código);
                                RubricaSalariaLinhas.SetRange("Cód. Rubrica Filha", RubricaSalaEmpregado."Cód. Rúbrica Salarial");
                                if RubricaSalariaLinhas.Find('-') then begin
                                    //ValorDescSS := ValorDescSS + ABS(RubricaSalaEmpregado."Total Amount");
                                    //como agora o novo codigo contributivo deixa lancar valores no ficheiro SS a negativo (ex: reposição de um
                                    //subsidio alimentação ou reposição de ajudas de custo) e nestes casos estes abonos são lançados como descontos
                                    //estes valores caem aqui. Contudo se se tratar de rubricas que tem valor limite temos de ter esse valor em conta
                                    //Assim sendo foi criado um novo campo para guardar só o valor em que incide SS.
                                    if RubricaSalariaLinhas."Valor Limite Máximo" <> 0 then begin
                                        RubricaSalaEmpregado."Valor Incidência SS" := (Abs(RubricaSalaEmpregado."Total Amount") -
                                          (RubricaSalaEmpregado.Quantity * RubricaSalariaLinhas."Valor Limite Máximo")) * -1;
                                        RubricaSalaEmpregado.Modify;
                                        ValorDescSS := ValorDescSS + Abs(RubricaSalaEmpregado."Valor Incidência SS");
                                    end else begin
                                        RubricaSalaEmpregado."Valor Incidência SS" := Abs(RubricaSalaEmpregado."Total Amount") * -1;
                                        RubricaSalaEmpregado.Modify;
                                        ValorDescSS := ValorDescSS + Abs(RubricaSalaEmpregado."Total Amount");
                                    end;
                                end;
                            end;

                            //Descontos que estejam relacionados com a CGA
                            TabRubSal.Reset;
                            TabRubSal.SetRange(Genero, TabRubSal.Genero::CGA);
                            if TabRubSal.FindFirst then begin
                                RubricaSalariaLinhas.Reset;
                                RubricaSalariaLinhas.SetRange("Payroll Item Code", TabRubSal.Código);
                                RubricaSalariaLinhas.SetRange("Cód. Rubrica Filha", RubricaSalaEmpregado."Cód. Rúbrica Salarial");
                                if RubricaSalariaLinhas.Find('-') then
                                    ValorDescCGA := ValorDescCGA + Abs(RubricaSalaEmpregado."Total Amount");
                            end;
                            //Descontos que estejam relacionados com a ADSE
                            TabRubSal.Reset;
                            TabRubSal.SetRange(Genero, TabRubSal.Genero::ADSE);
                            if TabRubSal.Find('-') then begin
                                RubricaSalariaLinhas.Reset;
                                RubricaSalariaLinhas.SetRange("Payroll Item Code", TabRubSal.Código);
                                RubricaSalariaLinhas.SetRange("Cód. Rubrica Filha", RubricaSalaEmpregado."Cód. Rúbrica Salarial");
                                if RubricaSalariaLinhas.Find('-') then
                                    ValorDescADSE := ValorDescADSE + Abs(RubricaSalaEmpregado."Total Amount");
                            end;
                        until RubricaSalaEmpregado.Next = 0;
                end;
            }
            dataitem(FCT; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                trigger OnAfterGetRecord()
                var
                    l_RubricaSalarial: Record "Payroll Item";
                    l_RubricaSalarialLinhas: Record "Rubrica Salarial Linhas";
                    l_RubricaSalarialEmpregado: Record "Rubrica Salarial Empregado";
                    Valor: Decimal;
                    l_RubricaSalarial2: Record "Payroll Item";
                begin
                    //Fundo Compensação
                    l_RubricaSalarial.Reset;
                    l_RubricaSalarial.SetRange(l_RubricaSalarial.Genero, l_RubricaSalarial.Genero::"FCT-FGCT");
                    if l_RubricaSalarial.FindSet then begin
                        repeat
                            Clear(Valor);
                            l_RubricaSalarialEmpregado.Reset;
                            l_RubricaSalarialEmpregado.SetRange(l_RubricaSalarialEmpregado."Employee No.", Empregado."No.");
                            l_RubricaSalarialEmpregado.SetRange(l_RubricaSalarialEmpregado."Cód. Rúbrica Salarial", l_RubricaSalarial.Código);
                            l_RubricaSalarialEmpregado.SetFilter(l_RubricaSalarialEmpregado."Data Início", '<=%1',
                                                                   "Periodos Processamento"."Data Fim Processamento");
                            l_RubricaSalarialEmpregado.SetFilter(l_RubricaSalarialEmpregado."Data Fim", '>=%1|=%2',
                                                                   "Periodos Processamento"."Data Inicio Processamento", 0D);
                            if l_RubricaSalarialEmpregado.FindFirst then begin
                                l_RubricaSalarialLinhas.Reset;
                                l_RubricaSalarialLinhas.SetRange(l_RubricaSalarialLinhas."Payroll Item Code", l_RubricaSalarial.Código);
                                if l_RubricaSalarialLinhas.FindSet then begin
                                    repeat
                                        TempRubricaEmpregado2.Reset;
                                        TempRubricaEmpregado2.SetRange(TempRubricaEmpregado2."Employee No.", Empregado."No.");
                                        TempRubricaEmpregado2.SetRange(TempRubricaEmpregado2."Cód. Rúbrica Salarial",
                                                                      l_RubricaSalarialLinhas."Cód. Rubrica Filha");
                                        if TempRubricaEmpregado2.FindFirst then begin
                                            l_RubricaSalarial2.Reset;
                                            if l_RubricaSalarial2.Get(TempRubricaEmpregado2."Cód. Rúbrica Salarial") then begin
                                                if l_RubricaSalarial2.Genero <> l_RubricaSalarial2.Genero::"Admissão-Demissão" then
                                                    Valor := Valor + TempRubricaEmpregado2."Total Amount";
                                            end;
                                        end;
                                    until l_RubricaSalarialLinhas.Next = 0;
                                    //Nos meses de admissão contabiliza conforme os dias do mês
                                    if (Date2DMY("Periodos Processamento"."Data Registo", 2) = Date2DMY(Empregado."Employment Date", 2)) and
                                       (Date2DMY("Periodos Processamento"."Data Registo", 3) = Date2DMY(Empregado."Employment Date", 3)) and
                                       (Empregado."End Date" = 0D) then begin
                                        DiasdoMes := CalcDate('1M-1D', DMY2Date(1, Date2DMY("Periodos Processamento"."Data Registo", 2),
                                                                               Date2DMY("Periodos Processamento"."Data Registo", 3))) -
                                                   DMY2Date(1, Date2DMY("Periodos Processamento"."Data Registo", 2),
                                                              Date2DMY("Periodos Processamento"."Data Registo", 3)) + 1;
                                        DiasdoMes := DiasdoMes - Date2DMY(Empregado."Employment Date", 1) + 1;
                                        if DiasdoMes > 30 then DiasdoMes := 30;
                                        Valor := Valor / 30 * DiasdoMes;
                                    end;
                                    //Nos meses de demissão contabiliza conforme os dias do mês
                                    if (Empregado."End Date" <> 0D) then begin
                                        //Admissões e Demissões no mesmo mês
                                        if (Date2DMY("Periodos Processamento"."Data Registo", 2) = Date2DMY(Empregado."Employment Date", 2)) and
                                           (Date2DMY("Periodos Processamento"."Data Registo", 3) = Date2DMY(Empregado."Employment Date", 3)) then begin

                                            if (Date2DMY("Periodos Processamento"."Data Registo", 2) = Date2DMY(Empregado."End Date", 2)) and
                                               (Date2DMY("Periodos Processamento"."Data Registo", 3) = Date2DMY(Empregado."End Date", 3)) then begin
                                                DiasdoMes := CalcDate('1M-1D', DMY2Date(1, Date2DMY("Periodos Processamento"."Data Registo", 2),
                                                                                    Date2DMY("Periodos Processamento"."Data Registo", 3))) -
                                                        DMY2Date(1, Date2DMY("Periodos Processamento"."Data Registo", 2),
                                                                   Date2DMY("Periodos Processamento"."Data Registo", 3)) + 1;
                                                Valor := Valor / DiasdoMes * (Empregado."End Date" - Empregado."Employment Date" + 1);
                                            end;
                                        end else begin
                                            //Restantes casos
                                            if (Date2DMY("Periodos Processamento"."Data Registo", 2) = Date2DMY(Empregado."End Date", 2)) and
                                               (Date2DMY("Periodos Processamento"."Data Registo", 3) = Date2DMY(Empregado."End Date", 3)) then begin
                                                DiasdoMes := Empregado."End Date" - "Periodos Processamento"."Data Inicio Processamento" + 1;
                                                if DiasdoMes > 30 then DiasdoMes := 30;
                                                Valor := Valor / 30 * DiasdoMes;
                                            end;
                                        end;
                                    end;
                                    ProcessarEncSociais(Valor,
                                                              l_RubricaSalarialLinhas.Percentagem,
                                                              l_RubricaSalarialLinhas."Payroll Item Code",
                                                              l_RubricaSalarialEmpregado."Debit Acc. No.",
                                                              l_RubricaSalarialEmpregado."Credit Acc. No.");
                                end;
                            end;
                        until l_RubricaSalarial.Next = 0;
                    end;
                    TempRubricaEmpregado2.SetRange(TempRubricaEmpregado2."Cód. Rúbrica Salarial");
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
                    CabMovEmpregado."Employee No." := Empregado2."No.";
                    CabMovEmpregado."Designação Empregado" := Empregado2.Name;
                    CabMovEmpregado."Data Registo" := "Periodos Processamento"."Data Registo";
                    CabMovEmpregado."Usa Transferência Bancária" := Empregado."Usa Transf. Bancária";
                    CabMovEmpregado."Cód. Banco Transf." := Empregado."Cód. Banco Transf.";
                    CabMovEmpregado."No. Segurança Social" := Empregado."No. Segurança Social";
                    CabMovEmpregado."No. Contribuinte" := Empregado."No. Contribuinte";
                    CabMovEmpregado.IBAN := Empregado.IBAN;
                    CabMovEmpregado."Nº CGA" := Empregado."Nº CGA";
                    CabMovEmpregado.Seguradora := Empregado.Seguradora;
                    CabMovEmpregado."No. Apólice" := Empregado."No. Apólice";

                    GrauFuncaoEmpregado.Reset;
                    GrauFuncaoEmpregado.SetRange(GrauFuncaoEmpregado."Employee No.", Empregado."No.");
                    GrauFuncaoEmpregado.SetFilter(GrauFuncaoEmpregado."Data Inicio Grau Função", '<=%1', "Periodos Processamento"."Data Registo");
                    GrauFuncaoEmpregado.SetFilter(GrauFuncaoEmpregado."Data Fim Grau Função", '>=%1|%2', "Periodos Processamento"."Data Registo", 0D);
                    if GrauFuncaoEmpregado.Find('-') then
                        CabMovEmpregado."Grau Função" := GrauFuncaoEmpregado."Cód. Grau Função";

                    CatProfQPEmpregado.Reset;
                    CatProfQPEmpregado.SetRange(CatProfQPEmpregado."Employee No.", Empregado."No.");
                    CatProfQPEmpregado.SetFilter(CatProfQPEmpregado."Data Inicio Cat. Prof.", '<=%1', "Periodos Processamento"."Data Registo");
                    CatProfQPEmpregado.SetFilter(CatProfQPEmpregado."Data Fim Cat. Prof.", '>=%1|%2', "Periodos Processamento"."Data Registo", 0D);
                    if CatProfQPEmpregado.Find('-') then
                        CabMovEmpregado."Descrição Cat Prof QP" := CatProfQPEmpregado.Description;

                    CabMovEmpregado."Valor Vencimento Base" := FuncoesRH.CalcularVencimentoBase("Periodos Processamento"."Data Registo", Empregado);
                    if Empregado."No. Horas Semanais" <> 0.0 then
                        CabMovEmpregado."Valor Hora" := FuncoesRH.CalcularValorHora(CabMovEmpregado."Valor Vencimento Base", Empregado)
                    else
                        CabMovEmpregado."Valor Hora" := 0;

                    CabMovEmpregado."No. Horas Semanais" := Empregado."No. Horas Semanais";
                    CabMovEmpregado."Nº Horas Semanais Totais" := Empregado."No. Horas Semanais Totais";
                    CabMovEmpregado."Nº Horas Docência Calc. Desct." := Empregado."Nº Horas Docência Calc. Desct.";
                    CabMovEmpregado."Valor Incidência IRS" := ValorIncidenciaIRS;
                    //CabMovEmpregado."Valor Incidência IRS" := RecalcularValordeIncidenciaIRSJovem(ValorIncidenciaIRS, Empregado);

                    CabMovEmpregado."Valor para Escalão Sobretaxa" := ValorEscalaoSobretaxa; //2016.01.08  -Sobretaxa 2016
                    CabMovEmpregado."Vacation Days Received" := CalcularDiasFeriasDireito(Empregado."No.");
                    CabMovEmpregado."Vacation Days Spent" := CalcularDiasFeriasGastos(Empregado."No.");
                    CabMovEmpregado."Vacation Days Balance" := CabMovEmpregado."Vacation Days Received" - CabMovEmpregado."Vacation Days Spent";
                    CabMovEmpregado.Insert;

                    TempRubricaEmpregado2.SetCurrentKey(TempRubricaEmpregado2."Employee No.", TempRubricaEmpregado2.Sort,
                    TempRubricaEmpregado2."Cód. Rúbrica Salarial", "Data a que se refere o mov", TempRubricaEmpregado2."Unit of Measure");
                    if TempRubricaEmpregado2.FindSet then begin
                        repeat
                            //Se a rubrica da falta for diferente, ou for de outro mes, ou tiver outra unidade medida, cria uma nova linha
                            if (VarCodRubrica <> TempRubricaEmpregado2."Cód. Rúbrica Salarial") then begin
                                InserirDadosCabMovEmp;
                            end else begin
                                if (TempRubricaEmpregado2."Data a que se refere o mov" <> 0D) then begin
                                    //IT001 - JTP - 2020.06.08 - Begin
                                    if varDataFalta = 0D then
                                        InserirDadosCabMovEmp
                                    else
                                        //IT001 - JTP - 2020.06.08 - End
                                        if (Date2DMY(varDataFalta, 2) <> Date2DMY(TempRubricaEmpregado2."Data a que se refere o mov", 2)) or
                                          //IT001 - JTP - 2020.06.08
                                          (Date2DMY(varDataFalta, 3) <> Date2DMY(TempRubricaEmpregado2."Data a que se refere o mov", 3))
                                         then begin
                                            InserirDadosCabMovEmp;
                                        end else begin
                                            if TempRubricaEmpregado2."Unit of Measure" <> varUnidadeMedida then begin
                                                InserirDadosCabMovEmp;
                                            end else begin
                                                LinhaMovEmpregado.Quantity := LinhaMovEmpregado.Quantity + TempRubricaEmpregado2.Quantity;
                                                LinhaMovEmpregado.Valor := LinhaMovEmpregado.Valor + TempRubricaEmpregado2."Total Amount";
                                                //Faço a actualização da valor da data de modo a que a data inserida seja a data de inicio da ultima falta
                                                LinhaMovEmpregado."Data a que se refere o mov" := TempRubricaEmpregado2."Data a que se refere o mov";

                                                //este código é para faltas aparecerem no recido em dias ou horas consoante o que foi lançado
                                                LinhaMovEmpregado."Quatidade Recibo Vencimentos" := LinhaMovEmpregado."Quatidade Recibo Vencimentos" +
                                                                                                  TempRubricaEmpregado2."Quatidade Recibo Vencimentos";
                                                //novo campo por causa do codigo contributivo
                                                if TempRubricaEmpregado2."Valor Incidência SS" = 0 then begin
                                                    TempRubricaEmpregado.Reset;
                                                    TempRubricaEmpregado.SetRange(TempRubricaEmpregado."Employee No.", TempRubricaEmpregado2."Employee No.");
                                                    TempRubricaEmpregado.SetRange(TempRubricaEmpregado."Line No.", TempRubricaEmpregado2."Line No.");
                                                    if TempRubricaEmpregado.Find('-') then
                                                        LinhaMovEmpregado."Valor Incidência SS" := LinhaMovEmpregado."Valor Incidência SS" +
                                                                                                   TempRubricaEmpregado."Valor Incidência SS"
                                                end else
                                                    LinhaMovEmpregado."Valor Incidência SS" := LinhaMovEmpregado."Valor Incidência SS" +
                                                                                               TempRubricaEmpregado2."Valor Incidência SS";
                                                LinhaMovEmpregado.Modify;
                                            end;
                                        end;
                                end else begin
                                    if TempRubricaEmpregado2."Unit of Measure" <> varUnidadeMedida then begin
                                        InserirDadosCabMovEmp;
                                    end else begin
                                        LinhaMovEmpregado.Quantity := LinhaMovEmpregado.Quantity + TempRubricaEmpregado2.Quantity;
                                        LinhaMovEmpregado.Valor := LinhaMovEmpregado.Valor + TempRubricaEmpregado2."Total Amount";
                                        //Faço a actualização da valor da data de modo a que a data inserida seja a data de inicio da ultima falta
                                        LinhaMovEmpregado."Data a que se refere o mov" := TempRubricaEmpregado2."Data a que se refere o mov";
                                        //este código é para faltas aparecerem no recido em dias ou horas consoante o que foi lançado
                                        LinhaMovEmpregado."Quatidade Recibo Vencimentos" := LinhaMovEmpregado."Quatidade Recibo Vencimentos" +
                                                                                            TempRubricaEmpregado2."Quatidade Recibo Vencimentos";
                                        //novo campo por causa do codigo contributivo
                                        if TempRubricaEmpregado2."Valor Incidência SS" = 0 then begin
                                            TempRubricaEmpregado.Reset;
                                            TempRubricaEmpregado.SetRange(TempRubricaEmpregado."Employee No.", TempRubricaEmpregado2."Employee No.");
                                            TempRubricaEmpregado.SetRange(TempRubricaEmpregado."Line No.", TempRubricaEmpregado2."Line No.");
                                            if TempRubricaEmpregado.Find('-') then
                                                LinhaMovEmpregado."Valor Incidência SS" := LinhaMovEmpregado."Valor Incidência SS" +
                                                                                           TempRubricaEmpregado."Valor Incidência SS"
                                        end else
                                            LinhaMovEmpregado."Valor Incidência SS" := LinhaMovEmpregado."Valor Incidência SS" +
                                                                                       TempRubricaEmpregado2."Valor Incidência SS";
                                        LinhaMovEmpregado.Modify;
                                    end;
                                end;
                            end;
                            varDataFalta := TempRubricaEmpregado2."Data a que se refere o mov";
                            VarCodRubrica := TempRubricaEmpregado2."Cód. Rúbrica Salarial";
                            varUnidadeMedida := TempRubricaEmpregado2."Unit of Measure";
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
                        rCabMovEmp.SetRange(rCabMovEmp."Tipo Processamento", rCabMovEmp."Tipo Processamento"::Vencimentos);
                        rCabMovEmp.SetRange("Employee No.", Empregado."No.");
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
                                rLinhaMovEmp."Tipo Processamento" := rLinhaMovEmp."Tipo Processamento"::Vencimentos;
                                rLinhaMovEmp.Validate("Employee No.", Empregado."No.");
                                rLinhaMovEmp."No. Linha" := NLinha;
                                rLinhaMovEmp."Data Registo" := "Periodos Processamento"."Data Registo";
                                rLinhaMovEmp.Validate("Payroll Item Code", rPenhora."Garnishment Rubric");

                                rLinhaMovEmp.Quantity := 1;
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
            var
                lRubSal: Record "Payroll Item";
                lAbonosDesc: Record "Abonos - Descontos Extra";
                Flag: Boolean;
            begin
                if (Empregado."Employment Date" > "Periodos Processamento"."Data Fim Processamento") then
                    CurrReport.Skip
                else begin
                    Empregado.TestField(Empregado."Tipo Contribuinte");
                    if Empregado."Tipo Contribuinte" = Empregado."Tipo Contribuinte"::"Conta de Outrem" then begin
                        Empregado.TestField(Empregado."Employment Date");
                        Empregado.TestField(Empregado.Estabelecimento);
                        if Empregado."Subscritor SS" then begin
                            Empregado.TestField(Empregado."Cod. Instituição SS");
                            Empregado.TestField(Empregado."Cod. Regime SS");
                            Empregado.TestField(Empregado."Cód. Rúbrica Enc. Seg. Social");
                        end;
                        Empregado.TestField(Empregado."No. Horas Semanais");
                        Empregado.TestField(Empregado."No. dias de Trabalho Semanal");
                    end;
                end;

                //2018.05.18 - Lançar automaticamente a rubrica Admissão/Demissão, sn
                if Empregado."Tipo Contribuinte" = Empregado."Tipo Contribuinte"::"Conta de Outrem" then begin
                    if ((Empregado."Employment Date" >= "Periodos Processamento"."Data Inicio Processamento") and
                       (Empregado."Employment Date" <= "Periodos Processamento"."Data Fim Processamento"))
                       or
                       ((Empregado."End Date" >= "Periodos Processamento"."Data Inicio Processamento") and
                       (Empregado."End Date" <= "Periodos Processamento"."Data Fim Processamento")) then begin

                        Flag := false;
                        lRubSal.Reset;
                        lRubSal.SetRange(lRubSal.Genero, lRubSal.Genero::"Admissão-Demissão");
                        if lRubSal.FindFirst then begin
                            lAbonosDesc.Reset;
                            lAbonosDesc.SetRange(lAbonosDesc."Employee No.", Empregado."No.");
                            lAbonosDesc.SetRange(lAbonosDesc."Payroll Item Code", lRubSal.Código);
                            if lAbonosDesc.FindFirst then begin
                                if Confirm(StrSubstNo(Text0040, Empregado."No.")) then begin
                                    Flag := true;
                                    lAbonosDesc.Delete;
                                end;
                            end else
                                Flag := true;

                            if Flag = true then begin
                                //Entrada
                                if (Date2DMY(Empregado."Employment Date", 1) <> 1) and
                                   (Empregado."Employment Date" >= "Periodos Processamento"."Data Inicio Processamento") and
                                   (Empregado."Employment Date" <= "Periodos Processamento"."Data Fim Processamento") then begin
                                    lAbonosDesc.Init;
                                    lAbonosDesc.Validate(lAbonosDesc."Employee No.", Empregado."No.");
                                    lAbonosDesc.Validate(lAbonosDesc.Date, "Periodos Processamento"."Data Registo");
                                    lAbonosDesc.Validate(lAbonosDesc."Payroll Item Code", lRubSal.Código);
                                    lAbonosDesc.Validate(lAbonosDesc.Quantity, 30 - ("Periodos Processamento"."Data Fim Processamento" - Empregado."Employment Date" + 1));
                                    //Empregados a tempo parcial
                                    if Empregado."Regime Duração Trabalho" = 2 then
                                        lAbonosDesc.Validate(lAbonosDesc.Quantity, Round(lAbonosDesc.Quantity * Empregado."No. Dias Trabalho Mensal" / 30, 1, '='));
                                    lAbonosDesc.Validate(lAbonosDesc."Unit of Measure", TabConfRH."Base Unit of Measure");
                                    //IT002 - JTP - 2020.07.21
                                    lAbonosDesc.Validate("Qty. Food Subsidy Loss", FuncoesRH.CalcularDiasUteisMes(Empregado.Estabelecimento,
                                                               "Periodos Processamento"."Data Inicio Processamento",
                                                               Empregado."Employment Date" - 1));
                                    lAbonosDesc.Insert(true);
                                end;
                                //Saídas
                                if (Empregado."End Date" >= "Periodos Processamento"."Data Inicio Processamento") and
                                   (Empregado."End Date" <= "Periodos Processamento"."Data Fim Processamento") then begin
                                    if (30 - Date2DMY(Empregado."End Date", 1)) > 0 then begin
                                        lAbonosDesc.Init;
                                        lAbonosDesc.Validate(lAbonosDesc."Employee No.", Empregado."No.");
                                        lAbonosDesc.Validate(lAbonosDesc.Date, "Periodos Processamento"."Data Registo");
                                        lAbonosDesc.Validate(lAbonosDesc."Payroll Item Code", lRubSal.Código);
                                        lAbonosDesc.Validate(lAbonosDesc.Quantity, 30 - Date2DMY(Empregado."End Date", 1));
                                        // Empregados a tempo parcial
                                        if Empregado."Regime Duração Trabalho" = 2 then
                                            lAbonosDesc.Validate(lAbonosDesc.Quantity, Round(lAbonosDesc.Quantity * Empregado."No. Dias Trabalho Mensal" / 30, 1, '='));

                                        lAbonosDesc.Validate(lAbonosDesc."Unit of Measure", TabConfRH."Base Unit of Measure");
                                        lAbonosDesc.Insert(true);
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;


                if (Empregado."Tipo Contribuinte" = Empregado."Tipo Contribuinte"::"Conta de Outrem") and (Empregado."No. Dias Trabalho Mensal" = 0) then
                    Error(Text0035, Empregado."No.");

                //se houver fichas em branco, dá mensagem de aviso
                if Empregado.Name = '' then begin
                    Message(Text0032, Empregado."No.");
                    CurrReport.Skip;
                end;

                //Se for independente não pode processar se estiver inactivo
                if (Empregado.Status = Empregado.Status::Inactive) and
                (Empregado."Tipo Contribuinte" = Empregado."Tipo Contribuinte"::"Trabalhador Independente") then
                    CurrReport.Skip;

                //Fecho Contas
                if (Empregado."End Date" <> 0D) and (Empregado."End Date" < "Periodos Processamento"."Data Inicio Processamento") then begin
                    Empregado.Status := Empregado.Status::Terminated;
                    Empregado.Modify;
                    CurrReport.Skip;
                end;

                //Fecho de contas
                FlagSF := false;
                FlagSN := false;


                //Limpar as tabelas temporárias
                TempRubricaEmpregado.Reset;
                TempRubricaEmpregado2.Reset;
                TempRubricaEmpregado.DeleteAll;
                TempRubricaEmpregado2.DeleteAll;
                TempRubricaEmpregadoValorTotalSemPercentagem.DeleteAll();
                TempRubricaEmpregadoDeducts.DeleteAll();
                NLinha := 0;
                NLinha2 := 0;
                VarAbateSubAlimentacao := 0;
                ValorTotalSubFerias := 0;
                ValorIncidenciaIRS := 0;
                ValorEscalaoSobretaxa := 0;
                ValorTotalAbonosBrutoIRS := 0;

                //Ver se já existe processamento para esse empregado para esse periodo (Cod Processamento)
                //Caso exista, pergunta ao utilizador se quer substituir
                CabMovEmpregado.Reset;
                CabMovEmpregado.SetRange(CabMovEmpregado."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                CabMovEmpregado.SetFilter(CabMovEmpregado."Tipo Processamento", '%1|%2',
                CabMovEmpregado."Tipo Processamento"::Vencimentos, CabMovEmpregado."Tipo Processamento"::Encargos);
                CabMovEmpregado.SetRange(CabMovEmpregado."Employee No.", Empregado."No.");
                if CabMovEmpregado.FindFirst then begin
                    if not first then begin
                        if Confirm(Text0006, true) then begin
                            CabMovEmpregado.DeleteAll;
                            LinhaMovEmpregado.SetRange(LinhaMovEmpregado."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                            LinhaMovEmpregado.SetFilter(LinhaMovEmpregado."Tipo Processamento", '%1|%2',
                            LinhaMovEmpregado."Tipo Processamento"::Vencimentos, LinhaMovEmpregado."Tipo Processamento"::Encargos);
                            LinhaMovEmpregado.SetRange(LinhaMovEmpregado."Employee No.", Empregado."No.");
                            if LinhaMovEmpregado.FindFirst then begin
                                LinhaMovEmpregado.DeleteAll;
                            end;
                        end else
                            CurrReport.Skip;
                        first := true;
                    end else begin
                        CabMovEmpregado.DeleteAll;
                        LinhaMovEmpregado.SetRange(LinhaMovEmpregado."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                        LinhaMovEmpregado.SetFilter(LinhaMovEmpregado."Tipo Processamento", '%1|%2',
                        LinhaMovEmpregado."Tipo Processamento"::Vencimentos, LinhaMovEmpregado."Tipo Processamento"::Encargos);
                        LinhaMovEmpregado.SetRange(LinhaMovEmpregado."Employee No.", Empregado."No.");
                        if LinhaMovEmpregado.Find('-') then begin
                            LinhaMovEmpregado.DeleteAll;
                        end;
                    end;
                end;

                //*******************************
                //Actualizar o Campo Gozo de Férias
                //*******************************
                TabFeriasEmpregado.Reset;
                TabFeriasEmpregado.SetRange(TabFeriasEmpregado."Employee No.", Empregado."No.");
                TabFeriasEmpregado.SetRange(TabFeriasEmpregado.Data, "Periodos Processamento"."Data Inicio Processamento",
                                            "Periodos Processamento"."Data Fim Processamento");
                if TabFeriasEmpregado.FindSet then begin
                    TabFeriasEmpregado.ModifyAll(TabFeriasEmpregado.Gozada, true);
                    TabFeriasEmpregado.ModifyAll("Processamento Referencia", "Periodos Processamento"."Cód. Processamento");
                    //Abater o sub. alimentação, por cada dia de férias marcado
                    if TabConfRH."Abate Sub. Alim. dias gozo fer" then begin
                        repeat
                            if TabFeriasEmpregado.Tipo = TabFeriasEmpregado.Tipo::ferias then
                                VarAbateSubAlimentacao := VarAbateSubAlimentacao + 1;
                        until TabFeriasEmpregado.Next = 0;
                    end;
                end;

                i += 1;
                window.Update(1, Round(i * 100 / counts * 100, 1));

                DataInicoMes := DMY2Date(1, Date2DMY(WorkDate, 2), Date2DMY(WorkDate, 3));
                DataFimMes := CalcDate('+1M-1D', DataInicoMes);

                HistoricoEmpregado.Reset;
                HistoricoEmpregado.SetRange("No.", Empregado."No.");
                HistoricoEmpregado.SetRange("Data Registo", "Periodos Processamento"."Data Registo");
                HistoricoEmpregado.SetRange("Cod Processamento", "Periodos Processamento"."Cód. Processamento");
                if HistoricoEmpregado.FindFirst then begin
                    HistoricoEmpregado."Data Registo" := "Periodos Processamento"."Data Registo";
                    HistoricoEmpregado."Cod Processamento" := "Periodos Processamento"."Cód. Processamento";
                    HistoricoEmpregado.Modify;
                end else begin
                    HistoricoEmpregado.Init;
                    HistoricoEmpregado.TransferFields(Empregado);
                    HistoricoEmpregado."Data Registo" := "Periodos Processamento"."Data Registo";
                    HistoricoEmpregado."Cod Processamento" := "Periodos Processamento"."Cód. Processamento";
                    HistoricoEmpregado.Insert;
                end;
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
                    CabMovEmpregado."Tipo Processamento"::Vencimentos, CabMovEmpregado."Tipo Processamento"::Encargos);
                    ApagaEmp := CopyStr(ApagaEmp, 1, StrLen(ApagaEmp) - 1);
                    CabMovEmpregado.SetFilter(CabMovEmpregado."Employee No.", ApagaEmp);
                    if CabMovEmpregado.FindFirst then begin
                        if Confirm(Text0017, true, ApagaEmp) then begin
                            CabMovEmpregado.DeleteAll;
                            LinhaMovEmpregado.SetRange(LinhaMovEmpregado."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                            LinhaMovEmpregado.SetFilter(LinhaMovEmpregado."Tipo Processamento", '%1|%2',
                            LinhaMovEmpregado."Tipo Processamento"::Vencimentos, LinhaMovEmpregado."Tipo Processamento"::Encargos);
                            LinhaMovEmpregado.SetFilter(LinhaMovEmpregado."Employee No.", ApagaEmp);
                            if LinhaMovEmpregado.FindFirst then
                                LinhaMovEmpregado.DeleteAll;
                        end;
                    end;
                end;
                window.Close;
            end;

            trigger OnPreDataItem()
            begin
                //----------------------------------------
                SetFilter("Data Filtro Inicio", '<=%1', "Periodos Processamento"."Data Fim Processamento");
                SetFilter("Data Filtro Fim", '>=%1|=%2', "Periodos Processamento"."Data Inicio Processamento", 0D);

                if ApagaTodosEmp then begin
                    CabMovEmpregado.Reset;
                    CabMovEmpregado.SetRange(CabMovEmpregado."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                    CabMovEmpregado.SetFilter(CabMovEmpregado."Tipo Processamento", '%1|%2',
                    CabMovEmpregado."Tipo Processamento"::Vencimentos, CabMovEmpregado."Tipo Processamento"::Encargos);
                    if CabMovEmpregado.FindFirst then begin
                        if Confirm(Text0025, true) then begin
                            CabMovEmpregado.DeleteAll;
                            LinhaMovEmpregado.Reset;
                            LinhaMovEmpregado.SetRange(LinhaMovEmpregado."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                            LinhaMovEmpregado.SetFilter(LinhaMovEmpregado."Tipo Processamento", '%1|%2',
                            LinhaMovEmpregado."Tipo Processamento"::Vencimentos, LinhaMovEmpregado."Tipo Processamento"::Encargos);
                            if LinhaMovEmpregado.FindFirst then begin
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

                //para guardar os filtros do empregado para quando chamar a sobretaxa
                FiltroEmpregado.CopyFilters(Empregado);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group("Periodo Processamento")
                {
                    Caption = 'Periodo Processamento';
                    field(PeriodoCode; PeriodoCode)
                    {
                        ApplicationArea = HumanResourcesAppArea;
                        Caption = 'Periodo Processamento';
                        TableRelation = "Periodos Processamento";
                    }
                    field(FiltroDataInicioFalta; FiltroDataInicioFalta)
                    {
                        ApplicationArea = HumanResourcesAppArea;
                        Caption = 'Data Início de Falta';
                    }
                    field(FiltroDataFimFalta; FiltroDataFimFalta)
                    {
                        ApplicationArea = HumanResourcesAppArea;
                        Caption = 'Data Fim de Falta';
                    }
                    field(varCriarRetroactivo; varCriarRetroactivo)
                    {
                        ApplicationArea = HumanResourcesAppArea;
                        Caption = 'Processar Retroactivos IRS';
                    }
                    field(ProcessarSobretaxa; ProcessarSobretaxa)
                    {
                        ApplicationArea = HumanResourcesAppArea;
                        Caption = 'Processar Sobretaxa';
                        Visible = false;
                    }
                }
                group("Apagar Processamento de Empregado")
                {
                    Caption = 'Apagar Processamento de Empregado';
                    field(ApagaEmp; ApagaEmp)
                    {
                        ApplicationArea = HumanResourcesAppArea;
                        Caption = 'Nº Empregado a apagar';
                        TableRelation = Empregado;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            recEmpregado: Record Empregado;
                        begin

                            //C+ - RSC - RH-009 - 11.01.2007
                            if Text = '' then
                                ApagaEmp := '';

                            recEmpregado.Reset;
                            recEmpregado.SetFilter("Data Filtro Inicio", '<=%1', "Periodos Processamento"."Data Fim Processamento");
                            recEmpregado.SetFilter("Data Filtro Fim", '>=%1|=%2', "Periodos Processamento"."Data Inicio Processamento", 0D);
                            if recEmpregado.Find('-') then begin
                                if PAGE.RunModal(0, recEmpregado) = ACTION::LookupOK then begin
                                    ApagaEmp += recEmpregado."No." + '|';
                                end;
                            end;
                            //C+ - RSC - RH-009 - 11.01.2007
                        end;
                    }
                    field(ApagaTodosEmp; ApagaTodosEmp)
                    {
                        ApplicationArea = HumanResourcesAppArea;
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

    #region TRIGGERS
    trigger OnPostReport()
    begin
        "Periodos Processamento"."Data Inicio Proces. Faltas" := FiltroDataInicioFalta;
        "Periodos Processamento"."Data Fim Proces. Faltas" := FiltroDataFimFalta;
        "Periodos Processamento".Modify;

        //Processar logo a sobretaxa
        if ProcessarSobretaxa then begin
            Sobretaxa.SetFiltros("Periodos Processamento"."Cód. Processamento", FiltroEmpregado);
            Sobretaxa.Run;
        end;
    end;

    trigger OnPreReport()
    begin
        if FiltroDataInicioFalta = 0D then
            Error(Text0007);
        if FiltroDataFimFalta = 0D then
            Error(Text0008);

        if FiltroDataInicioFalta > FiltroDataFimFalta then
            Error(Text0009);
    end;
    #endregion

    #region VARIABLES
    var
        DeductValue: Decimal;
        Text0001: Label 'Este Processamento encontra-se Fechado.';
        Text0002: Label 'Deve escolher um processamento do tipo Vencimentos.';
        RubricaSalaEmpregado: Record "Rubrica Salarial Empregado";
        RubricaSalaEmpregado2: Record "Rubrica Salarial Empregado";
        RubricaSalariaLinhas: Record "Rubrica Salarial Linhas";
        RubricaSalariaLinhas2: Record "Rubrica Salarial Linhas";
        TempRubricaEmpregado: Record "Rubrica Salarial Empregado" temporary;
        TempRubricaEmpregado2: Record "Rubrica Salarial Empregado" temporary;
        TempRubricaEmpregadoDeducts: Record "Rubrica Salarial Empregado" temporary;
        TempRubricaEmpregadoValorTotalSemPercentagem: Record "Rubrica Salarial Empregado" temporary;
        CabMovEmpregado: Record "Cab. Movs. Empregado";
        LinhaMovEmpregado: Record "Linhas Movs. Empregado";
        NLinha: Integer;
        Text0003: Label 'Já existe um processamento para o Empregado %1 para este periodo. Deseja substituí-lo?';
        NLinha2: Integer;
        FuncoesRH: Codeunit "Funções RH";
        TabRubricaSalarial: Record "Payroll Item";
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
        AuxTabRubricaSalarial: Record "Payroll Item";
        AuxTabRubricaSalLinhas: Record "Rubrica Salarial Linhas";
        AuxTabRubricaEmpregado: Record "Rubrica Salarial Empregado";
        TabFeriasEmpregado: Record "Férias Empregados";
        TabIRS: Record "Tabela IRS";
        TabHistLinhaMovEmp: Record "Hist. Linhas Movs. Empregado";
        TabHistLinhaMovEmp2: Record "Hist. Linhas Movs. Empregado";
        TempRubricaEmpregado3: Record "Rubrica Salarial Empregado" temporary;
        varCriarRetroactivo: Boolean;
        TabLinhaMovEmp: Record "Linhas Movs. Empregado";
        TabRubSal: Record "Payroll Item";
        TabRubSalLinha: Record "Rubrica Salarial Linhas";
        VarValorTotal2: Decimal;
        VarValorTotal3: Decimal;
        ValorTotalAbonosBrutoIRS: Decimal;
        TabInactiviEmpregado: Record "Inactividade Empregado";
        Text0004: Label 'Processamento terminado.';
        Text0005: Label 'Barra de Progresso @1@@@@@@@@@';
        TabEmpregado: Record Empregado;
        counts: Integer;
        i: Integer;
        window: Dialog;
        first: Boolean;
        Text0006: Label 'Já existe processamentos dos empregados para este período, deseja substituí-los?';
        ValorAbonosIRS: Decimal;
        ValorAbonosSS: Decimal;
        ValorAbonosCGA: Decimal;
        ValorAbonosADSE: Decimal;
        ValorDesc1: Decimal;
        ValorDescSS: Decimal;
        ValorDescCGA: Decimal;
        ValorDescADSE: Decimal;
        Rubrica: Code[20];
        Rubrica2: Code[20];
        Rubrica3: Code[20];
        Rubrica4: Code[20];
        Rubrica5: Code[20];
        Rubrica6: Code[20];
        FIltroRubricas: Text[250];
        FiltroDataInicioFalta: Date;
        FiltroDataFimFalta: Date;
        Text0007: Label 'Tem obrigatoriamente de preencher o campo Data Início do Período Processamento da Falta.';
        Text0008: Label 'Tem obrigatoriamente de preencher o campo Data Fim do Período Processamento da Falta.';
        Text0009: Label 'A Data Início do Período Processamento da Falta não pode ser superior a Data Fim do Período Processamento da Falta.';
        RubricaSalarial2: Record "Payroll Item";
        varDataFalta: Date;
        TabRubSal2: Record "Payroll Item";
        ApagaEmp: Text[250];
        Text0017: Label 'Tem a certeza que deseja apagar o processamento para os seguintes Empregados: %1 para este período?';
        ApagaTodosEmp: Boolean;
        Text0025: Label 'Tem a certeza que deseja apagar o processamento para todos os empregados?';
        UnidMedidaRH: Record "Unid. Medida Recursos Humanos";
        Text0030: Label 'Falta parametrizar a unidade de medida na ausencia do dia %1 do empregado %2.';
        QtdAProcessarRecVen: Decimal;
        varUnidadeMedida: Code[20];
        TabAusenciasNRemun: Record "Ausência Empregado";
        DataInicoMes: Date;
        DataFimMes: Date;
        HistoricoEmpregado: Record "Historico Empregado";
        TabRubricaSalAux: Record "Payroll Item";
        GrauFuncaoEmpregado: Record "Grau Função Empregado";
        GrauFuncao: Record "Grau Função";
        Nivel: Code[20];
        ContratoEmp: Record "Contrato Empregado";
        Text0031: Label 'O emprgado %1 não tem um contrato activo, como tal não é possível o calculo automático do Subsídio.';
        DataUltAcertoSF: Date;
        DataFimProcSubFerias: Date;
        ValorTotalSubFerias: Decimal;
        Text0032: Label 'O empregado %1 não tem nome preenchido. Elimine a sua ficha.';
        NumLinha: Integer;
        FlagSF: Boolean;
        FlagSN: Boolean;
        Text0033: Label 'O cod. de medida não existe.';
        TempVarValorTotal: Decimal;
        ValorIncidenciaIRS: Decimal;
        DiasdoMes: Integer;
        NumDias: Decimal;
        MesesTrabalhados: Decimal;
        PeriodoCode: Code[10];
        ProcessarSobretaxa: Boolean;
        Sobretaxa: Report "Sobretaxa em Sede IRS 2013";
        FiltroEmpregado: Record Empregado;
        TabContratoEmp: Record "Contrato Empregado";
        Text0029: Label 'O Empregado %1 encontra-se activo, mas não tem um contrato de trabalho em vigor e como tal não será processado.';
        ValorEscalaoSobretaxa: Decimal;
        Text0035: Label 'Corra a rotina Calcular Valor Dia e Hora para o empregado %1.';
        ValorVBparaDuoSF: Decimal;
        auxTempRubricaEmpregado: Record "Rubrica Salarial Empregado" temporary;
        recCatProfIntEmp: Record "Cat. Prof. Int. Empregado";
        DescTaxaIRS: Decimal;
        Text0040: Label 'Já existe uma Rubrica de Admissão/Demissão para o empregado %1. Deseja substituir?';
        DiasTrabMesAdmissao: Integer;
        DiasDesc: Integer;
        GuardaAbateSubAlim: Integer;
        ValorTotalSemDeduct: Decimal;
    #endregion

    #region CHANGES TO PROCESSING
    /// <summary>
    /// Deprecated
    /// </summary>
    procedure deprecated_InserirDadosCabMovEmp()
    var
        l_RubSal: Record "Payroll Item";
    begin
        NLinha := NLinha + 10000;
        LinhaMovEmpregado.Init;
        LinhaMovEmpregado."Cód. Processamento" := "Periodos Processamento"."Cód. Processamento";
        LinhaMovEmpregado."Tipo Processamento" := "Periodos Processamento"."Tipo Processamento";
        LinhaMovEmpregado."Employee No." := Empregado2."No.";
        LinhaMovEmpregado."No. Linha" := NLinha;
        LinhaMovEmpregado."Data Registo" := "Periodos Processamento"."Data Registo";
        LinhaMovEmpregado."Designação Empregado" := Empregado2.Name;
        LinhaMovEmpregado."Payroll Item Code" := TempRubricaEmpregado2."Cód. Rúbrica Salarial";
        LinhaMovEmpregado."Payroll Item Description" := TempRubricaEmpregado2."Payroll Item Description";
        //Retroactivos de IRS:
        //O Código da Rubrica fica = Código da Rubrica de IRS seja qual for
        //A Descrição da Rubrica fica fixa -->'Retroactivos de IRS de ' + mês
        if CopyStr(TempRubricaEmpregado2."Cód. Rúbrica Salarial", 1, 9) = 'IRS RETRO' then begin
            LinhaMovEmpregado."Payroll Item Code" := TempRubricaEmpregado2."Payroll Item Description";
            LinhaMovEmpregado."Payroll Item Description" := 'Retroactivos de IRS de ' +
                                                      CopyStr(TempRubricaEmpregado2."Cód. Rúbrica Salarial", 10);
        end;
        //Retroactivos de IRS - Fim

        LinhaMovEmpregado."Payroll Item Type" := TempRubricaEmpregado2."Payroll Item Type";
        LinhaMovEmpregado."Debit Acc. No." := TempRubricaEmpregado2."Debit Acc. No.";
        LinhaMovEmpregado."Credit Acc. No." := TempRubricaEmpregado2."Credit Acc. No.";
        LinhaMovEmpregado.Quantity := TempRubricaEmpregado2.Quantity;

        //este código é para faltas aparecerem no recido em dias ou horas consoante o que foi lançado
        LinhaMovEmpregado."Quatidade Recibo Vencimentos" := TempRubricaEmpregado2."Quatidade Recibo Vencimentos";
        LinhaMovEmpregado."Unit of Measure" := TempRubricaEmpregado2."Unit of Measure";

        LinhaMovEmpregado."Unit Value" := TempRubricaEmpregado2."Unit Value";
        LinhaMovEmpregado.Valor := TempRubricaEmpregado2."Total Amount";

        //Preencher o Tipo Rendimento por causa do Anexo J
        LinhaMovEmpregado."Tipo Rendimento" := Empregado2."Tipo Rendimento";
        LinhaMovEmpregado."Cód. Situação" := TempRubricaEmpregado2."Cód. Situação";
        LinhaMovEmpregado."Cód. Movimento" := TempRubricaEmpregado2."Cód. Movimento";
        LinhaMovEmpregado."Data Efeito" := TempRubricaEmpregado2."Data Efeito";

        //preencher o campo Natrem uma vez que deixou de ser FlowField
        TabRubSal.Reset;
        if TabRubSal.Get(TempRubricaEmpregado2."Cód. Rúbrica Salarial") then
            LinhaMovEmpregado.NATREM := TabRubSal.NATREM;


        //Preencher campos data inicio e data fim caso a rubricas seja do genero falta
        //RubricaSalarial2.RESET;
        //RubricaSalarial2.SETRANGE(Código,TempRubricaEmpregado2."Cód. Rúbrica Salarial");
        //IF RubricaSalarial2.FIND('-') THEN BEGIN
        //  IF (RubricaSalarial2.Genero = RubricaSalarial2.Genero::Falta)THEN BEGIN
        LinhaMovEmpregado."Data a que se refere o mov" := TempRubricaEmpregado2."Data a que se refere o mov";
        //  END;
        //END;


        //novo campo por causa do codigo contributivo
        if TempRubricaEmpregado2."Valor Incidência SS" = 0 then begin
            TempRubricaEmpregado.Reset;
            TempRubricaEmpregado.SetRange(TempRubricaEmpregado."Employee No.", TempRubricaEmpregado2."Employee No.");
            TempRubricaEmpregado.SetRange(TempRubricaEmpregado."Line No.", TempRubricaEmpregado2."Line No.");
            if TempRubricaEmpregado.FindFirst then
                LinhaMovEmpregado."Valor Incidência SS" := TempRubricaEmpregado."Valor Incidência SS"
        end else
            LinhaMovEmpregado."Valor Incidência SS" := TempRubricaEmpregado2."Valor Incidência SS";

        //preencher as dimensões das horas extra  e abonos / descontos extra
        LinhaMovEmpregado."Global Dimension 1 Code" := TempRubricaEmpregado."Global Dimension 1 Code";
        LinhaMovEmpregado."Global Dimension 2 Code" := TempRubricaEmpregado."Global Dimension 2 Code";

        //para preencher o campo que vai ser usado no Mapa Declaração Mensal Remunerações AT
        l_RubSal.Reset;
        if l_RubSal.Get(TempRubricaEmpregado2."Cód. Rúbrica Salarial") then begin
            LinhaMovEmpregado."Tipo Rendimento Cat.A" := l_RubSal."Tipo Rendimento Cat.A";
        end;

        LinhaMovEmpregado."Garnishmen No." := TempRubricaEmpregado2."Garnishmen No.";
        LinhaMovEmpregado.Insert;
    end;

    /// <summary>
    /// Timesheet Validation
    /// </summary>
    local procedure InserirDadosCabMovEmp()
    var
        timeSheetDetail: Record "Time Sheet Detail";
        job: Record Job;
        hoursTotal: Decimal;
        tempJobHours: List of [Decimal];
        tempJobNo: List of [Code[20]];
        jobIndex: Integer;
        jobNameTemp: Text;
    begin
        timeSheetDetail.Reset();
        timeSheetDetail.SetRange("Resource No.", Empregado."No."); //DUVIDA. Como é feito o match?m
        timeSheetDetail.SetFilter(Date, '%1..%2', "Periodos Processamento"."Data Inicio Processamento", "Periodos Processamento"."Data Fim Processamento");

        //Count day by day.
        if timeSheetDetail.FindSet() then
            repeat
                if not tempJobNo.Contains(timeSheetDetail."Job No.") then begin
                    tempJobHours.Add(timeSheetDetail.Quantity);
                    tempJobNo.Add(timeSheetDetail."Job No.");
                end else begin
                    jobIndex := tempJobNo.IndexOf(timeSheetDetail."Job No.");
                    tempJobHours.Set(jobIndex, tempJobHours.Get(jobIndex) + timeSheetDetail.Quantity);
                end;

                hoursTotal += timeSheetDetail.Quantity;
            until timeSheetDetail.Next() = 0;

        //Descontruir a linha
        if tempJobHours.Count() > 0 then begin
            for i := 1 to tempJobHours.Count() do begin
                Clear(job);
                job.Get(tempJobNo.Get(i));
                ExecuteInserirDadosCabMovEmp(tempJobHours.Get(i) / hoursTotal * TempRubricaEmpregado2."Total Amount", job.Description
                );
            end
        end else begin
            ExecuteInserirDadosCabMovEmp(TempRubricaEmpregado2."Total Amount", '');
        end;
    end;

    /// <summary>
    /// Insert on table taking in consideration the percentages based on the timesheet hours.
    /// </summary>
    local procedure ExecuteInserirDadosCabMovEmp(TotalAmount: Decimal; ProjectDescription: Text)
    var
        l_RubSal: Record "Payroll Item";
    begin
        NLinha := NLinha + 10000;
        LinhaMovEmpregado.Init;
        LinhaMovEmpregado."Cód. Processamento" := "Periodos Processamento"."Cód. Processamento";
        LinhaMovEmpregado."Tipo Processamento" := "Periodos Processamento"."Tipo Processamento";
        LinhaMovEmpregado."Employee No." := Empregado2."No.";
        LinhaMovEmpregado."No. Linha" := NLinha;
        LinhaMovEmpregado."Data Registo" := "Periodos Processamento"."Data Registo";
        LinhaMovEmpregado."Designação Empregado" := Empregado2.Name;
        LinhaMovEmpregado."Payroll Item Code" := TempRubricaEmpregado2."Cód. Rúbrica Salarial";

        //Validate project name
        if ProjectDescription = '' then begin
            LinhaMovEmpregado."Payroll Item Description" := TempRubricaEmpregado2."Payroll Item Description";
        end else begin
            LinhaMovEmpregado."Payroll Item Description" := TempRubricaEmpregado2."Payroll Item Description" + ' - ' + ProjectDescription; //Adicionado nome do projecto
        end;

        //Retroactivos de IRS:
        //O Código da Rubrica fica = Código da Rubrica de IRS seja qual for
        //A Descrição da Rubrica fica fixa -->'Retroactivos de IRS de ' + mês
        if CopyStr(TempRubricaEmpregado2."Cód. Rúbrica Salarial", 1, 9) = 'IRS RETRO' then begin
            LinhaMovEmpregado."Payroll Item Code" := TempRubricaEmpregado2."Payroll Item Description";
            LinhaMovEmpregado."Payroll Item Description" := 'Retroactivos de IRS de ' +
                                                      CopyStr(TempRubricaEmpregado2."Cód. Rúbrica Salarial", 10);
        end;
        //Retroactivos de IRS - Fim

        LinhaMovEmpregado."Payroll Item Type" := TempRubricaEmpregado2."Payroll Item Type";
        LinhaMovEmpregado."Debit Acc. No." := TempRubricaEmpregado2."Debit Acc. No.";
        LinhaMovEmpregado."Credit Acc. No." := TempRubricaEmpregado2."Credit Acc. No.";
        LinhaMovEmpregado.Quantity := TempRubricaEmpregado2.Quantity;

        //este código é para faltas aparecerem no recido em dias ou horas consoante o que foi lançado
        LinhaMovEmpregado."Quatidade Recibo Vencimentos" := TempRubricaEmpregado2."Quatidade Recibo Vencimentos";
        LinhaMovEmpregado."Unit of Measure" := TempRubricaEmpregado2."Unit of Measure";

        LinhaMovEmpregado."Unit Value" := TempRubricaEmpregado2."Unit Value";
        LinhaMovEmpregado.Valor := /*TempRubricaEmpregado2."Total Amount";*/ TotalAmount;// Modificado aqui.

        //Taxas efetivas
        TempRubricaEmpregadoDeducts.Reset();
        TempRubricaEmpregadoDeducts.SetFilter("Employee No.", TempRubricaEmpregado2."Employee No.");
        TempRubricaEmpregadoDeducts.SetFilter("Line No.", Format(TempRubricaEmpregado2."Line No."));

        if TempRubricaEmpregadoDeducts.FindFirst() then begin
            LinhaMovEmpregado."Parcela a Abater" := TempRubricaEmpregadoDeducts.Quantity;
            LinhaMovEmpregado."Taxa Efetiva IRS" := Abs(TempRubricaEmpregadoDeducts."Total Amount");
        end;


        //Preencher o Tipo Rendimento por causa do Anexo J
        LinhaMovEmpregado."Tipo Rendimento" := Empregado2."Tipo Rendimento";
        LinhaMovEmpregado."Cód. Situação" := TempRubricaEmpregado2."Cód. Situação";
        LinhaMovEmpregado."Cód. Movimento" := TempRubricaEmpregado2."Cód. Movimento";
        LinhaMovEmpregado."Data Efeito" := TempRubricaEmpregado2."Data Efeito";

        //preencher o campo Natrem uma vez que deixou de ser FlowField
        TabRubSal.Reset;
        if TabRubSal.Get(TempRubricaEmpregado2."Cód. Rúbrica Salarial") then
            LinhaMovEmpregado.NATREM := TabRubSal.NATREM;


        //Preencher campos data inicio e data fim caso a rubricas seja do genero falta
        //RubricaSalarial2.RESET;
        //RubricaSalarial2.SETRANGE(Código,TempRubricaEmpregado2."Cód. Rúbrica Salarial");
        //IF RubricaSalarial2.FIND('-') THEN BEGIN
        //  IF (RubricaSalarial2.Genero = RubricaSalarial2.Genero::Falta)THEN BEGIN
        LinhaMovEmpregado."Data a que se refere o mov" := TempRubricaEmpregado2."Data a que se refere o mov";
        //  END;
        //END;


        //novo campo por causa do codigo contributivo
        if TempRubricaEmpregado2."Valor Incidência SS" = 0 then begin
            TempRubricaEmpregado.Reset;
            TempRubricaEmpregado.SetRange(TempRubricaEmpregado."Employee No.", TempRubricaEmpregado2."Employee No.");
            TempRubricaEmpregado.SetRange(TempRubricaEmpregado."Line No.", TempRubricaEmpregado2."Line No.");
            if TempRubricaEmpregado.FindFirst then
                LinhaMovEmpregado."Valor Incidência SS" := TempRubricaEmpregado."Valor Incidência SS"
        end else
            LinhaMovEmpregado."Valor Incidência SS" := TempRubricaEmpregado2."Valor Incidência SS";

        //preencher as dimensões das horas extra  e abonos / descontos extra
        LinhaMovEmpregado."Global Dimension 1 Code" := TempRubricaEmpregado."Global Dimension 1 Code";
        LinhaMovEmpregado."Global Dimension 2 Code" := TempRubricaEmpregado."Global Dimension 2 Code";

        //para preencher o campo que vai ser usado no Mapa Declaração Mensal Remunerações AT
        l_RubSal.Reset;
        if l_RubSal.Get(TempRubricaEmpregado2."Cód. Rúbrica Salarial") then begin
            LinhaMovEmpregado."Tipo Rendimento Cat.A" := l_RubSal."Tipo Rendimento Cat.A";
        end;

        LinhaMovEmpregado."Garnishmen No." := TempRubricaEmpregado2."Garnishmen No.";
        LinhaMovEmpregado.Insert;
    end;
    #endregion

    #region PROCESSING AND CALCULATIONS PROCEDURES
    procedure ProcessarEncSociais(Valor: Decimal; VarTaxa: Decimal; VarCodRubrica: Code[20]; VarContaDeb: Code[20]; varContaCred: Code[20])
    var
        TabCabMovEmpregado: Record "Cab. Movs. Empregado";
        TabLinhaMovEmpregado: Record "Linhas Movs. Empregado";
        TabRubSalarial: Record "Payroll Item";
        recRubSalarialEmp: Record "Rubrica Salarial Empregado";
        recRubSalarial: Record "Payroll Item";
        Flag: Boolean;
    begin
        //****************************************************
        //****** Processamento dos Encargos Sociais **********
        //****************************************************
        TabRubSalarial.Reset;
        TabRubSalarial.SetRange(TabRubSalarial.Código, VarCodRubrica);
        if TabRubSalarial.Find('-') then begin
            TabCabMovEmpregado.Reset;
            TabCabMovEmpregado.SetRange(TabCabMovEmpregado."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
            TabCabMovEmpregado.SetRange(TabCabMovEmpregado."Tipo Processamento", TabCabMovEmpregado."Tipo Processamento"::Encargos);
            TabCabMovEmpregado.SetRange(TabCabMovEmpregado."Employee No.", Empregado."No.");
            if not TabCabMovEmpregado.Find('-') then begin
                TabCabMovEmpregado.Init;
                TabCabMovEmpregado."Cód. Processamento" := "Periodos Processamento"."Cód. Processamento";
                TabCabMovEmpregado."Tipo Processamento" := TabCabMovEmpregado."Tipo Processamento"::Encargos;
                TabCabMovEmpregado."Employee No." := Empregado."No.";
                TabCabMovEmpregado."Designação Empregado" := Empregado.Name;
                TabCabMovEmpregado."Data Registo" := "Periodos Processamento"."Data Registo";
                TabCabMovEmpregado.Insert;
            end;
            NLinha := NLinha + 10000;
            TabLinhaMovEmpregado.Init;
            TabLinhaMovEmpregado."Cód. Processamento" := "Periodos Processamento"."Cód. Processamento";
            TabLinhaMovEmpregado."Tipo Processamento" := TabCabMovEmpregado."Tipo Processamento"::Encargos;
            TabLinhaMovEmpregado."Employee No." := Empregado."No.";
            TabLinhaMovEmpregado."No. Linha" := NLinha;
            TabLinhaMovEmpregado."Data Registo" := "Periodos Processamento"."Data Registo";
            TabLinhaMovEmpregado."Designação Empregado" := Empregado.Name;
            TabLinhaMovEmpregado."Payroll Item Code" := TabRubSalarial.Código;
            TabLinhaMovEmpregado."Payroll Item Description" := TabRubSalarial.Descrição;
            TabLinhaMovEmpregado."Payroll Item Type" := TabRubSalarial."Payroll Item Type";
            //Novos parametros varcontadeb por causa do FCT
            if VarContaDeb = '' then
                TabLinhaMovEmpregado."Debit Acc. No." := TabRubSalarial."Debit Acc. No."
            else
                TabLinhaMovEmpregado."Debit Acc. No." := VarContaDeb;
            if varContaCred = '' then
                TabLinhaMovEmpregado."Credit Acc. No." := TabRubSalarial."Credit Acc. No."
            else
                TabLinhaMovEmpregado."Credit Acc. No." := varContaCred;
            TabLinhaMovEmpregado.Quantity := VarTaxa;
            TabLinhaMovEmpregado.Valor := Round(Valor * VarTaxa / 100, 0.01);

            //Preencher o Tipo Rendimento por causa do Anexo J
            TabLinhaMovEmpregado."Tipo Rendimento" := Empregado."Tipo Rendimento";
            if TabRubSalarial.Genero = TabRubSalarial.Genero::"Enc. CGA" then begin
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

    local procedure CalcularDiasFeriasDireito(NEmpregado: Code[20]): Decimal
    var
        DiasFerias: Decimal;
        QtdAusencia: Decimal;
        l_MotAus: Record "Absence Reason";
        l_AusenciaEmpregado: Record "Ausência Empregado";
        limite: Integer;
    begin
        //Calcular de férias
        Clear(DiasFerias);
        if Empregado."Tipo Contribuinte" = Empregado."Tipo Contribuinte"::"Conta de Outrem" then begin

            //1 - Ano de Admissão
            if Date2DMY(Empregado."Employment Date", 3) = Date2DMY("Periodos Processamento"."Data Inicio Processamento", 3) then begin

                //1.1 - Mês da Admissão
                if ((Empregado."Employment Date" >= "Periodos Processamento"."Data Inicio Processamento") and
                   (Empregado."Employment Date" <= "Periodos Processamento"."Data Fim Processamento")) then begin
                    if Date2DMY(Empregado."Employment Date", 1) = 1 then
                        DiasFerias := DiasFerias + 2
                    else
                        if Date2DMY(Empregado."Employment Date", 1) < 15 then
                            DiasFerias := DiasFerias + 1;
                end else begin
                    //1.2 Meses seguintes
                    Clear(limite);
                    if Date2DMY(Empregado."Employment Date", 1) = 1 then limite := limite + 2;
                    if (Date2DMY(Empregado."Employment Date", 1) > 1) and (Date2DMY(Empregado."Employment Date", 1) < 15) then limite := limite + 1;
                    for i := Date2DMY(Empregado."Employment Date", 2) + 1 to Date2DMY("Periodos Processamento"."Data Fim Processamento", 2) - 1 do begin
                        limite := limite + 2;
                    end;
                    if limite <= 18 then DiasFerias := DiasFerias + 2;
                    if limite = 19 then DiasFerias := DiasFerias + 1;
                end;

            end else begin
                //2 - Ano de admissão + 1
                if Date2DMY(Empregado."Employment Date", 3) + 1 = Date2DMY("Periodos Processamento"."Data Inicio Processamento", 3) then begin
                    Clear(limite);
                    for i := 1 to Date2DMY("Periodos Processamento"."Data Fim Processamento", 2) - 1 do begin
                        limite := limite + 2;
                    end;
                    if limite <= 20 then DiasFerias := DiasFerias + 2;
                    if limite = 21 then DiasFerias := DiasFerias + 1;
                end else begin
                    //3 - Anos seguintes
                    if Date2DMY("Periodos Processamento"."Data Inicio Processamento", 2) = 1 then
                        DiasFerias := DiasFerias + 22;
                end;
            end;


            /*
            //Descontar Ausencias de 30 dias
            CLEAR(QtdAusencia);
            l_MotAus.RESET;
            l_MotAus.SETRANGE("Vacation Days Influence",TRUE);
            IF l_MotAus.FINDSET THEN BEGIN
              REPEAT
                l_AusenciaEmpregado.RESET;
                l_AusenciaEmpregado.SETRANGE("Cause of Absence Code", l_MotAus.Code);
                l_AusenciaEmpregado.SETRANGE("Employee No.", Empregado."No.");
                IF l_AusenciaEmpregado.FINDSET THEN BEGIN
                  REPEAT
                    QtdAusencia := QtdAusencia + l_AusenciaEmpregado.Quantity;
                  UNTIL l_AusenciaEmpregado.NEXT=0;
                END;
              UNTIL l_MotAus.NEXT =0;
            END;
            IF l_AusenciaEmpregado.Quantity >= 30 THEN
              DiasFerias := DiasFerias - 2;
            */

            exit(DiasFerias);
        end;

    end;

    local procedure CalcularDiasFeriasGastos(NEmpregado: Code[20]): Decimal
    var
        DiasFerias: Decimal;
        QtdAusencia: Decimal;
        l_MotAus: Record "Absence Reason";
        l_AusenciaEmpregado: Record "Ausência Empregado";
        limite: Integer;
    begin

        //Calcular dias férias gozados
        TabFeriasEmpregado.Reset;
        TabFeriasEmpregado.SetRange("Employee No.", Empregado."No.");
        TabFeriasEmpregado.SetRange(Data, "Periodos Processamento"."Data Inicio Processamento",
                                    "Periodos Processamento"."Data Fim Processamento");
        TabFeriasEmpregado.SetRange(Tipo, 0);
        if TabFeriasEmpregado.FindSet then
            repeat
                DiasFerias := DiasFerias + TabFeriasEmpregado."Qtd.";
            until TabFeriasEmpregado.Next = 0;

        exit(DiasFerias);
    end;
    #endregion

    /// <summary>
    /// Retorna o valor já com o desconto.
    /// </summary>
    local procedure DescontosIRSJovemSeAplicavel(empregado: Record Empregado; valor: Decimal; valorTotal: Decimal): Decimal
    var
        regimeIRSJovem: Record "Regimes IRS Jovem";
        limiteMensal: Decimal;
        valorRubricaMensal: Decimal;
        valorATributar: Decimal;
        limiteIASEmpercentual: Decimal;
    begin
        valorRubricaMensal := valor;

        if empregado."IRS Jovem" = true then begin
            regimeIRSJovem.Reset();
            regimeIRSJovem.SetFilter(Code, empregado."Escalão IRS Jovem");
            if regimeIRSJovem.FindFirst() then begin
                limiteMensal := RegimeIRSJovem.Limite / 14;

                if valor < valorTotal then begin
                    //Duodecimos
                    limiteIASEmpercentual := limiteMensal * valor / valorTotal;
                    if ((valorRubricaMensal * regimeIRSJovem."Isenção" / 100) <= limiteMensal) then begin
                        exit(valor - (valor * regimeIRSJovem."Isenção" / 100));
                    end else begin
                        valorATributar := valor - limiteIASEmpercentual;
                        if valorATributar < 0 then begin
                            valorATributar := 0;
                        end;
                        exit(valorATributar);
                    end;
                end else begin
                    //Sem duodecimos
                    if ((valorRubricaMensal * regimeIRSJovem."Isenção" / 100) <= limiteMensal) then begin
                        exit(valor - (valor * regimeIRSJovem."Isenção" / 100));
                    end else begin
                        valorATributar := valorRubricaMensal - limiteMensal;
                        if valorATributar < 0 then begin
                            valorATributar := 0;
                        end;
                        exit(valorATributar);
                    end;
                end;
            end else begin
                //O code do irs jovem não foi encontrado.
                exit(valor);
            end;
        end else begin
            //Não tem irs jovem.
            exit(valor);
        end;
    end;
}