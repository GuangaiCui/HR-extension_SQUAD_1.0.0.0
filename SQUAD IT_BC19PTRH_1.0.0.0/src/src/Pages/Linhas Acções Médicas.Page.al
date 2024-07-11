#pragma implicitwith disable
page 53147 "Linhas Acções Médicas"
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
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;

                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;

                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;

                }
                field(Hour; Rec.Hour)
                {
                    ApplicationArea = All;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;

                }
                field(Observations; Rec.Observations)
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

