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
                field("Cód. Horário"; "Cód. Horário")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Descrição)
                {
                    ApplicationArea = All;

                }
                field("Mês"; Mês)
                {
                    ApplicationArea = All;

                }
                field("Dia da Semana"; "Dia da Semana")
                {
                    ApplicationArea = All;

                }
                field("Data Iníco Horário"; "Data Iníco Horário")
                {
                    ApplicationArea = All;

                }
                field("Data Fim Horário"; "Data Fim Horário")
                {
                    ApplicationArea = All;

                }
                field("Organização Tempo Trabalho"; "Organização Tempo Trabalho")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }
}

