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
                    ApplicationArea = All;

                }
                field("Garnishmen No."; Rec."Garnishmen No.")
                {
                    ApplicationArea = All;

                }
                field("Garnishment Date"; Rec."Garnishment Date")
                {
                    ApplicationArea = All;

                }
                field("Garnishment Coefficient"; Rec."Garnishment Coefficient")
                {
                    ApplicationArea = All;

                }
                field("Garnishment Amount"; Rec."Garnishment Amount")
                {
                    ApplicationArea = All;

                }
                field("Amount Already Garnishment"; Rec."Amount Already Garnishment")
                {
                    ApplicationArea = All;

                }
                field("Garnishment Rubric"; Rec."Garnishment Rubric")
                {
                    ApplicationArea = All;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;

                }
                field(Observation; Rec.Observation)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

