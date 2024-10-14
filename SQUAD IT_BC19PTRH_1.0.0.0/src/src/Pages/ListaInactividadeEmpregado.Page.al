#pragma implicitwith disable
page 53073 "Lista Inactividade Empregado"
{
    AutoSplitKey = true;
    Caption = 'Inactividade Empregado ';
    DataCaptionFields = "Employee No.";
    PageType = List;
    SourceTable = "Inactividade Empregado";
    ApplicationArea = HumanResourcesAppArea;
    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Cód. Inactividade"; Rec."Cód. Inactividade")
                {


                }
                field("Descrição"; Rec."Descrição")
                {


                }
                field("Data Inicio Inactividade"; Rec."Data Inicio Inactividade")
                {


                }
                field("Data Fim Inactividade"; Rec."Data Fim Inactividade")
                {


                }
                field("Comentário"; Rec."Comentário")
                {


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


                    Caption = 'Comentários';
                    Image = ViewComments;
                    RunObject = Page "Folha Comentários RH";
                    RunPageLink = "Table Name" = CONST(Inac),
                                  "No." = FIELD("Employee No."),
                                  "Table Line No." = FIELD("No. Linha");
                }
            }
        }
    }
}

#pragma implicitwith restore

