table 53064 "Habilitação"
{
    DrillDownPageID = "Habilitação";
    LookupPageID = "Habilitação";

    fields
    {
        field(1; "Código"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Descrição"; Text[200])
        {
            Caption = 'Description';
        }
        field(3; "Nível"; Option)
        {
            Caption = 'Level';
            Description = 'RU';
            OptionCaption = 'Inferior ao 1º Ciclo,1º Ciclo,2º Ciclo,3º Ciclo,Ensino Secundário,Ensino Pós Secundário Não Superior Nível IV,Bacharelato,Licenciatura,Mestrado,Doutoramento,Técnico Superior Profissional';
            OptionMembers = "Inf 1Ciclo","1Ciclo","2Ciclo","3Ciclo",Sec,PosSec,Barc,Lic,Mes,Dou,TecSupPro;
        }
    }

    keys
    {
        key(Key1; "Código")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Código", "Descrição")
        {
        }
    }
}

