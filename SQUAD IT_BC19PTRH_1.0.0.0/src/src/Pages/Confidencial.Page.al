#pragma implicitwith disable
page 53055 Confidencial
{
    Caption = 'Confidential';
    PageType = List;
    SourceTable = Confidencial;
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

