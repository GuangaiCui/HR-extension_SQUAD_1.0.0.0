#pragma implicitwith disable
page 53078 "Grau Função"
{
    PageType = List;
    SourceTable = "Grau Função";
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
                field("Level 1"; Rec."Level 1")
                {
                    ;

                    Visible = false;
                }
                field("Level 2"; Rec."Level 2")
                {
                    ;

                    Visible = false;
                }
                field("Level 3"; Rec."Level 3")
                {
                    ;

                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ;

                }
                field("Min Value"; Rec."Min Value")
                {
                    ;

                }
                field("Max Value"; Rec."Max Value")
                {
                    ;

                }
                field("Valor Hora Semanal"; Rec."Valor Hora Semanal")
                {
                    ;

                }
                field("Cod. Índice"; Rec."Cod. Índice")
                {
                    ;

                }
                field("Employees No."; Rec."Employees No.")
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
        //Isto serve para filtrar os graus de função para que só apareçam os que estão em vigor
        //ou seja, os que têm a data de inicio anterior à Workdate
        // e que têm a data de fim  posterior à workdate
        Rec.SetFilter("Data Filtro Inicio", '<=%1', WorkDate);
        Rec.SetFilter("Data Filtro Fim", '>=%1|%2', WorkDate, 0D);
        //HG - Fim
    end;
}

#pragma implicitwith restore

