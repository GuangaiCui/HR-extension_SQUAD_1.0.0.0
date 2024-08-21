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
                    ;

                }
                field("Descrição"; Rec."Descrição")
                {
                    ;

                }
                field("Hora Entrada"; Rec."Hora Entrada")
                {
                    ;

                }
                field("Hora Saída"; Rec."Hora Saída")
                {
                    ;

                }
                field("Hora Início Almoço"; Rec."Hora Início Almoço")
                {
                    ;

                }
                field("Hora Fim Almoço"; Rec."Hora Fim Almoço")
                {
                    ;

                }
                field("No. Horas Diárias"; Rec."No. Horas Diárias")
                {
                    ;

                }
                field("No. Horas Semanais"; Rec."No. Horas Semanais")
                {
                    ;

                }
                field("No. Horas Mensais"; Rec."No. Horas Mensais")
                {
                    ;

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

