table 53038 "Qualificação Empregado"
{
    Caption = 'Employee Qualification';
    DataCaptionFields = "Employee No.";
    DrillDownPageID = "Empregados Qualificados";
    LookupPageID = "Qualificações Empregado";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Empregado;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Qualification Code"; Code[10])
        {
            Caption = 'Qualification Code';
            TableRelation = "Qualificação";

            trigger OnValidate()
            begin
                Qualification.Get("Qualification Code");
                Description := Qualification.Description;
            end;
        }
        field(4; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(5; "To Date"; Date)
        {
            Caption = 'To Date';
        }
        field(6; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Habilitações Académicas,Qualificações Profissionais,,,,,,,Qualificações RU';
            OptionMembers = " ","Habilitações Académicas","Qualificações Profissionais",,,,,,,"Qualificações RU";
        }
        field(7; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(8; "Institution/Company"; Text[128])
        {
            Caption = 'Institution/Company';
        }
        field(9; Cost; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost';
        }
        field(10; "Course Grade"; Text[30])
        {
            Caption = 'Course Grade';
        }
        field(11; "Employee Status"; Option)
        {
            Caption = 'Employee Status';
            Editable = false;
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active,Inactive,Terminated;
        }
        field(12; Comment; Boolean)
        {
            CalcFormula = Exist("Linha Coment. Recurso Humano" WHERE("Table Name" = CONST(Qual),
                                                                      "No." = FIELD("Employee No."),
                                                                      "Table Line No." = FIELD("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(14; "Internal Qualification"; Option)
        {
            Caption = 'Internal Qualification';
            Description = 'RU';
            OptionCaption = ' ,Quadros Superiores,Quadros Médios,Encarregados/contramestres/mestres/chefes de equipa,Prof. altamente qualificados,Prof. qualificados,Prof. semi-qualificado,Prof. não qualificado,Estagiários/Praticantes/Aprendizes';
            OptionMembers = " ","1","2","3","4","5","6","7","8";
        }
        field(15; "Academic Degree"; Option)
        {
            Caption = 'Degree';
            OptionCaption = ' ,Licenciatura,Bacharelato,Pós-graduação,Mestrado,Doutoramento,Diploma de Estudos Superiores Especializados,Magistério Primário/Educadores de Infância,Secundário,Básico (3.º ciclo),Básico (2.º ciclo),Básico (1.º ciclo),Sem Habilitação,Outra';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10","11","12","99";
        }
        field(16; "University Code"; Code[4])
        {
            Caption = 'Cód. Universidade-Faculdade';
            Description = 'MISI';
        }
        field(17; "Course Code"; Code[4])
        {
            Caption = 'Código Curso';
            Description = 'MISI';
        }
        field(18; "Course Description"; Text[128])
        {
            Caption = 'Descrição Curso';
            Description = 'MISI';
        }
        field(19; "Final Course Classification"; Text[32])
        {
            Caption = 'Classificação Final Curso';
            Description = 'MISI';
        }
    }

    keys
    {
        key(Key1; "Employee No.", Type, "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Qualification Code")
        {
        }
        key(Key3; "Employee No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Comment then
            Error(Text000);
    end;

    trigger OnInsert()
    begin
        Employee.Get("Employee No.");
        "Employee Status" := Employee.Status;
    end;

    var
        Text000: Label 'You cannot delete employee qualification information if there are comments associated with it.';
        Qualification: Record "Qualificação";
        Employee: Record Empregado;
}

