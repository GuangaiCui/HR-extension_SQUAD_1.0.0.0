#pragma implicitwith disable
page 53041 "Qualificações Empregado"
{
    AutoSplitKey = true;
    Caption = 'Employee Qualifications';
    DataCaptionFields = "Employee No.";
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Qualificação Empregado";
    SourceTableView = WHERE(Type = FILTER(<> "Qualificações RU"));

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
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;

                    OptionCaption = '';
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
                field("Academic Degree"; Rec."Academic Degree")
                {
                    ApplicationArea = All;

                }
                field("University Code"; Rec."University Code")
                {
                    ApplicationArea = All;

                }
                field("Institution/Company"; Rec."Institution/Company")
                {
                    ApplicationArea = All;

                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;

                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;

                }
                field("Final Course Classification"; Rec."Final Course Classification")
                {
                    ApplicationArea = All;

                }
                field(Cost; Rec.Cost)
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field("Expiration Date"; Rec."Expiration Date")
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
            group("Qualificações")
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

