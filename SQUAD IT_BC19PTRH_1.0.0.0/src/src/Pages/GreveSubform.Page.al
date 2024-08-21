#pragma implicitwith disable
page 53162 "Greve Subform"
{
    PageType = CardPart;
    SourceTable = Greves;

    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field("Strike Date"; Rec."Strike Date")
                {
                    ;

                }
                field("Normal Working Period"; Rec."Normal Working Period")
                {
                    ;

                }
                field("Strike Number of Workers"; Rec."Strike Number of Workers")
                {
                    ;

                }
                field("Stop Time (Hours)"; Rec."Stop Time (Hours)")
                {
                    ;

                }
                field("Stop Time (Minutes)"; Rec."Stop Time (Minutes)")
                {
                    ;

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
        rGreves.SetRange(rGreves.Type, rGreves.Type::Linha2);
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

