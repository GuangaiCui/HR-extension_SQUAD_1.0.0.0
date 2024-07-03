page 31003083 "Instituição Seg. Social"
{
    AutoSplitKey = false;
    PageType = List;
    RefreshOnActivate = false;
    SourceTable = "Instituição Seg. Social";
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
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
                field(Address; Address)
                {
                    ApplicationArea = All;

                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = All;

                }
                field(City; City)
                {
                    ApplicationArea = All;

                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = All;

                }
                field(Fax; Fax)
                {
                    ApplicationArea = All;

                }
                field(NIPC; NIPC)
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

