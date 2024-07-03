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

                    OptionCaption = '';
                }
                field("Qualification Code"; "Qualification Code")
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
                {
                    ApplicationArea = All;

                }
                field("Academic Degree"; "Academic Degree")
                {
                    ApplicationArea = All;

                }
                field("University Code"; "University Code")
                {
                    ApplicationArea = All;

                }
                field("Institution/Company"; "Institution/Company")
                {
                    ApplicationArea = All;

                }
                field("Course Code"; "Course Code")
                {
                    ApplicationArea = All;

                }
                field("Course Description"; "Course Description")
                {
                    ApplicationArea = All;

                }
                field("Final Course Classification"; "Final Course Classification")
                {
                    ApplicationArea = All;

                }
                field(Cost; Cost)
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field("Expiration Date"; "Expiration Date")
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
        TabQualEmp.SetRange(TabQualEmp."Employee No.", "Employee No.");
        if TabQualEmp.Find('+') then
            "Line No." := TabQualEmp."Line No." + 10000
        else
            "Line No." := 10000;
    end;

    var
        TabQualEmp: Record "Qualificação Empregado";
}

