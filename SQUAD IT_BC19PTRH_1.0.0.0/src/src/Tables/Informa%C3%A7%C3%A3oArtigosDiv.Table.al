table 31003049 "Informação Artigos Div."
{
    Caption = 'Misc. Article Information';
    DataCaptionFields = "Employee No.";
    DrillDownPageID = "Informação Artigos Div.";
    LookupPageID = "Informação Artigos Div.";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Empregado;
        }
        field(2; "Misc. Article Code"; Code[10])
        {
            Caption = 'Misc. Article Code';
            NotBlank = true;
            TableRelation = "Artigo Diverso";

            trigger OnValidate()
            begin
                MiscArticle.Get("Misc. Article Code");
                Description := MiscArticle.Description;
            end;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(5; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(6; "To Date"; Date)
        {
            Caption = 'To Date';
        }
        field(7; "In Use"; Boolean)
        {
            Caption = 'In Use';
        }
        field(8; Comment; Boolean)
        {
            CalcFormula = Exist ("Linha Coment. Recurso Humano" WHERE ("Table Name" = CONST (InfArt),
                                                                      "No." = FIELD ("Employee No."),
                                                                      "Alternative Address Code" = FIELD ("Misc. Article Code"),
                                                                      "Table Line No." = FIELD ("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Serial No."; Text[30])
        {
            Caption = 'Serial No.';
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Misc. Article Code", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Comment then
            Error(Text000);
    end;

    trigger OnInsert()
    var
        MiscArticleInfo: Record "Informação Artigos Div.";
    begin
        MiscArticleInfo.SetCurrentKey("Line No.");
        if MiscArticleInfo.Find('+') then
            "Line No." := MiscArticleInfo."Line No." + 1
        else
            "Line No." := 1;
    end;

    var
        Text000: Label 'You cannot delete information if there are comments associated with it.';
        MiscArticle: Record "Artigo Diverso";
}

