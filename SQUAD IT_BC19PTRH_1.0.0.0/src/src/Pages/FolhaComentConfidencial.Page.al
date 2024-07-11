#pragma implicitwith disable
page 53069 "Folha Coment. Confidencial"
{
    AutoSplitKey = true;
    Caption = 'Confidential Comment Sheet';
    DataCaptionExpression = Caption(Rec);
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "Lin. Coment. Confidencial RH";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
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

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetUpNewLine;
    end;

    var
        Text000: Label 'untitled';
        Employee: Record Empregado;
        ConfidentialInfo: Record "Informação Confidencial";


    procedure Caption(HRCommentLine: Record "Lin. Coment. Confidencial RH"): Text[110]
    begin
        if ConfidentialInfo.Get(HRCommentLine."No.", HRCommentLine.Code, HRCommentLine."Table Line No.") and
           Employee.Get(HRCommentLine."No.")
          then
            exit(HRCommentLine."No." + ' ' + Employee.FullName + ' ' +
                 ConfidentialInfo."Confidential Code");
        exit(Text000);
    end;
}

#pragma implicitwith restore

