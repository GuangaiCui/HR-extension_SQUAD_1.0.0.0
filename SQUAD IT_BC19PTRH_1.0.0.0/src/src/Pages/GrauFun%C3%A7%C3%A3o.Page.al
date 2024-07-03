page 53078 "Grau Função"
{
    PageType = List;
    SourceTable = "Grau Função";
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Código"; Código)
                {
                    ApplicationArea = All;

                }
                field("Level 1"; "Level 1")
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field("Level 2"; "Level 2")
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field("Level 3"; "Level 3")
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;

                }
                field("Min Value"; "Min Value")
                {
                    ApplicationArea = All;

                }
                field("Max Value"; "Max Value")
                {
                    ApplicationArea = All;

                }
                field("Valor Hora Semanal"; "Valor Hora Semanal")
                {
                    ApplicationArea = All;

                }
                field("Cod. Índice"; "Cod. Índice")
                {
                    ApplicationArea = All;

                }
                field("Employees No."; "Employees No.")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //HG 11.07.05
        //Isto serve para filtrar os graus de função para que só apareçam os que estão em vigor
        //ou seja, os que têm a data de inicio anterior à Workdate
        // e que têm a data de fim  posterior à workdate
        SetFilter("Data Filtro Inicio", '<=%1', WorkDate);
        SetFilter("Data Filtro Fim", '>=%1|%2', WorkDate, 0D);
        //HG - Fim
    end;
}

