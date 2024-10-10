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


                }
                field(Description; Rec.Description)
                {


                }
                field("Total Absence (Base)"; Rec."Total Absence (Base)")
                {


                }
                field("Not Working Hours Reason Code"; Rec."Not Working Hours Reason Code")
                {


                }
                field("Not Working Hours Reason Desc."; Rec."Not Working Hours Reason Desc.")
                {


                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {


                }
                field("Rubric Code"; Rec."Payroll Item Code")
                {


                }
                field(Justified; Rec.Justified)
                {


                }
                field("Remuneration Loss"; Rec."Remuneration Loss")
                {


                }
                field("Food Subsidy Loss"; Rec."Food Subsidy Loss")
                {


                }
                field("Vacation Days Influence"; Rec."Vacation Days Influence")
                {


                }
                field(License; Rec.License)
                {


                }
                field("Holiday Subsidy Influence"; Rec."Holiday Subsidy Influence")
                {


                }
                field("Christmas Subsidy Influence"; Rec."Christmas Subsidy Influence")
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


                Visible = false;
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

