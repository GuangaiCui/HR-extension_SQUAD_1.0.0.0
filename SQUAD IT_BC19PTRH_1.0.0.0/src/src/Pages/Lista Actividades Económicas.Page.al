#pragma implicitwith disable
page 53123 "Lista Actividades Económicas"
{
    PageType = List;
    SourceTable = "Actividades Económicas";
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

