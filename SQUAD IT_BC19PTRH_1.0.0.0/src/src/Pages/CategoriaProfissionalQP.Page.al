page 53076 "Categoria Profissional QP"
{
    PageType = List;
    SourceTable = "Categoria Profissional QP";

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
                field("Descrição"; Descrição)
                {
                    ApplicationArea = All;

                }
                field("No. Empregados"; "No. Empregados")
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
        //Isto serve para filtrar as cat. Prof para que só apareçam os que estão em vigor
        //ou seja, os que têm a data de inicio anterior à Workdate
        // e que têm a data de fim  posterior à workdate
        SetFilter("Data Filtro Inicio", '<=%1', WorkDate);
        SetFilter("Data Filtro Fim", '>=%1|%2', WorkDate, 0D);
        //HG - Fim
    end;
}

