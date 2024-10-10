report 53098 "Mapa Resumo Processamento B"
{
    // //-------------------------------------------------------
    //               Mapa Resumo de Processamento
    // //--------------------------------------------------------
    //   É um Mapa que serve de conferência de dados oriundos do
    //   Processamento.
    //   Está disponível a partir de Mapas.
    // //-------------------------------------------------------
    // 
    // IT001 - 2017.03.07 -   faltava o filtro para não apanhar os encargos da entidade patronal
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\MapaResumoProcessamentoB.rdl';

    PreviewMode = PrintLayout;
    UseRequestPage = true;

    dataset
    {
        dataitem("Periodos Processamento"; "Periodos Processamento")
        {
            DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento");
            PrintOnlyIfDetail = true;

            trigger OnPreDataItem()
            begin
                SetFilter("Cód. Processamento", CodProcess);

                if DataInicio <> 0D then
                    SetRange("Data Inicio Processamento", DataInicio);
                if DataFim <> 0D then
                    SetRange("Data Fim Processamento", DataFim);

                FiltroDataInicProc := "Periodos Processamento".GetFilter("Data Inicio Processamento");
                FiltroDataFimProc := "Periodos Processamento".GetFilter("Data Fim Processamento");
                FiltroCodProc := "Periodos Processamento".GetFilter("Cód. Processamento");

                if (FiltroDataInicProc <> '') and (FiltroDataFimProc <> '') and (FiltroCodProc <> '') then
                    Error(Text0003);

                if (FiltroDataFimProc <> '') and (FiltroDataInicProc = '') then
                    Error(Text0004);

                if (FiltroDataInicProc <> '') and (FiltroDataFimProc = '') then
                    Error(Text0004);
            end;
        }
        dataitem(Empregado; Empregado)
        {
            DataItemTableView = WHERE("Tipo Contribuinte" = CONST("Trabalhador Independente"));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }

            column(TabConfEmpresa_City; TabConfEmpresa.City)
            {
            }
            column(TabConfEmpresa_Address; TabConfEmpresa.Address)
            {
            }
            column(TabConfEmpresa_Name; TabConfEmpresa.Name)
            {
            }
            column(TabConfEmpresa__Post_Code_; TabConfEmpresa."Post Code")
            {
            }
            column(TabConfEmpresa_Picture; TabConfEmpresa.Picture)
            {
            }
            column(N__Telefone______TabConfEmpresa__Phone_No__; 'Nº Telefone: ' + TabConfEmpresa."Phone No.")
            {
            }
            column(N__Contribuinte______TabConfEmpresa__VAT_Registration_No__; 'Nº Contribuinte: ' + TabConfEmpresa."VAT Registration No.")
            {
            }
            column(TabConfEmpresa__Name_2_; TabConfEmpresa."Name 2")
            {
            }
            column(Periodos_Processamento_Data; "Periodos Processamento"."Cód. Processamento" + ' de ' + Format("Periodos Processamento"."Data Inicio Processamento") + ' a ' + Format("Periodos Processamento"."Data Fim Processamento"))
            {
            }
            column(ABS_VarOutrosDesc_; Abs(VarOutrosDesc))
            {
            }
            column(ABS_VarIRS_; Abs(VarIRS))
            {
            }
            column(VarOutrosRendim; VarOutrosRendim)
            {
            }
            column(VarIVA; VarIVA)
            {
            }
            column(VarHonorario; VarHonorario)
            {
            }
            column(VarLiquido; VarLiquido)
            {
            }
            column(VarTotAbonos; VarTotAbonos)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(MAPA_RESUMO_DE_PROCESSAMENTO_CATEGORIA_BCaption; MAPA_RESUMO_DE_PROCESSAMENTO_CATEGORIA_BCaptionLbl)
            {
            }
            column(DESCONTOSCaption; DESCONTOSCaptionLbl)
            {
            }
            column(Outros_DescontosCaption; Outros_DescontosCaptionLbl)
            {
            }
            column("Valor_LíquidoCaption"; Valor_LíquidoCaptionLbl)
            {
            }
            column(IRSCaption; IRSCaptionLbl)
            {
            }
            column(Outros_Rendim_Caption; Outros_Rendim_CaptionLbl)
            {
            }
            column(ABONOSCaption; ABONOSCaptionLbl)
            {
            }
            column(IVACaption; IVACaptionLbl)
            {
            }
            column("HonoráriosCaption"; HonoráriosCaptionLbl)
            {
            }
            column(CategoriaCaption; CategoriaCaptionLbl)
            {
            }
            column(NomeCaption; NomeCaptionLbl)
            {
            }
            column(N__EmpregadoCaption; N__EmpregadoCaptionLbl)
            {
            }
            column(Total_AbonosCaption; Total_AbonosCaptionLbl)
            {
            }
            column(Processamento_Caption; Processamento_CaptionLbl)
            {
            }
            column(TOTAIS_Caption; TOTAIS_CaptionLbl)
            {
            }
            column(Empregado_No_; "No.")
            {
            }
            dataitem("Linhas Movs. Empregado"; "Linhas Movs. Empregado")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "Employee No.", "No. Linha") WHERE("Tipo Processamento" = FILTER(<> Encargos));

                trigger OnAfterGetRecord()
                begin
                    TabRubrica.Reset;
                    TabRubrica.SetRange(TabRubrica.Código, "Linhas Movs. Empregado"."Cód. Rubrica");
                    if TabRubrica.Find('-') then begin
                        if TabRubrica.Genero = TabRubrica.Genero::"Vencimento Base" then
                            VarHonorario := VarHonorario + "Linhas Movs. Empregado".Valor;
                        if TabRubrica.Genero = TabRubrica.Genero::IVA then
                            VarIVA := VarIVA + "Linhas Movs. Empregado".Valor;
                        if (TabRubrica."Tipo Rubrica" = TabRubrica."Tipo Rubrica"::Abono) and
                           (TabRubrica.Genero <> TabRubrica.Genero::"Vencimento Base") and
                           (TabRubrica.Genero <> TabRubrica.Genero::IVA) then
                            VarOutrosRendim := VarOutrosRendim + "Linhas Movs. Empregado".Valor;
                        if (TabRubrica.Genero = TabRubrica.Genero::IRS) then
                            VarIRS := VarIRS + "Linhas Movs. Empregado".Valor;
                        if (TabRubrica."Tipo Rubrica" = TabRubrica."Tipo Rubrica"::Desconto) and
                           (TabRubrica.Genero <> TabRubrica.Genero::IRS) then
                            VarOutrosDesc := VarOutrosDesc + "Linhas Movs. Empregado".Valor;
                    end;
                end;

                trigger OnPreDataItem()
                var
                    _DataInicioProcMin: Date;
                    _DataInicioProcMax: Date;
                    _DataFimProcMin: Date;
                    _DataFimProcMax: Date;
                    _PerProcessamento: Record "Periodos Processamento";
                begin

                    if FiltroCodProc = '' then begin
                        if (FiltroDataInicProc <> '') and (FiltroDataFimProc <> '') then begin
                            _PerProcessamento.Reset;
                            _PerProcessamento.SetFilter("Data Inicio Processamento", FiltroDataInicProc);
                            _PerProcessamento.SetFilter("Data Fim Processamento", FiltroDataFimProc);

                            _DataInicioProcMin := 0D;
                            _DataInicioProcMax := 0D;
                            _DataFimProcMin := 0D;
                            _DataFimProcMax := 0D;

                            _DataInicioProcMin := _PerProcessamento.GetRangeMin("Data Inicio Processamento");
                            _DataInicioProcMax := _PerProcessamento.GetRangeMax("Data Inicio Processamento");
                            _DataFimProcMin := _PerProcessamento.GetRangeMin("Data Fim Processamento");
                            _DataFimProcMax := _PerProcessamento.GetRangeMax("Data Fim Processamento");

                            SetRange("Data Registo", _DataInicioProcMin, _DataFimProcMax)
                        end;
                    end else
                        SetFilter("Cód. Processamento", FiltroCodProc);
                end;
            }
            dataitem("Hist. Linhas Movs. Empregado"; "Hist. Linhas Movs. Empregado")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "Employee No.", "No. Linha") WHERE("Tipo Processamento" = FILTER(<> Encargos));

                trigger OnAfterGetRecord()
                begin

                    TabRubrica.Reset;
                    TabRubrica.SetRange(TabRubrica.Código, "Hist. Linhas Movs. Empregado"."Cód. Rubrica");
                    if TabRubrica.FindFirst then begin
                        if TabRubrica.Genero = TabRubrica.Genero::"Vencimento Base" then
                            VarHonorario := VarHonorario + "Hist. Linhas Movs. Empregado".Valor;
                        if TabRubrica.Genero = TabRubrica.Genero::IVA then
                            VarIVA := VarIVA + "Hist. Linhas Movs. Empregado".Valor;
                        if (TabRubrica."Tipo Rubrica" = TabRubrica."Tipo Rubrica"::Abono) and
                           (TabRubrica.Genero <> TabRubrica.Genero::"Vencimento Base") and
                           (TabRubrica.Genero <> TabRubrica.Genero::IVA) then
                            VarOutrosRendim := VarOutrosRendim + "Hist. Linhas Movs. Empregado".Valor;
                        if TabRubrica.Genero = TabRubrica.Genero::IRS then
                            VarIRS := VarIRS + "Hist. Linhas Movs. Empregado".Valor;
                        if (TabRubrica."Tipo Rubrica" = TabRubrica."Tipo Rubrica"::Desconto) and
                           (TabRubrica.Genero <> TabRubrica.Genero::IRS) then
                            VarOutrosDesc := VarOutrosDesc + "Hist. Linhas Movs. Empregado".Valor;
                    end;
                end;

                trigger OnPreDataItem()
                var
                    _DataInicioProcMin: Date;
                    _DataInicioProcMax: Date;
                    _DataFimProcMin: Date;
                    _DataFimProcMax: Date;
                    _PerProcessamento: Record "Periodos Processamento";
                begin
                    if FiltroCodProc = '' then begin
                        if (FiltroDataInicProc <> '') and (FiltroDataFimProc <> '') then begin
                            _PerProcessamento.Reset;
                            _PerProcessamento.SetFilter("Data Inicio Processamento", FiltroDataInicProc);
                            _PerProcessamento.SetFilter("Data Fim Processamento", FiltroDataFimProc);
                            _DataInicioProcMin := 0D;
                            _DataInicioProcMax := 0D;
                            _DataFimProcMin := 0D;
                            _DataFimProcMax := 0D;
                            _DataInicioProcMin := _PerProcessamento.GetRangeMin("Data Inicio Processamento");
                            _DataInicioProcMax := _PerProcessamento.GetRangeMax("Data Inicio Processamento");
                            _DataFimProcMin := _PerProcessamento.GetRangeMin("Data Fim Processamento");
                            _DataFimProcMax := _PerProcessamento.GetRangeMax("Data Fim Processamento");
                            SetRange("Data Registo", _DataInicioProcMin, _DataFimProcMax)
                        end;
                    end else
                        SetFilter("Cód. Processamento", FiltroCodProc);
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(ABS_VarOutrosDesc__Control1101490081; Abs(VarOutrosDesc))
                {
                }
                column(ABS_VarIRS__Control1101490076; Abs(VarIRS))
                {
                }
                column(VarOutrosRendim_Control1101490071; VarOutrosRendim)
                {
                }
                column(VarHonorario_Control1101490033; VarHonorario)
                {
                }
                column("Empregado__Descrição_Cat_Prof_QP_"; Empregado."Descrição Cat Prof QP")
                {
                }
                column(Empregado_Name; Empregado.Name)
                {
                }
                column(Empregado__No__; Empregado."No.")
                {
                }
                column(VarLiquido_Control1101490090; VarLiquido)
                {
                }
                column(VarTotAbonos_Control1102056008; VarTotAbonos)
                {
                }
                column(VarIVA_Control1102065001; VarIVA)
                {
                }
                column(Integer_Number; Number)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    VarLiquido := VarHonorario + VarIVA + VarOutrosRendim + VarIRS + VarOutrosDesc;
                    VarTotAbonos := VarHonorario + VarIVA + VarOutrosRendim;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Clear(VarHonorario);
                Clear(VarIVA);
                Clear(VarOutrosRendim);
                Clear(VarIRS);
                Clear(VarOutrosDesc);
                Clear(VarLiquido);
                Clear(VarTotAbonos);
            end;

            trigger OnPreDataItem()
            begin
                //Para aparecerem os totais
                //TODO: Check this report
                //CurrReport.CreateTotals(VarHonorario, VarIVA, VarOutrosRendim, VarTotAbonos, VarIRS, VarOutrosDesc, VarLiquido);
            end;
        }
        dataitem(Rodape; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            column(Processado_por_ComputadorCaption; Processado_por_ComputadorCaptionLbl)
            {
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Resumo Processamento B")
                {
                    Caption = 'Resumo Processamento B';
                    field(CodProcess; CodProcess)
                    {

                        Caption = 'Cod. Processamento';
                        TableRelation = "Periodos Processamento";
                    }
                    field(DataInicio; DataInicio)
                    {

                        Caption = 'Data Inicio';
                    }
                    field(DataFim; DataFim)
                    {

                        Caption = 'Data Fim';
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
        lblTotais = 'TOTAIS:';
    }

    trigger OnPreReport()
    begin
        TabConfEmpresa.Get;
        TabConfEmpresa.CalcFields(TabConfEmpresa.Picture);

        FiltroDataInicProc := '';
        FiltroDataFimProc := '';
        FiltroCodProc := '';
    end;

    var
        TabRubrica: Record "Rubrica Salarial";
        TabLinhasMov: Record "Linhas Movs. Empregado";
        TabHistLinhasMov: Record "Hist. Linhas Movs. Empregado";
        VarHonorario: Decimal;
        VarIVA: Decimal;
        VarOutrosRendim: Decimal;
        VarIRS: Decimal;
        VarOutrosDesc: Decimal;
        VarLiquido: Decimal;
        TabConfEmpresa: Record "Company Information";
        Text0001: Label 'Não pode usar um período de processamento aberto.';
        FiltroDataInicProc: Text[1024];
        FiltroDataFimProc: Text[1024];
        FiltroCodProc: Text[1024];
        Text0002: Label 'O processamento tem de estar Fechado.';
        Text0003: Label 'Os filtros data de processamento e código de processamento são exclusivos. Não pode selecionar ambos.';
        Text0004: Label 'Tem que preencher a data de início e fim de processamento.';
        VarTotAbonos: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        MAPA_RESUMO_DE_PROCESSAMENTO_CATEGORIA_BCaptionLbl: Label 'MAPA RESUMO DE PROCESSAMENTO CATEGORIA B';
        DESCONTOSCaptionLbl: Label 'DESCONTOS';
        Outros_DescontosCaptionLbl: Label 'Outros Descontos';
        "Valor_LíquidoCaptionLbl": Label 'Valor Líquido';
        IRSCaptionLbl: Label 'IRS';
        Outros_Rendim_CaptionLbl: Label 'Outros Rendim.';
        ABONOSCaptionLbl: Label 'ABONOS';
        IVACaptionLbl: Label 'IVA';
        "HonoráriosCaptionLbl": Label 'Honorários';
        CategoriaCaptionLbl: Label 'Categoria';
        NomeCaptionLbl: Label 'Nome';
        N__EmpregadoCaptionLbl: Label 'Nº Empregado';
        Total_AbonosCaptionLbl: Label 'Total Abonos';
        Processamento_CaptionLbl: Label 'Processamento:';
        TOTAIS_CaptionLbl: Label 'TOTAIS:';
        Processado_por_ComputadorCaptionLbl: Label 'Processado por Computador';
        CodProcess: Code[10];
        DataInicio: Date;
        DataFim: Date;
}

