table 53125 "Factores Risco - Exames"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Nº Mov';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Nº Linha';
        }
        field(5; "Risk Factor"; Code[20])
        {
            Caption = 'Factor de Risco';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(ExCFR));

            trigger OnValidate()
            begin

                RUTabelas.Reset;
                RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::ExCFR);
                RUTabelas.SetRange(RUTabelas.Código, "Risk Factor");
                if RUTabelas.FindFirst then
                    "Risk Factor Description" := RUTabelas.Descrição
                else
                    "Risk Factor Description" := '';
            end;
        }
        field(6; "Risk Factor Description"; Text[250])
        {
            Caption = 'Desc. Factor de Risco';
        }
        field(7; Observations; Text[250])
        {
            Caption = 'Observações';
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Line No.")
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

