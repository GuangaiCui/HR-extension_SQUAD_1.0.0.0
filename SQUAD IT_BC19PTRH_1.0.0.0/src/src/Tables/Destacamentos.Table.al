table 53052 Destacamentos
{

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'No. Emp.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'No. Linha';
        }
        field(5; "Place of Detachment"; Text[50])
        {
            Caption = 'Local de Destacamento';
        }
        field(6; "Detachment Begin Date"; Date)
        {
            Caption = 'Data Início Destacamento';
        }
        field(7; "Detachment End Date"; Date)
        {
            Caption = 'Data Fim Destacamento';
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Line No.")
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

