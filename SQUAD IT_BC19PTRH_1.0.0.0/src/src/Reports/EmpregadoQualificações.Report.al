report 53062 "Empregado - Qualificações"
{
    // //-------------------------------------------------------
    //               Empregado - Qualificações
    // //--------------------------------------------------------
    //   É um Mapa para listar as qualificações de cada Empregado.
    //   Este Report está disponível a partir de Mapas.
    // //-------------------------------------------------------
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\EmpregadoQualificações.rdl';

    Caption = 'Employee - Qualifications';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Qualificação Empregado"; "Qualificação Empregado")
        {
            DataItemTableView = SORTING("Employee No.", Type, "Line No.");
            RequestFilterFields = "Employee No.", "Qualification Code";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(TabConfEmpresa_Picture; TabConfEmpresa.Picture)
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
            column("Qualificação_Empregado__TABLECAPTION__________EmployeeQualificationFilter"; "Qualificação Empregado".TableCaption + ': ' + EmployeeQualificationFilter)
            {
            }
            column("Qualificação_Empregado__Employee_No__"; "Employee No.")
            {
            }
            column(Employee_FullName; Employee.FullName)
            {
            }
            column("Qualificação_Empregado__From_Date_"; "From Date")
            {
            }
            column("Qualificação_Empregado__To_Date_"; "To Date")
            {
            }
            column(Tipo; Tipo)
            {
            }
            column(Descricao; Descricao)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column("QUALIFICAÇÕES_DOS_EMPREGADOSCaption"; QUALIFICAÇÕES_DOS_EMPREGADOSCaptionLbl)
            {
            }
            column("DescriçãoCaption"; DescriçãoCaptionLbl)
            {
            }
            column(TipoCaption; TipoCaptionLbl)
            {
            }
            column("Qualificação_Empregado__To_Date_Caption"; FieldCaption("To Date"))
            {
            }
            column("Qualificação_Empregado__From_Date_Caption"; FieldCaption("From Date"))
            {
            }
            column("Qualificação_Empregado_Type"; Type)
            {
            }
            column("Qualificação_Empregado_Line_No_"; "Line No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "Employee No." <> '' then
                    Employee.Get("Employee No.");

                if "Qualificação Empregado".Type = "Qualificação Empregado".Type::"Habilitações Académicas" then begin
                    Tipo := Format("Qualificação Empregado".Type);
                    Descricao := Format("Qualificação Empregado"."Academic Degree");
                    if "Qualificação Empregado"."Institution/Company" <> '' then
                        Descricao := Descricao + ' - ' + "Qualificação Empregado"."Institution/Company";
                    if "Qualificação Empregado"."Course Description" <> '' then
                        Descricao := Descricao + ' - ' + "Qualificação Empregado"."Course Description";
                    if "Qualificação Empregado"."Final Course Classification" <> '' then
                        Descricao := Descricao + ' - ' + "Qualificação Empregado"."Final Course Classification";
                end;

                if "Qualificação Empregado".Type = "Qualificação Empregado".Type::"Qualificações Profissionais" then begin
                    Tipo := Format("Qualificação Empregado".Type);
                    Descricao := "Qualificação Empregado".Description;
                    if "Qualificação Empregado"."Institution/Company" <> '' then
                        Descricao := Descricao + ' - ' + "Qualificação Empregado"."Institution/Company";
                end;

                if "Qualificação Empregado".Type = "Qualificação Empregado".Type::"Qualificações RU" then begin
                    Tipo := Text0001;
                    Descricao := Format("Qualificação Empregado"."Internal Qualification");
                end;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Employee No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
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
        EmployeeQualificationFilter := "Qualificação Empregado".GetFilters;
        TabConfEmpresa.Get;
        TabConfEmpresa.CalcFields(TabConfEmpresa.Picture);
    end;

    var
        Employee: Record Empregado;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        EmployeeQualificationFilter: Text[250];
        TabConfEmpresa: Record "Company Information";
        Tipo: Text[100];
        Descricao: Text[1024];
        Text0001: Label 'Qualificações Balanço Social';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        "QUALIFICAÇÕES_DOS_EMPREGADOSCaptionLbl": Label 'QUALIFICAÇÕES DOS EMPREGADOS';
        "DescriçãoCaptionLbl": Label 'Descrição';
        TipoCaptionLbl: Label 'Type';
}

