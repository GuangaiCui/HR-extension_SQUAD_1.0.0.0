page 53074 "Categoria Profissional Interna"
{
    PageType = List;
    SourceTable = "Categoria Profissional Interna";

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
        SetFilter("Data Filtro Inicio", '<=%1', WorkDate);
        SetFilter("Data Filtro Fim", '>=%1|%2', WorkDate, 0D);
    end;
}

