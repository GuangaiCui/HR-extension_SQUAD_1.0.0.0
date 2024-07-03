page 31003150 "Acções Promoção da Saúde"
{
    PageType = List;
    SourceTable = "Acções Promoção da Saúde";
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field(Data; Data)
                {
                    ApplicationArea = All;

                }
                field("Actividade Desenvolvida"; "Actividade Desenvolvida")
                {
                    ApplicationArea = All;

                }
                field("No. Acções Realizadas"; "No. Acções Realizadas")
                {
                    ApplicationArea = All;

                }
                field("No. Trabalhadores Abrangidos H"; "No. Trabalhadores Abrangidos H")
                {
                    ApplicationArea = All;

                }
                field("No. Trabalhadores Abrangidos M"; "No. Trabalhadores Abrangidos M")
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

