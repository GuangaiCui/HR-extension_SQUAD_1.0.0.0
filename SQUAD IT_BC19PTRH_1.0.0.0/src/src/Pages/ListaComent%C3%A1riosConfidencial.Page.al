page 53070 "Lista Comentários Confidencial"
{
    Caption = 'Comment List';
    Editable = false;
    PageType = Card;
    SourceTable = "Lin. Coment. Confidencial RH";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                field(Date; Date)
                {
                    ApplicationArea = All;

                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;

                }
                field("Code"; Code)
                {
                    ApplicationArea = All;

                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

