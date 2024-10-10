#pragma implicitwith disable
pageextension 53037 PaymentJournalRH extends "Payment Journal"
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
