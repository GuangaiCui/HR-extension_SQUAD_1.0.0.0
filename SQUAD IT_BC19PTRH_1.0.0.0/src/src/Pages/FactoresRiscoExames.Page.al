#pragma implicitwith disable
page 53148 "Factores Risco - Exames"
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
                field("Risk Factor"; Rec."Risk Factor")
                {
                    ApplicationArea = All;

                }
                field("Risk Factor Description"; Rec."Risk Factor Description")
                {
                    ApplicationArea = All;

                }
                field(Observations; Rec.Observations)
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

#pragma implicitwith restore

