page 31003050 Penhoras
{
    PageType = List;
    SourceTable = Penhoras;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = All;

                }
                field("Garnishmen No."; "Garnishmen No.")
                {
                    ApplicationArea = All;

                }
                field("Garnishment Date"; "Garnishment Date")
                {
                    ApplicationArea = All;

                }
                field("Garnishment Coefficient"; "Garnishment Coefficient")
                {
                    ApplicationArea = All;

                }
                field("Garnishment Amount"; "Garnishment Amount")
                {
                    ApplicationArea = All;

                }
                field("Amount Already Garnishment"; "Amount Already Garnishment")
                {
                    ApplicationArea = All;

                }
                field("Garnishment Rubric"; "Garnishment Rubric")
                {
                    ApplicationArea = All;

                }
                field(Status; Status)
                {
                    ApplicationArea = All;

                }
                field(Observation; Observation)
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

