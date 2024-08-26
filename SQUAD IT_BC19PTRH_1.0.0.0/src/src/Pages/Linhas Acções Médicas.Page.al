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


                }
                field(Name; Rec.Name)
                {


                }
                field(Date; Rec.Date)
                {


                }
                field(Hour; Rec.Hour)
                {


                }
                field(Status; Rec.Status)
                {


                }
                field(Observations; Rec.Observations)
                {


                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

