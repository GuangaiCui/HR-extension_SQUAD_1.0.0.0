report 53067 "Retenção Mensal de IRS"
{
    // //-------------------------------------------------------
    //               Retenção Mensal de IRS
    // //--------------------------------------------------------
    //   É um Mapa Legal a ser entregue mensalmente às Finanças
    //   com a listagens dos empregados e as retenções feitas.
    //   Este Report está disponível a partir de Mapas.
    // //-------------------------------------------------------
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\RetençãoMensaldeIRS.rdl';

    PreviewMode = PrintLayout;
    UseRequestPage = true;

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            DataItemTableView = SORTING("Primary Key");
            column(CompInf_Name; "Company Information".Name)
            {
            }
            column(CompInf_Name2; "Company Information"."Name 2")
            {
            }
            column(CompInf_Address; "Company Information".Address)
            {
            }
            column(CompInf_Address2; "Company Information"."Address 2")
            {
            }
            column(CompInf_City; "Company Information".City)
            {
            }
            column(CompInf_PostCode; "Company Information"."Post Code")
            {
            }
            column(CompInf_Picture; "Company Information".Picture)
            {
            }
            column(CompInf_Phone; 'Nº Telefone: ' + "Company Information"."Phone No.")
            {
            }
            column(CompInf_VatNo; 'Nº Contribuinte: ' + "Company Information"."VAT Registration No.")
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }

            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column("RETENÇÃO_MENSAL_DE_IRSCaption"; RETENÇÃO_MENSAL_DE_IRSCaptionLbl)
            {
            }
            column(Periodo_de_Processamento_Caption; Periodo_de_Processamento_CaptionLbl)
            {
            }
            column(Full_NameCaption; Full_NameCaptionLbl)
            {
            }
            column(NIFCaption; NIFCaptionLbl)
            {
            }
            column(N__EmpregadoCaption; N__EmpregadoCaptionLbl)
            {
            }
            column(Valor_RetidoCaption; Valor_RetidoCaptionLbl)
            {
            }
            column("Sobretaxa_ExtraordináriaCaption"; Sobretaxa_ExtraordináriaCaptionLbl)
            {
            }
            column(Processado_por_ComputadorCaption; Processado_por_ComputadorCaptionLbl)
            {
            }
            column(Trabalhadores_por_Conta_de_Outrem_Total_Caption; Trabalhadores_por_Conta_de_Outrem___Total_CaptionLbl)
            {
            }
            column(Trabalhadores_Independentes_Total_Caption; Trabalhadores_Independentes___Total_CaptionLbl)
            {
            }
            column(FORMAT_Mensal_FORMAT_Ano; Format(Mensal) + ' ' + Format(Ano))
            {
            }

            trigger OnAfterGetRecord()
            var
                l_PeriodosProc: Record "Periodos Processamento";
            begin
                if DataFim <> 0D then begin
                    Mes := Date2DMY(DataFim, 2);
                    Ano := Date2DMY(DataFim, 3);
                    Mensal := Month(Mes);
                end;

                if CodProcess <> '' then
                    if l_PeriodosProc.Get(CodProcess) then begin
                        Mes := Date2DMY(l_PeriodosProc."Data Registo", 2);
                        Ano := Date2DMY(l_PeriodosProc."Data Registo", 3);
                        Mensal := Month(Mes);
                    end;
            end;
        }
        dataitem("Periodos Processamento"; "Periodos Processamento")
        {
            DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento") WHERE("Tipo Processamento" = FILTER(<> Encargos));
            PrintOnlyIfDetail = true;

            trigger OnAfterGetRecord()
            begin
                //18.04.2007 - Não deixar correr o mapa para processamentos abertos
                if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then
                    Error(Text0001);
                //18.04.2007 - Fim

                recEmpregado.Reset;
                recEmpregado.SetCurrentKey("No.");
                recEmpregado.SetRange("Tipo Contribuinte", recEmpregado."Tipo Contribuinte"::"Conta de Outrem");
                recEmpregado.SetFilter(Status, '<>%1', recEmpregado.Status::Terminated);
                if not recEmpregado.FindFirst then begin
                    mostra := true;
                    CurrReport.Skip;
                end;

                recEmpregado.Reset;
                recEmpregado.SetCurrentKey("No.");
                recEmpregado.SetRange("Tipo Contribuinte", recEmpregado."Tipo Contribuinte"::"Trabalhador Independente");
                recEmpregado.SetFilter(Status, '<>%1', recEmpregado.Status::Terminated);
                if not recEmpregado.FindFirst then begin
                    mostra := true;
                    CurrReport.Skip;
                end;
            end;

            trigger OnPreDataItem()
            begin
                mostra := false;
                Empregado := EmpregadoA.GetFilter("No.");
                SetFilter("Cód. Processamento", CodProcess);
                if DataInicio <> 0D then
                    SetRange("Data Inicio Processamento", DataInicio, DataFim);
                if DataFim <> 0D then
                    SetRange("Data Fim Processamento", DataInicio, DataFim);

                FiltroDataInicProc := "Periodos Processamento".GetFilter("Data Inicio Processamento");
                FiltroDataFimProc := "Periodos Processamento".GetFilter("Data Fim Processamento");
                FiltroCodProc := "Periodos Processamento".GetFilter("Cód. Processamento");

                if (FiltroDataInicProc <> '') and (FiltroDataFimProc <> '') and (FiltroCodProc <> '') then
                    Error(Text0002);

                if (FiltroDataFimProc <> '') and (FiltroDataInicProc = '') then
                    Error(Text0003);

                if (FiltroDataFimProc = '') and (FiltroDataInicProc <> '') then
                    Error(Text0003);
            end;
        }
        dataitem(EmpregadoA; Empregado)
        {
            DataItemTableView = SORTING("No.") WHERE("Tipo Contribuinte" = FILTER("Conta de Outrem" | Pensionista));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(EmpregadoA_No_; "No.")
            {
            }
            dataitem("Hist. Linhas Movs. EmpregadoA"; "Hist. Linhas Movs. Empregado")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "Employee No.", "No. Linha") WHERE("Tipo Processamento" = FILTER(<> Encargos), "Payroll Item Type" = CONST(Desconto));

                trigger OnAfterGetRecord()
                begin

                    if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then
                        CurrReport.Skip
                    else begin
                        TabRubrica.Reset;
                        TabRubrica.SetRange(TabRubrica.Código, "Hist. Linhas Movs. EmpregadoA"."Payroll Item Code");
                        TabRubrica.SetRange(TabRubrica."Imposto Extraordinário", false);//2011.11.25
                        TabRubrica.SetRange(TabRubrica."Sobretaxa em Sede de IRS", false);//2013.01.14 Normatica
                        if TabRubrica.FindFirst then begin
                            if (TabRubrica.Genero = TabRubrica.Genero::IRS) or
                               (TabRubrica.Genero = TabRubrica.Genero::"IRS Sub. Férias") or
                               (TabRubrica.Genero = TabRubrica.Genero::"IRS Sub. Natal") then begin
                                VarIRS := VarIRS + "Hist. Linhas Movs. EmpregadoA".Valor;
                                TotalIRSA := TotalIRSA + "Hist. Linhas Movs. EmpregadoA".Valor;
                            end;
                        end;
                        TabRubrica.Reset;
                        TabRubrica.SetRange(TabRubrica.Código, "Hist. Linhas Movs. EmpregadoA"."Payroll Item Code");
                        TabRubrica.SetRange(TabRubrica."Sobretaxa em Sede de IRS", true);//2013.01.14 ormatica
                        if TabRubrica.FindFirst then begin
                            if (TabRubrica.Genero = TabRubrica.Genero::IRS) or
                               (TabRubrica.Genero = TabRubrica.Genero::"IRS Sub. Férias") or
                               (TabRubrica.Genero = TabRubrica.Genero::"IRS Sub. Natal") then begin
                                VarIRSExtra := VarIRSExtra + "Hist. Linhas Movs. EmpregadoA".Valor;
                                TotalIRSAExtra := TotalIRSAExtra + "Hist. Linhas Movs. EmpregadoA".Valor;
                            end;
                        end;
                        boolTV := true;
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
                        CurrReport.Skip
                    else begin
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

                                "Hist. Linhas Movs. EmpregadoA".SetRange("Data Registo", _DataInicioProcMin, _DataFimProcMax)
                            end;
                        end else
                            "Hist. Linhas Movs. EmpregadoA".SetFilter("Cód. Processamento", FiltroCodProc);
                    end;
                    boolTV := false;
                end;
            }
            dataitem(IntegerA; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                PrintOnlyIfDetail = false;
                column(EmpregadoA__No__; EmpregadoA."No.")
                {
                }
                column(EmpregadoA_Name; EmpregadoA.Name)
                {
                }
                column(EmpregadoA__No__Contribuinte_; EmpregadoA."No. Contribuinte")
                {
                }
                column(ABS_VarIRS_; Abs(VarIRS))
                {
                }
                column(ABS_VarIRSExtra_; Abs(VarIRSExtra))
                {
                }
                column(boolTV; boolTV)
                {
                }
                column(IntegerA_Number; Number)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if not boolTV then
                        CurrReport.Skip;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Clear(VarIRS);
                Clear(VarIRSExtra);
            end;
        }
        dataitem(EmpregadoB; Empregado)
        {
            DataItemTableView = SORTING("No.") WHERE("Tipo Contribuinte" = CONST("Trabalhador Independente"));
            column(EmpregadoB_No_; "No.")
            {
            }
            dataitem("Hist. Linhas Movs. EmpregadoB"; "Hist. Linhas Movs. Empregado")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "Employee No.", "No. Linha") WHERE("Tipo Processamento" = FILTER(<> Encargos), "Payroll Item Type" = CONST(Desconto));

                trigger OnAfterGetRecord()
                begin
                    if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then
                        CurrReport.Skip
                    else begin
                        TabRubrica.Reset;
                        TabRubrica.SetRange(TabRubrica.Código, "Hist. Linhas Movs. EmpregadoB"."Payroll Item Code");
                        if TabRubrica.FindFirst then begin
                            if (TabRubrica.Genero = TabRubrica.Genero::IRS) or
                               (TabRubrica.Genero = TabRubrica.Genero::"IRS Sub. Férias") or
                               (TabRubrica.Genero = TabRubrica.Genero::"IRS Sub. Natal") then begin
                                VarIRS := VarIRS + "Hist. Linhas Movs. EmpregadoB".Valor;
                                TotalIRSB := TotalIRSB + "Hist. Linhas Movs. EmpregadoB".Valor;
                            end;
                        end;
                        boolTV2 := true;
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
                        CurrReport.Skip
                    else begin
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

                                "Hist. Linhas Movs. EmpregadoB".SetRange("Data Registo", _DataInicioProcMin, _DataFimProcMax)
                            end;
                        end else
                            "Hist. Linhas Movs. EmpregadoB".SetFilter("Cód. Processamento", FiltroCodProc);

                    end;
                    boolTV2 := false;
                end;
            }
            dataitem(IntegerB; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(EmpregadoB__No__; EmpregadoB."No.")
                {
                }
                column(EmpregadoB_Name; EmpregadoB.Name)
                {
                }
                column(EmpregadoB__No__Contribuinte_; EmpregadoB."No. Contribuinte")
                {
                }
                column(ABS_VarIRS_B; Abs(VarIRS))
                {
                }
                column(boolTV2; boolTV2)
                {
                }
                column(IntegerB_Number; Number)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if not boolTV2 then
                        CurrReport.Skip;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Clear(VarIRS);
            end;

            trigger OnPreDataItem()
            begin
                SetFilter("No.", Empregado);
            end;
        }
        dataitem(integerTotal; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            column(ABS_TotalIRSA___TotalIRSB_; Abs(TotalIRSA + TotalIRSB))
            {
            }
            column(ABS_TotalIRSAExtra__Control1102065005; Abs(TotalIRSAExtra))
            {
            }
            column(Total_Global_Caption; Total_Global_CaptionLbl)
            {
            }
            column(integerTotal_Number; Number)
            {
            }
            column(Rodape_Number; Number)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if mostra then
                    CurrReport.Skip;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Retenção Mensal de IRS")
                {
                    Caption = 'Retenção Mensal de IRS';
                    field(CodProcess; CodProcess)
                    {

                        Caption = 'Cód. Processamento';
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
    }

    trigger OnInitReport()
    begin
        Message(Text0008);
    end;

    trigger OnPreReport()
    begin
        "Company Information".CalcFields("Company Information".Picture);
        FiltroDataInicProc := '';
        FiltroDataFimProc := '';
        FiltroCodProc := '';
    end;

    var
        TabConfEmpresa: Record "Company Information";
        TabRubrica: Record "Payroll Item";
        VarIRS: Decimal;
        TotalIRSA: Decimal;
        TotalIRSB: Decimal;
        Mes: Integer;
        Ano: Integer;
        Mensal: Text[30];
        Empregado: Code[20];
        recEmpregado: Record Empregado;
        mostra: Boolean;
        Text0001: Label 'Escolha um processamento já fechado.';
        FiltroDataInicProc: Text[1024];
        FiltroDataFimProc: Text[1024];
        FiltroCodProc: Text[1024];
        Text0008: Label 'Preencha o Cod. Processamento para tirar o Mapa para um só processamento.\ Ou preencha a Data de Inicio e de Fim, para tirar o Mapa para vários processamentos.';
        Text0002: Label 'Os filtros data de processamento e código de processamento são exclusivos. Não pode selecionar ambos.';
        Text0003: Label 'Tem que preencher a data de início e fim de processamento.';
        VarIRSExtra: Decimal;
        TotalIRSAExtra: Decimal;
        "RETENÇÃO_MENSAL_DE_IRSCaptionLbl": Label 'RETENÇÃO MENSAL DE IRS';
        Periodo_de_Processamento_CaptionLbl: Label 'Periodo de Processamento:';
        Full_NameCaptionLbl: Label 'Full Name';
        NIFCaptionLbl: Label 'NIF';
        N__EmpregadoCaptionLbl: Label 'Nº Empregado';
        Valor_RetidoCaptionLbl: Label 'Valor Retido';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        "Sobretaxa_ExtraordináriaCaptionLbl": Label 'Sobretaxa Extraordinária';
        Trabalhadores_por_Conta_de_Outrem___Total_CaptionLbl: Label 'Trabalhadores por Conta de Outrem - Total:';
        Trabalhadores_Independentes___Total_CaptionLbl: Label 'Trabalhadores Independentes - Total:';
        Total_Global_CaptionLbl: Label 'Total Global:';
        Processado_por_ComputadorCaptionLbl: Label 'Processado por Computador';
        CodProcess: Code[10];
        DataInicio: Date;
        DataFim: Date;
        boolTV: Boolean;
        boolTV2: Boolean;


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
}

