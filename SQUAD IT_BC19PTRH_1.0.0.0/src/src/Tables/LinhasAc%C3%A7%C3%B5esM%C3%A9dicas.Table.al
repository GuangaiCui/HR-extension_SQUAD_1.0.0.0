table 31003124 "Linhas Acções Médicas"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Nº Movimento';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Nº Linha';
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Nº Empregado';
            TableRelation = Empregado;

            trigger OnValidate()
            begin
                if TabEmpregado.Get("Employee No.") then
                    Name := TabEmpregado.Name
                else
                    Name := '';
            end;
        }
        field(4; Name; Text[75])
        {
            Caption = 'Nome';
        }
        field(6; Date; Date)
        {
            Caption = 'Data';
        }
        field(7; Hour; Time)
        {
            Caption = 'Hora';
        }
        field(8; Status; Option)
        {
            Caption = 'Estado';
            OptionMembers = Planeada,Agendada,Realizada,Cancelada;
        }
        field(9; Observations; Text[250])
        {
            Caption = 'Observações';
        }
        field(10; Attachment; BLOB)
        {
            Caption = 'Anexo';
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        RUTabelas: Record "RU - Tabelas";
        TabEmpregado: Record Empregado;
}

