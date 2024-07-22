table 53078 "Rubrica Salarial Empregado"
{
    // //C+ -LCF-  Acrescentei a chave a tabela (Nº Empregado,Ordenação,Cód. Rúbrica Salarial,Data Início)
    // //IT001 - CPA - 2016.10.24 - mudei o nome do campo "Data Falta" para "Data a que se refere o mov" pois agora é usado para acerto de duodécimos


    fields
    {
        field(1; "No. Empregado"; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
        }
        field(2; "Cód. Rúbrica Salarial"; Code[20])
        {
            Caption = 'Salary Iten Code';
            TableRelation = "Rubrica Salarial";

            trigger OnValidate()
            begin
                //HG
                TabRubrica.Get("Cód. Rúbrica Salarial");
                "Tipo Rubrica" := TabRubrica."Tipo Rubrica";
                "Descrição Rubrica" := TabRubrica.Descrição;
                "No. Conta a Debitar" := TabRubrica."No. Conta a Debitar";
                "No. Conta a Creditar" := TabRubrica."No. Conta a Creditar";
                Quantidade := TabRubrica.Quantidade;
                "Valor Unitário" := TabRubrica."Valor Unitário";
                "Valor Total" := TabRubrica."Valor Total";

                "Cód. Situação" := TabRubrica."Cód. Situação"; //CGA
            end;
        }
        field(3; "No. Linha"; Integer)
        {
            Caption = 'Line No.';
        }
        field(8; "Tipo Rubrica"; Option)
        {
            Caption = 'Salary Iten Type';
            OptionCaption = 'Abono,Desconto';
            OptionMembers = Abono,Desconto;
        }
        field(9; "Descrição Rubrica"; Text[100])
        {
            Caption = 'Salary Iten Descrption';
        }
        field(14; "No. Conta a Debitar"; Code[20])
        {
            Caption = 'Debit Acc. No.';
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                // 2007.09.05 AMFB - Nao deixar preencher se for conta maior

                if TabGLAccount.Get("No. Conta a Debitar") then begin
                    if TabGLAccount."Account Type" = TabGLAccount."Account Type"::Heading then
                        Error(Text0003, "No. Conta a Debitar");
                end;
            end;
        }
        field(15; "No. Conta a Creditar"; Code[20])
        {
            Caption = 'Credit Acc. No.';
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                // 2007.09.05 AMFB - Nao deixar preencher se for conta maior

                if TabGLAccount.Get("No. Conta a Creditar") then begin
                    if TabGLAccount."Account Type" = TabGLAccount."Account Type"::Heading then
                        Error(Text0003, "No. Conta a Creditar");
                end;
            end;
        }
        field(20; Quantidade; Decimal)
        {
            Caption = 'Quantity';

            trigger OnValidate()
            begin
                //HG

                Validate("Valor Total", Round(Quantidade * "Valor Unitário", 0.01));
            end;
        }
        field(21; "Valor Unitário"; Decimal)
        {
            Caption = 'Unit Value';

            trigger OnValidate()
            begin
                //HG
                Validate("Valor Total", Round(Quantidade * "Valor Unitário", 0.01));
            end;
        }
        field(22; "Valor Total"; Decimal)
        {
            Caption = 'Total Value';

            trigger OnValidate()
            begin
                //HG - Não deixar colocar valor na rubrica se esta tiver filhas, pois neste caso o valor é o somatório das filhas

                TabRubricaSalLinhas.Reset;
                TabRubricaSalLinhas.SetRange(TabRubricaSalLinhas."Cód. Rubrica", "Cód. Rúbrica Salarial");
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
        field(30; "Ordenação"; Integer)
        {
            Caption = 'Sort';
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
        field(91; UnidadeMedida; Code[20])
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
        field(101; Tabela; Integer)
        {
            Caption = 'Table';
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
        key(Key1; "No. Empregado", "No. Linha")
        {
            Clustered = true;
        }
        key(Key2; "No. Empregado", "Ordenação", "Cód. Rúbrica Salarial")
        {
        }
        key(Key3; "No. Empregado", "Ordenação", "Cód. Rúbrica Salarial", "Data Início")
        {
        }
        key(Key4; "No. Empregado", "Ordenação", "Cód. Rúbrica Salarial", "Data a que se refere o mov", UnidadeMedida)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //C+ -LCF-  Acrescentei a chave a tabela (Nº Empregado,Ordenação,Cód. Rúbrica Salarial,Data Início)

        //Preenche automaticamente o campo ordenação pela ordem que os registos são criados
        //Permitindo ao utilizador alterar
        Ordenação := Round("No. Linha" / 10000, 1);
    end;

    var
        TabRubrica: Record "Rubrica Salarial";
        TabRubricaSalLinhas: Record "Rubrica Salarial Linhas";
        TabRubricaSalEmp: Record "Rubrica Salarial Empregado";
        Text0002: Label 'A rúbrica %1 está depende de outras e como tal não se deve definir um valor.';
        TabGLAccount: Record "G/L Account";
        Text0003: Label 'A Conta %1 é uma conta maior. Escolha uma conta auxiliar.';
        Employee: Record Employee;
        TabConta: Record "G/L Account";
}

