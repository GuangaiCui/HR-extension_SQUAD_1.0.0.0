#pragma implicitwith disable
page 53150 "Acções Promoção da Saúde"
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
                field(Data; Rec.Data)
                {
                    ApplicationArea = All;

                }
                field("Actividade Desenvolvida"; Rec."Actividade Desenvolvida")
                {
                    ApplicationArea = All;

                }
                field("No. Acções Realizadas"; Rec."No. Acções Realizadas")
                {
                    ApplicationArea = All;

                }
                field("No. Trabalhadores Abrangidos H"; Rec."No. Trabalhadores Abrangidos H")
                {
                    ApplicationArea = All;

                }
                field("No. Trabalhadores Abrangidos M"; Rec."No. Trabalhadores Abrangidos M")
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

