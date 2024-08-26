#pragma implicitwith disable
page 53126 "Lista Tipo Empregado"
{
    PageType = List;
    SourceTable = "Tipo Empregado";
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

