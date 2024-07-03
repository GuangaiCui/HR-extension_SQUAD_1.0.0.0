page 31003155 "Perdas e Anomalias Emp."
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
                field("Grau de Incapacidade"; "Grau de Incapacidade")
                {
                    ApplicationArea = All;

                }
                field("Data Grau de Incapacidade"; "Data Grau de Incapacidade")
                {
                    ApplicationArea = All;

                }
                field("Observações"; Observações)
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

