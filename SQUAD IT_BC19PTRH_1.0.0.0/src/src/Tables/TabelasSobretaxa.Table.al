table 31003127 "Tabelas Sobretaxa"
{

    fields
    {
        field(1; "Echelon Code"; Code[10])
        {
            Caption = 'Cód. Escalão';
        }
        field(2; "Table"; Option)
        {
            Caption = 'Tabela';
            OptionCaption = 'Não Casados e Casados 2 Tit.,Casados 1 Tit.';
            OptionMembers = NCasCas2Tit,Cas1Tit;
        }
        field(3; "Minimum Value"; Decimal)
        {
            Caption = 'Valor Mínimo';
        }
        field(4; "Maximum Value"; Decimal)
        {
            Caption = 'Valor Máximo';
        }
        field(5; "Tax %"; Decimal)
        {
            Caption = 'Taxa %';
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

