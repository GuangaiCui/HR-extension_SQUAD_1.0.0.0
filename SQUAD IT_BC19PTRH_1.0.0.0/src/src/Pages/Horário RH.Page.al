#pragma implicitwith disable
page 53081 "Horário RH"
{
    PageType = List;
    SourceTable = "Horário RH";
    UsageCategory = Lists;
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
                field("Hora Entrada"; Rec."Hora Entrada")
                {
                    ApplicationArea = All;

                }
                field("Hora Saída"; Rec."Hora Saída")
                {
                    ApplicationArea = All;

                }
                field("Hora Início Almoço"; Rec."Hora Início Almoço")
                {
                    ApplicationArea = All;

                }
                field("Hora Fim Almoço"; Rec."Hora Fim Almoço")
                {
                    ApplicationArea = All;

                }
                field("No. Horas Diárias"; Rec."No. Horas Diárias")
                {
                    ApplicationArea = All;

                }
                field("No. Horas Semanais"; Rec."No. Horas Semanais")
                {
                    ApplicationArea = All;

                }
                field("No. Horas Mensais"; Rec."No. Horas Mensais")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //HG 11.07.05
        //Isto serve para filtrar os Horários para que só apareçam os que estão em vigor
        //ou seja, os que têm a data de inicio anterior à Workdate
        // e que têm a data de fim  posterior à workdate
        Rec.SetFilter("Data Filtro Inicio", '<=%1', WorkDate);
        Rec.SetFilter("Data Filtro Fim", '>=%1', WorkDate);
        //HG - Fim
    end;
}

#pragma implicitwith restore

