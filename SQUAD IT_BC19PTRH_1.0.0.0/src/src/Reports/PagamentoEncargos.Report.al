report 53077 "Pagamento Encargos"
{
    // //---------------------Pagamento de Vencimentos ------------------------
    // //Rotina que pega nos registos do Histórico Movs. de Empregado e os leva
    // //para um diario a fim de serem registados na contabilidade com os dados
    // //relativos ao pagamento dos e
    // //-----------------------------------------------------------------------

    Permissions = TableData "Hist. Cab. Movs. Empregado" = rimd,
                  TableData "Hist. Linhas Movs. Empregado" = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Empregado; Empregado)
        {
            RequestFilterFields = "No.", "Tipo Contribuinte";

            trigger OnAfterGetRecord()
            begin
                Clear(Valor);
                case TipoPagamento of
                    TipoPagamento::SSEmp:
                        TrazerNConta(3);
                    TipoPagamento::SSPat:
                        TrazerNConta(7);
                    TipoPagamento::CGAEmp:
                        TrazerNConta(9);
                    TipoPagamento::CGAPat:
                        TrazerNConta(12);
                    TipoPagamento::IRS:
                        begin
                            Clear(Valor);
                            TabHistLinhaMovEmp.Reset;
                            TabHistLinhaMovEmp.SetRange(TabHistLinhaMovEmp."Data Registo", DataInicio, DataFim);
                            TabHistLinhaMovEmp.SetRange(TabHistLinhaMovEmp."Employee No.", Empregado."No.");
                            TabHistLinhaMovEmp.SetRange(TabHistLinhaMovEmp.Pendente, true);
                            TabHistLinhaMovEmp.SetFilter(TabHistLinhaMovEmp.Valor, '<>%1', 0.0);
                            if TabHistLinhaMovEmp.FindFirst then begin
                                Empregado.TestField(Empregado."Nome Livro Diario Pag.");
                                Empregado.TestField(Empregado."Secção Diario Pag.");
                                // Ir buscar o ultimo Nº do Documento
                                TabSeccaoDiarioGeral.Reset;
                                TabSeccaoDiarioGeral.SetRange(TabSeccaoDiarioGeral."Journal Template Name", Empregado."Nome Livro Diario Pag.");
                                TabSeccaoDiarioGeral.SetRange(TabSeccaoDiarioGeral.Name, Empregado."Secção Diario Pag.");
                                if TabSeccaoDiarioGeral.FindFirst then begin
                                    Clear(NoSeriesMgt); //2008.12.10 para colocar todas as linhas com o mesmo nº documento
                                    NDocumento := NoSeriesMgt.GetNextNo(TabSeccaoDiarioGeral."No. Series", WorkDate, false);
                                end else
                                    Error(Text0002, Empregado."Nome Livro Diario Pag.", Empregado."Secção Diario Pag.");
                                repeat
                                    if (TabRubricaSalarial.Get(TabHistLinhaMovEmp."Cód. Rubrica")) and
                                      ((TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::IRS) or
                                      (TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::"IRS Sub. Férias") or
                                      (TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::"IRS Sub. Natal")) then begin
                                        TabRubricaSalEmpregado.Reset;
                                        TabRubricaSalEmpregado.SetRange(TabRubricaSalEmpregado."Employee No.", Empregado."No.");
                                        TabRubricaSalEmpregado.SetRange(TabRubricaSalEmpregado."Cód. Rúbrica Salarial", TabRubricaSalarial.Código);
                                        if (TabRubricaSalEmpregado.Find('+')) or (TabRubricaSalarial."Imposto Extraordinário" = true) then begin
                                            Valor := Valor + TabHistLinhaMovEmp.Valor;
                                            //Actualizar o Nº de Documento no Hist. Cab. Movs. Empregado
                                            if TabHistLinhaMovEmp.Valor <> 0 then begin
                                                TabHistLinhaMovEmp."Pago por No. Documento" := NDocumento;
                                                TabHistLinhaMovEmp.Modify;
                                            end;
                                        end;
                                    end;
                                until TabHistLinhaMovEmp.Next = 0;
                            end;
                            if Valor <> 0 then begin
                                // Ir buscar o ultimo nº linha usado
                                GenJnl.Reset;
                                GenJnl.SetRange(GenJnl."Journal Template Name", Empregado."Nome Livro Diario Pag.");
                                GenJnl.SetRange(GenJnl."Journal Batch Name", Empregado."Secção Diario Pag.");
                                if GenJnl.FindLast then
                                    LastMov := GenJnl."Line No."
                                else
                                    LastMov := 0;

                                //Ir buscar o Cód. Origem
                                TabCodSerie.Reset;
                                if TabCodSerie.Get() then;
                                TabCodSerie.TestField("Pagamento Vencimentos");
                                if GenLedgerSetup.Get() then;
                                LastMov := LastMov + 10000;
                                GenJnl.Init;
                                GenJnl.Validate("Journal Template Name", Empregado."Nome Livro Diario Pag.");
                                GenJnl.Validate("Journal Batch Name", Empregado."Secção Diario Pag.");
                                GenJnl.Validate("Line No.", LastMov);
                                GenJnl.Validate("Account Type", GenJnl."Account Type"::"G/L Account");
                                GenJnl.Validate("Account No.", TabRubricaSalEmpregado."Credit Acc. No.");
                                GenJnl.Validate("Posting Date", WorkDate);
                                GenJnl.Validate("Document Type", GenJnl."Document Type"::Payment);
                                GenJnl.Validate(GenJnl."Document No.", NDocumento);
                                GenJnl.Validate("Document Date", WorkDate);
                                GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"Bank Account"; //HG 2007.10.17
                                GenJnl.Validate("Bal. Account No.", TabConfigRH."No. Conta Pag. IRS");
                                if GenJnl."Bal. Account No." = '' then
                                    Error(Text0003);
                                GenJnl.Validate("Employee No.", Empregado."No.");
                                GenJnl.Validate("Debit Amount", Round(Abs(Valor), 0.01));//HG 2007.10.17 - coloquei abs
                                GenJnl."Source Code" := TabCodSerie."Pagamento Vencimentos";
                                GenJnl."Não deixa alterar No.Doc" := true; //para não deixar alterar o nº doc para não perdermos o rasto
                                                                           //2008.01.05 - para o caso do utilizador apagar as linhas do diario sem registar
                                                                           //nos sabermos a que processamento corresponde e desta forma tirarmos o pisco
                                                                           //do campo Integrado na Contabilidade
                                GenJnl."Cód. Processamento" := TabHistLinhaMovEmp."Cód. Processamento";
                                GenJnl.Insert;
                            end;
                        end;

                    TipoPagamento::ADSE:
                        TrazerNConta(14);
                    TipoPagamento::ADSEPat:
                        TrazerNConta(16);
                    TipoPagamento::FCT:
                        begin
                            Empregado.TestField(Empregado."Nome Livro Diario Pag.");
                            Empregado.TestField(Empregado."Secção Diario Pag.");
                            TabRubricaSalarial.Reset;
                            TabRubricaSalarial.SetRange(TabRubricaSalarial.Genero, TabRubricaSalarial.Genero::"FCT-FGCT");
                            if TabRubricaSalarial.FindSet then begin
                                repeat
                                    TabHistLinhaMovEmp.Reset;
                                    TabHistLinhaMovEmp.SetRange(TabHistLinhaMovEmp."Data Registo", DataInicio, DataFim);
                                    TabHistLinhaMovEmp.SetRange(TabHistLinhaMovEmp."Employee No.", Empregado."No.");
                                    TabHistLinhaMovEmp.SetRange(TabHistLinhaMovEmp.Pendente, true);
                                    TabHistLinhaMovEmp.SetFilter(TabHistLinhaMovEmp.Valor, '<>%1', 0.0);
                                    TabHistLinhaMovEmp.SetRange(TabHistLinhaMovEmp."Cód. Rubrica", TabRubricaSalarial.Código);
                                    if TabHistLinhaMovEmp.FindSet then begin
                                        Valor := TabHistLinhaMovEmp.Valor;
                                        // Ir buscar o ultimo nº linha usado
                                        GenJnl.Reset;
                                        GenJnl.SetRange(GenJnl."Journal Template Name", Empregado."Nome Livro Diario Pag.");
                                        GenJnl.SetRange(GenJnl."Journal Batch Name", Empregado."Secção Diario Pag.");
                                        if GenJnl.FindLast then
                                            LastMov := GenJnl."Line No."
                                        else
                                            LastMov := 0;

                                        // Ir buscar o ultimo Nº do Documento
                                        TabSeccaoDiarioGeral.Reset;
                                        TabSeccaoDiarioGeral.SetRange(TabSeccaoDiarioGeral."Journal Template Name", Empregado."Nome Livro Diario Pag.");
                                        TabSeccaoDiarioGeral.SetRange(TabSeccaoDiarioGeral.Name, Empregado."Secção Diario Pag.");
                                        if TabSeccaoDiarioGeral.Find('-') then begin
                                            Clear(NoSeriesMgt); //HG 2008.12.10 para colocar todas as linhas com o mesmo nº documento
                                            NDocumento := NoSeriesMgt.GetNextNo(TabSeccaoDiarioGeral."No. Series", WorkDate, false);
                                        end else
                                            Error(Text0002, Empregado."Nome Livro Diario Pag.", Empregado."Secção Diario Pag.");

                                        //Ir buscar o Cód. Origem
                                        TabCodSerie.Reset;
                                        if TabCodSerie.Get() then;
                                        TabCodSerie.TestField("Pagamento Vencimentos");

                                        if GenLedgerSetup.Get() then;

                                        LastMov := LastMov + 10000;
                                        GenJnl.Init;
                                        GenJnl.Validate("Journal Template Name", Empregado."Nome Livro Diario Pag.");
                                        GenJnl.Validate("Journal Batch Name", Empregado."Secção Diario Pag.");
                                        GenJnl.Validate("Line No.", LastMov);
                                        GenJnl.Validate("Account Type", GenJnl."Account Type"::"G/L Account");
                                        GenJnl.Validate("Account No.", TabHistLinhaMovEmp."Credit Acc. No.");
                                        GenJnl.Validate("Posting Date", WorkDate);
                                        GenJnl.Validate("Document Type", GenJnl."Document Type"::Payment);
                                        GenJnl.Validate(GenJnl."Document No.", NDocumento);
                                        GenJnl.Validate("Document Date", WorkDate);
                                        GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"Bank Account";
                                        GenJnl.Validate("Bal. Account No.", TabConfigRH."No. Conta Pag. Enc. FCT-FGCT");
                                        if GenJnl."Bal. Account No." = '' then
                                            Error(Text0003);
                                        GenJnl.Validate("Employee No.", Empregado."No.");
                                        GenJnl.Validate("Debit Amount", Round(Abs(Valor), 0.01));
                                        GenJnl."Source Code" := TabCodSerie."Pagamento Vencimentos";
                                        GenJnl."Não deixa alterar No.Doc" := true; //para não deixar alterar o nº doc para não perdermos o rasto
                                                                                   //2008.01.05 - para o caso do utilizador apagar as linhas do diario sem registar
                                                                                   //nos sabermos a que processamento corresponde e desta forma tirarmos o pisco
                                                                                   //do campo Integrado na Contabilidade
                                        GenJnl."Cód. Processamento" := TabHistLinhaMovEmp."Cód. Processamento";
                                        GenJnl.Insert;
                                        TabHistLinhaMovEmp."Pago por No. Documento" := NDocumento;
                                        TabHistLinhaMovEmp.Modify;
                                    end;
                                until TabRubricaSalarial.Next = 0;
                            end;
                        end;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Pagamento Encargos")
                {
                    Caption = 'Pagamento Encargos';
                    field(TipoPagamento; TipoPagamento)
                    {

                        Caption = 'Payment Type';
                        OptionCaption = 'Seg. Social Empregado,Seg. Social Entidade Patronal,CGA Empregado,CGA Entidade Patronal, IRS,ADSE,ADSE Ent. Patronal,Fundo de Compensação do Trabalho/FGCT';
                    }
                    field(DataInicio; DataInicio)
                    {

                        Caption = 'Data Inicio Processamento';
                    }
                    field(DataFim; DataFim)
                    {

                        Caption = 'Data Fim Processamento';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        Message(Text0001);
    end;

    trigger OnPreReport()
    begin
        if TabConfigRH.Get then;
    end;

    var
        Text0001: Label 'Processo concluído.';
        GenJnl: Record "Gen. Journal Line";
        LastMov: Integer;
        NDocumento: Code[20];
        NoSeriesMgt: Codeunit "No. Series";
        TabSeccaoDiarioGeral: Record "Gen. Journal Batch";
        TabRubricaSalarial: Record "Rubrica Salarial";
        TabRubricaSalEmpregado: Record "Rubrica Salarial Empregado";
        TabCodSerie: Record "Source Code Setup";
        TipoPagamento: Option SSEmp,SSPat,CGAEmp,CGAPat,IRS,ADSE,ADSEPat,FCT;
        TabHistLinhaMovEmp: Record "Hist. Linhas Movs. Empregado";
        TabConfigRH: Record "Config. Recursos Humanos";
        Text0002: Label 'Não existe Nº Documento para o Livro %1, secção %2.';
        Text0003: Label 'Especifique o Nº da conta de contrapartida em Config. Recursos Humanos, Pagamentos.';
        Valor: Decimal;
        DataInicio: Date;
        DataFim: Date;
        TabRubricaSalarialAux: Record "Rubrica Salarial";
        TabDistriCC: Record "Distribuição Custos";
        Text0004: Label 'Configure a Distribuição p/ Centro de Custo para o Empregado %1.';
        TabDistriDim: Record "Distribuição Custos";
        EmpDefaultDim: Record "Default Dimension";
        GenLedgerSetup: Record "General Ledger Setup";


    procedure TrazerNConta(genero: Integer)
    var
        AuxGenero: Integer;
    begin
        TabHistLinhaMovEmp.Reset;
        TabHistLinhaMovEmp.SetRange(TabHistLinhaMovEmp."Data Registo", DataInicio, DataFim);
        TabHistLinhaMovEmp.SetRange(TabHistLinhaMovEmp."Employee No.", Empregado."No.");
        TabHistLinhaMovEmp.SetRange(TabHistLinhaMovEmp.Pendente, true);
        TabHistLinhaMovEmp.SetFilter(TabHistLinhaMovEmp.Valor, '<>%1', 0.0);
        if TabHistLinhaMovEmp.FindSet then begin
            Empregado.TestField(Empregado."Nome Livro Diario Pag.");
            Empregado.TestField(Empregado."Secção Diario Pag.");
            repeat
                if (TabRubricaSalarial.Get(TabHistLinhaMovEmp."Cód. Rubrica")) and
                  (TabRubricaSalarial.Genero.AsInteger() = genero) then begin
                    Valor := TabHistLinhaMovEmp.Valor;
                    // Ir buscar o ultimo nº linha usado
                    GenJnl.Reset;
                    GenJnl.SetRange(GenJnl."Journal Template Name", Empregado."Nome Livro Diario Pag.");
                    GenJnl.SetRange(GenJnl."Journal Batch Name", Empregado."Secção Diario Pag.");
                    if GenJnl.FindLast then
                        LastMov := GenJnl."Line No."
                    else
                        LastMov := 0;

                    // Ir buscar o ultimo Nº do Documento
                    TabSeccaoDiarioGeral.Reset;
                    TabSeccaoDiarioGeral.SetRange(TabSeccaoDiarioGeral."Journal Template Name", Empregado."Nome Livro Diario Pag.");
                    TabSeccaoDiarioGeral.SetRange(TabSeccaoDiarioGeral.Name, Empregado."Secção Diario Pag.");
                    if TabSeccaoDiarioGeral.FindFirst then begin
                        Clear(NoSeriesMgt); //2008.12.10 para colocar todas as linhas com o mesmo nº documento
                        NDocumento := NoSeriesMgt.GetNextNo(TabSeccaoDiarioGeral."No. Series", WorkDate, false);
                    end else
                        Error(Text0002, Empregado."Nome Livro Diario Pag.", Empregado."Secção Diario Pag.");

                    //Ir buscar o Cód. Origem
                    TabCodSerie.Reset;
                    if TabCodSerie.Get() then;
                    TabCodSerie.TestField("Pagamento Vencimentos");
                    if GenLedgerSetup.Get() then;

                    LastMov := LastMov + 10000;
                    GenJnl.Init;
                    GenJnl.Validate("Journal Template Name", Empregado."Nome Livro Diario Pag.");
                    GenJnl.Validate("Journal Batch Name", Empregado."Secção Diario Pag.");
                    GenJnl.Validate("Line No.", LastMov);
                    GenJnl.Validate("Account Type", GenJnl."Account Type"::"G/L Account");

                    if genero = 7 then begin
                        TabRubricaSalarialAux.Reset;
                        if TabRubricaSalarialAux.Get(Empregado."Cód. Rúbrica Enc. Seg. Social") then
                            GenJnl.Validate("Account No.", TabRubricaSalarialAux."Credit Acc. No.");
                    end;

                    if genero = 12 then begin
                        TabRubricaSalarialAux.Reset;
                        if TabRubricaSalarialAux.Get(Empregado."Cód. Rúbrica Enc. CGA") then
                            GenJnl.Validate("Account No.", TabRubricaSalarialAux."Credit Acc. No.");
                    end;

                    if genero = 16 then begin
                        TabRubricaSalarialAux.Reset;
                        if TabRubricaSalarialAux.Get(Empregado."Cód. Rúbrica Enc. ADSE") then
                            GenJnl.Validate("Account No.", TabRubricaSalarialAux."Credit Acc. No.");
                    end;

                    if (genero <> 7) and (genero <> 12) and (genero <> 16) then begin
                        TabRubricaSalEmpregado.Reset;
                        TabRubricaSalEmpregado.SetRange(TabRubricaSalEmpregado."Employee No.", Empregado."No.");
                        TabRubricaSalEmpregado.SetRange(TabRubricaSalEmpregado."Cód. Rúbrica Salarial",
                          TabRubricaSalarial.Código);
                        if TabRubricaSalEmpregado.FindLast then
                            GenJnl.Validate("Account No.", TabRubricaSalEmpregado."Credit Acc. No.");
                    end;

                    GenJnl.Validate("Posting Date", WorkDate);
                    GenJnl.Validate("Document Type", GenJnl."Document Type"::Payment);
                    GenJnl.Validate(GenJnl."Document No.", NDocumento);
                    GenJnl.Validate("Document Date", WorkDate);
                    GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"Bank Account";

                    if genero = 3 then
                        GenJnl.Validate("Bal. Account No.", TabConfigRH."No. Conta Pag. Enc. SSocialEmp");
                    if genero = 7 then
                        GenJnl.Validate("Bal. Account No.", TabConfigRH."No. Conta Pag. Enc. SSocialPat");
                    if genero = 9 then
                        GenJnl.Validate("Bal. Account No.", TabConfigRH."No. Conta Pag. Enc. CGA Emp");
                    if genero = 12 then
                        GenJnl.Validate("Bal. Account No.", TabConfigRH."No. Conta Pag. Enc. CGA Pat");
                    if genero = 2 then
                        GenJnl.Validate("Bal. Account No.", TabConfigRH."No. Conta Pag. IRS");
                    if genero = 14 then
                        GenJnl.Validate("Bal. Account No.", TabConfigRH."No. Conta Pag. Enc. ADSE");
                    if genero = 16 then
                        GenJnl.Validate("Bal. Account No.", TabConfigRH."No. Conta Pag. Enc. ADSE Pat");

                    if GenJnl."Bal. Account No." = '' then
                        Error(Text0003);
                    GenJnl.Validate("Employee No.", Empregado."No.");
                    GenJnl.Validate("Debit Amount", Round(Abs(Valor), 0.01));
                    GenJnl."Source Code" := TabCodSerie."Pagamento Vencimentos";
                    GenJnl."Não deixa alterar No.Doc" := true; //para não deixar alterar o nº doc para não perdermos o rasto

                    //2008.01.05 - para o caso do utilizador apagar as linhas do diario sem registar
                    //nos sabermos a que processamento corresponde e desta forma tirarmos o pisco
                    //do campo Integrado na Contabilidade
                    GenJnl."Cód. Processamento" := TabHistLinhaMovEmp."Cód. Processamento";
                    GenJnl.Insert;
                    //Actualizar o Nº de Documento no Hist. Cab. Movs. Empregado
                    TabHistLinhaMovEmp."Pago por No. Documento" := NDocumento;
                    TabHistLinhaMovEmp.Modify;
                end;
            until TabHistLinhaMovEmp.Next = 0;
        end;
    end;
}

