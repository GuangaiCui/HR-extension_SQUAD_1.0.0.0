page 31003073 "Lista Inactividade Empregado"
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
                field("Cód. Inactividade"; "Cód. Inactividade")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Descrição)
                {
                    ApplicationArea = All;

                }
                field("Data Inicio Inactividade"; "Data Inicio Inactividade")
                {
                    ApplicationArea = All;

                }
                field("Data Fim Inactividade"; "Data Fim Inactividade")
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

