table 53110 "Tabela Temporária Relatórios"
{
    // //Tabela auxiliar usada para gerar um relatório

    Caption = 'Tabela Temporária Relatórios';

    fields
    {
        field(1; Code1; Code[20])
        {
            Caption = 'Código1';
        }
        field(2; Code2; Text[250])
        {
            Caption = 'Código2';
        }
        field(3; Decimal1; Decimal)
        {
        }
        field(4; Decimal2; Decimal)
        {
        }
        field(5; Decimal3; Decimal)
        {
        }
        field(6; Decimal4; Decimal)
        {
        }
        field(7; Decimal5; Decimal)
        {
        }
        field(8; Decimal6; Decimal)
        {
        }
        field(9; Decimal7; Decimal)
        {
        }
        field(10; Decimal8; Decimal)
        {
        }
        field(11; Decimal9; Decimal)
        {
        }
        field(12; Decimal10; Decimal)
        {
        }
        field(13; Decimal11; Decimal)
        {
        }
        field(14; Decimal12; Decimal)
        {
        }
        field(15; "Line No"; Integer)
        {
            Caption = 'Nº Linha';
        }
        field(16; Code3; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; Code1, "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

