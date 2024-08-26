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


                }
                field("Descrição"; Rec."Descrição")
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

