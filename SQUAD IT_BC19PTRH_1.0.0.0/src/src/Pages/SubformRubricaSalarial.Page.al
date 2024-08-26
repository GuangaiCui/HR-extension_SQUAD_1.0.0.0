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


                }
                field("Descrição Rubrica Filha"; Rec."Descrição Rubrica Filha")
                {


                }
                field("Tipo Rubrica Filha"; Rec."Tipo Rubrica Filha")
                {


                }
                field(Percentagem; Rec.Percentagem)
                {


                }
                field("Valor Limite Máximo"; Rec."Valor Limite Máximo")
                {


                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

