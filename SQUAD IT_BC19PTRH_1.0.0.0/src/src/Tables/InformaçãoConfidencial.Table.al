table 53051 "Informação Confidencial"
{
    Caption = 'Confidential Information';
    DataCaptionFields = "Employee No.";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Empregado;
        }
        field(2; "Confidential Code"; Code[10])
        {
            NotBlank = true;
            TableRelation = Confidencial;

            trigger OnValidate()
            begin
                Confidential.Get("Confidential Code");
                Description := Confidential.Description;
            end;
        }
        field(3; "Line No."; Integer)
        {
            NotBlank = true;
        }
        field(4; Description; Text[30])
        {
        }
        field(5; Comment; Boolean)
        {
            CalcFormula = Exist("Lin. Coment. Confidencial RH" WHERE("Table Name" = CONST("Informação Confidencial"),
                                                                      "No." = FIELD("Employee No."),
                                                                      "Table Line No." = FIELD("Line No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Confidential Code", "Line No.")
        {
            Clustered = true;
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

    var
        Text000: Label 'You can not delete confidential information if there are comments associated with it.';
        Confidential: Record Confidencial;
}

