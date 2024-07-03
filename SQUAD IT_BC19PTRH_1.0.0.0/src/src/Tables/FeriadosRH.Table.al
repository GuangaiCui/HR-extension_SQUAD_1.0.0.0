table 31003085 "Feriados RH"
{
    Description = 'Lista de Feriados Fixos e Variáveis para RH';

    fields
    {
        field(1; Chave; Integer)
        {
            Caption = 'Key';
            Editable = false;
        }
        field(2; Data; Date)
        {
            Caption = 'Date';
        }
        field(5; "Descritivo feriado"; Text[30])
        {
            Caption = 'Holiday Description';
        }
        field(7; Nacional; Boolean)
        {
            Caption = 'Nacional';
        }
        field(10; Estabelecimento; Code[4])
        {
            Caption = 'Office';
            TableRelation = "Estabelecimentos da Empresa"."Número da Unidade Local";
        }
    }

    keys
    {
        key(Key1; Chave)
        {
            Clustered = true;
        }
        key(Key2; Data)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin


        Fer.SetCurrentKey(Chave);
        if Fer.Find('+') then
            Chave := Fer.Chave + 1
        else
            Chave := 1;
    end;

    var
        Fer: Record "Feriados RH";
}

