#pragma implicitwith disable
page 53155 "Perdas e Anomalias Emp."
{
    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Perdas e Anomalias Emp.";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field("Grau de Incapacidade"; Rec."Grau de Incapacidade")
                {
                    ApplicationArea = All;

                }
                field("Data Grau de Incapacidade"; Rec."Data Grau de Incapacidade")
                {
                    ApplicationArea = All;

                }
                field("Observações"; Rec."Observações")
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

