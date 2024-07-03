page 31003148 "Factores Risco - Exames"
{
    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Factores Risco - Exames";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field("Risk Factor"; "Risk Factor")
                {
                    ApplicationArea = All;

                }
                field("Risk Factor Description"; "Risk Factor Description")
                {
                    ApplicationArea = All;

                }
                field(Observations; Observations)
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

