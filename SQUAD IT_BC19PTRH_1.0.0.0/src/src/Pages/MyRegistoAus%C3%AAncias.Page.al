page 53172 "MyRegistoAusências"
{
    Caption = 'Registo Ausências';
    PageType = ListPart;
    SourceTable = "Ausência Empregado";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = All;

                }
                field("Entry No."; "Entry No.")
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
                field("Cause of Absence Code"; "Cause of Absence Code")
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
                {
                    ApplicationArea = All;

                }
                field(Justificada; Justificada)
                {
                    ApplicationArea = All;

                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;

                }
                field("Hora Inicio"; "Hora Inicio")
                {
                    ApplicationArea = All;

                }
                field("Hora Fim"; "Hora Fim")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }
}

