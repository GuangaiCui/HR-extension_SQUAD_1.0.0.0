table 53105 "Histórico Ausências"
{
    Caption = 'Employee Absence';
    DataCaptionFields = "Employee No.";
    DrillDownPageID = "Lista Histórico Ausências";
    LookupPageID = "Lista Histórico Ausências";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'No. Empregado';
            NotBlank = true;
            TableRelation = Empregado;
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'No. Mov.';
        }
        field(3; "From Date"; Date)
        {
            Caption = 'Data Início';
        }
        field(4; "To Date"; Date)
        {
            Caption = 'Data Fim';
        }
        field(5; "Cause of Absence Code"; Code[10])
        {
            Caption = 'Cód. Motivo Ausência';
            TableRelation = "Absence Reason";
        }
        field(6; Description; Text[30])
        {
            Caption = 'Descrição';
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantidade';
            DecimalPlaces = 0 : 5;
        }
        field(8; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Cód. Unidade Medida';
            TableRelation = "Unid. Medida Recursos Humanos";
        }
        field(11; Comment; Boolean)
        {
            CalcFormula = Exist("Linha Coment. Recurso Humano" WHERE("Table Name" = CONST(HAus),
                                                                      "Table Line No." = FIELD("Entry No.")));
            Caption = 'Comentário';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantidade (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(13; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qtd. por Unidade Medida';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(20; Justificada; Boolean)
        {
            //Caption = 'Justify';
        }
        field(21; "Com Perca de Remuneração"; Boolean)
        {
            //Caption = 'With Loss of Pay';
        }
        field(22; "Com Perca Sub. Alimentação"; Boolean)
        {
            //Caption = 'With Loss of Lunch Subsidy';
        }
        field(23; "Qtd. Perca Sub. Alimentação"; Decimal)
        {
            //Caption = 'Loss of Lunch Subsidy Qtd.';
        }
        field(26; "Hora Inicio"; Time)
        {
            //Caption = 'Start Time';
        }
        field(27; "Hora Fim"; Time)
        {
            //Caption = 'End Time';
        }
        field(32; "Payroll Item Code"; Code[20])
        {
            Caption = 'Cód. Rúbrica';
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

