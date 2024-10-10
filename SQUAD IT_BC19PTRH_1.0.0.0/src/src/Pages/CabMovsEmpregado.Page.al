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
                field("Employee No."; Rec."Employee No.")
                {


                    Lookup = true;
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
            }
            part(Abonos; "Linhas Movs. Empregado")
            {


                Caption = 'Abonos';
                SubPageLink = "Cód. Processamento" = FIELD("Cód. Processamento"),
                              "Tipo Processamento" = FIELD("Tipo Processamento"),
                              "Employee No." = FIELD("Employee No.");
                SubPageView = WHERE("Payroll Item Type" = CONST(Abono));
            }
            part(Descontos; "Linhas Movs. Empregado")
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

