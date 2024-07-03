page 31003048 Sindicatos
{
    Caption = 'Unions';
    PageType = List;
    SourceTable = Sindicato;
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
                field(Name; Name)
                {
                    ApplicationArea = All;

                }
                field(Address; Address)
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field(City; City)
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = All;

                }
                field("No. of Members Employed"; "No. of Members Employed")
                {
                    ApplicationArea = All;

                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = All;

                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = All;

                Visible = false;
            }
        }
    }

    actions
    {
    }
}

