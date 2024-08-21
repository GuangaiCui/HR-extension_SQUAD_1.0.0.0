#pragma implicitwith disable
page 53058 "Lista Comentários RH"
{
    AutoSplitKey = true;
    Caption = 'Comment List';
    DataCaptionExpression = HRCommentSheet.Caption;
    Editable = false;
    PageType = List;
    SourceTable = "Linha Coment. Recurso Humano";

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

    var
        HRCommentSheet: Page "Folha Comentários RH";
}

#pragma implicitwith restore

