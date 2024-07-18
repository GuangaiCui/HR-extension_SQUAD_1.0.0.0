table 53115 "Segurança e Saúde no Trabalho"
{
    LookupPageID = "Org. dos Serviços Lista";

    fields
    {
        field(1; Ano; Code[4])
        {
            Caption = 'Ano';
        }
        field(5; "Foram Organizados Serv. Seg. T"; Boolean)
        {
            Caption = 'Foram Organizados os Serviços de Segurança no Trabalho';
        }
        field(6; "Foram Organizados Serv. Sau. T"; Boolean)
        {
            Caption = 'Foram Organizados os Serviços de Saúde no Trabalho';
        }
        field(7; "No. Trabalhadores Afectos"; Integer)
        {
            Caption = 'Nº Trabalhadores Afectos à Organização da Estrutura Interna de 1º Socorros, Combate a Incêndios e Evacuações';
        }
        field(8; "Actividades SST Organizadas"; Option)
        {
            Caption = 'Organização das Actividades de Segurança e Saúde no Trabalho';
            OptionMembers = " ","Em Conjunto","Em Separado";
        }
        field(9; "Seg-Serviço Interno"; Boolean)
        {
            Caption = 'Serviço Interno';
        }
        field(10; "Seg-Serviço Comum/Partilhado"; Boolean)
        {
            Caption = 'Serviço Comum/Partilhado';
        }
        field(11; "Seg-Serviço Externo"; Boolean)
        {
            Caption = 'Serviço Externo';
        }
        field(12; "Seg-Act. Exer. pelo Empregador"; Boolean)
        {
            Caption = 'Actividades Exercidas pelo Empregador';
        }
        field(13; "Seg-Act. Exer. pelo Trabalhado"; Boolean)
        {
            Caption = 'Actividades Exercidas pelo Trabalhador Designado';
        }
        field(14; "Sau-Serviço Interno"; Boolean)
        {
            Caption = 'Serviço Interno';
        }
        field(15; "Sau-Serviço Comum/Partilhado"; Boolean)
        {
            Caption = 'Serviço Comum/Partilhado';
        }
        field(16; "Sau-Serviço Externo"; Boolean)
        {
            Caption = 'Serviço Externo';
        }
        field(17; "Sau-Ser. Nac/Reg de Saúde"; Boolean)
        {
            Caption = 'Serviço Nacional/Regional de Saúde';
        }
        field(18; "Foram Completados os Serv."; Boolean)
        {
            Caption = 'Foram Completados os Serviços Especificados';
        }
        field(30; "Enc. Org.Serv. SST"; Decimal)
        {
            Caption = 'Na Organização dos Serviços de Seg. e Saúde no Trabalho';
        }
        field(31; "Enc. Org./Mod. dos Espaços"; Decimal)
        {
            Caption = 'Na Organização/Modificação dos Espaços de Trabalho';
        }
        field(32; "Enc. Aquisição Bens e Equipame"; Decimal)
        {
            Caption = 'Na Aquisição de Bens e Equipamentos';
        }
        field(33; "Enc. Formação, Inf. e Consulta"; Decimal)
        {
            Caption = 'Na Formação, Informação e Consulta';
        }
        field(34; "Enc. Outros"; Decimal)
        {
            Caption = 'Outros';
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

