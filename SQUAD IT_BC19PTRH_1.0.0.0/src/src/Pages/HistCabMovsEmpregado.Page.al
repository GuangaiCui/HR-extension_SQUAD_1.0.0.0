#pragma implicitwith disable
page 53106 "Hist. Cab. Movs. Empregado"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Hist. Cab. Movs. Empregado";
    UsageCategory = Tasks;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            group(Geral)
            {
                Caption = 'Geral';
                field("Employee No."; Rec."Employee No.")
                {


                }
                field("Designação Empregado"; Rec."Designação Empregado")
                {


                }
                field(Valor; Rec.Valor)
                {


                }
                field("Cód. Processamento"; Rec."Cód. Processamento")
                {


                }
                field("Tipo Processamento"; Rec."Tipo Processamento")
                {


                }
                field("Data Registo"; Rec."Data Registo")
                {


                }
                field(Pendente; Rec.Pendente)
                {


                    Editable = false;
                }
                field("Pago por No. Documento"; Rec."Pago por No. Documento")
                {


                    Editable = false;
                }
            }
            part(Abono; "Hist. Linhas Movs. Empregado")
            {


                Caption = 'Abonos';
                SubPageLink = "Cód. Processamento" = FIELD("Cód. Processamento"),
                              "Tipo Processamento" = FIELD("Tipo Processamento"),
                              "Employee No." = FIELD("Employee No.");
                SubPageView = WHERE("Payroll Item Type" = CONST(Abono));
            }
            part(Desconto; "Hist. Linhas Movs. Empregado")
            {


                Caption = 'Descontos';
                SubPageLink = "Cód. Processamento" = FIELD("Cód. Processamento"),
                              "Tipo Processamento" = FIELD("Tipo Processamento"),
                              "Employee No." = FIELD("Employee No.");
                SubPageView = WHERE("Payroll Item Type" = CONST(Desconto));
            }
        }
    }

    actions
    {
    }

    var
        Text19008238: Label 'ABONOS:';
        Text19053246: Label 'DESCONTOS:';
}

#pragma implicitwith restore

