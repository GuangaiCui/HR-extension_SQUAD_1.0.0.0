page 31003053 "Artigos Diversos"
{
    Caption = 'Misc. Articles';
    PageType = List;
    SourceTable = "Artigo Diverso";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
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

