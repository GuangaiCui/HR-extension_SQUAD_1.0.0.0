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
                field("Designação Cargo"; "Designação Cargo")
                {
                    ApplicationArea = All;

                }
                field("Horas Totais do Cargo"; "Horas Totais do Cargo")
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

