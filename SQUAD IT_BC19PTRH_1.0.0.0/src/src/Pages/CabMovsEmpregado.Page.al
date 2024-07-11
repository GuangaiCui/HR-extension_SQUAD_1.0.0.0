#pragma implicitwith disable
page 53102 "Cab. Movs. Empregado"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Cab. Movs. Empregado";

    layout
    {
        area(content)
        {
            group(Geral)
            {
                Caption = 'Geral';
                field("No. Empregado"; Rec."No. Empregado")
                {
                    ApplicationArea = All;

                    Lookup = true;
                }
                field("Designação Empregado"; Rec."Designação Empregado")
                {
                    ApplicationArea = All;

                }
                field(Valor; Rec.Valor)
                {
                    ApplicationArea = All;

                }
                field("Cód. Processamento"; Rec."Cód. Processamento")
                {
                    ApplicationArea = All;

                }
                field("Tipo Processamento"; Rec."Tipo Processamento")
                {
                    ApplicationArea = All;

                }
                field("Data Registo"; Rec."Data Registo")
                {
                    ApplicationArea = All;

                }
            }
            part(Abonos; "Linhas Movs. Empregado")
            {
                ApplicationArea = All;

                Caption = 'Abonos';
                SubPageLink = "Cód. Processamento" = FIELD("Cód. Processamento"),
                              "Tipo Processamento" = FIELD("Tipo Processamento"),
                              "No. Empregado" = FIELD("No. Empregado");
                SubPageView = WHERE("Tipo Rubrica" = CONST(Abono));
            }
            part(Descontos; "Linhas Movs. Empregado")
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

#pragma implicitwith restore

