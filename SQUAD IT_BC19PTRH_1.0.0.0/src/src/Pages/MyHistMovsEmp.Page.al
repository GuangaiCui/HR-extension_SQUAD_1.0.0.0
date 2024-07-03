page 31003173 MyHistMovsEmp
{
    Caption = 'Hist. Movs. Emp';
    PageType = ListPart;
    SourceTable = "Hist. Cab. Movs. Empregado";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cód. Processamento"; "Cód. Processamento")
                {
                    ApplicationArea = All;

                }
                field("Tipo Processamento"; "Tipo Processamento")
                {
                    ApplicationArea = All;

                }
                field("No. Empregado"; "No. Empregado")
                {
                    ApplicationArea = All;

                }
                field("Designação Empregado"; "Designação Empregado")
                {
                    ApplicationArea = All;

                }
                field("Data Registo"; "Data Registo")
                {
                    ApplicationArea = All;

                }
                field(Valor; Valor)
                {
                    ApplicationArea = All;

                }
                field(Pendente; Pendente)
                {
                    ApplicationArea = All;

                }
                field("Valor Vencimento Base"; "Valor Vencimento Base")
                {
                    ApplicationArea = All;

                }
                field("Valor Hora"; "Valor Hora")
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
                    if HistCabMovEmp.Get("Cód. Processamento", "Tipo Processamento", "No. Empregado") then
                        PAGE.Run(PAGE::"Hist. Cab. Movs. Empregado", HistCabMovEmp)
                end;
            }
        }
    }

    var
        HistCabMovEmp: Record "Hist. Cab. Movs. Empregado";
}

