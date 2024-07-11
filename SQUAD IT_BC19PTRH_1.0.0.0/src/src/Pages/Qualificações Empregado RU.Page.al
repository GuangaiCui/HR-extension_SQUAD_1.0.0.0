#pragma implicitwith disable
page 53130 "Qualificações Empregado RU"
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
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;

                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;

                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;

                }
                field("Internal Qualification"; Rec."Internal Qualification")
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field(Cost; Rec.Cost)
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field("Course Grade"; Rec."Course Grade")
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field(Comment; Rec.Comment)
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

#pragma implicitwith restore

