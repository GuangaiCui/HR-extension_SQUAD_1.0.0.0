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
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                Employee.Get("Employee No.");
                Name := Employee."Last Name";
            end;
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(3; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(4; "Name 2"; Text[30])
        {
            Caption = 'Name 2';
        }
        field(5; Address; Text[30])
        {
            Caption = 'Address';
        }
        field(6; "Address 2"; Text[30])
        {
            Caption = 'Address 2';
        }
        field(7; City; Text[30])
        {
            Caption = 'City';

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(8; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
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
            Caption = 'County';
        }
        field(10; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(11; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
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
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
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
        Employee: Record Employee;
}

