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
                    ApplicationArea = All;
                }
                field("Descrição"; Rec."Descrição")
                {
                    ApplicationArea = All;
                }
                field(Tipo; Rec.Tipo)
                {
                    ApplicationArea = All;
                }
                field("Data Início"; Rec."Data Início")
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

