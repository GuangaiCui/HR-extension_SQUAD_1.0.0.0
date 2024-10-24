report 53088 "Mapa Dec. Mensal Remu. AT"
{
    // //-------------------------------------------------------
    //     Ficheiro Declaração Mensal Remunerações AT
    // //--------------------------------------------------------
    //   É um ficheiro que deve ser entregue mensalmente às finanças,
    //   pela empresa, com os rendimentos e rentenções de cada empregado
    // 
    //   Este mapa deve sair em formato txt e como tal numa primeira fase
    //   exporta os dados para uma tabela criada para este tipo de mapas
    //   (Tabela Temp Ficheiro Texto) e depois corre um dataport (Temp Ficheiro Texto)
    //   para criar o ficheiro txt
    // 
    //   Tipos de Registo:
    //     001 - Header do Ficheiro
    //     002 - Header da Declaração
    //     003 - Header da DMR-AT
    //     004 - Detalhe da DMR-AT 1
    //     005 - Detalhe da DMR-AT 2
    // 
    //     006 - Detalhe da DMR-AT 3
    // 
    //     009 - Trailer DMR-AT
    //     099 - Trailer da Declaração
    //     999 - Trailer do Ficheiro
    // //-------------------------------------------------------
    // 
    //  //Normatica 2014.11.25 - versão 2 do ficheiro
    //  //Normatica 2015.04.08 - novos codigos A19,A24 e A25
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\MapaDecMensalRemuAT.rdl';

    Permissions = TableData "Tabela Temp Ficheiros Texto" = rimd;
    PreviewMode = PrintLayout;
    UseRequestPage = true;

    dataset
    {
        dataitem(Totais; "Hist. Linhas Movs. Empregado")
        {
            DataItemTableView = SORTING("Employee No.", "Tipo Rendimento Cat.A") WHERE("Tipo Rendimento" = CONST(A), "Tipo Processamento" = FILTER(<> Encargos));
            RequestFilterFields = "Employee No.";
            column(TotCount; TotCount)
            {
            }
            column(TotVal; TotVal)
            {
            }
            column(ABS_ROUND_TotalRendSujeitosValor_0_01__; Abs(Round(TotalRendSujeitosValor, 0.01)))
            {
            }
            column(ABS_ROUND_TotalRendSujeitosRetencoes_0_01__; Abs(Round(TotalRendSujeitosRetencoes, 0.01)))
            {
            }
            column(ABS_ROUND_TotalRendSujeitosContrib_0_01__; Abs(Round(TotalRendSujeitosContrib, 0.01)))
            {
            }
            column(ABS_ROUND_TotalRendSujeitosSindic_0_01__; Abs(Round(TotalRendSujeitosSindic, 0.01)))
            {
            }
            column(ABS_ROUND_TotalRendSujeitosSobretaxa_0_01__; Abs(Round(TotalRendSujeitosSobretaxa, 0.01)))
            {
            }
            column(V0_0; 0.0)
            {
            }
            column(ABS_ROUND_TotalRendNSujeitosSindic_0_01__; Abs(Round(TotalRendNSujeitosSindic, 0.01)))
            {
            }
            column(ABS_ROUND_TotalRendNSujeitosSobretaxa_0_01__; Abs(Round(TotalRendNSujeitosSobretaxa, 0.01)))
            {
            }
            column(ABS_ROUND_TotalRendNSujeitosContrib_0_01__; Abs(Round(TotalRendNSujeitosContrib, 0.01)))
            {
            }
            column(ABS_ROUND_TotalRendNSujeitosRetencoes_0_01__; Abs(Round(TotalRendNSujeitosRetencoes, 0.01)))
            {
            }
            column(ABS_ROUND_TotalRendNSujeitosValor_0_01__; Abs(Round(TotalRendNSujeitosValor, 0.01)))
            {
            }
            column(ABS_ROUND_TotalRendSujeitosSindic_TotalRendNSujeitosSindic_0_01__; Abs(Round(TotalRendSujeitosSindic + TotalRendNSujeitosSindic, 0.01)))
            {
            }
            column(ABS_ROUND_TotalRendSujeitosSobretaxa_TotalRendNSujeitosSobretaxa_0_01__; Abs(Round(TotalRendSujeitosSobretaxa + TotalRendNSujeitosSobretaxa, 0.01)))
            {
            }
            column(ABS_ROUND_TotalRendSujeitosContrib_TotalRendNSujeitosContrib_0_01__; Abs(Round(TotalRendSujeitosContrib + TotalRendNSujeitosContrib, 0.01)))
            {
            }
            column(ABS_ROUND_TotalRendSujeitosRetencoes_TotalRendNSujeitosRetencoes_0_01__; Abs(Round(TotalRendSujeitosRetencoes + TotalRendNSujeitosRetencoes, 0.01)))
            {
            }
            column(ABS_ROUND_TotalRendSujeitosValor_TotalRendNSujeitosValor_0_01__; Abs(Round(TotalRendSujeitosValor + TotalRendNSujeitosValor, 0.01)))
            {
            }
            column(N__Contribuinte______InfEmpresa__VAT_Registration_No__; 'Nº Contribuinte: ' + InfEmpresa."VAT Registration No.")
            {
            }
            column(N__Telefone______InfEmpresa__Phone_No__; 'Nº Telefone: ' + InfEmpresa."Phone No.")
            {
            }
            column(InfEmpresa_City; InfEmpresa.City)
            {
            }
            column(InfEmpresa__Post_Code_; InfEmpresa."Post Code")
            {
            }
            column(InfEmpresa_Address; InfEmpresa.Address)
            {
            }
            column(InfEmpresa_Picture; InfEmpresa.Picture)
            {
            }
            column(USERID; UserId)
            {
            }
            column(InfEmpresa__Name_2_; InfEmpresa."Name 2")
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(InfEmpresa_Name; InfEmpresa.Name)
            {
            }
            column(DataIni; Format(DataIni, 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(DataFim; Format(DataFim, 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column("Declaração_Mensal_de_RemuneraçõesCaption"; Declaração_Mensal_de_RemuneraçõesCaptionLbl)
            {
            }
            column(Valor_RendimentosCaption; Valor_RendimentosCaptionLbl)
            {
            }
            column("Retenção_IRSCaption"; Retenção_IRSCaptionLbl)
            {
            }
            column("Contribuições_ObrigatóriasCaption"; Contribuições_ObrigatóriasCaptionLbl)
            {
            }
            column("Quotizações_SindicaisCaption"; Quotizações_SindicaisCaptionLbl)
            {
            }
            column("Retenção_SobretaxaCaption"; Retenção_SobretaxaCaptionLbl)
            {
            }
            column(Redimentos_SujeitosCaption; Redimentos_SujeitosCaptionLbl)
            {
            }
            column(Redimentos_IsentosCaption; Redimentos_IsentosCaptionLbl)
            {
            }
            column("Redimentos_Não_SujeitosCaption"; Redimentos_Não_SujeitosCaptionLbl)
            {
            }
            column(TotaisCaption; TotaisCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Periodo_de_Caption; Periodo_de_CaptionLbl)
            {
            }
            column(a_Caption; a_CaptionLbl)
            {
            }
            column("Totais_Cód__Processamento"; "Cód. Processamento")
            {
            }
            column(Totais_Tipo_Processamento; "Tipo Processamento")
            {
            }
            column(Totais_N__Empregado; "Employee No.")
            {
            }
            column(Totais_N__Linha; "No. Linha")
            {
            }
            column(Totais_Tipo_Rendimento_Cat_A; "Tipo Rendimento Cat.A")
            {
            }
            column(SobretaxaCaption; SobretaxaCaptionLbl)
            {
            }
            column(Valor_SindicatoCaption; Valor_SindicatoCaptionLbl)
            {
            }
            column(DescontoCaption; DescontoCaptionLbl)
            {
            }
            column("Importâncias_RetidasCaption"; Importâncias_RetidasCaptionLbl)
            {
            }
            column(Rendimentos_AnoCaption; Rendimentos_AnoCaptionLbl)
            {
            }
            column(NomeCaption; NomeCaptionLbl)
            {
            }
            column(N__ContribuinteCaption; N__ContribuinteCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                TotCount := TotCount + 1;
                //--------------------------------------------------------
                //Limpar Variáveis
                //--------------------------------------------------------
                if (Totais."Employee No." <> AuxEmp) or
                   (Totais."Tipo Rendimento Cat.A" <> AuxTipoRend) then begin
                    RendimentosAno := 0;
                    ImportanciasRetidas := 0;
                    Desconto := 0;
                    ValorSindicato := 0;
                    SobreTaxa := 0;
                end;

                AuxEmp := Totais."Employee No.";
                AuxTipoRend := Totais."Tipo Rendimento Cat.A";

                //-----------------------------------------------------------------
                //Calcular qual os rendimentos do ano - sobre os quais incide irs
                //-----------------------------------------------------------------
                if (Totais."Tipo Rendimento Cat.A" = 0) then begin
                    Flag := false;
                    TabRubrica.Reset;
                    TabRubrica.SetFilter(TabRubrica.Genero, '%1|%2|%3',
                                         TabRubrica.Genero::IRS,
                                         TabRubrica.Genero::"IRS Sub. Férias",
                                         TabRubrica.Genero::"IRS Sub. Natal");
                    TabRubrica.SetRange(TabRubrica."Sobretaxa em Sede de IRS", false);
                    TabRubrica.SetRange(TabRubrica."Imposto Extraordinário", false);
                    if TabRubrica.FindSet then begin
                        repeat
                            TabRubricaLinhas.Reset;
                            TabRubricaLinhas.SetRange(TabRubricaLinhas."Payroll Item Code", TabRubrica.Código);
                            if TabRubricaLinhas.Find('-') then begin
                                repeat
                                    if TabRubricaLinhas."Cód. Rubrica Filha" = Totais."Payroll Item Code" then begin
                                        if TabRubricaLinhas."Valor Limite Máximo" <> 0 then
                                            varLimite := Totais.Quantity * TabRubricaLinhas."Valor Limite Máximo"
                                        else
                                            varLimite := 0;
                                        RendimentosAno := RendimentosAno + Round(Totais.Valor, 0.01) - varLimite;
                                        TotalRendSujeitosValor := TotalRendSujeitosValor + Round(Totais.Valor, 0.01) - varLimite;
                                        Flag := true;
                                    end;
                                until (TabRubricaLinhas.Next = 0) or (Flag);
                            end;
                        until (TabRubrica.Next = 0) or (Flag = true);
                    end;
                end;
                if (Totais."Tipo Rendimento Cat.A" = Totais."Tipo Rendimento Cat.A"::A2) or
                   (Totais."Tipo Rendimento Cat.A" = Totais."Tipo Rendimento Cat.A"::A3) or
                   (Totais."Tipo Rendimento Cat.A" = Totais."Tipo Rendimento Cat.A"::A4) or
                   (Totais."Tipo Rendimento Cat.A" = Totais."Tipo Rendimento Cat.A"::A5) then begin

                    Flag := false;
                    TabRubrica.Reset;
                    TabRubrica.SetFilter(TabRubrica.Genero, '%1|%2|%3',
                                         TabRubrica.Genero::IRS,
                                         TabRubrica.Genero::"IRS Sub. Férias",
                                         TabRubrica.Genero::"IRS Sub. Natal");
                    TabRubrica.SetRange(TabRubrica."Sobretaxa em Sede de IRS", false);
                    TabRubrica.SetRange(TabRubrica."Imposto Extraordinário", false);
                    if TabRubrica.FindSet then begin
                        repeat
                            TabRubricaLinhas.Reset;
                            TabRubricaLinhas.SetRange(TabRubricaLinhas."Payroll Item Code", TabRubrica.Código);
                            if TabRubricaLinhas.FindSet then begin
                                repeat
                                    if TabRubricaLinhas."Cód. Rubrica Filha" = Totais."Payroll Item Code" then begin
                                        if TabRubricaLinhas."Valor Limite Máximo" <> 0 then
                                            varLimite := Totais.Quantity * TabRubricaLinhas."Valor Limite Máximo"
                                        else
                                            varLimite := 0;
                                        RendimentosAno := RendimentosAno + Round(Totais.Valor, 0.01) - varLimite;
                                        TotalRendSujeitosValor := TotalRendSujeitosValor + Round(Totais.Valor, 0.01) - varLimite;
                                        Flag := true;
                                    end;
                                until (TabRubricaLinhas.Next = 0) or (Flag);
                            end;
                        until (TabRubrica.Next = 0) or (Flag);
                    end;
                end;

                //-----------------------------------------------------------------
                //Rendimentos Não Sujeitos
                //-----------------------------------------------------------------
                if (Totais."Tipo Rendimento Cat.A" = Totais."Tipo Rendimento Cat.A"::A20) or
                   (Totais."Tipo Rendimento Cat.A" = Totais."Tipo Rendimento Cat.A"::A21) or
                   (Totais."Tipo Rendimento Cat.A" = Totais."Tipo Rendimento Cat.A"::A22) or
                   (Totais."Tipo Rendimento Cat.A" = Totais."Tipo Rendimento Cat.A"::A23) or
                   (Totais."Tipo Rendimento Cat.A" = Totais."Tipo Rendimento Cat.A"::A24) or
                   (Totais."Tipo Rendimento Cat.A" = Totais."Tipo Rendimento Cat.A"::A25) or
                   (Totais."Tipo Rendimento Cat.A" = Totais."Tipo Rendimento Cat.A"::A30) or
                   (Totais."Tipo Rendimento Cat.A" = Totais."Tipo Rendimento Cat.A"::A31) or
                   (Totais."Tipo Rendimento Cat.A" = Totais."Tipo Rendimento Cat.A"::A32) or
                   (Totais."Tipo Rendimento Cat.A" = Totais."Tipo Rendimento Cat.A"::A33) then begin

                    Flag := false;
                    TabRubrica.Reset;
                    TabRubrica.SetFilter(TabRubrica.Genero, '%1|%2|%3',
                                         TabRubrica.Genero::IRS,
                                         TabRubrica.Genero::"IRS Sub. Férias",
                                         TabRubrica.Genero::"IRS Sub. Natal");
                    TabRubrica.SetRange(TabRubrica."Sobretaxa em Sede de IRS", false);
                    TabRubrica.SetRange(TabRubrica."Imposto Extraordinário", false);
                    if TabRubrica.FindSet then begin
                        repeat
                            TabRubricaLinhas.Reset;
                            TabRubricaLinhas.SetRange(TabRubricaLinhas."Payroll Item Code", TabRubrica.Código);
                            if TabRubricaLinhas.FindSet then begin
                                repeat
                                    if TabRubricaLinhas."Cód. Rubrica Filha" = Totais."Payroll Item Code" then
                                        Flag := true;
                                until (TabRubricaLinhas.Next = 0) or (Flag = true);
                            end;
                        until (TabRubrica.Next = 0) or (Flag = true);

                    end;

                    if not Flag then begin
                        RendimentosAno := RendimentosAno + Round(Totais.Valor, 0.01);
                        TotalRendNSujeitosValor := TotalRendNSujeitosValor + Round(Totais.Valor, 0.01);
                    end;
                end;

                //-----------------------------------------------------------------
                //Calcular as importâncias retidas
                //-----------------------------------------------------------------

                TabRubrica.Reset;
                TabRubrica.SetFilter(TabRubrica.Genero, '%1|%2|%3',
                                     TabRubrica.Genero::IRS,
                                     TabRubrica.Genero::"IRS Sub. Férias",
                                     TabRubrica.Genero::"IRS Sub. Natal");
                TabRubrica.SetRange(TabRubrica."Imposto Extraordinário", false);
                TabRubrica.SetRange(TabRubrica."Sobretaxa em Sede de IRS", false);
                if TabRubrica.FindSet then begin
                    repeat
                        if TabRubrica.Código = Totais."Payroll Item Code" then begin
                            ImportanciasRetidas := ImportanciasRetidas + Totais.Valor;
                            TotalRendSujeitosRetencoes := TotalRendSujeitosRetencoes + Totais.Valor;
                        end;
                    until TabRubrica.Next = 0;
                end;

                //----------------------------------------------------------
                //Calcular os descontos obrigatorios para a cga e adse e SS
                //--------------------------------------------------------- -
                TabRubrica.Reset;
                TabRubrica.SetFilter(TabRubrica.Genero, '%1|%2|%3',
                                   TabRubrica.Genero::CGA,
                                   TabRubrica.Genero::ADSE, TabRubrica.Genero::SS);
                if TabRubrica.FindSet then begin
                    repeat
                        if TabRubrica.Código = Totais."Payroll Item Code" then begin
                            Desconto := Desconto + Totais.Valor;
                            TotalRendSujeitosContrib := TotalRendSujeitosContrib + Totais.Valor;
                        end;
                    until TabRubrica.Next = 0;

                end;

                //--------------------------------------------------
                //Calcula o descontos para sindicatos
                //--------------------------------------------------
                TabRubrica.Reset;
                TabRubrica.SetRange(TabRubrica.Genero,
                                   TabRubrica.Genero::Sindicato);
                if TabRubrica.FindSet then begin
                    repeat
                        if TabRubrica.Código = Totais."Payroll Item Code" then begin
                            ValorSindicato := ValorSindicato + Totais.Valor;
                            TotalRendSujeitosSindic := TotalRendSujeitosSindic + Totais.Valor;
                        end;
                    until TabRubrica.Next = 0;
                end;

                //------------------------------------------------------------------
                //Calcular a sobretaxa extraordinária
                //------------------------------------------------------------------
                TabRubrica.Reset;
                TabRubrica.SetRange(TabRubrica."Sobretaxa em Sede de IRS", true);
                if TabRubrica.Find('-') then begin
                    repeat
                        if TabRubrica.Código = Totais."Payroll Item Code" then begin
                            SobreTaxa := SobreTaxa + Round(Totais.Valor, 0.01);
                            TotalRendSujeitosSobretaxa := TotalRendSujeitosSobretaxa + Round(Totais.Valor, 0.01);
                        end;
                    until TabRubrica.Next = 0;
                end;
            end;

            trigger OnPostDataItem()
            begin
                //>>>>>>  LINHA 004 - Detalhe de DMR-AT 1 >>>>>>>>>>>>>>>>>>>>>>>>>>
                TabelaTempFichTexto.Init;
                TabelaTempFichTexto."File Type" := TabelaTempFichTexto."File Type"::"DMR-AT";
                TabelaTempFichTexto."Line No." := TabelaTempFichTexto."Line No." + 1;
                TabelaTempFichTexto.Texto1 := '004'
                + Converter(TotalRendSujeitosValor, 16, true)
                + Converter(TotalRendSujeitosRetencoes, 15, false)
                + Converter(TotalRendSujeitosContrib, 15, false)
                + Converter(TotalRendSujeitosSindic, 15, false)
                + Converter(TotalRendSujeitosSobretaxa, 15, false)
                + '+000000000000000'
                + '+00000000000000'
                + '+00000000000000'
                + '+00000000000000'
                + '+00000000000000'
                + PadStr(' ', 17, ' ');
                TabelaTempFichTexto.Insert;


                //>>>>>>  LINHA 005 - Detalhe de DMR-AT 2 >>>>>>>>>>>>>>>>>>>>>>>>>>
                TabelaTempFichTexto.Init;
                TabelaTempFichTexto."File Type" := TabelaTempFichTexto."File Type"::"DMR-AT";
                TabelaTempFichTexto."Line No." := TabelaTempFichTexto."Line No." + 1;
                TabelaTempFichTexto.Texto1 := '005'
                + Converter(TotalRendNSujeitosValor, 16, true)
                + Converter(TotalRendNSujeitosRetencoes, 15, false)
                + Converter(TotalRendNSujeitosContrib, 15, false)
                + Converter(TotalRendNSujeitosSindic, 15, false)
                + Converter(TotalRendNSujeitosSobretaxa, 15, false)
                + Converter(TotalRendSujeitosValor + TotalRendNSujeitosValor, 17, true)
                + Converter(TotalRendSujeitosRetencoes + TotalRendNSujeitosRetencoes, 16, false)
                + Converter(TotalRendSujeitosContrib + TotalRendNSujeitosContrib, 16, false)
                + Converter(TotalRendSujeitosSindic + TotalRendNSujeitosSindic, 16, false)
                + Converter(TotalRendSujeitosSobretaxa + TotalRendNSujeitosSobretaxa, 16, false)
                + PadStr(' ', 12, ' ');
                TabelaTempFichTexto.Insert;
            end;

            trigger OnPreDataItem()
            begin
                Totais.SetRange(Totais."Data Registo", DataIni, DataFim);

                TotalRendSujeitosValor := 0;
                TotalRendSujeitosRetencoes := 0;
                TotalRendSujeitosContrib := 0;
                TotalRendSujeitosSindic := 0;
                TotalRendSujeitosSobretaxa := 0;
                TotalRendNSujeitosValor := 0;
                TotalRendNSujeitosRetencoes := 0;
                TotalRendNSujeitosContrib := 0;
                TotalRendNSujeitosSindic := 0;
                TotalRendNSujeitosSobretaxa := 0;
                TotVal := Totais.Count;
                TotCount := 0;
            end;
        }
        dataitem("Hist. Linhas Movs. Empregado2"; "Hist. Linhas Movs. Empregado")
        {
            DataItemTableView = SORTING("Employee No.", "Tipo Rendimento Cat.A") WHERE("Tipo Rendimento" = CONST(A), "Tipo Processamento" = FILTER(<> Encargos));
            column(Empregado__No__Contribuinte_; Empregado."No. Contribuinte")
            {
            }
            column(ABS_ROUND_RendimentosAno_0_01__; Abs(Round(RendimentosAno, 0.01)))
            {
            }
            column(ABS_ROUND_ImportanciasRetidas_0_01__; Abs(Round(ImportanciasRetidas, 0.01)))
            {
            }
            column(ABS_ROUND_Desconto_0_01__; Abs(Round(Desconto, 0.01)))
            {
            }
            column(ABS_ROUND_ValorSindicato_0_01__; Abs(Round(ValorSindicato, 0.01)))
            {
            }
            column(ABS_SobreTaxa_; Abs(SobreTaxa))
            {
            }
            column(Empregado_Name; Empregado.Name)
            {
            }
            column(Hist__Linhas_Movs__Empregado2__Tipo_Rendimento_Cat_A_; TipoProc)
            {
            }
            column(Hist__Linhas_Movs__Empregado2__Tipo_Rendimento_Cat_A_Caption; FieldCaption("Tipo Rendimento Cat.A"))
            {
            }
            column("Hist__Linhas_Movs__Empregado2_Cód__Processamento"; "Cód. Processamento")
            {
            }
            column(Hist__Linhas_Movs__Empregado2_Tipo_Processamento; "Tipo Processamento")
            {
            }
            column(Hist__Linhas_Movs__Empregado2_N__Empregado; "Employee No.")
            {
            }
            column(Hist__Linhas_Movs__Empregado2_N__Linha; "No. Linha")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Empregado.Get("Hist. Linhas Movs. Empregado2"."Employee No.");
                if "Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A" = 0 then
                    TipoProc := 1
                else
                    TipoProc := "Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A";

                //--------------------------------------------------------
                //Limpar Variáveis
                //--------------------------------------------------------

                if ("Hist. Linhas Movs. Empregado2"."Employee No." <> AuxEmp) or
                   (("Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A" <> AuxTipoRend) and
                     (RendimentosAno <> 0)) then begin //normatica 2014.02.11 se os rendimentos são 0 então os retidos aparecem na linha a seguir
                    RendimentosAno := 0;
                    ImportanciasRetidas := 0;
                    Desconto := 0;
                    ValorSindicato := 0;
                    SobreTaxa := 0;
                end;

                AuxEmp := "Hist. Linhas Movs. Empregado2"."Employee No.";
                AuxTipoRend := "Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A";
                //-----------------------------------------------------------------
                //Calcular qual os rendimentos do ano - sobre os quais incide irs
                //-----------------------------------------------------------------
                if ("Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A" = 0) then begin
                    Flag := false;
                    TabRubrica.Reset;
                    TabRubrica.SetFilter(TabRubrica.Genero, '%1|%2|%3',
                                         TabRubrica.Genero::IRS,
                                         TabRubrica.Genero::"IRS Sub. Férias",
                                         TabRubrica.Genero::"IRS Sub. Natal");
                    TabRubrica.SetRange(TabRubrica."Sobretaxa em Sede de IRS", false);
                    TabRubrica.SetRange(TabRubrica."Imposto Extraordinário", false);
                    if TabRubrica.Find('-') then begin
                        repeat
                            TabRubricaLinhas.Reset;
                            TabRubricaLinhas.SetRange(TabRubricaLinhas."Payroll Item Code", TabRubrica.Código);
                            if TabRubricaLinhas.FindSet then begin
                                repeat
                                    if TabRubricaLinhas."Cód. Rubrica Filha" = "Hist. Linhas Movs. Empregado2"."Payroll Item Code" then begin
                                        if TabRubricaLinhas."Valor Limite Máximo" <> 0 then
                                            varLimite := "Hist. Linhas Movs. Empregado2".Quantity * TabRubricaLinhas."Valor Limite Máximo"
                                        else
                                            varLimite := 0;
                                        RendimentosAno := RendimentosAno + Round("Hist. Linhas Movs. Empregado2".Valor, 0.01) - varLimite;
                                        TotalRendimentosAno := TotalRendimentosAno + Round("Hist. Linhas Movs. Empregado2".Valor, 0.01) - varLimite;
                                        Flag := true;
                                    end;
                                until (TabRubricaLinhas.Next = 0) or (Flag = true);
                            end;
                        until (TabRubrica.Next = 0) or (Flag = true);

                    end;
                end;

                if ("Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A" = "Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A"::A2) or
                   ("Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A" = "Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A"::A3) or
                   ("Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A" = "Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A"::A4) or
                   ("Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A" = "Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A"::A5)
                   then begin

                    Flag := false;
                    TabRubrica.Reset;
                    TabRubrica.SetFilter(TabRubrica.Genero, '%1|%2|%3',
                                         TabRubrica.Genero::IRS,
                                         TabRubrica.Genero::"IRS Sub. Férias",
                                         TabRubrica.Genero::"IRS Sub. Natal");
                    TabRubrica.SetRange(TabRubrica."Sobretaxa em Sede de IRS", false);
                    TabRubrica.SetRange(TabRubrica."Imposto Extraordinário", false);
                    if TabRubrica.FindSet then begin
                        repeat
                            TabRubricaLinhas.Reset;
                            TabRubricaLinhas.SetRange(TabRubricaLinhas."Payroll Item Code", TabRubrica.Código);
                            if TabRubricaLinhas.Find('-') then begin
                                repeat
                                    if TabRubricaLinhas."Cód. Rubrica Filha" = "Hist. Linhas Movs. Empregado2"."Payroll Item Code" then begin
                                        if TabRubricaLinhas."Valor Limite Máximo" <> 0 then
                                            varLimite := "Hist. Linhas Movs. Empregado2".Quantity * TabRubricaLinhas."Valor Limite Máximo"
                                        else
                                            varLimite := 0;
                                        RendimentosAno := RendimentosAno + Round("Hist. Linhas Movs. Empregado2".Valor, 0.01) - varLimite;
                                        TotalRendimentosAno := TotalRendimentosAno + Round("Hist. Linhas Movs. Empregado2".Valor, 0.01) - varLimite;
                                        Flag := true;
                                    end;
                                until (TabRubricaLinhas.Next = 0) or (Flag);
                            end;
                        until (TabRubrica.Next = 0) or (Flag);
                    end;
                end;

                //-----------------------------------------------------------------
                //Rendimentos Não Sujeitos
                //-----------------------------------------------------------------
                if ("Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A" = "Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A"::A20) or
                   ("Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A" = "Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A"::A21) or
                   ("Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A" = "Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A"::A22) or
                   ("Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A" = "Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A"::A23) or
                   ("Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A" = "Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A"::A24) or
                   ("Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A" = "Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A"::A25) or
                   ("Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A" = "Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A"::A30) or
                   ("Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A" = "Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A"::A31) or
                   ("Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A" = "Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A"::A32) or
                   ("Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A" = "Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A"::A33)
                   then begin
                    Flag := false;
                    TabRubrica.Reset;
                    TabRubrica.SetFilter(TabRubrica.Genero, '%1|%2|%3',
                                         TabRubrica.Genero::IRS,
                                         TabRubrica.Genero::"IRS Sub. Férias",
                                         TabRubrica.Genero::"IRS Sub. Natal");
                    TabRubrica.SetRange(TabRubrica."Sobretaxa em Sede de IRS", false);
                    TabRubrica.SetRange(TabRubrica."Imposto Extraordinário", false);
                    if TabRubrica.FindSet then begin
                        repeat
                            TabRubricaLinhas.Reset;
                            TabRubricaLinhas.SetRange(TabRubricaLinhas."Payroll Item Code", TabRubrica.Código);
                            if TabRubricaLinhas.FindSet then begin
                                repeat
                                    if TabRubricaLinhas."Cód. Rubrica Filha" = "Hist. Linhas Movs. Empregado2"."Payroll Item Code" then begin
                                        if TabRubricaLinhas."Valor Limite Máximo" <> 0 then
                                            varLimite := "Hist. Linhas Movs. Empregado2".Quantity * TabRubricaLinhas."Valor Limite Máximo"
                                        else
                                            varLimite := 0;
                                        RendimentosAno := RendimentosAno + varLimite;
                                        TotalRendimentosAno := TotalRendimentosAno + varLimite;
                                        Flag := true;
                                    end;
                                until (TabRubricaLinhas.Next = 0) or (Flag = true);
                            end;
                        until (TabRubrica.Next = 0) or (Flag = true);
                    end;
                    if not Flag then begin
                        RendimentosAno := RendimentosAno + Round("Hist. Linhas Movs. Empregado2".Valor, 0.01);
                        TotalRendimentosAno := TotalRendimentosAno + Round("Hist. Linhas Movs. Empregado2".Valor, 0.01);
                    end;
                end;

                //-----------------------------------------------------------------
                //Calcular as importâncias retidas
                //-----------------------------------------------------------------

                TabRubrica.Reset;
                TabRubrica.SetFilter(TabRubrica.Genero, '%1|%2|%3',
                                     TabRubrica.Genero::IRS,
                                     TabRubrica.Genero::"IRS Sub. Férias",
                                     TabRubrica.Genero::"IRS Sub. Natal");
                TabRubrica.SetRange(TabRubrica."Imposto Extraordinário", false);
                TabRubrica.SetRange(TabRubrica."Sobretaxa em Sede de IRS", false);
                if TabRubrica.FindSet then begin
                    repeat
                        if TabRubrica.Código = "Hist. Linhas Movs. Empregado2"."Payroll Item Code" then begin
                            ImportanciasRetidas := ImportanciasRetidas + "Hist. Linhas Movs. Empregado2".Valor;
                            TotalImpRetidas := TotalImpRetidas + "Hist. Linhas Movs. Empregado2".Valor;
                        end;
                    until TabRubrica.Next = 0;
                end;

                //----------------------------------------------------------
                //Calcular os descontos obrigatorios para a cga e adse e SS
                //--------------------------------------------------------- -
                TabRubrica.Reset;
                TabRubrica.SetFilter(TabRubrica.Genero, '%1|%2|%3',
                                   TabRubrica.Genero::CGA,
                                   TabRubrica.Genero::ADSE, TabRubrica.Genero::SS);
                if TabRubrica.FindSet then begin
                    repeat
                        if TabRubrica.Código = "Hist. Linhas Movs. Empregado2"."Payroll Item Code" then begin
                            Desconto := Desconto + "Hist. Linhas Movs. Empregado2".Valor;
                            TotalDescontos := TotalDescontos + "Hist. Linhas Movs. Empregado2".Valor;
                        end;
                    until TabRubrica.Next = 0;
                end;

                //--------------------------------------------------
                //Calcula o descontos para sindicatos
                //--------------------------------------------------
                TabRubrica.Reset;
                TabRubrica.SetRange(TabRubrica.Genero,
                                   TabRubrica.Genero::Sindicato);
                if TabRubrica.FindSet then begin
                    repeat
                        if TabRubrica.Código = "Hist. Linhas Movs. Empregado2"."Payroll Item Code" then begin
                            ValorSindicato := ValorSindicato + "Hist. Linhas Movs. Empregado2".Valor;
                            TotalSindicato := TotalSindicato + "Hist. Linhas Movs. Empregado2".Valor;
                        end;
                    until TabRubrica.Next = 0;
                end;
                //------------------------------------------------------------------
                //Calcular a sobretaxa extraordinária
                //------------------------------------------------------------------
                TabRubrica.Reset;
                TabRubrica.SetRange(TabRubrica."Sobretaxa em Sede de IRS", true);
                if TabRubrica.FindSet then begin
                    repeat
                        if TabRubrica.Código = "Hist. Linhas Movs. Empregado2"."Payroll Item Code" then begin
                            SobreTaxa := SobreTaxa + Round("Hist. Linhas Movs. Empregado2".Valor, 0.01);
                            TotSobreTaxa := TotSobreTaxa + Round("Hist. Linhas Movs. Empregado2".Valor, 0.01);
                        end;
                    until TabRubrica.Next = 0;
                end;
            end;

            trigger OnPostDataItem()
            begin
                //>>>>>>  LINHA 006 - Detalhe de DMR-AT 3 >>>>>>>>>>>>>>>>>>>>>>>>>>
                if RendimentosAno <> 0 then begin  //2014.02.11 - não pode aparcer linhas sem rendimento
                    if "Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A" = 0 then
                        "Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A" := 1;

                    Clear(NIP);
                    i := 1;

                    Empregado.Reset;
                    Empregado.SetRange(Empregado."No.", "Hist. Linhas Movs. Empregado2"."Employee No.");
                    if Empregado.FindFirst then begin
                        if Desconto <> 0 then begin
                            if Empregado."Subscritor SS" then begin
                                InstSegSocial.Reset;
                                InstSegSocial.SetRange(InstSegSocial.Code, Empregado."Cod. Instituição SS");
                                if InstSegSocial.FindFirst then begin
                                    NIP[i] := InstSegSocial.NIPC;
                                    i := i + 1;
                                end;
                            end;
                            if Empregado."Subsccritor CGA" then begin
                                NIP[i] := ConfRH."NIPC CGA";
                                i := i + 1;
                            end;

                            if Empregado."Subscritor ADSE" then begin
                                NIP[i] := ConfRH."NIPC ADSE";
                                i := i + 1;
                            end;
                        end;
                    end;

                    if (Abs(Round(RendimentosAno, 0.01)) <> 0.0) or
                        (Abs(Round(ImportanciasRetidas, 0.01)) <> 0.0) then begin
                        NLinha := NLinha + 1;
                        TabelaTempFichTexto.Init;
                        TabelaTempFichTexto."File Type" := TabelaTempFichTexto."File Type"::"DMR-AT";
                        TabelaTempFichTexto."Line No." := TabelaTempFichTexto."Line No." + 1;
                        TabelaTempFichTexto.Texto1 := '006'
                        + PadStr('0', 7 - StrLen(Format(NLinha)), '0') + Format(NLinha)                             //nlinha
                        + PadStr('0', 9 - StrLen(Empregado."No. Contribuinte"), '0') + Empregado."No. Contribuinte"   //NIF
                            + '+00000000000000'                                                                      //Rendimentos anos anteriores
                        + '0000'                                                                                //Nº ANos
                        + Converter(RendimentosAno, 15, true)                                                    //Rendimentos Ano
                        + PadStr(Format("Hist. Linhas Movs. Empregado2"."Tipo Rendimento Cat.A"), 3, ' ')        //tipo rendimento
                        + PadStr(Format(Empregado."Local Obtenção Rendimento"), 2, ' ')                          //Local rendimento
                        + Converter(ImportanciasRetidas, 14, false)                                              //Importancias retidas
                        + Converter(Desconto, 14, false)                                                         //Desconto
                        + PadStr(Format(NIP[1]), 9, '0')
                        + PadStr(Format(NIP[2]), 9, '0')
                        + PadStr(Format(NIP[3]), 9, '0')
                        + Converter(ValorSindicato, 14, false)                                                  //valor sindicato
                        + Converter(SobreTaxa, 14, false)                                                       //sobretaxa
                        + PadStr(' ', 31, ' ');
                        TabelaTempFichTexto.Insert;
                        TotalRegistos := TotalRegistos + 1;
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                "Hist. Linhas Movs. Empregado2".CopyFilters(Totais);
                TotalRendimentosAno := 0;
                TotalImpRetidas := 0;
                TotalDescontos := 0;
                TotalSindicato := 0;
                TotSobreTaxa := 0;
            end;
        }
        dataitem(TotalLinhas; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

            trigger OnAfterGetRecord()
            begin
                //2009.02.09 - o codigo passou para aqui
                //>>>>>>  LINHA 009 - Trailer DMR-AT >>>>>>>>>>>>>>>>>>>>>>>>>>
                TabelaTempFichTexto.Init;
                TabelaTempFichTexto."File Type" := TabelaTempFichTexto."File Type"::"DMR-AT";
                TabelaTempFichTexto."Line No." := TabelaTempFichTexto."Line No." + 1;
                TabelaTempFichTexto.Texto1 := '009'
                + '+000000000000000'
                + Converter(TotalRendimentosAno, 17, true)
                + Converter(TotalImpRetidas, 16, false)
                + Converter(TotalDescontos, 16, false)
                + Converter(TotalSindicato, 16, false)
                + Converter(TotSobreTaxa, 16, false)
                + ConvertStr(Format(TotalRegistos + 2, 7, '<Sign><Integer>'), ' ', '0')
                + PadStr(' ', 65, ' ');

                TabelaTempFichTexto.Insert;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group("Dec. Mensal Rem. AT")
                {
                    Caption = 'Options';
                    field(DataIni; DataIni)
                    {
                        ApplicationArea = HumanResourcesAppArea;
                        Caption = 'Periodo de:';
                    }
                    field(DataFim; DataFim)
                    {
                        ApplicationArea = HumanResourcesAppArea;
                        Caption = 'a:';
                    }
                    field(CodRepFinancas; CodRepFinancas)
                    {
                        ApplicationArea = HumanResourcesAppArea;
                        Caption = 'Cód. Rep.Finanças';
                    }
                    field(NIFRepLegal; NIFRepLegal)
                    {
                        ApplicationArea = HumanResourcesAppArea;
                        Caption = 'NIF Representante Legal';
                    }
                    field(NIFTecOficialContas; NIFTecOficialContas)
                    {
                        ApplicationArea = HumanResourcesAppArea;
                        Caption = 'NIF Tec. Oficial Contas';
                    }
                    field(Tipodeclaracao; Tipodeclaracao)
                    {
                        ApplicationArea = HumanResourcesAppArea;
                        Caption = 'Tipo Declaração';
                    }
                    field(campoData; DataAlteração)
                    {
                        ApplicationArea = HumanResourcesAppArea;
                        Caption = 'Data de alteração';
                    }
                    field("Declaraçao"; Declaraçao)
                    {
                        ApplicationArea = HumanResourcesAppArea;
                        Caption = 'Declaração apresentada nos termos da al. d), nº1, art.º 119 do CIRS';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin

            if InfEmpresa.Get then;
            CodRepFinancas := InfEmpresa."PTSS Tax Authority Code";
            NIFRepLegal := InfEmpresa."PTSS Legal Rep. VAT Reg. No.";
            NIFTecOficialContas := InfEmpresa."PTSS TOC VAT Reg. No.";
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        //>>>>>>  LINHA 099 - Trailer Declaração  >>>>>>>>>>>>>>>>>>>>>>>>>>
        TabelaTempFichTexto.Init;
        TabelaTempFichTexto."File Type" := TabelaTempFichTexto."File Type"::"DMR-AT";
        TabelaTempFichTexto."Line No." := TabelaTempFichTexto."Line No." + 1;
        TabelaTempFichTexto.Texto1 := '099'
        + ConvertStr(Format(TotalRegistos + 4, 9, '<Sign><Integer>'), ' ', '0')
        + PadStr(' ', 160, ' ');
        TabelaTempFichTexto.Insert;

        //>>>>>>  LINHA 999 - Trailer Ficheiro>>>>>>>>>>>>>>>>>>>>>>>>>>
        TabelaTempFichTexto.Init;
        TabelaTempFichTexto."File Type" := TabelaTempFichTexto."File Type"::"DMR-AT";
        TabelaTempFichTexto."Line No." := TabelaTempFichTexto."Line No." + 1;
        TabelaTempFichTexto.Texto1 := '999'
        + ConvertStr(Format(TotalRegistos + 6, 9, '<Sign><Integer>'), ' ', '0')
        + PadStr(' ', 160, ' ');
        TabelaTempFichTexto.Insert;
    end;

    trigger OnPreReport()
    begin
        InfEmpresa.Get;
        InfEmpresa.CalcFields(InfEmpresa.Picture);
        ConfRH.Get;

        TabelaTempFichTexto.SetRange(TabelaTempFichTexto."File Type", TabelaTempFichTexto."File Type"::"DMR-AT");
        if TabelaTempFichTexto.FindFirst then
            TabelaTempFichTexto.DeleteAll;

        //>>>>>>  LINHA 001 - Header do ficheiro >>>>>>>>>>>>>>>>>>>>>>>>>>
        TabelaTempFichTexto.Init;
        TabelaTempFichTexto."File Type" := TabelaTempFichTexto."File Type"::"DMR-AT";
        TabelaTempFichTexto."Line No." := 1;
        TabelaTempFichTexto.Texto1 := '001ASCII02'
        + Format(WorkDate, 0, '<Year4><Month,2><Day,2>')
        + PadStr(' ', 154, ' ');
        TabelaTempFichTexto.Insert;

        //>>>>>>  LINHA 002 - Header de declaração >>>>>>>>>>>>>>>>>>>>>>>>>>
        TabelaTempFichTexto.Init;
        TabelaTempFichTexto."File Type" := TabelaTempFichTexto."File Type"::"DMR-AT";
        TabelaTempFichTexto."Line No." := TabelaTempFichTexto."Line No." + 1;
        TabelaTempFichTexto.Texto1 := '002DMR-AT'
        + PadStr('0', 9 - StrLen(InfEmpresa."VAT Registration No."), '0') + InfEmpresa."VAT Registration No."  //NIF
        + Format(DataIni, 0, '<Year4>')                                                      //Periodo de
        + Format(DataIni, 0, '<Month,2>')                                                    //Periodo a
        + 'EUR'
        + PadStr(' ', 145, ' ');
        TabelaTempFichTexto.Insert;

        TabelaTempFichTexto.Init;
        TabelaTempFichTexto."File Type" := TabelaTempFichTexto."File Type"::"DMR-AT";
        TabelaTempFichTexto."Line No." := TabelaTempFichTexto."Line No." + 1;
        TabelaTempFichTexto.Texto1 := '003'
        + PadStr('0', 4 - StrLen(CodRepFinancas), '0') + CodRepFinancas;                                       //Cod. Rep. finanças

        if Tipodeclaracao = Tipodeclaracao::"1ª Declaração do ano" then                                     //Tipo declaração
            TabelaTempFichTexto.Texto1 := TabelaTempFichTexto.Texto1 + '1'
        else
            TabelaTempFichTexto.Texto1 := TabelaTempFichTexto.Texto1 + '2';

        if Declaraçao = Declaraçao::"Não" then begin
            TabelaTempFichTexto.Texto1 := TabelaTempFichTexto.Texto1 + '0'
        end else begin
            TabelaTempFichTexto.Texto1 := TabelaTempFichTexto.Texto1 + '3';
        end;

        TabelaTempFichTexto.Texto1 := TabelaTempFichTexto.Texto1
        + PadStr((Format(DataAlteração, 0, '<Year4><Month,2><Day,2>')), 8, '0')
        + PadStr('0', 9 - StrLen(NIFTecOficialContas), '0') + NIFTecOficialContas
        + PadStr('0', 9 - StrLen(NIFRepLegal), '0') + NIFRepLegal
        + PadStr(' ', 137, ' ');
        TabelaTempFichTexto.Insert;
    end;

    var
        TotalFor: Label 'Total de ';
        TabRubrica: Record "Payroll Item";
        TabRubricaLinhas: Record "Rubrica Salarial Linhas";
        DataIni: Date;
        DataFim: Date;
        TabelaTempFichTexto: Record "Tabela Temp Ficheiros Texto";
        InfEmpresa: Record "Company Information";
        ConfRH: Record "Config. Recursos Humanos";
        InstSegSocial: Record "Instituição Seg. Social";
        NLinha: Integer;
        CodRepFinancas: Text[4];
        Tipodeclaracao: Option "1ª Declaração do ano","Declaração de Substituição";
        NIFRepLegal: Text[9];
        NIFTecOficialContas: Text[9];
        RendimentosAno: Decimal;
        TotalRendimentosAno: Decimal;
        ImportanciasRetidas: Decimal;
        TotalImpRetidas: Decimal;
        AuxEmp: Code[20];
        Empregado: Record Empregado;
        TotalRegistos: Integer;
        AuxTipoRend: Integer;
        varLimite: Decimal;
        TabTempEmpregado: Record Empregado temporary;
        Desconto: Decimal;
        TotalDescontos: Decimal;
        ValorSindicato: Decimal;
        TotalSindicato: Decimal;
        "DataAlteração": Date;
        "Declaraçao": Option "Não",Sim;
        Flag: Boolean;
        SobreTaxa: Decimal;
        TotSobreTaxa: Decimal;
        TotalRendSujeitosValor: Decimal;
        TotalRendSujeitosRetencoes: Decimal;
        TotalRendSujeitosContrib: Decimal;
        TotalRendSujeitosSindic: Decimal;
        TotalRendSujeitosSobretaxa: Decimal;
        TotalRendNSujeitosValor: Decimal;
        TotalRendNSujeitosRetencoes: Decimal;
        TotalRendNSujeitosContrib: Decimal;
        TotalRendNSujeitosSindic: Decimal;
        TotalRendNSujeitosSobretaxa: Decimal;
        NIPCSS: Text[9];
        NIPCCGA: Text[9];
        NIPCADSE: Text[9];
        NIP: array[3] of Text[9];
        i: Integer;
        "Declaração_Mensal_de_RemuneraçõesCaptionLbl": Label 'Declaração Mensal de Remunerações';
        Valor_RendimentosCaptionLbl: Label 'Valor Rendimentos';
        "Retenção_IRSCaptionLbl": Label 'Retenção IRS';
        "Contribuições_ObrigatóriasCaptionLbl": Label 'Contribuições Obrigatórias';
        "Quotizações_SindicaisCaptionLbl": Label 'Quotizações Sindicais';
        "Retenção_SobretaxaCaptionLbl": Label 'Retenção Sobretaxa';
        Redimentos_SujeitosCaptionLbl: Label 'Redimentos Sujeitos';
        Redimentos_IsentosCaptionLbl: Label 'Redimentos Isentos';
        "Redimentos_Não_SujeitosCaptionLbl": Label 'Redimentos Não Sujeitos';
        TotaisCaptionLbl: Label 'Totais';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Periodo_de_CaptionLbl: Label 'Periodo de:';
        a_CaptionLbl: Label 'a:';
        SobretaxaCaptionLbl: Label 'Sobretaxa';
        Valor_SindicatoCaptionLbl: Label 'Valor Sindicato';
        DescontoCaptionLbl: Label 'Desconto';
        "Importâncias_RetidasCaptionLbl": Label 'Importâncias Retidas';
        Rendimentos_AnoCaptionLbl: Label 'Rendimentos Ano';
        NomeCaptionLbl: Label 'Nome';
        N__ContribuinteCaptionLbl: Label 'Nº Contribuinte';
        TotVal: Integer;
        TotCount: Integer;
        TipoProc: Option " ",A,A2,A11,A12,A13,A14,A15,A16,A17,A20,A21,A22,A23,A30,A31,A32,A3,A4,A5,A18,A33,A19,A24,A25;


    procedure Converter(Valor: Decimal; Tamanho: Integer; Abono: Boolean) ValorTexto: Text[30]
    var
        vartexto: Text[30];
        varsinal: Text[1];
    begin
        if Abono then begin
            if Valor >= 0 then
                varsinal := '+'
            else
                varsinal := '-';
        end else begin
            if Valor * -1 >= 0 then
                varsinal := '+'
            else
                varsinal := '-';
        end;
        vartexto := DelChr(ConvertStr(Format(Abs(Round(Valor, 0.01)), Tamanho, '<Integer><Decimals,3>'), ' ', '0'), '=', ',');
        exit(varsinal + vartexto);
    end;
}

