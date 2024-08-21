#pragma implicitwith disable
page 53051 "Departamentos Empregado"
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
                field("Code"; Rec.Code)
                {
                    ;

                }
                field(Description; Rec.Description)
                {
                    ;

                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

