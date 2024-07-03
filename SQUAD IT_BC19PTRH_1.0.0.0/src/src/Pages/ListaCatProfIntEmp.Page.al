page 31003075 "Lista Cat. Prof. Int. Emp."
{
    AutoSplitKey = true;
    DataCaptionFields = "No. Empregado";
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Cat. Prof. Int. Empregado";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("No. Empregado"; "No. Empregado")
                {
                    ApplicationArea = All;

                }
                field("Cód. Cat. Prof."; "Cód. Cat. Prof.")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Descrição)
                {
                    ApplicationArea = All;

                }
                field("Data Inicio Cat. Prof."; "Data Inicio Cat. Prof.")
                {
                    ApplicationArea = All;

                }
                field("Data Fim Cat. Prof."; "Data Fim Cat. Prof.")
                {
                    ApplicationArea = All;

                }
                field("Comentário"; Comentário)
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
            group("Cat. Prof. Emp. Int.")
            {
                action("Comentários")
                {
                    ApplicationArea = All;

                    Caption = 'Comentários';
                    Image = ViewComments;
                    RunObject = Page "Folha Comentários RH";
                    RunPageLink = "Table Name" = CONST(CatProf),
                                  "No." = FIELD("No. Empregado"),
                                  "Table Line No." = FIELD("No. Linha");
                }
            }
        }
    }
}

