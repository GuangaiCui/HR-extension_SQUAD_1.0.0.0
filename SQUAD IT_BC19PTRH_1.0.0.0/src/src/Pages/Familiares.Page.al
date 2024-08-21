#pragma implicitwith disable
page 53043 Familiares
{
    Caption = 'Relatives';
    PageType = List;
    SourceTable = Familiar;
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {


                }
                field(Description; Rec.Description)
                {


                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {


                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {


                Visible = false;
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

