#pragma implicitwith disable
page 53060 "List Table IRS 2023"
{
    Editable = true;
    PageType = List;
    SourceTable = "Table IRS 2023";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Line No."; Rec."Line No.")
                {
                }
                field(Region; Rec.Region)
                {
                }
                field(Table; Rec.Table)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Value; Rec.Value)
                {
                }
                field(Tax; Rec.Tax)
                {
                }
                field("Value to Substract"; Rec."Value to Substract")
                {
                }
                field("Factor to Substract"; Rec."Factor to Substract")
                {
                }
                field("Fixed Value to Substract"; Rec."Fixed Value to Substract")
                {
                }
                field("Value to Substract/dependente"; Rec."Value to Substract/dependente")
                {
                }
                field("From Date"; Rec."From Date")
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

