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
                    ApplicationArea = All;

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

