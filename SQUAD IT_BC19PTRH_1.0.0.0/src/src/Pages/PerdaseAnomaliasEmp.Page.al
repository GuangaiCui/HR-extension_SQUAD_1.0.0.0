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


                }
                field("Data Grau de Incapacidade"; Rec."Data Grau de Incapacidade")
                {


                }
                field("Observações"; Rec."Observações")
                {


                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

