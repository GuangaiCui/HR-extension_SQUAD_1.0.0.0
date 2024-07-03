table 53060 "Categoria Profissional QP"
{
    DrillDownPageID = "Categoria Profissional QP";
    LookupPageID = "Categoria Profissional QP";

    fields
    {
        field(1; "Código"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Descrição"; Text[200])
        {
            Caption = 'Description';
        }
        field(3; "No. Empregados"; Integer)
        {
            CalcFormula = Count("Cat. Prof. QP Empregado" WHERE("Cód. Cat. Prof. QP" = FIELD("Código"),
                                                                 "Data Inicio Cat. Prof." = FIELD("Data Filtro Inicio"),
                                                                 "Data Fim Cat. Prof." = FIELD("Data Filtro Fim")));
            Caption = 'Number of Employess';
            FieldClass = FlowField;
        }
        field(10; "Data Filtro Inicio"; Date)
        {
            Caption = 'Start Date Filter';
            FieldClass = FlowFilter;
        }
        field(11; "Data Filtro Fim"; Date)
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

