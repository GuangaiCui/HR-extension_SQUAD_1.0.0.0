#pragma implicitwith disable
page 53149 "Lista Acções Médicas"
{
    Editable = false;
    PageType = List;
    SourceTable = "Cab. Acções Médicas";

    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Exam Type"; Rec."Exam Type")
                {
                }
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Reason; Rec.Reason)
                {
                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

