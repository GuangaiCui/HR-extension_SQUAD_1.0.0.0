table 53104 "Associações Empregadores"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'No. Mov.';
        }
        field(5; "Associação de Empregadores"; Code[20])
        {
            Caption = 'Employers Association';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(AssEmp));

            trigger OnValidate()
            begin
                RUTabelas.Reset;
                RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::AssEmp);
                RUTabelas.SetRange(RUTabelas.Código, "Associação de Empregadores");
                if RUTabelas.FindFirst then
                    "Desc. Associação" := RUTabelas.Descrição
                else
                    "Desc. Associação" := '';
            end;
        }
        field(6; "Desc. Associação"; Text[250])
        {
            Caption = 'Association Description';
        }
        field(7; "Data de Adesão"; Date)
        {
            Caption = 'Admition Date';
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

    var
        RUTabelas: Record "RU - Tabelas";
}

