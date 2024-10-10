table 53080 "Linhas Movs. Empregado"
{
    DrillDownPageID = "Lista Movs. Empregado";
    LookupPageID = "Lista Movs. Empregado";

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
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Empregado;

            trigger OnValidate()
            begin
                if TabEmp.Get("Employee No.") then
                    "Designação Empregado" := TabEmp.Name;// + ' ' + TabEmp."First Name" + ' ' + TabEmp."Last Name"; //2008.05.23
            end;
        }
        field(4; "No. Linha"; Integer)
        {
            Caption = 'Line No.';
        }
        field(6; "Data Registo"; Date)
        {
            Caption = 'Posting Date';
        }
        field(13; "Designação Empregado"; Text[75])
        {
            Caption = 'Employee Name';
        }
        field(19; "Payroll Item Code"; Code[20])
        {
            Caption = 'Cód. Rubrica';
            TableRelation = "Payroll Item";

            trigger OnValidate()
            begin
                if TabRubrica.Get("Payroll Item Code") then begin
                    "Payroll Item Description" := TabRubrica.Descrição;
                    "Debit Acc. No." := TabRubrica."Debit Acc. No.";
                    "Credit Acc. No." := TabRubrica."Credit Acc. No.";
                    "Payroll Item Type" := TabRubrica."Payroll Item Type";
                    NATREM := TabRubrica.NATREM;
                end;
            end;
        }
        field(20; "Payroll Item Description"; Text[100])
        {
            Caption = 'Salary Iten Description';
        }
        field(21; "Payroll Item Type"; Option)
        {
            Caption = 'Salary Iten Type';
            OptionCaption = 'Abono,Desconto';
            OptionMembers = Abono,Desconto;
        }
        field(22; NATREM; Enum "Rubrica Salarial Nat. Rem.")
        {
            Caption = 'NATREM';
            //OptionCaption = ' ,Cód. Comissões,Cód. Sub. Férias,Cód. Sub. Natal,Remuneração Permanente,Subsídios Reg. Não Mensal,Forças Armadas,Férias Pagas não Gozadas,Diferenças de Vencimento,Ajudas Custo e Trans.,Prémios-Bonus Mensal,Compensação,Honorários,Subsídios regulares,Prémios-bonus Não mensal,Sub. Ref.,Trab. Supl.,Trab. Noct.,Compensação Cont. Intermitente';
            //OptionMembers = " ","Cód. Comissões","Cód. Sub. Férias","Cód. Sub. Natal","Remuneração Permanente","Subsídios Reg. Não Mensal","Forças Armadas","Férias Pagas não Gozadas","Diferenças de Vencimento","Ajudas Custo e Trans.","Prémios-Bonus Mensal","Compensação","Honorários","Subsídios regulares","Prémios-bonus Não mensal","Sub. Ref.","Trab. Supl.","Trab. Noct.","Compensação Cont. Intermitente";
        }
        field(25; "Debit Acc. No."; Code[20])
        {
            Caption = 'Debit Acc. No.';
            TableRelation = "G/L Account";
        }
        field(26; "Credit Acc. No."; Code[20])
        {
            Caption = 'Credit Acc. No.';
            TableRelation = "G/L Account";
        }
        field(38; Quantity; Decimal)
        {
            Caption = 'Quantidade';
        }
        field(39; "Unit Value"; Decimal)
        {
            Caption = 'Valor Unitário';
        }
        field(40; "Valor Débito"; Decimal)
        {
            Caption = 'Debit Amount';
            Enabled = false;

            trigger OnValidate()
            begin
                Validate(Valor, "Valor Débito");
            end;
        }
        field(41; "Valor Crédito"; Decimal)
        {
            Caption = 'Credit Amount';
            Enabled = false;

            trigger OnValidate()
            begin
                Validate(Valor, -"Valor Crédito");
            end;
        }
        field(42; Valor; Decimal)
        {
            Caption = 'Amount';
        }
        field(50; "Tipo Rendimento"; Option)
        {
            Caption = 'Type of Earning';
            Description = 'Anexo J';
            OptionCaption = 'A,B,E,EE,F,G,H,OUTRO';
            OptionMembers = A,B,E,EE,F,G,H,OUTRO;
        }
        field(60; "Cód. Situação"; Code[2])
        {
            Caption = 'Situation Code';
            Description = 'CGA';
            TableRelation = "Códigos Situação"."Cód. Situação";
        }
        field(61; "Cód. Movimento"; Option)
        {
            Caption = 'Transaction Code';
            Description = 'CGA';
            OptionCaption = ' ,9-Anulação do movimento,6-Movimento retroactivo positivo,7-Anulação movimento retroactivo';
            OptionMembers = " ","9","6","7";
        }
        field(62; "Data Efeito"; Date)
        {
            Caption = 'Start Date';
            Description = 'CGA';
        }
        field(85; "Data a que se refere o mov"; Date)
        {
            Caption = 'Absence Start Date';
            Description = 'LCF - o campo serve para as faltas do  fich Seg Social';
        }
        field(90; "Quatidade Recibo Vencimentos"; Decimal)
        {
            Caption = 'Qtd. in Salary Slip';
            Description = 'HG - por causa das ausencias em dias e em horas';
        }
        field(91; "Unit of Measure"; Code[20])
        {
            Caption = 'Unit Code';
            Description = 'HG - por causa das ausencias em dias e em horas';
        }
        field(105; "Valor Incidência SS"; Decimal)
        {
            Caption = 'Soc. Sec. Incidence Value';
            Description = 'Quando há valor limite(ex:Sub Alim), aqui a aplicação coloca só o valor no qual incide SS';
        }
        field(110; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Para as horas extra';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(111; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'Para as horas extra';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(112; "Tipo Rendimento Cat.A"; Option)
        {
            Caption = 'Type of Earning - Cat. A';
            Description = 'Usado na Declaração Mensal de Remunerações';
            OptionCaption = ' ,A,A2,A11,A12,A13,A14,A15,A16,A17,A20,A21,A22,A23,A30,A31,A32,A3,A4,A5,A18,A33,A19,A24,A25';
            OptionMembers = " ",A,A2,A11,A12,A13,A14,A15,A16,A17,A20,A21,A22,A23,A30,A31,A32,A3,A4,A5,A18,A33,A19,A24,A25;
        }
        field(120; "Garnishmen No."; Code[50])
        {
            Caption = 'Garnishmen No.';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Cód. Processamento", "Tipo Processamento", "Employee No.", "No. Linha")
        {
            Clustered = true;
            SumIndexFields = Valor;
        }
        key(Key2; "Employee No.", "Data Registo")
        {
        }
        key(Key3; "Employee No.", "Data Registo", "Cód. Situação")
        {
        }
        key(Key4; "Employee No.", "Data Registo", "Cód. Situação", "Cód. Movimento")
        {
        }
        key(Key5; "Payroll Item Code")
        {
        }
        key(Key6; "Payroll Item Type")
        {
        }
        key(Key7; "Cód. Processamento", "Employee No.", "No. Linha")
        {
        }
        key(Key8; "Employee No.", "Data a que se refere o mov")
        {
        }
    }

    fieldgroups
    {
    }

    var
        TabEmp: Record Empregado;
        TabRubrica: Record "Payroll Item";
        TabConta: Record "G/L Account";
        TabMovEmp: Record "Cab. Movs. Empregado";
}

