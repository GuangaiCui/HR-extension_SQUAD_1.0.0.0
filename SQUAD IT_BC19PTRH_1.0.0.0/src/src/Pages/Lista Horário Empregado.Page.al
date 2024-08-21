#pragma implicitwith disable
page 53082 "Lista Horário Empregado"
{
    AutoSplitKey = true;
    DataCaptionFields = "No. Empregado";
    PageType = List;
    SourceTable = "Horário Empregado";
    SourceTableView = SORTING("No. Empregado", "Data Iníco Horário", "Dia da Semana");

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Cód. Horário"; Rec."Cód. Horário")
                {
                    ;

                }
                field("Descrição"; Rec."Descrição")
                {
                    ;

                }
                field("Mês"; Rec."Mês")
                {
                    ;

                }
                field("Dia da Semana"; Rec."Dia da Semana")
                {
                    ;

                }
                field("Data Iníco Horário"; Rec."Data Iníco Horário")
                {
                    ;

                }
                field("Data Fim Horário"; Rec."Data Fim Horário")
                {
                    ;

                }
                field("Organização Tempo Trabalho"; Rec."Organização Tempo Trabalho")
                {
                    ;

                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

