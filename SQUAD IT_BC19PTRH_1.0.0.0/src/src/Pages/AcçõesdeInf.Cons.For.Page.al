#pragma implicitwith disable
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
                field("Data da Acção"; Rec."Data da Acção")
                {
                    ;
                }
                field("Tipo de Acção"; Rec."Tipo de Acção")
                {
                    ;
                }
                field("Código"; Rec."Código")
                {
                    ;
                }
                field("Descrição"; Rec."Descrição")
                {
                    ;
                }
                field("No. Acções Realizadas"; Rec."No. Acções Realizadas")
                {
                    ;
                }
                field("No. Participantes Homens"; Rec."No. Participantes Homens")
                {
                    ;
                }
                field("No. Participantes Mulheres"; Rec."No. Participantes Mulheres")
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

