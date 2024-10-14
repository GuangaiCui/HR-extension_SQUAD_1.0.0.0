table 53036 "Endereço Alternativo"
{
    Caption = 'Alternative Address';
    DataCaptionFields = "Employee No.", Name, "Code";
    DrillDownPageID = "Lista Endereços Alternativos";
    LookupPageID = "Lista Endereços Alternativos";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'No. Empregado';
            NotBlank = true;
            TableRelation = Empregado;

            trigger OnValidate()
            begin
                Employee.Get("Employee No.");
                Name := Employee."Last Name";
            end;
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Código';
            NotBlank = true;
        }
        field(3; Name; Text[30])
        {
            Caption = 'Nome';
        }
        field(4; "Name 2"; Text[30])
        {
            Caption = 'Nome 2';
        }
        field(5; Address; Text[30])
        {
            Caption = 'Endereço';
        }
        field(6; "Address 2"; Text[30])
        {
            Caption = 'Endereço 2';
        }
        field(7; City; Text[30])
        {
            Caption = 'Cidade';

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(8; "Post Code"; Code[20])
        {
            Caption = 'Cód. Postal';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(9; County; Text[30])
        {
            Caption = 'Distrito';
        }
        field(10; "Phone No."; Text[30])
        {
            Caption = 'Telefone';
        }
        field(11; "Fax No."; Text[30])
        {
            Caption = 'No. Fax';
        }
        field(12; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
        }
        field(13; Comment; Boolean)
        {
            CalcFormula = Exist("Linha Coment. Recurso Humano" WHERE("Table Name" = CONST("Edç"),
                                                                      "No." = FIELD("Employee No."),
                                                                      "Alternative Address Code" = FIELD(Code)));
            Caption = 'Comentário';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Country Code"; Code[10])
        {
            Caption = 'Cód. País';
            TableRelation = "Country/Region";
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PostCode: Record "Post Code";
        Employee: Record Empregado;
}

