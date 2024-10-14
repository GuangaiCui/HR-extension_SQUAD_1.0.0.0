table 53061 "Cat. Prof. QP Empregado"
{
    DrillDownPageID = "Lista Cat. Prof. Emp. QP";
    LookupPageID = "Lista Cat. Prof. Emp. QP";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'No. Empregado';
            TableRelation = Empregado;
        }
        field(2; "No. Linha"; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Cód. Cat. Prof. QP"; Code[20])
        {
            Caption = 'QP Prof. Cat. Code';
            TableRelation = "Categoria Profissional QP";

            trigger OnValidate()
            begin
                TabCatProfQPEmp.Get("Cód. Cat. Prof. QP");
                Description := TabCatProfQPEmp.Descrição;
            end;
        }
        field(4; Description; Text[200])
        {
            Caption = 'Description';
        }
        field(5; "Data Inicio Cat. Prof."; Date)
        {
            Caption = 'Prof. Cat. Start Date';
        }
        field(6; "Data Fim Cat. Prof."; Date)
        {
            Caption = 'Prof. Cat. End Date';
        }
        field(10; Comment; Boolean)
        {
            CalcFormula = Exist("Linha Coment. Recurso Humano" WHERE("Table Name" = CONST(CatProfQP),
                                                                      "No." = FIELD("Employee No."),
                                                                      "Table Line No." = FIELD("No. Linha")));
            Caption = 'Comentário';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Promotion Reason"; Option)
        {
            Caption = 'Motivo de Promoção';
            OptionMembers = " ","Por antiguidade","Por mérito",Outras;
        }
        field(12; "Reconversion Date"; Date)
        {
            Caption = 'Data de Reconversão';
        }
        field(13; "Reconversion Reason"; Text[50])
        {
            Caption = 'Motivo de Reconversão';
        }
        field(14; Reconversion; Boolean)
        {
            Caption = 'Reconversão';
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Cód. Cat. Prof. QP", "No. Linha")
        {
            Clustered = true;
        }
        key(Key2; "Employee No.", "Data Inicio Cat. Prof.", "Promotion Reason")
        {
        }
        key(Key3; "Employee No.", "Reconversion Date")
        {
        }
    }

    fieldgroups
    {
    }

    var
        TabCatProfQPEmp: Record "Categoria Profissional QP";
        TabEmpregado: Record Empregado;
        Pergunta: Text[200];
}

