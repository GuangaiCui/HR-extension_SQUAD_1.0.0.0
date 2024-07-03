table 53102 RU
{

    fields
    {
        field(1; Ano; Code[4])
        {
            Caption = 'Primary Key';
        }
        field(2; "Valor Acrescentado Bruto (VAB)"; Decimal)
        {
        }
        field(3; "Custos com Pessoal"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(4; "Amortizações do Exercício"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(5; "Provisões do Exercício"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(6; "Custos e Perdas Financeiras"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(7; "Imposto sobre Rendimento"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(8; "Resultado Líquido do Exercício"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(10; "Enc. Adm. Subsídio por Doença"; Decimal)
        {
            Caption = 'Subsídio por Doença e Doença Profissional';
        }
        field(11; "Origem Enc. A- Subsídio Doen"; Code[20])
        {
            Caption = 'Código referente à Origem do Encargo';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(OriEnc));
        }
        field(12; "Enc. Adm. Pensões Velhice"; Decimal)
        {
            Caption = 'Pensões de Velhice, de Invalidez e de Sobrevivênvia';
        }
        field(13; "Origem Enc. A- Pensões Velhice"; Code[20])
        {
            Caption = 'Código referente à Origem do Encargo';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(OriEnc));
        }
        field(14; "Enc. Adm. Outras Prestações"; Decimal)
        {
            Caption = 'Outras Prestações de Segurança Social';
        }
        field(15; "Origem Enc. A- Outras Prestaç"; Code[20])
        {
            Caption = 'Código referente à Origem do Encargo';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(OriEnc));
        }
        field(16; "Enc. não Adm. Subsídio por Doe"; Decimal)
        {
            Caption = 'Subsídio por Doença e Doença Profissional';
        }
        field(17; "Origem Enc. NA- Subsídio Doen"; Code[20])
        {
            Caption = 'Código referente à Origem do Encargo';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(OriEnc));
        }
        field(18; "Enc. não Adm. Pensões Velhice"; Decimal)
        {
            Caption = 'Pensões de Velhice, de Invalidez e de Sobrevivênvia';
        }
        field(19; "Origem Enc. NA- Pensões Velhic"; Code[20])
        {
            Caption = 'Código referente à Origem do Encargo';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(OriEnc));
        }
        field(20; "Enc. não Adm. Outras Prestaç"; Decimal)
        {
            Caption = 'Outras Prestações de Segurança Social';
        }
        field(21; "Origem Enc. NA- Outras Prestaç"; Code[20])
        {
            Caption = 'Código referente à Origem do Encargo';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(OriEnc));
        }
        field(22; "Enc. de Acção e Apoio Social"; Decimal)
        {
            Caption = 'Encargos de Acção e Apoio Social';
        }
        field(31; "ForProf. Mont. Horas Form."; Decimal)
        {
            Caption = 'Montante correspondente à remuneração Horas Formação';
        }
        field(32; "ForProf. Restanre Financia."; Decimal)
        {
            Caption = 'Restante financiamento da entidade empregadora';
        }
        field(34; "ForProf. Fundo Social Europeu"; Decimal)
        {
            Caption = 'Do Fundo Social Europeu';
        }
        field(35; "ForProf. Outras Fontes Finan."; Decimal)
        {
            Caption = 'De outras fontes de financiamento';
        }
        field(41; "Trab. Suplementar visado"; Boolean)
        {
            Caption = 'O Trabalho Suplementar ao abrigo do art. 227 da Lei 7/2009, foi visado pela comissão de trabalhadores ou sindicato?';
        }
        field(50; "Núm. Trab. Temp 31 Out"; Integer)
        {
            Caption = 'Número Trabalhadores temporários em 31 Outubro';
        }
        field(51; "Núm. Trab. Temp 31 Dez"; Integer)
        {
            Caption = 'Número Trabalhadores temporários em 31 Dezembro';
        }
        field(52; "Núm. Trab. Médio durante ano"; Integer)
        {
            Caption = 'Número médio durante o ano';
        }
        field(53; "Entradas durante ano - H"; Integer)
        {
            Caption = 'Entradas durante ano - Homens';
        }
        field(54; "Entradas durante ano - M"; Integer)
        {
            Caption = 'Entradas durante ano - Mulheres';
        }
        field(55; "Saídas durante ano - H"; Integer)
        {
            Caption = 'Saídas durante ano - Homens';
        }
        field(56; "Saídas durante ano - M"; Integer)
        {
            Caption = 'Saídas durante ano - Mulheres';
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

