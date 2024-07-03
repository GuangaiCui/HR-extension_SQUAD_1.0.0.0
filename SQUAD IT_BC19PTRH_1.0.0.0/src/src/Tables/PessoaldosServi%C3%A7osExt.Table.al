table 53118 "Pessoal dos Serviços Ext"
{

    fields
    {
        field(1; Ano; Code[4])
        {
            Caption = 'Ano';
        }
        field(2; "No. Linha"; Integer)
        {
            Caption = 'Nº Linha';
        }
        field(5; "Tipo Serviço"; Option)
        {
            Caption = 'Tipo de Serviço';
            OptionMembers = "Segurança","Saúde";
        }
        field(6; "Denominação Serv. Externo"; Text[70])
        {
            Caption = 'Denominação do Serviço Externo';
        }
        field(7; NIF; Text[9])
        {
            Caption = 'NIF';
        }
        field(8; "Tipo de Empresa"; Code[20])
        {
            Caption = 'Tipo de Empresa';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(TEmp));

            trigger OnValidate()
            begin

                RUTabelas.Reset;
                RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::TEmp);
                RUTabelas.SetRange(RUTabelas.Código, "Tipo de Empresa");
                if RUTabelas.FindFirst then
                    "Desc. do Tipo de Empresa" := RUTabelas.Descrição
                else
                    "Desc. do Tipo de Empresa" := '';
            end;
        }
        field(9; "Desc. do Tipo de Empresa"; Text[30])
        {
            Caption = 'Desc. do Tipo de Empresa';
        }
    }

    keys
    {
        key(Key1; Ano, "No. Linha")
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

