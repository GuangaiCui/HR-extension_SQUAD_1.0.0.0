#pragma implicitwith disable
page 53040 "Qualificações"
{
    Caption = 'Qualifications';
    PageType = List;
    SourceTable = "Qualificação";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
                field("Qualified Employees"; Rec."Qualified Employees")
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

                Visible = false;
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
                action("Análise Qualificação")
                {
                    ApplicationArea = All;

                    Caption = 'Q&ualification Overview';
                    Image = QualificationOverview;
                    RunObject = Page "Qualification Overview";
                }
            }
        }
    }

    trigger OnOpenPage()
    begin

        Rec.SetFilter("Initial Filter Date", '<=%1', WorkDate);
        Rec.SetFilter("End Filter Date", '>=%1|%2', WorkDate, 0D);
    end;
}

#pragma implicitwith restore

