#pragma implicitwith disable
page 53075 "Lista Cat. Prof. Int. Emp."
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
                field("No. Empregado"; Rec."No. Empregado")
                {
                    ApplicationArea = All;

                }
                field("Cód. Cat. Prof."; Rec."Cód. Cat. Prof.")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Rec."Descrição")
                {
                    ApplicationArea = All;

                }
                field("Data Inicio Cat. Prof."; Rec."Data Inicio Cat. Prof.")
                {
                    ApplicationArea = All;

                }
                field("Data Fim Cat. Prof."; Rec."Data Fim Cat. Prof.")
                {
                    ApplicationArea = All;

                }
                field("Comentário"; Rec."Comentário")
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

#pragma implicitwith restore

