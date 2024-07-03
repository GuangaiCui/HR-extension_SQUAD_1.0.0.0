page 31003149 "Lista Acções Médicas"
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
                field("Entry No."; "Entry No.")
                {
                }
                field("Exam Type"; "Exam Type")
                {
                }
                field("Code"; Code)
                {
                }
                field(Description; Description)
                {
                }
                field(Reason; Reason)
                {
                }
            }
        }
    }

    actions
    {
    }
}

