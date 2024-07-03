page 53143 "Acções de Inf. Cons. For"
{
    PageType = List;
    SourceTable = "Acções de Inf. Cons. For";
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field("Data da Acção"; "Data da Acção")
                {
                    ApplicationArea = All;

                }
                field("Tipo de Acção"; "Tipo de Acção")
                {
                    ApplicationArea = All;

                }
                field("Código"; Código)
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Descrição)
                {
                    ApplicationArea = All;

                }
                field("No. Acções Realizadas"; "No. Acções Realizadas")
                {
                    ApplicationArea = All;

                }
                field("No. Participantes Homens"; "No. Participantes Homens")
                {
                    ApplicationArea = All;

                }
                field("No. Participantes Mulheres"; "No. Participantes Mulheres")
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

