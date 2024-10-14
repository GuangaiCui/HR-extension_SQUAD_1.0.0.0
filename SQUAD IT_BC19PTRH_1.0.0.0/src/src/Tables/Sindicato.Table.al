table 53044 Sindicato
{
    Caption = 'Union';
    DrillDownPageID = Sindicatos;
    LookupPageID = Sindicatos;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Código';
            NotBlank = true;
        }
        field(2; Name; Text[30])
        {
            Caption = 'Nome';
        }
        field(3; Address; Text[30])
        {
            Caption = 'Endereço';
        }
        field(4; "Post Code"; Code[20])
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
        field(5; City; Text[30])
        {
            Caption = 'Cidade';

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(6; "Phone No."; Text[30])
        {
            Caption = 'Telefone';
        }
        field(7; "No. of Members Employed"; Integer)
        {
            CalcFormula = Count(Empregado WHERE(Status = FILTER(<> Terminated),
                                                 "Union Code" = FIELD(Code)));
            Caption = 'N.º de Empregados';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Name 2"; Text[30])
        {
            Caption = 'Nome 2';
        }
        field(9; "Address 2"; Text[30])
        {
            Caption = 'Endereço 2';
        }
        field(10; County; Text[30])
        {
            Caption = 'Distrito';
        }
        field(11; "Fax No."; Text[30])
        {
            Caption = 'No. Fax';
        }
        field(12; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
        }
        field(13; "Home Page"; Text[80])
        {
            Caption = 'Página Inicial';
        }
        field(14; "Country Code"; Code[10])
        {
            Caption = 'Cód. País';
            TableRelation = "Country/Region";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Name)
        {
        }
    }

    var
        PostCode: Record "Post Code";
}

