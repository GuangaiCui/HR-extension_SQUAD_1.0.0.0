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
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Qualified Employees"; Integer)
        {
            CalcFormula = Count("Qualificação Empregado" WHERE("Qualification Code" = FIELD(Code),
                                                                "From Date" = FIELD("Initial Filter Date"),
                                                                "To Date" = FIELD("End Filter Date")));
            Caption = 'Qualified Employees';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Initial Filter Date"; Date)
        {
            Caption = 'Start Date Filter';
            FieldClass = FlowFilter;
        }
        field(11; "End Filter Date"; Date)
        {
            Caption = 'End Date Filter';
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

