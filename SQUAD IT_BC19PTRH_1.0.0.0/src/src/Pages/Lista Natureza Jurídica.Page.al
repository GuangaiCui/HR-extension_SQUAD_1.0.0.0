#pragma implicitwith disable
page 53124 "Lista Natureza Jurídica"
{
    PageType = List;
    SourceTable = "Natureza Jurídica";
    UsageCategory = Administration;
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
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

