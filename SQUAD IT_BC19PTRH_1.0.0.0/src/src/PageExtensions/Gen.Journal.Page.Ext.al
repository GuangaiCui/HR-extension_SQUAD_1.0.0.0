
#pragma implicitwith disable
pageextension 53036 GenJournalRH extends "General Journal"
{
    layout
    {
        addlast(Control1)

        {

            field("Employee No."; Rec."Employee No.")

            {

                ApplicationArea = Basic, Suite;

            }
        }

    }
}
#pragma implicitwith restore
