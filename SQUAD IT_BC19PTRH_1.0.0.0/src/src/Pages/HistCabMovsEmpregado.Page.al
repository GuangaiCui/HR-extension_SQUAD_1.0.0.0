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
                field("No. Empregado"; "No. Empregado")
                {
                    ApplicationArea = All;

                }
                field("Designação Empregado"; "Designação Empregado")
                {
                    ApplicationArea = All;

                }
                field(Valor; Valor)
                {
                    ApplicationArea = All;

                }
                field("Cód. Processamento"; "Cód. Processamento")
                {
                    ApplicationArea = All;

                }
                field("Tipo Processamento"; "Tipo Processamento")
                {
                    ApplicationArea = All;

                }
                field("Data Registo"; "Data Registo")
                {
                    ApplicationArea = All;

                }
                field(Pendente; Pendente)
                {
                    ApplicationArea = All;

                    Editable = false;
                }
                field("Pago por No. Documento"; "Pago por No. Documento")
                {
                    ApplicationArea = All;

                    Editable = false;
                }
            }
            part(Abono; "Hist. Linhas Movs. Empregado")
            {
                ApplicationArea = All;

                Caption = 'Abonos';
                SubPageLink = "Cód. Processamento" = FIELD("Cód. Processamento"),
                              "Tipo Processamento" = FIELD("Tipo Processamento"),
                              "No. Empregado" = FIELD("No. Empregado");
                SubPageView = WHERE("Tipo Rubrica" = CONST(Abono));
            }
            part(Desconto; "Hist. Linhas Movs. Empregado")
            {
                ApplicationArea = All;

                Caption = 'Descontos';
                SubPageLink = "Cód. Processamento" = FIELD("Cód. Processamento"),
                              "Tipo Processamento" = FIELD("Tipo Processamento"),
                              "No. Empregado" = FIELD("No. Empregado");
                SubPageView = WHERE("Tipo Rubrica" = CONST(Desconto));
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

