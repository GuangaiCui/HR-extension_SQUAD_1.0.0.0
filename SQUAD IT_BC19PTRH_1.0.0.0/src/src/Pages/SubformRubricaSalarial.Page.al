page 53099 "Subform Rubrica Salarial"
//NOTES: not in use, 
{
    AutoSplitKey = true;
    ApplicationArea = All;
    Caption = 'teste_vc';
    PageType = ListPart;
    SourceTable = "Rubrica Salarial Linhas";

    layout
    {
        area(Content)
        {
            repeater(Control1101490000)
            {
                field("Cód. Rubrica Filha"; Rec."Cód. Rubrica Filha")
                {


                }
                field("Descrição Rubrica Filha"; Rec."Descrição Rubrica Filha")
                {

                    Editable = false;
                }
                field("Tipo Rubrica Filha"; Rec."Tipo Rubrica Filha")
                {
                    Editable = false;

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
}


