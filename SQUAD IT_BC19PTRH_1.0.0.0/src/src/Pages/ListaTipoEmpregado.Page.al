page 53126 "Lista Tipo Empregado"
{
    PageType = List;
    SourceTable = "Tipo Empregado";
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

