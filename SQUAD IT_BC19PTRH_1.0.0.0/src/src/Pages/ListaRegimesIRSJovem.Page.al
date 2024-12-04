page 53125 "Lista Regimes IRS Jovem"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Regimes IRS Jovem";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {

                field(Code; Rec.Code)
                {
                    Editable = true;
                }
                field(Ano; Rec.Ano)
                {

                }
                field(Regime; Rec.Regime)
                {
                }

                field(Escalao; Rec.Escalao)
                {
                }
                field("Isenção"; Rec."Isenção")
                {
                }
                field("Limite"; Rec.Limite)
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}