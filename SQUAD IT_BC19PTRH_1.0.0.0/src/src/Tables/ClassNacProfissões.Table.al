table 53071 "Class. Nac. Profissões"
{
    DrillDownPageID = "Matriz Vista Ferias";
    LookupPageID = "Matriz Vista Ferias";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[150])
        {
            Caption = 'Descripton';
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

