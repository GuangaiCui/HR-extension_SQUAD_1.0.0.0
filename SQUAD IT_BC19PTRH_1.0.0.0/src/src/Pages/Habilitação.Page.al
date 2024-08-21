#pragma implicitwith disable
page 53080 "Habilitação"
{
    PageType = List;
    SourceTable = "Habilitação";
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Código"; Rec."Código")
                {


                }
                field("Descrição"; Rec."Descrição")
                {


                }
                field("Nível"; Rec."Nível")
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

