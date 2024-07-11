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
                    ApplicationArea = All;

                }
                field("Tipo de Acção"; Rec."Tipo de Acção")
                {
                    ApplicationArea = All;

                }
                field("Código"; Rec."Código")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Rec."Descrição")
                {
                    ApplicationArea = All;

                }
                field("No. Acções Realizadas"; Rec."No. Acções Realizadas")
                {
                    ApplicationArea = All;

                }
                field("No. Participantes Homens"; Rec."No. Participantes Homens")
                {
                    ApplicationArea = All;

                }
                field("No. Participantes Mulheres"; Rec."No. Participantes Mulheres")
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

