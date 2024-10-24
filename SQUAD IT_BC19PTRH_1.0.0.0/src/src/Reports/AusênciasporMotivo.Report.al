report 53061 "Ausências por Motivo"
{
    //  //-------------------------------------------------------
    //                 Ausencias por Motivos
    //  //--------------------------------------------------------
    //   É um Mapa para listar as ausencias registadas agrupadas
    //   por motivo de ausencia.
    //   Este Report está disponível a partir de Mapas.
    //  //-------------------------------------------------------
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\AusênciasporMotivo.rdl';

    Caption = 'Absences by Causes';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Absence Reason"; "Absence Reason")
        {
            DataItemTableView = SORTING(Code);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code";
            column(USERID; UserId)
            {
            }
            column(TabConfEmpresa_Picture; TabConfEmpresa.Picture)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(N__Contribuinte______TabConfEmpresa__VAT_Registration_No__; 'Nº Contribuinte: ' + TabConfEmpresa."VAT Registration No.")
            {
            }
            column(N__Telefone______TabConfEmpresa__Phone_No__; 'Nº Telefone: ' + TabConfEmpresa."Phone No.")
            {
            }
            column(TabConfEmpresa_City; TabConfEmpresa.City)
            {
            }
            column(TabConfEmpresa_Address; TabConfEmpresa.Address)
            {
            }
            column(TabConfEmpresa__Name_2_; TabConfEmpresa."Name 2")
            {
            }
            column(TabConfEmpresa_Name; TabConfEmpresa.Name)
            {
            }
            column(TabConfEmpresa__Post_Code_; TabConfEmpresa."Post Code")
            {
            }
            column(Texto; Texto)
            {
            }
            column("Motivo_Ausência_Description"; Description)
            {
            }
            column("Motivo_Ausência__Motivo_Ausência__Code"; "Absence Reason".Code)
            {
            }
            column("AUSÊNCIAS_POR_MOTIVOCaption"; AUSÊNCIAS_POR_MOTIVOCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column("Histórico_Ausências__From_Date_Caption"; "Histórico Ausências".FieldCaption("From Date"))
            {
            }
            column("Histórico_Ausências__To_Date_Caption"; "Histórico Ausências".FieldCaption("To Date"))
            {
            }
            column("Histórico_Ausências__Employee_No__Caption"; "Histórico Ausências".FieldCaption("Employee No."))
            {
            }
            column(Full_NameCaption; Full_NameCaptionLbl)
            {
            }
            column("Histórico_Ausências__Quantity__Base__Caption"; "Histórico Ausências".FieldCaption("Quantity (Base)"))
            {
            }
            column("Histórico_Ausências_QuantityCaption"; "Histórico Ausências".FieldCaption(Quantity))
            {
            }
            column("Cód__Unid__MedidaCaption"; Cód__Unid__MedidaCaptionLbl)
            {
            }
            dataitem("Histórico Ausências"; "Histórico Ausências")
            {
                DataItemLink = "Cause of Absence Code" = FIELD(Code);
                DataItemTableView = SORTING("Cause of Absence Code", "From Date");
                column("Histórico_Ausências__From_Date_"; "From Date")
                {
                }
                column("Histórico_Ausências__To_Date_"; "To Date")
                {
                }
                column("Histórico_Ausências__Quantity__Base__"; "Quantity (Base)")
                {
                }
                column("Histórico_Ausências__Employee_No__"; "Employee No.")
                {
                }
                column(Nome; Nome)
                {
                }
                column("Histórico_Ausências_Quantity"; Quantity)
                {
                }
                column("Histórico_Ausências__Unit_of_Measure_Code_"; "Unit of Measure Code")
                {
                }
                column(HumanResSetup__Base_Unit_of_Measure_; HumanResSetup."Base Unit of Measure")
                {
                }
                column(TotalAbsence; TotalAbsence)
                {
                    DecimalPlaces = 0 : 2;
                }
                column(HumanResSetup__Base_Unit_of_Measure__Control13; HumanResSetup."Base Unit of Measure")
                {
                }
                column("Histórico_Ausências_Description"; Description)
                {
                }
                column(Total_AbsenceCaption; Total_AbsenceCaptionLbl)
                {
                }
                column("Histórico_Ausências_Entry_No_"; "Entry No.")
                {
                }
                column("Histórico_Ausências_Cause_of_Absence_Code"; "Cause of Absence Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TotalAbsence := TotalAbsence + "Quantity (Base)";
                    if Employee.Get("Histórico Ausências"."Employee No.") then
                        Nome := Employee.Name;
                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FieldNo("Cause of Absence Code");
                    //TODO: Check is TotalAbsence has right value
                    //CurrReport.CreateTotals(TotalAbsence);

                    if AbertoFechado = 1 then
                        CurrReport.Break;

                    if (FiltroDataIni <> 0D) and (FiltroDataFim <> 0D) then
                        "Histórico Ausências".SetFilter("Histórico Ausências"."From Date", '%1..%2', FiltroDataIni, FiltroDataFim);
                end;
            }
            dataitem("Ausência Empregado"; "Ausência Empregado")
            {
                DataItemLink = "Cause of Absence Code" = FIELD(Code);
                DataItemTableView = SORTING("Cause of Absence Code", "From Date");
                column("Ausência_Empregado__From_Date_"; "From Date")
                {
                }
                column("Ausência_Empregado__To_Date_"; "To Date")
                {
                }
                column("Ausência_Empregado__Quantity__Base__"; "Quantity (Base)")
                {
                }
                column("Ausência_Empregado__Employee_No__"; "Employee No.")
                {
                }
                column(Nome_Control1102059004; Nome)
                {
                }
                column("Ausência_Empregado_Quantity"; Quantity)
                {
                }
                column("Ausência_Empregado__Unit_of_Measure_Code_"; "Unit of Measure Code")
                {
                }
                column(HumanResSetup__Base_Unit_of_Measure__Control1102059007; HumanResSetup."Base Unit of Measure")
                {
                }
                column(TotalAbsence_Control1102059008; TotalAbsence)
                {
                    DecimalPlaces = 0 : 2;
                }
                column(HumanResSetup__Base_Unit_of_Measure__Control1102059010; HumanResSetup."Base Unit of Measure")
                {
                }
                column("Ausência_Empregado_Description"; Description)
                {
                }
                column(Total_AbsenceCaption_Control1102059009; Total_AbsenceCaption_Control1102059009Lbl)
                {
                }
                column("Ausência_Empregado_Entry_No_"; "Entry No.")
                {
                }
                column("Ausência_Empregado_Cause_of_Absence_Code"; "Cause of Absence Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TotalAbsence := TotalAbsence + "Quantity (Base)";
                    if Employee.Get("Ausência Empregado"."Employee No.") then
                        Nome := Employee.Name;
                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FieldNo("Cause of Absence Code");
                    //TODO: Check is TotalAbsence has right value
                    //CurrReport.CreateTotals(TotalAbsence);
                    if AbertoFechado = 2 then
                        CurrReport.Break;

                    if (FiltroDataIni <> 0D) and (FiltroDataFim <> 0D) then
                        "Ausência Empregado".SetFilter("Ausência Empregado"."From Date", '%1..%2', FiltroDataIni, FiltroDataFim);
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Opções")
                {
                    Caption = 'Options';
                    field(AbertoFechado; AbertoFechado)
                    {
                        ApplicationArea = HumanResourcesAppArea;
                        Caption = 'Processamento';
                    }
                    field(FiltroDataIni; FiltroDataIni)
                    {
                        ApplicationArea = HumanResourcesAppArea;
                        Caption = 'Data Início';
                    }
                    field(FiltroDataFim; FiltroDataFim)
                    {
                        ApplicationArea = HumanResourcesAppArea;
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
        EmployeeAbsenceFilter := "Histórico Ausências".GetFilters;
        HumanResSetup.Get;
        HumanResSetup.TestField("Base Unit of Measure");

        TabConfEmpresa.Get;
        TabConfEmpresa.CalcFields(TabConfEmpresa.Picture);


        //C+ 2008.04.29
        if AbertoFechado = 1 then Texto := Text0001;
        if AbertoFechado = 2 then Texto := Text0002;
        if AbertoFechado = 0 then Error(text0003);
    end;

    var
        Employee: Record Empregado;
        HumanResSetup: Record "Config. Recursos Humanos";
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        EmployeeAbsenceFilter: Text[250];
        TotalAbsence: Decimal;
        TabConfEmpresa: Record "Company Information";
        Texto: Text[30];
        Text0001: Label 'Mês Aberto';
        Text0002: Label 'Mês Fechado';
        text0003: Label 'Tem de escolher uma das opções.';
        Nome: Text[250];
        FiltroDataIni: Date;
        "AUSÊNCIAS_POR_MOTIVOCaptionLbl": Label 'AUSÊNCIAS POR MOTIVO';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Full_NameCaptionLbl: Label 'Full Name';
        "Cód__Unid__MedidaCaptionLbl": Label 'Cód. Unid. Medida';
        Total_AbsenceCaptionLbl: Label 'Total Absence';
        Total_AbsenceCaption_Control1102059009Lbl: Label 'Total Absence';
        AbertoFechado: Option ,Aberto,Fechado;
        FiltroDataFim: Date;
}

