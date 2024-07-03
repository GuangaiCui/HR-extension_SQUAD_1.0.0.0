table 31003044 Sindicato
{
    Caption = 'Union';
    DrillDownPageID = Sindicatos;
    LookupPageID = Sindicatos;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(3; Address; Text[30])
        {
            Caption = 'Address';
        }
        field(4; "Post Code"; Code[20])
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
        field(5; City; Text[30])
        {
            Caption = 'City';

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(6; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(7; "No. of Members Employed"; Integer)
        {
            CalcFormula = Count (Empregado WHERE (Status = FILTER (<> Terminated),
                                                 "Union Code" = FIELD (Code)));
            Caption = 'No. of Members Employed';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Name 2"; Text[30])
        {
            Caption = 'Name 2';
        }
        field(9; "Address 2"; Text[30])
        {
            Caption = 'Address 2';
        }
        field(10; County; Text[30])
        {
            Caption = 'County';
        }
        field(11; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(12; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
        }
        field(13; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
        }
        field(14; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
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

