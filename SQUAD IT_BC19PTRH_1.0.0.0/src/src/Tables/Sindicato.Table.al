table 53044 Sindicato
{
    //Caption = 'Union';
    DrillDownPageID = Sindicatos;
    LookupPageID = Sindicatos;

    fields
    {
        field(1; "Code"; Code[10])
        {
            NotBlank = true;
        }
        field(2; Name; Text[30])
        {
        }
        field(3; Address; Text[30])
        {
        }
        field(4; "Post Code"; Code[20])
        {
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

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(6; "Phone No."; Text[30])
        {
        }
        field(7; "No. of Members Employed"; Integer)
        {
            CalcFormula = Count(Empregado WHERE(Status = FILTER(<> Terminated),
                                                 "Union Code" = FIELD(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Name 2"; Text[30])
        {
        }
        field(9; "Address 2"; Text[30])
        {
        }
        field(10; County; Text[30])
        {
        }
        field(11; "Fax No."; Text[30])
        {
        }
        field(12; "E-Mail"; Text[80])
        {
        }
        field(13; "Home Page"; Text[80])
        {
        }
        field(14; "Country Code"; Code[10])
        {
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

