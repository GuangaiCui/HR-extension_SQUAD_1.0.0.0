#pragma implicitwith disable
page 53046 "Ausências Empregado"
{
    Caption = 'Employee Absences';
    DataCaptionFields = "Employee No.";
    DelayedInsert = true;
    Editable = false;
    PageType = List;
    PopulateAllFields = true;
    SourceTable = "Ausência Empregado";
    SourceTableView = SORTING("Employee No.", "From Date");
    ApplicationArea = HumanResourcesAppArea;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("From Date"; Rec."From Date")
                {


                }
                field("To Date"; Rec."To Date")
                {


                }
                field("Cause of Absence Code"; Rec."Cause of Absence Code")
                {


                }
                field(Description; Rec.Description)
                {


                }
                field(Quantity; Rec.Quantity)
                {


                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {


                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
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
            group("A&bsence")
            {
                Caption = 'A&bsence';
                Image = Absence;
                action("Comentários")
                {


                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Employee Absence"),
                                  "Table Line No." = FIELD("Entry No.");
                }
            }
        }
    }
}

#pragma implicitwith restore

