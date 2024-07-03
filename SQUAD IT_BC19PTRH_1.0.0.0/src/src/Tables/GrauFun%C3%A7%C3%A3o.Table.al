table 31003062 "Grau Função"
{
    DrillDownPageID = "Grau Função";
    LookupPageID = "Grau Função";

    fields
    {
        field(1; "Código"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Level 1"; Code[20])
        {
            Caption = 'Level 1';
        }
        field(3; "Level 2"; Code[20])
        {
            Caption = 'Level 2';
        }
        field(4; "Level 3"; Code[20])
        {
            Caption = 'Level 3';
        }
        field(5; Description; Text[200])
        {
            Caption = 'Description';
        }
        field(6; "Min Value"; Decimal)
        {
            Caption = 'Min. Value';
        }
        field(7; "Max Value"; Decimal)
        {
            Caption = 'Max value';
        }
        field(8; "Employees No."; Integer)
        {
            CalcFormula = Count ("Grau Função Empregado" WHERE ("Cód. Grau Função" = FIELD ("Código"),
                                                               "Data Inicio Grau Função" = FIELD ("Data Filtro Inicio"),
                                                               "Data Fim Grau Função" = FIELD ("Data Filtro Fim")));
            Caption = 'Number of Employees';
            FieldClass = FlowField;
        }
        field(12; "Data Filtro Inicio"; Date)
        {
            Caption = 'Begin Date Filter';
            FieldClass = FlowFilter;
        }
        field(13; "Data Filtro Fim"; Date)
        {
            Caption = 'End Date Filter';
            FieldClass = FlowFilter;
        }
        field(18; "Valor Hora Semanal"; Decimal)
        {
            Caption = 'Weekly Hours Value';
        }
        field(19; "Cod. Índice"; Integer)
        {
            Caption = 'Indice Code';
        }
    }

    keys
    {
        key(Key1; "Código")
        {
            Clustered = true;
        }
        key(Key2; "Min Value")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Código", Description)
        {
        }
    }
}

