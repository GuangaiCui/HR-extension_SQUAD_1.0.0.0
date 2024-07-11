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
                    ApplicationArea = All;

                }
                field("Table"; Rec.Table)
                {
                    ApplicationArea = All;

                }
                field("Minimum Value"; Rec."Minimum Value")
                {
                    ApplicationArea = All;

                }
                field("Maximum Value"; Rec."Maximum Value")
                {
                    ApplicationArea = All;

                }
                field("Tax %"; Rec."Tax %")
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

