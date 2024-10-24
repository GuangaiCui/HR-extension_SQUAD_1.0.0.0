table 53124 "Linhas Acções Médicas"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Employee No."; Code[20])
        {
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
        }
        field(6; Date; Date)
        {
        }
        field(7; Hour; Time)
        {
        }
        field(8; Status; Option)
        {
            OptionMembers = Planeada,Agendada,Realizada,Cancelada;
        }
        field(9; Observations; Text[250])
        {
        }
        field(10; Attachment; BLOB)
        {
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

