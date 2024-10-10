#pragma implicitwith disable
pageextension 53038 RecurringGeneralJournalRH extends "Recurring General Journal"
{
    layout
    {
        addlast(Control1)

        {

            field("Employee No."; Rec."Employee No.")

            {

                ApplicationArea = Suite;

            }
        }

    }
}
#pragma implicitwith restore
