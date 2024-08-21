#pragma implicitwith disable
page 53120 "Lista Acções Formação"
{
    CardPageID = "Ficha Acção Formação";
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Acções Formação";
    UsageCategory = Tasks;
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
                field(Tipo; Rec.Tipo)
                {

                }
                field("Data Início"; Rec."Data Início")
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

