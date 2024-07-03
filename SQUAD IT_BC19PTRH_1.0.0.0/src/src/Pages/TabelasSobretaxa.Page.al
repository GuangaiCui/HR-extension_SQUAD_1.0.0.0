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
                field("Echelon Code"; "Echelon Code")
                {
                    ApplicationArea = All;

                }
                field("Table"; Table)
                {
                    ApplicationArea = All;

                }
                field("Minimum Value"; "Minimum Value")
                {
                    ApplicationArea = All;

                }
                field("Maximum Value"; "Maximum Value")
                {
                    ApplicationArea = All;

                }
                field("Tax %"; "Tax %")
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

