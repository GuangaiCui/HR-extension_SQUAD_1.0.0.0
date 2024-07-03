page 53080 "Habilitação"
{
    PageType = List;
    SourceTable = "Habilitação";
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
                field("Descrição"; Descrição)
                {
                    ApplicationArea = All;

                }
                field("Nível"; Nível)
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

