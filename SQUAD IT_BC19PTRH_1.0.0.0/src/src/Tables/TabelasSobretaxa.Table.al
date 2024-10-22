table 53127 "Tabelas Sobretaxa"
{

    fields
    {
        field(1; "Echelon Code"; Code[10])
        {
        }
        field(2; "Table"; Option)
        {
            OptionMembers = NCasCas2Tit,Cas1Tit;
        }
        field(3; "Minimum Value"; Decimal)
        {
        }
        field(4; "Maximum Value"; Decimal)
        {
        }
        field(5; "Tax %"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Echelon Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

