table 53073 "Horas Extra Empregado"
{
    DataCaptionFields = "Employee No.";
    DrillDownPageID = "Registo Horas Extra";
    LookupPageID = "Registo Horas Extra";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Empregado;
        }
        field(3; Data; Date)
        {
            Caption = 'Date';
        }
        field(6; "Cód. Hora Extra"; Code[20])
        {
            Caption = 'Extra Hour Code';
            TableRelation = "Tipos Horas Extra";

            trigger OnValidate()
            begin
                //HG
                TabHora.Get("Cód. Hora Extra");
                Descrição := TabHora.Descrição;
                "Cód. Rubrica" := TabHora."Cód. Rubrica";
                Factor := TabHora.Factor;
            end;
        }
        field(7; "Descrição"; Text[100])
        {
            Caption = 'Description';
        }
        field(12; "Cód. Rubrica"; Code[20])
        {
            Caption = 'Salary Item code';
            TableRelation = "Rubrica Salarial";
        }
        field(17; Quantity; Decimal)
        {
            Caption = 'Quantidade';
        }
        field(18; Factor; Decimal)
        {
            Caption = 'Factor';
        }
        field(19; "Unit Value"; Decimal)
        {
            Caption = 'Valor Unitário';
        }
        field(25; "Comentário"; Boolean)
        {
            CalcFormula = Exist("Linha Coment. Recurso Humano" WHERE("Table Name" = CONST(HorEx),
                                                                      "Table Line No." = FIELD("Entry No.")));
            Caption = 'Commet';
            Editable = false;
            FieldClass = FlowField;
        }
        field(26; "Hora Extra Bloqueada"; Boolean)
        {
            Caption = 'Extra Hour Bloqued';
            Editable = false;
        }
        field(30; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(31; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //2009.02.26 - quando se apaga uma ausencia temos de apagar os comentários da mesma
        HumanResComment.Reset;
        HumanResComment.SetRange(HumanResComment."Table Name", DATABASE::"Horas Extra Empregado");
        HumanResComment.SetRange(HumanResComment."Table Line No.", "Entry No.");
        if HumanResComment.Find('-') then
            HumanResComment.DeleteAll;

        //2009.02.26 - fim
    end;

    trigger OnInsert()
    begin
        TabHoraExtraEmpregado.SetCurrentKey(TabHoraExtraEmpregado."Entry No.");
        if TabHoraExtraEmpregado.Find('+') then
            "Entry No." := TabHoraExtraEmpregado."Entry No." + 1
        else
            "Entry No." := 1;
    end;

    var
        TabHora: Record "Tipos Horas Extra";
        TabHoraExtraEmpregado: Record "Horas Extra Empregado";
        TabEmpregado: Record Empregado;
        HumanResComment: Record "Linha Coment. Recurso Humano";
        Employee: Record Empregado;
}

