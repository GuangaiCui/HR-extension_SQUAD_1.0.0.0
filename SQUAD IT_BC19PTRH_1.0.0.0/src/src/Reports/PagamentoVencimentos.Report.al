report 53055 "Pagamento Vencimentos"
{
    // //---------------------Pagamento de Vencimentos ------------------------
    // //Rotina que pega nos registos do Histórico Movs. de Empregado e os leva
    // //para um diario a fim de serem registados na contabilidade com os dados
    // //relativos ao pagamento dos vencimentos
    // //-----------------------------------------------------------------------
    // 
    //  IT004 - Tagus - 20191121 - novo campo Balance Cash-Flow Code utilizado no pagamento de vencientos
    //  IT005 - Tagus - 20191126 - querem o mesmo numero de documento para todos os empregados e com alteração do nº série

    Permissions = TableData "Hist. Cab. Movs. Empregado" = rimd,
                  TableData "Hist. Linhas Movs. Empregado" = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Periodos Processamento"; "Periodos Processamento")
        {
            DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento") WHERE("Tipo Processamento" = FILTER(<> Encargos));

            trigger OnPreDataItem()
            begin
                SetFilter("Cód. Processamento", PeriodoCode);
            end;
        }
        dataitem(Empregado; Employee)
        {
            RequestFilterFields = "No.", "Tipo Contribuinte";
            dataitem("Hist. Cab. Movs. Empregado"; "Hist. Cab. Movs. Empregado")
            {
                CalcFields = Valor;
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado") WHERE("Tipo Processamento" = FILTER(<> Encargos), Pendente = CONST(true));

                trigger OnAfterGetRecord()
                var
                    Flag: Boolean;
                begin
                    if "Hist. Cab. Movs. Empregado".Valor = 0.0 then
                        CurrReport.Skip; //16.10.07 - nao envia se o processamento tem valor 0

                    /*IT005
                    //27.08.07 - testar se na ficha empregado, o livro e a secção do pagamento, estão preenchidos
                    Empregado.TESTFIELD(Empregado."Nome Livro Diario Pag.");
                    Empregado.TESTFIELD(Empregado."Secção Diario Pag.");
                    */
                    Clear(NConta);

                    /*IT005
                    // Ir buscar o ultimo Nº do Documento
                    TabSeccaoDiarioGeral.RESET;
                    TabSeccaoDiarioGeral.SETRANGE(TabSeccaoDiarioGeral."Journal Template Name",Empregado."Nome Livro Diario Pag.");
                    TabSeccaoDiarioGeral.SETRANGE(TabSeccaoDiarioGeral.Name,Empregado."Secção Diario Pag.");
                    IF TabSeccaoDiarioGeral.FINDFIRST THEN BEGIN
                      CLEAR(NoSeriesMgt); //2008.12.10 - para criar o mesmo nº para todos os empregados
                      NDocumento := NoSeriesMgt.GetNextNo(TabSeccaoDiarioGeral."No. Series",WORKDATE,TRUE);
                    END ELSE
                      NDocumento := '';
                    */
                    Flag := false;

                    TabHistLinhasMovEmp.Reset;
                    TabHistLinhasMovEmp.SetRange(TabHistLinhasMovEmp."Cód. Processamento", "Hist. Cab. Movs. Empregado"."Cód. Processamento");
                    TabHistLinhasMovEmp.SetRange(TabHistLinhasMovEmp."Tipo Processamento", "Hist. Cab. Movs. Empregado"."Tipo Processamento");
                    TabHistLinhasMovEmp.SetRange(TabHistLinhasMovEmp."No. Empregado", "Hist. Cab. Movs. Empregado"."No. Empregado");
                    TabHistLinhasMovEmp.SetRange(TabHistLinhasMovEmp."Tipo Rubrica", TabHistLinhasMovEmp."Tipo Rubrica"::Abono);//2009.06.18
                    if TabHistLinhasMovEmp.FindSet then begin
                        //2009.06.18
                        NConta := TabHistLinhasMovEmp."No. Conta a Creditar";
                        repeat
                            TabRubricaSalarial.Reset;
                            TabRubricaSalarial.SetRange(TabRubricaSalarial.Código, TabHistLinhasMovEmp."Cód. Rubrica");
                            TabRubricaSalarial.SetRange(TabRubricaSalarial.Genero, TabRubricaSalarial.Genero::"Vencimento Base");
                            if TabRubricaSalarial.Find('-') then begin
                                NConta := TabHistLinhasMovEmp."No. Conta a Creditar";
                                Flag := true;//2009.06.18
                            end;
                        until (TabHistLinhasMovEmp.Next = 0) or (Flag = true);//2009.06.18
                    end;

                    //Envia para o Diário
                    LastMov := LastMov + 10000;

                    //Ir buscar o Cód. Origem
                    TabCodSerie.Reset;
                    if TabCodSerie.Get() then;
                    TabCodSerie.TestField("Pagamento Vencimentos");

                    GenJnl.Init;

                    GenJnl.Validate("Journal Template Name", Empregado."Nome Livro Diario Pag.");
                    GenJnl.Validate("Journal Batch Name", Empregado."Secção Diario Pag.");
                    GenJnl.Validate("Line No.", LastMov);
                    GenJnl.Validate("Account Type", GenJnl."Account Type"::"G/L Account");
                    GenJnl.Validate("Account No.", NConta);
                    GenJnl.Validate("Posting Date", WorkDate);
                    GenJnl.Validate("Document Type", GenJnl."Document Type"::Payment);
                    GenJnl.Validate(GenJnl."Document No.", NDocumento);
                    GenJnl.Validate("Document Date", WorkDate);
                    if Empregado.Pagamento = Empregado.Pagamento::"Bank Account" then
                        GenJnl.Validate("Bal. Account Type", GenJnl."Bal. Account Type"::"Bank Account")
                    else
                        GenJnl.Validate("Bal. Account Type", GenJnl."Bal. Account Type"::"G/L Account");

                    GenJnl.Validate("Bal. Account No.", Empregado."Conta Pag.");
                    GenJnl.Validate("No. Empregado", "Hist. Cab. Movs. Empregado"."No. Empregado");
                    GenJnl.Validate("Debit Amount", Round("Hist. Cab. Movs. Empregado".Valor, 0.01)); //HG 2006.08.30 -Coloquei o Round
                    GenJnl."Source Code" := TabCodSerie."Pagamento Vencimentos";
                    GenJnl."Não deixa alterar No.Doc" := true;//20.06.2007 - para não deixar alterar o nº doc para não perdermos o rasto
                    //2008.01.05 - para o caso do utilizador apagar as linhas do diario sem registar
                    //nos sabermos a que processamento corresponde e desta forma tirarmos o pisco
                    //do campo Integrado na Contabilidade
                    GenJnl."Cód. Processamento" := "Hist. Cab. Movs. Empregado"."Cód. Processamento";

                    if UsaTransfBancaria then
                        GenJnl."Bank Payment Type" := GenJnl."Bank Payment Type"::"Electronic Payment";

                    if DataTransfSEPA <> 0D then
                        GenJnl."Posting Date" := DataTransfSEPA;

                    //IT004,sn
                    if ConfRH."Balance Cash-Flow Code" <> '' then
                        GenJnl.Validate("PTSS Bal: cash-flow code", ConfRH."Balance Cash-Flow Code");
                    //IT004,en
                    GenJnl."Posting No. Series" := nSerieReg;//IT005
                    GenJnl.Insert;

                    //Actualizar o Nº de Documento no Hist. Cab. Movs. Empregado
                    TabHistCabMovEmp.Reset;
                    TabHistCabMovEmp.SetRange(TabHistCabMovEmp."Cód. Processamento", "Hist. Cab. Movs. Empregado"."Cód. Processamento");
                    TabHistCabMovEmp.SetRange(TabHistCabMovEmp."Tipo Processamento", "Hist. Cab. Movs. Empregado"."Tipo Processamento");
                    TabHistCabMovEmp.SetRange(TabHistCabMovEmp."No. Empregado", "Hist. Cab. Movs. Empregado"."No. Empregado");
                    if TabHistCabMovEmp.FindFirst then begin
                        TabHistCabMovEmp."Pago por No. Documento" := NDocumento;
                        TabHistCabMovEmp.Modify;
                    end;

                end;

                trigger OnPreDataItem()
                begin
                    "Hist. Cab. Movs. Empregado".SetRange("Hist. Cab. Movs. Empregado"."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                    if UsaTransfBancaria then
                        "Hist. Cab. Movs. Empregado".SetRange("Hist. Cab. Movs. Empregado"."Usa Transferência Bancária", true);
                    if BankAccount <> '' then
                        "Hist. Cab. Movs. Empregado".SetRange("Hist. Cab. Movs. Empregado"."Cód. Banco Transf.", BankAccount);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                // Ir buscar o ultimo nº linha usado
                GenJnl.Reset;
                GenJnl.SetRange(GenJnl."Journal Template Name", Empregado."Nome Livro Diario Pag.");
                GenJnl.SetRange(GenJnl."Journal Batch Name", Empregado."Secção Diario Pag.");
                if GenJnl.FindLast then
                    LastMov := GenJnl."Line No."
                else
                    LastMov := 0;
            end;

            trigger OnPreDataItem()
            var
                l_Empregado: Record Employee;
            begin
                if ConfRH.Get then; //IT004,n


                //IT005,sn
                l_Empregado.Reset;
                l_Empregado.SetRange(Status, Status::Active);
                if l_Empregado.FindFirst then begin
                    l_Empregado.TestField("Nome Livro Diario Pag.");
                    l_Empregado.TestField("Secção Diario Pag.");

                    TabSeccaoDiarioGeral.Reset;
                    TabSeccaoDiarioGeral.SetRange(TabSeccaoDiarioGeral."Journal Template Name", l_Empregado."Nome Livro Diario Pag.");
                    TabSeccaoDiarioGeral.SetRange(TabSeccaoDiarioGeral.Name, l_Empregado."Secção Diario Pag.");
                    if TabSeccaoDiarioGeral.FindFirst then begin
                        NDocumento := NoSeriesMgt.GetNextNo(TabSeccaoDiarioGeral."No. Series", WorkDate, true);
                        nSerieReg := TabSeccaoDiarioGeral."Posting No. Series";
                    end else
                        Error(StrSubstNo(Text50000, l_Empregado."Nome Livro Diario Pag.", l_Empregado."Secção Diario Pag."));

                end;
                //IT005,en
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
                        ;
                        Caption = 'Periodo Processamento';
                        TableRelation = "Periodos Processamento";
                    }
                }
                group("Opções")
                {
                    Caption = 'Opções';
                    field(UsaTransfBancaria; UsaTransfBancaria)
                    {
                        ;
                        Caption = 'Usa Tranfs. Bancária';
                    }
                    field(BankAccount; BankAccount)
                    {
                        ;
                        Caption = 'Banco';
                        TableRelation = "Bank Account";
                    }
                    field(DataTransfSEPA; DataTransfSEPA)
                    {
                        ;
                        Caption = 'Data Transferência';
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

    var
        Text0001: Label 'Processo concluído.';
        GenJnl: Record "Gen. Journal Line";
        LastMov: Integer;
        NDocumento: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TabSeccaoDiarioGeral: Record "Gen. Journal Batch";
        TabRubricaSalarial: Record "Rubrica Salarial";
        TabRubricaSalEmpregado: Record "Rubrica Salarial Empregado";
        NConta: Code[20];
        TabCodSerie: Record "Source Code Setup";
        TabHistCabMovEmp: Record "Hist. Cab. Movs. Empregado";
        TabHistLinhasMovEmp: Record "Hist. Linhas Movs. Empregado";
        PeriodoCode: Code[10];
        UsaTransfBancaria: Boolean;
        BankAccount: Code[20];
        DataTransfSEPA: Date;
        "--TAGUS--": Integer;
        ConfRH: Record "Config. Recursos Humanos";
        Text50000: Label 'Paramentrize o nº série para o diário %1, seção %2.';
        nSerieReg: Code[20];
}

