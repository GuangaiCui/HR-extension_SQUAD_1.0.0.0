table 31003097 "Formação - Período Referência"
{
    DrillDownPageID = "Registo Formação";
    LookupPageID = "Registo Formação";

    fields
    {
        field(1; "No. Empregado"; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Empregado."No.";
        }
        field(2; "Cód. Acção"; Code[10])
        {
            Caption = 'Training Code';
            TableRelation = "Acções Formação"."Código";
        }
        field(3; "No. Linha"; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Período Ref. Formação"; Code[20])
        {
            Caption = 'Training Period';
            TableRelation = "RU - Tabelas"."Código" WHERE (Tipo = CONST (PRF));

            trigger OnValidate()
            begin
                RuTabelas.Reset;
                RuTabelas.SetRange(RuTabelas.Tipo, RuTabelas.Tipo::PRF);
                RuTabelas.SetRange(RuTabelas.Código, "Período Ref. Formação");
                if RuTabelas.FindFirst then
                    Descrição := RuTabelas.Descrição;
            end;
        }
        field(5; "Descrição"; Text[250])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "No. Empregado", "Cód. Acção", "No. Linha")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text0001: Label 'Execedeu o limite de inscrições permitidas para esta Acção de Formação.';
        RuTabelas: Record "RU - Tabelas";
}

