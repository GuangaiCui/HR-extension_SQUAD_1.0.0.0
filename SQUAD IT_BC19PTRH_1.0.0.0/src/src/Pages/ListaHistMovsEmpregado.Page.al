#pragma implicitwith disable
page 53110 "Lista Hist. Movs. Empregado"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Hist. Linhas Movs. Empregado";
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Cód. Processamento"; Rec."Cód. Processamento")
                {
                    ;

                }
                field("Tipo Processamento"; Rec."Tipo Processamento")
                {
                    ;

                }
                field("No. Empregado"; Rec."No. Empregado")
                {
                    ;

                }
                field("No. Linha"; Rec."No. Linha")
                {
                    ;

                }
                field("Data Registo"; Rec."Data Registo")
                {
                    ;

                }
                field("Designação Empregado"; Rec."Designação Empregado")
                {
                    ;

                }
                field("Cód. Rubrica"; Rec."Cód. Rubrica")
                {
                    ;

                }
                field("Descrição Rubrica"; Rec."Descrição Rubrica")
                {
                    ;

                }
                field("Tipo Rubrica"; Rec."Tipo Rubrica")
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
                field(Quantidade; Rec.Quantidade)
                {
                    ;

                }
                field("Valor Unitário"; Rec."Valor Unitário")
                {
                    ;

                }
                field(Valor; Rec.Valor)
                {
                    ;

                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

