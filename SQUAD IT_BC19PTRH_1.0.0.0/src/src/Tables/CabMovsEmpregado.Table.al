table 31003079 "Cab. Movs. Empregado"
{
    DrillDownPageID = "Lista Cab. Movs. Empregado";
    LookupPageID = "Lista Cab. Movs. Empregado";

    fields
    {
        field(1; "Cód. Processamento"; Code[10])
        {
            Caption = 'Payroll Code';
        }
        field(2; "Tipo Processamento"; Option)
        {
            Caption = 'Payroll Type';
            OptionCaption = 'Vencimentos,Encargos,Sub. Natal,Sub. Férias';
            OptionMembers = Vencimentos,Encargos,SubNatal,SubFerias;
        }
        field(3; "No. Empregado"; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Empregado;

            trigger OnValidate()
            begin
                if TabEmp.Get("No. Empregado") then
                    "Designação Empregado" := TabEmp.Name; //2008.05.23
                                                           //"Designação Empregado" := COPYSTR(TabEmp.Name,1,60);
            end;
        }
        field(5; "Designação Empregado"; Text[75])
        {
            Caption = 'Employee Name';
        }
        field(10; "Data Registo"; Date)
        {
            Caption = 'Posting Date';
        }
        field(20; Valor; Decimal)
        {
            CalcFormula = Sum("Linhas Movs. Empregado".Valor WHERE("Cód. Processamento" = FIELD("Cód. Processamento"),
                                                                    "Tipo Processamento" = FIELD("Tipo Processamento"),
                                                                    "No. Empregado" = FIELD("No. Empregado")));
            Caption = 'Amount';
            FieldClass = FlowField;
        }
        field(30; "Usa Transferência Bancária"; Boolean)
        {
            Caption = 'Use Bank Transfer';
        }
        field(31; "Cód. Banco Transf."; Code[20])
        {
            Caption = 'Bank Transfer Code';
        }
        field(40; "Abate Sub Alimentação"; Integer)
        {
            Caption = 'Abate Sub Alimentação';
        }
        field(50; "No. Segurança Social"; Text[11])
        {
            Caption = 'Social Security No.';
            Numeric = true;
        }
        field(51; "No. Contribuinte"; Text[9])
        {
            Caption = 'VAT No.';
            Numeric = true;

            trigger OnValidate()
            var
                i: Integer;
                x: Integer;
                num: Integer;
            begin
            end;
        }
        field(52; IBAN; Code[50])
        {
            Caption = 'IBAN';
            Numeric = true;

            trigger OnValidate()
            var
                num: BigInteger;
                X: Integer;
                txtnum: Text[30];
                rEmpregado: Record Empregado;
                OK: Boolean;
                text01: Label 'Está a inserir um NIB já existente!\Empregado: %1\NIB: %2\Continuar?';
                text02: Label 'Introduza de novo o NIB.';
            begin
            end;
        }
        field(53; "Nº CGA"; Text[11])
        {
            Numeric = true;
        }
        field(54; Seguradora; Text[60])
        {
            Caption = 'Insurance';
        }
        field(55; "No. Apólice"; Text[20])
        {
            Caption = 'Insurance No.';
        }
        field(56; "Grau Função"; Code[20])
        {
            Caption = 'Degree';
        }
        field(57; "Descrição Cat Prof QP"; Text[100])
        {
            Caption = 'QP Prof. Categ. Description';
        }
        field(58; "Valor Vencimento Base"; Decimal)
        {
            Caption = 'Base Salary Amount';
        }
        field(59; "Valor Hora"; Decimal)
        {
            Caption = 'Hour Amount';
        }
        field(60; "No. Horas Semanais"; Decimal)
        {
            Caption = 'No. of Weekly Hours';
        }
        field(61; "Nº Horas Semanais Totais"; Decimal)
        {
            Caption = 'Nº Horas Semanais Totais';
            Enabled = false;
        }
        field(62; "Nº Horas Docência Calc. Desct."; Integer)
        {
            Caption = 'Nº Horas Docência Calc. Desct.';
            Enabled = false;
        }
        field(1000; "Valor Incidência IRS"; Decimal)
        {
            Caption = 'IRS Value';
            Description = 'Usado na Sobretaxa 3,5 de 2013';
        }
        field(1001; "Valor para Escalão Sobretaxa"; Decimal)
        {
            Caption = 'Valor para Escalão Sobretaxa';
        }
        field(1002; "Vacation Days Received"; Decimal)
        {
            Caption = 'Dias Férias Recebidos';
            DataClassification = ToBeClassified;
        }
        field(1003; "Vacation Days Spent"; Decimal)
        {
            Caption = 'Dias Férias Gastos';
            DataClassification = ToBeClassified;
        }
        field(1004; "Vacation Days Balance"; Decimal)
        {
            Caption = 'Saldo Dias Férias';
            DataClassification = ToBeClassified;
        }
        field(50000; "Descrição Cat Prof Int"; Text[100])
        {
            Caption = 'QP Prof. Categ. Description';
        }
    }

    keys
    {
        key(Key1; "Cód. Processamento", "Tipo Processamento", "No. Empregado")
        {
            Clustered = true;
        }
        key(Key2; Seguradora, "No. Apólice")
        {
        }
        key(Key3; Seguradora, "No. Apólice", "No. Empregado")
        {
        }
    }

    fieldgroups
    {
    }

    var
        TabEmp: Record Empregado;
}

