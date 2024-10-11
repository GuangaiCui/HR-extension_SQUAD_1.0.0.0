table 53070 "Código IRCT"
{
    DrillDownPageID = "Código IRCT";
    LookupPageID = "Código IRCT";

    fields
    {
        field(1; "Código IRCT"; Code[5])
        {
            //Caption = 'IRCT Code';
        }
        field(2; "Acordo Colectivo"; Code[20])
        {
            //Caption = 'Colective Agreement';
        }
        field(3; "Descrição"; Text[100])
        {
            //Caption = 'Description';
        }
        field(10; "No. Boletim do Trabalho"; Text[2])
        {
            //Caption = 'Work Bulletin No.';
            Description = 'Quadros Pessoal';
        }
        field(11; "Data Publicação"; Date)
        {
            //Caption = 'Publish Date';
            Description = 'Quadros Pessoal';
        }
        field(12; "Data da última Tabela Salarial"; Date)
        {
            //Caption = 'Pay Scales Last Date';
            Description = 'Quadros Pessoal';
        }
    }

    keys
    {
        key(Key1; "Código IRCT")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

