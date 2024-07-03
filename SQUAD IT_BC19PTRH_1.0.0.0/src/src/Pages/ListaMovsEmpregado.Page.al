page 53109 "Lista Movs. Empregado"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Linhas Movs. Empregado";

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
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
                field("No. Linha"; "No. Linha")
                {
                    ApplicationArea = All;

                }
                field("Data Registo"; "Data Registo")
                {
                    ApplicationArea = All;

                }
                field("Designação Empregado"; "Designação Empregado")
                {
                    ApplicationArea = All;

                }
                field("Cód. Rubrica"; "Cód. Rubrica")
                {
                    ApplicationArea = All;

                }
                field("Descrição Rubrica"; "Descrição Rubrica")
                {
                    ApplicationArea = All;

                }
                field("Tipo Rubrica"; "Tipo Rubrica")
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
                field(Quantidade; Quantidade)
                {
                    ApplicationArea = All;

                }
                field("Valor Unitário"; "Valor Unitário")
                {
                    ApplicationArea = All;

                }
                field(Valor; Valor)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }
}

