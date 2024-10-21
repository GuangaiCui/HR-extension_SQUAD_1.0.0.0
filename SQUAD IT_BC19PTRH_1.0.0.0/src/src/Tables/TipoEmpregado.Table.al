table 53098 "Tipo Empregado"
{
    LookupPageID = "Lista Tipo Empregado";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(3; "Description"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, "Description")
        {
        }
    }
}

