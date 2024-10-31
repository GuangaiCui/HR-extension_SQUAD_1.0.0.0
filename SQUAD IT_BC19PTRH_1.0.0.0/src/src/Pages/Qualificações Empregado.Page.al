#pragma implicitwith disable
page 53041 "Qualificações Empregado"
{
    AutoSplitKey = true;
    //Caption = 'Employee Qualifications';
    DataCaptionFields = "Employee No.";
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Qualificação Empregado";
    SourceTableView = WHERE(Type = FILTER(<> "Qualificações RU"));
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
                field("Qualification Code"; Rec."Qualification Code")
                {


                }
                field(Description; Rec.Description)
                {


                }
                field("Academic Degree"; Rec."Academic Degree")
                {


                }
                field("University Code"; Rec."University Code")
                {


                }
                field("Institution/Company"; Rec."Institution/Company")
                {


                }
                field("Course Code"; Rec."Course Code")
                {


                }
                field("Course Description"; Rec."Course Description")
                {


                }
                field("Final Course Classification"; Rec."Final Course Classification")
                {


                }
                field(Cost; Rec.Cost)
                {


                    Visible = false;
                }
                field("Expiration Date"; Rec."Expiration Date")
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
            group("Qualificações")
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

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        //2008.12.23 -
        TabQualEmp.Reset;
        TabQualEmp.SetCurrentKey(TabQualEmp."Employee No.", TabQualEmp."Line No.");
        TabQualEmp.SetRange(TabQualEmp."Employee No.", Rec."Employee No.");
        if TabQualEmp.Find('+') then
            Rec."Line No." := TabQualEmp."Line No." + 10000
        else
            Rec."Line No." := 10000;
    end;

    var
        TabQualEmp: Record "Qualificação Empregado";
}

#pragma implicitwith restore

