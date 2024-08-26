#pragma implicitwith disable
page 53044 "Familiares Empregado"
{
    AutoSplitKey = true;
    Caption = 'Employee Relatives';
    DataCaptionFields = "Employee No.";
    PageType = List;
    SourceTable = "Familiar Empregado";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Relative Code"; Rec."Relative Code")
                {


                }
                field(Name; Rec.Name)
                {


                }
                field("Birth Date"; Rec."Birth Date")
                {


                }
                field("Phone No."; Rec."Phone No.")
                {


                }
                field(Gender; Rec.Gender)
                {


                }
                field("Vat Number"; Rec."Vat Number")
                {


                }
                field("Emergency Contact"; Rec."Emergency Contact")
                {


                }
                field("Employee Relative No."; Rec."Employee Relative No.")
                {


                    Visible = false;
                }
                field(Comment; Rec.Comment)
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


                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Relative")
            {
                Caption = '&Relative';
                Image = Relatives;
                action("Comentário")
                {


                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Employee Relative"),
                                  "No." = FIELD("Employee No."),
                                  "Table Line No." = FIELD("Line No.");
                }
            }
        }
    }
}

#pragma implicitwith restore

