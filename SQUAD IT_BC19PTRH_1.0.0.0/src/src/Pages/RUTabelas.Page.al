page 31003156 "RU - Tabelas"
{
    PageType = List;
    SourceTable = "RU - Tabelas";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1102065000)
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
            }
        }
    }

    actions
    {
    }
}

