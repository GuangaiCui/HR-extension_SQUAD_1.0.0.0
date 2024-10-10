table 53074 "Abonos - Descontos Extra"
{
    DrillDownPageID = "Registo Abonos-Descontos Extra";
    LookupPageID = "Registo Abonos-Descontos Extra";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'No. Mov';
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'No. Empregado';
            TableRelation = Empregado;
        }
        field(3; Date; Date)
        {
            Caption = 'Data';
        }
        field(8; "Payroll Item Code"; Code[20])
        {
            Caption = 'Cód. Rubrica';
            TableRelation = "Payroll Item";

            trigger OnValidate()
            begin
                TabRubrica.Get("Payroll Item Code");
                "Payroll Item Type" := TabRubrica."Payroll Item Type";
                "Payroll Item Description" := TabRubrica.Descrição;
                Quantity := TabRubrica.Quantity;
                "Unit Value" := TabRubrica."Unit Value";
                "Valor Total" := TabRubrica."Valor Total";
            end;
        }
        field(9; "Payroll Item Type"; Option)
        {
            Caption = 'Tipo Rubrica';
            OptionCaption = 'Abono,Desconto';
            OptionMembers = Abono,Desconto;
        }
        field(10; "Payroll Item Description"; Text[100])
        {
            Caption = 'Descrição Rubrica';
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
        field(17; "Unit of Measure"; Code[20])
        {
            Caption = 'Unidade Medida';
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
        field(35; "Cancel Absence"; Boolean)
        {
            Caption = 'Anular Falta';
            Description = 'Para anular uma falta debitada por engano, no Fich SS e CGA';
        }
        field(36; "Reference Date"; Date)
        {
            Caption = 'Data a que se refere o Mov.';
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
        key(Key2; "Employee No.", "Reference Date")
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
            "Unit of Measure" := ConfRH."Base Unit of Measure";
    end;

    var
        TabAbonosDescExtra: Record "Abonos - Descontos Extra";
        TabEmpregado: Record Empregado;
        TabRubrica: Record "Payroll Item";
        ConfRH: Record "Config. Recursos Humanos";
        HumanResComment: Record "Linha Coment. Recurso Humano";
        Employee: Record Empregado;
}

