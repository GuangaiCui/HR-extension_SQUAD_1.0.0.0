table 53084 "Doenças Profissionais"
{

    fields
    {
        field(1; "No. Mov."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(5; "No. Empregado"; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Empregado;
        }
        field(6; "Data Participação"; Date)
        {
            Caption = 'Comunication Date';
        }
        field(7; "Factor Risco"; Code[20])
        {
            Caption = 'Risk Factor';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(RDoeProf));

            trigger OnValidate()
            begin

                RUTabelas.Reset;
                RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::RDoeProf);
                RUTabelas.SetRange(RUTabelas.Código, "Factor Risco");
                if RUTabelas.FindFirst then
                    "Designação Factor Risco" := RUTabelas.Descrição
                else
                    "Designação Factor Risco" := '';
            end;
        }
        field(8; "Designação Factor Risco"; Text[70])
        {
            Caption = 'Risk Factor Description';
            TableRelation = Empregado;
        }
        field(9; "Doença Profissional"; Code[20])
        {
            Caption = 'Profissional Disease';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(DoeProf),
                                                           "Classificação" = FIELD("Factor Risco"));

            trigger OnValidate()
            begin

                RUTabelas.Reset;
                RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::DoeProf);
                RUTabelas.SetRange(RUTabelas.Código, "Doença Profissional");
                if RUTabelas.FindFirst then
                    "Designação Doença Profissional" := RUTabelas.Descrição
                else
                    "Designação Doença Profissional" := '';
            end;
        }
        field(10; "Designação Doença Profissional"; Text[70])
        {
            Caption = 'Profissional Disease Description';
        }
        field(11; "Data Confirmação"; Date)
        {
            Caption = 'Confirmation Date';
        }
    }

    keys
    {
        key(Key1; "No. Mov.")
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

