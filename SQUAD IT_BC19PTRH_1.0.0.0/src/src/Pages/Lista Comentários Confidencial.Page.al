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


                }
                field(Date; Rec.Date)
                {


                }
                field(Comment; Rec.Comment)
                {


                }
                field("Code"; Rec.Code)
                {


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

