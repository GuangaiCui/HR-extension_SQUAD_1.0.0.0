page 31003051 "Departamentos Empregado"
{
    Caption = 'Employee Statistics Groups';
    PageType = List;
    SourceTable = "Departamentos Empregado";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
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

