page 31003171 MyEmpregado
{
    PageType = ListPart;
    SourceTable = Empregado;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                field(Name; Name)
                {
                    ApplicationArea = All;

                }
                field(Address; Address)
                {
                    ApplicationArea = All;

                }
                field(City; City)
                {
                    ApplicationArea = All;

                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = All;

                }
                field("Mobile Phone No."; "Mobile Phone No.")
                {
                    ApplicationArea = All;

                }
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = All;

                }
                field("Birth Date"; "Birth Date")
                {
                    ApplicationArea = All;

                }
                field(Sex; Sex)
                {
                    ApplicationArea = All;

                }
                field("Employment Date"; "Employment Date")
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
                    if Empregado.Get("No.") then
                        PAGE.Run(PAGE::"Ficha Empregado", Empregado)
                end;
            }
        }
    }

    var
        Empregado: Record Empregado;
}

