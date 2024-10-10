table 53074 "Abonos - Descontos Extra"
{
    DrillDownPageID = "Registo Abonos-Descontos Extra";
    LookupPageID = "Registo Abonos-Descontos Extra";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'No. Mov.';
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Empregado;
        }
        field(3; Data; Date)
        {
            Caption = 'Data';
        }
        field(8; "Cód. Rubrica"; Code[20])
        {
            Caption = 'Salary Item Code';
            TableRelation = "Rubrica Salarial";

            trigger OnValidate()
            begin
                TabRubrica.Get("Cód. Rubrica");
                "Tipo Rubrica" := TabRubrica."Tipo Rubrica";
                "Descrição Rubrica" := TabRubrica.Descrição;
                Quantity := TabRubrica.Quantity;
                "Unit Value" := TabRubrica."Unit Value";
                "Valor Total" := TabRubrica."Valor Total";
            end;
        }
        field(9; "Tipo Rubrica"; Option)
        {
            Caption = 'Salary Item Type';
            OptionCaption = 'Abono,Desconto';
            OptionMembers = Abono,Desconto;
        }
        field(10; "Descrição Rubrica"; Text[100])
        {
            Caption = 'Salary Item Description';
        }
        field(14; Quantity; Decimal)
        {
            Caption = 'Quantity';

            trigger OnValidate()
            begin
                "Valor Total" := Quantity * "Unit Value";
            end;
        }
        field(15; "Unit Value"; Decimal)
        {
            Caption = 'Valor Unitário';

            trigger OnValidate()
            begin
                "Valor Total" := Quantity * "Unit Value";
            end;
        }
        field(16; "Valor Total"; Decimal)
        {
            Caption = 'Total Amount';
        }
        field(17; UnidadeMedida; Code[20])
        {
            Caption = 'Unit code';
            TableRelation = "Unid. Medida Recursos Humanos";
        }
        field(21; "Earning - Blocked Deduction"; Boolean)
        {
            Caption = 'Abono - Desconto Bloqueado';
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
        field(35; "Anular Falta"; Boolean)
        {
            Caption = 'Cancel Absence';
            Description = 'Para anular uma falta debitada por engano, no Fich SS e CGA';
        }
        field(36; "Data a que se refere o Mov."; Date)
        {
            Caption = 'Reference Date';
            Description = 'Para aparecer no Fic. Seg. Social e CGA com a data do mês a que se refere a falta ou acerto venc, etc...';
        }
        field(40; "Qtd. Perca Sub. Alimentação"; Integer)
        {
            Caption = 'Loss of Lunch Subsidy Qtd.';
            Description = 'Para nas Admissões Demissões abater o Sub. Alimentação';
        }
        field(60; "Garnishmen No."; Code[50])
        {
            Caption = 'Garnishmen No.';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Employee No.", "Data a que se refere o Mov.")
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
        HumanResComment.SetRange(HumanResComment."Table Name", DATABASE::"Abonos - Descontos Extra");
        HumanResComment.SetRange(HumanResComment."Table Line No.", "Entry No.");
        if HumanResComment.Find('-') then
            HumanResComment.DeleteAll;

        //2009.02.26 - fim
    end;

    trigger OnInsert()
    begin
        TabAbonosDescExtra.SetCurrentKey(TabAbonosDescExtra."Entry No.");
        if TabAbonosDescExtra.Find('+') then
            "Entry No." := TabAbonosDescExtra."Entry No." + 1
        else
            "Entry No." := 1;


        //2009.03.11
        //Para trazer a analitica por defeito que está na ficha do empregado



        //2008.10.30
        if ConfRH.Get() then
            UnidadeMedida := ConfRH."Base Unit of Measure";
    end;

    var
        TabAbonosDescExtra: Record "Abonos - Descontos Extra";
        TabEmpregado: Record Empregado;
        TabRubrica: Record "Rubrica Salarial";
        ConfRH: Record "Config. Recursos Humanos";
        HumanResComment: Record "Linha Coment. Recurso Humano";
        Employee: Record Empregado;
}

