report 53083 "Mapa Pagamento por Cheque/Num"
{
    // //-------------------------------------------------------
    //           Mapa Pagamento por Cheque/Numerário
    // //--------------------------------------------------------
    //   É um Mapa que serve de conferência aos dados dos Empregados
    //   que não recebem por Transferência Bancária.
    //   Neste mapa são englobados os empregados que nesse mês não têm
    //   o pisco no "Usa transferência Bancária"
    //   Este Mapa pode ser tirado que a partir dos Movs. quer a partir
    //   do Histórico.
    // //-------------------------------------------------------
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\MapaPagamentoporChequeNum.rdl';

    Permissions = TableData "Tabela Temp Ficheiros Texto" = rimd;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(filtros; "Periodos Processamento")
        {
            DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento");

            trigger OnAfterGetRecord()
            begin
                DataReg := filtros."Data Registo";
                //17.04.07 - Se o processamento não está fechado tem de aparecer no mapa a indicação de que este é provisório
                if (FiltroCodProc <> '') and (filtros.Estado = filtros.Estado::Aberto) then
                    varProvisorio := 'Provisório'
                else
                    varProvisorio := '';

                CurrReport.Break
            end;

            trigger OnPreDataItem()
            begin
                SetFilter("Cód. Processamento", CodProcess);
                if DataInicio <> 0D then
                    SetRange("Data Inicio Processamento", DataInicio);
                if DataFim <> 0D then
                    SetRange("Data Fim Processamento", DataFim);

                FiltroDataInicProc := filtros.GetFilter("Data Inicio Processamento");
                FiltroDataFimProc := filtros.GetFilter("Data Fim Processamento");
                FiltroCodProc := filtros.GetFilter("Cód. Processamento");

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
            end;
        }
        dataitem(Empregado; Empregado)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "No.";
            dataitem("Cab. Movs. Empregado"; "Cab. Movs. Empregado")
            {
                CalcFields = Valor;
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "Employee No.") ORDER(Ascending) WHERE("Usa Transferência Bancária" = CONST(false));

                trigger OnAfterGetRecord()
                begin
                    //Só entram para o mapa os empregados que tenham processamento,
                    //que nãu usem transf. bancárias

                    CalcFields(Valor);
                    ValorTotalEmpregado := ValorTotalEmpregado + Valor;

                    if not "Cab. Movs. Empregado"."Usa Transferência Bancária" then
                        Flag := true;
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
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "Employee No.") WHERE("Usa Transferência Bancária" = CONST(false));

                trigger OnAfterGetRecord()
                begin
                    //Só entram para o mapa os empregados que tenham processamento,
                    //que não usem transf. bancárias
                    CalcFields(Valor);
                    ValorTotalEmpregado := ValorTotalEmpregado + Valor;
                    if not "Hist. Cab. Movs. Empregado"."Usa Transferência Bancária" then
                        Flag := true;
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
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column("MAPA_DE_PAGAMENTOS_POR_CHEQUE_NUMERÁRIOCaption"; MAPA_DE_PAGAMENTOS_POR_CHEQUE_NUMERÁRIOCaptionLbl)
                {
                }
                column(ValorCaption; ValorCaptionLbl)
                {
                }
                column(N__Emp_Caption; N__Emp_CaptionLbl)
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
                column(Empregado_No_; Empregado."No.")
                {
                }
                column(Processado_por_ComputadorCaption; Processado_por_ComputadorCaptionLbl)
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
                //Este código serve para só aparecerem os empregados que têm dados

                Flag := false;

                TemHistMovEmp := false;
                TemMovEmp := false;
                ValorTotalEmpregado := 0;

                _HistCabEmp.Reset;
                _HistCabEmp.SetRange("Employee No.", Empregado."No.");

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
                end else
                    _HistCabEmp.SetFilter("Cód. Processamento", FiltroCodProc);

                if _HistCabEmp.FindFirst then
                    TemHistMovEmp := true;

                _CabMovEmp.Reset;
                _CabMovEmp.SetRange("Employee No.", Empregado."No.");

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
                end else
                    _CabMovEmp.SetFilter("Cód. Processamento", FiltroCodProc);

                if _CabMovEmp.FindFirst then
                    TemMovEmp := true;

                if (not TemHistMovEmp) and (not TemMovEmp) then begin
                    CurrReport.Skip;
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
                group("Pagamento por Cheque/Numerário")
                {
                    Caption = 'Pagamento por Cheque/Numerário';
                    field(CodProcess; CodProcess)
                    {

                        Caption = 'Cód. Processamento';
                        TableRelation = "Periodos Processamento";
                    }
                    field(DataInicio; DataInicio)
                    {

                        Caption = 'Data Inicio';
                    }
                    field(DataFim; DataFim)
                    {

                        Caption = 'Data Fim';
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
        Employee: Record Empregado;
        Datacab: Date;
        TabConfEmpresa: Record "Company Information";
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
        Text0001: Label 'O tipo de Processamento tem de ser Vencimentos, Sub. Férias ou Sub. Natal';
        Text0002: Label 'Os filtros data de processamento e código de processamento são exclusivos. Não pode selecionar ambos.';
        Text0003: Label 'Tem que preencher a data de início e fim de processamento.';
        Text0008: Label 'Preencha o Cod. Processamento para tirar o Mapa para um só processamento.\ Ou preencha a Data de Inicio e de Fim, para tirar o Mapa para vários processamentos.';
        TextFiltro1: Text[60];
        TextFiltro2: Text[60];
        Flag: Boolean;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        "MAPA_DE_PAGAMENTOS_POR_CHEQUE_NUMERÁRIOCaptionLbl": Label 'MAPA DE PAGAMENTOS POR CHEQUE/NUMERÁRIO';
        ValorCaptionLbl: Label 'Valor';
        N__Emp_CaptionLbl: Label 'Nº Emp.';
        NomeCaptionLbl: Label 'Nome';
        Data_Registo_CaptionLbl: Label 'Data Registo:';
        Total_CaptionLbl: Label 'Total:';
        Processado_por_ComputadorCaptionLbl: Label 'Processado por Computador';
        CodProcess: Code[10];
        DataInicio: Date;
        DataFim: Date;
}

