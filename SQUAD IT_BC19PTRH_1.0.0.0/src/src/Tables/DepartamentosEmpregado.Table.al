table 31003047 "Departamentos Empregado"
{
    Caption = 'Employee Statistics Group';
    DrillDownPageID = "Departamentos Empregado";
    LookupPageID = "Departamentos Empregado";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
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
        fieldgroup(DropDown; "Code", Description)
        {
        }
    }
}

