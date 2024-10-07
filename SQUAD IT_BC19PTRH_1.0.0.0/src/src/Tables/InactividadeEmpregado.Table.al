table 53057 "Inactividade Empregado"
{
    DataCaptionFields = "No. Empregado";

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
        field(3; "Cód. Inactividade"; Code[10])
        {
            Caption = 'Inactivity Code';
            TableRelation = "Motivo Inactividade";

            trigger OnValidate()
            begin
                TabMotivoInatividade.Get("Cód. Inactividade");
                Descrição := TabMotivoInatividade.Description
            end;
        }
        field(4; "Descrição"; Text[30])
        {
            Caption = 'Description';
        }
        field(5; "Data Inicio Inactividade"; Date)
        {
            Caption = 'Inactivity Begin Date';
        }
        field(6; "Data Fim Inactividade"; Date)
        {
            Caption = 'Inactivity End Date';
        }
        field(7; "Comentário"; Boolean)
        {
            CalcFormula = Exist("Linha Coment. Recurso Humano" WHERE("Table Name" = CONST(Inac),
                                                                      "No." = FIELD("No. Empregado"),
                                                                      "Table Line No." = FIELD("No. Linha")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No. Empregado", "No. Linha")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
    }

    var
        TabMotivoInatividade: Record "Motivo Inactividade";
}

