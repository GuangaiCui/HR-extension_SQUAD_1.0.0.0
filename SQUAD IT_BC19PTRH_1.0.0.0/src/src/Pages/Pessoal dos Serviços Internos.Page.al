#pragma implicitwith disable
page 53140 "Pessoal dos Serviços Internos"
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
                field("Tipo de Técnico"; Rec."Tipo de Técnico")
                {
                    ApplicationArea = All;

                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Nome; Rec.Nome)
                {
                    ApplicationArea = All;

                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("No. de Horas Mensais Afectação"; Rec."No. de Horas Mensais Afectação")
                {
                    ApplicationArea = All;

                }
                field("No. da Cédula Profissional"; Rec."No. da Cédula Profissional")
                {
                    ApplicationArea = All;

                }
                field("No. Certificado Aptidão Prof."; Rec."No. Certificado Aptidão Prof.")
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
        if Rec.GetFilter("Tipo de Técnico") <> '' then
            CurrPage.Editable := false;
    end;
}

#pragma implicitwith restore

