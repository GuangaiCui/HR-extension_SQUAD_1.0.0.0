report 53096 "RH-CONTRAC"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(Employee; Employee)
        {
            column(EmployeeName; Employee.Name)
            { }
            column(EmployeeDocumentType; Employee."Documento Identificação")
            { }
            column(EmployeeDocumentNo; Employee."No. Doc. Identificação")
            { }
            column(IssueDate; Format(Employee."Data Doc. Ident."))
            { }
            column(IssueLoc; Employee."Local Emissão Doc. Ident.")
            { }
            column(NIF; Employee."No. Contribuinte")
            { }
            column(Address; Employee.Address)
            { }
            column(Address2; Employee."Address 2")
            { }
            column(City; Employee.City)
            { }
            column(PostCode; Employee."Post Code")
            { }


        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'Layouts\RH-CONTRAC.rdl';
        }
    }

    var
        myInt: Integer;

    trigger OnPreReport()
    var
        RecEmployee: Record Employee;
    begin

        // if Empregado."Documento Identificação" = RecEmployee."Documento Identificação"::BI then
        //     EscreveWord2('«tipo doc»', 'Bilhete de Identidade', wdApp2)
        // else
        //     EscreveWord2('«tipo doc»', Format(Empregado."Documento Identificação"), wdApp2);


        // Empregado.CalcFields(Empregado.Profissionalização);
        // if Empregado.Profissionalização = true then
        //     EscreveWord2('«profissionalizado»', 'Profissionalizado', wdApp2)
        // else
        //     EscreveWord2('«profissionalizado»', 'não Profissionalizado', wdApp2);

        // TabQualificacoes.Reset;
        // TabQualificacoes.SetRange(TabQualificacoes."Employee No.", Empregado."No.");
        // TabQualificacoes.SetRange(TabQualificacoes.Type, TabQualificacoes.Type::"Habilitações Académicas");
        // if TabQualificacoes.Find('+') then
        //     EscreveWord2('«Descrição código habilitação»', '', wdApp2);

        // EscreveWord2('«data de trabalho»', Format(Today, 0, '<day> de <month text> de <year4>'), wdApp2);
    end;


}