#pragma implicitwith disable
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
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;

                }
                field("Entry No."; Rec."Entry No.")
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
                field("Cause of Absence Code"; Rec."Cause of Absence Code")
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
                field(Justificada; Rec.Justificada)
                {
                    ApplicationArea = All;

                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;

                }
                field("Hora Inicio"; Rec."Hora Inicio")
                {
                    ApplicationArea = All;

                }
                field("Hora Fim"; Rec."Hora Fim")
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

#pragma implicitwith restore

