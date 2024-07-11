#pragma implicitwith disable
page 53158 "Associações Empregadores"
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
                field("Associação de Empregadores"; Rec."Associação de Empregadores")
                {
                    ApplicationArea = All;

                }
                field("Desc. Associação"; Rec."Desc. Associação")
                {
                    ApplicationArea = All;

                }
                field("Data de Adesão"; Rec."Data de Adesão")
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

