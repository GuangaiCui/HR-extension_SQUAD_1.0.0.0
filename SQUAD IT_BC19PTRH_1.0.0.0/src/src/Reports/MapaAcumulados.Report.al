report 53076 "Mapa Acumulados"
{
    // IT001 - CPA:Aparecer a Desc. Cat. profissional interna em vez da QP -   2010.03.18
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\MapaAcumulados.rdl';

    Permissions = TableData "Tabela Temporária Relatórios" = rimd;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Periodos Processamento"; "Periodos Processamento")
        {
            DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento");

            trigger OnAfterGetRecord()
            begin
                if "Periodos Processamento".GetFilter("Cód. Processamento") <> '' then begin
                    if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then
                        Error(Text0001);
                end else begin
                    SetRange(Estado, "Periodos Processamento".Estado::Fechado);
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetFilter("Cód. Processamento", CodProcess);
                SetRange("Data Inicio Processamento", DataInicio);
                SetRange("Data Fim Processamento", DataFim);
                FiltroDataInicProc := "Periodos Processamento".GetFilter("Data Inicio Processamento");
                FiltroDataFimProc := "Periodos Processamento".GetFilter("Data Fim Processamento");
                FiltroCodProc := "Periodos Processamento".GetFilter("Cód. Processamento");
            end;
        }
        dataitem(Empregado; Empregado)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(FiltroCodProc; FiltroCodProc)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(TabConfEmpresa_City; TabConfEmpresa.City)
            {
            }
            column(TabConfEmpresa_Address; TabConfEmpresa.Address)
            {
            }
            column(TabConfEmpresa_Name; TabConfEmpresa.Name)
            {
            }
            column(TabConfEmpresa__Post_Code_; TabConfEmpresa."Post Code")
            {
            }
            column(TabConfEmpresa_Picture; TabConfEmpresa.Picture)
            {
            }
            column(FiltroCodProcCol; 'Processamento: ' + FiltroCodProc)
            {
            }
            column(TabConfEmpresa__Name_2_; TabConfEmpresa."Name 2")
            {
            }
            column(N__Telefone______TabConfEmpresa__Phone_No__; 'Nº Telefone: ' + TabConfEmpresa."Phone No.")
            {
            }
            column(N__Contribuinte______TabConfEmpresa__VAT_Registration_No__; 'Nº Contribuinte: ' + TabConfEmpresa."VAT Registration No.")
            {
            }
            column(FORMAT_TODAY_0_4__Control1102056011; Format(Today, 0, 4))
            {
            }
            column(USERID_Control1102056034; UserId)
            {
            }
            column(TabConfEmpresa_Picture_Control1102056056; TabConfEmpresa.Picture)
            {
            }
            column(Processamento______FORMAT_FiltroDataInicProc_______a_____FORMAT_FiltroDataFimProc__; 'Processamento: ' + Format(FiltroDataInicProc) + ' a ' + Format(FiltroDataFimProc))
            {
            }
            column(TabConfEmpresa__Name_2__Control1102056092; TabConfEmpresa."Name 2")
            {
            }
            column(TabConfEmpresa_Name_Control1102056093; TabConfEmpresa.Name)
            {
            }
            column(TabConfEmpresa_Address_Control1102056094; TabConfEmpresa.Address)
            {
            }
            column(TabConfEmpresa_City_Control1102056095; TabConfEmpresa.City)
            {
            }
            column(N__Telefone______TabConfEmpresa__Phone_No___Control1102056096; 'Nº Telefone: ' + TabConfEmpresa."Phone No.")
            {
            }
            column(N__Contribuinte______TabConfEmpresa__VAT_Registration_No___Control1102056097; 'Nº Contribuinte: ' + TabConfEmpresa."VAT Registration No.")
            {
            }
            column(TabConfEmpresa__Post_Code__Control1102056098; TabConfEmpresa."Post Code")
            {
            }
            column(Empregado_Empregado__No__; Empregado."No.")
            {
            }
            column(Empregado_Empregado_Name; Empregado.Name)
            {
            }
            column("Empregado__Grau_Função_"; "Grau Função")
            {
            }
            column("Empregado__Descrição_Grau_Função_"; "Descrição Grau Função")
            {
            }
            column("Empregado__Descrição_Cat_Prof"; "Descrição Cat Prof")
            {
            }
            column(Empregado_Empregado__Statistics_Group_Code_; Empregado."Statistics Group Code")
            {
            }
            column(varDescricaoDepartamento; varDescricaoDepartamento)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Mapa_de_AcumuladosCaption; Mapa_de_AcumuladosCaptionLbl)
            {
            }
            column(CurrReport_PAGENO_Control1102056035Caption; CurrReport_PAGENO_Control1102056035CaptionLbl)
            {
            }
            column(Mapa_de_AcumuladosCaption_Control1102056057; Mapa_de_AcumuladosCaption_Control1102056057Lbl)
            {
            }
            column(N__Caption; N__CaptionLbl)
            {
            }
            column(Nome_Caption; Nome_CaptionLbl)
            {
            }
            column("RúbricaCaption"; RúbricaCaptionLbl)
            {
            }
            column(JanCaption; JanCaptionLbl)
            {
            }
            column(FevCaption; FevCaptionLbl)
            {
            }
            column(MarCaption; MarCaptionLbl)
            {
            }
            column(AbrCaption; AbrCaptionLbl)
            {
            }
            column(MaiCaption; MaiCaptionLbl)
            {
            }
            column(JunCaption; JunCaptionLbl)
            {
            }
            column(JulCaption; JulCaptionLbl)
            {
            }
            column(AgoCaption; AgoCaptionLbl)
            {
            }
            column(SetCaption; SetCaptionLbl)
            {
            }
            column(OutCaption; OutCaptionLbl)
            {
            }
            column(NovCaption; NovCaptionLbl)
            {
            }
            column(DezCaption; DezCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column("Grau_Função__Caption"; Grau_Função__CaptionLbl)
            {
            }
            column(Categoria_Profissional_Caption; Categoria_Profissional_CaptionLbl)
            {
            }
            column(Departamento__Caption; Departamento__CaptionLbl)
            {
            }
            column(Totais_Caption; Totais_CaptionLbl)
            {
            }
            column(JanCaption_Control1102056067; JanCaption_Control1102056067Lbl)
            {
            }
            column(FevCaption_Control1102056068; FevCaption_Control1102056068Lbl)
            {
            }
            column(MarCaption_Control1102056069; MarCaption_Control1102056069Lbl)
            {
            }
            column(AbrCaption_Control1102056070; AbrCaption_Control1102056070Lbl)
            {
            }
            column(MaiCaption_Control1102056071; MaiCaption_Control1102056071Lbl)
            {
            }
            column(JunCaption_Control1102056072; JunCaption_Control1102056072Lbl)
            {
            }
            column(JulCaption_Control1102056073; JulCaption_Control1102056073Lbl)
            {
            }
            column(AgoCaption_Control1102056074; AgoCaption_Control1102056074Lbl)
            {
            }
            column(SetCaption_Control1102056075; SetCaption_Control1102056075Lbl)
            {
            }
            column(OutCaption_Control1102056076; OutCaption_Control1102056076Lbl)
            {
            }
            column(NovCaption_Control1102056077; NovCaption_Control1102056077Lbl)
            {
            }
            column(DezCaption_Control1102056078; DezCaption_Control1102056078Lbl)
            {
            }
            column(TotalCaption_Control1102056079; TotalCaption_Control1102056079Lbl)
            {
            }
            column(Totais_Caption_Control1102056017; Totais_Caption_Control1102056017Lbl)
            {
            }
            dataitem("Hist. Linhas Movs. Empregado"; "Hist. Linhas Movs. Empregado")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "Employee No.", "No. Linha") WHERE("Tipo Processamento" = FILTER(<> Encargos));

                trigger OnAfterGetRecord()
                begin
                    FillTabelaTemporáriaRelatórios("Hist. Linhas Movs. Empregado");

                    if CodEmpregado <> "Hist. Linhas Movs. Empregado"."Employee No." then begin
                        CodEmpregado := "Hist. Linhas Movs. Empregado"."Employee No.";
                        NumeroEmpregado := NumeroEmpregado + 1;
                    end;
                end;

                trigger OnPreDataItem()
                var
                    _DataInicioProcMin: Date;
                    _DataInicioProcMax: Date;
                    _DataFimProcMin: Date;
                    _DataFimProcMax: Date;
                    _PerProcessamento: Record "Periodos Processamento";
                begin
                    Clear(LastEmpNo);
                    Clear(contador);
                    Clear(Valores);
                    Clear(TotalTotais);

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

                            SetRange("Data Registo", _DataInicioProcMin, _DataFimProcMax)
                        end;
                    end else
                        SetFilter("Cód. Processamento", FiltroCodProc);

                    TabTemp.DeleteAll;
                end;
            }
            dataitem(Cab; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(TabTemp_Code2; TabTemp.Code2)
                {
                }
                column(TabTemp_Decimal1; TabTemp.Decimal1)
                {
                }
                column(TabTemp_Decimal2; TabTemp.Decimal2)
                {
                }
                column(TabTemp_Decimal3; TabTemp.Decimal3)
                {
                }
                column(TabTemp_Decimal4; TabTemp.Decimal4)
                {
                }
                column(TabTemp_Decimal5; TabTemp.Decimal5)
                {
                }
                column(TabTemp_Decimal6; TabTemp.Decimal6)
                {
                }
                column(TabTemp_Decimal7; TabTemp.Decimal7)
                {
                }
                column(TabTemp_Decimal8; TabTemp.Decimal8)
                {
                }
                column(TabTemp_Decimal9; TabTemp.Decimal9)
                {
                }
                column(TabTemp_Decimal10; TabTemp.Decimal10)
                {
                }
                column(TabTemp_Decimal11; TabTemp.Decimal11)
                {
                }
                column(TabTemp_Decimal12; TabTemp.Decimal12)
                {
                }
                column(TabTemp_Decimal13; TabTemp.Decimal1 + TabTemp.Decimal2 + TabTemp.Decimal3 + TabTemp.Decimal4 + TabTemp.Decimal5 + TabTemp.Decimal6 + TabTemp.Decimal7 + TabTemp.Decimal8 + TabTemp.Decimal9 + TabTemp.Decimal10 + TabTemp.Decimal11 + TabTemp.Decimal12)
                {
                }
                column(TotaisPorMes_13_; TotaisPorMes[13])
                {
                }
                column(TotaisPorMes_12_; TotaisPorMes[12])
                {
                }
                column(TotaisPorMes_11_; TotaisPorMes[11])
                {
                }
                column(TotaisPorMes_10_; TotaisPorMes[10])
                {
                }
                column(TotaisPorMes_9_; TotaisPorMes[9])
                {
                }
                column(TotaisPorMes_8_; TotaisPorMes[8])
                {
                }
                column(TotaisPorMes_7_; TotaisPorMes[7])
                {
                }
                column(TotaisPorMes_6_; TotaisPorMes[6])
                {
                }
                column(TotaisPorMes_5_; TotaisPorMes[5])
                {
                }
                column(TotaisPorMes_4_; TotaisPorMes[4])
                {
                }
                column(TotaisPorMes_3_; TotaisPorMes[3])
                {
                }
                column(TotaisPorMes_2_; TotaisPorMes[2])
                {
                }
                column(TotaisPorMes_1_; TotaisPorMes[1])
                {
                }
                column("Totais_Líquidos_Caption"; Totais_Líquidos_CaptionLbl)
                {
                }
                column(Cab_Number; Number)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Number <> 1 then
                        TabTemp.Next
                    else
                        TabTemp.Find('-');

                    FiltroPreenchido;

                    //RH-010 - 21.03.2007
                    TempTabTempRelatorios.Reset;
                    //2008.01.15 - não se pode fazer filtro pela descrição pois pode mudar
                    TempTabTempRelatorios.SetRange(TempTabTempRelatorios.Code3, TabTemp.Code3);
                    NLinha := NLinha + 10000;
                    if not TempTabTempRelatorios.Find('-') then begin
                        TempTabTempRelatorios.Init;
                        TempTabTempRelatorios."Line No" := NLinha;
                        TempTabTempRelatorios.Code2 := TabTemp.Code2;
                        TempTabTempRelatorios.Code3 := TabTemp.Code3;//2008.01.15 - preencher o codigo da rubrica par usar em filtros
                        TempTabTempRelatorios.Decimal1 := TabTemp.Decimal1;
                        TempTabTempRelatorios.Decimal2 := TabTemp.Decimal2;
                        TempTabTempRelatorios.Decimal3 := TabTemp.Decimal3;
                        TempTabTempRelatorios.Decimal4 := TabTemp.Decimal4;
                        TempTabTempRelatorios.Decimal5 := TabTemp.Decimal5;
                        TempTabTempRelatorios.Decimal6 := TabTemp.Decimal6;
                        TempTabTempRelatorios.Decimal7 := TabTemp.Decimal7;
                        TempTabTempRelatorios.Decimal8 := TabTemp.Decimal8;
                        TempTabTempRelatorios.Decimal9 := TabTemp.Decimal9;
                        TempTabTempRelatorios.Decimal10 := TabTemp.Decimal10;
                        TempTabTempRelatorios.Decimal11 := TabTemp.Decimal11;
                        TempTabTempRelatorios.Decimal12 := TabTemp.Decimal12;
                        TempTabTempRelatorios.Insert;
                    end else begin
                        TempTabTempRelatorios.Decimal1 := TempTabTempRelatorios.Decimal1 + TabTemp.Decimal1;
                        TempTabTempRelatorios.Decimal2 := TempTabTempRelatorios.Decimal2 + TabTemp.Decimal2;
                        TempTabTempRelatorios.Decimal3 := TempTabTempRelatorios.Decimal3 + TabTemp.Decimal3;
                        TempTabTempRelatorios.Decimal4 := TempTabTempRelatorios.Decimal4 + TabTemp.Decimal4;
                        TempTabTempRelatorios.Decimal5 := TempTabTempRelatorios.Decimal5 + TabTemp.Decimal5;
                        TempTabTempRelatorios.Decimal6 := TempTabTempRelatorios.Decimal6 + TabTemp.Decimal6;
                        TempTabTempRelatorios.Decimal7 := TempTabTempRelatorios.Decimal7 + TabTemp.Decimal7;
                        TempTabTempRelatorios.Decimal8 := TempTabTempRelatorios.Decimal8 + TabTemp.Decimal8;
                        TempTabTempRelatorios.Decimal9 := TempTabTempRelatorios.Decimal9 + TabTemp.Decimal9;
                        TempTabTempRelatorios.Decimal10 := TempTabTempRelatorios.Decimal10 + TabTemp.Decimal10;
                        TempTabTempRelatorios.Decimal11 := TempTabTempRelatorios.Decimal11 + TabTemp.Decimal11;
                        TempTabTempRelatorios.Decimal12 := TempTabTempRelatorios.Decimal12 + TabTemp.Decimal12;
                        TempTabTempRelatorios.Modify;
                    end;
                    // A coluna 13 sao os totais de todos os meses
                    TotaisPorMes[1] := TotaisPorMes[1] + TabTemp.Decimal1;
                    TotaisPorMes[2] := TotaisPorMes[2] + TabTemp.Decimal2;
                    TotaisPorMes[3] := TotaisPorMes[3] + TabTemp.Decimal3;
                    TotaisPorMes[4] := TotaisPorMes[4] + TabTemp.Decimal4;
                    TotaisPorMes[5] := TotaisPorMes[5] + TabTemp.Decimal5;
                    TotaisPorMes[6] := TotaisPorMes[6] + TabTemp.Decimal6;
                    TotaisPorMes[7] := TotaisPorMes[7] + TabTemp.Decimal7;
                    TotaisPorMes[8] := TotaisPorMes[8] + TabTemp.Decimal8;
                    TotaisPorMes[9] := TotaisPorMes[9] + TabTemp.Decimal9;
                    TotaisPorMes[10] := TotaisPorMes[10] + TabTemp.Decimal10;
                    TotaisPorMes[11] := TotaisPorMes[11] + TabTemp.Decimal11;
                    TotaisPorMes[12] := TotaisPorMes[12] + TabTemp.Decimal12;
                end;

                trigger OnPostDataItem()
                begin
                    TabTemp.Reset;
                    TabTemp.DeleteAll;
                end;

                trigger OnPreDataItem()
                begin
                    TabTemp.Reset;
                    TabTemp.SetRange(Code1, Empregado."No.");
                    contadorAcum := TabTemp.Count;

                    SetRange(Number, 1, contadorAcum);
                end;
            }

            trigger OnAfterGetRecord()
            var
                _DataInicioProcMin: Date;
                _DataInicioProcMax: Date;
                _DataFimProcMin: Date;
                _DataFimProcMax: Date;
                _PerProcessamento: Record "Periodos Processamento";
            begin
                if TabGrupoEstEmp.Get(Empregado."Statistics Group Code") then
                    varDescricaoDepartamento := TabGrupoEstEmp.Description;

                Clear(Valores);
                First := false;
                Clear(LineNo);
                Clear(TotaisPorMes);

                TabLinhasMovsEmpregado.Reset;
                TabLinhasMovsEmpregado.SetCurrentKey("Cód. Processamento", "Tipo Processamento", "Employee No.", "No. Linha");
                TabLinhasMovsEmpregado.SetFilter("Tipo Processamento", '<>%1', TabLinhasMovsEmpregado."Tipo Processamento"::Encargos);
                TabLinhasMovsEmpregado.SetRange("Employee No.", "No.");
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
                        TabLinhasMovsEmpregado.SetRange("Data Registo", _DataInicioProcMin, _DataFimProcMax)
                    end;
                end else
                    TabLinhasMovsEmpregado.SetFilter("Cód. Processamento", FiltroCodProc);

                if not TabLinhasMovsEmpregado.Find('-') then
                    CurrReport.Skip;

                LastEmpNo := "No.";
            end;

            trigger OnPreDataItem()
            begin
                //----------------------------------------
                //Isto serve para filtrar os dados das rubricas para que só apareçam os que estão em vigor
                //ou seja, os que têm a data de inicio  anterior à data de fim de processamento
                // e que têm a data de fim posterior à data de inicio de processamento ou vazia
                //SETFILTER("Data Filtro Inicio",'<=%1',"Periodos Processamento"."Data Fim Processamento");
                //SETFILTER("Data Filtro Fim",'>=%1|=%2',"Periodos Processamento"."Data Inicio Processamento",0D);
            end;
        }
        dataitem(totais; "Integer")
        {
            DataItemTableView = SORTING(Number);
            column(TempTabTempRelatorios_Code2; TempTabTempRelatorios.Code2)
            {
            }
            column(TempTabTempRelatorios_Decimal1; TempTabTempRelatorios.Decimal1)
            {
            }
            column(TempTabTempRelatorios_Decimal2; TempTabTempRelatorios.Decimal2)
            {
            }
            column(TempTabTempRelatorios_Decimal3; TempTabTempRelatorios.Decimal3)
            {
            }
            column(TempTabTempRelatorios_Decimal4; TempTabTempRelatorios.Decimal4)
            {
            }
            column(TempTabTempRelatorios_Decimal5; TempTabTempRelatorios.Decimal5)
            {
            }
            column(TempTabTempRelatorios_Decimal6; TempTabTempRelatorios.Decimal6)
            {
            }
            column(TempTabTempRelatorios_Decimal7; TempTabTempRelatorios.Decimal7)
            {
            }
            column(TempTabTempRelatorios_Decimal8; TempTabTempRelatorios.Decimal8)
            {
            }
            column(TempTabTempRelatorios_Decimal9; TempTabTempRelatorios.Decimal9)
            {
            }
            column(TempTabTempRelatorios_Decimal10; TempTabTempRelatorios.Decimal10)
            {
            }
            column(TempTabTempRelatorios_Decimal11; TempTabTempRelatorios.Decimal11)
            {
            }
            column(TempTabTempRelatorios_Decimal12; TempTabTempRelatorios.Decimal12)
            {
            }
            column(TotalTotais; TotalTotais)
            {
            }
            column(Processado_por_ComputadorCaption; Processado_por_ComputadorCaptionLbl)
            {
            }
            column(totais_Number; Number)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if NumeroEmpregado <= 1 then
                    CurrReport.Skip;

                if totais.Number <> 1 then
                    TempTabTempRelatorios.Next
                else
                    TempTabTempRelatorios.Find('-');

                TotalTotais := TempTabTempRelatorios.Decimal1 + TempTabTempRelatorios.Decimal2 + TempTabTempRelatorios.Decimal3 +
                           TempTabTempRelatorios.Decimal4 + TempTabTempRelatorios.Decimal5 + TempTabTempRelatorios.Decimal6 +
                           TempTabTempRelatorios.Decimal7 + TempTabTempRelatorios.Decimal8 + TempTabTempRelatorios.Decimal9 +
                           TempTabTempRelatorios.Decimal10 + TempTabTempRelatorios.Decimal11 +
                           TempTabTempRelatorios.Decimal12;
            end;

            trigger OnPreDataItem()
            begin
                TempTabTempRelatorios.Reset;
                totais.SetRange(Number, 1, TempTabTempRelatorios.Count);
                TempTabTempRelatorios.Find('-');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Acumulados)
                {
                    Caption = 'Acumulados';
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
        lblTotaisLiq = 'Totais Líquidos:';
    }

    trigger OnPreReport()
    begin
        TabConfEmpresa.Get;
        TabConfEmpresa.CalcFields(TabConfEmpresa.Picture);

        FiltroDataInicProc := '';
        FiltroDataFimProc := '';
        FiltroCodProc := '';

        if (FiltroDataInicProc <> '') and (FiltroDataFimProc <> '') and (FiltroCodProc <> '') then
            Error(Text0003);

        if (FiltroDataFimProc <> '') and (FiltroDataInicProc = '') then
            Error(Text0004);

        if (FiltroDataInicProc <> '') and (FiltroDataFimProc = '') then
            Error(Text0004);
    end;

    var
        TabConfEmpresa: Record "Company Information";
        Text0001: Label 'Não pode usar um período de processamento aberto.';
        TabLinhasMovsEmpregado: Record "Hist. Linhas Movs. Empregado";
        TabTemp: Record "Tabela Temporária Relatórios";
        recLinhasMovsEmpregado: Record "Hist. Linhas Movs. Empregado";
        recRubricaSalarial: Record "Rubrica Salarial";
        LastEmpNo: Code[20];
        LastEmpTotal: Code[20];
        First: Boolean;
        Valores: Decimal;
        ValoresTotal: array[13] of Decimal;
        contador: Integer;
        contadorAcum: Integer;
        Rubrica: Text[80];
        passou: Boolean;
        Mes: Integer;
        LineNo: Integer;
        FiltroDataInicProc: Text[1024];
        FiltroDataFimProc: Text[1024];
        FiltroCodProc: Text[1024];
        Text0003: Label 'Os filtros data de processamento e código de processamento são exclusivos. Não pode selecionar ambos.';
        Text0004: Label 'Tem que preencher a data de início e fim de processamento.';
        TempTabTempRelatorios: Record "Tabela Temporária Relatórios" temporary;
        NLinha: Integer;
        TotalTotais: Decimal;
        TotaisPorMes: array[13] of Decimal;
        i: Integer;
        CodEmpregado: Code[20];
        NumeroEmpregado: Integer;
        TabGrupoEstEmp: Record "Departamentos Empregado";
        varDescricaoDepartamento: Text[30];
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Mapa_de_AcumuladosCaptionLbl: Label 'Mapa de Acumulados';
        CurrReport_PAGENO_Control1102056035CaptionLbl: Label 'Page';
        Mapa_de_AcumuladosCaption_Control1102056057Lbl: Label 'Mapa de Acumulados';
        N__CaptionLbl: Label 'Nº:';
        Nome_CaptionLbl: Label 'Nome:';
        "RúbricaCaptionLbl": Label 'Rúbrica';
        JanCaptionLbl: Label 'Jan';
        FevCaptionLbl: Label 'Fev';
        MarCaptionLbl: Label 'Mar';
        AbrCaptionLbl: Label 'Abr';
        MaiCaptionLbl: Label 'Mai';
        JunCaptionLbl: Label 'Jun';
        JulCaptionLbl: Label 'Jul';
        AgoCaptionLbl: Label 'Ago';
        SetCaptionLbl: Label 'Set';
        OutCaptionLbl: Label 'Out';
        NovCaptionLbl: Label 'Nov';
        DezCaptionLbl: Label 'Dez';
        TotalCaptionLbl: Label 'Total';
        "Grau_Função__CaptionLbl": Label 'Grau Função :';
        Categoria_Profissional_CaptionLbl: Label 'Categoria Profissional:';
        Departamento__CaptionLbl: Label 'Departamento :';
        Totais_CaptionLbl: Label 'Totais:';
        JanCaption_Control1102056067Lbl: Label 'Jan';
        FevCaption_Control1102056068Lbl: Label 'Fev';
        MarCaption_Control1102056069Lbl: Label 'Mar';
        AbrCaption_Control1102056070Lbl: Label 'Abr';
        MaiCaption_Control1102056071Lbl: Label 'Mai';
        JunCaption_Control1102056072Lbl: Label 'Jun';
        JulCaption_Control1102056073Lbl: Label 'Jul';
        AgoCaption_Control1102056074Lbl: Label 'Ago';
        SetCaption_Control1102056075Lbl: Label 'Set';
        OutCaption_Control1102056076Lbl: Label 'Out';
        NovCaption_Control1102056077Lbl: Label 'Nov';
        DezCaption_Control1102056078Lbl: Label 'Dez';
        TotalCaption_Control1102056079Lbl: Label 'Total';
        "Totais_Líquidos_CaptionLbl": Label 'Totais Líquidos:';
        Totais_Caption_Control1102056017Lbl: Label 'Totais:';
        JanCaption_Control1102056020Lbl: Label 'Jan';
        FevCaption_Control1102056110Lbl: Label 'Fev';
        MarCaption_Control1102056111Lbl: Label 'Mar';
        AbrCaption_Control1102056118Lbl: Label 'Abr';
        MaiCaption_Control1102056119Lbl: Label 'Mai';
        JunCaption_Control1102056120Lbl: Label 'Jun';
        JulCaption_Control1102056121Lbl: Label 'Jul';
        AgoCaption_Control1102056122Lbl: Label 'Ago';
        SetCaption_Control1102056123Lbl: Label 'Set';
        OutCaption_Control1102056124Lbl: Label 'Out';
        NovCaption_Control1102056125Lbl: Label 'Nov';
        DezCaption_Control1102056126Lbl: Label 'Dez';
        TotalCaption_Control1102056127Lbl: Label 'Total';
        Mapa_de_AcumuladosCaption_Control1102056128Lbl: Label 'Mapa de Acumulados';
        CurrReport_PAGENO_Control1102056129CaptionLbl: Label 'Page';
        Processado_por_ComputadorCaptionLbl: Label 'Processado por Computador';
        CodProcess: Code[10];
        DataInicio: Date;
        DataFim: Date;


    procedure "FillTabelaTemporáriaRelatórios"(pHistLinhasMovsEmpregado: Record "Hist. Linhas Movs. Empregado")
    var
        TabTemp: Record "Tabela Temporária Relatórios";
        TabTemp2: Record "Tabela Temporária Relatórios";
        recHistLinhasMovsEmpregado: Record "Hist. Linhas Movs. Empregado";
        TabRubrica: Record "Rubrica Salarial";
        TabRubricaLinha2: Record "Rubrica Salarial Linhas";
        ValorAbonosIRS: Decimal;
        ValorAbonosSS: Decimal;
        ValorDesc1: Decimal;
        ValorDesc2: Decimal;
        Rubrica1: Code[20];
        Rubrica2: Code[20];
        Rubrica3: Code[20];
        Rubrica4: Code[20];
        Rubrica5: Code[20];
        Quant: Decimal;
        Venc: Decimal;
        Valor1: Decimal;
        Valor2: Decimal;
        ValorTot: Decimal;
        ValorTotal: Decimal;
    begin
        TabTemp.Reset;
        TabTemp.SetRange(Code1, pHistLinhasMovsEmpregado."Employee No.");
        //2008.01.15 - não se pode fazer filtro pela descrição pois pode mudar
        TabTemp.SetRange(Code3, pHistLinhasMovsEmpregado."Cód. Rubrica");
        if not TabTemp.FindFirst then begin
            TabTemp.Init;
            TabTemp.Code1 := pHistLinhasMovsEmpregado."Employee No.";
            TabTemp.Code2 := pHistLinhasMovsEmpregado."Descrição Rubrica";
            //2008.01.15 - preencher o campo code 3 para depois servir de filtro
            TabTemp.Code3 := pHistLinhasMovsEmpregado."Cód. Rubrica";

            if LineNo = 0 then
                TabTemp."Line No" := 10000
            else
                TabTemp."Line No" := LineNo + 10000;

            Mes := 0;
            Mes := Date2DMY("Hist. Linhas Movs. Empregado"."Data Registo", 2);

            case Mes of
                1:
                    TabTemp.Decimal1 := pHistLinhasMovsEmpregado.Valor;
                2:
                    TabTemp.Decimal2 := pHistLinhasMovsEmpregado.Valor;
                3:
                    TabTemp.Decimal3 := pHistLinhasMovsEmpregado.Valor;
                4:
                    TabTemp.Decimal4 := pHistLinhasMovsEmpregado.Valor;
                5:
                    TabTemp.Decimal5 := pHistLinhasMovsEmpregado.Valor;
                6:
                    TabTemp.Decimal6 := pHistLinhasMovsEmpregado.Valor;
                7:
                    TabTemp.Decimal7 := pHistLinhasMovsEmpregado.Valor;
                8:
                    TabTemp.Decimal8 := pHistLinhasMovsEmpregado.Valor;
                9:
                    TabTemp.Decimal9 := pHistLinhasMovsEmpregado.Valor;
                10:
                    TabTemp.Decimal10 := pHistLinhasMovsEmpregado.Valor;
                11:
                    TabTemp.Decimal11 := pHistLinhasMovsEmpregado.Valor;
                12:
                    TabTemp.Decimal12 := pHistLinhasMovsEmpregado.Valor;
            end;

            TabTemp.Insert(true);
            LineNo := TabTemp."Line No";
        end else begin
            Mes := 0;
            Mes := Date2DMY("Hist. Linhas Movs. Empregado"."Data Registo", 2);
            //Altereia as linhas  1: TabTemp.Decimal1 := pHistLinhasMovsEmpregado.Valor;
            // para
            //  1: TabTemp.Decimal1 += pHistLinhasMovsEmpregado.Valor;
            case Mes of
                1:
                    TabTemp.Decimal1 += pHistLinhasMovsEmpregado.Valor;
                2:
                    TabTemp.Decimal2 += pHistLinhasMovsEmpregado.Valor;
                3:
                    TabTemp.Decimal3 += pHistLinhasMovsEmpregado.Valor;
                4:
                    TabTemp.Decimal4 += pHistLinhasMovsEmpregado.Valor;
                5:
                    TabTemp.Decimal5 += pHistLinhasMovsEmpregado.Valor;
                6:
                    TabTemp.Decimal6 += pHistLinhasMovsEmpregado.Valor;
                7:
                    TabTemp.Decimal7 += pHistLinhasMovsEmpregado.Valor;
                8:
                    TabTemp.Decimal8 += pHistLinhasMovsEmpregado.Valor;
                9:
                    TabTemp.Decimal9 += pHistLinhasMovsEmpregado.Valor;
                10:
                    TabTemp.Decimal10 += pHistLinhasMovsEmpregado.Valor;
                11:
                    TabTemp.Decimal11 += pHistLinhasMovsEmpregado.Valor;
                12:
                    TabTemp.Decimal12 += pHistLinhasMovsEmpregado.Valor;
            end;
            TabTemp.Modify;
        end;
    end;


    procedure FiltroPreenchido()
    begin
        if "Periodos Processamento".GetFilter("Cód. Processamento") <> '' then begin
            Mes := 0;
            Mes := Date2DMY("Hist. Linhas Movs. Empregado"."Data Registo", 2);
            case Mes of
                1:
                    begin
                        TabTemp.Decimal2 := 0;
                        TabTemp.Decimal3 := 0;
                        TabTemp.Decimal4 := 0;
                        TabTemp.Decimal5 := 0;
                        TabTemp.Decimal6 := 0;
                        TabTemp.Decimal7 := 0;
                        TabTemp.Decimal8 := 0;
                        TabTemp.Decimal9 := 0;
                        TabTemp.Decimal10 := 0;
                        TabTemp.Decimal11 := 0;
                        TabTemp.Decimal12 := 0;

                        ValoresTotal[2] := 0;
                        ValoresTotal[3] := 0;
                        ValoresTotal[4] := 0;
                        ValoresTotal[5] := 0;
                        ValoresTotal[6] := 0;
                        ValoresTotal[7] := 0;
                        ValoresTotal[8] := 0;
                        ValoresTotal[9] := 0;
                        ValoresTotal[10] := 0;
                        ValoresTotal[11] := 0;
                        ValoresTotal[12] := 0;
                    end;
                2:
                    begin
                        TabTemp.Decimal1 := 0;
                        TabTemp.Decimal3 := 0;
                        TabTemp.Decimal4 := 0;
                        TabTemp.Decimal5 := 0;
                        TabTemp.Decimal6 := 0;
                        TabTemp.Decimal7 := 0;
                        TabTemp.Decimal8 := 0;
                        TabTemp.Decimal9 := 0;
                        TabTemp.Decimal10 := 0;
                        TabTemp.Decimal11 := 0;
                        TabTemp.Decimal12 := 0;

                        ValoresTotal[1] := 0;
                        ValoresTotal[3] := 0;
                        ValoresTotal[4] := 0;
                        ValoresTotal[5] := 0;
                        ValoresTotal[6] := 0;
                        ValoresTotal[7] := 0;
                        ValoresTotal[8] := 0;
                        ValoresTotal[9] := 0;
                        ValoresTotal[10] := 0;
                        ValoresTotal[11] := 0;
                        ValoresTotal[12] := 0;
                    end;
                3:
                    begin
                        TabTemp.Decimal1 := 0;
                        TabTemp.Decimal2 := 0;
                        TabTemp.Decimal4 := 0;
                        TabTemp.Decimal5 := 0;
                        TabTemp.Decimal6 := 0;
                        TabTemp.Decimal7 := 0;
                        TabTemp.Decimal8 := 0;
                        TabTemp.Decimal9 := 0;
                        TabTemp.Decimal10 := 0;
                        TabTemp.Decimal11 := 0;
                        TabTemp.Decimal12 := 0;

                        ValoresTotal[1] := 0;
                        ValoresTotal[2] := 0;
                        ValoresTotal[4] := 0;
                        ValoresTotal[5] := 0;
                        ValoresTotal[6] := 0;
                        ValoresTotal[7] := 0;
                        ValoresTotal[8] := 0;
                        ValoresTotal[9] := 0;
                        ValoresTotal[10] := 0;
                        ValoresTotal[11] := 0;
                        ValoresTotal[12] := 0;
                    end;
                4:
                    begin
                        TabTemp.Decimal1 := 0;
                        TabTemp.Decimal2 := 0;
                        TabTemp.Decimal3 := 0;
                        TabTemp.Decimal5 := 0;
                        TabTemp.Decimal6 := 0;
                        TabTemp.Decimal7 := 0;
                        TabTemp.Decimal8 := 0;
                        TabTemp.Decimal9 := 0;
                        TabTemp.Decimal10 := 0;
                        TabTemp.Decimal11 := 0;
                        TabTemp.Decimal12 := 0;

                        ValoresTotal[1] := 0;
                        ValoresTotal[2] := 0;
                        ValoresTotal[3] := 0;
                        ValoresTotal[5] := 0;
                        ValoresTotal[6] := 0;
                        ValoresTotal[7] := 0;
                        ValoresTotal[8] := 0;
                        ValoresTotal[9] := 0;
                        ValoresTotal[10] := 0;
                        ValoresTotal[11] := 0;
                        ValoresTotal[12] := 0;
                    end;
                5:
                    begin
                        TabTemp.Decimal1 := 0;
                        TabTemp.Decimal2 := 0;
                        TabTemp.Decimal3 := 0;
                        TabTemp.Decimal4 := 0;
                        TabTemp.Decimal6 := 0;
                        TabTemp.Decimal7 := 0;
                        TabTemp.Decimal8 := 0;
                        TabTemp.Decimal9 := 0;
                        TabTemp.Decimal10 := 0;
                        TabTemp.Decimal11 := 0;
                        TabTemp.Decimal12 := 0;

                        ValoresTotal[1] := 0;
                        ValoresTotal[2] := 0;
                        ValoresTotal[3] := 0;
                        ValoresTotal[4] := 0;
                        ValoresTotal[6] := 0;
                        ValoresTotal[7] := 0;
                        ValoresTotal[8] := 0;
                        ValoresTotal[9] := 0;
                        ValoresTotal[10] := 0;
                        ValoresTotal[11] := 0;
                        ValoresTotal[12] := 0;
                    end;
                6:
                    begin
                        TabTemp.Decimal1 := 0;
                        TabTemp.Decimal2 := 0;
                        TabTemp.Decimal3 := 0;
                        TabTemp.Decimal4 := 0;
                        TabTemp.Decimal5 := 0;
                        TabTemp.Decimal7 := 0;
                        TabTemp.Decimal8 := 0;
                        TabTemp.Decimal9 := 0;
                        TabTemp.Decimal10 := 0;
                        TabTemp.Decimal11 := 0;
                        TabTemp.Decimal12 := 0;

                        ValoresTotal[1] := 0;
                        ValoresTotal[2] := 0;
                        ValoresTotal[3] := 0;
                        ValoresTotal[4] := 0;
                        ValoresTotal[5] := 0;
                        ValoresTotal[7] := 0;
                        ValoresTotal[8] := 0;
                        ValoresTotal[9] := 0;
                        ValoresTotal[10] := 0;
                        ValoresTotal[11] := 0;
                        ValoresTotal[12] := 0;
                    end;
                7:
                    begin
                        TabTemp.Decimal1 := 0;
                        TabTemp.Decimal2 := 0;
                        TabTemp.Decimal3 := 0;
                        TabTemp.Decimal4 := 0;
                        TabTemp.Decimal5 := 0;
                        TabTemp.Decimal6 := 0;
                        TabTemp.Decimal8 := 0;
                        TabTemp.Decimal9 := 0;
                        TabTemp.Decimal10 := 0;
                        TabTemp.Decimal11 := 0;
                        TabTemp.Decimal12 := 0;

                        ValoresTotal[1] := 0;
                        ValoresTotal[2] := 0;
                        ValoresTotal[3] := 0;
                        ValoresTotal[4] := 0;
                        ValoresTotal[5] := 0;
                        ValoresTotal[6] := 0;
                        ValoresTotal[8] := 0;
                        ValoresTotal[9] := 0;
                        ValoresTotal[10] := 0;
                        ValoresTotal[11] := 0;
                        ValoresTotal[12] := 0;
                    end;
                8:
                    begin
                        TabTemp.Decimal1 := 0;
                        TabTemp.Decimal2 := 0;
                        TabTemp.Decimal3 := 0;
                        TabTemp.Decimal4 := 0;
                        TabTemp.Decimal5 := 0;
                        TabTemp.Decimal6 := 0;
                        TabTemp.Decimal7 := 0;
                        TabTemp.Decimal9 := 0;
                        TabTemp.Decimal10 := 0;
                        TabTemp.Decimal11 := 0;
                        TabTemp.Decimal12 := 0;

                        ValoresTotal[1] := 0;
                        ValoresTotal[2] := 0;
                        ValoresTotal[3] := 0;
                        ValoresTotal[4] := 0;
                        ValoresTotal[5] := 0;
                        ValoresTotal[6] := 0;
                        ValoresTotal[7] := 0;
                        ValoresTotal[9] := 0;
                        ValoresTotal[10] := 0;
                        ValoresTotal[11] := 0;
                        ValoresTotal[12] := 0;
                    end;
                9:
                    begin
                        TabTemp.Decimal1 := 0;
                        TabTemp.Decimal2 := 0;
                        TabTemp.Decimal3 := 0;
                        TabTemp.Decimal4 := 0;
                        TabTemp.Decimal5 := 0;
                        TabTemp.Decimal6 := 0;
                        TabTemp.Decimal7 := 0;
                        TabTemp.Decimal8 := 0;
                        TabTemp.Decimal10 := 0;
                        TabTemp.Decimal11 := 0;
                        TabTemp.Decimal12 := 0;

                        ValoresTotal[1] := 0;
                        ValoresTotal[2] := 0;
                        ValoresTotal[3] := 0;
                        ValoresTotal[4] := 0;
                        ValoresTotal[5] := 0;
                        ValoresTotal[6] := 0;
                        ValoresTotal[7] := 0;
                        ValoresTotal[8] := 0;
                        ValoresTotal[10] := 0;
                        ValoresTotal[11] := 0;
                        ValoresTotal[12] := 0;
                    end;
                10:
                    begin
                        TabTemp.Decimal1 := 0;
                        TabTemp.Decimal2 := 0;
                        TabTemp.Decimal3 := 0;
                        TabTemp.Decimal4 := 0;
                        TabTemp.Decimal5 := 0;
                        TabTemp.Decimal6 := 0;
                        TabTemp.Decimal7 := 0;
                        TabTemp.Decimal8 := 0;
                        TabTemp.Decimal9 := 0;
                        TabTemp.Decimal11 := 0;
                        TabTemp.Decimal12 := 0;

                        ValoresTotal[1] := 0;
                        ValoresTotal[2] := 0;
                        ValoresTotal[3] := 0;
                        ValoresTotal[4] := 0;
                        ValoresTotal[5] := 0;
                        ValoresTotal[6] := 0;
                        ValoresTotal[7] := 0;
                        ValoresTotal[8] := 0;
                        ValoresTotal[9] := 0;
                        ValoresTotal[11] := 0;
                        ValoresTotal[12] := 0;
                    end;
                11:
                    begin
                        TabTemp.Decimal1 := 0;
                        TabTemp.Decimal2 := 0;
                        TabTemp.Decimal3 := 0;
                        TabTemp.Decimal4 := 0;
                        TabTemp.Decimal5 := 0;
                        TabTemp.Decimal6 := 0;
                        TabTemp.Decimal7 := 0;
                        TabTemp.Decimal8 := 0;
                        TabTemp.Decimal9 := 0;
                        TabTemp.Decimal10 := 0;
                        TabTemp.Decimal12 := 0;

                        ValoresTotal[1] := 0;
                        ValoresTotal[2] := 0;
                        ValoresTotal[3] := 0;
                        ValoresTotal[4] := 0;
                        ValoresTotal[5] := 0;
                        ValoresTotal[6] := 0;
                        ValoresTotal[7] := 0;
                        ValoresTotal[8] := 0;
                        ValoresTotal[9] := 0;
                        ValoresTotal[10] := 0;
                        ValoresTotal[12] := 0;
                    end;
                12:
                    begin
                        TabTemp.Decimal1 := 0;
                        TabTemp.Decimal2 := 0;
                        TabTemp.Decimal3 := 0;
                        TabTemp.Decimal4 := 0;
                        TabTemp.Decimal5 := 0;
                        TabTemp.Decimal6 := 0;
                        TabTemp.Decimal7 := 0;
                        TabTemp.Decimal8 := 0;
                        TabTemp.Decimal9 := 0;
                        TabTemp.Decimal10 := 0;
                        TabTemp.Decimal11 := 0;

                        ValoresTotal[1] := 0;
                        ValoresTotal[2] := 0;
                        ValoresTotal[3] := 0;
                        ValoresTotal[4] := 0;
                        ValoresTotal[5] := 0;
                        ValoresTotal[6] := 0;
                        ValoresTotal[7] := 0;
                        ValoresTotal[8] := 0;
                        ValoresTotal[9] := 0;
                        ValoresTotal[10] := 0;
                        ValoresTotal[11] := 0;
                    end;
            end;
        end;
    end;
}

