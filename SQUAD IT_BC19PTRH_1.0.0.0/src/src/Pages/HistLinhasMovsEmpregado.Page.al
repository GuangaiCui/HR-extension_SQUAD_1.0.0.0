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
                field("Cód. Rubrica"; Rec."Cód. Rubrica")
                {
                    ;

                }
                field("Descrição Rubrica"; Rec."Descrição Rubrica")
                {
                    ;

                }
                field("No. Conta a Debitar"; Rec."No. Conta a Debitar")
                {
                    ;

                }
                field("No. Conta a Creditar"; Rec."No. Conta a Creditar")
                {
                    ;

                }
                field(UnidadeMedida; Rec.UnidadeMedida)
                {
                    ;

                }
                field(Quantidade; Rec.Quantidade)
                {
                    ;

                }
                field("Valor Unitário"; Rec."Valor Unitário")
                {
                    ;

                }
                field(ValorSemSinal; ValorSemSinal)
                {
                    ;

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

