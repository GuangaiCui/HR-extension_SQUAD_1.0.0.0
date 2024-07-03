table 31003061 "Cat. Prof. QP Empregado"
{
    DrillDownPageID = "Lista Cat. Prof. Emp. QP";
    LookupPageID = "Lista Cat. Prof. Emp. QP";

    fields
    {
        field(1; "No. Empregado"; Code[20])
        {
            Caption = 'Employee No.';
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
            CalcFormula = Exist ("Linha Coment. Recurso Humano" WHERE ("Table Name" = CONST (CatProfQP),
                                                                      "No." = FIELD ("No. Empregado"),
                                                                      "Table Line No." = FIELD ("No. Linha")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Promotion Reason"; Option)
        {
            Caption = 'Promotion Reason';
            OptionMembers = " ","Por antiguidade","Por mérito",Outras;
        }
        field(12; "Reconversion Date"; Date)
        {
            Caption = 'Convertion Date';
        }
        field(13; "Reconversion Reason"; Text[50])
        {
            Caption = 'Convertion Reason';
        }
        field(14; Reconversion; Boolean)
        {
            Caption = 'Convertion';
        }
    }

    keys
    {
        key(Key1; "No. Empregado", "Cód. Cat. Prof. QP", "No. Linha")
        {
            Clustered = true;
        }
        key(Key2; "No. Empregado", "Data Inicio Cat. Prof.", "Promotion Reason")
        {
        }
        key(Key3; "No. Empregado", "Reconversion Date")
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

