report 53056 "Mapa Resumo Processamento"
{
    // //-------------------------------------------------------
    //               Mapa Resumo de Processamento
    // //--------------------------------------------------------
    //   É um Mapa que serve de conferência de dados oriundos do
    //   Processamento.
    //   Está disponível a partir de Mapas.
    // //-------------------------------------------------------
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/MapaResumoProcessamento.rdlc';

    PreviewMode = PrintLayout;
    UseRequestPage = true;

    dataset
    {
        dataitem(cab; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            column(Logo; TabConfEmpresa.Picture)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(TabConfEmpresa_Name; TabConfEmpresa.Name)
            {
            }
            column(TabConfEmpresa_City; TabConfEmpresa.City)
            {
            }
            column(TabConfEmpresa_Address; TabConfEmpresa.Address)
            {
            }
            column(TabConfEmpresa__Post_Code_; TabConfEmpresa."Post Code")
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
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(MAPA_RESUMO_DE_PROCESSAMENTOCaption; MAPA_RESUMO_DE_PROCESSAMENTOCaptionLbl)
            {
            }
            column(DESCONTOSCaption; DESCONTOSCaptionLbl)
            {
            }
            column(ENC__ENT__PATRONALCaption; ENC__ENT__PATRONALCaptionLbl)
            {
            }
            column(Outros_DescontosCaption; Outros_DescontosCaptionLbl)
            {
            }
            column(Enc__Seg__SocialCaption; Enc__Seg__SocialCaptionLbl)
            {
            }
            column(Enc__CGACaption; Enc__CGACaptionLbl)
            {
            }
            column("Valor_LíquidoCaption"; Valor_LíquidoCaptionLbl)
            {
            }
            column(Seg__SocialCaption; Seg__SocialCaptionLbl)
            {
            }
            column(CGACaption; CGACaptionLbl)
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
            column(Sub__NatalCaption; Sub__NatalCaptionLbl)
            {
            }
            column("Sub__FériasCaption"; Sub__FériasCaptionLbl)
            {
            }
            column(Sub__Alim_Caption; Sub__Alim_CaptionLbl)
            {
            }
            column(Venc__BaseCaption; Venc__BaseCaptionLbl)
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
            column(FCT_FGCTCaption; FCT_FGCTCaptionLbl)
            {
            }
            column(TOTAIS_Caption; TOTAIS_CaptionLbl)
            {
            }
            column(Cod_Processamento; CodProcess + ' ' + Format(DataInicio) + ' ' + Format(DataFim))
            {
            }
        }
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

                FiltroCodProc := "Periodos Processamento".GetFilter("Cód. Processamento");
                FiltroDataInicProc := "Periodos Processamento".GetFilter("Data Inicio Processamento");
                FiltroDataFimProc := "Periodos Processamento".GetFilter("Data Fim Processamento");

                if (FiltroDataInicProc <> '') and (FiltroDataFimProc <> '') and (FiltroCodProc <> '') then
                    Error(Text0003);

                if (FiltroDataFimProc <> '') and (FiltroDataInicProc = '') then
                    Error(Text0004);

                if (FiltroDataInicProc <> '') and (FiltroDataFimProc = '') then
                    Error(Text0004);
            end;
        }
        dataitem(Empregado; Employee)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Tipo Contribuinte";
            column(VarEncSS; VarEncSS)
            {
            }
            column(ABS_VarOutrosDesc_; Abs(VarOutrosDesc))
            {
            }
            column(ABS_VarSS_; Abs(VarSS))
            {
            }
            column(ABS_VarIRS_; Abs(VarIRS))
            {
            }
            column(ABS_VarCGA; Abs(VarCGA))
            {
            }
            column(VarOutrosRendim; VarOutrosRendim)
            {
            }
            column(VarSubNatal; VarSubNatal)
            {
            }
            column(VarSubFerias; VarSubFerias)
            {
            }
            column(VarSubAlimentacao; VarSubAlimentacao)
            {
            }
            column(VarVencimentoBase; VarVencimentoBase)
            {
            }
            column(VarLiquido; VarLiquido)
            {
            }
            column(VarTotAbonos; VarTotAbonos)
            {
            }
            column(VarFCT; VarFCT)
            {
            }
            column(Empregado_No_; "No.")
            {
            }
            column(Processado_por_ComputadorCaption; Processado_por_ComputadorCaptionLbl)
            {
            }
            dataitem("Linhas Movs. Empregado"; "Linhas Movs. Empregado")
            {
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado", "No. Linha");

                trigger OnAfterGetRecord()
                begin
                    TabRubrica.Reset;
                    TabRubrica.SetRange(TabRubrica.Código, "Linhas Movs. Empregado"."Cód. Rubrica");
                    if TabRubrica.FindFirst then begin
                        //2011.09.14 acrescentou-se o filtro abono para n descontar a incapacidade pois já desconta na coluna dos outros descontos
                        if (TabRubrica.Genero = TabRubrica.Genero::"Vencimento Base") and
                           (TabRubrica."Tipo Rubrica" = TabRubrica."Tipo Rubrica"::Abono) then
                            VarVencimentoBase := VarVencimentoBase + "Linhas Movs. Empregado".Valor;

                        //2011.09.14 acrescentou-se o filtro abono para n descontar o SA pois já desconta na coluna dos outros descontos
                        if (TabRubrica.Genero = TabRubrica.Genero::"Sub. Alimentação") and
                           (TabRubrica."Tipo Rubrica" = TabRubrica."Tipo Rubrica"::Abono) then
                            VarSubAlimentacao := VarSubAlimentacao + "Linhas Movs. Empregado".Valor;

                        if (TabRubrica.NATREM = TabRubrica.NATREM::"Cód. Sub. Férias") and
                           (TabRubrica."Tipo Rubrica" = TabRubrica."Tipo Rubrica"::Abono) then
                            VarSubFerias := VarSubFerias + "Linhas Movs. Empregado".Valor;

                        if (TabRubrica.NATREM = TabRubrica.NATREM::"Cód. Sub. Natal") and
                           (TabRubrica."Tipo Rubrica" = TabRubrica."Tipo Rubrica"::Abono) then
                            VarSubNatal := VarSubNatal + "Linhas Movs. Empregado".Valor;

                        if (TabRubrica."Tipo Rubrica" = TabRubrica."Tipo Rubrica"::Abono) and
                           (TabRubrica.Genero <> TabRubrica.Genero::"Vencimento Base") and
                           (TabRubrica.Genero <> TabRubrica.Genero::"Sub. Alimentação") and
                           (TabRubrica.NATREM <> TabRubrica.NATREM::"Cód. Sub. Férias") and
                           (TabRubrica.NATREM <> TabRubrica.NATREM::"Cód. Sub. Natal") then
                            VarOutrosRendim := VarOutrosRendim + "Linhas Movs. Empregado".Valor;

                        if (TabRubrica.Genero = TabRubrica.Genero::IRS) or
                           (TabRubrica.Genero = TabRubrica.Genero::"IRS Sub. Férias") or
                           (TabRubrica.Genero = TabRubrica.Genero::"IRS Sub. Natal") then
                            VarIRS := VarIRS + "Linhas Movs. Empregado".Valor;

                        if TabRubrica.Genero = TabRubrica.Genero::SS then
                            VarSS := VarSS + "Linhas Movs. Empregado".Valor;

                        if TabRubrica.Genero = TabRubrica.Genero::CGA then
                            VarCGA := VarCGA + "Linhas Movs. Empregado".Valor;

                        if (TabRubrica."Tipo Rubrica" = TabRubrica."Tipo Rubrica"::Desconto) and
                           (TabRubrica.Genero <> TabRubrica.Genero::IRS) and
                           (TabRubrica.Genero <> TabRubrica.Genero::"IRS Sub. Férias") and
                           (TabRubrica.Genero <> TabRubrica.Genero::"IRS Sub. Natal") and
                           (TabRubrica.Genero <> TabRubrica.Genero::SS) and
                           (TabRubrica.Genero <> TabRubrica.Genero::CGA) and
                           (TabRubrica.Genero <> TabRubrica.Genero::"Enc. SS") and
                           (TabRubrica.Genero <> TabRubrica.Genero::"Enc. CGA") and
                           (TabRubrica.Genero <> TabRubrica.Genero::"Enc. ADSE") and
                           (TabRubrica.Genero <> TabRubrica.Genero::"FCT-FGCT") then
                            VarOutrosDesc := VarOutrosDesc + "Linhas Movs. Empregado".Valor;

                        if TabRubrica.Genero = TabRubrica.Genero::"Enc. SS" then
                            VarEncSS := VarEncSS + "Linhas Movs. Empregado".Valor;

                        if TabRubrica.Genero = TabRubrica.Genero::"Enc. CGA" then
                            VarEncCGA := VarEncCGA + "Linhas Movs. Empregado".Valor;

                        if TabRubrica.Genero = TabRubrica.Genero::"FCT-FGCT" then
                            VarFCT := VarFCT + "Linhas Movs. Empregado".Valor;
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
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado", "No. Linha");

                trigger OnAfterGetRecord()
                begin
                    TabRubrica.Reset;
                    TabRubrica.SetRange(TabRubrica.Código, "Hist. Linhas Movs. Empregado"."Cód. Rubrica");
                    if TabRubrica.FindFirst then begin
                        //2011.09.14 acrescentou-se o filtro abono para n descontar a incapacidade pois já desconta na coluna dos outros descontos
                        if (TabRubrica.Genero = TabRubrica.Genero::"Vencimento Base") and
                          (TabRubrica."Tipo Rubrica" = TabRubrica."Tipo Rubrica"::Abono) then
                            VarVencimentoBase := VarVencimentoBase + "Hist. Linhas Movs. Empregado".Valor;

                        //2011.09.14 acrescentou-se o filtro abono para n descontar o SA pois já desconta na coluna dos outros descontos
                        if (TabRubrica.Genero = TabRubrica.Genero::"Sub. Alimentação") and
                          (TabRubrica."Tipo Rubrica" = TabRubrica."Tipo Rubrica"::Abono) then
                            VarSubAlimentacao := VarSubAlimentacao + "Hist. Linhas Movs. Empregado".Valor;

                        if (TabRubrica.NATREM = TabRubrica.NATREM::"Cód. Sub. Férias") and
                           (TabRubrica."Tipo Rubrica" = TabRubrica."Tipo Rubrica"::Abono) then
                            VarSubFerias := VarSubFerias + "Hist. Linhas Movs. Empregado".Valor;

                        if (TabRubrica.NATREM = TabRubrica.NATREM::"Cód. Sub. Natal") and
                           (TabRubrica."Tipo Rubrica" = TabRubrica."Tipo Rubrica"::Abono) then
                            VarSubNatal := VarSubNatal + "Hist. Linhas Movs. Empregado".Valor;

                        if (TabRubrica."Tipo Rubrica" = TabRubrica."Tipo Rubrica"::Abono) and
                           (TabRubrica.Genero <> TabRubrica.Genero::"Vencimento Base") and
                           (TabRubrica.Genero <> TabRubrica.Genero::"Sub. Alimentação") and
                           (TabRubrica.NATREM <> TabRubrica.NATREM::"Cód. Sub. Férias") and
                           (TabRubrica.NATREM <> TabRubrica.NATREM::"Cód. Sub. Natal") then
                            VarOutrosRendim := VarOutrosRendim + "Hist. Linhas Movs. Empregado".Valor;

                        if (TabRubrica.Genero = TabRubrica.Genero::IRS) or
                           (TabRubrica.Genero = TabRubrica.Genero::"IRS Sub. Férias") or
                           (TabRubrica.Genero = TabRubrica.Genero::"IRS Sub. Natal") then
                            VarIRS := VarIRS + "Hist. Linhas Movs. Empregado".Valor;

                        if TabRubrica.Genero = TabRubrica.Genero::SS then
                            VarSS := VarSS + "Hist. Linhas Movs. Empregado".Valor;

                        if TabRubrica.Genero = TabRubrica.Genero::CGA then
                            VarCGA := VarCGA + "Hist. Linhas Movs. Empregado".Valor;

                        if (TabRubrica."Tipo Rubrica" = TabRubrica."Tipo Rubrica"::Desconto) and
                           (TabRubrica.Genero <> TabRubrica.Genero::IRS) and
                           (TabRubrica.Genero <> TabRubrica.Genero::"IRS Sub. Férias") and
                           (TabRubrica.Genero <> TabRubrica.Genero::"IRS Sub. Natal") and
                           (TabRubrica.Genero <> TabRubrica.Genero::SS) and
                           (TabRubrica.Genero <> TabRubrica.Genero::CGA) and
                           (TabRubrica.Genero <> TabRubrica.Genero::"Enc. SS") and
                           (TabRubrica.Genero <> TabRubrica.Genero::"Enc. CGA") and
                           (TabRubrica.Genero <> TabRubrica.Genero::"Enc. ADSE") and
                           (TabRubrica.Genero <> TabRubrica.Genero::"FCT-FGCT") then
                            VarOutrosDesc := VarOutrosDesc + "Hist. Linhas Movs. Empregado".Valor;

                        if TabRubrica.Genero = TabRubrica.Genero::"Enc. SS" then
                            VarEncSS := VarEncSS + "Hist. Linhas Movs. Empregado".Valor;

                        if TabRubrica.Genero = TabRubrica.Genero::"Enc. CGA" then
                            VarEncCGA := VarEncCGA + "Hist. Linhas Movs. Empregado".Valor;

                        if TabRubrica.Genero = TabRubrica.Genero::"FCT-FGCT" then
                            VarFCT := VarFCT + "Hist. Linhas Movs. Empregado".Valor;
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
                    end else begin
                        SetFilter("Cód. Processamento", FiltroCodProc);
                    end;
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                PrintOnlyIfDetail = false;
                column(VarEncSS_Control1101490085; VarEncSS)
                {
                }
                column(VarEncCGA_Control1101490086; VarEncCGA)
                {
                }
                column(ABS_VarOutrosDesc__Control1101490081; Abs(VarOutrosDesc))
                {
                }
                column(ABS_VarSS__Control1101490078; Abs(VarSS))
                {
                }
                column(ABS_VarCGA__Control1101490077; Abs(VarCGA))
                {
                }
                column(ABS_VarIRS__Control1101490076; Abs(VarIRS))
                {
                }
                column(VarOutrosRendim_Control1101490071; VarOutrosRendim)
                {
                }
                column(VarSubNatal_Control1101490036; VarSubNatal)
                {
                }
                column(VarSubFerias_Control1101490035; VarSubFerias)
                {
                }
                column(VarSubAlimentacao_Control1101490034; VarSubAlimentacao)
                {
                }
                column(VarVencimentoBase_Control1101490033; VarVencimentoBase)
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
                column(VarFCT_Control1101490100; VarFCT)
                {
                }
                column(Integer_Number; Number)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    VarLiquido := VarVencimentoBase +
                                    VarSubAlimentacao +
                                    VarSubFerias +
                                    VarSubNatal +
                                    VarOutrosRendim +
                                    VarIRS +
                                    VarSS +
                                    VarCGA +
                                    VarOutrosDesc;

                    VarTotAbonos := VarVencimentoBase + VarSubAlimentacao + VarSubFerias + VarSubNatal + VarOutrosRendim;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Clear(VarVencimentoBase);
                Clear(VarSubAlimentacao);
                Clear(VarSubFerias);
                Clear(VarSubNatal);
                Clear(VarOutrosRendim);
                Clear(VarIRS);
                Clear(VarSS);
                Clear(VarCGA);
                Clear(VarOutrosDesc);
                Clear(VarEncSS);
                Clear(VarEncCGA);
                Clear(VarLiquido);
                Clear(VarTotAbonos);
                Clear(VarFCT);
                Empregado.CalcFields(Empregado."Descrição Cat Prof QP");
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CreateTotals(VarVencimentoBase, VarSubAlimentacao, VarSubFerias, VarSubNatal, VarOutrosRendim, VarTotAbonos);
                CurrReport.CreateTotals(VarIRS, VarSS, VarCGA, VarOutrosDesc, VarEncSS, VarEncCGA, VarLiquido, VarFCT);
            end;
        }
        dataitem(Rodape; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            column(Rodape_Number; Number)
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
                group("Resumo Processamento")
                {
                    Caption = 'Resumo Processamento';
                    field(CodProcess; CodProcess)
                    {
                        ApplicationArea = All;
                        Caption = 'Cod. Processamento';
                        TableRelation = "Periodos Processamento";
                    }
                    field(DataInicio; DataInicio)
                    {
                        ApplicationArea = All;
                        Caption = 'Data Inicio';
                    }
                    field(DataFim; DataFim)
                    {
                        ApplicationArea = All;
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
        VarVencimentoBase: Decimal;
        VarSubAlimentacao: Decimal;
        VarSubFerias: Decimal;
        VarSubNatal: Decimal;
        VarOutrosRendim: Decimal;
        VarIRS: Decimal;
        VarSS: Decimal;
        VarCGA: Decimal;
        VarOutrosDesc: Decimal;
        VarEncSS: Decimal;
        VarEncCGA: Decimal;
        VarFCT: Decimal;
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
        MAPA_RESUMO_DE_PROCESSAMENTOCaptionLbl: Label 'MAPA RESUMO DE PROCESSAMENTO';
        DESCONTOSCaptionLbl: Label 'DESCONTOS';
        ENC__ENT__PATRONALCaptionLbl: Label 'ENC. ENT. PATRONAL';
        Outros_DescontosCaptionLbl: Label 'Outros Descontos';
        Enc__Seg__SocialCaptionLbl: Label 'Enc. Seg. Social';
        Enc__CGACaptionLbl: Label 'Enc. CGA';
        "Valor_LíquidoCaptionLbl": Label 'Valor Líquido';
        Seg__SocialCaptionLbl: Label 'Seg. Social';
        CGACaptionLbl: Label 'CGA';
        IRSCaptionLbl: Label 'IRS';
        Outros_Rendim_CaptionLbl: Label 'Outros Rendim.';
        ABONOSCaptionLbl: Label 'ABONOS';
        Sub__NatalCaptionLbl: Label 'Sub. Natal';
        "Sub__FériasCaptionLbl": Label 'Sub. Férias';
        Sub__Alim_CaptionLbl: Label 'Sub. Alim.';
        Venc__BaseCaptionLbl: Label 'Venc. Base';
        CategoriaCaptionLbl: Label 'Categoria';
        NomeCaptionLbl: Label 'Nome';
        N__EmpregadoCaptionLbl: Label 'Nº Empregado';
        Total_AbonosCaptionLbl: Label 'Total Abonos';
        Processamento_CaptionLbl: Label 'Processamento:';
        FCT_FGCTCaptionLbl: Label 'FCT FGCT';
        TOTAIS_CaptionLbl: Label 'TOTAIS:';
        Processado_por_ComputadorCaptionLbl: Label 'Processado por Computador';
        CodProcess: Code[10];
        DataInicio: Date;
        DataFim: Date;
}

