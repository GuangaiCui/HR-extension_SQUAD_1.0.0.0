table 31003105 "Histórico Ausências"
{
    Caption = 'Employee Absence';
    DataCaptionFields = "Employee No.";
    DrillDownPageID = "Lista Histórico Ausências";
    LookupPageID = "Lista Histórico Ausências";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Empregado;
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(4; "To Date"; Date)
        {
            Caption = 'To Date';
        }
        field(5; "Cause of Absence Code"; Code[10])
        {
            Caption = 'Cause of Absence Code';
            TableRelation = "Absence Reason";
        }
        field(6; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(8; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Unid. Medida Recursos Humanos";
        }
        field(11; Comment; Boolean)
        {
            CalcFormula = Exist ("Linha Coment. Recurso Humano" WHERE ("Table Name" = CONST (HAus),
                                                                      "Table Line No." = FIELD ("Entry No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(13; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(20; Justificada; Boolean)
        {
            Caption = 'Justify';
        }
        field(21; "Com Perca de Remuneração"; Boolean)
        {
            Caption = 'With Loss of Pay';
        }
        field(22; "Com Perca Sub. Alimentação"; Boolean)
        {
            Caption = 'With Loss of Lunch Subsidy';
        }
        field(23; "Qtd. Perca Sub. Alimentação"; Decimal)
        {
            Caption = 'Loss of Lunch Subsidy Qtd.';
        }
        field(26; "Hora Inicio"; Time)
        {
            Caption = 'Start Time';
        }
        field(27; "Hora Fim"; Time)
        {
            Caption = 'End Time';
        }
        field(32; "Cód. Rubrica"; Code[20])
        {
            Caption = 'Salary Item Code';
        }
        field(42; "Influência No. dias férias"; Boolean)
        {
            Caption = 'Influence the No. of Vacation Days';
            Description = 'Util para o mapa de férias';
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
        key(Key2; "Employee No.", "From Date")
        {
            SumIndexFields = Quantity, "Quantity (Base)";
        }
        key(Key3; "Employee No.", "Cause of Absence Code", "From Date")
        {
            SumIndexFields = Quantity, "Quantity (Base)";
        }
        key(Key4; "Cause of Absence Code", "From Date")
        {
            SumIndexFields = Quantity, "Quantity (Base)";
        }
        key(Key5; "From Date", "To Date")
        {
        }
    }

    fieldgroups
    {
    }
}

