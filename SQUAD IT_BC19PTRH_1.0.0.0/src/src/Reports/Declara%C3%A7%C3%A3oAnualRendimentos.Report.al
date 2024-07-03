report 31003054 "Declaração Anual Rendimentos"
{
    //  //-------------------------------------------------------
    //            Mapa Declaração Anual de Rendimentos
    //  //--------------------------------------------------------
    //   É um mapa que especifica para cada empregado os rendimentos,
    //   as retenções e as deduções que este teve ao longo do ano anterior.
    //  //-------------------------------------------------------
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/DeclaraçãoAnualRendimentos.rdlc';

    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            DataItemTableView = SORTING("Primary Key");
        }
        dataitem(Empregado; Empregado)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(Empregado_Empregado_Name; Empregado.Name)
            {
            }
            column(Empregado__No__Contribuinte_; "No. Contribuinte")
            {
            }
            column(Empregado_Address; Address)
            {
            }
            column(Company_Information___Address_2_; "Company Information"."Address 2")
            {
            }
            column(Empregado_City; City)
            {
            }
            column(Empregado__Post_Code_; "Post Code")
            {
            }
            column(Company_Information___VAT_Registration_No__; "Company Information"."VAT Registration No.")
            {
            }
            column(Company_Information___Post_Code_; "Company Information"."Post Code")
            {
            }
            column(Company_Information__Address; "Company Information".Address)
            {
            }
            column(Empregado__Address_2_; "Address 2")
            {
            }
            column(Company_Information__Name; "Company Information".Name)
            {
            }
            column(Company_Information__City; "Company Information".City)
            {
            }
            column(varAno; varAno)
            {
            }
            column(Company_Information___Name_2_; "Company Information"."Name 2")
            {
            }
            column(Empregado_Empregado_NameCaption; FieldCaption(Name))
            {
            }
            column(Empregado__No__Contribuinte_Caption; FieldCaption("No. Contribuinte"))
            {
            }
            column(MoradaCaption; MoradaCaptionLbl)
            {
            }
            column("IDENTIFICAÇÃO_DO_TITULAR_DOS_RENDIMENTOSCaption"; IDENTIFICAÇÃO_DO_TITULAR_DOS_RENDIMENTOSCaptionLbl)
            {
            }
            column(V3Caption; V3CaptionLbl)
            {
            }
            column(Empregado_CityCaption; FieldCaption(City))
            {
            }
            column(Empregado__Post_Code_Caption; FieldCaption("Post Code"))
            {
            }
            column(Company_Information___VAT_Registration_No__Caption; "Company Information".FieldCaption("VAT Registration No."))
            {
            }
            column(Company_Information___Post_Code_Caption; "Company Information".FieldCaption("Post Code"))
            {
            }
            column(Company_Information__AddressCaption; "Company Information".FieldCaption(Address))
            {
            }
            column(Company_Information__NameCaption; "Company Information".FieldCaption(Name))
            {
            }
            column(Company_Information__CityCaption; "Company Information".FieldCaption(City))
            {
            }
            column("IDENTIFICAÇÃO_DA_ENTIDADE_PAGADORACaption"; IDENTIFICAÇÃO_DA_ENTIDADE_PAGADORACaptionLbl)
            {
            }
            column(Nota_dos_rendimentos_devidos_e_do_imposto_retido_nos_termos_do_n_1__alinea_b__do_Art__119__do_CIRSCaption; Nota_dos_rendimentos_devidos_e_do_imposto_retido_nos_termos_do_n_1__alinea_b__do_Art__119__do_CIRSCaptionLbl)
            {
            }
            column(V2Caption; V2CaptionLbl)
            {
            }
            column("RETENÇÃO_NA_FONTECaption"; RETENÇÃO_NA_FONTECaptionLbl)
            {
            }
            column(Ano_a_que_os_rendimentos_dizem_respeitoCaption; Ano_a_que_os_rendimentos_dizem_respeitoCaptionLbl)
            {
            }
            column(V1Caption; V1CaptionLbl)
            {
            }
            column(Empregado_No_; "No.")
            {
            }
            column("Quotizações_sindicaisCaption"; Quotizações_sindicaisCaptionLbl)
            {
            }
            column("Contribuições_obrigatórias_para_regimes_de_protecção_socialCaption"; Contribuições_obrigatórias_para_regimes_de_protecção_socialCaptionLbl)
            {
            }
            column("DEDUÇÕESCaption"; DEDUÇÕESCaptionLbl)
            {
            }
            column(V5Caption; V5CaptionLbl)
            {
            }
            dataitem("Imposto Retido"; "Hist. Linhas Movs. Empregado")
            {
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("No. Empregado", "Tipo Rendimento");

                trigger OnAfterGetRecord()
                begin
                    //Para apanhar só os registos que são do Genero IRS ou IRS Sub. Férias  ou IRS Sub. NAtal
                    TabRubrica.Reset;
                    TabRubrica.SetRange(TabRubrica.Código, "Imposto Retido"."Cód. Rubrica");
                    TabRubrica.SetRange(TabRubrica."Sobretaxa em Sede de IRS", false);//2013.01.14
                    if TabRubrica.Find('-') then begin
                        if (TabRubrica.Genero <> TabRubrica.Genero::IRS) and
                          (TabRubrica.Genero <> TabRubrica.Genero::"IRS Sub. Férias") and
                          (TabRubrica.Genero <> TabRubrica.Genero::"IRS Sub. Natal") then
                            CurrReport.Skip;
                    end else
                        CurrReport.Skip;

                    if "Imposto Retido"."Tipo Rendimento" = "Imposto Retido"."Tipo Rendimento"::A then
                        varRetidoA := varRetidoA + "Imposto Retido".Valor;

                    if "Imposto Retido"."Tipo Rendimento" = "Imposto Retido"."Tipo Rendimento"::B then
                        varRetidoB := varRetidoB + "Imposto Retido".Valor;

                    if "Imposto Retido"."Tipo Rendimento" = "Imposto Retido"."Tipo Rendimento"::E then
                        varRetidoE := varRetidoE + "Imposto Retido".Valor;

                    if "Imposto Retido"."Tipo Rendimento" = "Imposto Retido"."Tipo Rendimento"::F then
                        varRetidoF := varRetidoF + "Imposto Retido".Valor;
                end;

                trigger OnPreDataItem()
                begin
                    //Filtrar os registos para o ano desejado
                    "Imposto Retido".SetFilter("Imposto Retido"."Data Registo",
                    '>=%1&<=%2', DMY2Date(1, 1, varAno), DMY2Date(31, 12, varAno));
                end;
            }
            dataitem(SobretaxaExtraordinaria; "Hist. Linhas Movs. Empregado")
            {
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("No. Empregado", "Tipo Rendimento");

                trigger OnAfterGetRecord()
                begin
                    //Para apanhar só os registos que são do Genero IRS ou IRS Sub. Férias  ou IRS Sub. NAtal
                    TabRubrica.Reset;
                    TabRubrica.SetRange(TabRubrica.Código, SobretaxaExtraordinaria."Cód. Rubrica");
                    TabRubrica.SetRange(TabRubrica."Sobretaxa em Sede de IRS", true);
                    if TabRubrica.FindFirst then begin
                        if (TabRubrica.Genero <> TabRubrica.Genero::IRS) and
                          (TabRubrica.Genero <> TabRubrica.Genero::"IRS Sub. Férias") and
                          (TabRubrica.Genero <> TabRubrica.Genero::"IRS Sub. Natal") then
                            CurrReport.Skip;
                    end else
                        CurrReport.Skip;

                    if SobretaxaExtraordinaria."Tipo Rendimento" = SobretaxaExtraordinaria."Tipo Rendimento"::A then
                        varRetidoAExtra := varRetidoAExtra + SobretaxaExtraordinaria.Valor;
                end;

                trigger OnPreDataItem()
                begin
                    SobretaxaExtraordinaria.SetFilter(SobretaxaExtraordinaria."Data Registo", '>=%1&<=%2', DMY2Date(1, 1, varAno), DMY2Date(31, 12, varAno));
                end;
            }
            dataitem("Sujeito a Retenção"; "Hist. Linhas Movs. Empregado")
            {
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("No. Empregado", "Data Registo");

                trigger OnAfterGetRecord()
                var
                    recHistLinhasMovsEmpregado: Record "Hist. Linhas Movs. Empregado";
                    recRubricaSalarialLinhas: Record "Rubrica Salarial Linhas";
                    TabHistLinhasMov2: Record "Hist. Linhas Movs. Empregado";
                    Flag: Boolean;
                    TabRubrica2: Record "Rubrica Salarial";
                    TabRubricaLinha2: Record "Rubrica Salarial Linhas";
                begin
                end;

                trigger OnPreDataItem()
                var
                    TabHistLinhasMov2: Record "Hist. Linhas Movs. Empregado";
                    Flag: Boolean;
                    TabRubrica2: Record "Rubrica Salarial";
                    TabRubricaLinha2: Record "Rubrica Salarial Linhas";
                begin
                    //Filtrar os registos para o ano desejado
                    "Sujeito a Retenção".SetFilter("Sujeito a Retenção"."Data Registo", '>=%1&<=%2', DMY2Date(1, 1, varAno), DMY2Date(31, 12, varAno));
                    TabHistLinhasMov2.Reset;
                    TabHistLinhasMov2.SetRange(TabHistLinhasMov2."No. Empregado", Empregado."No.");
                    TabHistLinhasMov2.SetFilter(TabHistLinhasMov2."Tipo Processamento", '<>%1', TabHistLinhasMov2."Tipo Processamento"::Encargos);
                    TabHistLinhasMov2.SetRange(TabHistLinhasMov2."Data Registo",
                                                 DMY2Date(1, 1, varAno),
                                                 DMY2Date(31, 12, varAno));
                    if TabHistLinhasMov2.FindSet then begin
                        repeat
                            if TabHistLinhasMov2."Tipo Rendimento" = TabHistLinhasMov2."Tipo Rendimento"::A then begin
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
                                            if TabRubricaLinha2."Valor Limite Máximo" <> 0 then begin
                                                if TabHistLinhasMov2.Valor > TabHistLinhasMov2.Quantidade * TabRubricaLinha2."Valor Limite Máximo" then
                                                    varSujeitoA := varSujeitoA +
                                                                ((TabHistLinhasMov2.Valor - TabHistLinhasMov2.Quantidade * TabRubricaLinha2."Valor Limite Máximo")
                                                                * (TabRubricaLinha2.Percentagem / 100));

                                            end else
                                                varSujeitoA := varSujeitoA + TabHistLinhasMov2.Valor;
                                            Flag := true;
                                        end;
                                    until (TabRubrica2.Next = 0) or (Flag = true);
                            end;
                            if TabHistLinhasMov2."Tipo Rendimento" = TabHistLinhasMov2."Tipo Rendimento"::B then begin
                                Flag := false;
                                TabRubrica2.Reset;
                                TabRubrica2.SetFilter(TabRubrica2.Genero, '%1|%2|%3', TabRubrica2.Genero::IRS, TabRubrica2.Genero::"IRS Sub. Férias",
                                                      TabRubrica2.Genero::"IRS Sub. Natal");
                                if TabRubrica2.FindSet then
                                    repeat
                                        TabRubricaLinha2.Reset;
                                        TabRubricaLinha2.SetRange(TabRubricaLinha2."Cód. Rubrica", TabRubrica2.Código);
                                        TabRubricaLinha2.SetRange(TabRubricaLinha2."Cód. Rubrica Filha", TabHistLinhasMov2."Cód. Rubrica");
                                        if TabRubricaLinha2.Find('-') then begin
                                            varSujeitoB := varSujeitoB +
                                                        ((TabHistLinhasMov2.Valor - TabHistLinhasMov2.Quantidade * TabRubricaLinha2."Valor Limite Máximo")
                                                        * (TabRubricaLinha2.Percentagem / 100));
                                            Flag := true;
                                        end;
                                    until (TabRubrica2.Next = 0) or (Flag = true);
                            end;
                            if TabHistLinhasMov2."Tipo Rendimento" = TabHistLinhasMov2."Tipo Rendimento"::E then begin
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
                                            varSujeitoE := varSujeitoE +
                                                        ((TabHistLinhasMov2.Valor - TabHistLinhasMov2.Quantidade * TabRubricaLinha2."Valor Limite Máximo")
                                                        * (TabRubricaLinha2.Percentagem / 100));
                                            Flag := true;
                                        end;
                                    until (TabRubrica2.Next = 0) or (Flag);
                            end;
                            if TabHistLinhasMov2."Tipo Rendimento" = TabHistLinhasMov2."Tipo Rendimento"::F then begin
                                Flag := false;
                                TabRubrica2.Reset;
                                TabRubrica2.SetFilter(TabRubrica2.Genero, '%1|%2|%3', TabRubrica2.Genero::IRS, TabRubrica2.Genero::"IRS Sub. Férias", TabRubrica2.Genero::"IRS Sub. Natal");
                                if TabRubrica2.FindSet then
                                    repeat
                                        TabRubricaLinha2.Reset;
                                        TabRubricaLinha2.SetRange(TabRubricaLinha2."Cód. Rubrica", TabRubrica2.Código);
                                        TabRubricaLinha2.SetRange(TabRubricaLinha2."Cód. Rubrica Filha", TabHistLinhasMov2."Cód. Rubrica");
                                        if TabRubricaLinha2.Find('-') then begin
                                            varSujeitoF := varSujeitoF +
                                                        ((TabHistLinhasMov2.Valor - TabHistLinhasMov2.Quantidade * TabRubricaLinha2."Valor Limite Máximo")
                                                        * (TabRubricaLinha2.Percentagem / 100));
                                            Flag := true;
                                        end;
                                    until (TabRubrica2.Next = 0) or (Flag);
                            end;
                        until TabHistLinhasMov2.Next = 0;
                    end;
                end;
            }
            dataitem("Não Sujeito"; "Hist. Linhas Movs. Empregado")
            {
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("No. Empregado", "Data Registo");

                trigger OnPreDataItem()
                var
                    TabHistLinhasMov2: Record "Hist. Linhas Movs. Empregado";
                begin
                    //Filtrar os registos para o ano desejado
                    "Não Sujeito".SetFilter("Não Sujeito"."Data Registo", '>=%1&<=%2', DMY2Date(1, 1, varAno), DMY2Date(31, 12, varAno));
                    TabHistLinhasMov2.Reset;
                    TabHistLinhasMov2.SetRange(TabHistLinhasMov2."No. Empregado", Empregado."No.");
                    TabHistLinhasMov2.SetFilter(TabHistLinhasMov2."Tipo Processamento", '<>%1', TabHistLinhasMov2."Tipo Processamento"::Encargos);
                    TabHistLinhasMov2.SetRange(TabHistLinhasMov2."Data Registo", DMY2Date(1, 1, varAno), DMY2Date(31, 12, varAno));
                    TabHistLinhasMov2.SetFilter(TabHistLinhasMov2."Tipo Rendimento Cat.A", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10', 10, 11, 12, 13, 14, 15, 16, 21, 23, 24);
                    if TabHistLinhasMov2.FindSet then
                        repeat
                            if TabHistLinhasMov2."Tipo Rendimento" = TabHistLinhasMov2."Tipo Rendimento"::A then
                                varNaoSujeitoA := varNaoSujeitoA + TabHistLinhasMov2.Valor;
                        until TabHistLinhasMov2.Next = 0;
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(ABS_varRetidoA_; Abs(varRetidoA))
                {
                }
                column(ABS_varRetidoB_; Abs(varRetidoB))
                {
                }
                column(ABS_varRetidoE_; Abs(varRetidoE))
                {
                }
                column(ABS_varRetidoF_; Abs(varRetidoF))
                {
                }
                column(ABS_varSujeitoA_; Abs(varSujeitoA))
                {
                }
                column(ABS_varSujeitoB_; Abs(varSujeitoB))
                {
                }
                column(ABS_varSujeitoE_; Abs(varSujeitoE))
                {
                }
                column(ABS_varSujeitoF_; Abs(varSujeitoF))
                {
                }
                column(ABS_varRetidoAExtra_; Abs(varRetidoAExtra))
                {
                }
                column(ABS_varNaoSujeitoA_; Abs(varNaoSujeitoA))
                {
                }
                column("IMPORTÂNCIAS_DEVIDAS_E_IMPOSTO_RETIDOCaption"; IMPORTÂNCIAS_DEVIDAS_E_IMPOSTO_RETIDOCaptionLbl)
                {
                }
                column(Rendimentos_do_Ano__a_Caption; Rendimentos_do_Ano__a_CaptionLbl)
                {
                }
                column("Sujeitos_a_Retenção__2_Caption"; Sujeitos_a_Retenção__2_CaptionLbl)
                {
                }
                column(Total_Imposto_Retido__1_Caption; Total_Imposto_Retido__1_CaptionLbl)
                {
                }
                column(Tipo_de_RendimentosCaption; Tipo_de_RendimentosCaptionLbl)
                {
                }
                column(A___Trabalho_DependenteCaption; A___Trabalho_DependenteCaptionLbl)
                {
                }
                column(B___Trabalho_IndependenteCaption; B___Trabalho_IndependenteCaptionLbl)
                {
                }
                column(E___CapitaisCaption; E___CapitaisCaptionLbl)
                {
                }
                column(F___PrediaisCaption; F___PrediaisCaptionLbl)
                {
                }
                column(V4Caption; V4CaptionLbl)
                {
                }
                column(EmptyStringCaption; EmptyStringCaptionLbl)
                {
                }
                column(EmptyStringCaption_Control1101490040; EmptyStringCaption_Control1101490040Lbl)
                {
                }
                column(EmptyStringCaption_Control1101490042; EmptyStringCaption_Control1101490042Lbl)
                {
                }
                column(EmptyStringCaption_Control1101490044; EmptyStringCaption_Control1101490044Lbl)
                {
                }
                column(EmptyStringCaption_Control1101490065; EmptyStringCaption_Control1101490065Lbl)
                {
                }
                column(EmptyStringCaption_Control1101490073; EmptyStringCaption_Control1101490073Lbl)
                {
                }
                column(EmptyStringCaption_Control1101490074; EmptyStringCaption_Control1101490074Lbl)
                {
                }
                column(EmptyStringCaption_Control1101490075; EmptyStringCaption_Control1101490075Lbl)
                {
                }
                column(Sobretaxa_em_Sede_de_IRSCaption; Sobretaxa_em_Sede_de_IRSCaptionLbl)
                {
                }
                column(EmptyStringCaption_Control1102065002; EmptyStringCaption_Control1102065002Lbl)
                {
                }
                column("Não_Sujeitos_a_RetençãoCaption"; Não_Sujeitos_a_RetençãoCaptionLbl)
                {
                }
                column(EmptyStringCaption_Control1101490057; EmptyStringCaption_Control1101490057Lbl)
                {
                }
                column(Integer_Number; Number)
                {
                }
            }
            dataitem("Deduções"; "Hist. Linhas Movs. Empregado")
            {
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("No. Empregado", "Data Registo");

                trigger OnAfterGetRecord()
                begin
                    //só os registos que são do Genero SS
                    TabRubrica.Reset;

                    TabRubrica.Reset;
                    TabRubrica.SetRange(TabRubrica.Código, Deduções."Cód. Rubrica");
                    if TabRubrica.FindSet then begin
                        if (TabRubrica.Genero = TabRubrica.Genero::SS) or (TabRubrica.Genero = TabRubrica.Genero::ADSE) or
                          (TabRubrica.Genero = TabRubrica.Genero::CGA) then
                            varDeducoes := varDeducoes + Deduções.Valor
                        else
                            varDeducoes := varDeducoes + 0;
                    end;

                    //Para apanhar só os registos que são do Genero Sindicato
                    TabRubrica.Reset;
                    TabRubrica.SetRange(TabRubrica.Código, Deduções."Cód. Rubrica");
                    if TabRubrica.FindFirst then
                        if TabRubrica.Genero = TabRubrica.Genero::Sindicato then
                            VarSindicato := VarSindicato + Deduções.Valor
                        else
                            VarSindicato := VarSindicato + 0;
                end;

                trigger OnPreDataItem()
                begin
                    //Filtrar os registos para o ano desejado
                    Deduções.SetFilter(Deduções."Data Registo", '>=%1&<=%2', DMY2Date(1, 1, varAno), DMY2Date(31, 12, varAno));
                end;
            }
            dataitem(Integer_Dud; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(ABS_varDeducoes_; Abs(varDeducoes))
                {
                }
                column(ABS_VarSindicato_; Abs(VarSindicato))
                {
                }
                column(EmptyStringCaption_Control1101490116; EmptyStringCaption_Control1101490116Lbl)
                {
                }
                column(EmptyStringCaption_Control1101490123; EmptyStringCaption_Control1101490123Lbl)
                {
                }
                column(IntegerDud_Number; Number)
                {
                }
            }
            dataitem(Integer2; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(WORKDATE; WorkDate)
                {
                }
                column(Company_Information__City_Control1101490093; "Company Information".City)
                {
                }
                column(LocalCaption; LocalCaptionLbl)
                {
                }
                column(Data_Caption; Data_CaptionLbl)
                {
                }
                column("Assinatura_do_ResponsávelCaption"; Assinatura_do_ResponsávelCaptionLbl)
                {
                }
                column(Carimbo_da_Entidade_PagadoraCaption; Carimbo_da_Entidade_PagadoraCaptionLbl)
                {
                }
                column(Processado_por_ComputadorCaption; Processado_por_ComputadorCaptionLbl)
                {
                }
                column(Integer2_Number; Number)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                //Impedir que apareçam empregados que não têm rendimentos mas estão activos
                TabHistLinhasMovEmp.Reset;
                TabHistLinhasMovEmp.SetFilter("Data Registo", '>=%1&<=%2', DMY2Date(1, 1, varAno), DMY2Date(31, 12, varAno));
                TabHistLinhasMovEmp.SetRange("No. Empregado", "No.");
                if not TabHistLinhasMovEmp.Find('-') then
                    CurrReport.Skip;

                //Limpar as variáveis
                Clear(varRetidoA);
                Clear(varSujeitoA);
                Clear(varDispensadoA);
                Clear(varRetidoAExtra);
                Clear(varNaoSujeitoA);//Normatica 2014.03.19

                Clear(varRetidoB);
                Clear(varSujeitoB);
                Clear(varDispensadoB);

                Clear(varRetidoE);
                Clear(varSujeitoE);
                Clear(varDispensadoE);

                Clear(varRetidoF);
                Clear(varSujeitoF);
                Clear(varDispensadoF);


                Clear(varDeducoes);
                Clear(VarSindicato);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(varAno; varAno)
                {
                    ApplicationArea = All;
                    Caption = 'Year';
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
        if varAno = 0 then
            Error(Text0001);
    end;

    var
        TabRubrica: Record "Rubrica Salarial";
        TabHistLinhasMovEmp: Record "Hist. Linhas Movs. Empregado";
        varAno: Integer;
        varRetidoA: Decimal;
        varRetidoB: Decimal;
        varRetidoE: Decimal;
        varRetidoF: Decimal;
        varSujeitoA: Decimal;
        varSujeitoB: Decimal;
        varSujeitoE: Decimal;
        varSujeitoF: Decimal;
        varDispensadoA: Decimal;
        varDispensadoB: Decimal;
        varDispensadoE: Decimal;
        varDispensadoF: Decimal;
        Text0001: Label 'Prencha o Ano para o qual pretende tirar a Declaração de Rendimentos.';
        varDeducoes: Decimal;
        VarSindicato: Decimal;
        varRetidoAExtra: Decimal;
        varNaoSujeitoA: Decimal;
        MoradaCaptionLbl: Label 'Morada';
        "IDENTIFICAÇÃO_DO_TITULAR_DOS_RENDIMENTOSCaptionLbl": Label 'IDENTIFICAÇÃO DO TITULAR DOS RENDIMENTOS';
        V3CaptionLbl: Label '3';
        "IDENTIFICAÇÃO_DA_ENTIDADE_PAGADORACaptionLbl": Label 'IDENTIFICAÇÃO DA ENTIDADE PAGADORA';
        Nota_dos_rendimentos_devidos_e_do_imposto_retido_nos_termos_do_n_1__alinea_b__do_Art__119__do_CIRSCaptionLbl: Label 'Nota dos rendimentos devidos e do imposto retido nos termos do nº1, alinea b) do Art. 119º do CIRS';
        V2CaptionLbl: Label '2';
        "RETENÇÃO_NA_FONTECaptionLbl": Label 'RETENÇÃO NA FONTE';
        Ano_a_que_os_rendimentos_dizem_respeitoCaptionLbl: Label 'Ano a que os rendimentos dizem respeito';
        V1CaptionLbl: Label '1';
        "IMPORTÂNCIAS_DEVIDAS_E_IMPOSTO_RETIDOCaptionLbl": Label 'IMPORTÂNCIAS DEVIDAS E IMPOSTO RETIDO';
        Rendimentos_do_Ano__a_CaptionLbl: Label 'Rendimentos do Ano (a)';
        "Sujeitos_a_Retenção__2_CaptionLbl": Label 'Sujeitos a Retenção (2)';
        Total_Imposto_Retido__1_CaptionLbl: Label 'Total Imposto Retido (1)';
        Tipo_de_RendimentosCaptionLbl: Label 'Tipo de Rendimentos';
        A___Trabalho_DependenteCaptionLbl: Label 'A - Trabalho Dependente';
        B___Trabalho_IndependenteCaptionLbl: Label 'B - Trabalho Independente';
        E___CapitaisCaptionLbl: Label 'E - Capitais';
        F___PrediaisCaptionLbl: Label 'F - Prediais';
        V4CaptionLbl: Label '4';
        EmptyStringCaptionLbl: Label '€';
        EmptyStringCaption_Control1101490040Lbl: Label '€';
        EmptyStringCaption_Control1101490042Lbl: Label '€';
        EmptyStringCaption_Control1101490044Lbl: Label '€';
        EmptyStringCaption_Control1101490065Lbl: Label '€';
        EmptyStringCaption_Control1101490073Lbl: Label '€';
        EmptyStringCaption_Control1101490074Lbl: Label '€';
        EmptyStringCaption_Control1101490075Lbl: Label '€';
        Sobretaxa_em_Sede_de_IRSCaptionLbl: Label 'Sobretaxa em Sede de IRS';
        EmptyStringCaption_Control1102065002Lbl: Label '€';
        "Não_Sujeitos_a_RetençãoCaptionLbl": Label 'Não Sujeitos a Retenção';
        EmptyStringCaption_Control1101490057Lbl: Label '€';
        "Quotizações_sindicaisCaptionLbl": Label 'Quotizações sindicais';
        EmptyStringCaption_Control1101490116Lbl: Label '€';
        "Contribuições_obrigatórias_para_regimes_de_protecção_socialCaptionLbl": Label 'Contribuições obrigatórias para regimes de protecção social';
        EmptyStringCaption_Control1101490123Lbl: Label '€';
        "DEDUÇÕESCaptionLbl": Label 'DEDUÇÕES';
        V5CaptionLbl: Label '5';
        LocalCaptionLbl: Label 'Local';
        Data_CaptionLbl: Label 'Data ';
        "Assinatura_do_ResponsávelCaptionLbl": Label 'Assinatura do Responsável';
        Carimbo_da_Entidade_PagadoraCaptionLbl: Label 'Carimbo da Entidade Pagadora';
        Processado_por_ComputadorCaptionLbl: Label 'Processado por Computador';


    procedure InitData(pAno: Integer)
    begin
        varAno := pAno;
    end;
}

