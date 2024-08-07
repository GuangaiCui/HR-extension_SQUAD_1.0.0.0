report 53097 "Contract Templates"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Contrato"; "Contrato Empregado")
        {
            column(CompanyName; CompanyInformation.Name)
            { }
            column(CompanyNIF; CompanyInformation."VAT Registration No.")
            { }
            column(CompanyAddress; CompanyInformation.Address)
            { }
            column(CompanyAddress2; CompanyInformation."Address 2")
            { }
            column(CompanyPostCode; CompanyInformation."Post Code")
            { }
            column(CompanyCity; CompanyInformation.City)
            { }
            column(CompanyRegistrationAuthority; CompanyInformation."PTSS Registration Authority")
            { }
            column(CompanyRegistrationNo; CompanyInformation."Registration No.")
            { }
            column(CompanyCAEDescription; CompanyInformation."PTSS CAE Description")
            { }
            column(EmployeeName; Employee.Name)
            { }
            column(EmployeeNationality; Employee."Nacionalidade Descrição")
            { }
            column(EmployeeAddress; Employee.Address)
            { }
            column(EmployeeAddress2; Employee."Address 2")
            { }
            column(EmployeePostCode; Employee."Post Code")
            { }
            column(EmployeeCity; Employee.City)
            { }
            column(EmployeeNIF; Employee."No. Contribuinte")
            { }
            column(EmployeeIDDocumentation; Employee."Documento Identificação")
            { }
            column(EmployeeIDNo; Employee."No. Doc. Identificação")
            { }
            column(EmployeeDataValDocID; Format(Employee."Data Validade Doc. Ident."))
            { }
            column(EmployeeEstadoCivil; Format(Employee."Estado Civil"))
            { }
            column(EmployeeLocalEmissao; Employee."Local Emissão Doc. Ident.")
            { }
            column(EmployeeNoHorasSemanais; Employee."No. Horas Semanais")
            { }
            column(EmployeeCounty; Employee.County)
            { }
            column(EmployeeCategoriaProfissional; Employee."Descrição Cat Prof QP")
            { }
            column(EmployeeVencimentoBase; Format(Employee."Valor Vencimento Base"))
            { }
            column(Employee_Hab_Literarias; Employee."Descrição Habilitações")
            { }
            column(Data_Inicio_Contrato; Contrato."Data Inicio Contrato")
            { }
            column(Data_Fim_Contrato; Contrato."Data Fim Contrato")
            { }
            column(WorkDate; format(WorkDate()))
            { }
            column(Estabelecimento; Estab_Emp."Descrição")
            { }
            trigger OnAfterGetRecord()
            begin
                if Employee.get(Contrato."Cód. Empregado") then;

                Employee.CalcFields(Employee."Cód. Cat. Prof QP");

                Estab_Emp.Reset();
                Estab_Emp.SetRange(Estab_Emp."Número da Unidade Local", Employee.Estabelecimento);
                if Estab_Emp.FindFirst() then;
            end;

            trigger OnPreDataItem()
            begin
                if CompanyInformation.Get then;


            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {

            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'ContractTemplates.rdl';
        }
    }

    var
        CompanyInformation: Record "Company Information";
        Employee: Record Employee;
        IDTYpe: Text;
        Estab_Emp: Record "Estabelecimentos da Empresa";
}