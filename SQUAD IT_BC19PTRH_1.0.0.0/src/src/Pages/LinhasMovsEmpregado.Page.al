#pragma implicitwith disable
page 53103 "Linhas Movs. Empregado"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Linhas Movs. Empregado";

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Cód. Rubrica"; Rec."Cód. Rubrica")
                {

                }
                field("Descrição Rubrica"; Rec."Descrição Rubrica")
                {

                }
                field("Debit Acc. No."; Rec."Debit Acc. No.")
                {

                }
                field("Credit Acc. No."; Rec."Credit Acc. No.")
                {

                }
                field(UnidadeMedida; Rec.UnidadeMedida)
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

        if Rec."Tipo Rubrica" = Rec."Tipo Rubrica"::Desconto then
            ValorSemSinal := Abs(Rec.Valor)
        else
            ValorSemSinal := Rec.Valor;
    end;

    var
        ValorSemSinal: Decimal;
}

#pragma implicitwith restore

