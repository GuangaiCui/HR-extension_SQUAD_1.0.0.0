#pragma implicitwith disable
pageextension 53038 RecurringGeneralJournalRH extends "Recurring General Journal"
{
    layout
    {
        addlast(Control1)

        {

            field("No. Empregado"; Rec."No. Empregado")

            {

                ApplicationArea = ALL;

            }
        }

    }
}
#pragma implicitwith restore
