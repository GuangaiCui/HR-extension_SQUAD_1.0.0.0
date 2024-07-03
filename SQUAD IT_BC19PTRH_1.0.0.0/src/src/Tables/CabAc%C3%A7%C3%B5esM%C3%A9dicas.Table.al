table 53123 "Cab. Acções Médicas"
{
    LookupPageID = "Lista Acções Médicas";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Nº Movimento';
        }
        field(2; "Exam Type"; Option)
        {
            Caption = 'Tipo de Exame';
            OptionMembers = "Exame Admissão","Exame Periódico","Exame Ocasional","Exame Complementar","Acções Imunização";
        }
        field(3; "Code"; Code[20])
        {
            Caption = 'Código';
            TableRelation = IF ("Exam Type" = CONST("Exame Admissão")) "RU - Tabelas"."Código" WHERE(Tipo = CONST(ExAd))
            ELSE
            IF ("Exam Type" = CONST("Exame Periódico")) "RU - Tabelas"."Código" WHERE(Tipo = CONST(ExP))
            ELSE
            IF ("Exam Type" = CONST("Exame Ocasional")) "RU - Tabelas"."Código" WHERE(Tipo = CONST(ExO))
            ELSE
            IF ("Exam Type" = CONST("Exame Complementar")) "RU - Tabelas"."Código" WHERE(Tipo = CONST(ExC))
            ELSE
            IF ("Exam Type" = CONST("Acções Imunização")) "RU - Tabelas"."Código" WHERE(Tipo = CONST(Vac));

            trigger OnValidate()
            begin
                RUTabelas.Reset;
                if "Exam Type" = "Exam Type"::"Exame Admissão" then
                    RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::ExAd);
                if "Exam Type" = "Exam Type"::"Exame Periódico" then
                    RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::ExP);
                if "Exam Type" = "Exam Type"::"Exame Ocasional" then
                    RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::ExO);
                if "Exam Type" = "Exam Type"::"Exame Complementar" then
                    RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::ExC);
                if "Exam Type" = "Exam Type"::"Acções Imunização" then
                    RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::Vac);
                RUTabelas.SetRange(RUTabelas.Código, Code);
                if RUTabelas.FindFirst then
                    Description := RUTabelas.Descrição
                else
                    Description := '';
            end;
        }
        field(4; Description; Text[250])
        {
            Caption = 'Descrição';
        }
        field(8; Reason; Option)
        {
            Caption = 'Motivo';
            OptionCaption = ' ,Mudança de Posto Trab.,Alterações no Posto Trab.,Regresso ao Trab. após ausência sup. a 30 dias por acidente de trabalho,Regresso ao Trab. após ausência sup. a 30 dias por doença,Iniciativa do médico,Pedido do trabalhador,Por cessação do contrato de trabalho,Outras Razões';
            OptionMembers = " ","Mudança de Posto Trab.","Alterações no Posto Trab.","Regresso ao Trab. após ausência sup. a 30 dias por acidente de trabalho","Regresso ao Trab. após ausência sup. a 30 dias por doença","Iniciativa do médico","Pedido do trabalhador","Por cessação do contrato de trabalho","Outras Razões";
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
        TabVendor: Record Vendor;
}

