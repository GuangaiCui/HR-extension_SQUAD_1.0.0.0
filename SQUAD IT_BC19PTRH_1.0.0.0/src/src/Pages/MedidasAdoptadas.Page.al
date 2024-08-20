#pragma implicitwith disable
page 53145 "Medidas Adoptadas"
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
                field("Medida de Prevenção Adoptada"; Rec."Medida de Prevenção Adoptada")
                {
                    ApplicationArea = All;
                }
                field("Desc. Medida de Prev. Adoptada"; Rec."Desc. Medida de Prev. Adoptada")
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
        if rFactoresRisco.Get(Rec."No. Mov.") then
            Rec."Tipo de Risco" := rFactoresRisco."Tipo de Risco";
    end;

    var
        rFactoresRisco: Record "Factores de Risco";
}

#pragma implicitwith restore

