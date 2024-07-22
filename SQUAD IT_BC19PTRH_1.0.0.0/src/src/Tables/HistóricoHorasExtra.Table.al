table 53106 "Histórico Horas Extra"
{
    DataCaptionFields = "No. Empregado";
    DrillDownPageID = "Lista Histórico Horas Extra";
    LookupPageID = "Lista Histórico Horas Extra";

    fields
    {
        field(1; "No. Mov."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "No. Empregado"; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
        }
        field(3; Data; Date)
        {
            Caption = 'Date';
        }
        field(6; "Cód. Hora Extra"; Code[20])
        {
            Caption = 'Extra Hour Code';
            TableRelation = "Tipos Horas Extra";
        }
        field(7; "Descrição"; Text[100])
        {
            Caption = 'Description';
        }
        field(12; "Cód. Rubrica"; Code[20])
        {
            Caption = 'Salary Item code';
            TableRelation = "Rubrica Salarial";
        }
        field(17; Quantidade; Decimal)
        {
            Caption = 'Quantity';
        }
        field(18; Factor; Decimal)
        {
            Caption = 'Factor';
        }
        field(19; "Valor Unitário"; Decimal)
        {
            Caption = 'Unit Value';
        }
        field(25; "Comentário"; Boolean)
        {
            CalcFormula = Exist("Linha Coment. Recurso Humano" WHERE("Table Name" = CONST(HHorEx),
                                                                      "No." = FIELD("No. Empregado")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(31; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50; "Processamento Referencia"; Code[10])
        {
            Description = 'Usado na abertura processamento';
        }
    }

    keys
    {
        key(Key1; "No. Mov.")
        {
            Clustered = true;
        }
        key(Key2; "Cód. Hora Extra")
        {
            SumIndexFields = Quantidade;
        }
        key(Key3; "Cód. Hora Extra", Data)
        {
            SumIndexFields = Quantidade;
        }
        key(Key4; "Cód. Hora Extra", "No. Empregado", Data)
        {
            SumIndexFields = Quantidade;
        }
        key(Key5; "No. Empregado", Data)
        {
            SumIndexFields = Quantidade;
        }
    }

    fieldgroups
    {
    }
}

