#pragma implicitwith disable
page 53097 "Lista Hist. Abon. - Des. Extr."
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Histórico Abonos - Desc. Extra";

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("No. Mov."; Rec."No. Mov.")
                {
                    ApplicationArea = All;

                }
                field("No. Empregado"; Rec."No. Empregado")
                {
                    ApplicationArea = All;

                }
                field(Data; Rec.Data)
                {
                    ApplicationArea = All;

                }
                field("Cód. Rubrica"; Rec."Cód. Rubrica")
                {
                    ApplicationArea = All;

                }
                field("Tipo Rubrica"; Rec."Tipo Rubrica")
                {
                    ApplicationArea = All;

                }
                field(UnidadeMedida; Rec.UnidadeMedida)
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
                field("Valor Total"; Rec."Valor Total")
                {
                    ApplicationArea = All;

                }
                field("Anular Falta"; Rec."Anular Falta")
                {
                    ApplicationArea = All;

                }
                field("Data a que se refere o Mov."; Rec."Data a que se refere o Mov.")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
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

