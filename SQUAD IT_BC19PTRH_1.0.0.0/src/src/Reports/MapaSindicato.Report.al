report 53084 "Mapa Sindicato"
{
    // //-------------------------------------------------------
    //               Mapa Sindicato
    // //--------------------------------------------------------
    //   Listagem dos empregados que nesse período de processamento
    //   estiveram sujeitos a retenção para o Sindicato
    // //-------------------------------------------------------
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/MapaSindicato.rdlc';

    PreviewMode = PrintLayout;
    UseRequestPage = true;

    dataset
    {
        dataitem("Periodos Processamento"; "Periodos Processamento")
        {
            DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento") WHERE("Tipo Processamento" = CONST(Vencimentos));
            PrintOnlyIfDetail = true;

            trigger OnAfterGetRecord()
            begin
                if "Periodos Processamento".Estado <> "Periodos Processamento".Estado::Fechado then begin
                    Message(Text0001);
                    CurrReport.Quit;
                end;

                if TabEmpregado.Find('-') then;
            end;

            trigger OnPreDataItem()
            begin
                SetFilter("Cód. Processamento", CodProcess);
                SetRange("Data Inicio Processamento", DataInicio);
                SetRange("Data Fim Processamento", DataFim);

                FiltroDataInicProc := "Periodos Processamento".GetFilter("Data Inicio Processamento");
                FiltroDataFimProc := "Periodos Processamento".GetFilter("Data Fim Processamento");
                FiltroCodProc := "Periodos Processamento".GetFilter("Cód. Processamento");
            end;
        }
        dataitem(Empregado; Employee)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
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
            column(TabConfEmpresa_Address; TabConfEmpresa.Address)
            {
            }
            column(TabConfEmpresa_City; TabConfEmpresa.City)
            {
            }
            column(TabConfEmpresa__Post_Code_; TabConfEmpresa."Post Code")
            {
            }
            column(TabConfEmpresa_Picture; TabConfEmpresa.Picture)
            {
            }
            column(SindicatoTxt; TxtSindicato)
            {
            }
            column(N__Contribuinte______TabConfEmpresa__VAT_Registration_No__; 'Nº Contribuinte: ' + TabConfEmpresa."VAT Registration No.")
            {
            }
            column(N__Telefone______TabConfEmpresa__Phone_No__; 'Nº Telefone: ' + TabConfEmpresa."Phone No.")
            {
            }
            column(TabConfEmpresa__Name_2_; TabConfEmpresa."Name 2")
            {
            }
            column(DataItem1102056006; Format(FiltroCodProc) + ' ' + Format("Periodos Processamento"."Data Inicio Processamento") + ' - ' + Format("Periodos Processamento"."Data Fim Processamento"))
            {
            }
            column(ABS_TotalIncidencia_; Abs(TotalIncidencia))
            {
            }
            column(ABS_TotalQuota_; Abs(TotalQuota))
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Mapa_de_SindicatoCaption; Mapa_de_SindicatoCaptionLbl)
            {
            }
            column(Sindicato_Caption; Sindicato_CaptionLbl)
            {
            }
            column(Periodo_de_Processamento_Caption; Periodo_de_Processamento_CaptionLbl)
            {
            }
            column(N__Emp_Caption; N__Emp_CaptionLbl)
            {
            }
            column(NomeCaption; NomeCaptionLbl)
            {
            }
            column("N__SócioCaption"; N__SócioCaptionLbl)
            {
            }
            column("IncidênciaCaption"; IncidênciaCaptionLbl)
            {
            }
            column(Categoria_ProfissionalCaption; Categoria_ProfissionalCaptionLbl)
            {
            }
            column("QuotizaçãoCaption"; QuotizaçãoCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Empregado_No_; "No.")
            {
            }
            column(Processado_por_ComputadorCaption; Processado_por_ComputadorCaptionLbl)
            {
            }
            dataitem("Hist. Linhas Movs. Empregado"; "Hist. Linhas Movs. Empregado")
            {
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado", "No. Linha") WHERE("Tipo Processamento" = CONST(Vencimentos));
                column(ABS_Incidencia_; Abs(Incidencia))
                {
                }
                column(Empregado__No__; Empregado."No.")
                {
                }
                column(Empregado_Name; Empregado.Name)
                {
                }
                column(Empregado__Union_Membership_No__; Empregado."Union Membership No.")
                {
                }
                column("Empregado__Descrição_Cat_Prof_QP_"; Empregado."Descrição Cat Prof QP")
                {
                }
                column(ABS_Quota_; Abs(Quota))
                {
                }
                column("Hist__Linhas_Movs__Empregado_Cód__Processamento"; "Cód. Processamento")
                {
                }
                column(Hist__Linhas_Movs__Empregado_Tipo_Processamento; "Tipo Processamento")
                {
                }
                column(Hist__Linhas_Movs__Empregado_N__Empregado; "No. Empregado")
                {
                }
                column(Hist__Linhas_Movs__Empregado_N__Linha; "No. Linha")
                {
                }

                trigger OnAfterGetRecord()
                var
                    _DataInicioProcMin: Date;
                    _DataInicioProcMax: Date;
                    _DataFimProcMin: Date;
                    _DataFimProcMax: Date;
                    _PerProcessamento: Record "Periodos Processamento";
                begin
                    TabRubrica.Reset;
                    if TabRubrica.Get("Hist. Linhas Movs. Empregado"."Cód. Rubrica") then begin
                        Quota := Quota + "Hist. Linhas Movs. Empregado".Valor;
                        TotalQuota := TotalQuota + "Hist. Linhas Movs. Empregado".Valor;
                        TabRubricaLinhas.Reset;
                        TabRubricaLinhas.SetRange(TabRubricaLinhas."Cód. Rubrica", TabRubrica.Código);
                        if TabRubricaLinhas.FindSet then begin
                            repeat
                                TabHistLinhasMov.Reset;
                                TabHistLinhasMov.SetRange(TabHistLinhasMov."Cód. Processamento", "Hist. Linhas Movs. Empregado"."Cód. Processamento");
                                TabHistLinhasMov.SetRange(TabHistLinhasMov."Tipo Processamento", "Hist. Linhas Movs. Empregado"."Tipo Processamento");
                                TabHistLinhasMov.SetRange(TabHistLinhasMov."No. Empregado", "Hist. Linhas Movs. Empregado"."No. Empregado");
                                TabHistLinhasMov.SetRange(TabHistLinhasMov."Cód. Rubrica", TabRubricaLinhas."Cód. Rubrica Filha");
                                if TabHistLinhasMov.FindFirst then begin
                                    Incidencia := Incidencia + TabHistLinhasMov.Valor;
                                    TotalIncidencia := TotalIncidencia + Incidencia;
                                end;
                            until TabRubricaLinhas.Next = 0;
                        end;
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

                    "Hist. Linhas Movs. Empregado".SetFilter("Cód. Rubrica", CodRubricas);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Clear(Incidencia);
                Clear(Quota);
                //2012.09.17 - Filtro da última categoria profissional
                SetFilter("Data Filtro Inicio", '<=%1', WorkDate);
                SetFilter("Data Filtro Fim", '>=%1|=%2', WorkDate, 0D);
                Empregado.CalcFields(Empregado."Descrição Cat Prof QP");
                Clear(EmpregadoAntigo);
                First := true;
            end;

            trigger OnPreDataItem()
            begin
                Empregado.SetRange(Empregado."Union Code", CodSindicato);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control1000000006)
                {
                    Caption = 'Sindicato';
                    field(CodProcess; CodProcess)
                    {
                        ApplicationArea = All;
                        Caption = 'Cód. Processamento';
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
                    field(Sindicato; CodSindicato)
                    {
                        ApplicationArea = All;
                        Caption = 'Sindicato';
                        TableRelation = Sindicato;

                        trigger OnValidate()
                        begin
                            if TabSindicato.Get(CodSindicato) then
                                TxtSindicato := TabSindicato.Name;
                        end;
                    }
                    field(CodRubricas; CodRubricas)
                    {
                        ApplicationArea = All;
                        Caption = 'Rubrica Salarial';
                        TableRelation = "Rubrica Salarial";
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

    trigger OnInitReport()
    begin
        EscreveRubricasSindicato;
    end;

    trigger OnPreReport()
    begin
        TabConfEmpresa.Get;
        TabConfEmpresa.CalcFields(TabConfEmpresa.Picture);
        TabConfContab.Get();

        FiltroDataInicProc := '';
        FiltroDataFimProc := '';
        FiltroCodProc := '';

        if (FiltroDataInicProc <> '') and (FiltroDataFimProc <> '') and (FiltroCodProc <> '') then
            Error(Text0002);

        if (FiltroDataFimProc <> '') and (FiltroDataInicProc = '') then
            Error(Text0003);

        if (FiltroDataFimProc = '') and (FiltroDataInicProc <> '') then
            Error(Text0003);

        if CodSindicato = '' then
            Error(Text0004);
    end;

    var
        TabConfContab: Record "General Ledger Setup";
        TabEmpregado: Record Employee;
        TabConfEmpresa: Record "Company Information";
        TabHistLinhasMov: Record "Hist. Linhas Movs. Empregado";
        TabRubrica: Record "Rubrica Salarial";
        TabRubricaLinhas: Record "Rubrica Salarial Linhas";
        FiltroDataInicProc: Text[1024];
        FiltroDataFimProc: Text[1024];
        FiltroCodProc: Text[1024];
        Text0001: Label 'O processamento tem de estar Fechado.';
        Text0002: Label 'Os filtros data de processamento e código de processamento são exclusivos. Não pode selecionar ambos.';
        Text0003: Label 'Tem que preencher a data de início e fim de processamento.';
        MostraEmpregado: Boolean;
        TabSindicato: Record Sindicato;
        CodSindicato: Code[10];
        Text0004: Label 'Tem de escolher um sindicato.';
        TxtSindicato: Text[50];
        Incidencia: Decimal;
        TotalIncidencia: Decimal;
        Quota: Decimal;
        TotalQuota: Decimal;
        CodRubricas: Text[1024];
        First: Boolean;
        EmpregadoAntigo: Code[20];
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Mapa_de_SindicatoCaptionLbl: Label 'Mapa de Sindicato';
        Sindicato_CaptionLbl: Label 'Sindicato:';
        Periodo_de_Processamento_CaptionLbl: Label 'Periodo de Processamento:';
        N__Emp_CaptionLbl: Label 'Nº Emp.';
        NomeCaptionLbl: Label 'Nome';
        "N__SócioCaptionLbl": Label 'Nº Sócio';
        "IncidênciaCaptionLbl": Label 'Incidência';
        Categoria_ProfissionalCaptionLbl: Label 'Categoria Profissional';
        "QuotizaçãoCaptionLbl": Label 'Quotização';
        TotalCaptionLbl: Label 'Total';
        Processado_por_ComputadorCaptionLbl: Label 'Processado por Computador';
        CodProcess: Code[10];
        DataInicio: Date;
        DataFim: Date;


    procedure EscreveRubricasSindicato()
    var
        first: Boolean;
    begin
        Clear(CodRubricas);
        TabRubrica.Reset;
        TabRubrica.SetRange("Tipo Rubrica", TabRubrica."Tipo Rubrica"::Desconto);
        TabRubrica.SetRange(Genero, TabRubrica.Genero::Sindicato);
        if TabRubrica.FindSet then begin
            first := true;
            repeat
                if first then begin
                    CodRubricas += TabRubrica.Código;
                    first := false;
                end else
                    CodRubricas += '|' + TabRubrica.Código;
            until TabRubrica.Next = 0;
        end;
    end;
}

