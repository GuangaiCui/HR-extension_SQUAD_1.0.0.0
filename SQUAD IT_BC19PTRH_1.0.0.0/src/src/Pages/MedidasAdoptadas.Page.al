page 31003145 "Medidas Adoptadas"
{
    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Medidas Adoptadas";
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field("Medida de Prevenção Adoptada"; "Medida de Prevenção Adoptada")
                {
                    ApplicationArea = All;

                }
                field("Desc. Medida de Prev. Adoptada"; "Desc. Medida de Prev. Adoptada")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rFactoresRisco.Reset;
        if rFactoresRisco.Get("No. Mov.") then
            "Tipo de Risco" := rFactoresRisco."Tipo de Risco";
    end;

    var
        rFactoresRisco: Record "Factores de Risco";
}

