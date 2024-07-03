page 31003095 "Lista Freguesia/Conc/Distrito"
{
    PageType = List;
    SourceTable = "Cód. Freguesia/Conc/Distrito";
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
                field(Freguesia; Freguesia)
                {
                    ApplicationArea = All;

                }
                field(Concelho; Concelho)
                {
                    ApplicationArea = All;

                }
                field(Distrito; Distrito)
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

