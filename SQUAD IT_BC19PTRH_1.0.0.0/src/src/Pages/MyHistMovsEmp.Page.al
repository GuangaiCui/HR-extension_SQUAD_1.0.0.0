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
                    ApplicationArea = All;

                }
                field("Tipo Processamento"; Rec."Tipo Processamento")
                {
                    ApplicationArea = All;

                }
                field("No. Empregado"; Rec."No. Empregado")
                {
                    ApplicationArea = All;

                }
                field("Designação Empregado"; Rec."Designação Empregado")
                {
                    ApplicationArea = All;

                }
                field("Data Registo"; Rec."Data Registo")
                {
                    ApplicationArea = All;

                }
                field(Valor; Rec.Valor)
                {
                    ApplicationArea = All;

                }
                field(Pendente; Rec.Pendente)
                {
                    ApplicationArea = All;

                }
                field("Valor Vencimento Base"; Rec."Valor Vencimento Base")
                {
                    ApplicationArea = All;

                }
                field("Valor Hora"; Rec."Valor Hora")
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
                    if HistCabMovEmp.Get(Rec."Cód. Processamento", Rec."Tipo Processamento", Rec."No. Empregado") then
                        PAGE.Run(PAGE::"Hist. Cab. Movs. Empregado", HistCabMovEmp)
                end;
            }
        }
    }

    var
        HistCabMovEmp: Record "Hist. Cab. Movs. Empregado";
}

#pragma implicitwith restore

