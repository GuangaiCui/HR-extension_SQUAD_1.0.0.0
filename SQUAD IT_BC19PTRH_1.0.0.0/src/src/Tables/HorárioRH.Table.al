table 53065 "Horário RH"
{
    DrillDownPageID = "Horário RH";
    LookupPageID = "Horário RH";

    fields
    {
        field(1; "Código"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Descrição"; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Hora Entrada"; Time)
        {
            Caption = 'Start Period';
        }
        field(4; "Hora Saída"; Time)
        {
            Caption = 'End Period';
        }
        field(5; "Hora Início Almoço"; Time)
        {
            Caption = 'Lunch Start Period';
        }
        field(6; "Hora Fim Almoço"; Time)
        {
            Caption = 'Lunch End Period';
        }
        field(10; "No. Horas Diárias"; Decimal)
        {
            Caption = 'No. of Daily Hours';
        }
        field(11; "No. Horas Semanais"; Decimal)
        {
            Caption = 'No. of Week Hours';
        }
        field(12; "No. Horas Mensais"; Decimal)
        {
            Caption = 'No. of Month Hours';
        }
        field(13; "Data Filtro Inicio"; Date)
        {
            Caption = 'Start Date Filter';
            FieldClass = FlowFilter;
        }
        field(14; "Data Filtro Fim"; Date)
        {
            Caption = 'End Date Filter';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; "Código")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Código", "Descrição")
        {
        }
    }
}

