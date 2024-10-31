#pragma implicitwith disable
page 53130 "Qualificações Empregado RU"
{
    AutoSplitKey = true;
    //Caption = 'Employee Qualifications RU ';
    DataCaptionFields = "Employee No.";
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Qualificação Empregado";
    ApplicationArea = HumanResourcesAppArea;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Employee No."; Rec."Employee No.")
                {


                }
                field("From Date"; Rec."From Date")
                {


                }
                field("To Date"; Rec."To Date")
                {


                }
                field("Internal Qualification"; Rec."Internal Qualification")
                {


                }
                field(Description; Rec.Description)
                {


                }
                field("Expiration Date"; Rec."Expiration Date")
                {


                    Visible = false;
                }
                field(Cost; Rec.Cost)
                {


                    Visible = false;
                }
                field("Course Grade"; Rec."Course Grade")
                {


                    Visible = false;
                }
                field(Comment; Rec.Comment)
                {


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

