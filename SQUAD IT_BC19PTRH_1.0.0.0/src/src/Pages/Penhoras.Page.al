#pragma implicitwith disable
page 53050 Penhoras
{
    PageType = List;
    SourceTable = Penhoras;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ;

                }
                field("Garnishmen No."; Rec."Garnishmen No.")
                {
                    ;

                }
                field("Garnishment Date"; Rec."Garnishment Date")
                {
                    ;

                }
                field("Garnishment Coefficient"; Rec."Garnishment Coefficient")
                {
                    ;

                }
                field("Garnishment Amount"; Rec."Garnishment Amount")
                {
                    ;

                }
                field("Amount Already Garnishment"; Rec."Amount Already Garnishment")
                {
                    ;

                }
                field("Garnishment Rubric"; Rec."Garnishment Rubric")
                {
                    ;

                }
                field(Status; Rec.Status)
                {
                    ;

                }
                field(Observation; Rec.Observation)
                {
                    ;

                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

