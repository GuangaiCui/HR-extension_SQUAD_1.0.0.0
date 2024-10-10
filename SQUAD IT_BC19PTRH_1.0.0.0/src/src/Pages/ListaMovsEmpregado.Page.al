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
                field("Payroll Item Code"; Rec."Payroll Item Code")
                {


                }
                field("Payroll Item Description"; Rec."Payroll Item Description")
                {


                }
                field("Payroll Item Type"; Rec."Payroll Item Type")
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

