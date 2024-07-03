page 53142 "Actividades dos Serviços"
{
    PageType = List;
    SourceTable = "Actividades dos Serviços";
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field("Data Actividade"; "Data Actividade")
                {
                    ApplicationArea = All;

                }
                field(Actividade; Actividade)
                {
                    ApplicationArea = All;

                }
                field("Descrição Actividade"; "Descrição Actividade")
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

