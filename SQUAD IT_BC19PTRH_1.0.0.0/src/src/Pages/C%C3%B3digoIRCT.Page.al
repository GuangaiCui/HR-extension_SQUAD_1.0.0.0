page 31003086 "Código IRCT"
{
    PageType = List;
    SourceTable = "Código IRCT";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Código IRCT"; "Código IRCT")
                {
                    ApplicationArea = All;

                }
                field("Acordo Colectivo"; "Acordo Colectivo")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Descrição)
                {
                    ApplicationArea = All;

                }
                field("No. Boletim do Trabalho"; "No. Boletim do Trabalho")
                {
                    ApplicationArea = All;

                }
                field("Data Publicação"; "Data Publicação")
                {
                    ApplicationArea = All;

                }
                field("Data da última Tabela Salarial"; "Data da última Tabela Salarial")
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

