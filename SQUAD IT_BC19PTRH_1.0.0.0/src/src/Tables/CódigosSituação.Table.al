table 53088 "Códigos Situação"
{
    LookupPageID = "Lista Códigos Situação";

    fields
    {
        field(1; "Cód. Situação"; Code[2])
        {
            Caption = 'Situation Code';
        }
        field(2; "Descrição"; Text[60])
        {
            Caption = 'Description';
        }
        field(3; "Perdas Efectivas"; Boolean)
        {
            Caption = 'Efective Losses';
        }
        field(4; Diuturnidades; Boolean)
        {
            Caption = 'Seniority';
        }
    }

    keys
    {
        key(Key1; "Cód. Situação")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Cód. Situação", "Descrição")
        {
        }
    }
}

