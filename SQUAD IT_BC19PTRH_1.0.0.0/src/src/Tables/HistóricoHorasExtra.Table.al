table 53106 "Histórico Horas Extra"
{
    DataCaptionFields = "Employee No.";
    DrillDownPageID = "Lista Histórico Horas Extra";
    LookupPageID = "Lista Histórico Horas Extra";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'No. Mov';
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'No. Empregado';
            TableRelation = Empregado;
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
        field(12; "Payroll Item Code"; Code[20])
        {
            Caption = 'Cód. Rubrica';
            TableRelation = "Payroll Item";
        }
        field(17; Quantity; Decimal)
        {
            Caption = 'Quantidade';
        }
        field(18; Factor; Decimal)
        {
            Caption = 'Factor';
        }
        field(19; "Unit Value"; Decimal)
        {
            Caption = 'Valor Unitário';
        }
        field(25; "Comentário"; Boolean)
        {
            CalcFormula = Exist("Linha Coment. Recurso Humano" WHERE("Table Name" = CONST(HHorEx),
                                                                      "No." = FIELD("Employee No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Cód. Dimensão 1 Global';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(31; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Cód. Dimensão 2 Global';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50; "Processamento Referencia"; Code[10])
        {
            Description = 'Usado na abertura processamento';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Cód. Hora Extra")
        {
            SumIndexFields = Quantity;
        }
        key(Key3; "Cód. Hora Extra", Data)
        {
            SumIndexFields = Quantity;
        }
        key(Key4; "Cód. Hora Extra", "Employee No.", Data)
        {
            SumIndexFields = Quantity;
        }
        key(Key5; "Employee No.", Data)
        {
            SumIndexFields = Quantity;
        }
    }

    fieldgroups
    {
    }
}

