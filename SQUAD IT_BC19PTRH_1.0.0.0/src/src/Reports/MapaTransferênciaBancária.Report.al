report 53046 "Mapa Transferência Bancária"
{
    // //-------------------------------------------------------
    //           Mapa Transferências Bancárias - PS2
    // //--------------------------------------------------------
    //   É um Mapa que serve de conferência aos dados do Ficheiro
    //   Transferências Bancárias que deve ser enviado mensalmente pela empresa
    //   para o seu Banco onde deve constar para cada empregado o NIB
    //   e o Valor a transferir para a conta do empregado; valor este
    //   que corresponde à remuneração liquida mensal do empregado.
    // 
    //   Este Mapa pode ser tirado que a partir dos Movs. quer a partir
    //   do Histórico.
    // //-------------------------------------------------------
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\MapaTransferênciaBancária.rdl';

    Permissions = TableData "Tabela Temp Ficheiros Texto" = rimd;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(Cab; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(TabConfEmpresa_Name; TabConfEmpresa.Name)
            {
            }
            column(USERID; UserId)
            {
            }
            column(TabConfEmpresa_Address; TabConfEmpresa.Address)
            {
            }

            column(TabConfEmpresa_City; TabConfEmpresa.City)
            {
            }
            column(TabConfEmpresa__Post_Code_; TabConfEmpresa."Post Code")
            {
            }
            column(TabConfEmpresa_Picture; TabConfEmpresa.Picture)
            {
            }
            column(TabConfEmpresa__Name_2_; TabConfEmpresa."Name 2")
            {
            }
            column(varProvisorio; varProvisorio)
            {
            }
            column(N__Contribuinte______TabConfEmpresa__VAT_Registration_No__; 'Nº Contribuinte: ' + TabConfEmpresa."VAT Registration No.")
            {
            }
            column(N__Telefone______TabConfEmpresa__Phone_No__; 'Nº Telefone: ' + TabConfEmpresa."Phone No.")
            {
            }
            column(TextFiltro2; TextFiltro2)
            {
            }
            column(DataReg; Format(DataReg, 0, 4))
            {
            }
            column(TextFiltro1____; TextFiltro1 + ':')
            {
            }
            column(ValorTotal; ValorTotal)
            {
            }
            column(ContaBancoName; BankAccount.Name)
            {
            }
            column(ContaBancoIBAN; BankAccount.IBAN)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(MAPA_TRANSF_BANC_Caption; MAPA_TRANSF_BANC_CaptionLbl)
            {
            }
            column(ValorCaption; ValorCaptionLbl)
            {
            }
            column(N__Emp_Caption; N__Emp_CaptionLbl)
            {
            }
            column(IBAN_Caption; IBANCaptionLbl)
            {
            }
            column(NomeCaption; NomeCaptionLbl)
            {
            }
            column(Data_Registo_Caption; Data_Registo_CaptionLbl)
            {
            }
            column(Total_Caption; Total_CaptionLbl)
            {
            }
            column(Processado_por_ComputadorCaption; Processado_por_ComputadorCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Filtros
                if CodProcess <> '' then
                    PerProc.SetFilter("Cód. Processamento", CodProcess);
                if DataInicio <> 0D then
                    PerProc.SetRange("Data Inicio Processamento", DataInicio);
                if DataFim <> 0D then
                    PerProc.SetRange("Data Fim Processamento", DataFim);

                FiltroDataInicProc := PerProc.GetFilter("Data Inicio Processamento");
                FiltroDataFimProc := PerProc.GetFilter("Data Fim Processamento");
                FiltroCodProc := PerProc.GetFilter("Cód. Processamento");

                if (FiltroDataInicProc <> '') and (FiltroDataFimProc <> '') and (FiltroCodProc <> '') then
                    Error(Text0002);

                if (FiltroDataFimProc <> '') and (FiltroDataInicProc = '') then
                    Error(Text0003);

                if (FiltroDataFimProc = '') and (FiltroDataInicProc <> '') then
                    Error(Text0003);

                if (FiltroDataInicProc <> '') and (FiltroDataFimProc <> '') then begin
                    TextFiltro1 := 'Data Processamento';
                    TextFiltro2 := FiltroDataInicProc + ' .. ' + FiltroDataFimProc;
                end;

                if (FiltroCodProc <> '') then begin
                    TextFiltro1 := 'Cód. Processamento';
                    TextFiltro2 := FiltroCodProc;
                end;

                if PerProc.FindSet then
                    DataReg := PerProc."Data Registo";

                if BankAccount.Get(BankAccount."No.") then;

                //Se o processamento não está fechado tem de aparecer no mapa a indicação de que este é provisório
                if (FiltroCodProc <> '') and (PerProc.Estado = PerProc.Estado::Aberto) then
                    varProvisorio := 'Provisório'
                else
                    varProvisorio := '';
            end;
        }
        dataitem(Empregado; Employee)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "No.";
            column(Empregado_No_; "No.")
            {
            }
            dataitem("Cab. Movs. Empregado"; "Cab. Movs. Empregado")
            {
                CalcFields = Valor;
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado") ORDER(Ascending);

                trigger OnAfterGetRecord()
                begin
                    //Só entram para o mapa os empregados que tenham processamento,
                    //que usem transf. bancárias e que tenham o banco definido

                    CalcFields(Valor);
                    ValorTotalEmpregado := ValorTotalEmpregado + Valor;

                    //31.10.2007 - substitui o código abaixo por este novo (deixa de ir ler à ficha e lê no processamento)
                    if ("Cab. Movs. Empregado"."Usa Transferência Bancária" = true) and
                       ("Cab. Movs. Empregado"."Cód. Banco Transf." = BankAccount."No.") then
                        Flag := true;

                    //2008.05.04  - passa a ir buscar o Nib e o nome do empregado ao processamento e não há ficha
                    Num := "Cab. Movs. Empregado"."No. Empregado";
                    vIBAN := "Cab. Movs. Empregado".IBAN;
                    Nome := "Cab. Movs. Empregado"."Designação Empregado";
                end;

                trigger OnPreDataItem()
                var
                    _DataInicioProcMin: Date;
                    _DataInicioProcMax: Date;
                    _DataFimProcMin: Date;
                    _DataFimProcMax: Date;
                    _PerProcessamento: Record "Periodos Processamento";
                begin
                    if FiltroCodProc = '' then begin
                        if (FiltroDataInicProc <> '') and (FiltroDataFimProc <> '') then begin
                            _PerProcessamento.Reset;
                            _PerProcessamento.SetFilter("Data Inicio Processamento", FiltroDataInicProc);
                            _PerProcessamento.SetFilter("Data Fim Processamento", FiltroDataFimProc);

                            _DataInicioProcMin := 0D;
                            _DataInicioProcMax := 0D;
                            _DataFimProcMin := 0D;
                            _DataFimProcMax := 0D;

                            _DataInicioProcMin := _PerProcessamento.GetRangeMin("Data Inicio Processamento");
                            _DataInicioProcMax := _PerProcessamento.GetRangeMax("Data Inicio Processamento");
                            _DataFimProcMin := _PerProcessamento.GetRangeMin("Data Fim Processamento");
                            _DataFimProcMax := _PerProcessamento.GetRangeMax("Data Fim Processamento");

                            //27.08.07 -não apanhar os encargos
                            "Cab. Movs. Empregado".SetFilter("Cab. Movs. Empregado"."Tipo Processamento", '<>%1',
                            "Cab. Movs. Empregado"."Tipo Processamento"::Encargos);

                            "Cab. Movs. Empregado".SetRange("Cab. Movs. Empregado"."Data Registo", _DataInicioProcMin, _DataFimProcMax)
                        end;
                    end else begin
                        //27.08.07 -não apanhar os encargos
                        "Cab. Movs. Empregado".SetFilter("Cab. Movs. Empregado"."Tipo Processamento", '<>%1',
                        "Cab. Movs. Empregado"."Tipo Processamento"::Encargos);
                        "Cab. Movs. Empregado".SetFilter("Cab. Movs. Empregado"."Cód. Processamento", FiltroCodProc);
                    end;
                end;
            }
            dataitem("Hist. Cab. Movs. Empregado"; "Hist. Cab. Movs. Empregado")
            {
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado");

                trigger OnAfterGetRecord()
                begin
                    //Só entram para o mapa os empregados que tenham processamento,
                    //que usem transf. bancárias e que tenham o banco definido
                    CalcFields(Valor);
                    ValorTotalEmpregado := ValorTotalEmpregado + Valor;

                    //31.10.2007 - substitui o código abaixo por este novo (deixa de ir ler à ficha e lê no processamento)
                    if ("Hist. Cab. Movs. Empregado"."Usa Transferência Bancária") and
                       ("Hist. Cab. Movs. Empregado"."Cód. Banco Transf." = BankAccount."No.") then
                        Flag := true;

                    //2008.05.04  - passa a ir buscar o Nib e o nome do empredao ao processamento e não á ficha pois pode mudar
                    Num := "Hist. Cab. Movs. Empregado"."No. Empregado";
                    vIBAN := "Hist. Cab. Movs. Empregado".IBAN;
                    Nome := "Hist. Cab. Movs. Empregado"."Designação Empregado";
                end;

                trigger OnPreDataItem()
                var
                    _DataInicioProcMin: Date;
                    _DataInicioProcMax: Date;
                    _DataFimProcMin: Date;
                    _DataFimProcMax: Date;
                    _PerProcessamento: Record "Periodos Processamento";
                begin
                    if FiltroCodProc = '' then begin
                        if (FiltroDataInicProc <> '') and (FiltroDataFimProc <> '') then begin
                            _PerProcessamento.Reset;
                            _PerProcessamento.SetFilter("Data Inicio Processamento", FiltroDataInicProc);
                            _PerProcessamento.SetFilter("Data Fim Processamento", FiltroDataFimProc);
                            _DataInicioProcMin := 0D;
                            _DataInicioProcMax := 0D;
                            _DataFimProcMin := 0D;
                            _DataFimProcMax := 0D;
                            _DataInicioProcMin := _PerProcessamento.GetRangeMin("Data Inicio Processamento");
                            _DataInicioProcMax := _PerProcessamento.GetRangeMax("Data Inicio Processamento");
                            _DataFimProcMin := _PerProcessamento.GetRangeMin("Data Fim Processamento");
                            _DataFimProcMax := _PerProcessamento.GetRangeMax("Data Fim Processamento");

                            //27.08.07 -não apanhar os encargos
                            "Hist. Cab. Movs. Empregado".SetFilter("Hist. Cab. Movs. Empregado"."Tipo Processamento", '<>%1',
                            "Hist. Cab. Movs. Empregado"."Tipo Processamento"::Encargos);
                            "Hist. Cab. Movs. Empregado".SetRange("Hist. Cab. Movs. Empregado"."Data Registo", _DataInicioProcMin, _DataFimProcMax);
                        end;
                    end else begin
                        //27.08.07 -não apanhar os encargos
                        "Hist. Cab. Movs. Empregado".SetFilter("Hist. Cab. Movs. Empregado"."Tipo Processamento", '<>%1',
                        "Hist. Cab. Movs. Empregado"."Tipo Processamento"::Encargos);
                        "Hist. Cab. Movs. Empregado".SetFilter("Hist. Cab. Movs. Empregado"."Cód. Processamento", FiltroCodProc);
                    end;
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(vIBAN; vIBAN)
                {
                }
                column(ValorTotalEmpregado; ValorTotalEmpregado)
                {
                }
                column(Empregado_Name; Empregado.Name)
                {
                }
                column(Empregado__No__; Empregado."No.")
                {
                }
                column(Integer_Number; Number)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //2016.11.25 - Correcção - para não aparecer quem não usa transf bancárias apesar de ter configurado o banco
                    if Flag = false then
                        CurrReport.Skip;
                end;
            }

            trigger OnAfterGetRecord()
            var
                _CabMovEmp: Record "Cab. Movs. Empregado";
                _HistCabEmp: Record "Hist. Cab. Movs. Empregado";
                _DataInicioProcMin: Date;
                _DataInicioProcMax: Date;
                _DataFimProcMin: Date;
                _DataFimProcMax: Date;
                _PerProcessamento: Record "Periodos Processamento";
            begin
                //Aparecer só empregados que têm dados
                Flag := false;

                TemHistMovEmp := false;
                TemMovEmp := false;
                ValorTotalEmpregado := 0;
                vIBAN := '';

                _HistCabEmp.Reset;
                _HistCabEmp.SetRange("No. Empregado", Empregado."No.");

                if FiltroCodProc = '' then begin
                    if (FiltroDataInicProc <> '') and (FiltroDataFimProc <> '') then begin
                        _PerProcessamento.Reset;
                        _PerProcessamento.SetFilter("Data Inicio Processamento", FiltroDataInicProc);
                        _PerProcessamento.SetFilter("Data Fim Processamento", FiltroDataFimProc);
                        _DataInicioProcMin := 0D;
                        _DataInicioProcMax := 0D;
                        _DataFimProcMin := 0D;
                        _DataFimProcMax := 0D;
                        _DataInicioProcMin := _PerProcessamento.GetRangeMin("Data Inicio Processamento");
                        _DataInicioProcMax := _PerProcessamento.GetRangeMax("Data Inicio Processamento");
                        _DataFimProcMin := _PerProcessamento.GetRangeMin("Data Fim Processamento");
                        _DataFimProcMax := _PerProcessamento.GetRangeMax("Data Fim Processamento");
                        _HistCabEmp.SetRange("Data Registo", _DataInicioProcMin, _DataFimProcMax)
                    end;
                end else begin
                    _HistCabEmp.SetFilter("Cód. Processamento", FiltroCodProc);
                end;

                if _HistCabEmp.FindFirst then
                    TemHistMovEmp := true;

                _CabMovEmp.Reset;
                _CabMovEmp.SetRange("No. Empregado", Empregado."No.");

                if FiltroCodProc = '' then begin
                    if (FiltroDataInicProc <> '') and (FiltroDataFimProc <> '') then begin
                        _PerProcessamento.Reset;
                        _PerProcessamento.SetFilter("Data Inicio Processamento", FiltroDataInicProc);
                        _PerProcessamento.SetFilter("Data Fim Processamento", FiltroDataFimProc);

                        _DataInicioProcMin := 0D;
                        _DataInicioProcMax := 0D;
                        _DataFimProcMin := 0D;
                        _DataFimProcMax := 0D;

                        _DataInicioProcMin := _PerProcessamento.GetRangeMin("Data Inicio Processamento");
                        _DataInicioProcMax := _PerProcessamento.GetRangeMax("Data Inicio Processamento");
                        _DataFimProcMin := _PerProcessamento.GetRangeMin("Data Fim Processamento");
                        _DataFimProcMax := _PerProcessamento.GetRangeMax("Data Fim Processamento");

                        _CabMovEmp.SetRange("Data Registo", _DataInicioProcMin, _DataFimProcMax)
                    end;
                end
                else begin
                    _CabMovEmp.SetFilter("Cód. Processamento", FiltroCodProc);
                end;

                if _CabMovEmp.FindFirst then
                    TemMovEmp := true;

                if (TemHistMovEmp = false) and (TemMovEmp = false) then begin
                    CurrReport.Skip;
                end;
            end;

            trigger OnPreDataItem()
            begin
                BankAccount2.Reset;
                BankAccount2.SetRange("No.", BankAccount."No.");
                if BankAccount2.Find('-') then;
                SetRange("Cód. Banco Transf.", BankAccount."No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Mapa Transferência Bancária")
                {
                    Caption = 'Mapa Transferência Bancária';
                    field(CodProcess; CodProcess)
                    {
                        ApplicationArea = All;
                        Caption = 'Cód. Processamento';
                        TableRelation = "Periodos Processamento";
                    }
                    field(DataInicio; DataInicio)
                    {
                        ApplicationArea = All;
                        Caption = 'Data Inicio';
                    }
                    field(DataFim; DataFim)
                    {
                        ApplicationArea = All;
                        Caption = 'Data Fim';
                    }
                    field("BankAccount.""No."""; BankAccount."No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Banco';
                        TableRelation = "Bank Account";
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
        PorDebito = 'Por débito da conta:';
    }

    trigger OnInitReport()
    begin
        Message(Text0008);
    end;

    trigger OnPreReport()
    begin
        TabConfEmpresa.Get();
        TabConfEmpresa.CalcFields(TabConfEmpresa.Picture);
        FiltroDataInicProc := '';
        FiltroDataFimProc := '';
        FiltroCodProc := '';
    end;

    var
        TabTempFichTexto: Record "Tabela Temp Ficheiros Texto";
        BankAccount: Record "Bank Account";
        Employee: Record Employee;
        TabConfEmpresa: Record "Company Information";
        PerProc: Record "Periodos Processamento";
        FiltroDataInicProc: Text[1024];
        FiltroDataFimProc: Text[1024];
        FiltroCodProc: Text[1024];
        TemHistMovEmp: Boolean;
        TemMovEmp: Boolean;
        ValorTotalEmpregado: Decimal;
        DataReg: Date;
        ValorTotal: Decimal;
        varProvisorio: Text[30];
        BankAccount2: Record "Bank Account";
        TextFiltro1: Text[60];
        TextFiltro2: Text[60];
        Flag: Boolean;
        Text0001: Label 'O tipo de Processamento tem de ser Vencimentos, Sub. Férias ou Sub. Natal';
        Text0002: Label 'Os filtros data de processamento e código de processamento são exclusivos. Não pode selecionar ambos.';
        Text0003: Label 'Tem que preencher a data de início e fim de processamento.';
        Text0008: Label 'Preencha o Cod. Processamento para tirar o Mapa para um só processamento.\ Ou preencha a Data de Inicio e de Fim, para tirar o Mapa para vários processamentos.';
        Text0009: Label 'A data tem de estar preenchida.';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        MAPA_TRANSF_BANC_CaptionLbl: Label 'MAPA DE TRANSFERÊNCIA BANCÁRIA';
        IBANCaptionLbl: Label 'IBAN';
        ValorCaptionLbl: Label 'Valor';
        N__Emp_CaptionLbl: Label 'Nº Emp.';
        NomeCaptionLbl: Label 'Nome';
        Data_Registo_CaptionLbl: Label 'Data Registo:';
        Total_CaptionLbl: Label 'Total:';
        Processado_por_ComputadorCaptionLbl: Label 'Processado por Computador';
        CodProcess: Code[10];
        DataInicio: Date;
        DataFim: Date;
        vIBAN: Code[50];
        Nome: Text[250];
        Num: Code[20];
}

