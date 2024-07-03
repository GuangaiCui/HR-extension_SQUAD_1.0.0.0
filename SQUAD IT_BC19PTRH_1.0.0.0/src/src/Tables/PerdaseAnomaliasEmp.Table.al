table 53086 "Perdas e Anomalias Emp."
{

    fields
    {
        field(1; "No. Empregado"; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Empregado;
        }
        field(2; "No. Linha"; Integer)
        {
            Caption = 'Line No.';
        }
        field(6; "Grau de Incapacidade"; Option)
        {
            Caption = 'Inability Degree';
            OptionCaption = 'Inferior a 60%,De 60% e Inferior a 80%,Igual ou Superior a 80%';
            OptionMembers = "Inferior a 60%","De 60% e Inferior a 80%","Igual ou Superior a 80%";
        }
        field(7; "Data Grau de Incapacidade"; Date)
        {
            Caption = 'Inability Date';
        }
        field(8; "Observações"; Text[250])
        {
            Caption = 'Observations';
        }
    }

    keys
    {
        key(Key1; "No. Empregado", "No. Linha")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

