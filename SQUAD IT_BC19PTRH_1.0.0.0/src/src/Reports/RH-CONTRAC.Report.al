report 53096 "RH-CONTRAC"
{
    UsageCategory = ReportsAndAnalysis;
    ;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(Employee; Employee)
        {
            column(nome; Employee.Name)
            { }
            column(tipodoc; Tipodoc)
            { }
            column(nºdocIdentificação; Employee."No. Doc. Identificação")
            { }
            column(dataemissão; Format(Employee."Data Doc. Ident."))
            { }
            column(localemissão; Employee."Local Emissão Doc. Ident.")
            { }
            column(NIF; Employee."No. Contribuinte")
            { }
            column(morada; Employee.Address)
            { }
            column(morada2; Employee."Address 2")
            { }
            column(cidade; Employee.City)
            { }
            column(codpostal; Employee."Post Code")
            { }
            column(DatadeTrabalho; DatadeTrabalho)
            { }
            trigger OnAfterGetRecord()
            begin


                if Employee."Documento Identificação" = Employee."Documento Identificação"::BI then
                    Tipodoc := 'Bilhete de Identidade'
                else
                    Tipodoc := Format(Employee."Documento Identificação");


                Employee.CalcFields(Employee.Profissionalização);
                if Employee.Profissionalização = true then
                    Profissionalizado := 'Profissionalizado'
                else
                    Profissionalizado := 'não Profissionalizado';

                TabQualificacoes.Reset;
                TabQualificacoes.SetRange(TabQualificacoes."Employee No.", Employee."No.");
                TabQualificacoes.SetRange(TabQualificacoes.Type, TabQualificacoes.Type::"Habilitações Académicas");
                if TabQualificacoes.Find('+') then
                    DescriçãoCódigoHabilitação := '';

                DatadeTrabalho := Format(Today, 0, '<day> de <month text> de <year4>');
            end;


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
    begin





    end;

    var
        Profissionalizado: Text;
        Tipodoc: Text;
        TabQualificacoes: Record "Qualificação Empregado";
        DescriçãoCódigoHabilitação: Text;
        DatadeTrabalho: Text;


}