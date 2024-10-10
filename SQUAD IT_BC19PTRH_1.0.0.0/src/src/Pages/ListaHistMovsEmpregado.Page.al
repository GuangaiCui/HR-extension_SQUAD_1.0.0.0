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


                }
                field("Tipo Processamento"; Rec."Tipo Processamento")
                {


                }
                field("Employee No."; Rec."Employee No.")
                {


                }
                field("No. Linha"; Rec."No. Linha")
                {


                }
                field("Data Registo"; Rec."Data Registo")
                {


                }
                field("Designação Empregado"; Rec."Designação Empregado")
                {


                }
                field("Cód. Rubrica"; Rec."Cód. Rubrica")
                {


                }
                field("Descrição Rubrica"; Rec."Descrição Rubrica")
                {


                }
                field("Tipo Rubrica"; Rec."Tipo Rubrica")
                {


                }
                field("Debit Acc. No."; Rec."Debit Acc. No.")
                {


                }
                field("Credit Acc. No."; Rec."Credit Acc. No.")
                {


                }
                field(Quantity; Rec.Quantity)
                {


                }
                field("Unit Value"; Rec."Unit Value")
                {


                }
                field(Valor; Rec.Valor)
                {


                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

