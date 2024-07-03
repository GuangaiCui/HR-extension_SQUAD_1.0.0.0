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
                field("Cód. Rubrica"; "Cód. Rubrica")
                {
                    ApplicationArea = All;
                }
                field("Descrição Rubrica"; "Descrição Rubrica")
                {
                    ApplicationArea = All;
                }
                field("No. Conta a Debitar"; "No. Conta a Debitar")
                {
                    ApplicationArea = All;
                }
                field("No. Conta a Creditar"; "No. Conta a Creditar")
                {
                    ApplicationArea = All;
                }
                field(UnidadeMedida; UnidadeMedida)
                {
                    ApplicationArea = All;
                }
                field(Quantidade; Quantidade)
                {
                    ApplicationArea = All;
                }
                field("Valor Unitário"; "Valor Unitário")
                {
                    ApplicationArea = All;
                }
                field(ValorSemSinal; ValorSemSinal)
                {
                    ApplicationArea = All;
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

        if "Tipo Rubrica" = "Tipo Rubrica"::Desconto then
            ValorSemSinal := Abs(Valor)
        else
            ValorSemSinal := Valor;
    end;

    var
        ValorSemSinal: Decimal;
}

