#pragma implicitwith disable
page 53083 "Instituição Seg. Social"
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
                field("Code"; Rec.Code)
                {
                    ;

                }
                field(Description; Rec.Description)
                {
                    ;

                }
                field(Address; Rec.Address)
                {
                    ;

                }
                field("Post Code"; Rec."Post Code")
                {
                    ;

                }
                field(City; Rec.City)
                {
                    ;

                }
                field("Phone No."; Rec."Phone No.")
                {
                    ;

                }
                field(Fax; Rec.Fax)
                {
                    ;

                }
                field(NIPC; Rec.NIPC)
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

