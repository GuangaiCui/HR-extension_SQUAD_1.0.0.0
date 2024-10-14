table 53098 "Tipo Empregado"
{
    LookupPageID = "Lista Tipo Empregado";

    fields
    {
        field(1; "Código"; Code[20])
        {
            //Caption = 'Code';
        }
        field(3; "Descrição"; Text[50])
        {
            //Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Código")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Código", "Descrição")
        {
        }
    }
}

