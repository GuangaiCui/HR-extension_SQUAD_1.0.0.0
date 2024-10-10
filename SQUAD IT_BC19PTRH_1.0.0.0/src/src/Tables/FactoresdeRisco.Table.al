table 53121 "Factores de Risco"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'No. Mov.';
        }
        field(5; Data; Date)
        {
            Caption = 'Data';
        }
        field(6; "Tipo de Risco"; Option)
        {
            Caption = 'Tipo de Risco';
            OptionCaption = 'Físico,Químico,Biológico,Músculo-esquelético,Psicossociais,Outros';
            OptionMembers = "Físico","Químico","Biológico","Músculo-esquelético",Psicossociais,Outros;
        }
        field(7; Agente; Code[20])
        {
            Caption = 'Agente';
            TableRelation = IF ("Tipo de Risco" = CONST("Físico")) "RU - Tabelas"."Código" WHERE(Tipo = CONST(RF))
            ELSE
            IF ("Tipo de Risco" = CONST("Biológico")) "RU - Tabelas"."Código" WHERE(Tipo = CONST(RB))
            ELSE
            IF ("Tipo de Risco" = CONST("Músculo-esquelético")) "RU - Tabelas"."Código" WHERE(Tipo = CONST(RM))
            ELSE
            IF ("Tipo de Risco" = CONST(Psicossociais)) "RU - Tabelas"."Código" WHERE(Tipo = CONST(RP))
            ELSE
            IF ("Tipo de Risco" = CONST(Outros)) "RU - Tabelas"."Código" WHERE(Tipo = CONST(OR));

            trigger OnValidate()
            begin
                RUTabelas.Reset;
                if "Tipo de Risco" = "Tipo de Risco"::"Físico" then RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::RF);
                if "Tipo de Risco" = "Tipo de Risco"::"Biológico" then RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::RB);
                if "Tipo de Risco" = "Tipo de Risco"::"Músculo-esquelético" then RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::RM);
                if "Tipo de Risco" = "Tipo de Risco"::Psicossociais then RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::RP);
                if "Tipo de Risco" = "Tipo de Risco"::Outros then RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::"OR");
                RUTabelas.SetRange(RUTabelas.Código, Agente);
                if RUTabelas.FindFirst then begin
                    "Identificação do Agente" := RUTabelas.Descrição;
                    if "Tipo de Risco" = "Tipo de Risco"::"Biológico" then
                        "Classificação do Agente" := RUTabelas.Classificação
                    else
                        "Classificação do Agente" := '';

                end;
            end;
        }
        field(8; "No. Trab. Expostos H"; Integer)
        {
            Caption = 'No. Trab. Expostos - Homens';
        }
        field(9; "No. Trab. Expostos M"; Integer)
        {
            Caption = 'No. Trab. Expostos - Mulheres';
        }
        field(10; "No. Avaliações Efectuadas"; Integer)
        {
            Caption = 'No. Avaliações Efectuadas';
        }
        field(11; "No. Ordem - Código"; Code[20])
        {
            Caption = 'No. Ordem - Código';
            TableRelation = IF ("Tipo de Risco" = CONST("Químico")) "RU - Tabelas"."Código" WHERE(Tipo = CONST(RQ));

            trigger OnValidate()
            begin
                RUTabelas.Reset;
                RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::RQ);
                RUTabelas.SetRange(RUTabelas.Código, "No. Ordem - Código");
                if RUTabelas.FindFirst then
                    "Identificação do Agente" := RUTabelas.Descrição
                else
                    "Identificação do Agente" := '';
            end;
        }
        field(12; "Identificação do Agente"; Text[70])
        {
            Caption = 'Identificação do Agente';
        }
        field(13; "Menção ou Frase de Risco"; Code[20])
        {
            Caption = 'Menção ou Frase de Risco';
            TableRelation = IF ("Tipo de Risco" = CONST("Químico")) "RU - Tabelas"."Código" WHERE(Tipo = CONST(RQMF));
        }
        field(14; "Classificação do Agente"; Text[1])
        {
            Caption = 'Classificação do Agente';
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

