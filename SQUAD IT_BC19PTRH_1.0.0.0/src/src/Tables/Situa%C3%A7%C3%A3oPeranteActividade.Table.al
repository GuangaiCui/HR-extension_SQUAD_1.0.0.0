table 31003089 "Situação Perante Actividade"
{

    fields
    {
        field(1; "Cod. Estabelecimento"; Code[4])
        {
            Caption = 'Office Code';
        }
        field(2; "No. Linha"; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; CAE; Code[20])
        {
            Caption = 'CAE';
        }
        field(8; "Situação"; Code[20])
        {
            Caption = 'Situation';
            TableRelation = "RU - Tabelas"."Código" WHERE (Tipo = CONST (SitAct));

            trigger OnValidate()
            begin
                RUTabelas.Reset;
                RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::SitAct);
                RUTabelas.SetRange(RUTabelas.Código, Situação);
                if RUTabelas.FindFirst then
                    "Desc. Situação" := RUTabelas.Descrição
                else
                    "Desc. Situação" := '';
            end;
        }
        field(9; "Desc. Situação"; Text[50])
        {
            Caption = 'Situation Description';
        }
        field(10; Motivo; Code[20])
        {
            Caption = 'Reason Code';
            TableRelation = "RU - Tabelas"."Código" WHERE (Tipo = CONST (MotSit));

            trigger OnValidate()
            begin
                RUTabelas.Reset;
                RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::MotSit);
                RUTabelas.SetRange(RUTabelas.Código, Motivo);
                if RUTabelas.FindFirst then
                    "Desc. Motivo" := RUTabelas.Descrição
                else
                    "Desc. Motivo" := '';
            end;
        }
        field(11; "Desc. Motivo"; Text[50])
        {
            Caption = 'Reason Description';
        }
        field(12; "Data Início"; Date)
        {
            Caption = 'Start Date';
        }
        field(13; "Data Fim"; Date)
        {
            Caption = 'End Date';
        }
    }

    keys
    {
        key(Key1; "Cod. Estabelecimento", "No. Linha")
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

