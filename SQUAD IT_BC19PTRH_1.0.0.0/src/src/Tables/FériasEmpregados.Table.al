table 53090 "Férias Empregados"
{
    DrillDownPageID = "Lista Férias Empregado";
    LookupPageID = "Lista Férias Empregado";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Empregado;
        }
        field(2; Data; Date)
        {
            Caption = 'Date';
        }
        field(3; Tipo; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Vacation,Compensation';
            OptionMembers = ferias,compensacao;
        }
        field(4; "Ano a que se refere"; Integer)
        {
            Caption = 'Last Year';
        }
        field(6; "Qtd."; Decimal)
        {
            Caption = 'Qtd. in hours';
            DataClassification = ToBeClassified;
            ValuesAllowed = 1, 0, 5;
        }
        field(7; Gozada; Boolean)
        {
            Caption = 'Used';
            Editable = false;
        }
        field(50; "Processamento Referencia"; Code[10])
        {
            Description = 'Usado na abertura processamento';
        }
    }

    keys
    {
        key(Key1; "Employee No.", Data, Tipo)
        {
            Clustered = true;
            SumIndexFields = "Qtd.";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        PerProc.Reset;
        PerProc.SetRange("Cód. Processamento", "Processamento Referencia");
        PerProc.SetRange(Estado, 1);
        if (PerProc.FindFirst) and Gozada then
            Error(text002);
    end;

    trigger OnInsert()
    begin
        "Qtd." := 1;
        "Ano a que se refere" := Date2DMY(WorkDate, 3);
    end;

    trigger OnModify()
    begin
        /*
        PerProc.RESET;
        PerProc.SETRANGE("Cód. Processamento", "Processamento Referencia");
        PerProc.SETRANGE(Estado,1);
        IF (PerProc.FINDFIRST) AND Gozada THEN
          ERROR(text001);
          */

    end;

    var
        PerProc: Record "Periodos Processamento";
        text001: Label 'Não pode modificar porque já foi processado.';
        text002: Label 'Não pode apagar porque já foi processado.';
}

