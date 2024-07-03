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

    var
        HRCommentSheet: Page "Folha Comentários RH";
}

