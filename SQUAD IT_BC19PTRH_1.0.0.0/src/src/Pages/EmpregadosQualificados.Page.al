page 53042 "Empregados Qualificados"
{
    Caption = 'Qualified Employees';
    DataCaptionFields = "Qualification Code";
    Editable = false;
    PageType = List;
    SourceTable = "Qualificação Empregado";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = All;

                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = All;

                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = All;

                }
                field(Type; Type)
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
                {
                    ApplicationArea = All;

                }
                field("Institution/Company"; "Institution/Company")
                {
                    ApplicationArea = All;

                }
                field(Cost; Cost)
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field("Course Grade"; "Course Grade")
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
            group("Q&ualification")
            {
                Caption = 'Q&ualification';
                Image = Certificate;
                action("Comentários")
                {
                    ApplicationArea = All;

                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Employee Qualification"),
                                  "No." = FIELD("Employee No."),
                                  "Table Line No." = FIELD("Line No.");
                }
            }
        }
    }
}

