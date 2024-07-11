#pragma implicitwith disable
page 53156 "RU - Tabelas"
{
    PageType = List;
    SourceTable = "RU - Tabelas";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field("Código"; Rec."Código")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Rec."Descrição")
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

