table 53040 "Familiar Empregado"
{
    Caption = 'Employee Relative';
    DataCaptionFields = "Employee No.";
    DrillDownPageID = "Familiares Empregado";
    LookupPageID = "Familiares Empregado";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'No. Empregado';
            NotBlank = true;
            TableRelation = Empregado;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'No. Linha';
        }
        field(3; "Relative Code"; Code[10])
        {
            Caption = 'Cód. Familiar';
            TableRelation = Familiar;
        }
        field(4; Name; Text[60])
        {
            Caption = 'Nome';
        }
        field(7; "Birth Date"; Date)
        {
            Caption = 'Data Nascimento';
        }
        field(8; "Phone No."; Text[30])
        {
            Caption = 'Telefone';
        }
        field(9; "Employee Relative No."; Code[20])
        {
            Caption = 'Nº Familiar Empregado';
            TableRelation = Empregado;
        }
        field(10; Comment; Boolean)
        {
            CalcFormula = Exist("Linha Coment. Recurso Humano" WHERE("Table Name" = CONST(Fam),
                                                                      "No." = FIELD("Employee No."),
                                                                      "Table Line No." = FIELD("Line No.")));
            Caption = 'Comentário';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Emergency Contact"; Boolean)
        {
            Caption = 'Contacto Emergência';
            DataClassification = ToBeClassified;
        }
        field(21; Gender; Option)
        {
            Caption = 'Sexo';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Femenino,Masculino';
            OptionMembers = " ",Female,Male;
        }
        field(22; "Vat Number"; Text[9])
        {
            Caption = 'No. Contribuinte';
            DataClassification = ToBeClassified;
            Numeric = true;

            trigger OnValidate()
            var
                i: Integer;
                x: Integer;
                num: Integer;
            begin
                //Testa se o Nº de Contribuinte é válido
                if "Vat Number" <> '' then
                    CompanyInfo.CheckNIF("Vat Number");
            end;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        HRCommentLine: Record "Human Resource Comment Line";
    begin
        HRCommentLine.SetRange("Table Name", HRCommentLine."Table Name"::"Employee Relative");
        HRCommentLine.SetRange("No.", "Employee No.");
        HRCommentLine.DeleteAll;
    end;

    var
        CompanyInfo: Record "Company Information";
}

