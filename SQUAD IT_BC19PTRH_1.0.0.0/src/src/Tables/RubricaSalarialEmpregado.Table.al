table 53078 "Rubrica Salarial Empregado"
{
    // //C+ -LCF-  Acrescentei a chave a tabela (Nº Empregado,Sort,Cód. Rúbrica Salarial,Data Início)
    // //IT001 - CPA - 2016.10.24 - mudei o nome do campo "Data Falta" para "Data a que se refere o mov" pois agora é usado para acerto de duodécimos


    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'No. Empregado';
            TableRelation = Empregado;
        }
        field(2; "Cód. Rúbrica Salarial"; Code[20])
        {
            Caption = 'Salary Item Code';
            TableRelation = "Payroll Item";

            trigger OnValidate()
            begin
                //HG
                TabRubrica.Get("Cód. Rúbrica Salarial");
                "Payroll Item Type" := TabRubrica."Payroll Item Type";
                "Payroll Item Description" := TabRubrica.Descrição;
                "Debit Acc. No." := TabRubrica."Debit Acc. No.";
                "Credit Acc. No." := TabRubrica."Credit Acc. No.";
                Quantity := TabRubrica.Quantity;
                "Unit Value" := TabRubrica."Unit Value";
                "Total Amount" := TabRubrica."Total Amount";

                "Cód. Situação" := TabRubrica."Cód. Situação"; //CGA
            end;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'No. Linha';
        }
        field(8; "Payroll Item Type"; Option)
        {
            Caption = 'Tipo Rubrica';
            OptionCaption = 'Abono,Desconto';
            OptionMembers = Abono,Desconto;
        }
        field(9; "Payroll Item Description"; Text[100])
        {
            Caption = 'Salary Iten Descrption';
        }
        field(14; "Debit Acc. No."; Code[20])
        {
            Caption = 'Debit Acc. No.';
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                // 2007.09.05 AMFB - Nao deixar preencher se for conta maior

                if TabGLAccount.Get("Debit Acc. No.") then begin
                    if TabGLAccount."Account Type" = TabGLAccount."Account Type"::Heading then
                        Error(Text0003, "Debit Acc. No.");
                end;
            end;
        }
        field(15; "Credit Acc. No."; Code[20])
        {
            Caption = 'No. Conta a Creditar';
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                // 2007.09.05 AMFB - Nao deixar preencher se for conta maior

                if TabGLAccount.Get("Credit Acc. No.") then begin
                    if TabGLAccount."Account Type" = TabGLAccount."Account Type"::Heading then
                        Error(Text0003, "Credit Acc. No.");
                end;
            end;
        }
        field(20; Quantity; Decimal)
        {
            Caption = 'Quantidade';

            trigger OnValidate()
            begin
                //HG
                //Validate("Total Amount", Round(Quantity * "Unit Value", 0.01));
                "Total Amount" := Quantity * "Unit Value";
            end;
        }
        field(21; "Unit Value"; Decimal)
        {
            Caption = 'Valor Unitário';

            trigger OnValidate()
            begin
                //HG
                //Validate("Total Amount", Round(Quantity * "Unit Value", 0.01));
                "Total Amount" := Quantity * "Unit Value";
            end;
        }
        field(22; "Total Amount"; Decimal)
        {
            Caption = 'Valor Total';
            trigger OnValidate()
            begin
                //HG - Não deixar colocar valor na rubrica se esta tiver filhas, pois neste caso o valor é o somatório das filhas
                TabRubricaSalLinhas.Reset;
                TabRubricaSalLinhas.SetRange(TabRubricaSalLinhas."Payroll Item Code", "Cód. Rúbrica Salarial");
                if TabRubricaSalLinhas.Find('-') then
                    Error(Text0002, "Cód. Rúbrica Salarial");
            end;
        }
        field(27; "Data Início"; Date)
        {
            Caption = 'Start Date';
            InitValue = 19000101D;
        }
        field(28; "Data Fim"; Date)
        {
            Caption = 'End Date';
            InitValue = 21001231D;
        }
        field(30; "Sort"; Integer)
        {
            Caption = 'Ordenação';
            Description = 'Define a ordem pela qual as rúbricas aparecem no recibo';
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
        field(63; "Origem TP"; Boolean)
        {
            Caption = 'Edu Source';
        }
        field(64; "Utilizador Integracao"; Code[20])
        {
            Caption = 'Integration User ID';
        }
        field(65; "Data Integracao"; Date)
        {
            Caption = 'Integration Date';
        }
        field(90; "Quatidade Recibo Vencimentos"; Decimal)
        {
            Caption = 'Salary Slip Qtd.';
            Description = 'HG - por causa das ausencias em dias e em horas';
        }
        field(91; "Unit of Measure"; Code[20])
        {
            Caption = 'Unit of Measure';
            Description = 'HG - por causa das ausencias em dias e em horas';
        }
        field(98; "Data a que se refere o mov"; Date)
        {
            Caption = 'Absence Start Date';
            Description = 'Usado no Ficheiro Seg. Social';
        }
        field(99; NLinhaRubSalEmp; Integer)
        {
            Caption = 'Line No. Emp. Salary Iten';
            Description = 'Usado na Analitica para relacionar com Coef Default';
        }
        field(101; Table; Integer)
        {
            Caption = 'Tabela';
            Description = 'Usado na Analitica para relacionar com Coef Default';
        }
        field(105; "Valor Incidência SS"; Decimal)
        {
            Caption = 'Soc. Sec. Value';
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
        field(120; "Garnishmen No."; Code[50])
        {
            Caption = 'Garnishmen No.';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Employee No.", Sort, "Cód. Rúbrica Salarial")
        {
        }
        key(Key3; "Employee No.", Sort, "Cód. Rúbrica Salarial", "Data Início")
        {
        }
        key(Key4; "Employee No.", Sort, "Cód. Rúbrica Salarial", "Data a que se refere o mov", "Unit of Measure")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //C+ -LCF-  Acrescentei a chave a tabela (Nº Empregado,Sort,Cód. Rúbrica Salarial,Data Início)

        //Preenche automaticamente o campo Sort pela ordem que os registos são criados
        //Permitindo ao utilizador alterar
        Sort := Round("Line No." / 10000, 1);
    end;

    var
        TabRubrica: Record "Payroll Item";
        TabRubricaSalLinhas: Record "Rubrica Salarial Linhas";
        TabRubricaSalEmp: Record "Rubrica Salarial Empregado";
        Text0002: Label 'A rúbrica %1 está depende de outras e como tal não se deve definir um valor.';
        TabGLAccount: Record "G/L Account";
        Text0003: Label 'A Conta %1 é uma conta maior. Escolha uma conta auxiliar.';
        Employee: Record Empregado;
        TabConta: Record "G/L Account";
}

