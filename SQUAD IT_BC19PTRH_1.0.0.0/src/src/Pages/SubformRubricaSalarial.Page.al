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
                field("Cód. Rubrica Filha"; "Cód. Rubrica Filha")
                {
                    ApplicationArea = All;

                }
                field("Descrição Rubrica Filha"; "Descrição Rubrica Filha")
                {
                    ApplicationArea = All;

                }
                field("Tipo Rubrica Filha"; "Tipo Rubrica Filha")
                {
                    ApplicationArea = All;

                }
                field(Percentagem; Percentagem)
                {
                    ApplicationArea = All;

                }
                field("Valor Limite Máximo"; "Valor Limite Máximo")
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

