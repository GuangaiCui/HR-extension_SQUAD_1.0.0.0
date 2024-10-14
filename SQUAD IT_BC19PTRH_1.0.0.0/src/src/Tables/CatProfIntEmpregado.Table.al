table 53059 "Cat. Prof. Int. Empregado"
{
    DrillDownPageID = "Lista Cat. Prof. Int. Emp.";
    LookupPageID = "Lista Cat. Prof. Int. Emp.";

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
        field(3; "Cód. Cat. Prof."; Code[20])
        {
            Caption = 'Prof. Cat. Code';
            TableRelation = "Categoria Profissional Interna"."Código";

            trigger OnValidate()
            begin
                TabCatProf.Get("Cód. Cat. Prof.");
                Descrição := TabCatProf.Descrição;
            end;
        }
        field(4; "Descrição"; Text[100])
        {
            Caption = 'Description';
        }
        field(5; "Data Inicio Cat. Prof."; Date)
        {
            Caption = 'Prof. Cat. Start Date';
        }
        field(6; "Data Fim Cat. Prof."; Date)
        {
            // Caption = 'Prof. Cat. End Date';
        }
        field(10; "Comentário"; Boolean)
        {
            CalcFormula = Exist("Linha Coment. Recurso Humano" WHERE("Table Name" = CONST(CatProf),
                                                                      "No." = FIELD("Employee No."),
                                                                      "Table Line No." = FIELD("No. Linha")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Cód. Cat. Prof.", "No. Linha")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*
        //Perguntar ao utilizador se quer actualizar na tabela empregado  com o novo registo
        
        TabEmpregado.GET("Nº Empregado");
        IF "Cód. Cat. Prof." <> TabEmpregado."Cód. Cat. Profissional" THEN BEGIN
           Pergunta := 'Quer actualizar o Contrato na Ficha do empregado de ' + FORMAT(TabEmpregado."Cód. Cat. Profissional")
                       + ' para ' +  FORMAT("Cód. Cat. Prof.") + ' ?';
           IF CONFIRM(Pergunta) THEN BEGIN
              TabEmpregado.VALIDATE(TabEmpregado."Cód. Cat. Profissional","Cód. Cat. Prof.");
              TabEmpregado.MODIFY;
           END;
        END;
         */

    end;

    var
        TabCatProf: Record "Categoria Profissional Interna";
        TabEmpregado: Record Empregado;
        Pergunta: Text[200];
}

