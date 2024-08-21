#pragma implicitwith disable
page 53166 "Tabelas Sobretaxa"
{
    PageType = List;
    SourceTable = "Tabelas Sobretaxa";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Echelon Code"; Rec."Echelon Code")
                {
                    ;

                }
                field("Table"; Rec.Table)
                {
                    ;

                }
                field("Minimum Value"; Rec."Minimum Value")
                {
                    ;

                }
                field("Maximum Value"; Rec."Maximum Value")
                {
                    ;

                }
                field("Tax %"; Rec."Tax %")
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

