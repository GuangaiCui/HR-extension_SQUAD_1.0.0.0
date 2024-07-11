#pragma implicitwith disable
page 53099 "Subform Rubrica Salarial"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Rubrica Salarial Linhas";

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Cód. Rubrica Filha"; Rec."Cód. Rubrica Filha")
                {
                    ApplicationArea = All;

                }
                field("Descrição Rubrica Filha"; Rec."Descrição Rubrica Filha")
                {
                    ApplicationArea = All;

                }
                field("Tipo Rubrica Filha"; Rec."Tipo Rubrica Filha")
                {
                    ApplicationArea = All;

                }
                field(Percentagem; Rec.Percentagem)
                {
                    ApplicationArea = All;

                }
                field("Valor Limite Máximo"; Rec."Valor Limite Máximo")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

