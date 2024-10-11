report 53042 "Ficheiro Seg. Social"
{
    // //-------------------------------------------------------
    //               Ficheiro da Seg. Social
    // //--------------------------------------------------------
    //   É um ficheiro que deve ser entregue mensalmente pela empresa
    //   com os rendimentos dos empregados agrupados por estabelecimento a
    //   que os mesmos pertencem e por taxa de desconto.
    // 
    //   Este mapa deve sair em formato txt e como tal numa primeira fase
    //   exporta os dados para uma tabela criada para este tipo de mapas
    //   (Tabela Temp Ficheiro Texto) e depois corre um dataport (Temp Ficheiro Texto)
    //   para criar o ficheiro txt
    // 
    //   Tipos de Registo:
    //     R0 - Identificação do Ficheiro
    //     R1 - Identificação da Entidade empregadora
    //     R2 - Remunerações do Trabalhador
    //     R3 - Registo de Totais
    // //-------------------------------------------------------
    // IT007 - JTP - 2020.06.08 - Contemplar férias não gozadas de anos diferentes
    // 
    // IT008 - JTP - 2020.07.02 - Sub. Férias - Considerar "Data Registo" caso "Data a que se refere o Mov" esteja vazia
    // 
    // IT009 - JTP - 2020.08.05 - Admissão/Demissão estava a ser contada em duplicado
    // 
    // IT010 - JTP - 2021.04.09 - Sub. Natal - Considerar "Data Registo" caso "Data a que se refere o Mov" esteja vazia
    UsageCategory = Tasks;
    ApplicationArea = HumanResourcesAppArea;

    Permissions = TableData "Tabela Temp Ficheiros Texto" = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Periodos Processamento"; "Periodos Processamento")
        {
            DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento");

            trigger OnAfterGetRecord()
            begin
                if "Periodos Processamento".Estado <> "Periodos Processamento".Estado::Fechado then begin
                    Message(Text0001);
                    CurrReport.Quit;
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetFilter("Cód. Processamento", CodProcess);
                if DataInicio <> 0D then
                    SetRange("Data Inicio Processamento", DataInicio);
                if DataFim <> 0D then
                    SetRange("Data Fim Processamento", DataFim);

                FiltroDataInicProc := "Periodos Processamento".GetFilter("Data Inicio Processamento");
                FiltroDataFimProc := "Periodos Processamento".GetFilter("Data Fim Processamento");
                FiltroCodProc := "Periodos Processamento".GetFilter("Cód. Processamento");

                if (FiltroDataInicProc <> '') and (FiltroDataFimProc <> '') and (FiltroCodProc <> '') then
                    Error(Text0003);

                if (FiltroDataFimProc <> '') and (FiltroDataInicProc = '') then
                    Error(Text0004);

                if (FiltroDataFimProc = '') and (FiltroDataInicProc <> '') then
                    Error(Text0004);

                CodProcessamento := "Periodos Processamento".GetFilter("Cód. Processamento");
            end;
        }
        dataitem("Estabelecimentos da Empresa"; "Estabelecimentos da Empresa")
        {
            DataItemTableView = SORTING("Número da Unidade Local");
            dataitem("Regime Seg. Social"; "Regime Seg. Social")
            {
                DataItemTableView = SORTING("Código");
                dataitem(Empregado; Empregado)
                {
                    DataItemLink = "Cod. Regime SS" = FIELD("Código");
                    DataItemTableView = SORTING(Estabelecimento, "Cod. Regime SS", "No.") WHERE("Subscritor SS" = CONST(true));
                    dataitem("Hist. Linhas Movs. Empregado"; "Hist. Linhas Movs. Empregado")
                    {
                        DataItemLink = "Employee No." = FIELD("No.");
                        DataItemTableView = SORTING("Employee No.", "Data Registo");
                        RequestFilterFields = "Employee No.";

                        trigger OnAfterGetRecord()
                        var
                            l_HistLinhaMov: Record "Hist. Linhas Movs. Empregado";
                            l_HistLinhaMov2: Record "Hist. Linhas Movs. Empregado";
                            l_RubricaFalta: Record "Payroll Item";
                            l_Rubrica: Record "Payroll Item";
                        begin
                            if CodEmpregado <> "Hist. Linhas Movs. Empregado"."Employee No." then begin
                                TabControlar.DeleteAll;
                                CodEmpregado := "Hist. Linhas Movs. Empregado"."Employee No.";
                            end;

                            TempHistLinhasMovs.Reset;
                            TempHistLinhasMovs.DeleteAll;
                            l_HistLinhaMov.Reset;
                            l_HistLinhaMov.SetRange("Cód. Processamento", "Hist. Linhas Movs. Empregado"."Cód. Processamento");
                            l_HistLinhaMov.SetRange("Employee No.", "Hist. Linhas Movs. Empregado"."Employee No.");
                            //IT009 - JTP - 2020.08.05
                            l_HistLinhaMov.SetFilter(Valor, '<>0');
                            if l_HistLinhaMov.FindSet then begin
                                repeat
                                    l_RubricaFalta.Reset;
                                    l_RubricaFalta.SetRange(Código, l_HistLinhaMov."Payroll Item Code");
                                    l_RubricaFalta.SetFilter(Genero, '%1|%2', l_RubricaFalta.Genero::"Admissão-Demissão", l_RubricaFalta.Genero::Falta);
                                    if not l_RubricaFalta.FindFirst then begin
                                        TempHistLinhasMovs.Init;
                                        TempHistLinhasMovs.TransferFields(l_HistLinhaMov);
                                        TempHistLinhasMovs.Insert;
                                    end;

                                    if (l_Rubrica.Get(l_HistLinhaMov."Payroll Item Code")) and
                                       ((l_Rubrica.Faults = true) or
                                        //        (l_Rubrica.Genero= l_Rubrica.Genero::"Vencimento Base"))
                                        ((l_Rubrica.Genero = l_Rubrica.Genero::"Vencimento Base") and (l_Rubrica.Periodicidade = l_Rubrica.Periodicidade::Mensal)))
                                        then begin
                                        l_RubricaFalta.Reset;
                                        l_RubricaFalta.SetFilter(Genero, '%1|%2', l_RubricaFalta.Genero::"Admissão-Demissão", l_RubricaFalta.Genero::Falta);
                                        if l_RubricaFalta.FindSet then begin
                                            repeat
                                                l_HistLinhaMov2.Reset;
                                                l_HistLinhaMov2.SetRange("Cód. Processamento", "Hist. Linhas Movs. Empregado"."Cód. Processamento");
                                                l_HistLinhaMov2.SetRange("Employee No.", "Hist. Linhas Movs. Empregado"."Employee No.");
                                                l_HistLinhaMov2.SetRange("Payroll Item Code", l_RubricaFalta.Código);
                                                if l_HistLinhaMov2.FindSet then begin
                                                    repeat
                                                        TempHistLinhasMovs.Init;
                                                        TempHistLinhasMovs.TransferFields(l_HistLinhaMov2);
                                                        TempHistLinhasMovs.NATREM := l_HistLinhaMov.NATREM;
                                                        contalinha := contalinha + 1;
                                                        TempHistLinhasMovs."No. Linha" := TempHistLinhasMovs."No. Linha" + contalinha;
                                                        TempHistLinhasMovs."Valor Incidência SS" := (l_HistLinhaMov.Valor / 30 * Abs(l_HistLinhaMov2.Quantity)) * -1;
                                                        TempHistLinhasMovs.Insert;
                                                    until l_HistLinhaMov2.Next = 0;
                                                end;
                                            until l_RubricaFalta.Next = 0;
                                        end;
                                    end;
                                until l_HistLinhaMov.Next = 0;
                            end;



                            TabRubrica.SetRange(TabRubrica.Código, "Hist. Linhas Movs. Empregado"."Payroll Item Code");
                            if TabRubrica.FindFirst then begin
                                TabControlar.Init;
                                //IT007 - JTP - 2020.06.08 - Begin
                                if TabRubrica.NATREM = TabRubrica.NATREM::"Férias Pagas não Gozadas" then begin
                                    Clear(MonthMovsAux);
                                    Clear(YearMovsAux);
                                    if "Hist. Linhas Movs. Empregado"."Data a que se refere o mov" <> 0D then begin
                                        MonthMovsAux := Date2DMY("Hist. Linhas Movs. Empregado"."Data a que se refere o mov", 2);
                                        YearMovsAux := Date2DMY("Hist. Linhas Movs. Empregado"."Data a que se refere o mov", 3);
                                    end
                                    else begin
                                        MonthMovsAux := Date2DMY("Hist. Linhas Movs. Empregado"."Data Registo", 2);
                                        YearMovsAux := Date2DMY("Hist. Linhas Movs. Empregado"."Data Registo", 3);
                                    end;
                                    TabControlar."No." := CopyStr(Format(YearMovsAux), 3) + Format(MonthMovsAux) +
                                                          CopyStr(Format("Hist. Linhas Movs. Empregado".NATREM), 1, 16);
                                end
                                else
                                    //IT007 - JTP - 2020.06.08 - End
                                    TabControlar."No." := CopyStr(Format("Hist. Linhas Movs. Empregado".NATREM), 1, 20);
                                if TabControlar.Insert then begin
                                    Clear(ValorALancar);
                                    TempHistLinhasMovs.CopyFilters("Hist. Linhas Movs. Empregado");
                                    if TempHistLinhasMovs.FindSet then begin
                                        repeat
                                            //IT007 - JTP - 2020.06.08 - Begin
                                            if TabRubrica.NATREM = TabRubrica.NATREM::"Férias Pagas não Gozadas" then begin
                                                if (TempHistLinhasMovs.NATREM = "Hist. Linhas Movs. Empregado".NATREM) and
                                                    (TempHistLinhasMovs."Data a que se refere o mov" =
                                                    "Hist. Linhas Movs. Empregado"."Data a que se refere o mov") then begin
                                                    if TempHistLinhasMovs."Valor Incidência SS" <> 0 then
                                                        ValorALancar := ValorALancar + Round(TempHistLinhasMovs."Valor Incidência SS", 0.01)
                                                    else
                                                        ValorALancar := ValorALancar + Round(TempHistLinhasMovs.Valor, 0.01);
                                                end;
                                            end
                                            else
                                                //IT007 - JTP - 2020.06.08 - End
                                                if TempHistLinhasMovs.NATREM = "Hist. Linhas Movs. Empregado".NATREM then begin
                                                    if TempHistLinhasMovs."Valor Incidência SS" <> 0 then
                                                        ValorALancar := ValorALancar + Round(TempHistLinhasMovs."Valor Incidência SS", 0.01)
                                                    else
                                                        ValorALancar := ValorALancar + Round(TempHistLinhasMovs.Valor, 0.01);
                                                end;
                                        until TempHistLinhasMovs.Next = 0;
                                    end;
                                    //>>>>>> LINHA R1 - Identificação da Entidade Empregadora >>>>>>>>>>>>>>>>>>>>>>>>>>
                                    if Contador = 0 then begin
                                        TabTempFichTexto.Init;
                                        TabTempFichTexto."Tipo Ficheiro" := 0;
                                        TabTempFichTexto.NLinha := TabTempFichTexto.NLinha + 1;
                                        TabTempFichTexto.Data := WorkDate;
                                        TabTempFichTexto.Texto1 := 'R1'
                                        + TabInfEmpresa."Social Security No."
                                        + "Estabelecimentos da Empresa"."Instituição Seg. Social"
                                        + TabInfEmpresa."VAT Registration No."
                                        //+ Converter.Ascii2Ansi(PADSTR(UPPERCASE(COPYSTR(TabInfEmpresa.Name,1,66)),66,' '))
                                        + PadStr(UpperCase(CopyStr(TabInfEmpresa.Name, 1, 66)), 66, ' ')
                                        + Format("Periodos Processamento"."Data Registo", 0, '<Year4><Month,2>')
                                        + PadStr(' ', 20, ' ');
                                        TabTempFichTexto.Insert;
                                        Contador := 1
                                    end;

                                    case "Hist. Linhas Movs. Empregado".NATREM of
                                        "Hist. Linhas Movs. Empregado".NATREM::"Ajudas Custo e Trans.":
                                            begin
                                                strNATREM := ' A';
                                                RemuneracoesTrabalhador(strNATREM, ValorALancar);
                                            end;

                                        "Hist. Linhas Movs. Empregado".NATREM::"Prémios-Bonus Mensal":
                                            begin
                                                strNATREM := ' B';
                                                RemuneracoesTrabalhador(strNATREM, ValorALancar);
                                            end;

                                        "Hist. Linhas Movs. Empregado".NATREM::"Cód. Comissões":
                                            begin
                                                strNATREM := ' C';
                                                RemuneracoesTrabalhador(strNATREM, ValorALancar);
                                            end;

                                        "Hist. Linhas Movs. Empregado".NATREM::"Compensação":
                                            begin
                                                strNATREM := ' D';
                                                RemuneracoesTrabalhador(strNATREM, ValorALancar);
                                            end;

                                        "Hist. Linhas Movs. Empregado".NATREM::"Cód. Sub. Férias":
                                            begin
                                                strNATREM := ' F';
                                                RemuneracoesTrabalhador(strNATREM, ValorALancar);
                                            end;

                                        "Hist. Linhas Movs. Empregado".NATREM::"Honorários":
                                            begin
                                                strNATREM := ' H';
                                                RemuneracoesTrabalhador(strNATREM, ValorALancar);
                                            end;

                                        "Hist. Linhas Movs. Empregado".NATREM::"Subsídios regulares":
                                            begin
                                                strNATREM := ' M';
                                                RemuneracoesTrabalhador(strNATREM, ValorALancar);
                                            end;

                                        "Hist. Linhas Movs. Empregado".NATREM::"Cód. Sub. Natal":
                                            begin
                                                strNATREM := ' N';
                                                RemuneracoesTrabalhador(strNATREM, ValorALancar);
                                            end;

                                        "Hist. Linhas Movs. Empregado".NATREM::"Prémios-bonus Não mensal":
                                            begin
                                                strNATREM := ' O';
                                                RemuneracoesTrabalhador(strNATREM, ValorALancar);
                                            end;

                                        "Hist. Linhas Movs. Empregado".NATREM::"Remuneração Permanente":
                                            begin
                                                strNATREM := ' P';
                                                RemuneracoesTrabalhador(strNATREM, ValorALancar);
                                            end;

                                        "Hist. Linhas Movs. Empregado".NATREM::"Sub. Ref.":
                                            begin
                                                strNATREM := ' R';
                                                RemuneracoesTrabalhador(strNATREM, ValorALancar);
                                            end;

                                        "Hist. Linhas Movs. Empregado".NATREM::"Trab. Supl.":
                                            begin
                                                strNATREM := ' S';
                                                RemuneracoesTrabalhador(strNATREM, ValorALancar);
                                            end;

                                        "Hist. Linhas Movs. Empregado".NATREM::"Trab. Noct.":
                                            begin
                                                strNATREM := ' T';
                                                RemuneracoesTrabalhador(strNATREM, ValorALancar);
                                            end;

                                        "Hist. Linhas Movs. Empregado".NATREM::"Subsídios Reg. Não Mensal":
                                            begin
                                                strNATREM := ' X';
                                                RemuneracoesTrabalhador(strNATREM, ValorALancar);
                                            end;

                                        "Hist. Linhas Movs. Empregado".NATREM::"Férias Pagas não Gozadas":
                                            begin
                                                strNATREM := ' 2';
                                                RemuneracoesTrabalhador(strNATREM, ValorALancar);
                                            end;

                                        "Hist. Linhas Movs. Empregado".NATREM::"Diferenças de Vencimento":
                                            begin
                                                strNATREM := ' 6';
                                                RemuneracoesTrabalhador(strNATREM, ValorALancar);
                                            end;

                                        "Hist. Linhas Movs. Empregado".NATREM::"Compensação Cont. Intermitente":
                                            begin
                                                strNATREM := ' I';
                                                RemuneracoesTrabalhador(strNATREM, ValorALancar);
                                            end;
                                    end;
                                end;
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
                            end else begin
                                "Hist. Linhas Movs. Empregado".SetFilter("Cód. Processamento", FiltroCodProc);
                            end;
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
                        if Empregado.Estabelecimento <> "Estabelecimentos da Empresa"."Número da Unidade Local" then
                            CurrReport.Skip;

                        //2011.03.28 - os empregados cujo o vencimento é zero (ex: estão de baixa o mes todo) não devem ir para o ficheiro
                        FlagValor := false;
                        TabHistCabMovEmp.Reset;

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

                                TabHistCabMovEmp.SetRange("Data Registo", _DataInicioProcMin, _DataFimProcMax)
                            end;
                        end else begin
                            TabHistCabMovEmp.SetRange(TabHistCabMovEmp."Cód. Processamento", FiltroCodProc);
                        end;


                        TabHistCabMovEmp.SetFilter(TabHistCabMovEmp."Tipo Processamento", '%1|%2|%3',
                        TabHistCabMovEmp."Tipo Processamento"::Vencimentos, TabHistCabMovEmp."Tipo Processamento"::SubNatal,
                        TabHistCabMovEmp."Tipo Processamento"::SubFerias);
                        TabHistCabMovEmp.SetRange(TabHistCabMovEmp."Employee No.", Empregado."No.");
                        if TabHistCabMovEmp.FindSet then begin
                            repeat
                                TabHistCabMovEmp.CalcFields(TabHistCabMovEmp.Valor);
                                if TabHistCabMovEmp.Valor <> 0 then
                                    FlagValor := true;
                            until TabHistCabMovEmp.Next = 0;
                        end;

                        //2012.03.01 - Mesmo que o valor a receber (TabHistCabMovEmp.Valor) seja 0 temos de ir ver se as faltas dizem
                        //respeito unicamente a esse mês. Pois se parte delas disser respeito a meses anteriores a aplicação deverá continuar
                        //a incluir este empregado
                        if not FlagValor then begin
                            TabHistMovsAux.Reset;
                            TabHistMovsAux.SetRange(TabHistMovsAux."Data Registo", "Periodos Processamento"."Data Inicio Processamento",
                            "Periodos Processamento"."Data Fim Processamento");
                            TabHistMovsAux.SetRange(TabHistMovsAux."Employee No.", Empregado."No.");
                            TabHistMovsAux.SetRange(TabHistMovsAux.NATREM, 4);//P
                            TabHistMovsAux.SetFilter(TabHistMovsAux.Valor, '<0');//Faltas
                            if TabHistMovsAux.FindSet then begin
                                repeat
                                    if TabHistMovsAux."Data a que se refere o mov" < "Periodos Processamento"."Data Inicio Processamento" then
                                        FlagValor := true;
                                until TabHistMovsAux.Next = 0;
                            end;
                        end;
                        //2012.03.01 - fim

                        if not FlagValor then
                            CurrReport.Skip;

                        Clear(AuxValorFaltas);
                        Clear(AuxDiasFaltas);
                        Clear(AuxDiasNTrabalhados);//HG 30.04.07
                        TempTabHistAboDesExtra.Reset;//13.03.2008
                        TempTabHistAboDesExtra.DeleteAll;//13.03.2008

                        //04.05.2007 - o total das contribuições deve de ir buscar ao historico
                        TabRubricaSal2.Reset;
                        TabRubricaSal2.SetFilter(TabRubricaSal2.Genero, '%1|%2', TabRubricaSal2.Genero::SS, TabRubricaSal2.Genero::"Enc. SS");
                        if TabRubricaSal2.FindSet then begin
                            repeat
                                TabHistLinhasMovs.Reset;
                                TabHistLinhasMovs.SetRange(TabHistLinhasMovs."Employee No.", Empregado."No.");
                                TabHistLinhasMovs.SetRange(TabHistLinhasMovs."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                                TabHistLinhasMovs.SetRange(TabHistLinhasMovs."Payroll Item Code", TabRubricaSal2.Código);
                                if TabHistLinhasMovs.FindSet then
                                    repeat
                                        TotalContribuicoes2 := TotalContribuicoes2 + Abs(TabHistLinhasMovs.Valor);
                                    until TabHistLinhasMovs.Next = 0;
                            until TabRubricaSal2.Next = 0;
                        end;
                        //04.05.2007 - fim
                    end;

                    trigger OnPostDataItem()
                    begin
                        //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                        //>>>>>>>>>>>>>> LINHA R3 - Registo de Totais >>>>>>>>>>>>>>>>>>>>>>>>>>>
                        //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                        if TotalRegistos <> 0 then begin
                            TotalRemuneracaoes := Round(TotalRemuneracaoes, 0.01, '=');
                            Taxa := "Regime Seg. Social"."Taxa Contributiva Empregado" +
                                    "Regime Seg. Social"."Taxa Contributiva Ent Patronal";

                            TabTempFichTexto.Init;
                            TabTempFichTexto."Tipo Ficheiro" := 0;
                            TabTempFichTexto.NLinha := TabTempFichTexto.NLinha + 1;
                            TabTempFichTexto.Data := WorkDate;
                            TabTempFichTexto.Texto1 := 'R3'
                            + TabInfEmpresa."Social Security No."
                            + "Estabelecimentos da Empresa"."Instituição Seg. Social"
                            + PadStr('9', 11, '9')
                            + DelChr(ConvertStr(Format(TotalRemuneracaoes, 15, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')
                            + '0'

                            //04.05.2007 - o total das contribuições deve de ir buscar ao historico
                            + DelChr(ConvertStr(Format(Round(TotalRemuneracaoes * Taxa / 100, 0.01, '='), 13, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')
                            //+ DELCHR(CONVERTSTR(FORMAT(ROUND(TotalContribuicoes2,0.01,'='),13,'<Sign><Integer><Decimals,3>'),' ','0'),'=',',')
                            //04.05.2007 - fim

                            + '0'
                            + DelChr(ConvertStr(Format(Taxa, 5, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')
                            + ConvertStr(Format(TotalRegistos, 6, '<Sign><Integer>'), ' ', '0')
                            + PadStr(' ', 52, ' ');
                            TabTempFichTexto.Insert;
                        end;
                        //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                    end;

                    trigger OnPreDataItem()
                    begin
                        Contador := 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    Clear(TotalRemuneracaoes);
                    Clear(TotalRegistos);
                    Clear(TotalContribuicoes2);//04.05.2007 - o total das contribuições deve de ir buscar ao historico
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Ficheiro Seg. Social")
                {
                    Caption = 'Ficheiro Seg. Social';
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

    trigger OnPostReport()
    var
        ExportFicheiroTexto: XMLport "Export Ficheiro Texto";
    begin
        //Correr o Dataport para exportar da Tabela Temp Ficheiro Texto para o Ficheiro
        //-------------------------------------------------------------------------------
        Commit;
        TabTempFichTexto.Reset;
        TabTempFichTexto.SetRange(TabTempFichTexto."Tipo Ficheiro", TabTempFichTexto."Tipo Ficheiro"::MapaSS);
        if TabTempFichTexto.FindFirst then
            XMLPORT.Run(XMLPORT::"Export Ficheiro Texto", true, false, TabTempFichTexto);
    end;

    trigger OnPreReport()
    begin
        TabInfEmpresa.Get;
        FiltroDataInicProc := '';
        FiltroDataFimProc := '';
        FiltroCodProc := '';

        //Limpar a tabela temporária para o tipo de ficheiro MapaSS
        //---------------------------------------------------------

        TabTempFichTexto.SetRange(TabTempFichTexto."Tipo Ficheiro", TabTempFichTexto."Tipo Ficheiro"::MapaSS);
        if TabTempFichTexto.Find('-') then
            TabTempFichTexto.DeleteAll;

        //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        //>>>>>>  LINHA R0 - Identificação do Ficheiro >>>>>>>>>>>>>>>>>>>>>>>>>>
        //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        TabTempFichTexto.Init;
        TabTempFichTexto."Tipo Ficheiro" := 0;
        TabTempFichTexto.NLinha := 1;
        TabTempFichTexto.Texto1 := 'R0' + 'RC4008' + '  ' + '01' + PadStr(' ', 106, ' ');
        TabTempFichTexto.Insert;
        //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    end;

    var
        Converter: Codeunit "Funções RH";
        TabInfEmpresa: Record "Company Information";
        TabTempFichTexto: Record "Tabela Temp Ficheiros Texto";
        TabHistLinhasMovs: Record "Hist. Linhas Movs. Empregado";
        TabRubrica: Record "Payroll Item";
        TabControlar: Record Customer temporary;
        TabHistMovsAux: Record "Hist. Linhas Movs. Empregado";
        DiasTrabalho: Text[3];
        TotalRemuneracaoes: Decimal;
        TotalContribuicoes: Decimal;
        TotalRegistos: Integer;
        Taxa: Decimal;
        Text0001: Label 'O processamento tem de estar Fechado.';
        ValorALancar: Decimal;
        CodEmpregado: Code[20];
        Contador: Integer;
        strNATREM: Text[2];
        AuxValorFaltas: Decimal;
        AuxDiasFaltas: Decimal;
        AuxDiasFaltas2: Text[30];
        TabRubrica2: Record "Payroll Item";
        TabHorario: Record "Horário RH";
        Text0002: Label 'O Empregado %1 não tem horário definido.';
        TabConfRH: Record "Config. Recursos Humanos";
        TabUnidadeMedidaRH: Record "Unid. Medida Recursos Humanos";
        FlagFalta: Boolean;
        AuxDiasNTrabalhados: Integer;
        TabHistLinhaEmpregado: Record "Hist. Linhas Movs. Empregado";
        TotalContribuicoes2: Decimal;
        TabRubricaSal2: Record "Payroll Item";
        CodRubrica: Code[20];
        DataFalta: Date;
        CodProcessamento: Code[20];
        FiltroDataInicProc: Text[1024];
        FiltroDataFimProc: Text[1024];
        FiltroCodProc: Text[1024];
        Text0003: Label 'Os filtros data de processamento e código de processamento são exclusivos. Não pode selecionar ambos.';
        Text0004: Label 'Tem que preencher a data de início e fim de processamento.';
        Text0008: Label 'Preencha o Cod. Processamento para tirar o Mapa para um só processamento.\ Ou preencha a Data de Inicio e de Fim, para tirar o Mapa para vários processamentos.';
        TemHistMov: Record "Hist. Linhas Movs. Empregado" temporary;
        Encontrou: Boolean;
        TabHistAboDesExtra: Record "Histórico Abonos - Desc. Extra";
        TempTabHistAboDesExtra: Record "Histórico Abonos - Desc. Extra" temporary;
        AuxDiasFaltas3: Text[30];
        TabRubSal: Record "Payroll Item";
        TabHistCabMovEmp: Record "Hist. Cab. Movs. Empregado";
        FlagValor: Boolean;
        SinalDiasTrabalho: Text[1];
        SinalValor: Text[1];
        AuxDiasFaltaMes: Decimal;
        CodProcess: Code[10];
        DataInicio: Date;
        DataFim: Date;
        boolAdmission: Boolean;
        TempHistLinhasMovs: Record "Hist. Linhas Movs. Empregado" temporary;
        contalinha: Integer;
        MonthMovsAux: Integer;
        YearMovsAux: Integer;


    procedure RemuneracoesTrabalhador(strNatrem: Text[2]; Valorlancar: Decimal)
    var
        Datareferencia: Text[30];
        LHistMovEmp: Record "Hist. Linhas Movs. Empregado";
        LValorLancar: Decimal;
        LHistAbonDescExtra: Record "Histórico Abonos - Desc. Extra";
        LDataMov: Date;
        LRubricaSal: Record "Payroll Item";
        TempHistMovEmp: Record "Hist. Linhas Movs. Empregado" temporary;
        LRubricaSalAux: Record "Payroll Item";
    begin
        //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        //>>>>>> LINHA R2 - Remunerações do Trabalhador >>>>>>>>>>>>>>>>>>>>>>>>>>
        //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        Clear(DataFalta);
        Clear(CodRubrica);
        Clear(AuxDiasNTrabalhados);//2011.08.10
        Clear(AuxDiasFaltaMes);//2012.02.24

        // IF (ROUND(Valorlancar,1) = 0) OR //2007.03.20 coloquei em comentário pq se o valor é zero é porque houve falta o mês todo
        if (strNatrem = ' F') or   //p/ o Sub Férias, Natal, Comissões e Outros Subsidios o nº dias tem de ser zero
            (strNatrem = ' N') or
            (strNatrem = ' C') or
            (strNatrem = ' X') or
            (strNatrem = ' 6') or
            //24.02.2011
            (strNatrem = ' A') or
            (strNatrem = ' B') or
            (strNatrem = ' D') or
            (strNatrem = ' H') or
            (strNatrem = ' M') or
            (strNatrem = ' O') or
            (strNatrem = ' R') or
            (strNatrem = ' S') or
            (strNatrem = ' T') then
            DiasTrabalho := '000'
        else begin
            //Abater as faltas não remuneradas
            if (strNatrem = ' P') then begin
                FlagFalta := false; //HG 30.04.07

                //2008.01.11 - Antigamente se para um empregado eram registadas duas linhas de faltas para o mesmo mês, quando se fazia
                //o processamento dos vencimentos a aplicação juntava as duas linhas numa só e enviava para o histórico uma só linha.
                //Como a partir de agora as faltas podem ser registadas em dias ou horas em que o valor unitário é diferente, o
                //processamento já não pode juntar as linhas, mas no ficheiro da segurança social têm de estar juntas se forem do mesmo mês.
                //Então este código o que faz é pegar no histórico e tudo o que forem linhas de faltas juntá - las numa só (caso sejam do
                //mesmo mês) e enviar esses registos para uma tabela temporaria. A partir dai usa a tabela temporária para fazer os
                //calculos que já fazia.

                TabHistMovsAux.Reset;
                TabHistMovsAux.SetCurrentKey("Tipo Processamento", "Cód. Processamento", "Employee No.", "No. Linha", "Data a que se refere o mov");
                TabHistMovsAux.SetRange(TabHistMovsAux."Data Registo", "Periodos Processamento"."Data Inicio Processamento",
                  "Periodos Processamento"."Data Fim Processamento");
                TabHistMovsAux.SetRange(TabHistMovsAux."Employee No.", Empregado."No.");
                TabHistMovsAux.SetRange(TabHistMovsAux.NATREM, 4);//P
                TabHistMovsAux.SetFilter(TabHistMovsAux.Valor, '<0');//Faltas
                if TabHistMovsAux.FindSet then begin
                    repeat
                        if (TabRubSal.Get(TabHistMovsAux."Payroll Item Code")) then begin
                            TemHistMov.Reset;
                            TemHistMov.SetRange(TemHistMov."Cód. Processamento", TabHistMovsAux."Cód. Processamento");
                            TemHistMov.SetRange(TemHistMov."Tipo Processamento", TabHistMovsAux."Tipo Processamento");
                            TemHistMov.SetRange(TemHistMov."Employee No.", TabHistMovsAux."Employee No.");
                            if TemHistMov.Find('-') then begin
                                Encontrou := false;
                                repeat
                                    if (TabRubrica2.Get(TabHistMovsAux."Payroll Item Code") and (TabRubrica2.Genero = TabRubrica2.Genero::Falta)) then begin
                                        if (Date2DMY(TemHistMov."Data a que se refere o mov", 2) = Date2DMY(TabHistMovsAux."Data a que se refere o mov", 2)) then begin
                                            TemHistMov.Quantity := TemHistMov.Quantity + TabHistMovsAux.Quantity;
                                            TemHistMov.Valor := TemHistMov.Valor + TabHistMovsAux.Valor;
                                            TemHistMov.Modify;
                                            Encontrou := true;
                                        end;
                                    end;
                                until TemHistMov.Next = 0;
                                if Encontrou = false then begin
                                    TemHistMov.Init;
                                    TemHistMov.TransferFields(TabHistMovsAux);
                                    TemHistMov.Insert;
                                end;
                            end else begin
                                TemHistMov.Init;
                                TemHistMov.TransferFields(TabHistMovsAux);
                                TemHistMov.Insert;
                            end;
                        end;
                    until TabHistMovsAux.Next = 0;
                end;
                //HG 2008.01.11

                TemHistMov.Reset;
                TemHistMov.SetCurrentKey("Tipo Processamento", "Cód. Processamento", "Employee No.", "No. Linha", "Data a que se refere o mov");
                TemHistMov.SetRange(TemHistMov."Data Registo", "Periodos Processamento"."Data Inicio Processamento",
                  "Periodos Processamento"."Data Fim Processamento");
                TemHistMov.SetRange(TemHistMov."Employee No.", Empregado."No.");
                TemHistMov.SetRange(TemHistMov.NATREM, 4);//P
                TemHistMov.SetFilter(TemHistMov.Valor, '<0');//Faltas
                                                             //2012.02.24 - filtro para não apanhar as faltas do proprio mes
                                                             //até agora sempre que um empregado tinha faltas a aplicação criava 2 linhas, uma com o valor total do vencimento e 30 dias
                                                             //e outra a negativo com o valor da falta e os dias da falta
                                                             //No entanto disseram na segurança social que as faltas devem ser subtraidas à linha P do vencimento
                                                             //desta forma estou a fazer este filtro para não apanhar as faltas do proprio mes e subtrai-las ao vencimento
                                                             //se a falta for do mes anterior então apanho e coloco numa linha à parte, isto porque pode acontecer exceder os 30 dias
                TemHistMov.SetFilter(TemHistMov."Data a que se refere o mov", '<%1|%2', "Periodos Processamento"."Data Inicio Processamento", 0D);
                if TemHistMov.Find('-') then begin
                    Clear(boolAdmission); //IT006,n
                    repeat
                        //2008.03.12 - estava a apanhar as admissões a negativo e n pode
                        if (TabRubSal.Get(TemHistMov."Payroll Item Code")) and (TabRubSal.Genero <> TabRubSal.Genero::"Admissão-Demissão") then begin
                            if (DataFalta <> TemHistMov."Data a que se refere o mov") then begin
                                AuxValorFaltas := 0;
                                AuxDiasFaltas := 0;
                            end;
                            if (TabRubrica2.Get(TemHistMov."Payroll Item Code")) then begin
                                if (TabRubrica2.Genero = TabRubrica2.Genero::Falta) then begin //HG 30.04.07
                                    AuxValorFaltas := AuxValorFaltas + Round(TemHistMov.Valor, 0.01);
                                    AuxDiasFaltas := AuxDiasFaltas + Abs(TemHistMov.Quantity);
                                    FlagFalta := true; //30.04.07
                                    if (CodRubrica <> TemHistMov."Payroll Item Code") or (DataFalta <> 0D) and
                                      (DataFalta <> TemHistMov."Data a que se refere o mov") then begin

                                        TabTempFichTexto.Init;
                                        TabTempFichTexto."Tipo Ficheiro" := 0;
                                        TabTempFichTexto.NLinha := TabTempFichTexto.NLinha + 1;
                                        TabTempFichTexto.Data := WorkDate;
                                        TabTempFichTexto.Texto1 := 'R2'
                                         + TabInfEmpresa."Social Security No."                                                  //Nº Seg. Social da empresa
                                      + "Estabelecimentos da Empresa"."Instituição Seg. Social"        //Estabelecimento do Empregado
                                      + PadStr(Empregado."No. Segurança Social", 11, ' ')                //Nº Seg. Social do Empregado
                                         + PadStr(UpperCase(CopyStr(Empregado.Name, 1, 60)), 60, ' ')      //Nome do empregado
                                         + Format(Empregado."Birth Date", 0, '<Year4><Month,2><Day,2>')                        //Data Nascimento
                                         + Format(TemHistMov."Data a que se refere o mov", 0, '<Year4><Month,2>');      //Mes e ano das remuner
                                        if StrPos(Format(AuxDiasFaltas), ',') = 0 then
                                            AuxDiasFaltas2 := Format(AuxDiasFaltas) + '0'
                                        else
                                            AuxDiasFaltas2 := DelChr(Format(Round(Abs(AuxDiasFaltas), 0.1, '=')), '=', ',');

                                        if StrLen(AuxDiasFaltas2) = 1 then
                                            TabTempFichTexto.Texto1 := TabTempFichTexto.Texto1 + '0' + AuxDiasFaltas2 + '0';        //Dias de trabalho
                                        if StrLen(AuxDiasFaltas2) = 2 then
                                            TabTempFichTexto.Texto1 := TabTempFichTexto.Texto1 + '0' + AuxDiasFaltas2;              //Dias de trabalho
                                        if StrLen(AuxDiasFaltas2) = 3 then
                                            TabTempFichTexto.Texto1 := TabTempFichTexto.Texto1 + AuxDiasFaltas2;                    //Dias de trabalho

                                        TabTempFichTexto.Texto1 := TabTempFichTexto.Texto1
                                         + '-'
                                         + strNatrem                                                                               //NATREM
                                         + DelChr(ConvertStr(Format(Round(Abs(AuxValorFaltas), 0.01), 10, '<Sign><Integer><Decimals,3>'),
                                          ' ', '0'), '=', ',')             //Valor
                                         + '-';                                                                                    //Sinal do valor
                                        TabTempFichTexto.Insert;

                                        TotalRemuneracaoes := TotalRemuneracaoes - Round(Abs(AuxValorFaltas), 0.01);//20150904 - acrescentei round
                                        TotalRegistos := TotalRegistos + 1;
                                        //Somar ao Vencimento base o valor das faltas que a aplicação já tinha de descontado
                                        Valorlancar := Valorlancar + Abs(AuxValorFaltas);
                                    end;
                                end;

                                CodRubrica := TemHistMov."Payroll Item Code";
                                DataFalta := TemHistMov."Data a que se refere o mov";
                            end;
                        end else begin //2008.01.09 - este codigo passou para aqui porque tem o if lá em cima e nunca entrava
                                       //HG 30.04.07 - Quando um empregado entra ou sai a meio do mês, há necessidade de registar uma ausência com os dias
                                       //não trabalhados. Contudo esse registo não pode ser feito com rubricas de faltas porque não é correcto.
                                       //Como esses dias não trabalhados têm de ser subtraidos aos 30 dias do VB, criou - se um criou-se uma novo género
                                       //de rubrica salarial Admissão - Demissão do tipo desconto. Assim sendo sempre que um empregado sai ou entra é
                                       //inserido nos abonos e descontos extra esta rubrica salarial com a quantidade = aos dias não trabalhados
                                       //Esses dias são abatidos aos 30 dias da linha do VB no Ficheiro Seg. Social
                            if (TabRubSal.Genero = TabRubSal.Genero::"Admissão-Demissão") then //HG 30.04.07
                                                                                               //IT006,sn Erro de conversão de variável integer Vs decimal. Empregado com data de admissão do corrente Mês trabalhou um dia incompleto.
                                if StrPos(Format(TemHistMov.Quantity), ',') <> 0 then begin
                                    AuxDiasNTrabalhados := AuxDiasNTrabalhados + Round(Abs(TemHistMov.Quantity * 10), 1);
                                    boolAdmission := true;
                                end else
                                    //IT006,en
                                    AuxDiasNTrabalhados := AuxDiasNTrabalhados + Abs(TemHistMov.Quantity);
                            //HG 30.04.07

                        end;
                    until TemHistMov.Next = 0;
                end;
                //2012.02.24 - abater os dias não trabalhados deste mês
                AuxDiasFaltaMes := 0;
                TemHistMov.Reset;
                TemHistMov.SetCurrentKey("Tipo Processamento", "Cód. Processamento", "Employee No.", "No. Linha", "Data a que se refere o mov");
                TemHistMov.SetRange(TemHistMov."Data Registo", "Periodos Processamento"."Data Inicio Processamento",
                  "Periodos Processamento"."Data Fim Processamento");
                TemHistMov.SetRange(TemHistMov."Employee No.", Empregado."No.");
                TemHistMov.SetRange(TemHistMov.NATREM, 4);//P
                TemHistMov.SetFilter(TemHistMov.Valor, '<0');//Faltas
                TemHistMov.SetFilter(TemHistMov."Data a que se refere o mov", '>=%1', "Periodos Processamento"."Data Inicio Processamento");
                if TemHistMov.FindSet then begin
                    repeat
                        AuxDiasFaltaMes := AuxDiasFaltaMes + Abs(TemHistMov.Quantity);
                    until TemHistMov.Next = 0;
                    if StrPos(Format(AuxDiasFaltaMes), ',') = 0 then  //é um valor inteiro
                        AuxDiasNTrabalhados := AuxDiasNTrabalhados + AuxDiasFaltaMes;
                end;
                //2012.02.24 - fim

            end; //TERMINA AQUI A PARTE DE ABATER AS FALTAS

            //2012.02.24 - para o caso de faltar meio dia
            if StrPos(Format(AuxDiasFaltaMes), ',') <> 0 then //é um numero décimal
                AuxDiasNTrabalhados := AuxDiasNTrabalhados + Round(AuxDiasFaltaMes * 10, 1)
            else
                if not boolAdmission then
                    AuxDiasNTrabalhados := AuxDiasNTrabalhados * 10;

            DiasTrabalho := Format(Empregado."No. Dias Trabalho Mensal" * 10 - AuxDiasNTrabalhados);//trab temp parcial
                                                                                                    //reportou que no fecho de contas as linhas de Natrem 2 não vem com o numero de dias certos
            if strNatrem = ' 2' then begin
                if StrPos(Format("Hist. Linhas Movs. Empregado".Quantity), ',') <> 0 then //é um numero décimal 2015.04.21
                    DiasTrabalho := DelChr(Format(Round(Abs("Hist. Linhas Movs. Empregado".Quantity), 0.1, '=')), '=', ',')
                else
                    DiasTrabalho := DelChr(Format(Round(Abs("Hist. Linhas Movs. Empregado".Quantity * 10), 0.1, '=')), '=', ',');
            end;
            // ******************************* Repor Faltas**********************************************
            //05.03.2008 - É necessário o ficheiro da segurança Social contemplar a faltas que foram repostas ou seja, que em meses
            //anteriores tinham sido descontadas e que no presente mês voltaram a ser pagas. Estas reposição é feita nos abonos e descontos
            //Extra com o codigo da rúbrica vencimento base, em que na coluna "Anular Falta SS" é colocado um pisco e é colocada a data
            //da falta;
            //NO ficheiro só pode colocar uma linha por cada mês

            TabHistAboDesExtra.Reset;
            TabHistAboDesExtra.SetCurrentKey(TabHistAboDesExtra."Employee No.", TabHistAboDesExtra."Reference Date");
            TabHistAboDesExtra.SetRange(TabHistAboDesExtra."Employee No.", Empregado."No.");
            TabHistAboDesExtra.SetRange(TabHistAboDesExtra.Data, "Periodos Processamento"."Data Inicio Processamento",
              "Periodos Processamento"."Data Fim Processamento");
            TabHistAboDesExtra.SetRange(TabHistAboDesExtra."Anular Falta", true);
            if TabHistAboDesExtra.FindFirst then begin
                TempTabHistAboDesExtra.Reset;
                TempTabHistAboDesExtra.DeleteAll;
                repeat
                    TempTabHistAboDesExtra.Reset;
                    if TempTabHistAboDesExtra.Find('-') then begin
                        Encontrou := false;
                        repeat
                            if (Date2DMY(TempTabHistAboDesExtra."Reference Date", 2) =
                              Date2DMY(TabHistAboDesExtra."Reference Date", 2))
                            and (Date2DMY(TempTabHistAboDesExtra."Reference Date", 3) =
                            Date2DMY(TabHistAboDesExtra."Reference Date", 3)) then begin
                                Encontrou := true;
                                TempTabHistAboDesExtra.Quantity := TempTabHistAboDesExtra.Quantity + TabHistAboDesExtra.Quantity;
                                TempTabHistAboDesExtra."Total Amount" := TempTabHistAboDesExtra."Total Amount" + TabHistAboDesExtra."Total Amount";
                                TempTabHistAboDesExtra.Modify;
                            end;
                        until (TempTabHistAboDesExtra.Next = 0) or (Encontrou = true);
                    end;
                    if Encontrou = false then begin
                        TempTabHistAboDesExtra.Init;
                        TempTabHistAboDesExtra.TransferFields(TabHistAboDesExtra);
                        TempTabHistAboDesExtra.Insert;
                    end;
                until TabHistAboDesExtra.Next = 0;
            end;

            TempTabHistAboDesExtra.Reset;
            if TempTabHistAboDesExtra.FindSet then begin
                repeat
                    TabTempFichTexto.Init;
                    TabTempFichTexto."Tipo Ficheiro" := 0;
                    TabTempFichTexto.NLinha := TabTempFichTexto.NLinha + 1;
                    TabTempFichTexto.Data := WorkDate;
                    TabTempFichTexto.Texto1 := 'R2'
                     + TabInfEmpresa."Social Security No."                                                          //Nº Seg. Social da empresa
                     + "Estabelecimentos da Empresa"."Instituição Seg. Social"                                //Estabelecimento do Empregado
                     + PadStr(Empregado."No. Segurança Social", 11, ' ')                                          //Nº Seg. Social do Empregado
                                                                                                                  //+ Converter.Ascii2Ansi(PADSTR(UPPERCASE(COPYSTR(Empregado.Name,1,60)),60,' '))            //Nome do empregado
                     + PadStr(UpperCase(CopyStr(Empregado.Name, 1, 60)), 60, ' ')                                     //Nome do empregado
                     + Format(Empregado."Birth Date", 0, '<Year4><Month,2><Day,2>')                              //Data Nascimento
                     + Format(TempTabHistAboDesExtra."Reference Date", 0, '<Year4><Month,2>');    //Data Mov
                                                                                                  //2007.03.20 acrescentei este if porque ele limpa as casas decimais (ex: qtd = 26,00 aparece 26)
                    if StrPos(Format(TempTabHistAboDesExtra.Quantity), ',') = 0 then
                        AuxDiasFaltas3 := Format(TempTabHistAboDesExtra.Quantity) + '0'
                    else
                        AuxDiasFaltas3 := DelChr(Format(Round(Abs(TempTabHistAboDesExtra.Quantity), 0.1, '=')), '=', ',');

                    if StrLen(AuxDiasFaltas3) = 1 then
                        TabTempFichTexto.Texto1 := TabTempFichTexto.Texto1 + '0' + AuxDiasFaltas3 + '0';        //Dias de trabalho
                    if StrLen(AuxDiasFaltas3) = 2 then
                        TabTempFichTexto.Texto1 := TabTempFichTexto.Texto1 + '0' + AuxDiasFaltas3;              //Dias de trabalho
                    if StrLen(AuxDiasFaltas3) = 3 then
                        TabTempFichTexto.Texto1 := TabTempFichTexto.Texto1 + AuxDiasFaltas3;                    //Dias de trabalho

                    TabTempFichTexto.Texto1 := TabTempFichTexto.Texto1
                     + '0'
                     + strNatrem                                                                               //NATREM
                     + DelChr(ConvertStr(Format(Round(TempTabHistAboDesExtra."Total Amount",
                      0.01), 10, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')  //Valor
                     + '0';                                                                                    //Sinal do valor
                    TabTempFichTexto.Insert;

                    TotalRemuneracaoes := TotalRemuneracaoes + Round(TempTabHistAboDesExtra."Total Amount", 0.01);//20150904 - acrescentei round
                    TotalRegistos := TotalRegistos + 1;
                    Valorlancar := Valorlancar - TempTabHistAboDesExtra."Total Amount"; //para abater este valor à linha P do vencimento base

                until TempTabHistAboDesExtra.Next = 0;
            end;
        end;

        ////////////////////////////////////Parte 2//////////////////////////////
        //-----------------------------------------------------------------------
        //2016.10.21 - Alterações ao processamento por causa dos Acertos de Duodécimos
        case strNatrem of
            ' F':
                begin
                    ////////////////////////////////////Parte 2.1 - Sub. Férias ////////////////////////////
                    Encontrou := false;
                    LHistMovEmp.Reset;
                    LHistMovEmp.SetCurrentKey(LHistMovEmp."Employee No.", LHistMovEmp."Data a que se refere o mov");
                    LHistMovEmp.SetRange(LHistMovEmp."Data Registo", "Periodos Processamento"."Data Inicio Processamento",
                      "Periodos Processamento"."Data Fim Processamento");
                    LHistMovEmp.SetRange(LHistMovEmp."Employee No.", Empregado."No.");
                    LHistMovEmp.SetFilter(LHistMovEmp.NATREM, '%1', LHistMovEmp.NATREM::"Cód. Sub. Férias");
                    //IT007 - JTP - 2020.06.08 - Begin
                    LRubricaSalAux.Get("Hist. Linhas Movs. Empregado"."Payroll Item Code");
                    if LRubricaSalAux.NATREM = LRubricaSalAux.NATREM::"Férias Pagas não Gozadas" then
                        LHistMovEmp.SetRange("Data a que se refere o mov", "Hist. Linhas Movs. Empregado"."Data a que se refere o mov");
                    //IT007 - JTP - 2020.06.08 - End
                    if LHistMovEmp.FindSet then begin
                        TempHistMovEmp.Reset;
                        TempHistMovEmp.DeleteAll;
                        repeat
                            TempHistMovEmp.Reset;
                            if TempHistMovEmp.Find('-') then begin
                                Encontrou := false;
                                repeat
                                    if (Date2DMY(TempHistMovEmp."Data a que se refere o mov", 2) = Date2DMY(LHistMovEmp."Data a que se refere o mov", 2)) and
                                       (Date2DMY(TempHistMovEmp."Data a que se refere o mov", 3) = Date2DMY(LHistMovEmp."Data a que se refere o mov", 3)) then begin
                                        Encontrou := true;
                                        TempHistMovEmp.Quantity := TempHistMovEmp.Quantity + LHistMovEmp.Quantity;
                                        //2017.03.01 - Correcções por causa dos Acertos a negativo de Sub Natal e Férias
                                        //Se a rubrica for um desconto já vem a negativo, logo não se poe sinal
                                        //IF LHistMovEmp."Payroll Item Type" = LHistMovEmp."Payroll Item Type"::Abono THEN
                                        //  TempHistMovEmp.Valor := TempHistMovEmp.Valor + LHistMovEmp.Valor;
                                        //IF LHistMovEmp."Payroll Item Type" = LHistMovEmp."Payroll Item Type"::Desconto THEN
                                        //  TempHistMovEmp.Valor := TempHistMovEmp.Valor - LHistMovEmp.Valor;
                                        TempHistMovEmp.Valor := TempHistMovEmp.Valor + LHistMovEmp.Valor;
                                        //2017.03.01 - en
                                        TempHistMovEmp.Modify;
                                    end;
                                until (TempHistMovEmp.Next = 0) or (Encontrou = true);
                            end;
                            if Encontrou = false then begin
                                TempHistMovEmp.Init;
                                TempHistMovEmp.TransferFields(LHistMovEmp);
                                //2017.03.01 - Correcções por causa dos Acertos a negativo de Sub Natal e Férias
                                //Se a rubrica for um desconto já vem a negativo, logo não se poe sinal
                                //IF LHistMovEmp."Payroll Item Type" = LHistMovEmp."Payroll Item Type"::Abono THEN
                                //  TempHistMovEmp.Valor := LHistMovEmp.Valor;
                                //IF LHistMovEmp."Payroll Item Type" = LHistMovEmp."Payroll Item Type"::Desconto THEN
                                //  TempHistMovEmp.Valor := - LHistMovEmp.Valor;
                                TempHistMovEmp.Valor := LHistMovEmp.Valor;
                                //2017.03.01 - en
                                TempHistMovEmp.Insert;
                            end;

                        until LHistMovEmp.Next = 0;

                        TempHistMovEmp.Reset;
                        if TempHistMovEmp.FindSet then begin
                            repeat
                                SinalDiasTrabalho := '0';
                                SinalValor := '0';
                                if TempHistMovEmp.Valor < 0 then begin
                                    SinalDiasTrabalho := '-';
                                    SinalValor := '-';
                                end;

                                //IT008 - JTP - 2020.07.02 - Begin
                                LDataMov := TempHistMovEmp."Data a que se refere o mov";
                                if LDataMov = 0D then
                                    LDataMov := TempHistMovEmp."Data Registo";
                                //IT008 - JTP - 2020.07.02 - End
                                TabTempFichTexto.Init;
                                TabTempFichTexto."Tipo Ficheiro" := 0;
                                TabTempFichTexto.NLinha := TabTempFichTexto.NLinha + 1;
                                TabTempFichTexto.Data := WorkDate;
                                TabTempFichTexto.Texto1 := 'R2'
                                 + TabInfEmpresa."Social Security No."                                                          //Nº Seg. Social da empresa
                                 + "Estabelecimentos da Empresa"."Instituição Seg. Social"                                //Estabelecimento do Empregado
                                 + PadStr(Empregado."No. Segurança Social", 11, ' ')                                   //Nº Seg. Social do Empregado
                                 + PadStr(UpperCase(CopyStr(Empregado.Name, 1, 60)), 60, ' ')                                    //Nome do empregado
                                 + Format(Empregado."Birth Date", 0, '<Year4><Month,2><Day,2>')         //Data Nascimento
                                                                                                        //IT008 - JTP - 2020.07.02 - Begin
                                                                                                        //+ FORMAT(TempHistMovEmp."Data a que se refere o mov",0,'<Year4><Month,2>');    //Data Mov
                                 + Format(LDataMov, 0, '<Year4><Month,2>');    //Data Mov
                                                                               //IT008 - JTP - 2020.07.02 - End
                                                                               //2007.03.20 acrescentei este if porque ele limpa as casas decimais (ex: qtd = 26,00 aparece 26)
                                TabTempFichTexto.Texto1 := TabTempFichTexto.Texto1 + '000';                                //Dias de trabalho
                                TabTempFichTexto.Texto1 := TabTempFichTexto.Texto1
                                 + SinalDiasTrabalho
                                 + strNatrem                                                                               //NATREM
                                 + DelChr(ConvertStr(Format(Round(Abs(TempHistMovEmp.Valor),
                                  0.01), 10, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')  //Valor
                                 + SinalValor;                                                                                    //Sinal do valor
                                TabTempFichTexto.Insert;
                                TotalRemuneracaoes := TotalRemuneracaoes + Round(TempHistMovEmp.Valor, 0.01);//20150904 - acrescentei round
                                TotalRegistos := TotalRegistos + 1;
                            until TempHistMovEmp.Next = 0;
                        end;
                    end;
                end;
            ' N':
                begin
                    ////////////////////////////////////Parte 2.2 - Sub. Natal ////////////////////////////
                    Encontrou := false;
                    LHistMovEmp.Reset;
                    LHistMovEmp.SetCurrentKey(LHistMovEmp."Employee No.", LHistMovEmp."Data a que se refere o mov");
                    LHistMovEmp.SetRange(LHistMovEmp."Data Registo", "Periodos Processamento"."Data Inicio Processamento",
                      "Periodos Processamento"."Data Fim Processamento");
                    LHistMovEmp.SetRange(LHistMovEmp."Employee No.", Empregado."No.");
                    LHistMovEmp.SetFilter(LHistMovEmp.NATREM, '%1', LHistMovEmp.NATREM::"Cód. Sub. Natal");
                    if LHistMovEmp.FindSet then begin
                        TempHistMovEmp.Reset;
                        TempHistMovEmp.DeleteAll;
                        repeat
                            TempHistMovEmp.Reset;
                            if TempHistMovEmp.Find('-') then begin
                                Encontrou := false;
                                repeat
                                    if (Date2DMY(TempHistMovEmp."Data a que se refere o mov", 2) = Date2DMY(LHistMovEmp."Data a que se refere o mov", 2)) and
                                       (Date2DMY(TempHistMovEmp."Data a que se refere o mov", 3) = Date2DMY(LHistMovEmp."Data a que se refere o mov", 3)) then begin
                                        Encontrou := true;
                                        TempHistMovEmp.Quantity := TempHistMovEmp.Quantity + LHistMovEmp.Quantity;
                                        //2017.03.01 - Correcções por causa dos Acertos a negativo de Sub Natal e Férias
                                        //Se a rubrica for um desconto já vem a negativo, logo não se poe sinal
                                        //IF LHistMovEmp."Payroll Item Type" = LHistMovEmp."Payroll Item Type"::Abono THEN
                                        //  TempHistMovEmp.Valor := TempHistMovEmp.Valor + LHistMovEmp.Valor;
                                        //IF LHistMovEmp."Payroll Item Type" = LHistMovEmp."Payroll Item Type"::Desconto THEN
                                        //  TempHistMovEmp.Valor := TempHistMovEmp.Valor - LHistMovEmp.Valor;
                                        TempHistMovEmp.Valor := TempHistMovEmp.Valor + LHistMovEmp.Valor;
                                        //2017.03.01 - en
                                        TempHistMovEmp.Modify;
                                    end;
                                until (TempHistMovEmp.Next = 0) or (Encontrou = true);
                            end;
                            if not Encontrou then begin
                                TempHistMovEmp.Init;
                                TempHistMovEmp.TransferFields(LHistMovEmp);
                                //2017.03.01 - Correcções por causa dos Acertos a negativo de Sub Natal e Férias
                                //Se a rubrica for um desconto já vem a negativo, logo não se poe sinal
                                //IF LHistMovEmp."Payroll Item Type" = LHistMovEmp."Payroll Item Type"::Abono THEN
                                //  TempHistMovEmp.Valor := LHistMovEmp.Valor;
                                //IF LHistMovEmp."Payroll Item Type" = LHistMovEmp."Payroll Item Type"::Desconto THEN
                                //  TempHistMovEmp.Valor := - LHistMovEmp.Valor;
                                TempHistMovEmp.Valor := LHistMovEmp.Valor;
                                //2017.03.01 - en
                                TempHistMovEmp.Insert;
                            end;
                        until LHistMovEmp.Next = 0;

                        TempHistMovEmp.Reset;
                        if TempHistMovEmp.FindSet then begin
                            repeat
                                SinalDiasTrabalho := '0';
                                SinalValor := '0';
                                if TempHistMovEmp.Valor < 0 then begin
                                    SinalDiasTrabalho := '-';
                                    SinalValor := '-';
                                end;

                                //IT010 - JTP - 2021.04.09 - Begin
                                LDataMov := TempHistMovEmp."Data a que se refere o mov";
                                if LDataMov = 0D then
                                    LDataMov := TempHistMovEmp."Data Registo";
                                //IT010 - JTP - 2021.04.09 - End
                                TabTempFichTexto.Init;
                                TabTempFichTexto."Tipo Ficheiro" := 0;
                                TabTempFichTexto.NLinha := TabTempFichTexto.NLinha + 1;
                                TabTempFichTexto.Data := WorkDate;
                                TabTempFichTexto.Texto1 := 'R2'
                                 + TabInfEmpresa."Social Security No."                                                          //Nº Seg. Social da empresa
                                 + "Estabelecimentos da Empresa"."Instituição Seg. Social"                                //Estabelecimento do Empregado
                                 + PadStr(Empregado."No. Segurança Social", 11, ' ')                                   //Nº Seg. Social do Empregado
                                                                                                                       //+ Converter.Ascii2Ansi(PADSTR(UPPERCASE(COPYSTR(Empregado.Name,1,60)),60,' '))            //Nome do empregado
                                 + PadStr(UpperCase(CopyStr(Empregado.Name, 1, 60)), 60, ' ')                                    //Nome do empregado
                                 + Format(Empregado."Birth Date", 0, '<Year4><Month,2><Day,2>')                              //Data Nascimento
                                                                                                                             //IT010 - JTP - 2021.04.09 - Begin
                                                                                                                             //+ FORMAT(TempHistMovEmp."Data a que se refere o mov",0,'<Year4><Month,2>');    //Data Mov
                                 + Format(LDataMov, 0, '<Year4><Month,2>');    //Data Mov
                                                                               //IT010 - JTP - 2021.04.09 - End
                                                                               //HG 2007.03.20 acrescentei este if porque ele limpa as casas decimais (ex: qtd = 26,00 aparece 26)
                                TabTempFichTexto.Texto1 := TabTempFichTexto.Texto1 + '000';                                //Dias de trabalho
                                TabTempFichTexto.Texto1 := TabTempFichTexto.Texto1
                                 + SinalDiasTrabalho
                                 + strNatrem                                                                               //NATREM
                                 + DelChr(ConvertStr(Format(Round(Abs(TempHistMovEmp.Valor),
                                  0.01), 10, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')  //Valor
                                 + SinalValor;                                                                                    //Sinal do valor
                                TabTempFichTexto.Insert;
                                TotalRemuneracaoes := TotalRemuneracaoes + Round(TempHistMovEmp.Valor, 0.01);//20150904 - acrescentei round
                                TotalRegistos := TotalRegistos + 1;
                            until TempHistMovEmp.Next = 0;
                        end;
                    end;
                end;

            ' 6':
                begin
                    ////////////////////////////////////Parte 2.3 - Diferenças Vencimento //////////////////////////////
                    //14.11.2008 - as rubricas cujo natrem = 6 (diferenças de vencimento) seja desconto ou abono tem de vir com a
                    //data referente ao mes a que se refere o acerto (campo data a que se refere o mov. da tabela abonos e descontos extra)
                    Encontrou := false;
                    LHistMovEmp.Reset;
                    LHistMovEmp.SetRange(LHistMovEmp."Data Registo", "Periodos Processamento"."Data Inicio Processamento",
                      "Periodos Processamento"."Data Fim Processamento");
                    LHistMovEmp.SetRange(LHistMovEmp."Employee No.", Empregado."No.");
                    LHistMovEmp.SetFilter(LHistMovEmp.NATREM, '%1', LHistMovEmp.NATREM::"Diferenças de Vencimento");//corresponde a 6
                    if LHistMovEmp.FindSet then begin
                        repeat
                            LHistAbonDescExtra.Reset;
                            LHistAbonDescExtra.SetCurrentKey(LHistAbonDescExtra."Employee No.", LHistAbonDescExtra."Reference Date");
                            LHistAbonDescExtra.SetRange(LHistAbonDescExtra."Employee No.", Empregado."No.");
                            LHistAbonDescExtra.SetRange(LHistAbonDescExtra.Data, "Periodos Processamento"."Data Inicio Processamento",
                              "Periodos Processamento"."Data Fim Processamento");
                            LHistAbonDescExtra.SetRange(LHistAbonDescExtra."Payroll Item Code", LHistMovEmp."Payroll Item Code");
                            if LHistAbonDescExtra.FindSet then begin
                                TempTabHistAboDesExtra.Reset;
                                TempTabHistAboDesExtra.DeleteAll;
                                repeat
                                    TempTabHistAboDesExtra.Reset;
                                    if TempTabHistAboDesExtra.FindSet then begin
                                        Encontrou := false;
                                        repeat
                                            if (Date2DMY(TempTabHistAboDesExtra."Reference Date", 2) =
                                                Date2DMY(LHistAbonDescExtra."Reference Date", 2))
                                                and (Date2DMY(TempTabHistAboDesExtra."Reference Date", 3) =
                                                Date2DMY(LHistAbonDescExtra."Reference Date", 3)) then begin
                                                Encontrou := true;
                                                TempTabHistAboDesExtra.Quantity := TempTabHistAboDesExtra.Quantity + LHistAbonDescExtra.Quantity;

                                                if LHistAbonDescExtra."Payroll Item Type" = LHistAbonDescExtra."Payroll Item Type"::Abono then
                                                    TempTabHistAboDesExtra."Total Amount" := TempTabHistAboDesExtra."Total Amount" + LHistAbonDescExtra."Total Amount";

                                                if LHistAbonDescExtra."Payroll Item Type" = LHistAbonDescExtra."Payroll Item Type"::Desconto then
                                                    TempTabHistAboDesExtra."Total Amount" := TempTabHistAboDesExtra."Total Amount" - LHistAbonDescExtra."Total Amount";
                                                TempTabHistAboDesExtra.Modify;
                                            end;
                                        until (TempTabHistAboDesExtra.Next = 0) or (Encontrou = true);
                                    end;
                                    if Encontrou = false then begin
                                        TempTabHistAboDesExtra.Init;
                                        TempTabHistAboDesExtra.TransferFields(LHistAbonDescExtra);

                                        if LHistAbonDescExtra."Payroll Item Type" = LHistAbonDescExtra."Payroll Item Type"::Abono then
                                            TempTabHistAboDesExtra."Total Amount" := LHistAbonDescExtra."Total Amount";

                                        if LHistAbonDescExtra."Payroll Item Type" = LHistAbonDescExtra."Payroll Item Type"::Desconto then
                                            TempTabHistAboDesExtra."Total Amount" := -LHistAbonDescExtra."Total Amount";

                                        TempTabHistAboDesExtra.Insert;
                                    end;
                                until LHistAbonDescExtra.Next = 0;
                            end;

                            TempTabHistAboDesExtra.Reset;
                            if TempTabHistAboDesExtra.FindSet then begin
                                repeat
                                    SinalDiasTrabalho := '0';
                                    SinalValor := '0';
                                    //14.11.2008 - as rubricas cujo natrem = 6 (diferenças de vencimento) e que que seja desconto
                                    // (se for abono não) tem de vir:
                                    //sinal dias trabalho ( - )
                                    //valor positivo
                                    //sinal do valor ( + )
                                    if TempTabHistAboDesExtra."Total Amount" < 0 then begin
                                        SinalDiasTrabalho := '-';
                                        SinalValor := '-';
                                    end;

                                    TabTempFichTexto.Init;
                                    TabTempFichTexto."Tipo Ficheiro" := 0;
                                    TabTempFichTexto.NLinha := TabTempFichTexto.NLinha + 1;
                                    TabTempFichTexto.Data := WorkDate;
                                    TabTempFichTexto.Texto1 := 'R2'
                                     + TabInfEmpresa."Social Security No."                                                          //Nº Seg. Social da empresa
                                     + "Estabelecimentos da Empresa"."Instituição Seg. Social"                                //Estabelecimento do Empregado
                                     + PadStr(Empregado."No. Segurança Social", 11, ' ')                                   //Nº Seg. Social do Empregado
                                                                                                                           //+ Converter.Ascii2Ansi(PADSTR(UPPERCASE(COPYSTR(Empregado.Name,1,60)),60,' '))            //Nome do empregado
                                     + PadStr(UpperCase(CopyStr(Empregado.Name, 1, 60)), 60, ' ')                                    //Nome do empregado
                                     + Format(Empregado."Birth Date", 0, '<Year4><Month,2><Day,2>')                              //Data Nascimento
                                     + Format(TempTabHistAboDesExtra."Reference Date", 0, '<Year4><Month,2>');    //Data Mov
                                                                                                                  //HG 2007.03.20 acrescentei este if porque ele limpa as casas decimais (ex: qtd = 26,00 aparece 26)
                                    TabTempFichTexto.Texto1 := TabTempFichTexto.Texto1 + '000';                                //Dias de trabalho
                                    TabTempFichTexto.Texto1 := TabTempFichTexto.Texto1
                                     + SinalDiasTrabalho
                                     + strNatrem                                                                               //NATREM
                                     + DelChr(ConvertStr(Format(Round(Abs(TempTabHistAboDesExtra."Total Amount"),
                                      0.01), 10, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')  //Valor
                                     + SinalValor;                                                                                    //Sinal do valor
                                    TabTempFichTexto.Insert;
                                    TotalRemuneracaoes := TotalRemuneracaoes + Round(TempTabHistAboDesExtra."Total Amount", 0.01);//20150904 - acrescentei round
                                    TotalRegistos := TotalRegistos + 1;
                                until TempTabHistAboDesExtra.Next = 0;
                            end;
                        until LHistMovEmp.Next = 0;
                    end;
                end;
            else begin
                ////////////////////////////////////Parte 2.4 - Restantes Casos //////////////////////////////
                SinalDiasTrabalho := '0';
                SinalValor := '0';
                //IT007 - JTP - 2020.06.08 - Begin
                if "Hist. Linhas Movs. Empregado"."Data a que se refere o mov" <> 0D then
                    Datareferencia := Format("Hist. Linhas Movs. Empregado"."Data a que se refere o mov", 0, '<Year4><Month,2>')
                else
                    //IT007 - JTP - 2020.06.08 - End
                    Datareferencia := Format("Periodos Processamento"."Data Registo", 0, '<Year4><Month,2>');
                LValorLancar := Valorlancar;

                //24.02.2011 - Como agora se pode ter valores a negativo o sinal (-) tem de passar para a direita do valor
                if LValorLancar < 0 then begin
                    SinalValor := '-';
                    LValorLancar := Abs(LValorLancar);
                    SinalDiasTrabalho := '-';
                end;
                //24.02.2011 - fim

                if StrLen(DiasTrabalho) = 1 then
                    DiasTrabalho := '00' + DiasTrabalho;
                if StrLen(DiasTrabalho) = 2 then
                    DiasTrabalho := '0' + DiasTrabalho;
                if LValorLancar <> 0 then begin //2012.12.11 Normatica - Coloquei o if para não enviar linhas a 0
                    TabTempFichTexto.Init;
                    TabTempFichTexto."Tipo Ficheiro" := 0;
                    TabTempFichTexto.NLinha := TabTempFichTexto.NLinha + 1;
                    TabTempFichTexto.Data := WorkDate;
                    TabTempFichTexto.Texto1 := 'R2'
                     + TabInfEmpresa."Social Security No."                                                          //Nº Seg. Social da empresa
                     + "Estabelecimentos da Empresa"."Instituição Seg. Social"                                //Estabelecimento do Empregado
                     + PadStr(Empregado."No. Segurança Social", 11, ' ')                                          //Nº Seg. Social do Empregado
                                                                                                                  //+ Converter.Ascii2Ansi(PADSTR(UPPERCASE(COPYSTR(Empregado.Name,1,60)),60,' '))            //Nome do empregado
                     + PadStr(UpperCase(CopyStr(Empregado.Name, 1, 60)), 60, ' ')                                    //Nome do empregado
                     + Format(Empregado."Birth Date", 0, '<Year4><Month,2><Day,2>')                              //Data Nascimento
                     + Datareferencia                                                                    //Mes e ano a que se referem as remuner
                     + DiasTrabalho                                                                        //Dias de trabalho
                     + SinalDiasTrabalho                                                                                 //sinal dias trabalho
                     + strNatrem                                                                               //NATREM
                     + DelChr(ConvertStr(Format(Round(LValorLancar, 0.01), 10, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')  //Valor
                     + SinalValor;                                                                                    //Sinal do valor
                    TabTempFichTexto.Insert;

                    TotalRemuneracaoes := TotalRemuneracaoes + Round(Valorlancar, 0.01); //20150904 - acrescentei round
                    TotalRegistos := TotalRegistos + 1;
                end;
            end;
        end;
    end;
}

