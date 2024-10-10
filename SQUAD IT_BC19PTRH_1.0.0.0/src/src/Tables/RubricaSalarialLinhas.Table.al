table 53077 "Rubrica Salarial Linhas"
{
    Caption = 'Rubrica Salarial Linhas';

    fields
    {
        field(1; "Cód. Rubrica"; Code[20])
        {

        }
        field(2; "Cód. Rubrica Filha"; Code[20])
        {

        }
        field(3; "No. Linha"; Integer)
        {
            Caption = 'Line No.';
        }
        field(8; "Tipo Rubrica Filha"; Option)
        {
            Caption = 'Second Salary Iten Type';
            Editable = false;
            OptionCaption = 'Abono,Desconto';
            OptionMembers = Abono,Desconto;
        }
        field(9; "Descrição Rubrica Filha"; Text[100])
        {
            Caption = 'Second Salary Iten Description';
            Editable = false;
        }
        field(15; Percentagem; Decimal)
        {
            Caption = 'Percentage';
            DecimalPlaces = 2 : 3;
            InitValue = 100;
            MaxValue = 100;
            MinValue = 0.001;
        }
        field(16; "Valor Limite Máximo"; Decimal)
        {
            Caption = 'Exemption Maximum Limit Value';
        }
    }

    keys
    {
        key(Key1; "Cód. Rubrica", "Cód. Rubrica Filha", "No. Linha")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        TabRubrica: Record "Rubrica Salarial";
        Text001: Label 'A rubrica %1 não tem o campo NATREN preenchido.';
        rRubrica: Record "Rubrica Salarial";
}

