report 53050 "Mapa Imp. Extraordinário 2011"
{
    // //-------------------------------------------------------
    //               Imposto Extra
    // //-------------------------------------------------------
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\MapaImpExtraordinário2011.rdl';

    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Periodos Processamento"; "Periodos Processamento")
        {
            DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Cód. Processamento";
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
            column(USERID; UserId)
            {
            }
            column(TabConfEmpresa__Name_2_; TabConfEmpresa."Name 2")
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
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
            column(DataItem1101490069; "Periodos Processamento"."Cód. Processamento" + ' de ' + Format("Periodos Processamento"."Data Inicio Processamento") + ' a ' + Format("Periodos Processamento"."Data Fim Processamento"))
            {
            }
            column("Mapa_Imposto_Extraordinário_Caption"; Mapa_Imposto_Extraordinário_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column("Período_de_Processamento_Caption"; Período_de_Processamento_CaptionLbl)
            {
            }
            column(Linhas_Movs__Empregado__N__Empregado_Caption; "Linhas Movs. Empregado".FieldCaption("Employee No."))
            {
            }
            column("Linhas_Movs__Empregado__Designação_Empregado_Caption"; "Linhas Movs. Empregado".FieldCaption("Designação Empregado"))
            {
            }
            column(Linhas_Movs__Empregado_ValorCaption; "Linhas Movs. Empregado".FieldCaption(Valor))
            {
            }
            column(N__ContribuinteCaption; N__ContribuinteCaptionLbl)
            {
            }
            column("Periodos_Processamento_Cód__Processamento"; "Cód. Processamento")
            {
            }
            column(Periodos_Processamento_Tipo_Processamento; "Tipo Processamento")
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Processado_por_ComputadorCaption; Processado_por_ComputadorCaptionLbl)
            {
            }
            dataitem("Linhas Movs. Empregado"; "Linhas Movs. Empregado")
            {
                DataItemLink = "Cód. Processamento" = FIELD("Cód. Processamento"), "Tipo Processamento" = FIELD("Tipo Processamento");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "Employee No.", "No. Linha");
                column(Linhas_Movs__Empregado__N__Empregado_; "Employee No.")
                {
                }
                column("Linhas_Movs__Empregado__Designação_Empregado_"; "Designação Empregado")
                {
                }
                column(Linhas_Movs__Empregado_Valor; Valor)
                {
                }
                column(NContribuinte; NContribuinte)
                {
                }
                column(Linhas_Movs__Empregado_Valor_Control1102065009; Valor)
                {
                }
                column("Linhas_Movs__Empregado_Cód__Processamento"; "Cód. Processamento")
                {
                }
                column(Linhas_Movs__Empregado_Tipo_Processamento; "Tipo Processamento")
                {
                }
                column(Linhas_Movs__Empregado_N__Linha; "No. Linha")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if rEmpregado.Get("Linhas Movs. Empregado"."Employee No.") then
                        NContribuinte := rEmpregado."No. Contribuinte"
                end;

                trigger OnPreDataItem()
                begin
                    "Linhas Movs. Empregado".SetRange("Linhas Movs. Empregado"."Cód. Rubrica", codRubSalarial);
                end;
            }
            dataitem("Hist. Linhas Movs. Empregado"; "Hist. Linhas Movs. Empregado")
            {
                DataItemLink = "Cód. Processamento" = FIELD("Cód. Processamento"), "Tipo Processamento" = FIELD("Tipo Processamento");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "Employee No.", "No. Linha");
                column(Hist__Linhas_Movs__Empregado_Valor; Valor)
                {
                }
                column("Hist__Linhas_Movs__Empregado__Designação_Empregado_"; "Designação Empregado")
                {
                }
                column(Hist__Linhas_Movs__Empregado__N__Empregado_; "Employee No.")
                {
                }
                column(NContribuinte_Control1102065017; NContribuinte)
                {
                }
                column(Hist__Linhas_Movs__Empregado_Valor_Control1102065012; Valor)
                {
                }
                column("Hist__Linhas_Movs__Empregado_Cód__Processamento"; "Cód. Processamento")
                {
                }
                column(Hist__Linhas_Movs__Empregado_Tipo_Processamento; "Tipo Processamento")
                {
                }
                column(Hist__Linhas_Movs__Empregado_N__Linha; "No. Linha")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if rEmpregado.Get("Hist. Linhas Movs. Empregado"."Employee No.") then
                        NContribuinte := rEmpregado."No. Contribuinte"
                end;

                trigger OnPreDataItem()
                begin
                    "Hist. Linhas Movs. Empregado".SetRange("Hist. Linhas Movs. Empregado"."Cód. Rubrica", codRubSalarial);
                end;
            }
        }
        dataitem(Rodape; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            column(Rodape_Number; Number)
            {
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(codRubSalarial; codRubSalarial)
                {

                    Caption = 'Rubrica do Imposto';
                    TableRelation = "Rubrica Salarial";
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
        rEmpregado: Record Empregado;
        TabConfEmpresa: Record "Company Information";
        Text0001: Label 'Não pode usar um período de processamento aberto.';
        Text0002: Label 'O processamento tem de estar Fechado.';
        Text0003: Label 'Os filtros data de processamento e código de processamento são exclusivos. Não pode selecionar ambos.';
        Text0004: Label 'Tem que preencher a data de início e fim de processamento.';
        codRubSalarial: Code[20];
        NContribuinte: Text[30];
        "Mapa_Imposto_Extraordinário_CaptionLbl": Label 'Mapa Imposto Extraordinário ';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        "Período_de_Processamento_CaptionLbl": Label 'Período de Processamento:';
        N__ContribuinteCaptionLbl: Label 'Nº Contribuinte';
        TotalCaptionLbl: Label 'Total';
        TotalCaption_Control1102065014Lbl: Label 'Total';
        Processado_por_ComputadorCaptionLbl: Label 'Processado por Computador';
}

