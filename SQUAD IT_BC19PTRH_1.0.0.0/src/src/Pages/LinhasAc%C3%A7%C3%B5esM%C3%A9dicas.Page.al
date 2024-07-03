page 31003147 "Linhas Acções Médicas"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Linhas Acções Médicas";

    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = All;

                }
                field(Name; Name)
                {
                    ApplicationArea = All;

                }
                field(Date; Date)
                {
                    ApplicationArea = All;

                }
                field(Hour; Hour)
                {
                    ApplicationArea = All;

                }
                field(Status; Status)
                {
                    ApplicationArea = All;

                }
                field(Observations; Observations)
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

