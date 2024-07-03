page 53161 "Reivindicações"
{
    PageType = CardPart;
    SourceTable = Greves;
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field(Claim; Claim)
                {
                    ApplicationArea = All;

                }
                field("Claim Description"; "Claim Description")
                {
                    ApplicationArea = All;

                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Result; Result)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        rGreves.Reset;
        rGreves.SetRange(rGreves.Type, rGreves.Type::Linha1);
        rGreves.SetRange(rGreves.Year, Year);
        rGreves.SetRange(rGreves."Strike Code", "Strike Code");
        if rGreves.FindLast then
            "Line No." := rGreves."Line No." + 10000
        else
            "Line No." := 10000;
    end;

    var
        rGreves: Record Greves;
}

