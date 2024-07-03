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
                field("Relative Code"; "Relative Code")
                {
                    ApplicationArea = All;

                }
                field(Name; Name)
                {
                    ApplicationArea = All;

                }
                field("Birth Date"; "Birth Date")
                {
                    ApplicationArea = All;

                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = All;

                }
                field(Gender; Gender)
                {
                    ApplicationArea = All;

                }
                field("Vat Number"; "Vat Number")
                {
                    ApplicationArea = All;

                }
                field("Emergency Contact"; "Emergency Contact")
                {
                    ApplicationArea = All;

                }
                field("Employee Relative No."; "Employee Relative No.")
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field(Comment; Comment)
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
                    ApplicationArea = All;

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

