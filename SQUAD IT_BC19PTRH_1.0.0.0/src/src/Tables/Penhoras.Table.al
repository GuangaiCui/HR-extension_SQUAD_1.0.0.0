table 53103 Penhoras
{

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'No. Empregado';
            DataClassification = ToBeClassified;
            TableRelation = Empregado;
        }
        field(2; "Garnishmen No."; Code[50])
        {
            Caption = 'No. Penhora';
            DataClassification = ToBeClassified;
        }
        field(5; "Garnishment Date"; Date)
        {
            Caption = 'Data Penhora';
            DataClassification = ToBeClassified;
        }
        field(8; "Garnishment Coefficient"; Option)
        {
            Caption = 'Coeficiente da Penhora';
            DataClassification = ToBeClassified;
            OptionCaption = '1/3,1/6';
            OptionMembers = "1/3","1/6";
        }
        field(10; "Garnishment Amount"; Decimal)
        {
            Caption = 'Valor Penhorar';
            DataClassification = ToBeClassified;
        }
        field(11; "Amount Already Garnishment"; Decimal)
        {
            CalcFormula = - Sum("Hist. Linhas Movs. Empregado".Valor WHERE("Employee No." = FIELD("Employee No."),
                                                                           "Garnishmen No." = FIELD("Garnishmen No.")));
            Caption = 'Valor já Penhorado';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Garnishment Rubric"; Code[20])
        {
            Caption = 'Rubrica Penhora';
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Item";
        }
        field(16; Status; Option)
        {
            Caption = 'Estado';
            DataClassification = ToBeClassified;
            OptionCaption = 'Pending,Active,Closed';
            OptionMembers = Pending,Active,Closed;
        }
        field(20; Observation; Text[30])
        {
            Caption = 'Observações';
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

