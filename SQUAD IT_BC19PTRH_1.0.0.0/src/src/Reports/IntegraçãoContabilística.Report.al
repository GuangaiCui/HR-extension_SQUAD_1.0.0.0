report 53047 "Integração Contabilística"
{
    // //---------------------Integração Contabilistica ------------------------
    // //Rotina que pega nos registos do Histórico Movs. de Empregado e os leva
    // //para um diario a fim de serem registados na contabilidade
    // //-----------------------------------------------------------------------
    // 
    //  IT005 - Tagus - 20191126 - querem o mesmo numero de documento para todos os empregados e com alteração do nº série
    UsageCategory = Tasks;
    ApplicationArea = HumanResourcesAppArea;

    Permissions = TableData "Integração Contabilistica" = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Periodos Processamento"; "Periodos Processamento")
        {
            DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento");
            dataitem("Movs. Empregado"; "Hist. Linhas Movs. Empregado")
            {
                DataItemLink = "Cód. Processamento" = FIELD("Cód. Processamento");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado", "No. Linha");

                trigger OnAfterGetRecord()
                begin
                    if ("Movs. Empregado".Valor = 0.0) or (("Movs. Empregado"."No. Conta a Debitar" = '') and ("Movs. Empregado"."No. Conta a Creditar" = '')) then
                        CurrReport.Skip; //não enviar valores a zero

                    //-----------------------------------------------------------
                    //---------------------FASE - 1------------------------------
                    //Passa os registos da tabela Hist. Movs. Empregado
                    //para a tabela Integração Contabilistica,
                    //criado por registo duas linhas (uma com o valor a Crédito e
                    //e outra a Débito)
                    //-----------------------------------------------------------

                    //----------------------------------------------------------------
                    //Testa se as contas estão preenchidas e se são menores e se existem, caso contrario dá um aviso
                    //-----------------------------------------------------------------
                    /*
                    IF "Movs. Empregado"."No. Conta a Debitar" = '' THEN
                       MESSAGE(Text0005,"Movs. Empregado"."Descrição Rubrica","Movs. Empregado"."No. Empregado");
                    
                    IF "Movs. Empregado"."No. Conta a Creditar" = '' THEN
                       MESSAGE(Text0005,"Movs. Empregado"."Descrição Rubrica","Movs. Empregado"."No. Empregado");
                    
                    IF TabContaAux.GET("Movs. Empregado"."No. Conta a Debitar") THEN BEGIN
                       IF TabContaAux."Account Type" = TabContaAux."Account Type"::Heading THEN
                          MESSAGE(Text0006,"Movs. Empregado"."No. Empregado","Movs. Empregado"."No. Conta a Debitar"
                                  ,"Movs. Empregado"."Descrição Rubrica");
                    END ELSE
                      MESSAGE(Text0007,"Movs. Empregado"."No. Conta a Debitar");
                    
                    IF TabContaAux.GET("Movs. Empregado"."No. Conta a Creditar") THEN BEGIN
                       IF TabContaAux."Account Type" = TabContaAux."Account Type"::Heading THEN
                          MESSAGE(Text0006,"Movs. Empregado"."No. Empregado","Movs. Empregado"."No. Conta a Creditar"
                                  ,"Movs. Empregado"."Descrição Rubrica");
                    END ELSE
                      MESSAGE(Text0007,"Movs. Empregado"."No. Conta a Creditar");
                    */
                    //-----------------------------------
                    //Faltas com contas diferentes
                    //-----------------------------------
                    //Se for falta então temos de ver se temos de distribuir por várias rubricas

                    Clear(TotAbonos);
                    TabRubSal.Reset;
                    if TabRubSal.Get("Movs. Empregado"."Cód. Rubrica") then begin
                        if TabRubSal.Genero = TabRubSal.Genero::Falta then begin
                            //Percorrer todos os abonos deste empregado e soma o valor daqueles
                            //que são do tipo vencimento base e/ou tem o pisco no campo faltas
                            AuxLinhasMovEmp.Reset;
                            AuxLinhasMovEmp.SetRange(AuxLinhasMovEmp."Cód. Processamento", "Movs. Empregado"."Cód. Processamento");
                            AuxLinhasMovEmp.SetRange(AuxLinhasMovEmp."No. Empregado", "Movs. Empregado"."No. Empregado");
                            AuxLinhasMovEmp.SetRange(AuxLinhasMovEmp."Tipo Rubrica", AuxLinhasMovEmp."Tipo Rubrica"::Abono);
                            if AuxLinhasMovEmp.FindSet then begin
                                repeat
                                    TabRubSal2.Reset;
                                    if TabRubSal2.Get(AuxLinhasMovEmp."Cód. Rubrica") then
                                        if (TabRubSal2.Faults = true) or (TabRubSal2.Genero = TabRubSal2.Genero::"Vencimento Base") then
                                            TotAbonos := TotAbonos + AuxLinhasMovEmp.Valor;
                                until AuxLinhasMovEmp.Next = 0;
                            end;

                            //Percorrer todos os abonos deste empregado que são do tipo vencimento base e/ou tem o pisco no campo faltas
                            //e criar uma linha na tabela temporária com o valor respectivo da falta
                            Clear(TempLinhasMovEmp);
                            Clear(NLinha2);
                            AuxLinhasMovEmp.Reset;
                            AuxLinhasMovEmp.SetRange(AuxLinhasMovEmp."Cód. Processamento", "Movs. Empregado"."Cód. Processamento");
                            AuxLinhasMovEmp.SetRange(AuxLinhasMovEmp."No. Empregado", "Movs. Empregado"."No. Empregado");
                            AuxLinhasMovEmp.SetRange(AuxLinhasMovEmp."Tipo Rubrica", AuxLinhasMovEmp."Tipo Rubrica"::Abono);
                            if AuxLinhasMovEmp.FindSet then begin
                                repeat
                                    TabRubSal2.Reset;
                                    if TabRubSal2.Get(AuxLinhasMovEmp."Cód. Rubrica") then
                                        if (TabRubSal2.Faults) or (TabRubSal2.Genero = TabRubSal2.Genero::"Vencimento Base") then begin
                                            NLinha2 := NLinha2 + 10000;
                                            TempLinhasMovEmp.Init;
                                            TempLinhasMovEmp.TransferFields("Movs. Empregado");
                                            TempLinhasMovEmp."No. Linha" := NLinha2;
                                            TempLinhasMovEmp."No. Conta a Creditar" := AuxLinhasMovEmp."No. Conta a Debitar";
                                            TempLinhasMovEmp.Valor := "Movs. Empregado".Valor * AuxLinhasMovEmp.Valor / TotAbonos;
                                            TempLinhasMovEmp.Insert;
                                        end;
                                until AuxLinhasMovEmp.Next = 0;
                            end;
                            if TempLinhasMovEmp.FindSet then begin
                                repeat
                                    InsertIntegracaoContab(TempLinhasMovEmp);
                                until TempLinhasMovEmp.Next = 0;
                            end;
                            TempLinhasMovEmp.DeleteAll;
                        end else
                            InsertIntegracaoContab("Movs. Empregado");
                    end;

                end;

                trigger OnPreDataItem()
                begin
                    //Nº de linha
                    NLinha := 0;
                end;
            }
            dataitem(DimDistribuir; "Integração Contabilistica")
            {
                DataItemLink = "Cód. Processamento" = FIELD("Cód. Processamento");
                DataItemTableView = SORTING("No. Empregado", "Cód. Rubrica") WHERE("No. Conta" = FILTER('6*'));

                trigger OnAfterGetRecord()
                var
                    TotalPercentagem: Decimal;
                    EmpDefaultDim: Record "Default Dimension";
                    AuxEmpDefaultDim: Record "Default Dimension";
                begin
                    //-----------------------------------------------------------
                    //---------------------FASE - 2------------------------------
                    //Só entra aqui se estivermos a usar as Dimensões,
                    //nesse caso temos apanhar só as contas de custos (6*)
                    //e fazer a distribuição pelas percentagens definidas
                    //-----------------------------------------------------------

                    //Testa se as linhas de distribuição perfazem um total de 100%
                    //************************************************************************************************

                    /*IT005
                    //Ir buscar o último nº de linha usado
                    GenJnl.RESET;
                    GenJnl.SETRANGE(GenJnl."Journal Template Name",TabConfRH."Nome Livro Diario");
                    GenJnl.SETRANGE(GenJnl."Journal Batch Name",TabConfRH."Secção Diario");
                    IF GenJnl.FINDLAST THEN
                      LastMov := GenJnl."Line No."
                    ELSE
                      LastMov := 0;
                    
                    // Ir buscar o ultimo Nº do Documento
                    CLEAR(NoSeriesMgt);
                    TabSeccaoDiarioGeral.RESET;
                    TabSeccaoDiarioGeral.SETRANGE(TabSeccaoDiarioGeral."Journal Template Name",TabConfRH."Nome Livro Diario");
                    TabSeccaoDiarioGeral.SETRANGE(TabSeccaoDiarioGeral.Name,TabConfRH."Secção Diario");
                    IF TabSeccaoDiarioGeral.FIND('-') THEN
                      NDocumento := NoSeriesMgt.GetNextNo(TabSeccaoDiarioGeral."No. Series",WORKDATE,FALSE)
                    ELSE
                      NDocumento := '';
                    */

                    GenJnlBatch.Reset;

                    //Percorre os registos associados a este empregado para distribuir o valor pelas percentagens
                    //************************************************************************************************

                    // Este If é por causa das horas extra que podem vir com dimensão já definida e então ignora a distribuição
                    if DimDistribuir."Global Dimension 1 Code" = '' then begin
                        TabEmpregadoDistribCustos.Reset;
                        TabEmpregadoDistribCustos.SetRange(TabEmpregadoDistribCustos."No. Empregado", DimDistribuir."No. Empregado");
                        if TabEmpregadoDistribCustos.FindSet then begin
                            repeat
                                if (TabEmpregadoDistribCustos."Data Inicio" <= "Periodos Processamento"."Data Inicio Processamento") and
                                  (TabEmpregadoDistribCustos."Data Fim" >= "Periodos Processamento"."Data Fim Processamento") then begin
                                    LastMov := LastMov + 10000;
                                    // Ir buscar o Cód. Origem
                                    TabCodSerie.Reset;
                                    if TabCodSerie.Get() then
                                        TabCodSerie.TestField("Integração Vencimentos");

                                    GenJnl.Init;
                                    GenJnl.Validate("Journal Template Name", TabConfRH."Nome Livro Diario");
                                    GenJnl.Validate("Journal Batch Name", TabConfRH."Secção Diario");
                                    GenJnl.Validate("Line No.", LastMov);
                                    GenJnl.Validate("Account Type", GenJnl."Account Type"::"G/L Account");
                                    GenJnl.Validate("Account No.", DimDistribuir."No. Conta");
                                    GenJnl.Validate("Posting Date", DimDistribuir."Data Registo");

                                    //Ir buscar a Descrição da conta
                                    TabConta.Reset;
                                    TabConta.SetRange(TabConta."No.", DimDistribuir."No. Conta");
                                    if TabConta.Find('-') then
                                        GenJnl.Validate(Description, TabConta.Name);

                                    GenJnl."Document No." := NDocumento;

                                    if DimDistribuir."Valor Débito" <> 0 then
                                        GenJnl.Validate("Debit Amount", DimDistribuir."Valor Débito" * TabEmpregadoDistribCustos.Percentagem);

                                    if DimDistribuir."Valor Crédito" <> 0 then
                                        GenJnl.Validate("Credit Amount", DimDistribuir."Valor Crédito" * TabEmpregadoDistribCustos.Percentagem);

                                    //Fazer a distribuição
                                    if TabEmpregadoDistribCustos."Global Dimension 1 Code" <> '' then
                                        GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code", TabEmpregadoDistribCustos."Global Dimension 1 Code");

                                    if TabEmpregadoDistribCustos."Global Dimension 2 Code" <> '' then
                                        GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code", TabEmpregadoDistribCustos."Global Dimension 2 Code");

                                    if TabEmpregadoDistribCustos."Shortcut Dimension 3 Code" <> '' then
                                        DimMgt.ValidateShortcutDimValues(3, TabEmpregadoDistribCustos."Shortcut Dimension 3 Code", GenJnl."Dimension Set ID");

                                    if TabEmpregadoDistribCustos."Shortcut Dimension 4 Code" <> '' then
                                        DimMgt.ValidateShortcutDimValues(4, TabEmpregadoDistribCustos."Shortcut Dimension 4 Code", GenJnl."Dimension Set ID");

                                    if TabEmpregadoDistribCustos."Shortcut Dimension 5 Code" <> '' then
                                        DimMgt.ValidateShortcutDimValues(5, TabEmpregadoDistribCustos."Shortcut Dimension 5 Code", GenJnl."Dimension Set ID");

                                    if TabEmpregadoDistribCustos."Shortcut Dimension 6 Code" <> '' then
                                        DimMgt.ValidateShortcutDimValues(6, TabEmpregadoDistribCustos."Shortcut Dimension 6 Code", GenJnl."Dimension Set ID");

                                    if TabEmpregadoDistribCustos."Shortcut Dimension 7 Code" <> '' then
                                        DimMgt.ValidateShortcutDimValues(7, TabEmpregadoDistribCustos."Shortcut Dimension 7 Code", GenJnl."Dimension Set ID");

                                    if TabEmpregadoDistribCustos."Shortcut Dimension 8 Code" <> '' then
                                        DimMgt.ValidateShortcutDimValues(8, TabEmpregadoDistribCustos."Shortcut Dimension 8 Code", GenJnl."Dimension Set ID");

                                    GenJnl."No. Empregado" := DimDistribuir."No. Empregado";
                                    GenJnl."Source Code" := TabCodSerie."Integração Vencimentos";
                                    //Para o caso do utilizador apagar as linhas do diario sem registar
                                    //nos sabermos a que processamento corresponde e desta forma tirarmos o pisco
                                    //do campo Integrado na Contabilidade
                                    GenJnl."Cód. Processamento" := "Periodos Processamento"."Cód. Processamento";
                                    GenJnl."Posting No. Series" := nSerieReg;//IT005
                                    GenJnl.Insert;
                                end;
                            until TabEmpregadoDistribCustos.Next = 0;
                        end else begin
                            //Se o Empregado não tem distribuição de custos vai buscar o que estiver na ficha
                            //************************************************************************************************
                            EmpDefaultDim.Reset;
                            EmpDefaultDim.SetRange(EmpDefaultDim."Table ID", 53035);
                            EmpDefaultDim.SetRange(EmpDefaultDim."No.", DimDistribuir."No. Empregado");
                            EmpDefaultDim.SetFilter(EmpDefaultDim."Dimension Value Code", '<>%1', '');
                            if EmpDefaultDim.FindFirst then begin
                                LastMov := LastMov + 10000;
                                // Ir buscar o Cód. Origem
                                TabCodSerie.Reset;
                                if TabCodSerie.Get() then
                                    TabCodSerie.TestField("Integração Vencimentos");

                                GenJnl.Init;
                                GenJnl.Validate("Journal Template Name", TabConfRH."Nome Livro Diario");
                                GenJnl.Validate("Journal Batch Name", TabConfRH."Secção Diario");
                                GenJnl.Validate("Line No.", LastMov);
                                GenJnl.Validate("Account Type", GenJnl."Account Type"::"G/L Account");
                                GenJnl.Validate("Account No.", DimDistribuir."No. Conta");
                                GenJnl.Validate("Posting Date", DimDistribuir."Data Registo");

                                //Ir buscar a Descrição da conta
                                TabConta.Reset;
                                TabConta.SetRange(TabConta."No.", DimDistribuir."No. Conta");
                                if TabConta.FindFirst then
                                    GenJnl.Validate(Description, TabConta.Name);

                                GenJnl."Document No." := NDocumento;

                                if DimDistribuir."Valor Débito" <> 0 then
                                    GenJnl.Validate("Debit Amount", DimDistribuir."Valor Débito");

                                if DimDistribuir."Valor Crédito" <> 0 then
                                    GenJnl.Validate("Credit Amount", DimDistribuir."Valor Crédito");
                                if GenLedgerSetup."Global Dimension 1 Code" <> '' then begin
                                    AuxEmpDefaultDim.Reset;
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."Table ID", 53035);
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."No.", DimDistribuir."No. Empregado");
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."Dimension Code", GenLedgerSetup."Global Dimension 1 Code");
                                    AuxEmpDefaultDim.SetFilter(AuxEmpDefaultDim."Dimension Value Code", '<>%1', '');
                                    if AuxEmpDefaultDim.Find('-') then
                                        GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code", AuxEmpDefaultDim."Dimension Value Code");
                                end;

                                if GenLedgerSetup."Global Dimension 2 Code" <> '' then begin
                                    AuxEmpDefaultDim.Reset;
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."Table ID", 53035);
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."No.", DimDistribuir."No. Empregado");
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."Dimension Code", GenLedgerSetup."Global Dimension 2 Code");
                                    AuxEmpDefaultDim.SetFilter(AuxEmpDefaultDim."Dimension Value Code", '<>%1', '');
                                    if AuxEmpDefaultDim.Find('-') then
                                        GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code", AuxEmpDefaultDim."Dimension Value Code");
                                end;

                                if GenLedgerSetup."Shortcut Dimension 3 Code" <> '' then begin
                                    AuxEmpDefaultDim.Reset;
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."Table ID", 53035);
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."No.", DimDistribuir."No. Empregado");
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."Dimension Code", GenLedgerSetup."Shortcut Dimension 3 Code");
                                    AuxEmpDefaultDim.SetFilter(AuxEmpDefaultDim."Dimension Value Code", '<>%1', '');
                                    if AuxEmpDefaultDim.Find('-') then
                                        DimMgt.ValidateShortcutDimValues(3, AuxEmpDefaultDim."Dimension Value Code", GenJnl."Dimension Set ID");
                                end;

                                if GenLedgerSetup."Shortcut Dimension 4 Code" <> '' then begin
                                    AuxEmpDefaultDim.Reset;
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."Table ID", 53035);
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."No.", DimDistribuir."No. Empregado");
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."Dimension Code", GenLedgerSetup."Shortcut Dimension 4 Code");
                                    AuxEmpDefaultDim.SetFilter(AuxEmpDefaultDim."Dimension Value Code", '<>%1', '');
                                    if AuxEmpDefaultDim.Find('-') then
                                        DimMgt.ValidateShortcutDimValues(4, AuxEmpDefaultDim."Dimension Value Code", GenJnl."Dimension Set ID");
                                end;

                                if GenLedgerSetup."Shortcut Dimension 5 Code" <> '' then begin
                                    AuxEmpDefaultDim.Reset;
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."Table ID", 53035);
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."No.", DimDistribuir."No. Empregado");
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."Dimension Code", GenLedgerSetup."Shortcut Dimension 5 Code");
                                    AuxEmpDefaultDim.SetFilter(AuxEmpDefaultDim."Dimension Value Code", '<>%1', '');
                                    if AuxEmpDefaultDim.Find('-') then
                                        DimMgt.ValidateShortcutDimValues(5, AuxEmpDefaultDim."Dimension Value Code", GenJnl."Dimension Set ID");
                                end;

                                if GenLedgerSetup."Shortcut Dimension 6 Code" <> '' then begin
                                    AuxEmpDefaultDim.Reset;
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."Table ID", 53035);
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."No.", DimDistribuir."No. Empregado");
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."Dimension Code", GenLedgerSetup."Shortcut Dimension 6 Code");
                                    AuxEmpDefaultDim.SetFilter(AuxEmpDefaultDim."Dimension Value Code", '<>%1', '');
                                    if AuxEmpDefaultDim.Find('-') then
                                        DimMgt.ValidateShortcutDimValues(6, AuxEmpDefaultDim."Dimension Value Code", GenJnl."Dimension Set ID");
                                end;

                                if GenLedgerSetup."Shortcut Dimension 7 Code" <> '' then begin
                                    AuxEmpDefaultDim.Reset;
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."Table ID", 53035);
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."No.", DimDistribuir."No. Empregado");
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."Dimension Code", GenLedgerSetup."Shortcut Dimension 7 Code");
                                    AuxEmpDefaultDim.SetFilter(AuxEmpDefaultDim."Dimension Value Code", '<>%1', '');
                                    if AuxEmpDefaultDim.Find('-') then
                                        DimMgt.ValidateShortcutDimValues(7, AuxEmpDefaultDim."Dimension Value Code", GenJnl."Dimension Set ID");
                                end;

                                if GenLedgerSetup."Shortcut Dimension 8 Code" <> '' then begin
                                    AuxEmpDefaultDim.Reset;
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."Table ID", 53035);
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."No.", DimDistribuir."No. Empregado");
                                    AuxEmpDefaultDim.SetRange(AuxEmpDefaultDim."Dimension Code", GenLedgerSetup."Shortcut Dimension 8 Code");
                                    AuxEmpDefaultDim.SetFilter(AuxEmpDefaultDim."Dimension Value Code", '<>%1', '');
                                    if AuxEmpDefaultDim.Find('-') then
                                        DimMgt.ValidateShortcutDimValues(8, AuxEmpDefaultDim."Dimension Value Code", GenJnl."Dimension Set ID");
                                end;

                                GenJnl."No. Empregado" := DimDistribuir."No. Empregado";
                                GenJnl."Source Code" := TabCodSerie."Integração Vencimentos";
                                //Para o caso do utilizador apagar as linhas do diario sem registar
                                //nos sabermos a que processamento corresponde e desta forma tirarmos o pisco
                                //do campo Integrado na Contabilidade
                                GenJnl."Cód. Processamento" := "Periodos Processamento"."Cód. Processamento";
                                GenJnl."Posting No. Series" := nSerieReg;//IT005
                                GenJnl.Insert;

                            end else begin
                                //Se o Empregado tb não tem dimensões parametrizadas na sua ficha então não distribui
                                //************************************************************************************************
                                LastMov := LastMov + 10000;
                                // Ir buscar o Cód. Origem
                                TabCodSerie.Reset;
                                if TabCodSerie.Get() then
                                    TabCodSerie.TestField("Integração Vencimentos");

                                GenJnl.Init;
                                GenJnl.Validate("Journal Template Name", TabConfRH."Nome Livro Diario");
                                GenJnl.Validate("Journal Batch Name", TabConfRH."Secção Diario");
                                GenJnl.Validate("Line No.", LastMov);
                                GenJnl.Validate("Account Type", GenJnl."Account Type"::"G/L Account");
                                GenJnl.Validate("Account No.", DimDistribuir."No. Conta");
                                GenJnl.Validate("Posting Date", DimDistribuir."Data Registo");

                                //Ir buscar a Descrição da conta
                                TabConta.Reset;
                                TabConta.SetRange(TabConta."No.", DimDistribuir."No. Conta");
                                if TabConta.FindFirst then
                                    GenJnl.Validate(Description, TabConta.Name);

                                GenJnl."Document No." := NDocumento;

                                if DimDistribuir."Valor Débito" <> 0 then
                                    GenJnl.Validate("Debit Amount", DimDistribuir."Valor Débito");

                                if DimDistribuir."Valor Crédito" <> 0 then
                                    GenJnl.Validate("Credit Amount", DimDistribuir."Valor Crédito");

                                GenJnl."No. Empregado" := DimDistribuir."No. Empregado";
                                GenJnl."Source Code" := TabCodSerie."Integração Vencimentos";
                                GenJnl."Dimension Set ID" := DimDistribuir."Dimension Set ID";
                                //Para o caso do utilizador apagar as linhas do diario sem registar
                                //nos sabermos a que processamento corresponde e desta forma tirarmos o pisco
                                //do campo Integrado na Contabilidade
                                GenJnl."Cód. Processamento" := "Periodos Processamento"."Cód. Processamento";
                                GenJnl."Posting No. Series" := nSerieReg;//IT005
                                GenJnl.Insert;
                            end;
                        end;
                    end else begin
                        LastMov := LastMov + 10000;
                        GenJnl.Init;
                        GenJnl.Validate("Journal Template Name", TabConfRH."Nome Livro Diario");
                        GenJnl.Validate("Journal Batch Name", TabConfRH."Secção Diario");
                        GenJnl.Validate("Line No.", LastMov);
                        GenJnl.Validate("Account Type", GenJnl."Account Type"::"G/L Account");
                        GenJnl.Validate("Account No.", DimDistribuir."No. Conta");
                        GenJnl.Validate("Posting Date", DimDistribuir."Data Registo");

                        //Ir buscar a Descrição da conta
                        TabConta.Reset;
                        TabConta.SetRange(TabConta."No.", DimDistribuir."No. Conta");
                        if TabConta.FindFirst then
                            GenJnl.Validate(Description, TabConta.Name);

                        GenJnl."Document No." := NDocumento;

                        if DimDistribuir."Valor Débito" <> 0 then
                            GenJnl.Validate("Debit Amount", DimDistribuir."Valor Débito");

                        if DimDistribuir."Valor Crédito" <> 0 then
                            GenJnl.Validate("Credit Amount", DimDistribuir."Valor Crédito");

                        GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code", DimDistribuir."Global Dimension 1 Code");
                        GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code", DimDistribuir."Global Dimension 2 Code");
                        GenJnl."No. Empregado" := DimDistribuir."No. Empregado";
                        GenJnl."Posting No. Series" := nSerieReg;//IT005
                        GenJnl.Insert;
                    end;

                end;
            }
            dataitem(DimNDistribuir; "Integração Contabilistica")
            {
                DataItemLink = "Cód. Processamento" = FIELD("Cód. Processamento");
                DataItemTableView = SORTING("No. Conta") WHERE("No. Conta" = FILTER(<> '6*'));

                trigger OnAfterGetRecord()
                begin
                    if flag then begin
                        NConta := DimNDistribuir."No. Conta";
                        flag := false;
                    end;

                    if NConta = DimNDistribuir."No. Conta" then begin
                        TotDeb := TotDeb + DimNDistribuir."Valor Débito";
                        TotCre := TotCre + DimNDistribuir."Valor Crédito";
                    end;

                    //-----------------------------------------------------------
                    //---------------------FASE - 3A----------------------------
                    //Só entra aqui se estivermos a usar as Dimensões,
                    //nesse caso temos apanhar as restantes contas (<>6*)
                    //e enviar para o diario sem dimensões
                    //-----------------------------------------------------------


                    //-------------------------------------------------------
                    //Se escolheu agrupar as contas balanço, então só passam por
                    //aqui as contas que não são balanço e que são <>6*
                    //Se não escolheu agrupar as contas balanço então, passam
                    //por aqui todas as contas <>6*
                    //-------------------------------------------------------

                    TabConta.Reset;
                    TabConta.SetRange(TabConta."No.", DimNDistribuir."No. Conta");
                    if TabConta.Find('-') then begin

                        if ((AgruparContasBalanco) and (TabConta."Income/Balance" <> TabConta."Income/Balance"::"Balance Sheet")) or
                            ((not AgruparContasBalanco)) then begin

                            /*IT005
                            //Ir buscar o último nº de linha usado
                            GenJnl.RESET;
                            GenJnl.SETRANGE(GenJnl."Journal Template Name",TabConfRH."Nome Livro Diario");
                            GenJnl.SETRANGE(GenJnl."Journal Batch Name",TabConfRH."Secção Diario");
                            IF GenJnl.FINDLAST THEN
                              LastMov := GenJnl."Line No."
                            ELSE
                              LastMov := 0;

                            // Ir buscar o ultimo Nº do Documento
                            CLEAR(NoSeriesMgt);
                            TabSeccaoDiarioGeral.RESET;
                            TabSeccaoDiarioGeral.SETRANGE(TabSeccaoDiarioGeral."Journal Template Name",TabConfRH."Nome Livro Diario");
                            TabSeccaoDiarioGeral.SETRANGE(TabSeccaoDiarioGeral.Name,TabConfRH."Secção Diario");
                            IF TabSeccaoDiarioGeral.FINDFIRST THEN
                              NDocumento := NoSeriesMgt.GetNextNo(TabSeccaoDiarioGeral."No. Series",WORKDATE,FALSE)
                            ELSE
                              NDocumento := '';
                            */

                            GenJnlBatch.Reset;

                            LastMov := LastMov + 10000;

                            // Ir buscar o Cód. Origem
                            TabCodSerie.Reset;
                            if TabCodSerie.Get() then
                                TabCodSerie.TestField("Integração Vencimentos");

                            GenJnl.Init;
                            GenJnl.Validate("Journal Template Name", TabConfRH."Nome Livro Diario");
                            GenJnl.Validate("Journal Batch Name", TabConfRH."Secção Diario");
                            GenJnl.Validate("Line No.", LastMov);
                            GenJnl.Validate("Account Type", GenJnl."Account Type"::"G/L Account");
                            GenJnl.Validate("Account No.", DimNDistribuir."No. Conta");
                            GenJnl.Validate("Posting Date", DimNDistribuir."Data Registo");

                            //Ir buscar a Descrição da conta
                            TabConta.Reset;
                            TabConta.SetRange(TabConta."No.", DimNDistribuir."No. Conta");
                            if TabConta.Find('-') then
                                GenJnl.Validate(Description, TabConta.Name);

                            GenJnl."Document No." := NDocumento;

                            if DimNDistribuir."Valor Débito" <> 0 then
                                GenJnl.Validate("Debit Amount", DimNDistribuir."Valor Débito");

                            if DimNDistribuir."Valor Crédito" <> 0 then
                                GenJnl.Validate("Credit Amount", DimNDistribuir."Valor Crédito");

                            GenJnl."No. Empregado" := DimNDistribuir."No. Empregado";
                            GenJnl."Source Code" := TabCodSerie."Integração Vencimentos";
                            //Para o caso do utilizador apagar as linhas do diario sem registar
                            //nos sabermos a que processamento corresponde e desta forma tirarmos o pisco
                            //do campo Integrado na Contabilidade
                            GenJnl."Cód. Processamento" := "Periodos Processamento"."Cód. Processamento";
                            GenJnl."Posting No. Series" := nSerieReg;//IT005
                            GenJnl.Insert;
                        end;
                    end;

                    if NConta <> DimNDistribuir."No. Conta" then begin
                        //-----------------------------------------------------------
                        //---------------------FASE - 3 B----------------------------
                        //Só entra aqui se não estivermos a utilizar a Distribuição por CC
                        //Nesse caso usamos as Dimensões e então temos de ir apanhar
                        //as restantes contas (<>6*) e que são balanço, agrupá-las e
                        //envia-las para o diario sem dimensões
                        //-----------------------------------------------------------

                        //-------------------------------------------------------
                        //Se escolheu agrupar as contas balanço, então só passam por
                        //aqui as contas quesão balanço e que são <>6*
                        //-------------------------------------------------------

                        TabConta.Reset;
                        TabConta.SetRange(TabConta."No.", DimNDistribuir."No. Conta");
                        if TabConta.FindFirst then begin
                            if (AgruparContasBalanco) and (TabConta."Income/Balance" = TabConta."Income/Balance"::"Balance Sheet") then begin

                                /*IT005
                                //Ir buscar o último nº de linha usado
                                GenJnl.RESET;
                                GenJnl.SETRANGE(GenJnl."Journal Template Name",TabConfRH."Nome Livro Diario");
                                GenJnl.SETRANGE(GenJnl."Journal Batch Name",TabConfRH."Secção Diario");
                                IF GenJnl.FINDLAST THEN
                                   LastMov := GenJnl."Line No."
                                ELSE
                                   LastMov := 0;

                                // Ir buscar o ultimo Nº do Documento
                                CLEAR(NoSeriesMgt);
                                TabSeccaoDiarioGeral.RESET;
                                TabSeccaoDiarioGeral.SETRANGE(TabSeccaoDiarioGeral."Journal Template Name",TabConfRH."Nome Livro Diario");
                                TabSeccaoDiarioGeral.SETRANGE(TabSeccaoDiarioGeral.Name,TabConfRH."Secção Diario");
                                IF TabSeccaoDiarioGeral.FIND('-') THEN
                                  NDocumento := NoSeriesMgt.GetNextNo(TabSeccaoDiarioGeral."No. Series",WORKDATE,FALSE)
                                ELSE
                                  NDocumento := '';
                                */

                                GenJnlBatch.Reset;

                                LastMov := LastMov + 10000;

                                // Ir buscar o Cód. Origem
                                TabCodSerie.Reset;
                                if TabCodSerie.Get() then
                                    TabCodSerie.TestField("Integração Vencimentos");

                                GenJnl.Init;
                                GenJnl.Validate("Journal Template Name", TabConfRH."Nome Livro Diario");
                                GenJnl.Validate("Journal Batch Name", TabConfRH."Secção Diario");
                                GenJnl.Validate("Line No.", LastMov);
                                GenJnl.Validate("Account Type", GenJnl."Account Type"::"G/L Account");
                                GenJnl.Validate("Account No.", NConta);
                                GenJnl.Validate("Posting Date", DimNDistribuir."Data Registo");

                                //Ir buscar a Descrição da conta
                                TabConta.Reset;
                                TabConta.SetRange(TabConta."No.", NConta);
                                if TabConta.FindFirst then
                                    GenJnl.Validate(Description, TabConta.Name);

                                GenJnl."Document No." := NDocumento;
                                GenJnl.Validate(GenJnl.Amount, TotDeb - TotCre);

                                GenJnl."Source Code" := TabCodSerie."Integração Vencimentos";
                                //Para o caso do utilizador apagar as linhas do diario sem registar
                                //nos sabermos a que processamento corresponde e desta forma tirarmos o pisco
                                //do campo Integrado na Contabilidade
                                GenJnl."Cód. Processamento" := "Periodos Processamento"."Cód. Processamento";
                                GenJnl."Posting No. Series" := nSerieReg;//IT005
                                GenJnl.Insert;
                            end;
                        end;
                        NConta := DimNDistribuir."No. Conta";
                        TotDeb := 0;
                        TotCre := 0;
                        TotDeb := TotDeb + DimNDistribuir."Valor Débito";
                        TotCre := TotCre + DimNDistribuir."Valor Crédito";
                    end;

                end;

                trigger OnPostDataItem()
                begin
                    if AgruparContasBalanco then begin
                        //-----------------------------------------------------------
                        //---------------------FASE - 3 B----------------------------
                        //Só entra aqui se não estivermos a utilizar a Distribuição por CC
                        //Nesse caso usamos as Dimensões e então temos de ir apanhar
                        //as restantes contas (<>6*) e que são balanço, agrupá-las e
                        //envia-las para o diario sem dimensões
                        //-----------------------------------------------------------
                        //-------------------------------------------------------
                        //Se escolheu agrupar as contas balanço, então só passam por
                        //aqui as contas quesão balanço e que são <>6*
                        //-------------------------------------------------------

                        TabConta.Reset;
                        TabConta.SetRange(TabConta."No.", DimNDistribuir."No. Conta");
                        if TabConta.FindFirst then begin
                            if (AgruparContasBalanco) and (TabConta."Income/Balance" = TabConta."Income/Balance"::"Balance Sheet") then begin

                                /*IT005
                                //Ir buscar o último nº de linha usado
                                GenJnl.RESET;
                                GenJnl.SETRANGE(GenJnl."Journal Template Name",TabConfRH."Nome Livro Diario");
                                GenJnl.SETRANGE(GenJnl."Journal Batch Name",TabConfRH."Secção Diario");
                                IF GenJnl.FIND('+') THEN
                                   LastMov := GenJnl."Line No."
                                ELSE
                                   LastMov := 0;

                                // Ir buscar o ultimo Nº do Documento
                                CLEAR(NoSeriesMgt);
                                TabSeccaoDiarioGeral.RESET;
                                TabSeccaoDiarioGeral.SETRANGE(TabSeccaoDiarioGeral."Journal Template Name",TabConfRH."Nome Livro Diario");
                                TabSeccaoDiarioGeral.SETRANGE(TabSeccaoDiarioGeral.Name,TabConfRH."Secção Diario");
                                IF TabSeccaoDiarioGeral.FINDFIRST THEN
                                  NDocumento := NoSeriesMgt.GetNextNo(TabSeccaoDiarioGeral."No. Series",WORKDATE,FALSE)
                                ELSE
                                  NDocumento := '';
                                */
                                GenJnlBatch.Reset;

                                LastMov := LastMov + 10000;

                                // Ir buscar o Cód. Origem
                                TabCodSerie.Reset;
                                if TabCodSerie.Get() then
                                    TabCodSerie.TestField("Integração Vencimentos");

                                GenJnl.Init;
                                GenJnl.Validate("Journal Template Name", TabConfRH."Nome Livro Diario");
                                GenJnl.Validate("Journal Batch Name", TabConfRH."Secção Diario");
                                GenJnl.Validate("Line No.", LastMov);
                                GenJnl.Validate("Account Type", GenJnl."Account Type"::"G/L Account");
                                GenJnl.Validate("Account No.", NConta);
                                GenJnl.Validate("Posting Date", DimNDistribuir."Data Registo");

                                //Ir buscar a Descrição da conta
                                TabConta.Reset;
                                TabConta.SetRange(TabConta."No.", NConta);
                                if TabConta.Find('-') then
                                    GenJnl.Validate(Description, TabConta.Name);

                                GenJnl."Document No." := NDocumento;
                                GenJnl.Validate(GenJnl.Amount, TotDeb - TotCre);
                                GenJnl."Source Code" := TabCodSerie."Integração Vencimentos";
                                //Para o caso do utilizador apagar as linhas do diario sem registar
                                //nos sabermos a que processamento corresponde e desta forma tirarmos o pisco
                                //do campo Integrado na Contabilidade
                                GenJnl."Cód. Processamento" := "Periodos Processamento"."Cód. Processamento";
                                GenJnl."Posting No. Series" := nSerieReg;//IT005
                                GenJnl.Insert;
                            end;
                        end;
                    end;

                end;

                trigger OnPreDataItem()
                begin
                    flag := true;
                end;
            }
            dataitem(Arredondamentos; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                trigger OnAfterGetRecord()
                var
                    varEmpregado: Code[20];
                    varConta: Code[20];
                    varTotalDiario: Decimal;
                    varTotalHistorico: Decimal;
                    l_HistMovEmp: Record "Hist. Linhas Movs. Empregado";
                begin

                    //Por vezes com a distribuição de percentagens os valores são arredondados e depois os valores não batem certo.
                    //Temos de apanhar a diferença e lança-la.
                    Clear(varEmpregado);
                    Clear(varConta);
                    GenJnl.Reset;
                    GenJnl.SetCurrentKey(GenJnl."No. Empregado", GenJnl."Account No.");
                    GenJnl.SetFilter(GenJnl."Account No.", '6*');
                    if GenJnl.Find('-') then begin
                        repeat
                            if (varEmpregado <> '') and ((varEmpregado <> GenJnl."No. Empregado") or (varConta <> GenJnl."Account No.")) then begin

                                Clear(varTotalHistorico);
                                l_HistMovEmp.Reset;
                                l_HistMovEmp.SetRange(l_HistMovEmp."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                                l_HistMovEmp.SetRange(l_HistMovEmp."No. Empregado", varEmpregado);
                                l_HistMovEmp.SetRange(l_HistMovEmp."No. Conta a Debitar", varConta);
                                if l_HistMovEmp.FindSet then begin
                                    repeat
                                        varTotalHistorico := varTotalHistorico + l_HistMovEmp.Valor
                                    until l_HistMovEmp.Next = 0;
                                end;

                                if varTotalHistorico <> varTotalDiario then begin
                                    GenJnl.Next(-1);
                                    GenJnl.Validate(GenJnl."Debit Amount", GenJnl."Debit Amount" - Abs(varTotalHistorico - varTotalDiario));
                                    GenJnl.Modify;
                                    GenJnl.Next;
                                end;

                                Clear(varTotalDiario);
                                varTotalDiario := GenJnl."Debit Amount"; //GenJnl.Amount;
                                varEmpregado := GenJnl."No. Empregado";
                                varConta := GenJnl."Account No.";

                            end else begin
                                varEmpregado := GenJnl."No. Empregado";
                                varConta := GenJnl."Account No.";
                                varTotalDiario := varTotalDiario + GenJnl."Debit Amount";
                            end;
                        until GenJnl.Next = 0;
                    end;
                end;

                trigger OnPostDataItem()
                begin
                    //Manda da temporaria para a definitiva

                    GenJnl.Reset;
                    if GenJnl.Find('-') then begin
                        repeat
                            GenJnlLine.Init;
                            GenJnlLine.TransferFields(GenJnl);
                            if not GenJnlLine.Insert then;
                        until GenJnl.Next = 0;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if "Periodos Processamento".Estado <> "Periodos Processamento".Estado::Fechado then
                    Error(Text0003);

                //Testa se já foi feita a integração para este periodo
                if "Periodos Processamento"."Integrado na Contabilidade" then
                    Error(Text0002);

                //Actualiza o campo Integrado na Contabilidade
                "Periodos Processamento"."Integrado na Contabilidade" := true;
                "Periodos Processamento".Modify;

                //Limpar a tabela Integração Contabilistica
                TabIntegracaoContab.Reset;
                TabIntegracaoContab.DeleteAll;
                TabTempIntegracaoContab.DeleteAll;
                TabTempIntegracaoContab2.DeleteAll;
                TabConfRH.Get();

                //IT005,sn
                //Ir buscar o último nº de linha usado
                GenJnl.Reset;
                GenJnl.SetRange(GenJnl."Journal Template Name", TabConfRH."Nome Livro Diario");
                GenJnl.SetRange(GenJnl."Journal Batch Name", TabConfRH."Secção Diario");
                if GenJnl.FindLast then
                    LastMov := GenJnl."Line No."
                else
                    LastMov := 0;

                // Ir buscar o ultimo Nº do Documento
                Clear(NoSeriesMgt);
                TabSeccaoDiarioGeral.Reset;
                TabSeccaoDiarioGeral.SetRange(TabSeccaoDiarioGeral."Journal Template Name", TabConfRH."Nome Livro Diario");
                TabSeccaoDiarioGeral.SetRange(TabSeccaoDiarioGeral.Name, TabConfRH."Secção Diario");
                if TabSeccaoDiarioGeral.Find('-') then begin
                    NDocumento := NoSeriesMgt.GetNextNo(TabSeccaoDiarioGeral."No. Series", WorkDate, true);
                    nSerieReg := TabSeccaoDiarioGeral."Posting No. Series";//IT005
                end else
                    NDocumento := '';
                //IT005,en
            end;

            trigger OnPreDataItem()
            begin
                SetFilter("Cód. Processamento", PeriodoCode);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Periodo Processamento")
                {
                    Caption = 'Periodo Processamento';
                    field(PeriodoCode; PeriodoCode)
                    {

                        Caption = 'Periodo Processamento';
                        TableRelation = "Periodos Processamento";
                    }
                    field(AgruparContasBalanco; AgruparContasBalanco)
                    {

                        Caption = 'Agrupar contas de balanço';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            AgruparContasBalanco := true;
        end;
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
        //Se escolher agrupar contas então não pode ter numero doc diferente por empregado
        if ((AgruparContasBalancoCC) and (NumDocDif)) or
          ((AgruparContasPGCC) and (NumDocDif)) or
          ((AgruparContasBalanco) and (NumDocDif)) or
          ((AgruparContasBalancoAnal) and (NumDocDif)) then
            Error(Text0013);

        if GenLedgerSetup.Get() then;
    end;

    var
        AgruparContasBalanco: Boolean;
        TabEmpregadoDistribCustos: Record "Distribuição Custos";
        TabConta: Record "G/L Account";
        GenJnl: Record "Gen. Journal Line" temporary;
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlBatch: Record "Gen. Journal Batch";
        LastMov: Integer;
        i: Integer;
        DiarNum: Code[20];
        TabConfRH: Record "Config. Recursos Humanos";
        Text0001: Label 'Processo concluído.';
        TabIntegracaoContab: Record "Integração Contabilistica";
        TabTempIntegracaoContab: Record "Integração Contabilistica" temporary;
        NLinha: Integer;
        Text0002: Label 'Este periodo já foi integrado.';
        NDocumento: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TabSeccaoDiarioGeral: Record "Gen. Journal Batch";
        TabCodSerie: Record "Source Code Setup";
        Text0003: Label 'O processamento tem de estar fechado.';
        TabDistribpCentroCusto: Record "Distribuição Custos";
        Text0004: Label 'Não pode escolher Agrupar as contas balanço, pois está a usar a Distribuição p/ Centros de Custo.';
        Text0005: Label 'Atenção, a rubrica %1, do empregado %2, não tem conta poc definida o que impede de aparecer no mapa.';
        Text0006: Label 'Para o empregado %1, a conta poc %2 da rubrica %3 tem de ser auxiliar.';
        TabContaAux: Record "G/L Account";
        Text0007: Label 'A conta poc %1, não existe.';
        AgruparContasBalancoCC: Boolean;
        Text0012: Label 'Não pode agrupar as contas balanço por centro de custo se não está a usar a Distribuição p/ Centros Custo.';
        TabTempIntegracaoContab2: Record "Integração Contabilistica" temporary;
        AgruparContasPGCC: Boolean;
        TabEmpregado: Record Employee;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        NumDocDif: Boolean;
        NEmp: Code[20];
        TabRubSal: Record "Rubrica Salarial";
        TabRubSal2: Record "Rubrica Salarial";
        AuxLinhasMovEmp: Record "Hist. Linhas Movs. Empregado";
        TempLinhasMovEmp: Record "Hist. Linhas Movs. Empregado" temporary;
        TotAbonos: Decimal;
        NLinha2: Integer;
        Text0013: Label 'Não pode agrupar as contas se quer usar um nº de documento diferente por Empregado.';
        Text0014: Label 'A distribuição de custos - dimensões, não perfaz um total de 100 para o empregado %1.';
        Text0015: Label 'Não pode agrupar as contas contas de perdas e ganhos por centro de custo se não está a usar a Distribuição p/ Centros Custo.';
        GenLedgerSetup: Record "General Ledger Setup";
        AgruparContasBalancoAnal: Boolean;
        JnlDimSetEntries: Record "Dimension Set Entry";
        PeriodoCode: Code[10];
        NConta: Code[20];
        TotDeb: Decimal;
        TotCre: Decimal;
        flag: Boolean;
        DimMgt: Codeunit DimensionManagement;
        "--Tagus": Integer;
        nSerieReg: Code[20];


    procedure InsertIntegracaoContab(MovsEmp: Record "Hist. Linhas Movs. Empregado")
    begin
        //-----------------------------------
        //Lançamento a Débito
        //-----------------------------------
        NLinha := NLinha + 1;
        TabIntegracaoContab.Init;
        TabIntegracaoContab."Cód. Processamento" := MovsEmp."Cód. Processamento";
        TabIntegracaoContab."Tipo Processamento" := MovsEmp."Tipo Processamento";
        TabIntegracaoContab."No. Empregado" := MovsEmp."No. Empregado";
        TabIntegracaoContab."No. Linha" := NLinha;
        TabIntegracaoContab."Data Registo" := WorkDate;
        TabIntegracaoContab."Designação Empregado" := MovsEmp."Designação Empregado";
        TabIntegracaoContab."Cód. Rubrica" := MovsEmp."Cód. Rubrica";
        TabIntegracaoContab."Descrição Rubrica" := MovsEmp."Descrição Rubrica";
        TabIntegracaoContab."Tipo Rubrica" := MovsEmp."Tipo Rubrica";
        TabIntegracaoContab."No. Conta" := MovsEmp."No. Conta a Debitar";
        //Se for Abono Negativo troca a coluna e o sinal
        //***************************************************************************************
        if (MovsEmp."Tipo Rubrica" = MovsEmp."Tipo Rubrica"::Abono) and
          (MovsEmp.Valor < 0) then begin
            TabIntegracaoContab."Valor Débito" := 0;
            TabIntegracaoContab."Valor Crédito" := Abs(MovsEmp.Valor);
        end else begin
            //Se for Desconto Negativo troca o sinal
            //***************************************************************************************
            if MovsEmp."Tipo Rubrica" = MovsEmp."Tipo Rubrica"::Desconto then
                TabIntegracaoContab."Valor Débito" := Abs(MovsEmp.Valor)
            else
                TabIntegracaoContab."Valor Débito" := MovsEmp.Valor;
            TabIntegracaoContab."Valor Crédito" := 0;
        end;

        //Preencher as dimensões das horas extra
        TabIntegracaoContab."Global Dimension 1 Code" := MovsEmp."Global Dimension 1 Code";
        TabIntegracaoContab."Global Dimension 2 Code" := MovsEmp."Global Dimension 2 Code";
        TabIntegracaoContab.Insert;
        //-----------------------------------
        //Lançamento a Crédito
        //------------------------------------
        NLinha := NLinha + 1;
        TabIntegracaoContab.Init;
        TabIntegracaoContab."Cód. Processamento" := MovsEmp."Cód. Processamento";
        TabIntegracaoContab."Tipo Processamento" := MovsEmp."Tipo Processamento";
        TabIntegracaoContab."No. Empregado" := MovsEmp."No. Empregado";
        TabIntegracaoContab."No. Linha" := NLinha;
        TabIntegracaoContab."Data Registo" := WorkDate;
        TabIntegracaoContab."Designação Empregado" := MovsEmp."Designação Empregado";
        TabIntegracaoContab."Cód. Rubrica" := MovsEmp."Cód. Rubrica";
        TabIntegracaoContab."Descrição Rubrica" := MovsEmp."Descrição Rubrica";
        TabIntegracaoContab."Tipo Rubrica" := MovsEmp."Tipo Rubrica";
        TabIntegracaoContab."No. Conta" := MovsEmp."No. Conta a Creditar";

        //Se for Abono Negativo troca a coluna e o sinal
        //***************************************************************************************
        if (MovsEmp."Tipo Rubrica" = MovsEmp."Tipo Rubrica"::Abono) and
          (MovsEmp.Valor < 0) then begin
            TabIntegracaoContab."Valor Débito" := Abs(MovsEmp.Valor);
            TabIntegracaoContab."Valor Crédito" := 0;
        end else begin
            TabIntegracaoContab."Valor Débito" := 0;
            //Se for Desconto Negativo troca o sinal
            //***************************************************************************************
            if MovsEmp."Tipo Rubrica" = MovsEmp."Tipo Rubrica"::Desconto then
                TabIntegracaoContab."Valor Crédito" := Abs(MovsEmp.Valor)
            else
                TabIntegracaoContab."Valor Crédito" := MovsEmp.Valor;
        end;
        //Preencher as dimensões das horas extra
        TabIntegracaoContab."Global Dimension 1 Code" := MovsEmp."Global Dimension 1 Code";
        TabIntegracaoContab."Global Dimension 2 Code" := MovsEmp."Global Dimension 2 Code";
        TabIntegracaoContab.Insert;
    end;
}

