table 53091 "Cód. Freguesia/Conc/Distrito"
{
    LookupPageID = "Lista Freguesia/Conc/Distrito";

    fields
    {
        field(1; "Código"; Code[6])
        {
            //Caption = 'Code';
        }
        field(3; Freguesia; Text[100])
        {
            //Caption = 'Parish';
        }
        field(4; Concelho; Text[100])
        {
            //Caption = 'County';
        }
        field(5; Distrito; Text[100])
        {
            //Caption = 'District';
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
        fieldgroup(DropDown; "Código", Freguesia, Concelho, Distrito)
        {
        }
    }
}

