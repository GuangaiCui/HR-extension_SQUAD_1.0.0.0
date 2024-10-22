table 53112 "Tabela Temp Ficheiros Texto"
{
    //  //Tabela usada quando se está a gerar mapasque exportam para txt


    fields
    {
        field(1; "File Type"; Option)
        {
            //OptionCaption = 'MapaSS,PS2,AnexoJ,QP,CGA,DMR-AT,Seguros';
            //TODO: doubts on the translation of options
            OptionMembers = MapaSS,PS2,AnexoJ,QP,CGA,"DMR-AT",Seguros;
        }
        field(2; "Line No."; Integer)
        {
        }
        field(5; Texto1; Text[250])
        {
        }
        field(6; Texto2; Text[250])
        {
        }
        field(10; Date; Date)
        {
        }
        field(20; "Employee No."; Code[20])
        {
        }
        field(21; "Situation Code"; Code[20])
        {
        }
        field(22; Amount; Decimal)
        {
        }
        field(23; "No. of Days"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "File Type", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

