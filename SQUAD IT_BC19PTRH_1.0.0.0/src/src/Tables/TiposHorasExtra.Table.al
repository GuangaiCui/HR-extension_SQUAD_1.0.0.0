table 53072 "Tipos Horas Extra"
{
    DrillDownPageID = "Tipos Horas Extra";
    LookupPageID = "Tipos Horas Extra";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Description"; Text[100])
        {
        }
        field(7; "Payroll Item Code"; Code[20])
        {
            TableRelation = "Payroll Item";
        }
        field(12; Factor; Decimal)
        {
        }
        field(15; "Employee No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Empregado;
        }
        field(16; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(17; "Total Overtime Hours"; Decimal)
        {
            CalcFormula = Sum("Histórico Horas Extra".Quantity WHERE("Employee No." = FIELD("Employee No. Filter"),
                                                                        "Cód. Hora Extra" = FIELD(Code),
                                                                        Data = FIELD("Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Weekly Schedule"; Option)
        {
            Description = 'HR.02 - BS';
            OptionMembers = " ","Business Day","Complementary Rest","Holiday","Mandatory Rest";
        }
        field(20; "Lei n. 7/2009 de 12 Fevereiro"; Option)
        {
            Description = 'RU';
            OptionMembers = " ","No. 1 of Article 227","No. 2 of Article 227";
        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, Description)
        {
        }
    }
}

