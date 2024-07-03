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
                field("Strike Date"; "Strike Date")
                {
                    ApplicationArea = All;

                }
                field("Normal Working Period"; "Normal Working Period")
                {
                    ApplicationArea = All;

                }
                field("Strike Number of Workers"; "Strike Number of Workers")
                {
                    ApplicationArea = All;

                }
                field("Stop Time (Hours)"; "Stop Time (Hours)")
                {
                    ApplicationArea = All;

                }
                field("Stop Time (Minutes)"; "Stop Time (Minutes)")
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
        rGreves.SetRange(rGreves.Type, rGreves.Type::Linha2);
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

