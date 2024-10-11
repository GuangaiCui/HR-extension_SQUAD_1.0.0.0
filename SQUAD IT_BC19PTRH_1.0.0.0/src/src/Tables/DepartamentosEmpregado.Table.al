table 53047 "Departamentos Empregado"
{
    Caption = 'Employee Statistics Group';
    DrillDownPageID = "Departamentos Empregado";
    LookupPageID = "Departamentos Empregado";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Código';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Descrição';
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

