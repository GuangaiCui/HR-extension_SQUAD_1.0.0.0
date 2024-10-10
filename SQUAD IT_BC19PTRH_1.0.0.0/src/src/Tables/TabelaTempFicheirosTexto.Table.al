table 53112 "Tabela Temp Ficheiros Texto"
{
    //  //Tabela usada quando se está a gerar mapasque exportam para txt


    fields
    {
        field(1; "Tipo Ficheiro"; Option)
        {
            OptionCaption = 'MapaSS,PS2,AnexoJ,QP,CGA,DMR-AT,Seguros';
            OptionMembers = MapaSS,PS2,AnexoJ,QP,CGA,"DMR-AT",Seguros;
        }
        field(2; NLinha; Integer)
        {
        }
        field(5; Texto1; Text[250])
        {
        }
        field(6; Texto2; Text[250])
        {
        }
        field(10; Data; Date)
        {
        }
        field(20; "Employee No."; Code[20])
        {
        }
        field(21; "Cod. Situacao"; Code[20])
        {
        }
        field(22; Valor; Decimal)
        {
        }
        field(23; NDias; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Tipo Ficheiro", NLinha)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

