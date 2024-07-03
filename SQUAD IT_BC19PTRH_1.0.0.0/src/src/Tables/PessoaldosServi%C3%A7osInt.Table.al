table 31003117 "Pessoal dos Serviços Int"
{
    DrillDownPageID = "Pessoal dos Serviços Internos";

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
        field(3; "Tipo de Técnico"; Option)
        {
            Caption = 'Tipo de Técnico';
            OptionCaption = 'Médico do Trabalho,Técnico de SHT,Técnico Sup. de SHT';
            OptionMembers = "Médico do Trabalho","Técnico de SHT","Técnico Sup. de SHT";
        }
        field(5; Nome; Text[70])
        {
            Caption = 'Nome';
        }
        field(6; "No. da Cédula Profissional"; Text[5])
        {
            Caption = 'Nº da Cédula Profissional';
        }
        field(7; "No. de Horas Mensais Afectação"; Decimal)
        {
            Caption = 'Nº de Horas Mensais de Afectação';
        }
        field(8; "No. Certificado Aptidão Prof."; Text[11])
        {
            Caption = 'Nº Certificado de Aptidão Profissional';
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
}

