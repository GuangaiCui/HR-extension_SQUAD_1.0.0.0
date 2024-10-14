table 53063 "Grau Função Empregado"
{
    DataCaptionFields = "Employee No.";
    DrillDownPageID = "Lista Grau Função Empregado";
    LookupPageID = "Lista Grau Função Empregado";

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
        field(3; "Cód. Grau Função"; Code[20])
        {
            Caption = 'Job Degree Code';
            TableRelation = "Grau Função";

            trigger OnValidate()
            begin
                TabGrauFuncao.Get("Cód. Grau Função");
                Descrição := TabGrauFuncao.Description;
            end;
        }
        field(4; "Descrição"; Text[200])
        {
            Caption = 'Description';
        }
        field(5; "Data Inicio Grau Função"; Date)
        {
            Caption = 'Job Degree Start Date';
        }
        field(6; "Data Fim Grau Função"; Date)
        {
            Caption = 'Job Degree End Date';
        }
        field(7; "Comentário"; Boolean)
        {
            CalcFormula = Exist("Linha Coment. Recurso Humano" WHERE("Table Name" = CONST(Grau),
                                                                      "No." = FIELD("Employee No."),
                                                                      "Table Line No." = FIELD("No. Linha")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Cód. Grau Função", "No. Linha")
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
        IF "Cód. Grau Função" <> TabEmpregado."Grau Função" THEN BEGIN
           Pergunta := 'Quer actualizar o Contrato na Ficha do empregado de ' + FORMAT(TabEmpregado."Grau Função")
                       + ' para ' +  FORMAT("Cód. Grau Função") + ' ?';
           IF CONFIRM(Pergunta) THEN BEGIN
              TabEmpregado.VALIDATE(TabEmpregado."Grau Função","Cód. Grau Função");
              TabEmpregado.MODIFY;
           END;
        END;
        */

    end;

    var
        TabGrauFuncao: Record "Grau Função";
        TabEmpregado: Record Empregado;
        Pergunta: Text[200];
}

