#pragma implicitwith disable
page 53073 "Lista Inactividade Empregado"
{
    AutoSplitKey = true;
    Caption = 'Inactividade Empregado ';
    DataCaptionFields = "No. Empregado";
    PageType = List;
    SourceTable = "Inactividade Empregado";

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Cód. Inactividade"; Rec."Cód. Inactividade")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Rec."Descrição")
                {
                    ApplicationArea = All;

                }
                field("Data Inicio Inactividade"; Rec."Data Inicio Inactividade")
                {
                    ApplicationArea = All;

                }
                field("Data Fim Inactividade"; Rec."Data Fim Inactividade")
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
            group(Inactividade)
            {
                action("Comentários")
                {
                    ApplicationArea = All;

                    Caption = 'Comentários';
                    Image = ViewComments;
                    RunObject = Page "Folha Comentários RH";
                    RunPageLink = "Table Name" = CONST(Inac),
                                  "No." = FIELD("No. Empregado"),
                                  "Table Line No." = FIELD("No. Linha");
                }
            }
        }
    }
}

#pragma implicitwith restore

