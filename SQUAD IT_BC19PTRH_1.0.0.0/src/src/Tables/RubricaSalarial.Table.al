table 53076 "Payroll Item"
{
    Caption = 'Rubrica Salarial';
    // IT001 - CPA:Novo campo para a funcionalidade de certos de Duodécimos
    // 
    // IT003 - CPA - 207.07.03 -  Novo campo "Vencimento Base" para ser usado nos recibos de vencimento

    DrillDownPageID = "Lista Rubrica Salarial";
    LookupPageID = "Lista Rubrica Salarial";

    fields
    {
        field(1; "Código"; Code[20])
        {
            Caption = 'Code';
        }
        field(6; "Payroll Item Type"; Option)
        {
            Caption = 'Tipo Rubrica';
            OptionCaption = 'Abono,Desconto';
            OptionMembers = Abono,Desconto;
        }
        field(7; "Descrição"; Text[100])
        {
            Caption = 'Description';
        }
        field(13; Periodicidade; Option)
        {
            Caption = 'Frequency';
            OptionCaption = 'Mensal,Bimestral,Trimestral,Quadrimestral,Semestral,Anual';
            OptionMembers = Mensal,Bimestral,Trimestral,Quadrimestral,Semestral,Anual;
        }
        field(14; "Mês Início Periocidade"; Integer)
        {
            Caption = 'Start Frequency';
        }
        field(19; "Debit Acc. No."; Code[20])
        {
            Caption = 'No. Conta a Debitar';
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
        field(20; "Credit Acc. No."; Code[20])
        {
            Caption = 'Credit Acc. No.';
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
        field(25; Quantity; Decimal)
        {
            Caption = 'Quantidade';

            trigger OnValidate()
            begin
                "Valor Total" := Quantity * "Unit Value";
            end;
        }
        field(26; "Unit Value"; Decimal)
        {
            Caption = 'Valor Unitário';

            trigger OnValidate()
            begin
                "Valor Total" := Quantity * "Unit Value";
            end;
        }
        field(27; "Valor Total"; Decimal)
        {
            Caption = 'Total Value';

            trigger OnValidate()
            begin
                if Quantity = 0 then Quantity := 1;
                "Unit Value" := "Valor Total" / Quantity;
            end;
        }
        field(35; NATREM; Enum "Rubrica Salarial Nat. Rem.")
        {
            Caption = 'NATREM';
            Description = 'Mapa Seg. Social';
            //OptionCaption = ' ,Comissões - C,Cód. Sub. Férias - F,Cód. Sub. Natal - N,Remuneração Permanente - P,Subsídios Reg. Não Mensal - X,Forças Armadas,Férias Pagas não Gozadas - 2,Diferenças de Vencimento - 6,Ajudas Custo e Trans. - A,Prémios Bonus e outras Prest. Mensais - B,Compensação Cessação Contrato - D,Honorários - H,Subsídios Regulares Mensais - M,Prémios Bonus e outras Prest. Não Mensais - O,Sub. Ref. - R,Trab. Supl. - S,Trab. Noct. - T,Compensação Cont. Intermitente - I';
            //OptionMembers = " ","Cód. Comissões","Cód. Sub. Férias","Cód. Sub. Natal","Remuneração Permanente","Subsídios Reg. Não Mensal","Forças Armadas","Férias Pagas não Gozadas","Diferenças de Vencimento","Ajudas Custo e Trans.","Prémios-Bonus Mensal","Compensação","Honorários","Subsídios regulares","Prémios-bonus Não mensal","Sub. Ref.","Trab. Supl.","Trab. Noct.","Compensação Cont. Intermitente";

            trigger OnValidate()
            var
                lRubricaSal: Record "Payroll Item";
                lRubricaSalLinhas: Record "Rubrica Salarial Linhas";
            begin
                if NATREM <> NATREM::" " then begin
                    lRubricaSal.Reset;
                    lRubricaSal.SetRange(lRubricaSal.Genero, lRubricaSal.Genero::SS);
                    if lRubricaSal.Find('-') then begin
                        lRubricaSalLinhas.Reset;
                        lRubricaSalLinhas.SetRange(lRubricaSalLinhas."Payroll Item Code", lRubricaSal.Código);
                        lRubricaSalLinhas.SetRange(lRubricaSalLinhas."Cód. Rubrica Filha", Código);
                        if not lRubricaSalLinhas.Find('-') then
                            Message(Text0004, Código);
                    end;
                end;
            end;
        }
        field(39; Genero; Enum "Rubrica Salarial Genero")
        {
            Caption = 'Type';
            //OptionCaption = ' ,Rúbrica de Vencimento Base,Rúbrica de IRS,Rúbrica de Seg. Social,Rúbrica Sub. Alimentação,Rúbrica IRS Sub. Férias,Rúbrica IRS Sub. Natal,Rúbrica Enc. Seg. Social,Rúbrica IVA,Rúbrica CGA,Rúbrica Falta,Rúbrica Hora Extra,Rúbrica Enc. CGA,Sindicato,ADSE,Admissão-Demissão,Enc. ADSE,Duo. Sub. Férias,Duo. Sub. Natal,Fundo Compensação Trabalho / FGCT';
            //OptionMembers = " ","Vencimento Base",IRS,SS,"Sub. Alimentação","IRS Sub. Férias","IRS Sub. Natal","Enc. SS",IVA,CGA,Falta,"Hora Extra","Enc. CGA",Sindicato,ADSE,"Admissão-Demissão","Enc. ADSE",DuoSF,DuoSN,"FCT-FGCT";
        }
        field(40; "Genero Rubrica Fecho"; Enum "Rubrica Salarial Genero Fecho")
        {
            Caption = 'Rubrica Fecho';
            Description = 'Fecho de Contas';
            //OptionCaption = ' ,Indem. Mútuo Acordo ou Despedimento,Indem. Falta Aviso Prévio do Empregado,Indem. Falta Aviso Prévio da Empresa,Compensação fim contrato,Férias não gozadas,Proporcional Sub. Férias,Proporcional Sub. Natal,Sub. Férias Ano Anterior,Prop. Férias,Crédito Formação';
            //OptionMembers = " ","Indem. Mútuo Acordo ou Despedimento","Indem. Falta Aviso Prévio do Empregado","Indem. Falta Aviso Prévio da Empresa","Compensação fim contrato","Férias não gozadas","Proporcional Sub. Férias","Proporcional Sub. Natal","Sub. Férias Ano Anterior","Prop. Férias","Cred. Formacao";
        }
        field(50; "Tipo de Remuneração"; Option)
        {
            Caption = 'Salary Type';
            Description = 'RU';
            OptionCaption = ' ,Prémios e Subsídios Regulares,Prestações Irregulares,Subsídio Turno';
            OptionMembers = " ","Prémios e Subsídios Regulares","Prestações Irregulares","Subsídio Turno";
        }
        field(55; "Cód. Situação"; Code[2])
        {
            Description = 'CGA';
            TableRelation = "Códigos Situação"."Cód. Situação";
        }
        field(56; "Cód. Movimento"; Option)
        {
            Description = 'CGA';
            OptionCaption = ' ,9-Anulação do movimento,6-Movimento retroactivo positivo,7-Anulação movimento retroactivo';
            OptionMembers = " ","9","6","7";
        }
        field(57; "Mapa Companhia Seguros"; Boolean)
        {
            Caption = 'Mapa Companhia Seguros';
            Description = 'Mapa Companhia Seguros';
        }
        field(58; Faults; Boolean)
        {
            Caption = 'Absence';
            Description = 'Significa que as faltas são abatidas a esta rubrica.';
        }
        field(100; Acertos; Boolean)
        {
            Description = 'CGA';
        }
        field(101; "Actualização Vencimento"; Boolean)
        {
            Caption = 'Salary Update';
            Description = 'Serve para indicar qual a rubrica que vai sofrer act. por parte da rotina de Act. Vencimento';
        }
        field(102; "Usado no cálculo indemnização"; Boolean)
        {
            Caption = 'Use in Compensation Salary';
            Description = 'Fecho de Contas';
        }
        field(110; "Imposto Extraordinário"; Boolean)
        {
            Caption = 'Extra TAX';
            Description = 'Imp. Extraordinario Sub Natal 2011';
        }
        field(111; "Sobretaxa em Sede de IRS"; Boolean)
        {
            Caption = 'Extra IRS';
            Description = 'Sobretaxa 3,5% em 2013';
        }
        field(112; "Tipo Rendimento Cat.A"; Option)
        {
            Caption = 'Type of Earning - Cat. A';
            Description = 'Usado na Declaração Mensal de Remunerações';
            OptionCaption = ' ,Default,A2,A11,A12,A13,A14,A15,A16,A17,A20,A21,A22,A23,A30,A31,A32,A3,A4,A5,A18,A33,A19,A24,A25';
            OptionMembers = " ",A,A2,A11,A12,A13,A14,A15,A16,A17,A20,A21,A22,A23,A30,A31,A32,A3,A4,A5,A18,A33,A19,A24,A25;
        }
        field(120; "Rubrica Acerto Duo"; Boolean)
        {
            Description = 'Rubrica se acerto de duodécimo para quando há aumentos salariais';
        }
        field(200; "Vencimento Base"; Boolean)
        {
            Description = 'CPA - para aparecer no cab. recibo';
        }
    }

    keys
    {
        key(Key1; "Código")
        {
            Clustered = true;
        }
        key(Key2; "Payroll Item Type", "Mês Início Periocidade", Quantity)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Código", "Descrição")
        {
        }
    }

    trigger OnDelete()
    begin
        //HG - quando apaga uma rubrica salarial "Mãe"
        //    1 - tem de apagar em todo o lado onde ela é filha
        //    2 - tem de apagar as filhas dela


        TabRubricaSalLinhas.Reset;
        TabRubricaSalLinhas.SetRange(TabRubricaSalLinhas."Payroll Item Code", Código);
        if TabRubricaSalLinhas.Find('-') then TabRubricaSalLinhas.DeleteAll;

        TabRubricaSalLinhas.Reset;
        TabRubricaSalLinhas.SetRange(TabRubricaSalLinhas."Cód. Rubrica Filha", Código);
        if TabRubricaSalLinhas.Find('-') then TabRubricaSalLinhas.DeleteAll;
    end;

    trigger OnModify()
    begin
        //HG - quando se modificar uma rúbrica perguntar ao utilizador se que actualizar a mesma
        //na tabela Rubrica Salarial Empregado


        //Pergunta se quer actualizar os registos que têm o antigo valor, com o novo valor
        //---------------------------------------------------------------------------------
        TabRubricaSalEmp.Reset;
        TabRubricaSalEmp.SetRange(TabRubricaSalEmp."Cód. Rúbrica Salarial", Código);
        TabRubricaSalEmp.SetFilter(TabRubricaSalEmp."Data Início", '<=%1|%2', WorkDate, 0D);
        TabRubricaSalEmp.SetFilter(TabRubricaSalEmp."Data Fim", '>=%1|=%2', WorkDate, 0D);
        if TabRubricaSalEmp.Find('-') then begin
            if Confirm(Text0001, true, Código) then begin
                repeat
                    if xRec."Payroll Item Type" <> "Payroll Item Type" then begin
                        if TabRubricaSalEmp."Payroll Item Type" = xRec."Payroll Item Type" then
                            TabRubricaSalEmp."Payroll Item Type" := "Payroll Item Type";
                    end;

                    if xRec.Descrição <> Descrição then begin
                        if TabRubricaSalEmp."Payroll Item Description" = xRec.Descrição then
                            TabRubricaSalEmp."Payroll Item Description" := Descrição;
                    end;

                    if xRec."Debit Acc. No." <> "Debit Acc. No." then begin
                        if TabRubricaSalEmp."Debit Acc. No." = xRec."Debit Acc. No." then
                            TabRubricaSalEmp."Debit Acc. No." := "Debit Acc. No.";
                    end;

                    if xRec."Credit Acc. No." <> "Credit Acc. No." then begin
                        if TabRubricaSalEmp."Credit Acc. No." = xRec."Credit Acc. No." then
                            TabRubricaSalEmp."Credit Acc. No." := "Credit Acc. No.";
                    end;

                    if xRec.Quantity <> Quantity then begin
                        if TabRubricaSalEmp.Quantity = xRec.Quantity then
                            TabRubricaSalEmp.Quantity := Quantity;
                    end;

                    if xRec."Unit Value" <> "Unit Value" then begin
                        if TabRubricaSalEmp."Unit Value" = xRec."Unit Value" then
                            TabRubricaSalEmp."Unit Value" := "Unit Value";
                    end;

                    if xRec."Cód. Situação" <> "Cód. Situação" then begin
                        if TabRubricaSalEmp."Cód. Situação" = xRec."Cód. Situação" then
                            TabRubricaSalEmp."Cód. Situação" := "Cód. Situação";
                    end;

                    TabRubricaSalEmp.Modify;
                until TabRubricaSalEmp.Next = 0;
            end;
        end;


        //Pergunta se quer actualizar os registos que têm valor <> do antigo valor, com o novo valor
        //---------------------------------------------------------------------------------
        TabRubricaSalEmp.Reset;
        TabRubricaSalEmp.SetRange(TabRubricaSalEmp."Cód. Rúbrica Salarial", Código);
        TabRubricaSalEmp.SetFilter(TabRubricaSalEmp."Data Início", '<=%1|%2', WorkDate, 0D);
        TabRubricaSalEmp.SetFilter(TabRubricaSalEmp."Data Fim", '>=%1|=%2', WorkDate, 0D);
        if TabRubricaSalEmp.Find('-') then begin
            if Confirm(Text0002, true, Código) then begin
                repeat
                    if xRec."Payroll Item Type" <> "Payroll Item Type" then
                        TabRubricaSalEmp."Payroll Item Type" := "Payroll Item Type";

                    if xRec.Descrição <> Descrição then
                        TabRubricaSalEmp."Payroll Item Description" := Descrição;

                    if xRec."Debit Acc. No." <> "Debit Acc. No." then
                        TabRubricaSalEmp."Debit Acc. No." := "Debit Acc. No.";

                    if xRec."Credit Acc. No." <> "Credit Acc. No." then
                        TabRubricaSalEmp."Credit Acc. No." := "Credit Acc. No.";

                    if xRec.Quantity <> Quantity then
                        TabRubricaSalEmp.Quantity := Quantity;

                    if xRec."Unit Value" <> "Unit Value" then
                        TabRubricaSalEmp."Unit Value" := "Unit Value";

                    if xRec."Cód. Situação" <> "Cód. Situação" then
                        TabRubricaSalEmp."Cód. Situação" := "Cód. Situação";

                    TabRubricaSalEmp.Modify;
                until TabRubricaSalEmp.Next = 0;
            end;
        end;
    end;

    var
        TabRubricaSalLinhas: Record "Rubrica Salarial Linhas";
        TabRubricaSalEmp: Record "Rubrica Salarial Empregado";
        Text0001: Label 'Deseja actualizar a rúbrica %1 para os empregados que têm o valor antigo?';
        Text0002: Label 'Deseja actualizar a rúbrica %1 para os empregados que têm valor diferente do antigo?';
        Text0003: Label 'A Conta %1 é uma conta maior. Escolha uma conta auxiliar.';
        TabGLAccount: Record "G/L Account";
        Text0004: Label 'A rubrica %1, deve ser criada como filha da Seg. Social.';
}

