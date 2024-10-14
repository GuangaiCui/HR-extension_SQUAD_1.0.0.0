#pragma implicitwith disable
page 53115 "Cargos Empregado"
{
    PageType = List;
    SourceTable = "Dispensa Sit - Cargos Empregad";
    ApplicationArea = HumanResourcesAppArea;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Designação Cargo"; Rec."Designação Cargo")
                {


                }
                field("Horas Totais do Cargo"; Rec."Horas Totais do Cargo")
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

