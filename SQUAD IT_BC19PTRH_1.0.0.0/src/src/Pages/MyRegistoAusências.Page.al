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
                    ;

                }
                field("Entry No."; Rec."Entry No.")
                {
                    ;

                }
                field("From Date"; Rec."From Date")
                {
                    ;

                }
                field("To Date"; Rec."To Date")
                {
                    ;

                }
                field("Cause of Absence Code"; Rec."Cause of Absence Code")
                {
                    ;

                }
                field(Description; Rec.Description)
                {
                    ;

                }
                field(Justificada; Rec.Justificada)
                {
                    ;

                }
                field(Quantity; Rec.Quantity)
                {
                    ;

                }
                field("Hora Inicio"; Rec."Hora Inicio")
                {
                    ;

                }
                field("Hora Fim"; Rec."Hora Fim")
                {
                    ;

                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

