table 53100 "Profissionalização"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'No. Mov';
        }
        field(2; "Data Início"; Date)
        {
            Caption = 'Start Date';
        }
        field(3; "Data Fim"; Date)
        {
            Caption = 'End Date';

            trigger OnValidate()
            begin
                if "Data Fim" < "Data Início" then
                    Error(Text001);
            end;
        }
        field(4; "No. Horas Profissionalização"; Decimal)
        {
            Caption = 'No. of Profissionalization Hours';
        }
        field(5; "Descrição"; Text[50])
        {
            Caption = 'Description';
        }
        field(6; "Cod Empregado"; Code[20])
        {
            Caption = 'Employee Code';
            TableRelation = Empregado."No.";
        }
        field(7; "Classificação"; Decimal)
        {
            Caption = 'Classification';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        "Rec_HorasProfissionalização": Record "Profissionalização";
        Text001: Label 'A data fim não poder ser inferior a data início.';
}

