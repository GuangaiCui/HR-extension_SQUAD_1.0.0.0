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

    var
        HRCommentSheet: Page "Folha Comentários RH";
}

#pragma implicitwith restore

