page 31003108 "Lista Hist. Cab. Movs. Emp"
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
                field("Designação Empregado"; "Designação Empregado")
                {
                    ApplicationArea = All;

                }
                field("Data Registo"; "Data Registo")
                {
                    ApplicationArea = All;

                }
                field(Valor; Valor)
                {
                    ApplicationArea = All;

                }
                field(Pendente; Pendente)
                {
                    ApplicationArea = All;

                }
                field("Pago por No. Documento"; "Pago por No. Documento")
                {
                    ApplicationArea = All;

                }
                field("Recibo enviado via E-Mail"; "Recibo enviado via E-Mail")
                {
                    ApplicationArea = All;

                }
                field("Vacation Days Received"; "Vacation Days Received")
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field("Vacation Days Spent"; "Vacation Days Spent")
                {
                    ApplicationArea = All;

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
                    ApplicationArea = All;

                    Caption = '&Card';
                    Image = EditLines;
                    Promoted = true;
                    RunObject = Page "Hist. Cab. Movs. Empregado";
                    RunPageLink = "Cód. Processamento" = FIELD("Cód. Processamento"),
                                  "Tipo Processamento" = FIELD("Tipo Processamento"),
                                  "No. Empregado" = FIELD("No. Empregado");
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }
}

