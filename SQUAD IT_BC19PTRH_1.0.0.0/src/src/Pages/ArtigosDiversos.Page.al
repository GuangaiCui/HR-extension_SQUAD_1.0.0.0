#pragma implicitwith disable
page 53053 "Artigos Diversos"
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
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
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

