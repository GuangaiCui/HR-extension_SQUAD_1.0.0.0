table 53087 "Dispensa Sit - Cargos Empregad"
{
    DataCaptionFields = "Nº Empregado";

    fields
    {
        field(1; "Nº Empregado"; Code[20])
        {
            Caption = 'Nº Empregado';
            TableRelation = Empregado;
        }
        field(2; "N.º Linha"; Integer)
        {
            Caption = 'N.º Linha';
        }
        field(3; "Cód. Dispensa"; Code[10])
        {
            Caption = 'Cód. Dispensa';
        }
        field(4; "Descrição"; Text[100])
        {
            Caption = 'Descrição';
        }
        field(5; "Nº Horas Sem. Contrato"; Integer)
        {
            Caption = 'Nº Horas Sem. Contrato';
        }
        field(6; "Nº Horas Sem. Totais"; Integer)
        {
            Caption = 'Nº Horas Sem. Totais';
        }
        field(10; "Designação Cargo"; Text[64])
        {
            Caption = 'Designação Cargo';
        }
        field(11; "Horas Totais do Cargo"; Integer)
        {
            Caption = 'Horas Totais';
        }
        field(12; "Horas Contrato do Cargo"; Integer)
        {
            Caption = 'Horas do Contrato';
        }
        field(20; Tipo; Option)
        {
            Caption = 'Tipo';
            OptionCaption = 'Dispensa Sit,Cargos';
            OptionMembers = "Dispensa Sit",Cargos;
        }
    }

    keys
    {
        key(Key1; "Nº Empregado", "N.º Linha")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //2009.09.29
        TabDispSitCargos.Reset;
        TabDispSitCargos.SetRange(TabDispSitCargos."Nº Empregado", "Nº Empregado");
        if TabDispSitCargos.FindLast then
            "N.º Linha" := TabDispSitCargos."N.º Linha" + 10000
        else
            "N.º Linha" := 10000;
    end;

    var
        TabDispSitCargos: Record "Dispensa Sit - Cargos Empregad";
}

