table 53071 "Class. Nac. Profissões"
{
    DrillDownPageID = "Matriz Vista Ferias";
    LookupPageID = "Matriz Vista Ferias";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Código';
        }
        field(2; Description; Text[150])
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

