table 53122 "Medidas Adoptadas"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Nº Mov';
        }
        field(2; "No. Linha"; Integer)
        {
            Caption = 'Nº Linha';
        }
        field(3; "Tipo de Risco"; Option)
        {
            Caption = 'Risk Type';
            OptionMembers = "Físico","Químico","Biológico","Músculo-esquelético",Psicossociais,Outros;
        }
        field(5; "Medida de Prevenção Adoptada"; Code[20])
        {
            Caption = 'Medida de Prevenção Adoptada';
            TableRelation = IF ("Tipo de Risco" = CONST("Físico")) "RU - Tabelas"."Código" WHERE(Tipo = CONST(RFMed))
            ELSE
            IF ("Tipo de Risco" = CONST("Químico")) "RU - Tabelas"."Código" WHERE(Tipo = CONST(RQMed))
            ELSE
            IF ("Tipo de Risco" = CONST("Biológico")) "RU - Tabelas"."Código" WHERE(Tipo = CONST(RBMed))
            ELSE
            IF ("Tipo de Risco" = CONST("Músculo-esquelético")) "RU - Tabelas"."Código" WHERE(Tipo = CONST(RMMed))
            ELSE
            IF ("Tipo de Risco" = CONST(Psicossociais)) "RU - Tabelas"."Código" WHERE(Tipo = CONST(RPMed))
            ELSE
            IF ("Tipo de Risco" = CONST(Outros)) "RU - Tabelas"."Código" WHERE(Tipo = CONST(ORMed));

            trigger OnValidate()
            begin

                RUTabelas.Reset;
                if "Tipo de Risco" = "Tipo de Risco"::"Físico" then
                    RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::RFMed);

                if "Tipo de Risco" = "Tipo de Risco"::"Biológico" then
                    RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::RBMed);

                if "Tipo de Risco" = "Tipo de Risco"::"Músculo-esquelético" then
                    RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::RMMed);

                if "Tipo de Risco" = "Tipo de Risco"::Psicossociais then
                    RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::RPMed);

                if "Tipo de Risco" = "Tipo de Risco"::Psicossociais then
                    RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::RPMed);

                if "Tipo de Risco" = "Tipo de Risco"::Outros then
                    RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::ORMed);

                RUTabelas.SetRange(RUTabelas.Código, "Medida de Prevenção Adoptada");
                if RUTabelas.FindFirst then
                    "Desc. Medida de Prev. Adoptada" := RUTabelas.Descrição
                else
                    "Desc. Medida de Prev. Adoptada" := '';
            end;
        }
        field(6; "Desc. Medida de Prev. Adoptada"; Text[250])
        {
            Caption = 'Desc. Medida de Prev. Adoptada';
        }
    }

    keys
    {
        key(Key1; "Entry No.", "No. Linha")
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

