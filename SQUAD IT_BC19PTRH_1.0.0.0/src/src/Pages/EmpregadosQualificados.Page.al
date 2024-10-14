#pragma implicitwith disable
page 53042 "Empregados Qualificados"
{
    Caption = 'Qualified Employees';
    DataCaptionFields = "Qualification Code";
    Editable = false;
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
                field(Type; Rec.Type)
                {


                }
                field(Description; Rec.Description)
                {


                }
                field("Institution/Company"; Rec."Institution/Company")
                {


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
            group("Q&ualification")
            {
                Caption = 'Q&ualification';
                Image = Certificate;
                action("Comentários")
                {


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

#pragma implicitwith restore

