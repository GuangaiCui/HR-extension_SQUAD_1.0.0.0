page 31003140 "Pessoal dos Serviços Internos"
{
    AutoSplitKey = true;
    Caption = 'Pessoal dos Serviços Internos';
    PageType = List;
    SourceTable = "Pessoal dos Serviços Int";

    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field("Tipo de Técnico"; "Tipo de Técnico")
                {
                    ApplicationArea = All;

                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Nome; Nome)
                {
                    ApplicationArea = All;

                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("No. de Horas Mensais Afectação"; "No. de Horas Mensais Afectação")
                {
                    ApplicationArea = All;

                }
                field("No. da Cédula Profissional"; "No. da Cédula Profissional")
                {
                    ApplicationArea = All;

                }
                field("No. Certificado Aptidão Prof."; "No. Certificado Aptidão Prof.")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        if GetFilter("Tipo de Técnico") <> '' then
            CurrPage.Editable := false;
    end;
}

