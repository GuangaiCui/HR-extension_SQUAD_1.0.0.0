table 31003072 "Tipos Horas Extra"
{
    DrillDownPageID = "Tipos Horas Extra";
    LookupPageID = "Tipos Horas Extra";

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
        field(7; "Cód. Rubrica"; Code[20])
        {
            Caption = 'Salary Item Code';
            TableRelation = "Rubrica Salarial";
        }
        field(12; Factor; Decimal)
        {
            Caption = 'Factor';
        }
        field(15; "Employee No. Filter"; Code[20])
        {
            Caption = 'Employee No. Filter';
            FieldClass = FlowFilter;
            TableRelation = Empregado;
        }
        field(16; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(17; "Total Hora Extra"; Decimal)
        {
            CalcFormula = Sum ("Histórico Horas Extra".Quantidade WHERE ("No. Empregado" = FIELD ("Employee No. Filter"),
                                                                        "Cód. Hora Extra" = FIELD ("Código"),
                                                                        Data = FIELD ("Date Filter")));
            Caption = 'Total Absence (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Dia semanal"; Option)
        {
            Caption = 'Week Day';
            Description = 'HR.02 - BS';
            OptionMembers = " ","Dia útil","Descanso complementar",Feriado,"Descanso obrigatório";
        }
        field(20; "Lei n. 7/2009 de 12 Fevereiro"; Option)
        {
            Description = 'RU';
            OptionCaption = ' ,No. 1 do Artigo 227,No. 2 do Artigo 227';
            OptionMembers = " ","No. 1 do Artigo 227","No. 2 do Artigo 227";
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

