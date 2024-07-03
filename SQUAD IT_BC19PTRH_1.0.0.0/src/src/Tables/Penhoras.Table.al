table 53103 Penhoras
{

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = Empregado;
        }
        field(2; "Garnishmen No."; Code[50])
        {
            Caption = 'Garnishmen No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Garnishment Date"; Date)
        {
            Caption = 'Garnishment Date';
            DataClassification = ToBeClassified;
        }
        field(8; "Garnishment Coefficient"; Option)
        {
            Caption = 'Garnishment Coefficient';
            DataClassification = ToBeClassified;
            OptionCaption = '1/3,1/6';
            OptionMembers = "1/3","1/6";
        }
        field(10; "Garnishment Amount"; Decimal)
        {
            Caption = 'Garnishment Amount';
            DataClassification = ToBeClassified;
        }
        field(11; "Amount Already Garnishment"; Decimal)
        {
            CalcFormula = - Sum("Hist. Linhas Movs. Empregado".Valor WHERE("No. Empregado" = FIELD("Employee No."),
                                                                           "Garnishmen No." = FIELD("Garnishmen No.")));
            Caption = 'Amount Already Garnishment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Garnishment Rubric"; Code[20])
        {
            Caption = 'Garnishment Rubric';
            DataClassification = ToBeClassified;
            TableRelation = "Rubrica Salarial";
        }
        field(16; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Pending,Active,Closed';
            OptionMembers = Pending,Active,Closed;
        }
        field(20; Observation; Text[30])
        {
            Caption = 'Observation';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Garnishmen No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

