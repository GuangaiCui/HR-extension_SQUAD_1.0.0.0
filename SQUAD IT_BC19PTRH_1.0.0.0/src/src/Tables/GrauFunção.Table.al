table 53062 "Grau Função"
{
    DrillDownPageID = "Grau Função";
    LookupPageID = "Grau Função";

    fields
    {
        field(1; "Código"; Code[20])
        {
            Caption = 'Código';
        }
        field(2; "Level 1"; Code[20])
        {
            Caption = 'Nível 1';
        }
        field(3; "Level 2"; Code[20])
        {
            Caption = 'Nível 2';
        }
        field(4; "Level 3"; Code[20])
        {
            Caption = 'Nível 3';
        }
        field(5; Description; Text[200])
        {
            Caption = 'Descrição';
        }
        field(6; "Min Value"; Decimal)
        {
            Caption = 'Valor Mínimo';
        }
        field(7; "Max Value"; Decimal)
        {
            Caption = 'Valor Máximo';
        }
        field(8; "Employees No."; Integer)
        {
            CalcFormula = Count("Grau Função Empregado" WHERE("Cód. Grau Função" = FIELD("Código"),
                                                               "Data Inicio Grau Função" = FIELD("Data Filtro Inicio"),
                                                               "Data Fim Grau Função" = FIELD("Data Filtro Fim")));
            Caption = 'Nº Empregados';
            FieldClass = FlowField;
        }
        field(12; "Data Filtro Inicio"; Date)
        {
            Caption = 'Data Filtro Inicio';
            FieldClass = FlowFilter;
        }
        field(13; "Data Filtro Fim"; Date)
        {
            Caption = 'Data Filtro Fim';
            FieldClass = FlowFilter;
        }
        field(18; "Valor Hora Semanal"; Decimal)
        {
            //Caption = 'Weekly Hours Value';
        }
        field(19; "Cod. Índice"; Integer)
        {
            //Caption = 'Indice Code';
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

