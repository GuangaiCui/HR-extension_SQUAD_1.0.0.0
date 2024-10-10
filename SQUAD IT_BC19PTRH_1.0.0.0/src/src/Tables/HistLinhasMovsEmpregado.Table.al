table 53109 "Hist. Linhas Movs. Empregado"
{
    // //IT001 - CPA - 2016.10.21 - Nova Key "No. Empregado,Data Inicio Falta", por causa dos Mapas Seg. Social
    // //IT001 - CPA - 2016.10.24 - mudei o nome do campo "Data Falta" para "Data a que se refere o mov" pois agora é usado para acerto de duodécimos

    DrillDownPageID = "Lista Hist. Movs. Empregado";
    LookupPageID = "Lista Hist. Movs. Empregado";

    fields
    {
        field(1; "Cód. Processamento"; Code[10])
        {
            Caption = 'Payroll Code';
        }
        field(2; "Tipo Processamento"; Option)
        {
            Caption = 'Payroll Code';
            OptionCaption = 'Vencimentos,Encargos,Sub. Natal,Sub. Férias';
            OptionMembers = Vencimentos,Encargos,SubNatal,SubFerias;
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Empregado;
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
        field(19; "Cód. Rubrica"; Code[20])
        {
            Caption = 'Salary Iten Code';
            TableRelation = "Rubrica Salarial";
        }
        field(20; "Descrição Rubrica"; Text[100])
        {
            Caption = 'Salary Iten Description';
        }
        field(21; "Tipo Rubrica"; Option)
        {
            Caption = 'Salary Iten Type';
            OptionCaption = 'Abono,Desconto';
            OptionMembers = Abono,Desconto;
        }
        field(22; NATREM; Option)
        {
            OptionCaption = ' ,Cód. Comissões,Cód. Sub. Férias,Cód. Sub. Natal,Remuneração Permanente,Subsídios Reg. Não Mensal,Forças Armadas,Férias Pagas não Gozadas,Diferenças de Vencimento,Ajudas Custo e Trans.,Prémios-Bonus Mensal,Compensação,Honorários,Subsídios regulares,Prémios-bonus Não mensal,Sub. Ref.,Trab. Supl.,Trab. Noct.,Compensação Cont. Intermitente';
            OptionMembers = " ","Cód. Comissões","Cód. Sub. Férias","Cód. Sub. Natal","Remuneração Permanente","Subsídios Reg. Não Mensal","Forças Armadas","Férias Pagas não Gozadas","Diferenças de Vencimento","Ajudas Custo e Trans.","Prémios-Bonus Mensal","Compensação","Honorários","Subsídios regulares","Prémios-bonus Não mensal","Sub. Ref.","Trab. Supl.","Trab. Noct.","Compensação Cont. Intermitente";
        }
        field(25; "Debit Acc. No."; Code[20])
        {
            Caption = 'No. Conta a Debitar';
            TableRelation = "G/L Account";
        }
        field(26; "Credit Acc. No."; Code[20])
        {
            Caption = 'No. Conta a Creditar';
            TableRelation = "G/L Account";
        }
        field(38; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(39; "Unit Value"; Decimal)
        {
            Caption = 'Valor Unitário';
        }
        field(40; "Valor Débito"; Decimal)
        {
            Caption = 'Debit Amount';
            Enabled = false;
        }
        field(41; "Valor Crédito"; Decimal)
        {
            Caption = 'Credit Amount';
            Enabled = false;
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
        field(80; Pendente; Boolean)
        {
            Caption = 'Open';
            Description = 'Pagamento Encargos';
            InitValue = true;
        }
        field(81; "Pago por No. Documento"; Code[20])
        {
            Caption = 'Payment Document No.';
            Description = 'Pagamento Encargos';
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
        field(91; UnidadeMedida; Code[20])
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
        key(Key3; "Employee No.")
        {
        }
        key(Key4; "Debit Acc. No.")
        {
        }
        key(Key5; "Tipo Rendimento")
        {
        }
        key(Key6; "Employee No.", "Data Registo", "Cód. Situação")
        {
        }
        key(Key7; "Employee No.", "Tipo Rendimento")
        {
        }
        key(Key8; "Tipo Processamento", "Cód. Processamento", "Employee No.", "No. Linha", "Data a que se refere o mov")
        {
        }
        key(Key9; "Data Registo")
        {
        }
        key(Key10; "Employee No.", "Data Registo", "Cód. Situação", "Cód. Movimento")
        {
        }
        key(Key11; "Cód. Rubrica")
        {
        }
        key(Key12; "Employee No.", "Tipo Rendimento Cat.A")
        {
        }
        key(Key13; "Employee No.", "Data a que se refere o mov")
        {
        }
    }

    fieldgroups
    {
    }
}

