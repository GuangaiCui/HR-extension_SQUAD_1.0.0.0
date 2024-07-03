page 53123 "Lista Actividades Económicas"
{
    PageType = List;
    SourceTable = "Actividades Económicas";
    UsageCategory = Administration;
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

