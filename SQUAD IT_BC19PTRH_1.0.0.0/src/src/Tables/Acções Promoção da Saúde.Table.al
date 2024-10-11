table 53082 "Acções Promoção da Saúde"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'No. Mov';
            AutoIncrement = true;
        }
        field(5; Data; Date)
        {
        }
        field(6; "Actividade Desenvolvida"; Code[20])
        {
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(ActDes));
        }
        field(7; "No. Acções Realizadas"; Integer)
        {
        }
        field(8; "No. Trabalhadores Abrangidos H"; Integer)
        {
        }
        field(9; "No. Trabalhadores Abrangidos M"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

