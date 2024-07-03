page 31003055 Confidencial
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

