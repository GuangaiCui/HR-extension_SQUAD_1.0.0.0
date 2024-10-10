#pragma implicitwith disable
page 53107 "Hist. Linhas Movs. Empregado"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Hist. Linhas Movs. Empregado";

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Payroll Item Code"; Rec."Payroll Item Code")
                {


                }
                field("Payroll Item Description"; Rec."Payroll Item Description")
                {


                }
                field("Debit Acc. No."; Rec."Debit Acc. No.")
                {


                }
                field("Credit Acc. No."; Rec."Credit Acc. No.")
                {


                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {


                }
                field(Quantity; Rec.Quantity)
                {


                }
                field("Unit Value"; Rec."Unit Value")
                {


                }
                field(ValorSemSinal; ValorSemSinal)
                {


                    Caption = 'Valor';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        //HG - neste form em vez de mostrarmos o campo Valor tal como ele está na db,
        // usamos uma variável que vai buscar o Abs(valor) para que os descontos não
        //apareçam a negativo, o que faz confusão ao utilizador.

        if Rec."Payroll Item Type" = Rec."Payroll Item Type"::Desconto then
            ValorSemSinal := Abs(Rec.Valor)
        else
            ValorSemSinal := Rec.Valor;
    end;

    var
        ValorSemSinal: Decimal;
}

#pragma implicitwith restore

