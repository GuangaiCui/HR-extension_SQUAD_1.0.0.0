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
                    ;

                }
                field("Desc. Associação"; Rec."Desc. Associação")
                {
                    ;

                }
                field("Data de Adesão"; Rec."Data de Adesão")
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

