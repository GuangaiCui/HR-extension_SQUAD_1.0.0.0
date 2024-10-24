table 53116 "Pessoal dos Serviços"
{

    fields
    {
        field(1; Ano; Code[4])
        {
            Caption = 'Ano';
        }
        field(5; "Nome Dir/Resp dos Serviços Seg"; Text[70])
        {
            Caption = 'Nome Dir/Resp dos Serviços de Segurança';
        }
        field(6; "Seg. - NIF"; Text[9])
        {
            Caption = 'NIF';
        }
        field(7; "Nome Dir/Resp dos Serviços Saú"; Text[70])
        {
            Caption = 'Nome Dir/Resp dos Serviços de Saúde';
        }
        field(8; "Saúde - NIF"; Text[9])
        {
            Caption = 'NIF';
        }
        field(9; "Employer Name"; Text[70])
        {
        }
        field(10; "Emp. - No. Autorização"; Text[8])
        {
            Caption = 'Nº Autorização';
        }
        field(11; "Nome Trabalhador Designado"; Text[70])
        {
            Caption = 'Nome do Trabalhador Designado';
        }
        field(12; "Trab. - No. Autorização"; Text[8])
        {
            Caption = 'Nº Autorização';
        }
        field(13; "Nome Representante do Emp."; Text[70])
        {
            Caption = 'Nome do Representante do Empregador';
        }
        field(14; "Médicos do Trabalho"; Integer)
        {
            CalcFormula = Count("Pessoal dos Serviços Int" WHERE(Ano = FIELD(Ano),
                                                                  "Tipo de Técnico" = CONST("Médico do Trabalho")));
            Caption = 'Médicos do Trabalho';
            FieldClass = FlowField;
        }
        field(15; Enfermeiros; Integer)
        {
            Caption = 'Enfermeiros';
        }
        field(16; "Técnicos Superiores de SHT"; Integer)
        {
            CalcFormula = Count("Pessoal dos Serviços Int" WHERE(Ano = FIELD(Ano),
                                                                  "Tipo de Técnico" = CONST("Técnico Sup. de SHT")));
            Caption = 'Técnicos Superiores de SHT';
            FieldClass = FlowField;
        }
        field(17; "Técnicos de SHT"; Integer)
        {
            CalcFormula = Count("Pessoal dos Serviços Int" WHERE(Ano = FIELD(Ano),
                                                                  "Tipo de Técnico" = CONST("Técnico de SHT")));
            Caption = 'Técnicos de SHT';
            FieldClass = FlowField;
        }
        field(18; "Outro Pessoal"; Integer)
        {
            Caption = 'Outro Pessoal';
        }
    }

    keys
    {
        key(Key1; Ano)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

