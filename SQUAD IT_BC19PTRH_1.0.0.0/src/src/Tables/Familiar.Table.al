table 53039 Familiar
{
    Caption = 'Relative';
    DrillDownPageID = Familiares;
    LookupPageID = Familiares;

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

