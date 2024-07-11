#pragma implicitwith disable
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
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;

                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;

                }
                field("Code"; Rec.Code)
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

#pragma implicitwith restore

