
#pragma implicitwith disable
pageextension 53036 GenJournalRH extends "General Journal"
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
