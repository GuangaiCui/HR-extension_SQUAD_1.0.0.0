report 53093 "Mapa Companhia Seguros"
{
    //  //-------------------------------------------------------
    //                 Listagem Companhia de Seguros
    //  //--------------------------------------------------------
    //   É um Mapa Legal a ser entregue mensalmente à Companhia Seguros
    //   com a listagens dos empregados e Abonos Auferidos.
    //   Este Report está disponível a partir de Mapas.
    //  //-------------------------------------------------------
    // 
    // 
    // IT001 - CPA:Nova Coluna com Vencimento Base
    // IT002 - CPA:Aparecer a Desc. Cat. profissional interna em vez da QP
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\MapaCompanhiaSeguros.rdl';

    PreviewMode = PrintLayout;
    UseRequestPage = true;

    dataset
    {
        dataitem("Periodos Processamento"; "Periodos Processamento")
        {
            DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento") WHERE("Tipo Processamento" = FILTER(<> Encargos));
            PrintOnlyIfDetail = false;
            column(PeriodosProcessamento_Estado; Estado)
            {
            }
            column(PeriodosProcessamento_CodProcessamento; "Cód. Processamento")
            {
            }
            column(TotaisCaption_Control1102059061; TotaisCaption_Control1102059061Lbl)
            {
            }
            dataitem("Movs. Empregado"; "Cab. Movs. Empregado")
            {
                DataItemTableView = SORTING(Seguradora, "No. Apólice", "No. Empregado") WHERE("Tipo Processamento" = FILTER(<> Encargos), "No. Apólice" = FILTER(<> ''));
                PrintOnlyIfDetail = false;
                column(TabConfEmpresa_Picture; TabConfEmpresa.Picture)
                {
                }
                column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
                {
                }
                column(USERID; UserId)
                {
                }
                column(TabConfEmpresa__Name_2_; TabConfEmpresa."Name 2")
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
                column(N__Telefone______TabConfEmpresa__Phone_No__; 'Nº Telefone: ' + TabConfEmpresa."Phone No.")
                {
                }
                column(N__Contribuinte______TabConfEmpresa__VAT_Registration_No__; 'Nº Contribuinte: ' + TabConfEmpresa."VAT Registration No.")
                {
                }
                column(varProvisorio; varProvisorio)
                {
                }
                column(Movs__Empregado_Seguradora; Seguradora)
                {
                }
                column("Movs__Empregado__N__Apólice_"; "No. Apólice")
                {
                }
                column(FORMAT_Mensal___________FORMAT_Ano_; Format(Mensal) + ' ' + Format(Ano))
                {
                }
                column(Movs__Empregado__N__Empregado_; "No. Empregado")
                {
                }
                column("Movs__Empregado__Designação_Empregado_"; "Designação Empregado")
                {
                }
                column(valorvencimento; valorvencimento)
                {
                }
                column(valorDiuturnidades; valorDiuturnidades)
                {
                }
                column(valorSubsAlmoco; valorSubsAlmoco)
                {
                }
                column(valorSubsNatalFerias; valorSubsNatalFerias)
                {
                }
                column(valorOutros; valorOutros)
                {
                }
                column(Total; Total)
                {
                }
                column("Movs__Empregado__Movs__Empregado___Descrição_Cat_Prof_"; "Movs. Empregado"."Descrição Cat Prof Int")
                {
                }
                column(NDias; NDias)
                {
                }
                column(TotalGlobal; TotalGlobal)
                {
                }
                column(TabConfContab__Currency_Text_; TabConfContab."LCY Code")
                {
                }
                column(N__EmpregadoCaption; N__EmpregadoCaptionLbl)
                {
                }
                column(NomeCaption; NomeCaptionLbl)
                {
                }
                column(VencimentoCaption; VencimentoCaptionLbl)
                {
                }
                column(DiuturnidadesCaption; DiuturnidadesCaptionLbl)
                {
                }
                column("Subsídio_AlmoçoCaption"; Subsídio_AlmoçoCaptionLbl)
                {
                }
                column("Subsídios_Natal_FériasCaption"; Subsídios_Natal_FériasCaptionLbl)
                {
                }
                column(Outros_AbonosCaption; Outros_AbonosCaptionLbl)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(MAPA_COMPANHIA_DE_SEGUROSCaption; MAPA_COMPANHIA_DE_SEGUROSCaptionLbl)
                {
                }
                column(DiasCaption; DiasCaptionLbl)
                {
                }
                column(Companhia_de_Seguros_Caption; Companhia_de_Seguros_CaptionLbl)
                {
                }
                column("N__Apólice_Caption"; N__Apólice_CaptionLbl)
                {
                }
                column(Periodo_de_Processamento_Caption; Periodo_de_Processamento_CaptionLbl)
                {
                }
                column(TotalCaption_Control1102059074; TotalCaption_Control1102059074Lbl)
                {
                }
                column(Outros_AbonosCaption_Control1102059075; Outros_AbonosCaption_Control1102059075Lbl)
                {
                }
                column("Subsídios_Natal_FériasCaption_Control1102059076"; Subsídios_Natal_FériasCaption_Control1102059076Lbl)
                {
                }
                column("Subsídio_AlmoçoCaption_Control1102059079"; Subsídio_AlmoçoCaption_Control1102059079Lbl)
                {
                }
                column(DiuturnidadesCaption_Control1102059080; DiuturnidadesCaption_Control1102059080Lbl)
                {
                }
                column(VencimentoCaption_Control1102059081; VencimentoCaption_Control1102059081Lbl)
                {
                }
                column(NomeCaption_Control1102059082; NomeCaption_Control1102059082Lbl)
                {
                }
                column(N__EmpregadoCaption_Control1102059083; N__EmpregadoCaption_Control1102059083Lbl)
                {
                }
                column(CurrReport_PAGENO_Control1102059116Caption; CurrReport_PAGENO_Control1102059116CaptionLbl)
                {
                }
                column(MAPA_COMPANHIA_DE_SEGUROSCaption_Control1102059124; MAPA_COMPANHIA_DE_SEGUROSCaption_Control1102059124Lbl)
                {
                }
                column(DiasCaption_Control1102065005; DiasCaption_Control1102065005Lbl)
                {
                }
                column(TotaisCaption; TotaisCaptionLbl)
                {
                }
                column(Processado_por_ComputadorCaption; Processado_por_ComputadorCaptionLbl)
                {
                }
                column("Movs__Empregado_Cód__Processamento"; "Cód. Processamento")
                {
                }
                column(Movs__Empregado_Tipo_Processamento; "Tipo Processamento")
                {
                }
                column(Movs_Emp_VB; decVencBase)
                {
                }
                dataitem("Linhas Movs. Empregado1"; "Linhas Movs. Empregado")
                {
                    DataItemLink = "Cód. Processamento" = FIELD("Cód. Processamento"), "Tipo Processamento" = FIELD("Tipo Processamento"), "No. Empregado" = FIELD("No. Empregado");
                    DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado", "No. Linha") WHERE("Tipo Processamento" = FILTER(<> Encargos));

                    trigger OnAfterGetRecord()
                    begin
                        if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Fechado then
                            CurrReport.Skip
                        else begin

                            TabRubrica.Reset;
                            if TabRubrica.Get("Linhas Movs. Empregado1"."Cód. Rubrica") then begin
                                if TabRubrica."Mapa Companhia Seguros" = true then begin
                                    //      Total := Total + "Linhas Movs. Empregado1".Valor;
                                    //      TotalGlobal := TotalGlobal + "Linhas Movs. Empregado1".Valor;
                                end;
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
                        if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Fechado then
                            CurrReport.Skip;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if TabEmpregado.Get("No. Empregado") then
                        decVencBase := TabEmpregado."Valor Vencimento Base";


                    /*
                    //FBC - 26-03-2007 - Erro de pagina a branco
                     TabLinhasMov.RESET;
                     TabLinhasMov.SETRANGE(TabLinhasMov."Cód. Processamento","Periodos Processamento"."Cód. Processamento");
                     TabLinhasMov.SETRANGE(TabLinhasMov."Tipo Processamento","Periodos Processamento"."Tipo Processamento");
                     TabLinhasMov.SETRANGE(TabLinhasMov."Nº Empregado","Nº Empregado");
                     IF NOT TabLinhasMov.FIND('-') THEN BEGIN
                        TabHistLinhasMov.RESET;
                        TabHistLinhasMov.SETRANGE(TabHistLinhasMov."Cód. Processamento","Periodos Processamento"."Cód. Processamento");
                        TabHistLinhasMov.SETRANGE(TabHistLinhasMov."Tipo Processamento","Periodos Processamento"."Tipo Processamento");
                        TabHistLinhasMov.SETRANGE(TabHistLinhasMov."Nº Empregado","Nº Empregado");
                        IF NOT TabHistLinhasMov.FIND('-') THEN BEGIN
                           CurrReport.SKIP;
                        END;
                    
                     END;
                     */
                    if Seguradora = '' then
                        CurrReport.Skip;

                    //----------

                    if ((CodSeg <> '') and (UpperCase(CodSeg) <> UpperCase(Seguradora))) or
                       ((CodApo <> '') and (UpperCase(CodApo) <> UpperCase("No. Apólice"))) then begin
                        //TODO:Test this report
                        //CurrReport.NewPage;
                        //CurrReport.PageNo := 1;
                        TotalVencimento := 0;
                        TotalDiuturnidades := 0;
                        TotalSubsAlmoco := 0;
                        TotalSubsNatalFerias := 0;
                        TotalOutros := 0;
                        TotalGlobal := 0;
                    end;

                    CodSeg := Seguradora;
                    CodApo := "No. Apólice";
                    //-----------



                    if nemp <> "Movs. Empregado"."No. Empregado" then begin
                        nemp := "Movs. Empregado"."No. Empregado";

                        //2009.04.16
                        Clear(valorvencimento);
                        Clear(valorDiuturnidades);
                        Clear(valorSubsAlmoco);
                        Clear(valorSubsNatalFerias);
                        Clear(valorOutros);
                        Clear(Total);
                        Clear(NDias);
                        //fim

                        //2009.04.16 -Fiz o IF para n apanhar os inactivos
                        "Movs. Empregado".CalcFields("Movs. Empregado".Valor);
                        if "Movs. Empregado".Valor <> 0 then begin

                            Vencimentos("Movs. Empregado"."No. Empregado");
                            ProcessaFaltas("Movs. Empregado"."No. Empregado");
                            Diuturnidades("Movs. Empregado"."No. Empregado");
                            SubsAlmoco("Movs. Empregado"."No. Empregado");
                            SubsNatalFerias("Movs. Empregado"."No. Empregado");
                            ProcessaOutros("Movs. Empregado"."No. Empregado");
                            OutrosAbonos("Movs. Empregado"."No. Empregado");
                            CalcTotal();
                            TotalVencimento += valorvencimento;
                            TotalDiuturnidades += valorDiuturnidades;
                            TotalSubsAlmoco += valorSubsAlmoco;
                            TotalSubsNatalFerias += valorSubsNatalFerias;
                            TotalOutros += valorOutros;
                        end;
                    end;

                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FieldNo("No. Apólice");


                    Mes := Date2DMY("Periodos Processamento"."Data Registo", 2);
                    Ano := Date2DMY("Periodos Processamento"."Data Registo", 3);
                    Mensal := Month(Mes);
                    //dataInicioProc := 0D;
                    //dataFimProc := 0D;

                    TotalVencimento := 0;
                    TotalDiuturnidades := 0;
                    TotalSubsAlmoco := 0;
                    TotalSubsNatalFerias := 0;
                    TotalOutros := 0;
                    TotalGlobal := 0;
                    NDias := 0;

                    //C+ - AFG

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
                            _DataFimProcMax := _PerProcessamento.GetRangeMin("Data Fim Processamento");

                            SetRange("Data Registo", _DataInicioProcMin, _DataFimProcMax)
                        end;
                    end
                    else begin
                        SetFilter("Cód. Processamento", FiltroCodProc);
                    end;

                    //C+ - AFG


                    if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Fechado then
                        CurrReport.Skip;

                    CodSeg := '';
                    CodApo := '';
                end;
            }
            dataitem("Hist. Movs. Empregado"; "Hist. Cab. Movs. Empregado")
            {
                DataItemTableView = SORTING(Seguradora, "No. Apólice", "No. Empregado") WHERE("Tipo Processamento" = FILTER(<> Encargos), "No. Apólice" = FILTER(<> ''));
                PrintOnlyIfDetail = false;
                column(TabConfEmpresa_Picture_Control1102059078; TabConfEmpresa.Picture)
                {
                }
                column(FORMAT_TODAY_0_4__Control1102059085; Format(Today, 0, 4))
                {
                }
                column(USERID_Control1102059086; UserId)
                {
                }
                column(TabConfEmpresa__Name_2__Control1102059089; TabConfEmpresa."Name 2")
                {
                }
                column(TabConfEmpresa_Name_Control1102059090; TabConfEmpresa.Name)
                {
                }
                column(TabConfEmpresa_Address_Control1102059091; TabConfEmpresa.Address)
                {
                }
                column(TabConfEmpresa_City_Control1102059092; TabConfEmpresa.City)
                {
                }
                column(TabConfEmpresa__Post_Code__Control1102059093; TabConfEmpresa."Post Code")
                {
                }
                column(N__Telefone______TabConfEmpresa__Phone_No___Control1102059094; 'Nº Telefone: ' + TabConfEmpresa."Phone No.")
                {
                }
                column(N__Contribuinte______TabConfEmpresa__VAT_Registration_No___Control1102059095; 'Nº Contribuinte: ' + TabConfEmpresa."VAT Registration No.")
                {
                }
                column(varProvisorio_Control1102059097; varProvisorio)
                {
                }
                column(Hist__Movs__Empregado_Seguradora; Seguradora)
                {
                }
                column("Hist__Movs__Empregado__N__Apólice_"; "No. Apólice")
                {
                }
                column(FORMAT_Mensal___________FORMAT_Ano__Control1102059041; Format(Mensal) + ' ' + Format(Ano))
                {
                }
                column(TabConfEmpresa_Picture_Control1102059098; TabConfEmpresa.Picture)
                {
                }
                column(FORMAT_TODAY_0_4__Control1102059099; Format(Today, 0, 4))
                {
                }
                column(USERID_Control1102059100; UserId)
                {
                }
                column(Hist__Movs__Empregado__N__Empregado_; "No. Empregado")
                {
                }
                column("Hist__Movs__Empregado__Designação_Empregado_"; "Designação Empregado")
                {
                }
                column(valorvencimento_hist; valorvencimento)
                {
                }
                column(valorDiuturnidades_hist; valorDiuturnidades)
                {
                }
                column(valorSubsAlmoco_hist; valorSubsAlmoco)
                {
                }
                column(valorSubsNatalFerias_hist; valorSubsNatalFerias)
                {
                }
                column(valorOutros_hist; valorOutros)
                {
                }
                column(Total_hist; Total)
                {
                }
                column("Hist__Movs__Empregado__Hist__Movs__Empregado___Descrição_Cat_Prof_"; "Hist. Movs. Empregado"."Descrição Cat Prof Int")
                {
                }
                column(NDias_Control1102065002; NDias)
                {
                }
                column(TotalGlobal_Control1102059060; TotalGlobal)
                {
                }
                column(TabConfContab__Currency_Text__Control1102059062; TabConfContab."LCY Code")
                {
                }
                column(N__EmpregadoCaption_Control1102059028; N__EmpregadoCaption_Control1102059028Lbl)
                {
                }
                column(NomeCaption_Control1102059029; NomeCaption_Control1102059029Lbl)
                {
                }
                column(VencimentoCaption_Control1102059030; VencimentoCaption_Control1102059030Lbl)
                {
                }
                column(DiuturnidadesCaption_Control1102059031; DiuturnidadesCaption_Control1102059031Lbl)
                {
                }
                column("Subsídio_AlmoçoCaption_Control1102059032"; Subsídio_AlmoçoCaption_Control1102059032Lbl)
                {
                }
                column("Subsídios_Natal_FériasCaption_Control1102059033"; Subsídios_Natal_FériasCaption_Control1102059033Lbl)
                {
                }
                column(Outros_AbonosCaption_Control1102059034; Outros_AbonosCaption_Control1102059034Lbl)
                {
                }
                column(TotalCaption_Control1102059035; TotalCaption_Control1102059035Lbl)
                {
                }
                column(CurrReport_PAGENO_Control1102059088Caption; CurrReport_PAGENO_Control1102059088CaptionLbl)
                {
                }
                column(MAPA_COMPANHIA_DE_SEGUROSCaption_Control1102059096; MAPA_COMPANHIA_DE_SEGUROSCaption_Control1102059096Lbl)
                {
                }
                column(DiasCaption_Control1102065006; DiasCaption_Control1102065006Lbl)
                {
                }
                column(Companhia_de_Seguros_Caption_Control1102059038; Companhia_de_Seguros_Caption_Control1102059038Lbl)
                {
                }
                column("N__Apólice_Caption_Control1102059040"; N__Apólice_Caption_Control1102059040Lbl)
                {
                }
                column(Periodo_de_Processamento_Caption_Control1102059042; Periodo_de_Processamento_Caption_Control1102059042Lbl)
                {
                }
                column(TotalCaption_Control1102059044; TotalCaption_Control1102059044Lbl)
                {
                }
                column(Outros_AbonosCaption_Control1102059045; Outros_AbonosCaption_Control1102059045Lbl)
                {
                }
                column("Subsídios_Natal_FériasCaption_Control1102059046"; Subsídios_Natal_FériasCaption_Control1102059046Lbl)
                {
                }
                column("Subsídio_AlmoçoCaption_Control1102059047"; Subsídio_AlmoçoCaption_Control1102059047Lbl)
                {
                }
                column(DiuturnidadesCaption_Control1102059048; DiuturnidadesCaption_Control1102059048Lbl)
                {
                }
                column(VencimentoCaption_Control1102059049; VencimentoCaption_Control1102059049Lbl)
                {
                }
                column(NomeCaption_Control1102059050; NomeCaption_Control1102059050Lbl)
                {
                }
                column(Processado_por_ComputadorCaption_Control1102059072; Processado_por_ComputadorCaption_Control1102059072Lbl)
                {
                }
                column("Hist__Movs__Empregado_Cód__Processamento"; "Cód. Processamento")
                {
                }
                column(Hist__Movs__Empregado_Tipo_Processamento; "Tipo Processamento")
                {
                }
                column(HistMovs_Emp_VB; decVencBase)
                {
                }
                dataitem("Hist. Linhas Movs. Empregado1"; "Hist. Linhas Movs. Empregado")
                {
                    DataItemLink = "Cód. Processamento" = FIELD("Cód. Processamento"), "Tipo Processamento" = FIELD("Tipo Processamento"), "No. Empregado" = FIELD("No. Empregado");
                    DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado", "No. Linha") WHERE("Tipo Processamento" = FILTER(<> Encargos));

                    trigger OnAfterGetRecord()
                    var
                        _DataInicioProcMin: Date;
                        _DataInicioProcMax: Date;
                        _DataFimProcMin: Date;
                        _DataFimProcMax: Date;
                        _PerProcessamento: Record "Periodos Processamento";
                    begin
                        if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then
                            CurrReport.Skip
                        else begin

                            TabRubrica.Reset;
                            if TabRubrica.Get("Hist. Linhas Movs. Empregado1"."Cód. Rubrica") then begin
                                if TabRubrica."Mapa Companhia Seguros" = true then begin
                                    //      Total := Total + "Hist. Linhas Movs. Empregado1".Valor;
                                    //      TotalGlobal := TotalGlobal + "Hist. Linhas Movs. Empregado1".Valor;
                                end;
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
                        if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then
                            CurrReport.Skip;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if TabEmpregado.Get("No. Empregado") then
                        decVencBase := TabEmpregado."Valor Vencimento Base";


                    /*
                    //FBC - 26-03-2007 - Erro de pagina a branco
                     TabLinhasMov.RESET;
                     TabLinhasMov.SETRANGE(TabLinhasMov."Cód. Processamento","Periodos Processamento"."Cód. Processamento");
                     TabLinhasMov.SETRANGE(TabLinhasMov."Tipo Processamento","Periodos Processamento"."Tipo Processamento");
                     TabLinhasMov.SETRANGE(TabLinhasMov."Nº Empregado","Nº Empregado");
                     IF NOT TabLinhasMov.FIND('-') THEN BEGIN
                        TabHistLinhasMov.RESET;
                        TabHistLinhasMov.SETRANGE(TabHistLinhasMov."Cód. Processamento","Periodos Processamento"."Cód. Processamento");
                        TabHistLinhasMov.SETRANGE(TabHistLinhasMov."Tipo Processamento","Periodos Processamento"."Tipo Processamento");
                        TabHistLinhasMov.SETRANGE(TabHistLinhasMov."Nº Empregado","Nº Empregado");
                        IF NOT TabHistLinhasMov.FIND('-') THEN BEGIN
                           CurrReport.SKIP;
                        END;
                    
                     END;
                    
                     */



                    if Seguradora = '' then
                        CurrReport.Skip;



                    //----------

                    if ((CodSeg <> '') and (UpperCase(CodSeg) <> UpperCase(Seguradora))) or
                       ((CodApo <> '') and (UpperCase(CodApo) <> UpperCase("No. Apólice"))) then begin
                        //TODO: Check this report
                        //CurrReport.NewPage;
                        //CurrReport.PageNo := 1;
                        TotalVencimento := 0;
                        TotalDiuturnidades := 0;
                        TotalSubsAlmoco := 0;
                        TotalSubsNatalFerias := 0;
                        TotalOutros := 0;
                        TotalGlobal := 0;
                    end;

                    CodSeg := Seguradora;
                    CodApo := "No. Apólice";

                    //-----------



                    if nemp <> "Hist. Movs. Empregado"."No. Empregado" then begin
                        nemp := "Hist. Movs. Empregado"."No. Empregado";

                        //2009.04.16
                        Clear(valorvencimento);
                        Clear(valorDiuturnidades);
                        Clear(valorSubsAlmoco);
                        Clear(valorSubsNatalFerias);
                        Clear(valorOutros);
                        Clear(Total);
                        Clear(NDias);
                        //fim


                        //2009.04.16 -Fiz o IF para n apanhar os inactivos
                        "Hist. Movs. Empregado".CalcFields("Hist. Movs. Empregado".Valor);
                        if "Hist. Movs. Empregado".Valor <> 0 then begin

                            Vencimentos("No. Empregado");
                            ProcessaFaltas("No. Empregado");
                            Diuturnidades("No. Empregado");
                            SubsAlmoco("No. Empregado");
                            SubsNatalFerias("No. Empregado");
                            ProcessaOutros("No. Empregado");
                            OutrosAbonos("No. Empregado");
                            CalcTotal();

                            TotalVencimento += valorvencimento;
                            TotalDiuturnidades += valorDiuturnidades;
                            TotalSubsAlmoco += valorSubsAlmoco;
                            TotalSubsNatalFerias += valorSubsNatalFerias;
                            TotalOutros += valorOutros;
                        end;
                    end;

                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FieldNo("No. Apólice");




                    Mes := Date2DMY("Periodos Processamento"."Data Registo", 2);
                    Ano := Date2DMY("Periodos Processamento"."Data Registo", 3);
                    Mensal := Month(Mes);

                    //dataInicioProc := 0D;
                    //dataFimProc := 0D;

                    TotalVencimento := 0;
                    TotalDiuturnidades := 0;
                    TotalSubsAlmoco := 0;
                    TotalSubsNatalFerias := 0;
                    TotalOutros := 0;
                    TotalGlobal := 0;
                    NDias := 0;


                    //C+ - AFG

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
                            _DataFimProcMax := _PerProcessamento.GetRangeMin("Data Fim Processamento");

                            SetRange("Data Registo", _DataInicioProcMin, _DataFimProcMax)
                        end;
                    end
                    else begin
                        SetFilter("Cód. Processamento", FiltroCodProc);
                    end;

                    //C+ - AFG




                    if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then
                        CurrReport.Skip;

                    CodSeg := '';
                    CodApo := '';
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if TabEmpregado.Find('-') then;

                //HG 17.04.07 - Se o processamento não está fechado tem de aparecer no mapa a indicação de que este é provisório
                if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then
                    varProvisorio := 'Provisório'
                else
                    varProvisorio := '';
            end;

            trigger OnPreDataItem()
            begin
                if CodProcess <> '' then
                    SetFilter("Cód. Processamento", CodProcess);
                if DataInicio <> 0D then
                    SetRange("Data Inicio Processamento", DataInicio);
                if DataFim <> 0D then
                    SetRange("Data Fim Processamento", DataFim);

                FiltroDataInicProc := "Periodos Processamento".GetFilter("Data Inicio Processamento");
                FiltroDataFimProc := "Periodos Processamento".GetFilter("Data Fim Processamento");
                FiltroCodProc := "Periodos Processamento".GetFilter("Cód. Processamento");
                Evaluate(dataInicioProc, "Periodos Processamento".GetFilter("Data Inicio Processamento"));
                Evaluate(dataFimProc, "Periodos Processamento".GetFilter("Data Fim Processamento"));
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
                group("Companhia Seguros")
                {
                    Caption = 'Companhia Seguros';
                    field(CodProcess; CodProcess)
                    {
                        ;
                        Caption = 'Cód. Processamento';
                        TableRelation = "Periodos Processamento";
                    }
                    field(DataInicio; DataInicio)
                    {
                        ;
                        Caption = 'Data Inicio';
                    }
                    field(DataFim; DataFim)
                    {
                        ;
                        Caption = 'Data Fim';
                    }
                    field(Venc; varVencimento)
                    {
                        ;
                        Caption = 'Vencimento';
                        TableRelation = "Rubrica Salarial";

                        trigger OnLookup(var Text: Text): Boolean
                        begin

                            Clear(ListaRubricas);
                            ListaRubricas.LookupMode(true);
                            if not (ListaRubricas.RunModal = ACTION::LookupOK) then
                                exit(false)
                            else
                                Text := Text + ListaRubricas.GetSelectionFilter;
                            exit(true);

                            varVencimento := Text;
                        end;
                    }
                    field(Diu; varDiuturnidades)
                    {
                        ;
                        Caption = 'Diuturnidades';
                        TableRelation = "Rubrica Salarial";

                        trigger OnLookup(var Text: Text): Boolean
                        begin

                            Clear(ListaRubricas);
                            ListaRubricas.LookupMode(true);
                            if not (ListaRubricas.RunModal = ACTION::LookupOK) then
                                exit(false)
                            else
                                Text := Text + ListaRubricas.GetSelectionFilter;
                            exit(true);

                            varDiuturnidades := Text;
                        end;
                    }
                    field(SA; varSubsAlmoco)
                    {
                        ;
                        Caption = 'Subsídio Almoço';
                        TableRelation = "Rubrica Salarial";

                        trigger OnLookup(var Text: Text): Boolean
                        begin

                            Clear(ListaRubricas);
                            ListaRubricas.LookupMode(true);
                            if not (ListaRubricas.RunModal = ACTION::LookupOK) then
                                exit(false)
                            else
                                Text := Text + ListaRubricas.GetSelectionFilter;
                            exit(true);

                            varSubsAlmoco := Text;
                        end;
                    }
                    field(SF; varSubsNatalFerias)
                    {
                        ;
                        Caption = 'Subsídio Natal/Férias';
                        TableRelation = "Rubrica Salarial";

                        trigger OnLookup(var Text: Text): Boolean
                        begin

                            Clear(ListaRubricas);
                            ListaRubricas.LookupMode(true);
                            if not (ListaRubricas.RunModal = ACTION::LookupOK) then
                                exit(false)
                            else
                                Text := Text + ListaRubricas.GetSelectionFilter;
                            exit(true);

                            varSubsNatalFerias := Text;
                        end;
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
        lblVenBase = 'Venc. Base';
        lblProcComp = 'Processado por Computador';
    }

    trigger OnPreReport()
    begin

        TabConfEmpresa.Get;
        TabConfEmpresa.CalcFields(Picture);
        TabConfContab.Get();

        //C+ - AFG

        FiltroDataInicProc := '';
        FiltroDataFimProc := '';
        FiltroCodProc := '';


        if (FiltroDataInicProc <> '') and (FiltroDataFimProc <> '') and (FiltroCodProc <> '') then
            Error(Text0002);

        if (FiltroDataFimProc <> '') and (FiltroDataInicProc = '') then
            Error(Text0003);

        if (FiltroDataFimProc <> '') and (FiltroDataInicProc = '') then
            Error(Text0003);


        //C+ - AFG
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TabConfContab: Record "General Ledger Setup";
        TabEmpregado: Record Employee;
        TabConfEmpresa: Record "Company Information";
        Total: Decimal;
        TotalGlobal: Decimal;
        TabLinhasMov: Record "Linhas Movs. Empregado";
        TabHistLinhasMov: Record "Hist. Linhas Movs. Empregado";
        TabRubrica: Record "Rubrica Salarial";
        FiltroDataInicProc: Text[1024];
        FiltroDataFimProc: Text[1024];
        FiltroCodProc: Text[1024];
        Text0001: Label 'O processamento tem de estar Fechado.';
        Text0002: Label 'Os filtros data de processamento e código de processamento são exclusivos. Não pode selecionar ambos.';
        Text0003: Label 'Tem que preencher a data de início e fim de processamento.';
        Mes: Integer;
        Ano: Integer;
        Mensal: Text[30];
        varProvisorio: Text[30];
        varVencimento: Text[1024];
        varDiuturnidades: Text[1024];
        varSubsAlmoco: Text[1024];
        varSubsNatalFerias: Text[1024];
        varOutros: Text[1024];
        valorvencimento: Decimal;
        dataInicioProc: Date;
        dataFimProc: Date;
        rPerProcessamento: Record "Periodos Processamento";
        valorDiuturnidades: Decimal;
        valorSubsAlmoco: Decimal;
        valorSubsNatalFerias: Decimal;
        valorOutros: Decimal;
        TotalVencimento: Decimal;
        TotalDiuturnidades: Decimal;
        TotalSubsAlmoco: Decimal;
        TotalSubsNatalFerias: Decimal;
        TotalOutros: Decimal;
        _DataInicioProcMin: Date;
        _DataInicioProcMax: Date;
        _DataFimProcMin: Date;
        _DataFimProcMax: Date;
        _PerProcessamento: Record "Periodos Processamento";
        CodEmp: Code[30];
        CodSeg: Text[60];
        CodApo: Text[20];
        nemp: Code[20];
        NDias: Decimal;
        N__EmpregadoCaptionLbl: Label 'Nº Empregado';
        NomeCaptionLbl: Label 'Nome';
        VencimentoCaptionLbl: Label 'Vencimento';
        DiuturnidadesCaptionLbl: Label 'Diuturnidades';
        "Subsídio_AlmoçoCaptionLbl": Label 'Subsídio Almoço';
        "Subsídios_Natal_FériasCaptionLbl": Label 'Subsídios Natal/Férias';
        Outros_AbonosCaptionLbl: Label 'Outros Abonos';
        TotalCaptionLbl: Label 'Total';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        MAPA_COMPANHIA_DE_SEGUROSCaptionLbl: Label 'MAPA COMPANHIA DE SEGUROS';
        DiasCaptionLbl: Label 'Dias';
        Companhia_de_Seguros_CaptionLbl: Label 'Companhia de Seguros:';
        "N__Apólice_CaptionLbl": Label 'Nº Apólice:';
        Periodo_de_Processamento_CaptionLbl: Label 'Periodo de Processamento:';
        TotalCaption_Control1102059074Lbl: Label 'Total';
        Outros_AbonosCaption_Control1102059075Lbl: Label 'Outros Abonos';
        "Subsídios_Natal_FériasCaption_Control1102059076Lbl": Label 'Subsídios Natal/Férias';
        "Subsídio_AlmoçoCaption_Control1102059079Lbl": Label 'Subsídio Almoço';
        DiuturnidadesCaption_Control1102059080Lbl: Label 'Diuturnidades';
        VencimentoCaption_Control1102059081Lbl: Label 'Vencimento';
        NomeCaption_Control1102059082Lbl: Label 'Nome';
        N__EmpregadoCaption_Control1102059083Lbl: Label 'Nº Empregado';
        CurrReport_PAGENO_Control1102059116CaptionLbl: Label 'Page';
        MAPA_COMPANHIA_DE_SEGUROSCaption_Control1102059124Lbl: Label 'MAPA COMPANHIA DE SEGUROS';
        DiasCaption_Control1102065005Lbl: Label 'Dias';
        TotaisCaptionLbl: Label 'Totais';
        Processado_por_ComputadorCaptionLbl: Label 'Processado por Computador';
        N__EmpregadoCaption_Control1102059028Lbl: Label 'Nº Empregado';
        NomeCaption_Control1102059029Lbl: Label 'Nome';
        VencimentoCaption_Control1102059030Lbl: Label 'Vencimento';
        DiuturnidadesCaption_Control1102059031Lbl: Label 'Diuturnidades';
        "Subsídio_AlmoçoCaption_Control1102059032Lbl": Label 'Subsídio Almoço';
        "Subsídios_Natal_FériasCaption_Control1102059033Lbl": Label 'Subsídios Natal/Férias';
        Outros_AbonosCaption_Control1102059034Lbl: Label 'Outros Abonos';
        TotalCaption_Control1102059035Lbl: Label 'Total';
        CurrReport_PAGENO_Control1102059088CaptionLbl: Label 'Page';
        MAPA_COMPANHIA_DE_SEGUROSCaption_Control1102059096Lbl: Label 'MAPA COMPANHIA DE SEGUROS';
        DiasCaption_Control1102065006Lbl: Label 'Dias';
        Companhia_de_Seguros_Caption_Control1102059038Lbl: Label 'Companhia de Seguros:';
        "N__Apólice_Caption_Control1102059040Lbl": Label 'Nº Apólice:';
        Periodo_de_Processamento_Caption_Control1102059042Lbl: Label 'Periodo de Processamento:';
        TotalCaption_Control1102059044Lbl: Label 'Total';
        Outros_AbonosCaption_Control1102059045Lbl: Label 'Outros Abonos';
        "Subsídios_Natal_FériasCaption_Control1102059046Lbl": Label 'Subsídios Natal/Férias';
        "Subsídio_AlmoçoCaption_Control1102059047Lbl": Label 'Subsídio Almoço';
        DiuturnidadesCaption_Control1102059048Lbl: Label 'Diuturnidades';
        VencimentoCaption_Control1102059049Lbl: Label 'Vencimento';
        NomeCaption_Control1102059050Lbl: Label 'Nome';
        N__EmpregadoCaption_Control1102059051Lbl: Label 'Nº Empregado';
        CurrReport_PAGENO_Control1102059102CaptionLbl: Label 'Page';
        MAPA_COMPANHIA_DE_SEGUROSCaption_Control1102059110Lbl: Label 'MAPA COMPANHIA DE SEGUROS';
        DiasCaption_Control1102065007Lbl: Label 'Dias';
        TotaisCaption_Control1102059061Lbl: Label 'Totais';
        Processado_por_ComputadorCaption_Control1102059072Lbl: Label 'Processado por Computador';
        CodProcess: Code[10];
        DataInicio: Date;
        DataFim: Date;
        ListaRubricas: Page "Lista Rubrica Salarial";
        decVencBase: Decimal;


    procedure Month(mes: Integer) Mensal: Text[30]
    var
        i: Integer;
    begin
        case mes of
            1:
                Mensal := 'Janeiro';
            2:
                Mensal := 'Fevereiro';
            3:
                Mensal := 'Março';
            4:
                Mensal := 'Abril';
            5:
                Mensal := 'Maio';
            6:
                Mensal := 'Junho';
            7:
                Mensal := 'Julho';
            8:
                Mensal := 'Agosto';
            9:
                Mensal := 'Setembro';
            10:
                Mensal := 'Outubro';
            11:
                Mensal := 'Novembro';
            12:
                Mensal := 'Dezembro';
        end;
    end;


    procedure Vencimentos(pEmpregado: Code[30])
    var
        rLinhasMovsEmpregado: Record "Linhas Movs. Empregado";
        rLinhasHistMovsEmpregado: Record "Hist. Linhas Movs. Empregado";
    begin
        //RFV 24.01.2008
        if varVencimento <> '' then begin
            valorvencimento := 0;
            if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then begin
                rLinhasMovsEmpregado.Reset;
                rLinhasMovsEmpregado.SetFilter("No. Empregado", pEmpregado);
                //comentei para poder colocar rubricas de desconto como por exemplo a incapacidade
                //rLinhasMovsEmpregado.SETRANGE("Tipo Rubrica",rLinhasMovsEmpregado."Tipo Rubrica"::Abono);
                if FiltroCodProc <> '' then rLinhasMovsEmpregado.SetFilter("Cód. Processamento", FiltroCodProc);
                if dataInicioProc <> 0D then
                    rLinhasMovsEmpregado.SetRange("Data Registo", dataInicioProc, dataFimProc);
                rLinhasMovsEmpregado.SetFilter("Cód. Rubrica", varVencimento);
                if rLinhasMovsEmpregado.Find('-') then begin
                    repeat
                        valorvencimento += rLinhasMovsEmpregado.Valor;
                        NDias += rLinhasMovsEmpregado.Quantidade;
                    until rLinhasMovsEmpregado.Next = 0;
                end;
            end
            else begin
                rLinhasHistMovsEmpregado.Reset;
                rLinhasHistMovsEmpregado.SetFilter("No. Empregado", pEmpregado);
                //comentei para poder colocar rubricas de desconto como por exemplo a incapacidade
                //rLinhasHistMovsEmpregado.SETRANGE("Tipo Rubrica",rLinhasMovsEmpregado."Tipo Rubrica"::Abono);
                if FiltroCodProc <> '' then rLinhasHistMovsEmpregado.SetFilter("Cód. Processamento", FiltroCodProc);
                if dataInicioProc <> 0D then
                    rLinhasHistMovsEmpregado.SetRange("Data Registo", dataInicioProc, dataFimProc);
                rLinhasHistMovsEmpregado.SetFilter("Cód. Rubrica", varVencimento);
                if rLinhasHistMovsEmpregado.Find('-') then begin
                    repeat
                        valorvencimento += rLinhasHistMovsEmpregado.Valor;
                        NDias += rLinhasHistMovsEmpregado.Quantidade;
                    until rLinhasHistMovsEmpregado.Next = 0;
                end;
            end;

        end;
        //RFV
    end;


    procedure Diuturnidades(pEmpregado: Code[30])
    var
        rLinhasMovsEmpregado: Record "Linhas Movs. Empregado";
        rLinhasHistMovsEmpregado: Record "Hist. Linhas Movs. Empregado";
    begin
        //RFV 24.01.2008
        if varDiuturnidades <> '' then begin
            valorDiuturnidades := 0;
            if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then begin
                rLinhasMovsEmpregado.Reset;
                rLinhasMovsEmpregado.SetFilter("No. Empregado", pEmpregado);
                //comentei para poder colocar rubricas de desconto como por exemplo a incapacidade
                //rLinhasMovsEmpregado.SETRANGE("Tipo Rubrica",rLinhasMovsEmpregado."Tipo Rubrica"::Abono);
                if FiltroCodProc <> '' then rLinhasMovsEmpregado.SetFilter("Cód. Processamento", FiltroCodProc);
                if dataInicioProc <> 0D then
                    rLinhasMovsEmpregado.SetRange("Data Registo", dataInicioProc, dataFimProc);
                rLinhasMovsEmpregado.SetFilter("Cód. Rubrica", varDiuturnidades);
                if rLinhasMovsEmpregado.Find('-') then begin
                    repeat
                        valorDiuturnidades += rLinhasMovsEmpregado.Valor;
                    until rLinhasMovsEmpregado.Next = 0;
                end;
            end
            else begin
                rLinhasHistMovsEmpregado.Reset;
                rLinhasHistMovsEmpregado.SetFilter("No. Empregado", pEmpregado);
                //comentei para poder colocar rubricas de desconto como por exemplo a incapacidade
                //rLinhasHistMovsEmpregado.SETRANGE("Tipo Rubrica",rLinhasMovsEmpregado."Tipo Rubrica"::Abono);
                if FiltroCodProc <> '' then rLinhasHistMovsEmpregado.SetFilter("Cód. Processamento", FiltroCodProc);
                if dataInicioProc <> 0D then
                    rLinhasHistMovsEmpregado.SetRange("Data Registo", dataInicioProc, dataFimProc);
                rLinhasHistMovsEmpregado.SetFilter("Cód. Rubrica", varDiuturnidades);
                if rLinhasHistMovsEmpregado.Find('-') then begin
                    repeat
                        valorDiuturnidades += rLinhasHistMovsEmpregado.Valor;
                    until rLinhasHistMovsEmpregado.Next = 0;
                end;
            end;

        end;
        //RFV
    end;


    procedure SubsAlmoco(pEmpregado: Code[30])
    var
        rLinhasMovsEmpregado: Record "Linhas Movs. Empregado";
        rLinhasHistMovsEmpregado: Record "Hist. Linhas Movs. Empregado";
    begin
        //RFV 24.01.2008
        if varSubsAlmoco <> '' then begin
            valorSubsAlmoco := 0;
            if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then begin
                rLinhasMovsEmpregado.Reset;
                rLinhasMovsEmpregado.SetFilter("No. Empregado", pEmpregado);
                rLinhasMovsEmpregado.SetRange("Tipo Rubrica", rLinhasMovsEmpregado."Tipo Rubrica"::Abono);
                if FiltroCodProc <> '' then rLinhasMovsEmpregado.SetFilter("Cód. Processamento", FiltroCodProc);
                if dataInicioProc <> 0D then
                    rLinhasMovsEmpregado.SetRange("Data Registo", dataInicioProc, dataFimProc);
                rLinhasMovsEmpregado.SetFilter("Cód. Rubrica", varSubsAlmoco);
                if rLinhasMovsEmpregado.Find('-') then begin
                    repeat
                        valorSubsAlmoco += rLinhasMovsEmpregado.Valor;
                    until rLinhasMovsEmpregado.Next = 0;
                end;
            end
            else begin
                rLinhasHistMovsEmpregado.Reset;
                rLinhasHistMovsEmpregado.SetFilter("No. Empregado", pEmpregado);
                rLinhasHistMovsEmpregado.SetRange("Tipo Rubrica", rLinhasMovsEmpregado."Tipo Rubrica"::Abono);
                if FiltroCodProc <> '' then rLinhasHistMovsEmpregado.SetFilter("Cód. Processamento", FiltroCodProc);
                if dataInicioProc <> 0D then
                    rLinhasHistMovsEmpregado.SetRange("Data Registo", dataInicioProc, dataFimProc);
                rLinhasHistMovsEmpregado.SetFilter("Cód. Rubrica", varSubsAlmoco);
                if rLinhasHistMovsEmpregado.Find('-') then begin
                    repeat
                        valorSubsAlmoco += rLinhasHistMovsEmpregado.Valor;
                    until rLinhasHistMovsEmpregado.Next = 0;
                end;
            end;

        end;
        //RFV
    end;


    procedure SubsNatalFerias(pEmpregado: Code[30])
    var
        rLinhasMovsEmpregado: Record "Linhas Movs. Empregado";
        rLinhasHistMovsEmpregado: Record "Hist. Linhas Movs. Empregado";
    begin
        //RFV 24.01.2008
        if varSubsNatalFerias <> '' then begin
            valorSubsNatalFerias := 0;
            if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then begin
                rLinhasMovsEmpregado.Reset;
                rLinhasMovsEmpregado.SetFilter("No. Empregado", pEmpregado);
                rLinhasMovsEmpregado.SetRange("Tipo Rubrica", rLinhasMovsEmpregado."Tipo Rubrica"::Abono);
                if FiltroCodProc <> '' then rLinhasMovsEmpregado.SetFilter("Cód. Processamento", FiltroCodProc);
                if dataInicioProc <> 0D then
                    rLinhasMovsEmpregado.SetRange("Data Registo", dataInicioProc, dataFimProc);
                rLinhasMovsEmpregado.SetFilter("Cód. Rubrica", varSubsNatalFerias);
                if rLinhasMovsEmpregado.Find('-') then begin
                    repeat
                        valorSubsNatalFerias += rLinhasMovsEmpregado.Valor;
                    until rLinhasMovsEmpregado.Next = 0;
                end;
            end
            else begin
                rLinhasHistMovsEmpregado.Reset;
                rLinhasHistMovsEmpregado.SetFilter("No. Empregado", pEmpregado);
                rLinhasHistMovsEmpregado.SetRange("Tipo Rubrica", rLinhasMovsEmpregado."Tipo Rubrica"::Abono);
                if FiltroCodProc <> '' then rLinhasHistMovsEmpregado.SetFilter("Cód. Processamento", FiltroCodProc);
                if dataInicioProc <> 0D then
                    rLinhasHistMovsEmpregado.SetRange("Data Registo", dataInicioProc, dataFimProc);
                rLinhasHistMovsEmpregado.SetFilter("Cód. Rubrica", varSubsNatalFerias);
                if rLinhasHistMovsEmpregado.Find('-') then begin
                    repeat
                        valorSubsNatalFerias += rLinhasHistMovsEmpregado.Valor;
                    until rLinhasHistMovsEmpregado.Next = 0;
                end;
            end;

        end;
        //RFV
    end;


    procedure OutrosAbonos(pEmpregado: Code[30])
    var
        rLinhasMovsEmpregado: Record "Linhas Movs. Empregado";
        rLinhasHistMovsEmpregado: Record "Hist. Linhas Movs. Empregado";
    begin
        //RFV 24.01.2008

        valorOutros := 0;
        if varOutros <> '' then begin

            if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then begin
                rLinhasMovsEmpregado.Reset;
                rLinhasMovsEmpregado.SetFilter("No. Empregado", pEmpregado);
                rLinhasMovsEmpregado.SetRange("Tipo Rubrica", rLinhasMovsEmpregado."Tipo Rubrica"::Abono);
                if FiltroCodProc <> '' then rLinhasMovsEmpregado.SetFilter("Cód. Processamento", FiltroCodProc);
                if dataInicioProc <> 0D then
                    rLinhasMovsEmpregado.SetRange("Data Registo", dataInicioProc, dataFimProc);
                rLinhasMovsEmpregado.SetFilter("Cód. Rubrica", varOutros);
                if rLinhasMovsEmpregado.Find('-') then begin
                    repeat
                        valorOutros += rLinhasMovsEmpregado.Valor;
                    until rLinhasMovsEmpregado.Next = 0;
                end;
            end
            else begin
                rLinhasHistMovsEmpregado.Reset;
                rLinhasHistMovsEmpregado.SetFilter("No. Empregado", pEmpregado);
                rLinhasHistMovsEmpregado.SetRange("Tipo Rubrica", rLinhasMovsEmpregado."Tipo Rubrica"::Abono);
                if FiltroCodProc <> '' then rLinhasHistMovsEmpregado.SetFilter("Cód. Processamento", FiltroCodProc);
                if dataInicioProc <> 0D then
                    rLinhasHistMovsEmpregado.SetRange("Data Registo", dataInicioProc, dataFimProc);
                rLinhasHistMovsEmpregado.SetFilter("Cód. Rubrica", varOutros);
                if rLinhasHistMovsEmpregado.Find('-') then begin
                    repeat
                        valorOutros += rLinhasHistMovsEmpregado.Valor;
                    until rLinhasHistMovsEmpregado.Next = 0;
                end;
            end;

        end;
        //RFV
    end;


    procedure CalcTotal()
    begin
        //RFV 24.01.2008
        Total := 0;

        Total := valorvencimento + valorDiuturnidades + valorSubsAlmoco + valorSubsNatalFerias + valorOutros;

        TotalGlobal += Total;
        //RFV
    end;


    procedure ProcessaOutros(pEmpregado: Code[30])
    var
        rLinhasMovsEmpregado: Record "Linhas Movs. Empregado";
        rLinhasHistMovsEmpregado: Record "Hist. Linhas Movs. Empregado";
        first: Boolean;
    begin
        //RFV 12.02.2008

        varOutros := '';
        first := true;

        if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then begin
            rLinhasMovsEmpregado.Reset;
            rLinhasMovsEmpregado.SetFilter("No. Empregado", pEmpregado);
            rLinhasMovsEmpregado.SetRange("Tipo Rubrica", rLinhasMovsEmpregado."Tipo Rubrica"::Abono);
            if FiltroCodProc <> '' then rLinhasMovsEmpregado.SetFilter("Cód. Processamento", FiltroCodProc);
            if dataInicioProc <> 0D then
                rLinhasMovsEmpregado.SetRange("Data Registo", dataInicioProc, dataFimProc);
            if rLinhasMovsEmpregado.Find('-') then
                repeat
                    if StrPos(varVencimento, rLinhasMovsEmpregado."Cód. Rubrica") = 0 then begin
                        if StrPos(varDiuturnidades, rLinhasMovsEmpregado."Cód. Rubrica") = 0 then
                            if StrPos(varSubsAlmoco, rLinhasMovsEmpregado."Cód. Rubrica") = 0 then
                                if StrPos(varSubsNatalFerias, rLinhasMovsEmpregado."Cód. Rubrica") = 0 then
                                    if StrPos(varOutros, rLinhasMovsEmpregado."Cód. Rubrica") = 0 then begin
                                        TabRubrica.Reset;
                                        TabRubrica.Get(rLinhasMovsEmpregado."Cód. Rubrica");
                                        if TabRubrica."Mapa Companhia Seguros" = true then
                                            if first = true then begin
                                                varOutros += rLinhasMovsEmpregado."Cód. Rubrica";
                                                first := false;
                                            end
                                            else
                                                varOutros += '|' + rLinhasMovsEmpregado."Cód. Rubrica";
                                    end;
                    end;
                until rLinhasMovsEmpregado.Next = 0;
        end
        else begin
            rLinhasHistMovsEmpregado.Reset;
            rLinhasHistMovsEmpregado.SetFilter("No. Empregado", pEmpregado);
            rLinhasHistMovsEmpregado.SetRange("Tipo Rubrica", rLinhasHistMovsEmpregado."Tipo Rubrica"::Abono);
            if FiltroCodProc <> '' then rLinhasHistMovsEmpregado.SetFilter("Cód. Processamento", FiltroCodProc);
            if dataInicioProc <> 0D then
                rLinhasHistMovsEmpregado.SetRange("Data Registo", dataInicioProc, dataFimProc);
            if rLinhasHistMovsEmpregado.Find('-') then
                repeat
                    if StrPos(varVencimento, rLinhasHistMovsEmpregado."Cód. Rubrica") = 0 then begin
                        if StrPos(varDiuturnidades, rLinhasHistMovsEmpregado."Cód. Rubrica") = 0 then
                            if StrPos(varSubsAlmoco, rLinhasHistMovsEmpregado."Cód. Rubrica") = 0 then
                                if StrPos(varSubsNatalFerias, rLinhasHistMovsEmpregado."Cód. Rubrica") = 0 then
                                    if StrPos(varOutros, rLinhasHistMovsEmpregado."Cód. Rubrica") = 0 then begin
                                        TabRubrica.Reset;
                                        TabRubrica.Get(rLinhasHistMovsEmpregado."Cód. Rubrica");
                                        if TabRubrica."Mapa Companhia Seguros" = true then
                                            if first = true then begin
                                                varOutros += rLinhasHistMovsEmpregado."Cód. Rubrica";
                                                first := false;
                                            end
                                            else
                                                varOutros += '|' + rLinhasHistMovsEmpregado."Cód. Rubrica";
                                    end;
                    end;
                until rLinhasHistMovsEmpregado.Next = 0;

        end;


        //RFV
    end;


    procedure ProcessaFaltas(pEmpregado: Code[30])
    var
        rLinhasMovsEmpregado: Record "Linhas Movs. Empregado";
        rLinhasHistMovsEmpregado: Record "Hist. Linhas Movs. Empregado";
    begin
        //RFV 19.02.2008

        TabRubrica.Reset;
        //TabRubrica.SETRANGE(TabRubrica.Genero, TabRubrica.Genero::Falta);
        TabRubrica.SetFilter(TabRubrica.Genero, '%1|%2', TabRubrica.Genero::Falta, TabRubrica.Genero::"Admissão-Demissão");
        if TabRubrica.Find('-') then begin
            repeat

                if varVencimento <> '' then begin

                    if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then begin
                        rLinhasMovsEmpregado.Reset;
                        rLinhasMovsEmpregado.SetFilter("No. Empregado", pEmpregado);
                        rLinhasMovsEmpregado.SetRange("Tipo Rubrica", rLinhasMovsEmpregado."Tipo Rubrica"::Desconto);
                        if FiltroCodProc <> '' then rLinhasMovsEmpregado.SetFilter("Cód. Processamento", FiltroCodProc);
                        if dataInicioProc <> 0D then
                            rLinhasMovsEmpregado.SetRange("Data Registo", dataInicioProc, dataFimProc);
                        rLinhasMovsEmpregado.SetFilter("Cód. Rubrica", TabRubrica.Código);
                        if rLinhasMovsEmpregado.Find('-') then begin
                            repeat
                                valorvencimento += rLinhasMovsEmpregado.Valor;
                                if rLinhasMovsEmpregado.Quantidade < 0 then
                                    NDias += rLinhasMovsEmpregado.Quantidade
                                else
                                    NDias -= rLinhasMovsEmpregado.Quantidade;
                            until rLinhasMovsEmpregado.Next = 0;
                            // IF (varVencimento <> '') AND (valorvencimento = 0) THEN
                            //     CurrReport.SKIP;
                        end;
                    end
                    else begin
                        rLinhasHistMovsEmpregado.Reset;
                        rLinhasHistMovsEmpregado.SetFilter("No. Empregado", pEmpregado);
                        rLinhasHistMovsEmpregado.SetRange("Tipo Rubrica", rLinhasHistMovsEmpregado."Tipo Rubrica"::Desconto);
                        if FiltroCodProc <> '' then rLinhasHistMovsEmpregado.SetFilter("Cód. Processamento", FiltroCodProc);
                        if dataInicioProc <> 0D then
                            rLinhasHistMovsEmpregado.SetRange("Data Registo", dataInicioProc, dataFimProc);
                        rLinhasHistMovsEmpregado.SetFilter("Cód. Rubrica", TabRubrica.Código);
                        if rLinhasHistMovsEmpregado.Find('-') then begin
                            repeat
                                valorvencimento += rLinhasHistMovsEmpregado.Valor;
                                if rLinhasHistMovsEmpregado.Quantidade < 0 then
                                    NDias += rLinhasHistMovsEmpregado.Quantidade
                                else
                                    NDias -= rLinhasHistMovsEmpregado.Quantidade;

                            until rLinhasHistMovsEmpregado.Next = 0;
                            //  IF (varVencimento <> '') AND (valorvencimento = 0) THEN
                            //     CurrReport.SKIP;
                        end;
                    end;

                end;

            until TabRubrica.Next = 0;
        end;


        //RFV
    end;
}

