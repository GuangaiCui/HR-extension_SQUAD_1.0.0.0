table 53052 Destacamentos
{

    fields
    {
        field(1; "No. Emp."; Code[20])
        {
            Caption = 'Employee No.';
        }
        field(2; "No. Linha"; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; "Local de Destacamento"; Text[50])
        {
            Caption = 'Place of Detachment';
        }
        field(6; "Data Início Destacamento"; Date)
        {
            Caption = 'Detachment Begin Date';
        }
        field(7; "Data Fim Destacamento"; Date)
        {
            Caption = 'Detachment End Date';
        }
    }

    keys
    {
        key(Key1; "No. Emp.", "No. Linha")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        RUTabelas: Record "RU - Tabelas";
}

