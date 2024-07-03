page 31003130 "Qualificações Empregado RU"
{
    AutoSplitKey = true;
    Caption = 'Employee Qualifications RU ';
    DataCaptionFields = "Employee No.";
    DelayedInsert = true;
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
                field("Internal Qualification"; "Internal Qualification")
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
                {
                    ApplicationArea = All;

                }
                field("Expiration Date"; "Expiration Date")
                {
                    ApplicationArea = All;

                    Visible = false;
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
    }

    actions
    {
        area(navigation)
        {
            group("&Qualificação")
            {
                Caption = 'Q&ualification';
                action("Co&mentários")
                {
                    ApplicationArea = All;

                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Folha Comentários RH";
                    RunPageLink = "Table Name" = CONST(Qual),
                                  "No." = FIELD("Employee No."),
                                  "Table Line No." = FIELD("Line No.");
                }
            }
        }
    }
}

