#pragma implicitwith disable
page 53171 MyEmpregado
{
    PageType = ListPart;
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;

                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;

                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;

                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;

                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;

                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;

                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ApplicationArea = All;

                }
                field(Sex; Rec.Gender)
                {
                    ApplicationArea = All;

                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Abrir)
            {
                ApplicationArea = All;


                trigger OnAction()
                begin
                    if Empregado.Get(Rec."No.") then
                        PAGE.Run(PAGE::"Employee Card", Empregado)
                end;
            }
        }
    }

    var
        Empregado: Record Employee;
}

#pragma implicitwith restore

