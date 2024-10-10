table 53120 "Acções de Inf. Cons. For"
{

    fields
    {
        field(1; "No. Mov"; Integer)
        {
            AutoIncrement = true;
            Caption = 'No. Mov';
        }
        field(5; "Data da Acção"; Date)
        {
            Caption = 'Data da Acção';
        }
        field(6; "Tipo de Acção"; Option)
        {
            Caption = 'Tipo de Acção';
            OptionCaption = 'Informação,Consulta,Formação';
            OptionMembers = "Informação",Consulta,"Formação";

            trigger OnValidate()
            begin
                Validate(Code, '');
            end;
        }
        field(7; "Code"; Code[20])
        {
            Caption = 'Código';
            TableRelation = IF ("Tipo de Acção" = CONST("Informação")) "RU - Tabelas"."Código" WHERE(Tipo = CONST(AcInf))
            ELSE
            IF ("Tipo de Acção" = CONST(Consulta)) "RU - Tabelas"."Código" WHERE(Tipo = CONST(AcCon))
            ELSE
            IF ("Tipo de Acção" = CONST("Formação")) "RU - Tabelas"."Código" WHERE(Tipo = CONST(AcFor));

            trigger OnValidate()
            begin

                RUTabelas.Reset;
                if "Tipo de Acção" = "Tipo de Acção"::"Informação" then
                    RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::AcInf);
                if "Tipo de Acção" = "Tipo de Acção"::Consulta then
                    RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::AcCon);
                if "Tipo de Acção" = "Tipo de Acção"::"Formação" then
                    RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::AcFor);

                RUTabelas.SetRange(RUTabelas.Código, Code);
                if RUTabelas.FindFirst then
                    Descrição := RUTabelas.Descrição
                else
                    Descrição := '';
            end;
        }
        field(8; "Descrição"; Text[250])
        {
            Caption = 'Descrição';
        }
        field(9; "No. Acções Realizadas"; Integer)
        {
            Caption = 'Nº de Acções Realizadas';
        }
        field(10; "No. Participantes Homens"; Integer)
        {
            Caption = 'Nº de Participantes Homens';
        }
        field(11; "No. Participantes Mulheres"; Integer)
        {
            Caption = 'Nº de Participantes Mulheres';
        }
    }

    keys
    {
        key(Key1; "No. Mov")
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

