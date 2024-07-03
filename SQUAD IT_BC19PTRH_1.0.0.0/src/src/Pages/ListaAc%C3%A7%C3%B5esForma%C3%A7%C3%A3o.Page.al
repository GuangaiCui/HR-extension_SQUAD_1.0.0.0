page 31003120 "Lista Acções Formação"
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
                field("Código"; Código)
                {
                    ApplicationArea = All;
                }
                field("Descrição"; Descrição)
                {
                    ApplicationArea = All;
                }
                field(Tipo; Tipo)
                {
                    ApplicationArea = All;
                }
                field("Data Início"; "Data Início")
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

