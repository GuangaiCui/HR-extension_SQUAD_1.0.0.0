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
                    ;

                }
                field("Risk Factor Description"; Rec."Risk Factor Description")
                {
                    ;

                }
                field(Observations; Rec.Observations)
                {
                    ;

                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

