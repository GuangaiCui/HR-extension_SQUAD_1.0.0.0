table 53096 "Natureza Jurídica"
{
    LookupPageID = "Lista Natureza Jurídica";

    fields
    {
        field(1; "Código"; Code[5])
        {
            //Caption = 'Code';
        }
        field(3; "Descrição"; Text[200])
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

