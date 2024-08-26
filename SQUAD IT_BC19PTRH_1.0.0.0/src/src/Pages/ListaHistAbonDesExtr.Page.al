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


                }
                field("No. Empregado"; Rec."No. Empregado")
                {


                }
                field(Data; Rec.Data)
                {


                }
                field("Cód. Rubrica"; Rec."Cód. Rubrica")
                {


                }
                field("Tipo Rubrica"; Rec."Tipo Rubrica")
                {


                }
                field(UnidadeMedida; Rec.UnidadeMedida)
                {


                }
                field(Quantidade; Rec.Quantidade)
                {


                }
                field("Valor Unitário"; Rec."Valor Unitário")
                {


                }
                field("Valor Total"; Rec."Valor Total")
                {


                }
                field("Anular Falta"; Rec."Anular Falta")
                {


                }
                field("Data a que se refere o Mov."; Rec."Data a que se refere o Mov.")
                {


                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {


                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
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

