#pragma implicitwith disable
page 53173 MyHistMovsEmp
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
                field("Cód. Processamento"; Rec."Cód. Processamento")
                {


                }
                field("Tipo Processamento"; Rec."Tipo Processamento")
                {


                }
                field("Employee No."; Rec."Employee No.")
                {


                }
                field("Designação Empregado"; Rec."Designação Empregado")
                {


                }
                field("Data Registo"; Rec."Data Registo")
                {


                }
                field(Valor; Rec.Valor)
                {


                }
                field(Pendente; Rec.Pendente)
                {


                }
                field("Valor Vencimento Base"; Rec."Valor Vencimento Base")
                {


                }
                field("Valor Hora"; Rec."Valor Hora")
                {


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



                trigger OnAction()
                begin
                    if HistCabMovEmp.Get(Rec."Cód. Processamento", Rec."Tipo Processamento", Rec."Employee No.") then
                        PAGE.Run(PAGE::"Hist. Cab. Movs. Empregado", HistCabMovEmp)
                end;
            }
        }
    }

    var
        HistCabMovEmp: Record "Hist. Cab. Movs. Empregado";
}

#pragma implicitwith restore

