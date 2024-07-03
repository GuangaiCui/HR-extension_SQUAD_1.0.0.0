page 53116 "Lista Códigos Situação"
{
    PageType = List;
    SourceTable = "Códigos Situação";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Cód. Situação"; "Cód. Situação")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Descrição)
                {
                    ApplicationArea = All;

                }
                field("Perdas Efectivas"; "Perdas Efectivas")
                {
                    ApplicationArea = All;

                }
                field(Diuturnidades; Diuturnidades)
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

