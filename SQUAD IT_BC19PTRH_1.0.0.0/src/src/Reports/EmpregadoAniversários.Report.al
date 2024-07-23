report 53063 "Empregado - Aniversários"
{
    // //-------------------------------------------------------
    //               Empregado - Aniversários
    // //--------------------------------------------------------
    // É um Mapa para listar as datas de Nascimento de cada Empregado.
    // Este Report está disponível a partir de Mapas.
    // //-------------------------------------------------------
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/EmpregadoAniversários.rdlc';

    Caption = 'Employee - Birthdays';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(Empregado; Employee)
        {
            RequestFilterFields = "No.";
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
            column(Empregado_TABLECAPTION__________EmployeeFilter; Empregado.TableCaption + ': ' + EmployeeFilter)
            {
            }
            column(Empregado__No__; "No.")
            {
            }
            column(FullName; FullName)
            {
            }
            column(Empregado__Birth_Date_; "Birth Date")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column("ANIVERSÁRIO_DOS_EMPREGADOSCaption"; ANIVERSÁRIO_DOS_EMPREGADOSCaptionLbl)
            {
            }
            column(Empregado__No__Caption; FieldCaption("No."))
            {
            }
            column(Full_NameCaption; Full_NameCaptionLbl)
            {
            }
            column(Empregado__Birth_Date_Caption; FieldCaption("Birth Date"))
            {
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("No.");
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
        EmployeeFilter := Empregado.GetFilters;
        TabConfEmpresa.Get;
        TabConfEmpresa.CalcFields(TabConfEmpresa.Picture);
    end;

    var
        LastFieldNo: Integer;
        EmployeeFilter: Text[250];
        TabConfEmpresa: Record "Company Information";
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        "ANIVERSÁRIO_DOS_EMPREGADOSCaptionLbl": Label 'ANIVERSÁRIO DOS EMPREGADOS';
        Full_NameCaptionLbl: Label 'Full Name';
}

