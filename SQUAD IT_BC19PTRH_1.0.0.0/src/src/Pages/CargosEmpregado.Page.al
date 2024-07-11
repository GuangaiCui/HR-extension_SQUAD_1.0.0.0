#pragma implicitwith disable
page 53115 "Cargos Empregado"
{
    PageType = List;
    SourceTable = "Dispensa Sit - Cargos Empregad";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Designação Cargo"; Rec."Designação Cargo")
                {
                    ApplicationArea = All;

                }
                field("Horas Totais do Cargo"; Rec."Horas Totais do Cargo")
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

