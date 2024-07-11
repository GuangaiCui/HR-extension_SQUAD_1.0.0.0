#pragma implicitwith disable
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
                field("No. Linha"; Rec."No. Linha")
                {
                    ApplicationArea = All;

                }
                field("Data Registo"; Rec."Data Registo")
                {
                    ApplicationArea = All;

                }
                field("Designação Empregado"; Rec."Designação Empregado")
                {
                    ApplicationArea = All;

                }
                field("Cód. Rubrica"; Rec."Cód. Rubrica")
                {
                    ApplicationArea = All;

                }
                field("Descrição Rubrica"; Rec."Descrição Rubrica")
                {
                    ApplicationArea = All;

                }
                field("Tipo Rubrica"; Rec."Tipo Rubrica")
                {
                    ApplicationArea = All;

                }
                field("No. Conta a Debitar"; Rec."No. Conta a Debitar")
                {
                    ApplicationArea = All;

                }
                field("No. Conta a Creditar"; Rec."No. Conta a Creditar")
                {
                    ApplicationArea = All;

                }
                field(Quantidade; Rec.Quantidade)
                {
                    ApplicationArea = All;

                }
                field("Valor Unitário"; Rec."Valor Unitário")
                {
                    ApplicationArea = All;

                }
                field(Valor; Rec.Valor)
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

#pragma implicitwith restore

