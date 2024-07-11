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
                    ApplicationArea = All;

                }
                field("Descrição"; Rec."Descrição")
                {
                    ApplicationArea = All;

                }
                field("Mês"; Rec."Mês")
                {
                    ApplicationArea = All;

                }
                field("Dia da Semana"; Rec."Dia da Semana")
                {
                    ApplicationArea = All;

                }
                field("Data Iníco Horário"; Rec."Data Iníco Horário")
                {
                    ApplicationArea = All;

                }
                field("Data Fim Horário"; Rec."Data Fim Horário")
                {
                    ApplicationArea = All;

                }
                field("Organização Tempo Trabalho"; Rec."Organização Tempo Trabalho")
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

#pragma implicitwith restore

