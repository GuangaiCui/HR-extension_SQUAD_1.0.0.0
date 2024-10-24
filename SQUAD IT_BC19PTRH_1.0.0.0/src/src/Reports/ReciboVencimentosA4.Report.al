report 53082 "Recibo Vencimentos A4"
{
    // //-------------------------------------------------------
    //               Recibo de Vencimentos
    // //--------------------------------------------------------
    //   Este é o report a ser entregue ao empregado mensalmente
    //   como recibo do sua remuneração.
    // //-------------------------------------------------------
    // 
    // Tagus - querem o cargo em vez da cat prof
    // SQD001 - 20200102 - alterações layout
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\ReciboVencimentosA4.rdl';

    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1));
            dataitem("Periodos Processamento"; "Periodos Processamento")
            {
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento") WHERE("Tipo Processamento" = FILTER(<> Encargos));
                PrintOnlyIfDetail = true;

                trigger OnAfterGetRecord()
                begin
                    //17.04.07 - Se o processamento não está fechado tem de aparecer no mapa a indicação de que este é provisório
                    if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then
                        VarProvisorio := ProvisoryTxt
                    else
                        VarProvisorio := '';

                    if "Periodos Processamento"."Tipo Processamento" = "Periodos Processamento"."Tipo Processamento"::Vencimentos then
                        varSubFerNat := ''
                    else
                        varSubFerNat := ' - ' + Format("Periodos Processamento"."Tipo Processamento");
                end;

                trigger OnPreDataItem()
                begin
                    if ProcCode <> '' then
                        SetFilter("Cód. Processamento", ProcCode)
                    else
                        SetFilter("Cód. Processamento", CodProcess);
                end;
            }
            dataitem(Empregado; Empregado)
            {
                PrintOnlyIfDetail = true;
                RequestFilterFields = "No.";
                column(Estado; "Periodos Processamento".Estado)
                {
                }
                column(Number; Integer.Number)
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
                column(TabConfEmpresa_Picture; TabConfEmpresa.Picture)
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
                column(N_Caption_Control1101490005; N_Caption_Control1101490005Lbl)
                {
                }
                column(SeguradoraCaption; SeguradoraCaptionLbl)
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
                column(Empregado_No_; "No.")
                {
                }
                column(DescontosCaption; DescontosCaptionLbl)
                {
                }
                column(Total_AbonosCaption; Total_AbonosCaptionLbl)
                {
                }
                column(Total_DescontosCaption; Total_DescontosCaptionLbl)
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
                column(TabConfContab__Currency_Text_; TabConfContab."LCY Code")
                {
                }
                dataitem("Linhas Movs. Empregado1"; "Linhas Movs. Empregado")
                {
                    DataItemLink = "Employee No." = FIELD("No.");
                    DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "Employee No.", "No. Linha") WHERE("Tipo Processamento" = FILTER(<> Encargos), "Payroll Item Type" = CONST(Abono));
                    column("Linhas_Movs__Empregado1__Descrição_Rubrica_"; "Payroll Item Description")
                    {
                    }
                    column(Linhas_Movs__Empregado1_Valor; Valor)
                    {
                    }
                    column(Linhas_Movs__Empregado1_Quantidade; Quantity)
                    {
                    }
                    column(Linhas_Movs__Empregado1_UnidadeMedida; "Unit of Measure")
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
                    column(Linhas_Movs__Empregado1_N__Empregado; "Employee No.")
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
                    DataItemLink = "Employee No." = FIELD("No.");
                    DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "Employee No.", "No. Linha") WHERE("Tipo Processamento" = FILTER(<> Encargos), "Payroll Item Type" = CONST(Desconto));
                    column(Linhas_Movs__Empregado2_Valor; Valor)
                    {
                    }
                    column(VarQuantidade; VarQuantidade)
                    {
                    }
                    column("Linhas_Movs__Empregado2__Descrição_Rubrica_"; "Payroll Item Description")
                    {
                    }
                    column(Linhas_Movs__Empregado2_UnidadeMedida; "Unit of Measure")
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
                    column(Linhas_Movs__Empregado2_N__Empregado; "Employee No.")
                    {
                    }
                    column(Linhas_Movs__Empregado2_N__Linha; "No. Linha")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        VarQuantidade := Format("Linhas Movs. Empregado2".Quantity);

                        //Para aparecer % na quantidade quando é irs ou seg. social
                        //----------------------------------------------------------
                        TabRubrica.Reset;
                        TabRubrica.SetRange(TabRubrica.Código, "Linhas Movs. Empregado2"."Payroll Item Code");
                        if TabRubrica.FindFirst then begin
                            if (TabRubrica.Genero = TabRubrica.Genero::IRS) or
                               (TabRubrica.Genero = TabRubrica.Genero::SS) or
                               (TabRubrica.Genero = TabRubrica.Genero::IVA) or
                               (TabRubrica.Genero = TabRubrica.Genero::CGA) or
                               (TabRubrica.Genero = TabRubrica.Genero::"IRS Sub. Férias") or
                               (TabRubrica.Genero = TabRubrica.Genero::"IRS Sub. Natal") or
                               (TabRubrica.Genero = TabRubrica.Genero::ADSE) or
                               (TabRubrica.Genero = TabRubrica.Genero::Sindicato) then begin
                                VarQuantidade := Format("Linhas Movs. Empregado2".Quantity) + '%';
                                //2011.11.09 - por causa do imposto extraordinário
                                if TabRubrica."Imposto Extraordinário" then
                                    VarQuantidade := '';
                            end;
                            //2008.01.10 - este código é para faltas aparecerem no recido em dias ou horas consoante o que foi lançado
                            if TabRubrica.Genero = TabRubrica.Genero::Falta then
                                VarQuantidade := Format("Linhas Movs. Empregado2"."Quatidade Recibo Vencimentos");
                        end;
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
                    DataItemLink = "Employee No." = FIELD("No.");
                    DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "Employee No.", "No. Linha") WHERE("Tipo Processamento" = FILTER(<> Encargos));
                    column(Linhas_Movs__Empregado3_Valor; Valor)
                    {
                    }
                    column("Linhas_Movs__Empregado3__Linhas_Movs__Empregado3___Designação_Empregado_"; "Linhas Movs. Empregado3"."Designação Empregado")
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
                    column("Linhas_Movs__Empregado3_Cód__Processamento"; "Cód. Processamento")
                    {
                    }
                    column(Linhas_Movs__Empregado3_Tipo_Processamento; "Tipo Processamento")
                    {
                    }
                    column(Linhas_Movs__Empregado3_N__Empregado; "Employee No.")
                    {
                    }
                    column(Linhas_Movs__Empregado3_N__Linha; "No. Linha")
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Fechado then
                            CurrReport.Skip
                        else
                            "Linhas Movs. Empregado3".SetRange("Linhas Movs. Empregado3"."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");

                        //27.04.2006 - IRS Descontado até ao momento
                        TabHistLinhasMov2.Reset;
                        TabHistLinhasMov2.SetRange(TabHistLinhasMov2."Employee No.", Empregado."No.");
                        TabHistLinhasMov2.SetFilter(TabHistLinhasMov2."Tipo Processamento", '<>%1', TabHistLinhasMov2."Tipo Processamento"::Encargos);
                        TabHistLinhasMov2.SetRange(TabHistLinhasMov2."Data Registo", DMY2Date(1, 1, Date2DMY("Periodos Processamento"."Data Registo", 3)), "Periodos Processamento"."Data Fim Processamento");
                        if TabHistLinhasMov2.FindSet then begin
                            repeat
                                TabRubrica2.Reset;
                                TabRubrica2.SetRange(TabRubrica2.Código, TabHistLinhasMov2."Payroll Item Code");
                                if TabRubrica2.Find('-') then begin
                                    if (TabRubrica2.Genero = TabRubrica2.Genero::IRS) or
                                        (TabRubrica2.Genero = TabRubrica2.Genero::"IRS Sub. Férias") or
                                        (TabRubrica2.Genero = TabRubrica2.Genero::"IRS Sub. Natal") then
                                        DescontadoIRS := DescontadoIRS + TabHistLinhasMov2.Valor;
                                end;
                            until TabHistLinhasMov2.Next = 0;
                        end;

                        TabLinhasMov2.Reset;
                        TabLinhasMov2.SetRange(TabLinhasMov2."Employee No.", Empregado."No.");
                        TabLinhasMov2.SetFilter(TabLinhasMov2."Tipo Processamento", '<>%1', TabLinhasMov2."Tipo Processamento"::Encargos);
                        TabLinhasMov2.SetRange(TabLinhasMov2."Data Registo", DMY2Date(1, 1, Date2DMY("Periodos Processamento"."Data Registo", 3)), "Periodos Processamento"."Data Fim Processamento");
                        if TabLinhasMov2.FindSet then begin
                            repeat
                                TabRubrica2.Reset;
                                TabRubrica2.SetRange(TabRubrica2.Código, TabLinhasMov2."Payroll Item Code");
                                if TabRubrica2.FindFirst then begin
                                    if (TabRubrica2.Genero = TabRubrica2.Genero::IRS) or
                                        (TabRubrica2.Genero = TabRubrica2.Genero::"IRS Sub. Férias") or
                                        (TabRubrica2.Genero = TabRubrica2.Genero::"IRS Sub. Natal") then
                                        DescontadoIRS := DescontadoIRS + TabLinhasMov2.Valor;
                                end;
                            until TabLinhasMov2.Next = 0;
                        end;
                        //27.04.2006 - Cativo - Base de Icidência de IRS
                        TabHistLinhasMov2.Reset;
                        TabHistLinhasMov2.SetRange(TabHistLinhasMov2."Employee No.", Empregado."No.");
                        TabHistLinhasMov2.SetFilter(TabHistLinhasMov2."Tipo Processamento", '<>%1', TabHistLinhasMov2."Tipo Processamento"::Encargos);
                        TabHistLinhasMov2.SetRange(TabHistLinhasMov2."Data Registo", DMY2Date(1, 1, Date2DMY("Periodos Processamento"."Data Registo", 3)), "Periodos Processamento"."Data Fim Processamento");
                        if TabHistLinhasMov2.FindSet then begin
                            repeat
                                Flag := false;
                                TabRubrica2.Reset;
                                TabRubrica2.SetFilter(TabRubrica2.Genero, '%1|%2|%3', TabRubrica2.Genero::IRS, TabRubrica2.Genero::"IRS Sub. Férias", TabRubrica2.Genero::"IRS Sub. Natal");
                                if TabRubrica2.FindSet then
                                    repeat
                                        TabRubricaLinha2.Reset;
                                        TabRubricaLinha2.SetRange(TabRubricaLinha2."Payroll Item Code", TabRubrica2.Código);
                                        TabRubricaLinha2.SetRange(TabRubricaLinha2."Cód. Rubrica Filha", TabHistLinhasMov2."Payroll Item Code");
                                        if TabRubricaLinha2.FindFirst then begin
                                            AcumuladoIRS := AcumuladoIRS +
                                                          ((TabHistLinhasMov2.Valor - TabHistLinhasMov2.Quantity * TabRubricaLinha2."Valor Limite Máximo")
                                                          * (TabRubricaLinha2.Percentagem / 100));
                                            Flag := true;
                                        end;
                                    until (TabRubrica2.Next = 0) or (Flag);
                            until TabHistLinhasMov2.Next = 0;
                        end;

                        TabLinhasMov2.Reset;
                        TabLinhasMov2.SetRange(TabLinhasMov2."Employee No.", Empregado."No.");
                        TabLinhasMov2.SetFilter(TabLinhasMov2."Tipo Processamento", '<>%1', TabLinhasMov2."Tipo Processamento"::Encargos);
                        TabLinhasMov2.SetRange(TabLinhasMov2."Data Registo", DMY2Date(1, 1, Date2DMY("Periodos Processamento"."Data Registo", 3)), "Periodos Processamento"."Data Fim Processamento");
                        if TabLinhasMov2.FindSet then begin
                            repeat
                                Flag := false;
                                TabRubrica2.Reset;
                                TabRubrica2.SetFilter(TabRubrica2.Genero, '%1|%2|%3', TabRubrica2.Genero::IRS, TabRubrica2.Genero::"IRS Sub. Férias", TabRubrica2.Genero::"IRS Sub. Natal");
                                if TabRubrica2.FindSet then
                                    repeat
                                        TabRubricaLinha2.Reset;
                                        TabRubricaLinha2.SetRange(TabRubricaLinha2."Payroll Item Code", TabRubrica2.Código);
                                        TabRubricaLinha2.SetRange(TabRubricaLinha2."Cód. Rubrica Filha", TabLinhasMov2."Payroll Item Code");
                                        if TabRubricaLinha2.FindFirst then begin
                                            AcumuladoIRS := AcumuladoIRS +
                                                        ((TabLinhasMov2.Valor - TabLinhasMov2.Quantity * TabRubricaLinha2."Valor Limite Máximo")
                                                        * (TabRubricaLinha2.Percentagem / 100));
                                            Flag := true;
                                        end;
                                    until (TabRubrica2.Next = 0) or (Flag);
                            until TabLinhasMov2.Next = 0;
                        end;
                    end;
                }
                dataitem("Hist. Linhas Movs. Empregado1"; "Hist. Linhas Movs. Empregado")
                {
                    DataItemLink = "Employee No." = FIELD("No.");
                    DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "Employee No.", "No. Linha") WHERE("Tipo Processamento" = FILTER(<> Encargos), "Payroll Item Type" = CONST(Abono));
                    column(Hist__Linhas_Movs__Empregado1_Valor; Valor)
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado1_Quantidade; Quantity)
                    {
                    }
                    column("Hist__Linhas_Movs__Empregado1__Descrição_Rubrica_"; "Payroll Item Description")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado1_UnidadeMedida; "Unit of Measure")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado1_Valor_Control1101490033; Valor)
                    {
                    }
                    column(Total_AbonosCaption_Control1101490035; Total_AbonosCaption_Control1101490035Lbl)
                    {
                    }
                    column("Hist__Linhas_Movs__Empregado1_Cód__Processamento"; "Cód. Processamento")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado1_Tipo_Processamento; "Tipo Processamento")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado1_N__Empregado; "Employee No.")
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
                            "Hist. Linhas Movs. Empregado1".SetRange("Hist. Linhas Movs. Empregado1"."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                    end;
                }
                dataitem("Hist. Linhas Movs. Empregado2"; "Hist. Linhas Movs. Empregado")
                {
                    DataItemLink = "Employee No." = FIELD("No.");
                    DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "Employee No.", "No. Linha") WHERE("Tipo Processamento" = FILTER(<> Encargos), "Payroll Item Type" = CONST(Desconto));
                    column(Hist__Linhas_Movs__Empregado2_Valor; Valor)
                    {
                    }
                    column(VarQuantidade_Control1101490039; VarQuantidade)
                    {
                    }
                    column("Hist__Linhas_Movs__Empregado2__Descrição_Rubrica_"; "Payroll Item Description")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado2_UnidadeMedida; "Unit of Measure")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado2_Valor_Control1101490043; Valor)
                    {
                    }
                    column(DescontosCaption_Control1101490037; DescontosCaption_Control1101490037Lbl)
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
                    column(Hist__Linhas_Movs__Empregado2_N__Empregado; "Employee No.")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado2_N__Linha; "No. Linha")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        VarQuantidade := Format("Hist. Linhas Movs. Empregado2".Quantity);

                        //Para aparecer % na quantidade quando é irs ou seg. social
                        //----------------------------------------------------------
                        TabRubrica.Reset;
                        TabRubrica.SetRange(TabRubrica.Código, "Hist. Linhas Movs. Empregado2"."Payroll Item Code");
                        if TabRubrica.FindFirst then begin
                            if (TabRubrica.Genero = TabRubrica.Genero::IRS) or
                                (TabRubrica.Genero = TabRubrica.Genero::SS) or
                                (TabRubrica.Genero = TabRubrica.Genero::IVA) or
                                (TabRubrica.Genero = TabRubrica.Genero::CGA) or
                                (TabRubrica.Genero = TabRubrica.Genero::"IRS Sub. Férias") or
                                (TabRubrica.Genero = TabRubrica.Genero::"IRS Sub. Natal") or
                                (TabRubrica.Genero = TabRubrica.Genero::ADSE) or
                                (TabRubrica.Genero = TabRubrica.Genero::Sindicato) then begin
                                VarQuantidade := Format("Hist. Linhas Movs. Empregado2".Quantity) + '%';
                                //2011.11.09 - por causa do imposto extraordinário
                                if TabRubrica."Imposto Extraordinário" then
                                    VarQuantidade := '';
                            end;
                            //2008.01.10 - este código é para faltas aparecerem no recido em dias ou horas consoante o que foi lançado
                            if TabRubrica.Genero = TabRubrica.Genero::Falta then
                                VarQuantidade := Format("Hist. Linhas Movs. Empregado2"."Quatidade Recibo Vencimentos");
                        end;
                    end;

                    trigger OnPreDataItem()
                    begin
                        if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then
                            CurrReport.Skip
                        else
                            "Hist. Linhas Movs. Empregado2".SetRange(
                            "Hist. Linhas Movs. Empregado2"."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                    end;
                }
                dataitem("Hist. Linhas Movs. Empregado3"; "Hist. Linhas Movs. Empregado")
                {
                    DataItemLink = "Employee No." = FIELD("No.");
                    DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "Employee No.", "No. Linha") WHERE("Tipo Processamento" = FILTER(<> Encargos));
                    column(Hist__Linhas_Movs__Empregado3_Valor; Valor)
                    {
                    }
                    column("Hist__Linhas_Movs__Empregado3__Hist__Linhas_Movs__Empregado3___Designação_Empregado_"; "Hist. Linhas Movs. Empregado3"."Designação Empregado")
                    {
                    }
                    column(AcumuladoIRS_Control1102056006; AcumuladoIRS)
                    {
                    }
                    column(ABS_DescontadoIRS__Control1102056008; Abs(DescontadoIRS))
                    {
                    }
                    column(varPagamento_Control1102056025; varPagamento)
                    {
                    }
                    column("Hist__Linhas_Movs__Empregado3_Cód__Processamento"; "Cód. Processamento")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado3_Tipo_Processamento; "Tipo Processamento")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado3_N__Empregado; "Employee No.")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado3_N__Linha; "No. Linha")
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then
                            CurrReport.Skip
                        else
                            "Hist. Linhas Movs. Empregado3".SetRange(
                            "Hist. Linhas Movs. Empregado3"."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");

                        //27.04.2006 - IRS Descontado até ao momento
                        TabHistLinhasMov2.Reset;
                        TabHistLinhasMov2.SetRange(TabHistLinhasMov2."Employee No.", Empregado."No.");
                        TabHistLinhasMov2.SetFilter(TabHistLinhasMov2."Tipo Processamento", '<>%1', TabHistLinhasMov2."Tipo Processamento"::Encargos);
                        TabHistLinhasMov2.SetRange(TabHistLinhasMov2."Data Registo", DMY2Date(1, 1, Date2DMY("Periodos Processamento"."Data Registo", 3)), "Periodos Processamento"."Data Fim Processamento");
                        if TabHistLinhasMov2.FindSet then begin
                            repeat
                                TabRubrica2.Reset;
                                TabRubrica2.SetRange(TabRubrica2.Código, TabHistLinhasMov2."Payroll Item Code");
                                if TabRubrica2.FindFirst then begin
                                    if (TabRubrica2.Genero = TabRubrica2.Genero::IRS) or
                                        (TabRubrica2.Genero = TabRubrica2.Genero::"IRS Sub. Férias") or
                                        (TabRubrica2.Genero = TabRubrica2.Genero::"IRS Sub. Natal") then
                                        DescontadoIRS := DescontadoIRS + TabHistLinhasMov2.Valor;
                                end;
                            until TabHistLinhasMov2.Next = 0;
                        end;

                        TabLinhasMov2.Reset;
                        TabLinhasMov2.SetRange(TabLinhasMov2."Employee No.", Empregado."No.");
                        TabLinhasMov2.SetFilter(TabLinhasMov2."Tipo Processamento", '<>%1', TabLinhasMov2."Tipo Processamento"::Encargos);
                        TabLinhasMov2.SetRange(TabLinhasMov2."Data Registo", DMY2Date(1, 1, Date2DMY("Periodos Processamento"."Data Registo", 3)), "Periodos Processamento"."Data Fim Processamento");
                        if TabLinhasMov2.FindSet then begin
                            repeat
                                TabRubrica2.Reset;
                                TabRubrica2.SetRange(TabRubrica2.Código, TabLinhasMov2."Payroll Item Code");
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
                        TabHistLinhasMov2.SetRange(TabHistLinhasMov2."Employee No.", Empregado."No.");
                        TabHistLinhasMov2.SetFilter(TabHistLinhasMov2."Tipo Processamento", '<>%1', TabHistLinhasMov2."Tipo Processamento"::Encargos);
                        TabHistLinhasMov2.SetRange(TabHistLinhasMov2."Data Registo", DMY2Date(1, 1, Date2DMY("Periodos Processamento"."Data Registo", 3)),
                                                    "Periodos Processamento"."Data Fim Processamento");
                        if TabHistLinhasMov2.FindSet then begin
                            repeat
                                Flag := false;
                                TabRubrica2.Reset;
                                TabRubrica2.SetFilter(TabRubrica2.Genero, '%1|%2|%3', TabRubrica2.Genero::IRS, TabRubrica2.Genero::"IRS Sub. Férias",
                                                      TabRubrica2.Genero::"IRS Sub. Natal");
                                if TabRubrica2.FindSet then
                                    repeat
                                        TabRubricaLinha2.Reset;
                                        TabRubricaLinha2.SetRange(TabRubricaLinha2."Payroll Item Code", TabRubrica2.Código);
                                        TabRubricaLinha2.SetRange(TabRubricaLinha2."Cód. Rubrica Filha", TabHistLinhasMov2."Payroll Item Code");
                                        if TabRubricaLinha2.Find('-') then begin
                                            AcumuladoIRS := AcumuladoIRS +
                                                        ((TabHistLinhasMov2.Valor - TabHistLinhasMov2.Quantity * TabRubricaLinha2."Valor Limite Máximo")
                                                        * (TabRubricaLinha2.Percentagem / 100));
                                            Flag := true;
                                        end;
                                    until (TabRubrica2.Next = 0) or (Flag);
                            until TabHistLinhasMov2.Next = 0;
                        end;

                        TabLinhasMov2.Reset;
                        TabLinhasMov2.SetRange(TabLinhasMov2."Employee No.", Empregado."No.");
                        TabLinhasMov2.SetFilter(TabLinhasMov2."Tipo Processamento", '<>%1', TabLinhasMov2."Tipo Processamento"::Encargos);
                        TabLinhasMov2.SetRange(TabLinhasMov2."Data Registo", DMY2Date(1, 1, Date2DMY("Periodos Processamento"."Data Registo", 3)), "Periodos Processamento"."Data Fim Processamento");
                        if TabLinhasMov2.FindSet then begin
                            repeat
                                Flag := false;
                                TabRubrica2.Reset;
                                TabRubrica2.SetFilter(TabRubrica2.Genero, '%1|%2|%3', TabRubrica2.Genero::IRS, TabRubrica2.Genero::"IRS Sub. Férias", TabRubrica2.Genero::"IRS Sub. Natal");
                                if TabRubrica2.FindSet then
                                    repeat
                                        TabRubricaLinha2.Reset;
                                        TabRubricaLinha2.SetRange(TabRubricaLinha2."Payroll Item Code", TabRubrica2.Código);
                                        TabRubricaLinha2.SetRange(TabRubricaLinha2."Cód. Rubrica Filha", TabLinhasMov2."Payroll Item Code");
                                        if TabRubricaLinha2.Find('-') then begin
                                            AcumuladoIRS := AcumuladoIRS +
                                                          ((TabLinhasMov2.Valor - TabLinhasMov2.Quantity * TabRubricaLinha2."Valor Limite Máximo")
                                                        * (TabRubricaLinha2.Percentagem / 100));
                                            Flag := true;
                                        end;
                                    until (TabRubrica2.Next = 0) or (Flag);
                            until TabLinhasMov2.Next = 0;
                        end;
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    RubSal: Record "Payroll Item";
                    RubSalEmp: Record "Rubrica Salarial Empregado";
                begin
                    Clear(DescontadoIRS);
                    Clear(AcumuladoIRS);

                    //2008.05.04 - Ir buscar os dados do recibo ao processamento
                    if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Aberto then begin
                        TabCabMovEmp.Reset;
                        TabCabMovEmp.SetRange(TabCabMovEmp."Cód. Processamento", "Periodos Processamento"."Cód. Processamento");
                        TabCabMovEmp.SetRange(TabCabMovEmp."Tipo Processamento", "Periodos Processamento"."Tipo Processamento");
                        TabCabMovEmp.SetRange(TabCabMovEmp."Employee No.", Empregado."No.");
                        if TabCabMovEmp.FindSet then begin
                            CabNEmp := TabCabMovEmp."Employee No.";
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
                        TabHistCabMovEmp.SetRange(TabHistCabMovEmp."Employee No.", Empregado."No.");
                        if TabHistCabMovEmp.FindFirst then begin
                            CabNEmp := TabHistCabMovEmp."Employee No.";
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

                    //207.07.03 -  No campo VB não quer que apareça o valor dos complementos
                    RubSal.SetRange(RubSal."Vencimento Base", true);
                    if RubSal.FindFirst then begin
                        RubSalEmp.Reset;
                        RubSalEmp.SetRange(RubSalEmp."Cód. Rúbrica Salarial", RubSal.Código);
                        RubSalEmp.SetRange(RubSalEmp."Employee No.", Empregado."No.");
                        RubSalEmp.SetFilter(RubSalEmp."Data Fim", '>=%1', "Periodos Processamento"."Data Fim Processamento");
                        RubSalEmp.SetFilter("Data Início", '<=%1', "Periodos Processamento"."Data Fim Processamento"); //2017.09.28 - Valor do vencimento não estava correto quando se adicionava uma nova rubrica a alterar o vencimento base com uma data futura.
                        if RubSalEmp.FindLast then begin
                            varVencimentoBase := RubSalEmp."Total Amount";
                            varValorHora := varVencimentoBase * 12 / 52 / Empregado."No. Horas Semanais";
                        end;
                    end;

                    //2011.05
                    if Empregado."Tipo Contribuinte" = Empregado."Tipo Contribuinte"::"Trabalhador Independente" then
                        varTitulo := ReciboHonorTxt
                    else
                        varTitulo := SalaryReceiptTxt;
                end;

                trigger OnPreDataItem()
                begin
                    if TabConfRH.Get() then;

                    if EmployeeNo <> '' then
                        Empregado.SetFilter("No.", EmployeeNo);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if (not CurrReport.UseRequestPage) and (Integer.Number = 2) then
                    CurrReport.Skip;
                if Integer.Number = 1 then
                    VarOrigiDuplicado := OriginalTxt;
                if Integer.Number = 2 then
                    VarOrigiDuplicado := DuplicadoTxt;
            end;
        }
        dataitem(Pict; "Integer")
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

        layout
        {
            area(content)
            {
                group("Recibo Vecimentos")
                {
                    Caption = 'Recibo Vecimentos';
                    field(CodProcess; CodProcess)
                    {
                        ApplicationArea = HumanResourcesAppArea;
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
        TabConfEmpresa.Get;
        TabConfContab.Get();
        VarProvisorio := '';
    end;

    var
        TabRubrica: Record "Payroll Item";
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
        TabRubrica2: Record "Payroll Item";
        TabRubricaLinha2: Record "Rubrica Salarial Linhas";
        VarProvisorio: Text[30];
        Flag: Boolean;
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
        N_Caption_Control1101490005Lbl: Label 'Nº';
        SeguradoraCaptionLbl: Label 'Seguradora';
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
        "Declaro_que_nada_mais_me_é_devido_até_à_presente_data_Caption_Control1102056026Lbl": Label 'Declaro que nada mais me é devido até à presente data.';
        CodProcess: Code[10];
        DataInicio: Date;
        DataFim: Date;
        ProcCode: Code[10];
        EmployeeNo: Code[20];
        OriginalTxt: Label 'Original';
        DuplicadoTxt: Label 'Duplicate';
        ReciboHonorTxt: Label 'HONORARY RECEIPT';
        ProvisoryTxt: Label 'Provisório';
        SalaryReceiptTxt: Label 'SALARIES RECEIPT';


    procedure InitData(pProcCode: Code[10]; pEmployeeNo: Code[20])
    begin
        ProcCode := pProcCode;
        EmployeeNo := pEmployeeNo;
    end;
}

