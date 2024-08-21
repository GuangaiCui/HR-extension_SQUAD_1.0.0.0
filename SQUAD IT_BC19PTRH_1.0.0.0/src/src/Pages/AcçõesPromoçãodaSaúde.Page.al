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
                    ;

                }
                field("Actividade Desenvolvida"; Rec."Actividade Desenvolvida")
                {
                    ;

                }
                field("No. Acções Realizadas"; Rec."No. Acções Realizadas")
                {
                    ;

                }
                field("No. Trabalhadores Abrangidos H"; Rec."No. Trabalhadores Abrangidos H")
                {
                    ;

                }
                field("No. Trabalhadores Abrangidos M"; Rec."No. Trabalhadores Abrangidos M")
                {
                    ;

                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

