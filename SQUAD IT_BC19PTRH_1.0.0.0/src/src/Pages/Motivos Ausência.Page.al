#pragma implicitwith disable
page 53045 "Motivos Ausência"
{
    Caption = 'Causes of Absence';
    PageType = List;
    SourceTable = "Absence Reason";
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
                field("Total Absence (Base)"; Rec."Total Absence (Base)")
                {
                    ApplicationArea = All;

                }
                field("Not Working Hours Reason Code"; Rec."Not Working Hours Reason Code")
                {
                    ApplicationArea = All;

                }
                field("Not Working Hours Reason Desc."; Rec."Not Working Hours Reason Desc.")
                {
                    ApplicationArea = All;

                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;

                }
                field("Rubric Code"; Rec."Rubric Code")
                {
                    ApplicationArea = All;

                }
                field(Justified; Rec.Justified)
                {
                    ApplicationArea = All;

                }
                field("Remuneration Loss"; Rec."Remuneration Loss")
                {
                    ApplicationArea = All;

                }
                field("Food Subsidy Loss"; Rec."Food Subsidy Loss")
                {
                    ApplicationArea = All;

                }
                field("Vacation Days Influence"; Rec."Vacation Days Influence")
                {
                    ApplicationArea = All;

                }
                field(License; Rec.License)
                {
                    ApplicationArea = All;

                }
                field("Holiday Subsidy Influence"; Rec."Holiday Subsidy Influence")
                {
                    ApplicationArea = All;

                }
                field("Christmas Subsidy Influence"; Rec."Christmas Subsidy Influence")
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
    }
}

#pragma implicitwith restore

