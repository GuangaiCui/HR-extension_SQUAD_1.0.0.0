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
                    ;

                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Nome; Rec.Nome)
                {
                    ;

                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("No. de Horas Mensais Afectação"; Rec."No. de Horas Mensais Afectação")
                {
                    ;

                }
                field("No. da Cédula Profissional"; Rec."No. da Cédula Profissional")
                {
                    ;

                }
                field("No. Certificado Aptidão Prof."; Rec."No. Certificado Aptidão Prof.")
                {
                    ;

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

