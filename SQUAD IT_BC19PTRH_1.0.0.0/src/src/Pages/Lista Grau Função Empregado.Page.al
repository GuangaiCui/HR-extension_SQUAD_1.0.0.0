#pragma implicitwith disable
page 53079 "Lista Grau Função Empregado"
{
    AutoSplitKey = true;
    DataCaptionFields = "No. Empregado";
    PageType = List;
    SourceTable = "Grau Função Empregado";

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
                field("Cód. Grau Função"; Rec."Cód. Grau Função")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Rec."Descrição")
                {
                    ApplicationArea = All;

                }
                field("Data Inicio Grau Função"; Rec."Data Inicio Grau Função")
                {
                    ApplicationArea = All;

                }
                field("Data Fim Grau Função"; Rec."Data Fim Grau Função")
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
            group("Grau Funç. Emp.")
            {

                action("Comentários")
                {
                    ApplicationArea = All;

                    Caption = 'Comentários';
                    Image = ViewComments;
                    RunObject = Page "Folha Comentários RH";
                    RunPageLink = "Table Name" = CONST(Grau),
                                  "No." = FIELD("No. Empregado"),
                                  "Table Line No." = FIELD("No. Linha");
                }
            }
        }
    }
}

#pragma implicitwith restore

