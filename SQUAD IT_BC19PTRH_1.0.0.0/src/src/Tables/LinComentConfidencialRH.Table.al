table 53054 "Lin. Coment. Confidencial RH"
{
    Caption = 'HR Confidential Comment Line';
    DataCaptionFields = "No.";
    DrillDownPageID = "Lista Comentários Confidencial";
    LookupPageID = "Lista Comentários Confidencial";

    fields
    {
        field(1; "Table Name"; Option)
        {
            Caption = 'Table Name';
            OptionCaption = 'Confidential Information';
            OptionMembers = "Informação Confidencial";
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = Employee;
        }
        field(3; "Code"; Code[10])
        {
            Caption = 'Code';
            TableRelation = Confidencial.Code;
        }
        field(4; "Table Line No."; Integer)
        {
            Caption = 'Table Line No.';
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(7; Date; Date)
        {
            Caption = 'Date';
        }
        field(9; Comment; Text[80])
        {
            Caption = 'Comment';
        }
    }

    keys
    {
        key(Key1; "Table Name", "No.", "Code", "Table Line No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure SetUpNewLine()
    var
        HRConfCommentLine: Record "Lin. Coment. Confidencial RH";
    begin
        HRConfCommentLine := Rec;
        HRConfCommentLine.SetRecFilter;
        HRConfCommentLine.SetRange("Line No.");
        HRConfCommentLine.SetRange(Date, WorkDate);
        if not HRConfCommentLine.Find('-') then
            Date := WorkDate;
    end;
}

