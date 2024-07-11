#pragma implicitwith disable
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
                field(Claim; Rec.Claim)
                {
                    ApplicationArea = All;

                }
                field("Claim Description"; Rec."Claim Description")
                {
                    ApplicationArea = All;

                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Result; Rec.Result)
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
        rGreves.SetRange(rGreves.Year, Rec.Year);
        rGreves.SetRange(rGreves."Strike Code", Rec."Strike Code");
        if rGreves.FindLast then
            Rec."Line No." := rGreves."Line No." + 10000
        else
            Rec."Line No." := 10000;
    end;

    var
        rGreves: Record Greves;
}

#pragma implicitwith restore

