table 31003042 "Ausência Empregado"
{
    //  //CPA - novo campo "Novo Valor Ausencia"

    Caption = 'Employee Absence';
    DataCaptionFields = "Employee No.";
    DrillDownPageID = "Ausências Empregado";
    LookupPageID = "Ausências Empregado";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Empregado;

            trigger OnValidate()
            begin
                Employee.Get("Employee No.");
            end;
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "From Date"; Date)
        {
            Caption = 'From Date';

            trigger OnValidate()
            begin
                //Validação
                AuxString := Text0001 + FieldCaption("From Date");
                if ("From Date" <> 0D) and ("To Date" <> 0D) and ("To Date" < "From Date") then
                    EmployeeAbsence.FieldError("To Date", AuxString);
            end;
        }
        field(4; "To Date"; Date)
        {
            Caption = 'To Date';

            trigger OnValidate()
            begin
                //Validação
                AuxString := Text0001 + FieldCaption("From Date");
                if ("From Date" <> 0D) and ("To Date" <> 0D) and ("To Date" < "From Date") then
                    EmployeeAbsence.FieldError("To Date", AuxString);
            end;
        }
        field(5; "Cause of Absence Code"; Code[10])
        {
            Caption = 'Cause of Absence Code';
            TableRelation = "Absence Reason";

            trigger OnValidate()
            begin
                CauseOfAbsence.Get("Cause of Absence Code");
                Description := CauseOfAbsence.Description;
                Validate("Unit of Measure Code", CauseOfAbsence."Unit of Measure Code");

                //HG
                Justificada := CauseOfAbsence.Justified;
                "Com Perda de Remuneração" := CauseOfAbsence."Remuneration Loss";
                "Com Perda Sub. Alimentação" := CauseOfAbsence."Food Subsidy Loss";
                "Cód. Rubrica" := CauseOfAbsence."Rubric Code";
                "Influência Nº dias férias" := CauseOfAbsence."Vacation Days Influence";
            end;
        }
        field(6; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                "Quantity (Base)" := CalcBaseQty(Quantity);
                "Quantidade Pendente" := "Quantity (Base)";

                //Prenche automaticamente a Qtd de perca de sub. Alimentação
                if "Com Perda Sub. Alimentação" = true then
                    "Qtd. Perda Sub. Alimentação" := Round("Quantity (Base)", 1, '=');
            end;
        }
        field(8; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Unid. Medida Recursos Humanos";

            trigger OnValidate()
            begin
                if HumanResUnitOfMeasure.Get("Unit of Measure Code") then;
                "Qty. per Unit of Measure" := HumanResUnitOfMeasure."Qty. per Unit of Measure";
                Validate(Quantity);
            end;
        }
        field(11; Comment; Boolean)
        {
            CalcFormula = Exist ("Linha Coment. Recurso Humano" WHERE ("Table Name" = CONST (Aus),
                                                                      "Table Line No." = FIELD ("Entry No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestField("Qty. per Unit of Measure", 1);
                Validate(Quantity, "Quantity (Base)");
            end;
        }
        field(13; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(20; Justificada; Boolean)
        {
            Caption = 'Justify';
        }
        field(21; "Com Perda de Remuneração"; Boolean)
        {
            Caption = 'With Loss of Pay';
        }
        field(22; "Com Perda Sub. Alimentação"; Boolean)
        {
            Caption = 'With Loss of Lunch Subsidy';
        }
        field(23; "Qtd. Perda Sub. Alimentação"; Decimal)
        {
            Caption = 'Loss of Lunch Subsidy Qtd.';
        }
        field(26; "Hora Inicio"; Time)
        {
            Caption = 'Start Time';
        }
        field(27; "Hora Fim"; Time)
        {
            Caption = 'End Time';
        }
        field(32; "Cód. Rubrica"; Code[20])
        {
            Caption = 'Salary Item Code';
            TableRelation = "Rubrica Salarial";
        }
        field(36; "Quantidade Pendente"; Decimal)
        {
            Caption = 'Outstanding Qty.';
        }
        field(39; "Ausência Bloqueada"; Boolean)
        {
            Caption = 'Absence Locked';
            Editable = false;
        }
        field(42; "Influência Nº dias férias"; Boolean)
        {
            Caption = 'Influence the No. of Vacation Days';
            Description = 'Util para o mapa de férias';
        }
        field(43; "Novo Valor Ausencia"; Decimal)
        {
            Caption = 'Novo Valor Ausência';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Employee No.", "From Date")
        {
            SumIndexFields = Quantity, "Quantity (Base)";
        }
        key(Key3; "Employee No.", "Cause of Absence Code", "From Date")
        {
            SumIndexFields = Quantity, "Quantity (Base)";
        }
        key(Key4; "Cause of Absence Code", "From Date")
        {
            SumIndexFields = Quantity, "Quantity (Base)";
        }
        key(Key5; "From Date", "To Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //2009.02.26 - quando se apaga uma ausencia temos de apagar os comentários da mesma
        HumanResComment.Reset;
        HumanResComment.SetRange(HumanResComment."Table Name", DATABASE::"Ausência Empregado");
        HumanResComment.SetRange(HumanResComment."Table Line No.", "Entry No.");
        if HumanResComment.Find('-') then
            HumanResComment.DeleteAll;

        //2009.02.26 - fim
    end;

    trigger OnInsert()
    begin
        EmployeeAbsence.SetCurrentKey("Entry No.");

        //2009.03.03 - descomentei esta parte e o campo deixou de ser autoincrement
        if EmployeeAbsence.Find('+') then
            "Entry No." := EmployeeAbsence."Entry No." + 1
        else
            "Entry No." := 1;
    end;

    var
        CauseOfAbsence: Record "Absence Reason";
        Employee: Record Empregado;
        EmployeeAbsence: Record "Ausência Empregado";
        HumanResUnitOfMeasure: Record "Unid. Medida Recursos Humanos";
        Text0001: Label 'tem que ser maior ou igual ';
        AuxString: Text[64];
        HumanResComment: Record "Linha Coment. Recurso Humano";

    local procedure CalcBaseQty(Qty: Decimal): Decimal
    begin
        TestField("Qty. per Unit of Measure");
        exit(Round(Qty * "Qty. per Unit of Measure", 0.00001));
    end;
}

