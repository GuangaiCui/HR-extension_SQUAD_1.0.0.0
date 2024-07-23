report 53071 "Mapa Fundos Compensação Trab."
{
    // //-------------------------------------------------------
    //               Mapa Fundo Compensação Trabalho
    // //--------------------------------------------------------
    //   Este Report está disponível a partir de Mapas.
    // //-------------------------------------------------------
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/MapaFundosCompensaçãoTrab.rdlc';

    PreviewMode = PrintLayout;
    UseRequestPage = true;

    dataset
    {
        dataitem("Periodos Processamento"; "Periodos Processamento")
        {
            DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento") WHERE("Tipo Processamento" = FILTER(<> Encargos));
            PrintOnlyIfDetail = true;

            trigger OnPreDataItem()
            begin
                SetFilter("Cód. Processamento", CodProcess);
                if DataInicio <> 0D then
                    SetRange("Data Inicio Processamento", DataInicio);
                if DataFin <> 0D then
                    SetRange("Data Fim Processamento", DataFin);

                FiltroDataInicProc := "Periodos Processamento".GetFilter("Data Inicio Processamento");
                FiltroDataFimProc := "Periodos Processamento".GetFilter("Data Fim Processamento");
                FiltroCodProc := "Periodos Processamento".GetFilter("Cód. Processamento");

                if (FiltroDataInicProc <> '') and (FiltroDataFimProc <> '') and (FiltroCodProc <> '') then
                    Error(Text0002);

                if (FiltroDataFimProc <> '') and (FiltroDataInicProc = '') then
                    Error(Text0003);

                if (FiltroDataFimProc = '') and (FiltroDataInicProc <> '') then
                    Error(Text0003);
            end;
        }
        dataitem("Rubrica Salarial"; "Rubrica Salarial")
        {
            DataItemTableView = SORTING("Código") WHERE(Genero = CONST("FCT-FGCT"));

            trigger OnAfterGetRecord()
            begin
                Conta := Conta + 1;
                varRubrica[Conta] := "Rubrica Salarial".Código;
            end;
        }
        dataitem(Empregado; Employee)
        {
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
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
            column(TabConfEmpresa__Name_2_; TabConfEmpresa."Name 2")
            {
            }
            column(N__Telefone______TabConfEmpresa__Phone_No__; 'Nº Telefone: ' + TabConfEmpresa."Phone No.")
            {
            }
            column(N__Contribuinte______TabConfEmpresa__VAT_Registration_No__; 'Nº Contribuinte: ' + TabConfEmpresa."VAT Registration No.")
            {
            }
            column(TabConfEmpresa__Post_Code_; TabConfEmpresa."Post Code")
            {
            }
            column(TabConfEmpresa_Picture; TabConfEmpresa.Picture)
            {
            }
            column(FiltroCodProc__________FiltroDataInicProc__________FiltroDataFimProc; FiltroCodProc + '  ' + FiltroDataInicProc + '  ' + FiltroDataFimProc)
            {
            }
            column(Empregado__No__; "No.")
            {
            }
            column(Empregado_Name; Name)
            {
            }
            column(Empregado__No__Contribuinte_; "No. Contribuinte")
            {
            }
            column("Empregado__No__Segurança_Social_"; "No. Segurança Social")
            {
            }
            column(varFCT; varFCT)
            {
            }
            column(varFGCT; varFGCT)
            {
            }
            column(varFCT___varFGCT; varFCT + varFGCT)
            {
            }
            column(varTotFCT___varTotFGCT; varTotFCT + varTotFGCT)
            {
            }
            column(varTotFGCT; varTotFGCT)
            {
            }
            column(varTotFCT; varTotFCT)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column("FUNDO_COMPENSAÇÃO_TRABALHOCaption"; FUNDO_COMPENSAÇÃO_TRABALHOCaptionLbl)
            {
            }
            column(Periodo_de_Processamento_Caption; Periodo_de_Processamento_CaptionLbl)
            {
            }
            column(Total_____FCT___FGCTCaption; Total_____FCT___FGCTCaptionLbl)
            {
            }
            column(FGCTCaption; FGCTCaptionLbl)
            {
            }
            column(FCTCaption; FCTCaptionLbl)
            {
            }
            column("Empregado__No__Segurança_Social_Caption"; FieldCaption("No. Segurança Social"))
            {
            }
            column(N__Contrib_Caption; N__Contrib_CaptionLbl)
            {
            }
            column(Empregado_NameCaption; FieldCaption(Name))
            {
            }
            column(Empregado__No__Caption; FieldCaption("No."))
            {
            }
            column(Total_Caption; Total_CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Clear(varFCT);
                Clear(varFGCT);
                if Evaluate(DataIni, FiltroDataInicProc) then;
                if Evaluate(DataFim, FiltroDataFimProc) then;

                HistLinhaMovEmp.Reset;
                if FiltroCodProc <> '' then
                    HistLinhaMovEmp.SetRange(HistLinhaMovEmp."Cód. Processamento", FiltroCodProc)
                else
                    HistLinhaMovEmp.SetRange(HistLinhaMovEmp."Data Registo", DataIni, DataFim);

                HistLinhaMovEmp.SetRange(HistLinhaMovEmp."No. Empregado", Empregado."No.");
                HistLinhaMovEmp.SetRange(HistLinhaMovEmp."Cód. Rubrica", varRubrica[1]);
                if HistLinhaMovEmp.FindFirst then
                    repeat
                        varFCT := varFCT + HistLinhaMovEmp.Valor;
                        varTotFCT := varTotFCT + HistLinhaMovEmp.Valor;
                    until HistLinhaMovEmp.Next = 0;

                HistLinhaMovEmp.SetRange(HistLinhaMovEmp."Cód. Rubrica", varRubrica[2]);
                if HistLinhaMovEmp.FindFirst then
                    repeat
                        varFGCT := varFGCT + HistLinhaMovEmp.Valor;
                        varTotFGCT := varTotFGCT + HistLinhaMovEmp.Valor;
                    until HistLinhaMovEmp.Next = 0;

                if (varFCT = 0) and (varFGCT = 0) then
                    CurrReport.Skip;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Fundos Compensação Trab.")
                {
                    Caption = 'Fundos Compensação Trab.';
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
                    field(DataFin; DataFin)
                    {
                        ApplicationArea = All;
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
        TabConfEmpresa.Get;
        TabConfEmpresa.CalcFields(TabConfEmpresa.Picture);
        FiltroDataInicProc := '';
        FiltroDataFimProc := '';
        FiltroCodProc := '';
    end;

    var
        TabConfEmpresa: Record "Company Information";
        recEmpregado: Record Employee;
        Text0001: Label 'Escolha um processamento já fechado.';
        HistLinhaMovEmp: Record "Hist. Linhas Movs. Empregado";
        FiltroDataInicProc: Text[100];
        FiltroDataFimProc: Text[100];
        FiltroCodProc: Text[50];
        Text0008: Label 'Preencha o Cod. Processamento para tirar o Mapa para um só processamento.\ Ou preencha a Data de Inicio e de Fim, para tirar o Mapa para vários processamentos.';
        Text0002: Label 'Os filtros data de processamento e código de processamento são exclusivos. Não pode selecionar ambos.';
        Text0003: Label 'Tem que preencher a data de início e fim de processamento.';
        DataIni: Date;
        DataFim: Date;
        varEmpregado: array[2, 8] of Text[100];
        Conta: Integer;
        varRubrica: array[2] of Code[10];
        varValorRemun: Decimal;
        varFCT: Decimal;
        varFGCT: Decimal;
        varTotFCT: Decimal;
        varTotFGCT: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        "FUNDO_COMPENSAÇÃO_TRABALHOCaptionLbl": Label 'FUNDO COMPENSAÇÃO TRABALHO';
        Periodo_de_Processamento_CaptionLbl: Label 'Periodo de Processamento:';
        Total_____FCT___FGCTCaptionLbl: Label '    Total     FCT + FGCT';
        FGCTCaptionLbl: Label 'FGCT';
        FCTCaptionLbl: Label 'FCT';
        N__Contrib_CaptionLbl: Label 'Nº Contrib.';
        Total_CaptionLbl: Label 'Total:';
        CodProcess: Code[10];
        DataInicio: Date;
        DataFin: Date;
}

