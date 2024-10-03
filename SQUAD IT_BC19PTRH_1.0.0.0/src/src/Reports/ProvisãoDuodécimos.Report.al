report 53068 "Provisão Duodécimos"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Empregado; Empregado)
        {
            DataItemTableView = SORTING("No.") WHERE(Status = CONST(Active));
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                if Empregado."Orgão Social" then begin
                    ConfRH.TestField(ConfRH."No. Conta Duo. SF OrgSoc");
                    ConfRH.TestField(ConfRH."No. Conta Duo. SN OrgSoc");
                    ConfRH.TestField(ConfRH."No. Conta Contrap. Duo. SF");
                    ConfRH.TestField(ConfRH."No. Conta Contrap. Duo. SN");
                end;


                //Limpa variáveis
                //**********************
                Clear(SF);
                Clear(Fer);
                Clear(SN);
                Clear(TaxaEnc);
                Clear(EncSF);
                Clear(EncFer);
                Clear(EncSN);
                Clear(VBSS);
                Clear(VBCGA);

                //Calcular valor SF e SN
                //*************************
                SF := Empregado."Valor Vencimento Base" / ConfRH."No. Meses";
                SN := Empregado."Valor Vencimento Base" / ConfRH."No. Meses";
                Fer := Empregado."Valor Vencimento Base" / ConfRH."No. Meses";
                if PercAcrescimo <> 0 then begin
                    SF := Round(SF * (1 + PercAcrescimo), 0.01);
                    SN := Round(SN * (1 + PercAcrescimo), 0.01);
                    Fer := Round(Fer * (1 + PercAcrescimo), 0.01);
                end;
                TotalSF := TotalSF + SF;
                TotalSN := TotalSN + SN;
                TotalFer := TotalFer + Fer;

                //-----------------------------------------------------
                //-----------------------SF e SN e Ferias ----------------------
                //-----------------------------------------------------

                //Tem Distribuição
                //*****************
                DistribCustos.Reset;
                DistribCustos.SetRange(DistribCustos."No. Empregado", Empregado."No.");
                if DistribCustos.FindSet then begin
                    repeat
                        GenLedSetup.Reset;
                        if GenLedSetup.FindFirst then begin
                            //------------------------------------
                            //registo Sub. Férias
                            //-------------------------------------
                            nLinha := nLinha + 10000;
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                            GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                            GenJnlLine."Line No." := nLinha;
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                            if Empregado."Orgão Social" = false then
                                GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Duo. SF")
                            else
                                GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Duo. SF OrgSoc");
                            GenJnlLine."Posting Date" := WorkDate;
                            GenJnlLine."Document No." := nDocumento;
                            GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                            GenJnlLine."Recurring Frequency" := Datef;
                            GenJnlLine.Validate(GenJnlLine."Debit Amount", SF * DistribCustos.Percentagem);
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code", DistribCustos."Global Dimension 1 Code");
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code", DistribCustos."Global Dimension 2 Code");
                            if DistribCustos."Shortcut Dimension 3 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(3, DistribCustos."Shortcut Dimension 3 Code", GenJnlLine."Dimension Set ID");
                            if DistribCustos."Shortcut Dimension 4 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(4, DistribCustos."Shortcut Dimension 4 Code", GenJnlLine."Dimension Set ID");
                            if DistribCustos."Shortcut Dimension 5 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(5, DistribCustos."Shortcut Dimension 5 Code", GenJnlLine."Dimension Set ID");
                            if DistribCustos."Shortcut Dimension 6 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(6, DistribCustos."Shortcut Dimension 6 Code", GenJnlLine."Dimension Set ID");
                            if DistribCustos."Shortcut Dimension 7 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(7, DistribCustos."Shortcut Dimension 7 Code", GenJnlLine."Dimension Set ID");
                            if DistribCustos."Shortcut Dimension 8 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(8, DistribCustos."Shortcut Dimension 8 Code", GenJnlLine."Dimension Set ID");
                            GenJnlLine."No. Empregado" := Empregado."No.";
                            GenJnlLine.Insert;

                            //------------------------------------
                            //registo Férias
                            //-------------------------------------
                            if ((Empregado."Orgão Social" = false) and (ConfRH."No. Conta Duo. F" <> '')) or
                               ((Empregado."Orgão Social") and (ConfRH."No. Conta Duo. F OrgSoc" <> '')) then begin
                                nLinha := nLinha + 10000;
                                GenJnlLine.Init;
                                GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                                GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                                GenJnlLine."Line No." := nLinha;
                                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                                if Empregado."Orgão Social" = false then
                                    GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Duo. F")
                                else
                                    GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Duo. F OrgSoc");
                                GenJnlLine."Posting Date" := WorkDate;
                                GenJnlLine."Document No." := nDocumento;
                                GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                                GenJnlLine."Recurring Frequency" := Datef;
                                GenJnlLine.Validate(GenJnlLine."Debit Amount", Fer * DistribCustos.Percentagem);
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code", DistribCustos."Global Dimension 1 Code");
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code", DistribCustos."Global Dimension 2 Code");
                                if DistribCustos."Shortcut Dimension 3 Code" <> '' then
                                    DimMgt.ValidateShortcutDimValues(3, DistribCustos."Shortcut Dimension 3 Code", GenJnlLine."Dimension Set ID");
                                if DistribCustos."Shortcut Dimension 4 Code" <> '' then
                                    DimMgt.ValidateShortcutDimValues(4, DistribCustos."Shortcut Dimension 4 Code", GenJnlLine."Dimension Set ID");
                                if DistribCustos."Shortcut Dimension 5 Code" <> '' then
                                    DimMgt.ValidateShortcutDimValues(5, DistribCustos."Shortcut Dimension 5 Code", GenJnlLine."Dimension Set ID");
                                if DistribCustos."Shortcut Dimension 6 Code" <> '' then
                                    DimMgt.ValidateShortcutDimValues(6, DistribCustos."Shortcut Dimension 6 Code", GenJnlLine."Dimension Set ID");
                                if DistribCustos."Shortcut Dimension 7 Code" <> '' then
                                    DimMgt.ValidateShortcutDimValues(7, DistribCustos."Shortcut Dimension 7 Code", GenJnlLine."Dimension Set ID");
                                if DistribCustos."Shortcut Dimension 8 Code" <> '' then
                                    DimMgt.ValidateShortcutDimValues(8, DistribCustos."Shortcut Dimension 8 Code", GenJnlLine."Dimension Set ID");
                                GenJnlLine."No. Empregado" := Empregado."No.";
                                GenJnlLine.Insert;
                            end;
                            //------------------------------------
                            //registo Sub. Natal
                            //-------------------------------------
                            nLinha := nLinha + 10000;
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                            GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                            GenJnlLine."Line No." := nLinha;
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                            if Empregado."Orgão Social" = false then
                                GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Duo. SN")
                            else
                                GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Duo. SN OrgSoc");
                            GenJnlLine."Posting Date" := WorkDate;
                            GenJnlLine."Document No." := nDocumento;
                            GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                            GenJnlLine."Recurring Frequency" := Datef;
                            GenJnlLine.Validate(GenJnlLine."Debit Amount", SN * DistribCustos.Percentagem);
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code", DistribCustos."Global Dimension 1 Code");
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code", DistribCustos."Global Dimension 2 Code");
                            if DistribCustos."Shortcut Dimension 3 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(3, DistribCustos."Shortcut Dimension 3 Code", GenJnlLine."Dimension Set ID");
                            if DistribCustos."Shortcut Dimension 4 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(4, DistribCustos."Shortcut Dimension 4 Code", GenJnlLine."Dimension Set ID");
                            if DistribCustos."Shortcut Dimension 5 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(5, DistribCustos."Shortcut Dimension 5 Code", GenJnlLine."Dimension Set ID");
                            if DistribCustos."Shortcut Dimension 6 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(6, DistribCustos."Shortcut Dimension 6 Code", GenJnlLine."Dimension Set ID");
                            if DistribCustos."Shortcut Dimension 7 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(7, DistribCustos."Shortcut Dimension 7 Code", GenJnlLine."Dimension Set ID");
                            if DistribCustos."Shortcut Dimension 8 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(8, DistribCustos."Shortcut Dimension 8 Code", GenJnlLine."Dimension Set ID");
                            GenJnlLine."No. Empregado" := Empregado."No.";
                            GenJnlLine.Insert;
                        end;
                    until DistribCustos.Next = 0;
                end else begin
                    //Só tem Dimensão
                    //********************
                    GenLedSetup.Reset;
                    if GenLedSetup.FindFirst then begin
                        DefDim.Reset;
                        DefDim.SetRange(DefDim."Table ID", DATABASE::Employee);
                        DefDim.SetRange(DefDim."No.", Empregado."No.");
                        DefDim.SetRange(DefDim."Dimension Code", GenLedSetup."Global Dimension 1 Code");
                        if DefDim.FindSet then begin
                            //------------------------------------
                            //registo Sub. Férias
                            //-------------------------------------
                            nLinha := nLinha + 10000;
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                            GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                            GenJnlLine."Line No." := nLinha;
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                            if Empregado."Orgão Social" = false then
                                GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Duo. SF")
                            else
                                GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Duo. SF OrgSoc");
                            GenJnlLine."Posting Date" := WorkDate;
                            GenJnlLine."Document No." := nDocumento;
                            GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                            GenJnlLine."Recurring Frequency" := Datef;
                            GenJnlLine.Validate(GenJnlLine."Debit Amount", SF);
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code", DefDim."Dimension Value Code");
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code", DefDim."Dimension Value Code");
                            GenJnlLine."No. Empregado" := Empregado."No.";
                            GenJnlLine.Insert;
                            //------------------------------------
                            //registo Férias
                            //-------------------------------------
                            nLinha := nLinha + 10000;
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                            GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                            GenJnlLine."Line No." := nLinha;
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                            if Empregado."Orgão Social" = false then
                                GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Duo. F")
                            else
                                GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Duo. F OrgSoc");
                            GenJnlLine."Posting Date" := WorkDate;
                            GenJnlLine."Document No." := nDocumento;
                            GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                            GenJnlLine."Recurring Frequency" := Datef;
                            GenJnlLine.Validate(GenJnlLine."Debit Amount", Fer);
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code", DefDim."Dimension Value Code");
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code", DefDim."Dimension Value Code");
                            GenJnlLine."No. Empregado" := Empregado."No.";
                            GenJnlLine.Insert;
                            //------------------------------------
                            //registo Sub. Natal
                            //-------------------------------------
                            nLinha := nLinha + 10000;
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                            GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                            GenJnlLine."Line No." := nLinha;
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                            if Empregado."Orgão Social" = false then
                                GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Duo. SN")
                            else
                                GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Duo. SN OrgSoc");
                            GenJnlLine."Posting Date" := WorkDate;
                            GenJnlLine."Document No." := nDocumento;
                            GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                            GenJnlLine."Recurring Frequency" := Datef;
                            GenJnlLine.Validate(GenJnlLine."Debit Amount", SN);
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code", DefDim."Dimension Value Code");
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code", DefDim."Dimension Value Code");
                            GenJnlLine."No. Empregado" := Empregado."No.";
                            GenJnlLine.Insert;
                        end else begin
                            //Não tem dimensões
                            //------------------------------------
                            //registo Sub. Férias
                            //-------------------------------------
                            nLinha := nLinha + 10000;
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                            GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                            GenJnlLine."Line No." := nLinha;
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                            if Empregado."Orgão Social" = false then
                                GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Duo. SF")
                            else
                                GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Duo. SF OrgSoc");
                            GenJnlLine."Posting Date" := WorkDate;
                            GenJnlLine."Document No." := nDocumento;
                            GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                            GenJnlLine."Recurring Frequency" := Datef;
                            GenJnlLine.Validate(GenJnlLine."Debit Amount", SF);
                            GenJnlLine."No. Empregado" := Empregado."No.";
                            GenJnlLine.Insert;
                            //------------------------------------
                            //registo Férias
                            //-------------------------------------
                            nLinha := nLinha + 10000;
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                            GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                            GenJnlLine."Line No." := nLinha;
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                            if Empregado."Orgão Social" = false then
                                GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Duo. F")
                            else
                                GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Duo. F OrgSoc");
                            GenJnlLine."Posting Date" := WorkDate;
                            GenJnlLine."Document No." := nDocumento;
                            GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                            GenJnlLine."Recurring Frequency" := Datef;
                            GenJnlLine.Validate(GenJnlLine."Debit Amount", Fer);
                            GenJnlLine."No. Empregado" := Empregado."No.";
                            GenJnlLine.Insert;
                            //------------------------------------
                            //registo Sub. Natal
                            //-------------------------------------
                            nLinha := nLinha + 10000;
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                            GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                            GenJnlLine."Line No." := nLinha;
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                            if Empregado."Orgão Social" = false then
                                GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Duo. SN")
                            else
                                GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Duo. SN OrgSoc");
                            GenJnlLine."Posting Date" := WorkDate;
                            GenJnlLine."Document No." := nDocumento;
                            GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                            GenJnlLine."Recurring Frequency" := Datef;
                            GenJnlLine.Validate(GenJnlLine."Debit Amount", SN);
                            GenJnlLine."No. Empregado" := Empregado."No.";
                            GenJnlLine.Insert;
                        end;
                    end;
                end;

                //-----------------------------------------------------
                //-----------------------Encargos ---------------------
                //-----------------------------------------------------
                //Calcular o valor consoante a taxa
                //**************************************
                if Empregado."Cód. Rúbrica Enc. Seg. Social" <> '' then begin
                    RegSS.Reset;
                    RegSS.SetRange(RegSS.Código, Empregado."Cod. Regime SS");
                    if RegSS.FindFirst then begin
                        TaxaEnc := RegSS."Taxa Contributiva Ent Patronal" / 100;
                        VBSS := Empregado."Valor Vencimento Base" * TaxaEnc;
                    end;
                end;

                if Empregado."Cód. Rúbrica Enc. CGA" <> '' then begin
                    TaxaEnc := ConfRH."Taxa Contributiva Ent Patronal" / 100;
                    RubSalEmp.Reset;
                    RubSalEmp.SetRange(RubSalEmp."No. Empregado", Empregado."No.");
                    if RubSalEmp.FindSet then begin
                        repeat
                            RubSal.Reset;
                            RubSal.SetRange(RubSal.Código, RubSalEmp."Cód. Rúbrica Salarial");
                            RubSal.SetRange(RubSal.Genero, RubSal.Genero::CGA);
                            if RubSal.FindFirst then begin
                                RubSalLinhas.Reset;
                                RubSalLinhas.SetRange(RubSalLinhas."Cód. Rubrica", RubSal.Código);
                                if RubSalLinhas.FindSet then begin
                                    repeat
                                        RubSal2.Reset;
                                        RubSal2.SetRange(RubSal2.Código, RubSalLinhas."Cód. Rubrica Filha");
                                        RubSal2.SetRange(RubSal2.Genero, RubSal2.Genero::"Vencimento Base");
                                        if RubSal2.FindFirst then begin
                                            RubSalEmp2.Reset;
                                            RubSalEmp2.SetRange(RubSalEmp2."No. Empregado", Empregado."No.");
                                            RubSalEmp2.SetRange(RubSalEmp2."Cód. Rúbrica Salarial", RubSal2.Código);
                                            if RubSalEmp2.FindLast then
                                                VBCGA := VBCGA + RubSalEmp2."Valor Total";
                                        end;
                                    until RubSalLinhas.Next = 0;
                                end;
                            end;
                        until RubSalEmp.Next = 0;
                    end;
                end;

                VBCGA := VBCGA * TaxaEnc;
                VBCGA := Round(VBCGA, 0.01);
                VBSS := Round(VBSS, 0.01);
                EncSF := (VBSS + VBCGA) / ConfRH."No. Meses";
                EncSN := (VBSS + VBCGA) / ConfRH."No. Meses";
                EncFer := (VBSS + VBCGA) / ConfRH."No. Meses";
                if PercAcrescimo <> 0 then begin
                    EncSF := EncSF * (1 + PercAcrescimo);
                    EncSN := EncSN * (1 + PercAcrescimo);
                    EncFer := EncFer * (1 + PercAcrescimo);
                end;
                EncTotalSF := EncTotalSF + EncSF;
                EncTotalSN := EncTotalSN + EncSN;
                EncTotalFer := EncTotalFer + EncFer;

                //Tem Distribuição
                //*****************
                DistribCustos.Reset;
                DistribCustos.SetRange(DistribCustos."No. Empregado", Empregado."No.");
                if DistribCustos.FindSet then begin
                    repeat
                        GenLedSetup.Reset;
                        if GenLedSetup.FindFirst then begin
                            //------------------------------------
                            //registo Sub. Férias
                            //-------------------------------------
                            nLinha := nLinha + 10000;
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                            GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                            GenJnlLine."Line No." := nLinha;
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                            GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Enc. Duo. SF");
                            GenJnlLine."Posting Date" := WorkDate;
                            GenJnlLine."Document No." := nDocumento;
                            GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                            GenJnlLine."Recurring Frequency" := Datef;
                            GenJnlLine.Validate(GenJnlLine."Debit Amount", EncSF * DistribCustos.Percentagem);
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code", DistribCustos."Global Dimension 1 Code");
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code", DistribCustos."Global Dimension 2 Code");
                            if DistribCustos."Shortcut Dimension 3 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(3, DistribCustos."Shortcut Dimension 3 Code", GenJnlLine."Dimension Set ID");
                            if DistribCustos."Shortcut Dimension 4 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(4, DistribCustos."Shortcut Dimension 4 Code", GenJnlLine."Dimension Set ID");
                            if DistribCustos."Shortcut Dimension 5 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(5, DistribCustos."Shortcut Dimension 5 Code", GenJnlLine."Dimension Set ID");
                            if DistribCustos."Shortcut Dimension 6 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(6, DistribCustos."Shortcut Dimension 6 Code", GenJnlLine."Dimension Set ID");
                            if DistribCustos."Shortcut Dimension 7 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(7, DistribCustos."Shortcut Dimension 7 Code", GenJnlLine."Dimension Set ID");
                            if DistribCustos."Shortcut Dimension 8 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(8, DistribCustos."Shortcut Dimension 8 Code", GenJnlLine."Dimension Set ID");
                            GenJnlLine."No. Empregado" := Empregado."No.";
                            GenJnlLine.Insert;
                            //------------------------------------
                            //registo Férias
                            //-------------------------------------
                            if ConfRH."No. Conta Duo. F" <> '' then begin
                                nLinha := nLinha + 10000;
                                GenJnlLine.Init;
                                GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                                GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                                GenJnlLine."Line No." := nLinha;
                                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                                GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Enc. Duo. F");
                                GenJnlLine."Posting Date" := WorkDate;
                                GenJnlLine."Document No." := nDocumento;
                                GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                                GenJnlLine."Recurring Frequency" := Datef;
                                GenJnlLine.Validate(GenJnlLine."Debit Amount", EncFer * DistribCustos.Percentagem);
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code", DistribCustos."Global Dimension 1 Code");
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code", DistribCustos."Global Dimension 2 Code");
                                if DistribCustos."Shortcut Dimension 3 Code" <> '' then
                                    DimMgt.ValidateShortcutDimValues(3, DistribCustos."Shortcut Dimension 3 Code", GenJnlLine."Dimension Set ID");
                                if DistribCustos."Shortcut Dimension 4 Code" <> '' then
                                    DimMgt.ValidateShortcutDimValues(4, DistribCustos."Shortcut Dimension 4 Code", GenJnlLine."Dimension Set ID");
                                if DistribCustos."Shortcut Dimension 5 Code" <> '' then
                                    DimMgt.ValidateShortcutDimValues(5, DistribCustos."Shortcut Dimension 5 Code", GenJnlLine."Dimension Set ID");
                                if DistribCustos."Shortcut Dimension 6 Code" <> '' then
                                    DimMgt.ValidateShortcutDimValues(6, DistribCustos."Shortcut Dimension 6 Code", GenJnlLine."Dimension Set ID");
                                if DistribCustos."Shortcut Dimension 7 Code" <> '' then
                                    DimMgt.ValidateShortcutDimValues(7, DistribCustos."Shortcut Dimension 7 Code", GenJnlLine."Dimension Set ID");
                                if DistribCustos."Shortcut Dimension 8 Code" <> '' then
                                    DimMgt.ValidateShortcutDimValues(8, DistribCustos."Shortcut Dimension 8 Code", GenJnlLine."Dimension Set ID");
                                GenJnlLine."No. Empregado" := Empregado."No.";
                                GenJnlLine.Insert;
                            end;
                            //------------------------------------
                            //registo Sub. Natal
                            //-------------------------------------
                            nLinha := nLinha + 10000;
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                            GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                            GenJnlLine."Line No." := nLinha;
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                            GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Enc. Duo. SN");
                            GenJnlLine."Posting Date" := WorkDate;
                            GenJnlLine."Document No." := nDocumento;
                            GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                            GenJnlLine."Recurring Frequency" := Datef;
                            GenJnlLine.Validate(GenJnlLine."Debit Amount", EncSN * DistribCustos.Percentagem);
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code", DistribCustos."Global Dimension 1 Code");
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code", DistribCustos."Global Dimension 2 Code");
                            if DistribCustos."Shortcut Dimension 3 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(3, DistribCustos."Shortcut Dimension 3 Code", GenJnlLine."Dimension Set ID");
                            if DistribCustos."Shortcut Dimension 4 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(4, DistribCustos."Shortcut Dimension 4 Code", GenJnlLine."Dimension Set ID");
                            if DistribCustos."Shortcut Dimension 5 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(5, DistribCustos."Shortcut Dimension 5 Code", GenJnlLine."Dimension Set ID");
                            if DistribCustos."Shortcut Dimension 6 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(6, DistribCustos."Shortcut Dimension 6 Code", GenJnlLine."Dimension Set ID");
                            if DistribCustos."Shortcut Dimension 7 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(7, DistribCustos."Shortcut Dimension 7 Code", GenJnlLine."Dimension Set ID");
                            if DistribCustos."Shortcut Dimension 8 Code" <> '' then
                                DimMgt.ValidateShortcutDimValues(8, DistribCustos."Shortcut Dimension 8 Code", GenJnlLine."Dimension Set ID");
                            GenJnlLine."No. Empregado" := Empregado."No.";
                            GenJnlLine.Insert;
                        end;
                    until DistribCustos.Next = 0;
                end else begin
                    //Só tem Dimensão
                    //********************
                    GenLedSetup.Reset;
                    if GenLedSetup.FindFirst then begin
                        DefDim.Reset;
                        DefDim.SetRange(DefDim."Table ID", DATABASE::Employee);
                        DefDim.SetRange(DefDim."No.", Empregado."No.");
                        DefDim.SetRange(DefDim."Dimension Code", GenLedSetup."Global Dimension 1 Code");
                        if DefDim.FindSet then begin
                            //------------------------------------
                            //registo Sub. Férias
                            //-------------------------------------
                            nLinha := nLinha + 10000;
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                            GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                            GenJnlLine."Line No." := nLinha;
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                            GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Enc. Duo. SF");
                            GenJnlLine."Posting Date" := WorkDate;
                            GenJnlLine."Document No." := nDocumento;
                            GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                            GenJnlLine."Recurring Frequency" := Datef;
                            GenJnlLine.Validate(GenJnlLine."Debit Amount", EncSF);
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code", DefDim."Dimension Value Code");
                            GenJnlLine."No. Empregado" := Empregado."No.";
                            GenJnlLine.Insert;
                            //------------------------------------
                            //registo Férias
                            //-------------------------------------
                            nLinha := nLinha + 10000;
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                            GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                            GenJnlLine."Line No." := nLinha;
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                            GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Enc. Duo. F");
                            GenJnlLine."Posting Date" := WorkDate;
                            GenJnlLine."Document No." := nDocumento;
                            GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                            GenJnlLine."Recurring Frequency" := Datef;
                            GenJnlLine.Validate(GenJnlLine."Debit Amount", EncFer);
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code", DefDim."Dimension Value Code");
                            GenJnlLine."No. Empregado" := Empregado."No.";
                            GenJnlLine.Insert;

                            //------------------------------------
                            //registo Sub. Natal
                            //------------------------------------
                            nLinha := nLinha + 10000;
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                            GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                            GenJnlLine."Line No." := nLinha;
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                            GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Enc. Duo. SN");
                            GenJnlLine."Posting Date" := WorkDate;
                            GenJnlLine."Document No." := nDocumento;
                            GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                            GenJnlLine."Recurring Frequency" := Datef;
                            GenJnlLine.Validate(GenJnlLine."Debit Amount", EncSN);
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code", DefDim."Dimension Value Code");
                            GenJnlLine."No. Empregado" := Empregado."No.";
                            GenJnlLine.Insert;
                        end else begin
                            //Não tem dimensões
                            //------------------------------------
                            //registo Sub. Férias
                            //-------------------------------------
                            nLinha := nLinha + 10000;
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                            GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                            GenJnlLine."Line No." := nLinha;
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                            GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Enc. Duo. SF");
                            GenJnlLine."Posting Date" := WorkDate;
                            GenJnlLine."Document No." := nDocumento;
                            GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                            GenJnlLine."Recurring Frequency" := Datef;
                            GenJnlLine.Validate(GenJnlLine."Debit Amount", EncSF);
                            GenJnlLine."No. Empregado" := Empregado."No.";
                            GenJnlLine.Insert;
                            //------------------------------------
                            //registo Férias
                            //-------------------------------------
                            nLinha := nLinha + 10000;
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                            GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                            GenJnlLine."Line No." := nLinha;
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                            GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Enc. Duo. F");
                            GenJnlLine."Posting Date" := WorkDate;
                            GenJnlLine."Document No." := nDocumento;
                            GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                            GenJnlLine."Recurring Frequency" := Datef;
                            GenJnlLine.Validate(GenJnlLine."Debit Amount", EncFer);
                            GenJnlLine."No. Empregado" := Empregado."No.";
                            GenJnlLine.Insert;
                            //------------------------------------
                            //registo Sub. Natal
                            //------------------------------------
                            nLinha := nLinha + 10000;
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                            GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                            GenJnlLine."Line No." := nLinha;
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                            GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Enc. Duo. SN");
                            GenJnlLine."Posting Date" := WorkDate;
                            GenJnlLine."Document No." := nDocumento;
                            GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                            GenJnlLine."Recurring Frequency" := Datef;
                            GenJnlLine.Validate(GenJnlLine."Debit Amount", EncSN);
                            GenJnlLine."No. Empregado" := Empregado."No.";
                            GenJnlLine.Insert;
                        end;
                    end;
                end;
            end;

            trigger OnPostDataItem()
            begin
                //------------------------------------
                //Registo contrapartida Sub. Férias
                //-------------------------------------
                nLinha := nLinha + 10000;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                GenJnlLine."Line No." := nLinha;
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Contrap. Duo. SF");
                GenJnlLine."Posting Date" := WorkDate;
                GenJnlLine."Document No." := nDocumento;
                GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                GenJnlLine."Recurring Frequency" := Datef;
                GenJnlLine.Validate(GenJnlLine."Credit Amount", TotalSF);
                GenJnlLine.Insert;
                //------------------------------------
                //Registo contrapartida Férias
                //-------------------------------------
                if ConfRH."No. Conta Contrap. Duo. F" <> '' then begin
                    nLinha := nLinha + 10000;
                    GenJnlLine.Init;
                    GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                    GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                    GenJnlLine."Line No." := nLinha;
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                    GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Contrap. Duo. F");
                    GenJnlLine."Posting Date" := WorkDate;
                    GenJnlLine."Document No." := nDocumento;
                    GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                    GenJnlLine."Recurring Frequency" := Datef;
                    GenJnlLine.Validate(GenJnlLine."Credit Amount", TotalFer);
                    GenJnlLine.Insert;
                end;

                //------------------------------------
                //Registo contrapartida Sub. Natal
                //-------------------------------------
                nLinha := nLinha + 10000;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                GenJnlLine."Line No." := nLinha;
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Contrap. Duo. SN");
                GenJnlLine."Posting Date" := WorkDate;
                GenJnlLine."Document No." := nDocumento;
                GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                GenJnlLine."Recurring Frequency" := Datef;
                GenJnlLine.Validate(GenJnlLine."Credit Amount", TotalSN);
                GenJnlLine.Insert;
                //------------------------------------
                //Registo Encargos contrapartida Sub. Férias
                //-------------------------------------
                nLinha := nLinha + 10000;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                GenJnlLine."Line No." := nLinha;
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Contrap. Enc. Duo.SF");
                GenJnlLine."Posting Date" := WorkDate;
                GenJnlLine."Document No." := nDocumento;
                GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                GenJnlLine."Recurring Frequency" := Datef;
                GenJnlLine.Validate(GenJnlLine."Credit Amount", EncTotalSF);
                GenJnlLine.Insert;
                //------------------------------------
                //Registo Encargos contrapartida Férias
                //-------------------------------------
                nLinha := nLinha + 10000;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                GenJnlLine."Line No." := nLinha;
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Contrap. Enc. Duo.F");
                GenJnlLine."Posting Date" := WorkDate;
                GenJnlLine."Document No." := nDocumento;
                GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                GenJnlLine."Recurring Frequency" := Datef;
                GenJnlLine.Validate(GenJnlLine."Credit Amount", EncTotalFer);
                GenJnlLine.Insert;
                //------------------------------------
                //Registo Encargos contrapartida Sub. Natal
                //-------------------------------------
                nLinha := nLinha + 10000;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := ConfRH."Nome Diário Duodécimos";
                GenJnlLine."Journal Batch Name" := ConfRH."Nome Secção Duodécimos";
                GenJnlLine."Line No." := nLinha;
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                GenJnlLine.Validate(GenJnlLine."Account No.", ConfRH."No. Conta Contrap. Enc. Duo.SN");
                GenJnlLine."Posting Date" := WorkDate;
                GenJnlLine."Document No." := nDocumento;
                GenJnlLine."Recurring Method" := GenJnlLine."Recurring Method"::"F  Fixed";
                GenJnlLine."Recurring Frequency" := Datef;
                GenJnlLine.Validate(GenJnlLine."Credit Amount", EncTotalSN);
                GenJnlLine.Insert;
                Message(Text0001);
            end;

            trigger OnPreDataItem()
            begin
                Evaluate(Datef, '1M');

                //Testa se o nome do diário e da secção estão preenchidos
                //******************************************************
                ConfRH.Reset;
                if ConfRH.Get() then begin
                    ConfRH.TestField(ConfRH."Nome Diário Duodécimos");
                    ConfRH.TestField(ConfRH."Nome Secção Duodécimos");
                    ConfRH.TestField(ConfRH."No. Conta Duo. SF");
                    ConfRH.TestField(ConfRH."No. Conta Duo. SN");
                    ConfRH.TestField(ConfRH."No. Conta Contrap. Duo. SF");
                    ConfRH.TestField(ConfRH."No. Conta Contrap. Duo. SN");
                    ConfRH.TestField(ConfRH."No. Conta Enc. Duo. SF");
                    ConfRH.TestField(ConfRH."No. Conta Enc. Duo. SN");
                    ConfRH.TestField(ConfRH."No. Conta Contrap. Enc. Duo.SF");
                    ConfRH.TestField(ConfRH."No. Conta Contrap. Enc. Duo.SN");
                    if ConfRH."No. Conta Duo. F" <> '' then begin
                        ConfRH.TestField(ConfRH."No. Conta Contrap. Duo. F");
                        ConfRH.TestField(ConfRH."No. Conta Enc. Duo. F");
                        ConfRH.TestField(ConfRH."No. Conta Contrap. Enc. Duo.F");
                    end;

                    ConfRH.TestField(ConfRH."No. Meses");
                end;

                //Apagar as linhas que estão no diário
                GenJnlLine.Reset;
                GenJnlLine.SetRange(GenJnlLine."Journal Template Name", ConfRH."Nome Diário Duodécimos");
                GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", ConfRH."Nome Secção Duodécimos");
                if GenJnlLine.FindSet then
                    GenJnlLine.DeleteAll;

                //Ir buscar o nº de série
                //*************************
                Clear(NoSeriesMgt);
                GenJournalBatch.Reset;
                GenJournalBatch.SetRange(GenJournalBatch."Journal Template Name", ConfRH."Nome Diário Duodécimos");
                GenJournalBatch.SetRange(GenJournalBatch.Name, ConfRH."Nome Secção Duodécimos");
                if GenJournalBatch.Find('-') then begin
                    if GenJournalBatch."No. Series" <> '' then
                        nDocumento := NoSeriesMgt.GetNextNo(GenJournalBatch."No. Series", WorkDate, false);
                    if GenJournalBatch."Posting No. Series" <> '' then
                        nDocumento := NoSeriesMgt.GetNextNo(GenJournalBatch."Posting No. Series", WorkDate, false);
                end else
                    nDocumento := '';

                //N Linha
                //**********************
                GenJnlLine.Reset;
                GenJnlLine.SetRange(GenJnlLine."Journal Template Name", ConfRH."Nome Diário Duodécimos");
                GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", ConfRH."Nome Secção Duodécimos");
                if GenJnlLine.FindLast then
                    nLinha := GenJnlLine."Line No."
                else
                    nLinha := 10000;

                Clear(TotalSF);
                Clear(TotalFer);
                Clear(TotalSN);
                Clear(EncTotalSF);
                Clear(EncTotalSN);
                Clear(EncTotalFer);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(PercAcrescimo; PercAcrescimo)
                {

                    Caption = 'Percentagem de Acrescimo';
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

    var
        DefDim: Record "Default Dimension";
        DistribCustos: Record "Distribuição Custos";
        GenLedSetup: Record "General Ledger Setup";
        GenJnlLine: Record "Gen. Journal Line";
        ConfRH: Record "Config. Recursos Humanos";
        GenJournalBatch: Record "Gen. Journal Batch";
        RegSS: Record "Regime Seg. Social";
        RubSalEmp: Record "Rubrica Salarial Empregado";
        RubSalEmp2: Record "Rubrica Salarial Empregado";
        RubSal: Record "Rubrica Salarial";
        RubSal2: Record "Rubrica Salarial";
        RubSalLinhas: Record "Rubrica Salarial Linhas";
        NoSeriesMgt: Codeunit "No. Series";
        nDocumento: Code[20];
        PercAcrescimo: Decimal;
        SF: Decimal;
        SN: Decimal;
        Fer: Decimal;
        TotalSF: Decimal;
        TotalSN: Decimal;
        TotalFer: Integer;
        TaxaEnc: Decimal;
        EncSF: Decimal;
        EncSN: Decimal;
        EncFer: Integer;
        EncTotalSF: Decimal;
        EncTotalSN: Decimal;
        EncTotalFer: Integer;
        Datef: DateFormula;
        nLinha: Integer;
        VBSS: Decimal;
        Text0001: Label 'Os movimentos dos duodécimos foram criados no diário.';
        VBCGA: Decimal;
        DimMgt: Codeunit DimensionManagement;
}

