report 53075 "Folha Remunerações"
{
    // //-------------------------------------------------------
    //               Folha de Remunerações
    // //--------------------------------------------------------
    //   É um Mapa que serve de conferência de dados oriundos do
    //   Processamento.
    //   Está disponível a partir de Mapas.
    // //-------------------------------------------------------
    // 
    // IT001 - CPA:Aparecer a Desc. Cat. profissional interna em vez da QP -   2010.03.18
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\FolhaRemunerações.rdl';

    PreviewMode = PrintLayout;
    UseRequestPage = true;

    dataset
    {
        dataitem("Periodos Processamento"; "Periodos Processamento")
        {
            DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento");
            PrintOnlyIfDetail = true;

            trigger OnPostDataItem()
            begin
                HideHist := false;
                if Estado = Estado::Aberto then
                    HideHist := true;
            end;

            trigger OnPreDataItem()
            begin
                if CodProcess <> '' then
                    "Periodos Processamento".SetFilter("Cód. Processamento", CodProcess);
                if DataInicio <> 0D then
                    SetRange("Data Inicio Processamento", DataInicio);
                if DataFim <> 0D then
                    SetRange("Data Fim Processamento", DataFim);
            end;
        }
        dataitem(Empregado; Employee)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Tipo Empregado";
            column(HideList; HideHist)
            {
            }
            column(Processado_por_ComputadorCaption; Processado_por_ComputadorCaptionLbl)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(TabConfEmpresa_Picture; TabConfEmpresa.Picture)
            {
            }
            column(N__Contribuinte______TabConfEmpresa__VAT_Registration_No__; 'Nº Contribuinte: ' + TabConfEmpresa."VAT Registration No.")
            {
            }
            column(N__Telefone______TabConfEmpresa__Phone_No__; 'Nº Telefone: ' + TabConfEmpresa."Phone No.")
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
            column(TabConfEmpresa__Name_2_; TabConfEmpresa."Name 2")
            {
            }
            column(Filtro; "Periodos Processamento"."Cód. Processamento" + ' de ' + Format("Periodos Processamento"."Data Inicio Processamento") + ' a ' + Format("Periodos Processamento"."Data Fim Processamento"))
            {
            }
            column(Empregado__No__; "No.")
            {
            }
            column(Empregado_Name; Name)
            {
            }
            column("Empregado__Descrição_Cat_Prof_"; "Descrição Cat Prof")
            {
            }
            column(Empregado__No__Contribuinte_; "No. Contribuinte")
            {
            }
            column("Empregado__No__Segurança_Social_"; "No. Segurança Social")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column("FOLHA_DE_REMUNERAÇÕESCaption"; FOLHA_DE_REMUNERAÇÕESCaptionLbl)
            {
            }
            column("Período_de_Processamento_Caption"; Período_de_Processamento_CaptionLbl)
            {
            }
            column(N__EmpregadoCaption; N__EmpregadoCaptionLbl)
            {
            }
            column(Empregado_NameCaption; FieldCaption(Name))
            {
            }
            column("Empregado__Descrição_Cat_Prof_Caption"; FieldCaption("Descrição Cat Prof"))
            {
            }
            column(Empregado__No__Contribuinte_Caption; FieldCaption("No. Contribuinte"))
            {
            }
            column("Empregado__No__Segurança_Social_Caption"; FieldCaption("No. Segurança Social"))
            {
            }
            column("REMUNERAÇÕESCaption"; REMUNERAÇÕESCaptionLbl)
            {
            }
            column("Ilíquido_Caption"; Ilíquido_CaptionLbl)
            {
            }
            column(DESCONTOSCaption; DESCONTOSCaptionLbl)
            {
            }
            column(Descontos_Caption; Descontos_CaptionLbl)
            {
            }
            column("Líquido_Caption"; Líquido_CaptionLbl)
            {
            }
            column("REMUNERAÇÕESCaption_Control1102056028"; REMUNERAÇÕESCaption_Control1102056028Lbl)
            {
            }
            column("Ilíquido_Caption_Control1102056033"; Ilíquido_Caption_Control1102056033Lbl)
            {
            }
            column(DESCONTOSCaption_Control1102056034; DESCONTOSCaption_Control1102056034Lbl)
            {
            }
            column(Descontos_Caption_Control1102056039; Descontos_Caption_Control1102056039Lbl)
            {
            }
            column("Líquido_Caption_Control1102056043"; Líquido_Caption_Control1102056043Lbl)
            {
            }
            dataitem("Movs. Abonos"; "Linhas Movs. Empregado")
            {
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado", "No. Linha") WHERE("Tipo Rubrica" = CONST(Abono), "Tipo Processamento" = FILTER(<> Encargos));
                column("Movs__Abonos__Cód__Rubrica_"; "Cód. Rubrica")
                {
                }
                column("Movs__Abonos__Descrição_Rubrica_"; "Descrição Rubrica")
                {
                }
                column(Movs__Abonos_Quantidade; Quantidade)
                {
                }
                column(Movs__Abonos_Valor; Valor)
                {
                }
                column("Movs__Abonos_Cód__Processamento"; "Cód. Processamento")
                {
                }
                column(Movs__Abonos_Tipo_Processamento; "Tipo Processamento")
                {
                }
                column(Movs__Abonos_N__Empregado; "No. Empregado")
                {
                }
                column(Movs__Abonos_N__Linha; "No. Linha")
                {
                }

                trigger OnPreDataItem()
                begin
                    "Movs. Abonos".SetFilter("Movs. Abonos"."Cód. Processamento",
                    "Periodos Processamento".GetFilter("Periodos Processamento"."Cód. Processamento"));
                end;
            }
            dataitem("Movs. Descontos"; "Linhas Movs. Empregado")
            {
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado", "No. Linha") WHERE("Tipo Rubrica" = CONST(Desconto), "Tipo Processamento" = FILTER(<> Encargos));
                column(Movs__Descontos_Valor; Valor)
                {
                }
                column(varqtd; varqtd)
                {
                }
                column("Movs__Descontos__Descrição_Rubrica_"; "Descrição Rubrica")
                {
                }
                column("Movs__Descontos__Cód__Rubrica_"; "Cód. Rubrica")
                {
                }
                column(ABS__Movs__Abonos__Valor____ABS__Movs__Descontos__Valor_; Abs("Movs. Abonos".Valor) - Abs("Movs. Descontos".Valor))
                {
                }
                column("Movs__Descontos_Cód__Processamento"; "Cód. Processamento")
                {
                }
                column(Movs__Descontos_Tipo_Processamento; "Tipo Processamento")
                {
                }
                column(Movs__Descontos_N__Empregado; "No. Empregado")
                {
                }
                column(Movs__Descontos_N__Linha; "No. Linha")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if "Movs. Descontos"."Quatidade Recibo Vencimentos" <> 0.0 then
                        varqtd := "Movs. Descontos"."Quatidade Recibo Vencimentos"
                    else
                        varqtd := "Movs. Descontos".Quantidade;
                end;

                trigger OnPreDataItem()
                begin
                    "Movs. Descontos".SetFilter("Movs. Descontos"."Cód. Processamento",
                    "Periodos Processamento".GetFilter("Periodos Processamento"."Cód. Processamento"));
                end;
            }
            dataitem("Hist. Movs. Abonos"; "Hist. Linhas Movs. Empregado")
            {
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado", "No. Linha") WHERE("Tipo Rubrica" = CONST(Abono), "Tipo Processamento" = FILTER(<> Encargos));
                column(Hist__Movs__Abonos_Valor; Valor)
                {
                }
                column(Hist__Movs__Abonos_Quantidade; Quantidade)
                {
                }
                column("Hist__Movs__Abonos__Descrição_Rubrica_"; "Descrição Rubrica")
                {
                }
                column("Hist__Movs__Abonos__Cód__Rubrica_"; "Cód. Rubrica")
                {
                }
                column("Hist__Movs__Abonos_Cód__Processamento"; "Cód. Processamento")
                {
                }
                column(Hist__Movs__Abonos_Tipo_Processamento; "Tipo Processamento")
                {
                }
                column(Hist__Movs__Abonos_N__Empregado; "No. Empregado")
                {
                }
                column(Hist__Movs__Abonos_N__Linha; "No. Linha")
                {
                }

                trigger OnPreDataItem()
                begin
                    "Hist. Movs. Abonos".SetFilter("Hist. Movs. Abonos"."Cód. Processamento",
                    "Periodos Processamento".GetFilter("Periodos Processamento"."Cód. Processamento"));
                end;
            }
            dataitem("Hist. Movs. Descontos"; "Hist. Linhas Movs. Empregado")
            {
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado", "No. Linha") WHERE("Tipo Rubrica" = CONST(Desconto), "Tipo Processamento" = FILTER(<> Encargos));
                column(Hist__Movs__Descontos_Valor; Valor)
                {
                }
                column(varqtd_Control1102056036; varqtd)
                {
                }
                column("Hist__Movs__Descontos__Descrição_Rubrica_"; "Descrição Rubrica")
                {
                }
                column("Hist__Movs__Descontos__Cód__Rubrica_"; "Cód. Rubrica")
                {
                }
                column(ABS__Hist__Movs__Abonos__Valor____ABS__Hist__Movs__Descontos__Valor_; Abs("Hist. Movs. Abonos".Valor) - Abs("Hist. Movs. Descontos".Valor))
                {
                }
                column("Hist__Movs__Descontos_Cód__Processamento"; "Cód. Processamento")
                {
                }
                column(Hist__Movs__Descontos_Tipo_Processamento; "Tipo Processamento")
                {
                }
                column(Hist__Movs__Descontos_N__Empregado; "No. Empregado")
                {
                }
                column(Hist__Movs__Descontos_N__Linha; "No. Linha")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if "Hist. Movs. Descontos"."Quatidade Recibo Vencimentos" <> 0.0 then
                        varqtd := "Hist. Movs. Descontos"."Quatidade Recibo Vencimentos"
                    else
                        varqtd := "Hist. Movs. Descontos".Quantidade;
                end;

                trigger OnPreDataItem()
                begin
                    "Hist. Movs. Descontos".SetFilter("Hist. Movs. Descontos"."Cód. Processamento",
                    "Periodos Processamento".GetFilter("Periodos Processamento"."Cód. Processamento"));
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
                group("Folha Remunerações")
                {
                    Caption = 'Folha Remunerações';
                    field(CodProcess; CodProcess)
                    {
                        ;
                        Caption = 'Cod. Processamento';
                        TableRelation = "Periodos Processamento";
                    }
                    field(DataInicio; DataInicio)
                    {
                        ;
                        Caption = 'Data Inicio';
                    }
                    field(DataFim; DataFim)
                    {
                        ;
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

    trigger OnPreReport()
    begin
        TabConfEmpresa.Get;
        TabConfEmpresa.CalcFields(TabConfEmpresa.Picture);
    end;

    var
        TabConfEmpresa: Record "Company Information";
        Text0001: Label 'Não pode usar um período de processamento aberto.';
        Text0002: Label 'O processamento tem de estar Fechado.';
        Text0003: Label 'Os filtros data de processamento e código de processamento são exclusivos. Não pode selecionar ambos.';
        Text0004: Label 'Tem que preencher a data de início e fim de processamento.';
        varqtd: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        "FOLHA_DE_REMUNERAÇÕESCaptionLbl": Label 'FOLHA DE REMUNERAÇÕES';
        "Período_de_Processamento_CaptionLbl": Label 'Período de Processamento:';
        N__EmpregadoCaptionLbl: Label 'Nº Empregado';
        "REMUNERAÇÕESCaptionLbl": Label 'REMUNERAÇÕES';
        "Ilíquido_CaptionLbl": Label 'Ilíquido:';
        DESCONTOSCaptionLbl: Label 'DESCONTOS';
        Descontos_CaptionLbl: Label 'Descontos:';
        "Líquido_CaptionLbl": Label 'Líquido:';
        "REMUNERAÇÕESCaption_Control1102056028Lbl": Label 'REMUNERAÇÕES';
        "Ilíquido_Caption_Control1102056033Lbl": Label 'Ilíquido:';
        DESCONTOSCaption_Control1102056034Lbl: Label 'DESCONTOS';
        Descontos_Caption_Control1102056039Lbl: Label 'Descontos:';
        "Líquido_Caption_Control1102056043Lbl": Label 'Líquido:';
        Processado_por_ComputadorCaptionLbl: Label 'Processado por Computador';
        CodProcess: Code[10];
        HideHist: Boolean;
        DataInicio: Date;
        DataFim: Date;
}

