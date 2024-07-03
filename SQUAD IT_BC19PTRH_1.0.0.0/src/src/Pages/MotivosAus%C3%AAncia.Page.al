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
                field("Code"; Code)
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
                {
                    ApplicationArea = All;

                }
                field("Total Absence (Base)"; "Total Absence (Base)")
                {
                    ApplicationArea = All;

                }
                field("Not Working Hours Reason Code"; "Not Working Hours Reason Code")
                {
                    ApplicationArea = All;

                }
                field("Not Working Hours Reason Desc."; "Not Working Hours Reason Desc.")
                {
                    ApplicationArea = All;

                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;

                }
                field("Rubric Code"; "Rubric Code")
                {
                    ApplicationArea = All;

                }
                field(Justified; Justified)
                {
                    ApplicationArea = All;

                }
                field("Remuneration Loss"; "Remuneration Loss")
                {
                    ApplicationArea = All;

                }
                field("Food Subsidy Loss"; "Food Subsidy Loss")
                {
                    ApplicationArea = All;

                }
                field("Vacation Days Influence"; "Vacation Days Influence")
                {
                    ApplicationArea = All;

                }
                field(License; License)
                {
                    ApplicationArea = All;

                }
                field("Holiday Subsidy Influence"; "Holiday Subsidy Influence")
                {
                    ApplicationArea = All;

                }
                field("Christmas Subsidy Influence"; "Christmas Subsidy Influence")
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

