page 31003158 "Associações Empregadores"
{
    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Associações Empregadores";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field("Associação de Empregadores"; "Associação de Empregadores")
                {
                    ApplicationArea = All;

                }
                field("Desc. Associação"; "Desc. Associação")
                {
                    ApplicationArea = All;

                }
                field("Data de Adesão"; "Data de Adesão")
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

