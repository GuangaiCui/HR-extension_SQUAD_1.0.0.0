#pragma implicitwith disable
page 53108 "Lista Hist. Cab. Movs. Emp"
{
    AutoSplitKey = true;
    CardPageID = "Hist. Cab. Movs. Empregado";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Hist. Cab. Movs. Empregado";

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
                field("Designação Empregado"; Rec."Designação Empregado")
                {


                }
                field("Data Registo"; Rec."Data Registo")
                {


                }
                field(Valor; Rec.Valor)
                {


                }
                field(Pendente; Rec.Pendente)
                {


                }
                field("Pago por No. Documento"; Rec."Pago por No. Documento")
                {


                }
                field("Recibo enviado via E-Mail"; Rec."Recibo enviado via E-Mail")
                {


                }
                field("Vacation Days Received"; Rec."Vacation Days Received")
                {


                    Visible = false;
                }
                field("Vacation Days Spent"; Rec."Vacation Days Spent")
                {


                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Movs. Empregado")
            {
                Caption = 'Movs. Empregado';
                action("Fi&cha Movs. Empregado")
                {


                    Caption = '&Card';
                    Image = EditLines;
                    Promoted = true;
                    RunObject = Page "Hist. Cab. Movs. Empregado";
                    RunPageLink = "Cód. Processamento" = FIELD("Cód. Processamento"),
                                  "Tipo Processamento" = FIELD("Tipo Processamento"),
                                  "Employee No." = FIELD("Employee No.");
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }
}

#pragma implicitwith restore

