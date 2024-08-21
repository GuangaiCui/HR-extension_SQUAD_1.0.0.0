#pragma implicitwith disable
page 53104 "Lista Cab. Movs. Empregado"
{
    AutoSplitKey = true;
    CardPageID = "Cab. Movs. Empregado";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Cab. Movs. Empregado";
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
                field("No. Empregado"; Rec."No. Empregado")
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
                action("Fi&cha")
                {


                    Caption = '&Card';
                    Image = EditLines;
                    Promoted = true;
                    RunObject = Page "Cab. Movs. Empregado";
                    RunPageLink = "Cód. Processamento" = FIELD("Cód. Processamento"),
                                  "Tipo Processamento" = FIELD("Tipo Processamento"),
                                  "No. Empregado" = FIELD("No. Empregado");
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }
}

#pragma implicitwith restore

