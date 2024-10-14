table 53037 "Qualificação"
{
    Caption = 'Qualification';
    DataCaptionFields = "Code", Description;
    DrillDownPageID = "Qualificações";
    LookupPageID = "Qualificações";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Código';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Descrição';
        }
        field(3; "Qualified Employees"; Integer)
        {
            CalcFormula = Count("Qualificação Empregado" WHERE("Qualification Code" = FIELD(Code),
                                                                "From Date" = FIELD("Initial Filter Date"),
                                                                "To Date" = FIELD("End Filter Date")));
            Caption = 'Empregado Qualificados';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Initial Filter Date"; Date)
        {
            Caption = 'Data Filtro Inicio';
            FieldClass = FlowFilter;
        }
        field(11; "End Filter Date"; Date)
        {
            Caption = 'Data Filtro Fim';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description)
        {
        }
    }
}

