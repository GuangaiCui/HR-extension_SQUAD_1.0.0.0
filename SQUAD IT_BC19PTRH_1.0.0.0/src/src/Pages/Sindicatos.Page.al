#pragma implicitwith disable
page 53048 Sindicatos
{
    //Caption = 'Unions';
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
                field("Code"; Rec.Code)
                {


                }
                field(Name; Rec.Name)
                {


                }
                field(Address; Rec.Address)
                {


                    Visible = false;
                }
                field("Post Code"; Rec."Post Code")
                {


                    Visible = false;
                }
                field(City; Rec.City)
                {


                    Visible = false;
                }
                field("Phone No."; Rec."Phone No.")
                {


                }
                field("No. of Members Employed"; Rec."No. of Members Employed")
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

