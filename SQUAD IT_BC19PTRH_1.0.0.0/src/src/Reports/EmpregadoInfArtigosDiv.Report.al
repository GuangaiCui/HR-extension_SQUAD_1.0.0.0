report 53059 "Empregado - Inf. Artigos Div"
{
    // //-------------------------------------------------------
    //               Empregado - Inf. Artigos Diversos
    // //--------------------------------------------------------
    //   É um Mapa para listar os artigos que cada empregado tem em
    //   seu poder.
    //   Este Report está disponível a partir de Mapas.
    // //-------------------------------------------------------
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\EmpregadoInfArtigosDiv.rdl';

    Caption = 'Employee - Misc. Article Info.';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Informação Artigos Div."; "Informação Artigos Div.")
        {
            DataItemTableView = SORTING("Employee No.", "Misc. Article Code", "Line No.");
            RequestFilterFields = "Employee No.", "Misc. Article Code";
            column(TabConfEmpresa_Picture; TabConfEmpresa.Picture)
            {
            }
            column(USERID; UserId)
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
            column(TabConfEmpresa_Name; TabConfEmpresa.Name)
            {
            }
            column(TabConfEmpresa__Post_Code_; TabConfEmpresa."Post Code")
            {
            }
            column(TabConfEmpresa__Name_2_; TabConfEmpresa."Name 2")
            {
            }
            column("Informação_Artigos_Div___TABLECAPTION__________MiscArticleFilter"; "Informação Artigos Div.".TableCaption + ': ' + MiscArticleFilter)
            {
            }
            column("Informação_Artigos_Div___Employee_No__"; "Employee No.")
            {
            }
            column(Employee_FullName; Employee.FullName)
            {
            }
            column("Informação_Artigos_Div___Misc__Article_Code_"; "Misc. Article Code")
            {
            }
            column("Informação_Artigos_Div__Description"; Description)
            {
            }
            column("Informação_Artigos_Div___Serial_No__"; "Serial No.")
            {
            }
            column("Informação_Artigos_Div___From_Date_"; "From Date")
            {
            }
            column("Informação_Artigos_Div___To_Date_"; "To Date")
            {
            }
            column("INFORMAÇÃO_ARTIGOS_DIVERSOS_POR_EMPREGADOCaption"; INFORMAÇÃO_ARTIGOS_DIVERSOS_POR_EMPREGADOCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column("Informação_Artigos_Div__DescriptionCaption"; FieldCaption(Description))
            {
            }
            column("Informação_Artigos_Div___Misc__Article_Code_Caption"; FieldCaption("Misc. Article Code"))
            {
            }
            column("Informação_Artigos_Div___Serial_No__Caption"; FieldCaption("Serial No."))
            {
            }
            column("Informação_Artigos_Div___From_Date_Caption"; FieldCaption("From Date"))
            {
            }
            column("Informação_Artigos_Div___To_Date_Caption"; FieldCaption("To Date"))
            {
            }
            column("Informação_Artigos_Div__Line_No_"; "Line No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "Employee No." <> '' then
                    Employee.Get("Employee No.")
                else
                    CurrReport.Skip;
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
        MiscArticleFilter := "Informação Artigos Div.".GetFilters;
        TabConfEmpresa.Get;
        TabConfEmpresa.CalcFields(TabConfEmpresa.Picture);
    end;

    var
        Employee: Record Employee;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        MiscArticleFilter: Text[250];
        TabConfEmpresa: Record "Company Information";
        "INFORMAÇÃO_ARTIGOS_DIVERSOS_POR_EMPREGADOCaptionLbl": Label 'INFORMAÇÃO ARTIGOS DIVERSOS POR EMPREGADO';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

