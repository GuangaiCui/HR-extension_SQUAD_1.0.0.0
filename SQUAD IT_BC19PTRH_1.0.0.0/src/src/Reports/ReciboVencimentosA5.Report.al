report 53043 "Recibo Vencimentos A5"
{
    // //-------------------------------------------------------
    //               Recibo de Vencimentos
    // //--------------------------------------------------------
    //   Este é o report a ser entregue ao empregado mensalmente
    //   como recibo do sua remuneração.
    // //-------------------------------------------------------
    // 
    // Tagus - querem o cargo em vez da cat prof
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\ReciboVencimentosA5.rdl';

    PreviewMode = PrintLayout;
    UseRequestPage = true;

    dataset
    {
        dataitem("Periodos Processamento"; "Periodos Processamento")
        {
            DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento") WHERE("Tipo Processamento" = FILTER(<> Encargos));
            PrintOnlyIfDetail = true;

            trigger OnAfterGetRecord()
            begin
                //17.04.07 - Se o processamento não está fechado tem de aparecer no mapa a indicação de que este é provisório
                if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then
                    VarProvisorio := 'Provisório'
                else
                    VarProvisorio := '';

                if "Periodos Processamento"."Tipo Processamento" = "Periodos Processamento"."Tipo Processamento"::Vencimentos then
                    varSubFerNat := ''
                else
                    varSubFerNat := ' - ' + Format("Periodos Processamento"."Tipo Processamento");
            end;

            trigger OnPreDataItem()
            begin
                "Periodos Processamento".SetRange("Cód. Processamento", CodProcess);
            end;
        }
        dataitem(Empregado; Employee)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(Empregado_No_; "No.")
            {
            }
            column(Estado; "Periodos Processamento".Estado)
            {
            }
            column(Tipo_Processamento; "Periodos Processamento"."Tipo Processamento")
            {
            }
            column(TabConfContab__Currency_Text_; TabConfContab."LCY Code")
            {
            }
            dataitem(Integer2; "Integer")
            {
                DataItemLinkReference = Empregado;
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 .. 2));
                column(TabConfContab__Currency_Text__Control1101490014; TabConfContab."LCY Code")
                {
                }
                column(UPPERCASE_FORMAT__Periodos_Processamento___Data_Registo__0___Month_Text___year4____; UpperCase(Format("Periodos Processamento"."Data Registo", 0, '<Month Text> <year4>')))
                {
                }
                column(txtCatProfEmp; txtCatProfEmp)
                {
                }
                column(CabNContribuinte; CabNContribuinte)
                {
                }
                column(UPPERCASE_CabNome_; UpperCase(CabNome))
                {
                }
                column(CabNEmp; CabNEmp)
                {
                }
                column(CabNsegSocial; CabNsegSocial)
                {
                }
                column(varVencimentoBase; varVencimentoBase)
                {
                }
                column(varValorHora; varValorHora)
                {
                }
                column(CabSeguradora; CabSeguradora)
                {
                }
                column(CabApolice; CabApolice)
                {
                }
                column(VarOrigiDuplicado; VarOrigiDuplicado)
                {
                }
                column(TabConfEmpresa_Name; TabConfEmpresa.Name)
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
                column(N__Telefone______TabConfEmpresa__Phone_No__; 'Nº Telefone: ' + TabConfEmpresa."Phone No.")
                {
                }
                column(CabNNIB; CabNNIB)
                {
                }
                column(TabConfEmpresa__Name_2_; TabConfEmpresa."Name 2")
                {
                }
                column(VarProvisorio; VarProvisorio)
                {
                }
                column(CabNCGA; CabNCGA)
                {
                }
                column(N__Contribuinte______TabConfEmpresa__VAT_Registration_No__; 'Nº Contribuinte: ' + TabConfEmpresa."VAT Registration No.")
                {
                }
                column(txtGrauEmp; txtGrauEmp)
                {
                }
                column(CabNHorasSeman; CabNHorasSeman)
                {
                }
                column(varSubFerNat; varSubFerNat)
                {
                }
                column(varTitulo; varTitulo)
                {
                }
                column(AbonosCaption; AbonosCaptionLbl)
                {
                }
                column(DescontosCaption; DescontosCaptionLbl)
                {
                }
                column("MÊSCaption"; MÊSCaptionLbl)
                {
                }
                column(CategoriaCaption; CategoriaCaptionLbl)
                {
                }
                column(N__ContribuinteCaption; N__ContribuinteCaptionLbl)
                {
                }
                column(NomeCaption; NomeCaptionLbl)
                {
                }
                column(N_Caption; N_CaptionLbl)
                {
                }
                column("N__Segurança_SocialCaption"; N__Segurança_SocialCaptionLbl)
                {
                }
                column(Vencimento_BaseCaption; Vencimento_BaseCaptionLbl)
                {
                }
                column(Valor_HoraCaption; Valor_HoraCaptionLbl)
                {
                }
                column("ApóliceCaption"; ApóliceCaptionLbl)
                {
                }
                column(NIBCaption; NIBCaptionLbl)
                {
                }
                column(N__CGACaption; N__CGACaptionLbl)
                {
                }
                column(N__Horas_SemanaisCaption; N__Horas_SemanaisCaptionLbl)
                {
                }
                column("Nível_SalarialCaption"; Nível_SalarialCaptionLbl)
                {
                }
                column(Integer2_Number; Number)
                {
                }
                column(Total_DescontosCaption; Total_DescontosCaptionLbl)
                {
                }
                column(Total_AbonosCaption; Total_AbonosCaptionLbl)
                {
                }
                dataitem("Linhas Movs. Empregado1"; "Linhas Movs. Empregado")
                {
                    DataItemLink = "No. Empregado" = FIELD("No.");
                    DataItemLinkReference = Empregado;
                    DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado", "No. Linha") WHERE("Tipo Processamento" = FILTER(<> Encargos), "Tipo Rubrica" = CONST(Abono));
                    column("Linhas_Movs__Empregado1__Descrição_Rubrica_"; "Descrição Rubrica")
                    {
                    }
                    column(Linhas_Movs__Empregado1_Valor; Valor)
                    {
                    }
                    column(Linhas_Movs__Empregado1_Quantidade; Quantidade)
                    {
                    }
                    column(Linhas_Movs__Empregado1_UnidadeMedida; UnidadeMedida)
                    {
                    }
                    column(Linhas_Movs__Empregado1_Valor_Control1000000042; Valor)
                    {
                    }
                    column("Linhas_Movs__Empregado1_Cód__Processamento"; "Cód. Processamento")
                    {
                    }
                    column(Linhas_Movs__Empregado1_Tipo_Processamento; "Tipo Processamento")
                    {
                    }
                    column(Linhas_Movs__Empregado1_N__Empregado; "No. Empregado")
                    {
                    }
                    column(Linhas_Movs__Empregado1_N__Linha; "No. Linha")
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Fechado then
                            CurrReport.Skip
                        else
                            "Linhas Movs. Empregado1".SetRange("Linhas Movs. Empregado1"."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                    end;
                }
                dataitem("Linhas Movs. Empregado2"; "Linhas Movs. Empregado")
                {
                    DataItemLink = "No. Empregado" = FIELD("No.");
                    DataItemLinkReference = Empregado;
                    DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado", "No. Linha") WHERE("Tipo Processamento" = FILTER(<> Encargos), "Tipo Rubrica" = CONST(Desconto));
                    column(Linhas_Movs__Empregado2_Valor; Valor)
                    {
                    }
                    column(VarQuantidade; VarQuantidade)
                    {
                    }
                    column("Linhas_Movs__Empregado2__Descrição_Rubrica_"; "Descrição Rubrica")
                    {
                    }
                    column(Linhas_Movs__Empregado2_UnidadeMedida; UnidadeMedida)
                    {
                    }
                    column(Linhas_Movs__Empregado2_Valor_Control1101490020; Valor)
                    {
                    }
                    column("Linhas_Movs__Empregado2_Cód__Processamento"; "Cód. Processamento")
                    {
                    }
                    column(Linhas_Movs__Empregado2_Tipo_Processamento; "Tipo Processamento")
                    {
                    }
                    column(Linhas_Movs__Empregado2_N__Empregado; "No. Empregado")
                    {
                    }
                    column(Linhas_Movs__Empregado2_N__Linha; "No. Linha")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        VarQuantidade := Format("Linhas Movs. Empregado2".Quantidade);

                        //Para aparecer % na quantidade quando é irs ou seg. social
                        //----------------------------------------------------------
                        TabRubrica.Reset;
                        TabRubrica.SetRange(TabRubrica.Código, "Linhas Movs. Empregado2"."Cód. Rubrica");
                        if TabRubrica.FindFirst then begin
                            if (TabRubrica.Genero = TabRubrica.Genero::IRS) or
                                (TabRubrica.Genero = TabRubrica.Genero::SS) or
                                (TabRubrica.Genero = TabRubrica.Genero::IVA) or
                                (TabRubrica.Genero = TabRubrica.Genero::CGA) or
                                (TabRubrica.Genero = TabRubrica.Genero::"IRS Sub. Férias") or
                                (TabRubrica.Genero = TabRubrica.Genero::"IRS Sub. Natal") or
                                (TabRubrica.Genero = TabRubrica.Genero::ADSE) or //HG 14.12.2007
                                (TabRubrica.Genero = TabRubrica.Genero::Sindicato) then begin   //HG 08.11.2007
                                VarQuantidade := Format("Linhas Movs. Empregado2".Quantidade) + '%';
                                //2011.11.09 - por causa do imposto extraordinário
                                if TabRubrica."Imposto Extraordinário" = true then
                                    VarQuantidade := '';
                            end;
                            //2008.01.10 - este código é para faltas aparecerem no recido em dias ou horas consoante o que foi lançado
                            if TabRubrica.Genero = TabRubrica.Genero::Falta then
                                VarQuantidade := Format("Linhas Movs. Empregado2"."Quatidade Recibo Vencimentos");
                        end;
                    end;

                    trigger OnPostDataItem()
                    begin
                        lastLine := false;
                    end;

                    trigger OnPreDataItem()
                    begin
                        if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Fechado then
                            CurrReport.Skip
                        else
                            "Linhas Movs. Empregado2".SetRange("Linhas Movs. Empregado2"."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                    end;
                }
                dataitem("Linhas Movs. Empregado3"; "Linhas Movs. Empregado")
                {
                    DataItemLink = "No. Empregado" = FIELD("No.");
                    DataItemLinkReference = Empregado;
                    DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado", "No. Linha") WHERE("Tipo Processamento" = FILTER(<> Encargos));
                    column(Linhas_Movs__Empregado3_Valor; Valor)
                    {
                    }
                    column(LME3Valor; LME3Valor)
                    {
                    }
                    column("Linhas_Movs__Empregado3__Linhas_Movs__Empregado3___Designação_Empregado_"; "Linhas Movs. Empregado3"."Designação Empregado")
                    {
                    }
                    column(TabConfContab__Currency_Text__Control1101490015; TabConfContab."LCY Code")
                    {
                    }
                    column(ABS_DescontadoIRS_; Abs(DescontadoIRS))
                    {
                    }
                    column(AcumuladoIRS; AcumuladoIRS)
                    {
                    }
                    column(varPagamento; varPagamento)
                    {
                    }
                    column(Total_a_ReceberCaption; Total_a_ReceberCaptionLbl)
                    {
                    }
                    column(Acumulado_IRS_Caption; Acumulado_IRS_CaptionLbl)
                    {
                    }
                    column(Cativo_Caption; Cativo_CaptionLbl)
                    {
                    }
                    column(Descontado_Caption; Descontado_CaptionLbl)
                    {
                    }
                    column(Processado_por_ComputadorCaption; Processado_por_ComputadorCaptionLbl)
                    {
                    }
                    column("Declaro_que_nada_mais_me_é_devido_até_à_presente_data_Caption"; Declaro_que_nada_mais_me_é_devido_até_à_presente_data_CaptionLbl)
                    {
                    }
                    column("Linhas_Movs__Empregado3_Cód__Processamento"; "Cód. Processamento")
                    {
                    }
                    column(Linhas_Movs__Empregado3_Tipo_Processamento; "Tipo Processamento")
                    {
                    }
                    column(Linhas_Movs__Empregado3_N__Empregado; "No. Empregado")
                    {
                    }
                    column(Linhas_Movs__Empregado3_N__Linha; "No. Linha")
                    {
                    }
                    column(NumLME3; NumLME3)
                    {
                    }
                    column(CountLME3; CountLME3)
                    {
                    }
                    column(lastLine; lastLine)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        NumLME3 := NumLME3 + 1;
                        LME3Valor := LME3Valor + Valor;
                        CountLME3 := Round("Linhas Movs. Empregado3".Count / 2, 1);
                        if "Linhas Movs. Empregado3".Next = 0 then
                            lastLine := true;
                    end;

                    trigger OnPreDataItem()
                    begin
                        if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Fechado then
                            CurrReport.Skip
                        else
                            "Linhas Movs. Empregado3".SetRange("Linhas Movs. Empregado3"."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                        //27.04.2006 - IRS Descontado até ao momento
                        TabHistLinhasMov2.Reset;
                        TabHistLinhasMov2.SetRange(TabHistLinhasMov2."No. Empregado", Empregado."No.");
                        TabHistLinhasMov2.SetFilter(TabHistLinhasMov2."Tipo Processamento", '<>%1', TabHistLinhasMov2."Tipo Processamento"::Encargos);
                        TabHistLinhasMov2.SetRange(TabHistLinhasMov2."Data Registo",
                                                   DMY2Date(1, 1, Date2DMY("Periodos Processamento"."Data Registo", 3)),
                                                   "Periodos Processamento"."Data Fim Processamento");
                        if TabHistLinhasMov2.FindSet then begin
                            repeat
                                TabRubrica2.Reset;
                                TabRubrica2.SetRange(TabRubrica2.Código, TabHistLinhasMov2."Cód. Rubrica");
                                if TabRubrica2.Find('-') then begin
                                    if (TabRubrica2.Genero = TabRubrica2.Genero::IRS) or
                                       (TabRubrica2.Genero = TabRubrica2.Genero::"IRS Sub. Férias") or
                                       (TabRubrica2.Genero = TabRubrica2.Genero::"IRS Sub. Natal") then
                                        DescontadoIRS := DescontadoIRS + TabHistLinhasMov2.Valor;
                                end;
                            until TabHistLinhasMov2.Next = 0;
                        end;

                        TabLinhasMov2.Reset;
                        TabLinhasMov2.SetRange(TabLinhasMov2."No. Empregado", Empregado."No.");
                        TabLinhasMov2.SetFilter(TabLinhasMov2."Tipo Processamento", '<>%1', TabLinhasMov2."Tipo Processamento"::Encargos);
                        TabLinhasMov2.SetRange(TabLinhasMov2."Data Registo",
                                                   DMY2Date(1, 1, Date2DMY("Periodos Processamento"."Data Registo", 3)),
                                                   "Periodos Processamento"."Data Fim Processamento");
                        if TabLinhasMov2.FindSet then begin
                            repeat
                                TabRubrica2.Reset;
                                TabRubrica2.SetRange(TabRubrica2.Código, TabLinhasMov2."Cód. Rubrica");
                                if TabRubrica2.Find('-') then begin
                                    if (TabRubrica2.Genero = TabRubrica2.Genero::IRS) or
                                       (TabRubrica2.Genero = TabRubrica2.Genero::"IRS Sub. Férias") or
                                       (TabRubrica2.Genero = TabRubrica2.Genero::"IRS Sub. Natal") then
                                        DescontadoIRS := DescontadoIRS + TabLinhasMov2.Valor;
                                end;
                            until TabLinhasMov2.Next = 0;
                        end;

                        //27.04.2006 - Cativo - Base de Icidência de IRS

                        TabHistLinhasMov2.Reset;
                        TabHistLinhasMov2.SetRange(TabHistLinhasMov2."No. Empregado", Empregado."No.");
                        TabHistLinhasMov2.SetFilter(TabHistLinhasMov2."Tipo Processamento", '<>%1', TabHistLinhasMov2."Tipo Processamento"::Encargos);
                        TabHistLinhasMov2.SetRange(TabHistLinhasMov2."Data Registo",
                                                   DMY2Date(1, 1, Date2DMY("Periodos Processamento"."Data Registo", 3)),
                                                   "Periodos Processamento"."Data Fim Processamento");
                        if TabHistLinhasMov2.Find('-') then begin
                            repeat
                                Flag := false;
                                TabRubrica2.Reset;
                                TabRubrica2.SetFilter(TabRubrica2.Genero, '%1|%2|%3', TabRubrica2.Genero::IRS, TabRubrica2.Genero::"IRS Sub. Férias",
                                                      TabRubrica2.Genero::"IRS Sub. Natal");
                                if TabRubrica2.FindSet then
                                    repeat
                                        TabRubricaLinha2.Reset;
                                        TabRubricaLinha2.SetRange(TabRubricaLinha2."Cód. Rubrica", TabRubrica2.Código);
                                        TabRubricaLinha2.SetRange(TabRubricaLinha2."Cód. Rubrica Filha", TabHistLinhasMov2."Cód. Rubrica");
                                        if TabRubricaLinha2.FindFirst then begin
                                            AcumuladoIRS := AcumuladoIRS +
                                                         ((TabHistLinhasMov2.Valor - TabHistLinhasMov2.Quantidade * TabRubricaLinha2."Valor Limite Máximo")
                                                         * (TabRubricaLinha2.Percentagem / 100));
                                            Flag := true;
                                        end;
                                    until (TabRubrica2.Next = 0) or (Flag = true);
                            until TabHistLinhasMov2.Next = 0;
                        end;

                        TabLinhasMov2.Reset;
                        TabLinhasMov2.SetRange(TabLinhasMov2."No. Empregado", Empregado."No.");
                        TabLinhasMov2.SetFilter(TabLinhasMov2."Tipo Processamento", '<>%1', TabLinhasMov2."Tipo Processamento"::Encargos);
                        TabLinhasMov2.SetRange(TabLinhasMov2."Data Registo",
                                                   DMY2Date(1, 1, Date2DMY("Periodos Processamento"."Data Registo", 3)),
                                                   "Periodos Processamento"."Data Fim Processamento");
                        if TabLinhasMov2.Find('-') then begin
                            repeat
                                Flag := false;
                                TabRubrica2.Reset;
                                TabRubrica2.SetFilter(TabRubrica2.Genero, '%1|%2|%3', TabRubrica2.Genero::IRS, TabRubrica2.Genero::"IRS Sub. Férias",
                                                      TabRubrica2.Genero::"IRS Sub. Natal");
                                if TabRubrica2.FindSet then
                                    repeat
                                        TabRubricaLinha2.Reset;
                                        TabRubricaLinha2.SetRange(TabRubricaLinha2."Cód. Rubrica", TabRubrica2.Código);
                                        TabRubricaLinha2.SetRange(TabRubricaLinha2."Cód. Rubrica Filha", TabLinhasMov2."Cód. Rubrica");
                                        if TabRubricaLinha2.Find('-') then begin
                                            AcumuladoIRS := AcumuladoIRS +
                                                        ((TabLinhasMov2.Valor - TabLinhasMov2.Quantidade * TabRubricaLinha2."Valor Limite Máximo")
                                                        * (TabRubricaLinha2.Percentagem / 100));
                                            Flag := true;
                                        end;
                                    until (TabRubrica2.Next = 0) or (Flag = true);
                            until TabLinhasMov2.Next = 0;
                        end;
                        //HG 27.04.2006 - Fim
                        NumLME3 := 0;
                        LME3Valor := 0;
                    end;
                }
                dataitem("Hist. Linhas Movs. Empregado1"; "Hist. Linhas Movs. Empregado")
                {
                    DataItemLink = "No. Empregado" = FIELD("No.");
                    DataItemLinkReference = Empregado;
                    DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado", "No. Linha") WHERE("Tipo Processamento" = FILTER(<> Encargos), "Tipo Rubrica" = CONST(Abono));
                    column(Hist__Linhas_Movs__Empregado1_Valor; Valor)
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado1_Quantidade; Quantidade)
                    {
                    }
                    column("Hist__Linhas_Movs__Empregado1__Descrição_Rubrica_"; "Descrição Rubrica")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado1_UnidadeMedida; UnidadeMedida)
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado1_Valor_Control1101490033; Valor)
                    {
                    }
                    column(TabConfContab__Currency_Text__Control1101490016; TabConfContab."LCY Code")
                    {
                    }
                    column("Hist__Linhas_Movs__Empregado1_Cód__Processamento"; "Cód. Processamento")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado1_Tipo_Processamento; "Tipo Processamento")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado1_N__Empregado; "No. Empregado")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado1_N__Linha; "No. Linha")
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then
                            CurrReport.Skip
                        else
                            "Hist. Linhas Movs. Empregado1".SetRange(
                            "Hist. Linhas Movs. Empregado1"."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                    end;
                }
                dataitem("Hist. Linhas Movs. Empregado2"; "Hist. Linhas Movs. Empregado")
                {
                    DataItemLink = "No. Empregado" = FIELD("No.");
                    DataItemLinkReference = Empregado;
                    DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado", "No. Linha") WHERE("Tipo Processamento" = FILTER(<> Encargos), "Tipo Rubrica" = CONST(Desconto));
                    column(Hist__Linhas_Movs__Empregado2_Valor; Valor)
                    {
                    }
                    column(VarQuantidade_Control1101490039; VarQuantidade)
                    {
                    }
                    column("Hist__Linhas_Movs__Empregado2__Descrição_Rubrica_"; "Descrição Rubrica")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado2_UnidadeMedida; UnidadeMedida)
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado2_Valor_Control1101490043; Valor)
                    {
                    }
                    column(TabConfContab__Currency_Text__Control1101490019; TabConfContab."LCY Code")
                    {
                    }
                    column(Total_DescontosCaption_Control1101490044; Total_DescontosCaption_Control1101490044Lbl)
                    {
                    }
                    column("Hist__Linhas_Movs__Empregado2_Cód__Processamento"; "Cód. Processamento")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado2_Tipo_Processamento; "Tipo Processamento")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado2_N__Empregado; "No. Empregado")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado2_N__Linha; "No. Linha")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        VarQuantidade := Format("Hist. Linhas Movs. Empregado2".Quantidade);

                        //Para aparecer % na quantidade quando é irs ou seg. social
                        //----------------------------------------------------------
                        TabRubrica.Reset;
                        TabRubrica.SetRange(TabRubrica.Código, "Hist. Linhas Movs. Empregado2"."Cód. Rubrica");
                        if TabRubrica.FindFirst then begin
                            if (TabRubrica.Genero = TabRubrica.Genero::IRS) or
                                (TabRubrica.Genero = TabRubrica.Genero::SS) or
                                (TabRubrica.Genero = TabRubrica.Genero::IVA) or
                                (TabRubrica.Genero = TabRubrica.Genero::CGA) or
                                (TabRubrica.Genero = TabRubrica.Genero::"IRS Sub. Férias") or
                                (TabRubrica.Genero = TabRubrica.Genero::"IRS Sub. Natal") or
                                (TabRubrica.Genero = TabRubrica.Genero::ADSE) or
                                (TabRubrica.Genero = TabRubrica.Genero::Sindicato) then begin

                                VarQuantidade := Format("Hist. Linhas Movs. Empregado2".Quantidade) + '%';
                                //2011.11.09 - por causa do imposto extraordinário
                                if TabRubrica."Imposto Extraordinário" = true then
                                    VarQuantidade := '';
                            end;
                            //2008.01.10 - este código é para faltas aparecerem no recido em dias ou horas consoante o que foi lançado
                            if TabRubrica.Genero = TabRubrica.Genero::Falta then
                                VarQuantidade := Format("Hist. Linhas Movs. Empregado2"."Quatidade Recibo Vencimentos");
                        end;
                    end;

                    trigger OnPostDataItem()
                    begin
                        lastLine3 := false;
                    end;

                    trigger OnPreDataItem()
                    begin
                        if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then
                            CurrReport.Skip
                        else
                            "Hist. Linhas Movs. Empregado2".SetRange("Hist. Linhas Movs. Empregado2"."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                    end;
                }
                dataitem("Hist. Linhas Movs. Empregado3"; "Hist. Linhas Movs. Empregado")
                {
                    DataItemLink = "No. Empregado" = FIELD("No.");
                    DataItemLinkReference = Empregado;
                    DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado", "No. Linha") WHERE("Tipo Processamento" = FILTER(<> Encargos));
                    column(Hist__Linhas_Movs__Empregado3_Valor; Valor)
                    {
                    }
                    column(HLME3Valor; HLME3Valor)
                    {
                    }
                    column("Hist__Linhas_Movs__Empregado3__Hist__Linhas_Movs__Empregado3___Designação_Empregado_"; "Hist. Linhas Movs. Empregado3"."Designação Empregado")
                    {
                    }
                    column(TabConfContab__Currency_Text__Control1101490021; TabConfContab."LCY Code")
                    {
                    }
                    column(AcumuladoIRS_Control1102056006; AcumuladoIRS)
                    {
                    }
                    column(ABS_DescontadoIRS__Control1102056008; Abs(DescontadoIRS))
                    {
                    }
                    column(varPagamento_Control1102056011; varPagamento)
                    {
                    }
                    column(Total_a_ReceberCaption_Control1101490048; Total_a_ReceberCaption_Control1101490048Lbl)
                    {
                    }
                    column(Acumulado_IRS_Caption_Control1102056002; Acumulado_IRS_Caption_Control1102056002Lbl)
                    {
                    }
                    column(Cativo_Caption_Control1102056007; Cativo_Caption_Control1102056007Lbl)
                    {
                    }
                    column(Descontado_Caption_Control1102056009; Descontado_Caption_Control1102056009Lbl)
                    {
                    }
                    column(Processado_por_ComputadorCaption_Control1102056018; Processado_por_ComputadorCaption_Control1102056018Lbl)
                    {
                    }
                    column("Declaro_que_nada_mais_me_é_devido_até_à_presente_data_Caption_Control1102056014"; Declaro_que_nada_mais_me_é_devido_até_à_presente_data_Caption_Control1102056014Lbl)
                    {
                    }
                    column("Hist__Linhas_Movs__Empregado3_Cód__Processamento"; "Cód. Processamento")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado3_Tipo_Processamento; "Tipo Processamento")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado3_N__Empregado; "No. Empregado")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado3_N__Linha; "No. Linha")
                    {
                    }
                    column(NumHLME3; NumHLME3)
                    {
                    }
                    column(CountHLME3; CountHLME3)
                    {
                    }
                    column(lastLine3; lastLine3)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        NumHLME3 := NumHLME3 + 1;
                        HLME3Valor := HLME3Valor + Valor;
                        CountHLME3 := Round("Hist. Linhas Movs. Empregado3".Count / 2, 1);
                        if "Linhas Movs. Empregado3".Next = 0 then
                            lastLine3 := true;
                    end;

                    trigger OnPreDataItem()
                    begin
                        if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then
                            CurrReport.Skip
                        else
                            "Hist. Linhas Movs. Empregado3".SetRange(
                            "Hist. Linhas Movs. Empregado3"."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                        //27.04.2006 - IRS Descontado até ao momento
                        TabHistLinhasMov2.Reset;
                        TabHistLinhasMov2.SetRange(TabHistLinhasMov2."No. Empregado", Empregado."No.");
                        TabHistLinhasMov2.SetFilter(TabHistLinhasMov2."Tipo Processamento", '<>%1', TabHistLinhasMov2."Tipo Processamento"::Encargos);
                        TabHistLinhasMov2.SetRange(TabHistLinhasMov2."Data Registo",
                                                   DMY2Date(1, 1, Date2DMY("Periodos Processamento"."Data Registo", 3)),
                                                   "Periodos Processamento"."Data Fim Processamento");
                        if TabHistLinhasMov2.FindSet then begin
                            repeat
                                TabRubrica2.Reset;
                                TabRubrica2.SetRange(TabRubrica2.Código, TabHistLinhasMov2."Cód. Rubrica");
                                if TabRubrica2.Find('-') then begin
                                    if (TabRubrica2.Genero = TabRubrica2.Genero::IRS) or
                                       (TabRubrica2.Genero = TabRubrica2.Genero::"IRS Sub. Férias") or
                                       (TabRubrica2.Genero = TabRubrica2.Genero::"IRS Sub. Natal") then
                                        DescontadoIRS := DescontadoIRS + TabHistLinhasMov2.Valor;
                                end;
                            until TabHistLinhasMov2.Next = 0;
                        end;

                        TabLinhasMov2.Reset;
                        TabLinhasMov2.SetRange(TabLinhasMov2."No. Empregado", Empregado."No.");
                        TabLinhasMov2.SetFilter(TabLinhasMov2."Tipo Processamento", '<>%1', TabLinhasMov2."Tipo Processamento"::Encargos);
                        TabLinhasMov2.SetRange(TabLinhasMov2."Data Registo",
                                                   DMY2Date(1, 1, Date2DMY("Periodos Processamento"."Data Registo", 3)),
                                                   "Periodos Processamento"."Data Fim Processamento");
                        if TabLinhasMov2.FindSet then begin
                            repeat
                                TabRubrica2.Reset;
                                TabRubrica2.SetRange(TabRubrica2.Código, TabLinhasMov2."Cód. Rubrica");
                                if TabRubrica2.Find('-') then begin
                                    if (TabRubrica2.Genero = TabRubrica2.Genero::IRS) or
                                       (TabRubrica2.Genero = TabRubrica2.Genero::"IRS Sub. Férias") or
                                       (TabRubrica2.Genero = TabRubrica2.Genero::"IRS Sub. Natal") then
                                        DescontadoIRS := DescontadoIRS + TabLinhasMov2.Valor;
                                end;
                            until TabLinhasMov2.Next = 0;
                        end;

                        //27.04.2006 - Cativo - Base de Icidência de IRS

                        TabHistLinhasMov2.Reset;
                        TabHistLinhasMov2.SetRange(TabHistLinhasMov2."No. Empregado", Empregado."No.");
                        TabHistLinhasMov2.SetFilter(TabHistLinhasMov2."Tipo Processamento", '<>%1', TabHistLinhasMov2."Tipo Processamento"::Encargos);
                        TabHistLinhasMov2.SetRange(TabHistLinhasMov2."Data Registo",
                                                   DMY2Date(1, 1, Date2DMY("Periodos Processamento"."Data Registo", 3)),
                                                   "Periodos Processamento"."Data Fim Processamento");
                        if TabHistLinhasMov2.FindSet then begin
                            repeat
                                Flag := false;//14.06.2007
                                TabRubrica2.Reset;
                                TabRubrica2.SetFilter(TabRubrica2.Genero, '%1|%2|%3', TabRubrica2.Genero::IRS, TabRubrica2.Genero::"IRS Sub. Férias",
                                                      TabRubrica2.Genero::"IRS Sub. Natal");
                                if TabRubrica2.Find('-') then
                                    repeat
                                        TabRubricaLinha2.Reset;
                                        //TabRubricalinha2.COPYFILTER(TabRubricaLinha2."Cód. Rubrica",TabRubrica2.Código);
                                        TabRubricaLinha2.SetRange(TabRubricaLinha2."Cód. Rubrica", TabRubrica2.Código);
                                        TabRubricaLinha2.SetRange(TabRubricaLinha2."Cód. Rubrica Filha", TabHistLinhasMov2."Cód. Rubrica");
                                        if TabRubricaLinha2.Find('-') then begin
                                            AcumuladoIRS := AcumuladoIRS +
                                                        ((TabHistLinhasMov2.Valor - TabHistLinhasMov2.Quantidade * TabRubricaLinha2."Valor Limite Máximo")
                                                        * (TabRubricaLinha2.Percentagem / 100));
                                            Flag := true;
                                        end;
                                    until (TabRubrica2.Next = 0) or (Flag = true);
                            until TabHistLinhasMov2.Next = 0;
                        end;

                        TabLinhasMov2.Reset;
                        TabLinhasMov2.SetRange(TabLinhasMov2."No. Empregado", Empregado."No.");
                        TabLinhasMov2.SetFilter(TabLinhasMov2."Tipo Processamento", '<>%1', TabLinhasMov2."Tipo Processamento"::Encargos);
                        TabLinhasMov2.SetRange(TabLinhasMov2."Data Registo",
                                                   DMY2Date(1, 1, Date2DMY("Periodos Processamento"."Data Registo", 3)),
                                                   "Periodos Processamento"."Data Fim Processamento");
                        if TabLinhasMov2.FindSet then begin
                            repeat
                                Flag := false;
                                TabRubrica2.Reset;
                                TabRubrica2.SetFilter(TabRubrica2.Genero, '%1|%2|%3', TabRubrica2.Genero::IRS, TabRubrica2.Genero::"IRS Sub. Férias",
                                                      TabRubrica2.Genero::"IRS Sub. Natal");
                                if TabRubrica2.FindSet then
                                    repeat
                                        TabRubricaLinha2.Reset;
                                        TabRubricaLinha2.SetRange(TabRubricaLinha2."Cód. Rubrica", TabRubrica2.Código);
                                        TabRubricaLinha2.SetRange(TabRubricaLinha2."Cód. Rubrica Filha", TabLinhasMov2."Cód. Rubrica");
                                        if TabRubricaLinha2.Find('-') then begin
                                            AcumuladoIRS := AcumuladoIRS +
                                                          ((TabLinhasMov2.Valor - TabLinhasMov2.Quantidade * TabRubricaLinha2."Valor Limite Máximo")
                                                         * (TabRubricaLinha2.Percentagem / 100));
                                            Flag := true;
                                        end;
                                    until (TabRubrica2.Next = 0) or (Flag = true);
                            until TabLinhasMov2.Next = 0;
                        end;

                        NumHLME3 := 0;
                        HLME3Valor := 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if Integer2.Number = 1 then
                        VarOrigiDuplicado := 'Original';
                    if Integer2.Number = 2 then begin
                        VarOrigiDuplicado := 'Duplicado';
                        Clear(DescontadoIRS);
                        Clear(AcumuladoIRS);
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            var
                RubSal: Record "Rubrica Salarial";
                RubSalEmp: Record "Rubrica Salarial Empregado";
            begin
                Clear(DescontadoIRS);
                Clear(AcumuladoIRS);

                //como a propriedade PrintIfDetail não está a funcionar tive de fazer este
                //código para que não apareçam recibos sem dados
                TabLinhasMov.Reset;
                TabLinhasMov.SetRange(TabLinhasMov."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                TabLinhasMov.SetRange(TabLinhasMov."Tipo Processamento", "Periodos Processamento"."Tipo Processamento");
                TabLinhasMov.SetRange(TabLinhasMov."No. Empregado", Empregado."No.");
                if not TabLinhasMov.FindFirst then begin
                    TabHistLinhasMov.Reset;
                    TabHistLinhasMov.SetRange(TabHistLinhasMov."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                    TabHistLinhasMov.SetRange(TabHistLinhasMov."Tipo Processamento", "Periodos Processamento"."Tipo Processamento");
                    TabHistLinhasMov.SetRange(TabHistLinhasMov."No. Empregado", Empregado."No.");
                    if not TabHistLinhasMov.FindFirst then
                        CurrReport.Skip;
                end;

                numlinhas := 0;

                //2008.05.04 - Ir buscar os dados do recibo ao processamento
                if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then begin
                    TabCabMovEmp.Reset;
                    TabCabMovEmp.SetRange(TabCabMovEmp."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                    TabCabMovEmp.SetRange(TabCabMovEmp."Tipo Processamento", "Periodos Processamento"."Tipo Processamento");
                    TabCabMovEmp.SetRange(TabCabMovEmp."No. Empregado", Empregado."No.");
                    if TabCabMovEmp.FindFirst then begin
                        CabNEmp := TabCabMovEmp."No. Empregado";
                        CabNome := TabCabMovEmp."Designação Empregado";
                        CabApolice := TabCabMovEmp."No. Apólice";
                        CabSeguradora := TabCabMovEmp.Seguradora;
                        CabNsegSocial := TabCabMovEmp."No. Segurança Social";
                        CabNContribuinte := TabCabMovEmp."No. Contribuinte";
                        CabNNIB := TabCabMovEmp.IBAN;
                        CabNCGA := TabCabMovEmp."Nº CGA";
                        CabNHorasSeman := TabCabMovEmp."No. Horas Semanais";
                        //Tagus,sn
                        //txtCatProfEmp := TabCabMovEmp."Descrição Cat Prof QP";
                        txtCatProfEmp := Empregado."Job Title";
                        //Tagus,en
                        txtGrauEmp := TabCabMovEmp."Grau Função";
                        varVencimentoBase := TabCabMovEmp."Valor Vencimento Base";
                        varValorHora := TabCabMovEmp."Valor Hora";
                        if TabCabMovEmp."Usa Transferência Bancária" then
                            varPagamento := Text002
                        else
                            varPagamento := Text001;
                    end;
                end else begin
                    TabHistCabMovEmp.Reset;
                    TabHistCabMovEmp.SetRange(TabHistCabMovEmp."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                    TabHistCabMovEmp.SetRange(TabHistCabMovEmp."Tipo Processamento", "Periodos Processamento"."Tipo Processamento");
                    TabHistCabMovEmp.SetRange(TabHistCabMovEmp."No. Empregado", Empregado."No.");
                    if TabHistCabMovEmp.Find('-') then begin
                        CabNEmp := TabHistCabMovEmp."No. Empregado";
                        CabNome := TabHistCabMovEmp."Designação Empregado";
                        CabApolice := TabHistCabMovEmp."No. Apólice";
                        CabSeguradora := TabHistCabMovEmp.Seguradora;
                        CabNsegSocial := TabHistCabMovEmp."No. Segurança Social";
                        CabNContribuinte := TabHistCabMovEmp."No. Contribuinte";
                        CabNNIB := TabHistCabMovEmp.IBAN;
                        CabNCGA := TabHistCabMovEmp."Nº CGA";
                        if TabConfRH."Valor Cálculo Ausências" = TabConfRH."Valor Cálculo Ausências"::"Valor Hora Lectiva" then
                            CabNHorasSeman := TabHistCabMovEmp."No. Horas Semanais"
                        else
                            CabNHorasSeman := TabHistCabMovEmp."Nº Horas Semanais Totais";
                        //Tagus,sn
                        //txtCatProfEmp := TabHistCabMovEmp."Descrição Cat Prof QP";
                        txtCatProfEmp := Empregado."Job Title";
                        //Tagus,en
                        txtGrauEmp := TabHistCabMovEmp."Grau Função";
                        varVencimentoBase := TabHistCabMovEmp."Valor Vencimento Base";
                        varValorHora := TabHistCabMovEmp."Valor Hora";
                        if TabHistCabMovEmp."Usa Transferência Bancária" then
                            varPagamento := Text002
                        else
                            varPagamento := Text001;
                    end;
                end;
                //2008.05.04 - fim

                //207.07.03 -  No campo VB não quer que apareça o valor dos complementos
                RubSal.SetRange(RubSal."Vencimento Base", true);
                if RubSal.FindFirst then begin
                    RubSalEmp.Reset;
                    RubSalEmp.SetRange(RubSalEmp."Cód. Rúbrica Salarial", RubSal.Código);
                    RubSalEmp.SetRange(RubSalEmp."No. Empregado", Empregado."No.");
                    RubSalEmp.SetFilter(RubSalEmp."Data Fim", '>=%1', "Periodos Processamento"."Data Fim Processamento");
                    RubSalEmp.SetFilter("Data Início", '<=%1', "Periodos Processamento"."Data Fim Processamento"); //IT004, Valor do vencimento não estava correto quando se adicionava uma nova rubrica a alterar o vencimento base com uma data futura
                    if RubSalEmp.FindLast then begin
                        varVencimentoBase := RubSalEmp."Valor Total";
                        varValorHora := varVencimentoBase * 12 / 52 / Empregado."No. Horas Semanais";
                    end;
                end;
                //2011.05
                if Empregado."Tipo Contribuinte" = Empregado."Tipo Contribuinte"::"Trabalhador Independente" then
                    varTitulo := 'RECIBO HONORÁRIOS'
                else
                    varTitulo := 'RECIBO VENCIMENTOS';
            end;

            trigger OnPreDataItem()
            begin
                if TabConfRH.Get then;
                TabLinhasMov.Reset;
                TabLinhasMov.SetRange(TabLinhasMov."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                TabLinhasMov.SetRange(TabLinhasMov."Tipo Processamento", "Periodos Processamento"."Tipo Processamento");
                TabLinhasMov.SetRange(TabLinhasMov."No. Empregado", Empregado."No.");
                if not TabLinhasMov.FindFirst then begin
                    TabHistLinhasMov.Reset;
                    TabHistLinhasMov.SetRange(TabHistLinhasMov."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                    TabHistLinhasMov.SetRange(TabHistLinhasMov."Tipo Processamento", "Periodos Processamento"."Tipo Processamento");
                    TabHistLinhasMov.SetRange(TabHistLinhasMov."No. Empregado", Empregado."No.");
                    if not TabHistLinhasMov.Find('-') then begin
                        //TODO: change this to RDLC HIDDEN
                        //CurrReport.ShowOutput(false);
                    end;
                end;
            end;
        }
        dataitem(pict; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            column(pictpic; TabConfEmpresa.Picture)
            {
            }

            trigger OnAfterGetRecord()
            begin
                TabConfEmpresa.CalcFields(Picture);
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
                group("Periodos Processamento")
                {
                    Caption = 'Periodos Processamento';
                    field(CodProcess; CodProcess)
                    {
                        ApplicationArea = All;
                        Caption = 'Cód. Processamento';
                        TableRelation = "Periodos Processamento";
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

    trigger OnPreReport()
    begin
        TabConfContab.Get();
        TabConfEmpresa.Get;

        VarProvisorio := '';
    end;

    var
        TabRubrica: Record "Rubrica Salarial";
        TabConfRH: Record "Config. Recursos Humanos";
        VarQuantidade: Text[30];
        VarOrigiDuplicado: Text[30];
        TabLinhasMov: Record "Linhas Movs. Empregado";
        TabHistLinhasMov: Record "Hist. Linhas Movs. Empregado";
        TabConfEmpresa: Record "Company Information";
        TabConfContab: Record "General Ledger Setup";
        DescontadoIRS: Decimal;
        AcumuladoIRS: Decimal;
        TabHistLinhasMov2: Record "Hist. Linhas Movs. Empregado";
        TabLinhasMov2: Record "Linhas Movs. Empregado";
        TabRubrica2: Record "Rubrica Salarial";
        TabRubricaLinha2: Record "Rubrica Salarial Linhas";
        VarProvisorio: Text[30];
        Flag: Boolean;
        numlinhas: Integer;
        CatProfQPEmpregado: Record "Cat. Prof. QP Empregado";
        GrauFuncaoEmpregado: Record "Grau Função Empregado";
        txtCatProfEmp: Text[200];
        txtGrauEmp: Text[20];
        varVencimentoBase: Decimal;
        varValorHora: Decimal;
        FuncoesRH: Codeunit "Funções RH";
        TabCabMovEmp: Record "Cab. Movs. Empregado";
        TabHistCabMovEmp: Record "Hist. Cab. Movs. Empregado";
        varPagamento: Text[50];
        Text001: Label 'Pago por Cheque/Numerário';
        Text002: Label 'Pago por Transferência Bancária';
        CabNEmp: Code[20];
        CabNome: Text[250];
        CabApolice: Text[20];
        CabSeguradora: Text[60];
        CabNsegSocial: Text[11];
        CabNContribuinte: Text[9];
        CabNNIB: Text[50];
        CabNCGA: Text[11];
        CabNHorasSeman: Decimal;
        varSubFerNat: Text[30];
        varTitulo: Text[30];
        AbonosCaptionLbl: Label 'Abonos';
        "MÊSCaptionLbl": Label 'MÊS';
        CategoriaCaptionLbl: Label 'Categoria';
        N__ContribuinteCaptionLbl: Label 'Nº Contribuinte';
        NomeCaptionLbl: Label 'Nome';
        N_CaptionLbl: Label 'Nº';
        "N__Segurança_SocialCaptionLbl": Label 'Nº Segurança Social';
        Vencimento_BaseCaptionLbl: Label 'Vencimento Base';
        Valor_HoraCaptionLbl: Label 'Valor Hora';
        "ApóliceCaptionLbl": Label 'Apólice';
        NIBCaptionLbl: Label 'IBAN';
        N__CGACaptionLbl: Label 'Nº CGA';
        N__Horas_SemanaisCaptionLbl: Label 'Nº Horas Semanais';
        "Nível_SalarialCaptionLbl": Label 'Nível Salarial';
        Total_AbonosCaptionLbl: Label 'Total Abonos';
        DescontosCaptionLbl: Label 'Descontos';
        Total_DescontosCaptionLbl: Label 'Total Descontos';
        Total_a_ReceberCaptionLbl: Label 'Total a Receber';
        Acumulado_IRS_CaptionLbl: Label 'Acumulado IRS:';
        Cativo_CaptionLbl: Label 'Cativo:';
        Descontado_CaptionLbl: Label 'Descontado:';
        Processado_por_ComputadorCaptionLbl: Label 'Processado por Computador';
        "Declaro_que_nada_mais_me_é_devido_até_à_presente_data_CaptionLbl": Label 'Declaro que nada mais me é devido até à presente data.';
        Total_AbonosCaption_Control1101490035Lbl: Label 'Total Abonos';
        DescontosCaption_Control1101490037Lbl: Label 'Descontos';
        Total_DescontosCaption_Control1101490044Lbl: Label 'Total Descontos';
        Total_a_ReceberCaption_Control1101490048Lbl: Label 'Total a Receber';
        Acumulado_IRS_Caption_Control1102056002Lbl: Label 'Acumulado IRS:';
        Cativo_Caption_Control1102056007Lbl: Label 'Cativo:';
        Descontado_Caption_Control1102056009Lbl: Label 'Descontado:';
        Processado_por_ComputadorCaption_Control1102056018Lbl: Label 'Processado por Computador';
        "Declaro_que_nada_mais_me_é_devido_até_à_presente_data_Caption_Control1102056014Lbl": Label 'Declaro que nada mais me é devido até à presente data.';
        NumLME3: Integer;
        CountLME3: Integer;
        NumHLME3: Integer;
        CountHLME3: Integer;
        LME3Valor: Decimal;
        HLME3Valor: Decimal;
        CodProcess: Code[10];
        lastLine: Boolean;
        lastLine3: Boolean;
}

