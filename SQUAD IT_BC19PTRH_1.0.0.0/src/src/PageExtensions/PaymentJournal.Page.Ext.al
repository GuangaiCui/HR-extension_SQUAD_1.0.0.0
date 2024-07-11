#pragma implicitwith disable
pageextension 53037 PaymentJournalRH extends "Payment Journal"
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
