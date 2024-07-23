report 53085 "Listagem de Férias"
{
    //  //-------------------------------------------------------
    //                 Listagem de Férias
    //  //--------------------------------------------------------
    //   É um Mapa para listar as férias de cada empregado de
    //   forma a poder conferir as férias marcadas
    //   Este Report está disponível a partir de Mapas.
    //  //-------------------------------------------------------
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/ListagemdeFérias.rdlc';

    PreviewMode = PrintLayout;
    UseRequestPage = true;

    dataset
    {
        dataitem(Empregado; Employee)
        {
            DataItemTableView = SORTING("No.") WHERE(Status = FILTER(<> Terminated), "Tipo Contribuinte" = CONST("Conta de Outrem"));
            RequestFilterFields = "No.";
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
            column("LISTAGEM_DE_FÉRIAS_DE_____FORMAT_varAno_"; 'LISTAGEM DE FÉRIAS DE ' + Format(varAno))
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
            column(Empregado_Empregado__No__; Empregado."No.")
            {
            }
            column(Empregado_Empregado_Name; Empregado.Name)
            {
            }
            column(AnoCorrenteMarcadas; AnoCorrenteMarcadas)
            {
            }
            column(AnoCorrenteGozadas; AnoCorrenteGozadas)
            {
            }
            column(AnoAnteriorDireito; AnoAnteriorDireito)
            {
            }
            column(AnoCorrenteDireito; AnoCorrenteDireito)
            {
            }
            column(TotalaMarcar; TotalaMarcar)
            {
            }
            column(DiasExtra; DiasExtra)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(EmpregadoCaption; EmpregadoCaptionLbl)
            {
            }
            column(Ano_CorrenteCaption; Ano_CorrenteCaptionLbl)
            {
            }
            column(MarcadasCaption; MarcadasCaptionLbl)
            {
            }
            column(GozadasCaption; GozadasCaptionLbl)
            {
            }
            column("Total_Dias_FériasCaption"; Total_Dias_FériasCaptionLbl)
            {
            }
            column(Presente_AnoCaption; Presente_AnoCaptionLbl)
            {
            }
            column(Ano_AnteriorCaption; Ano_AnteriorCaptionLbl)
            {
            }
            column(Total_a_MarcarCaption; Total_a_MarcarCaptionLbl)
            {
            }
            column(Dias_ExtraCaption; Dias_ExtraCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //------------------------------------------------
                //Limpar variáveis
                //------------------------------------------------

                Clear(AnoCorrenteDireito);
                Clear(AnoAnteriorDireito);
                Clear(AnoCorrenteMarcadas);
                Clear(AnoCorrenteGozadas);
                Clear(VarTotalFaltas);
                Clear(TotalaMarcar);
                Clear(DiasExtra);
                Flag := false;

                //------------------------------------------------
                //Saber quantos dias tem este empregado para gozar
                //------------------------------------------------

                //Dias por direito
                //******************
                TabContratoEmpregado.Reset;
                TabContratoEmpregado.SetRange(TabContratoEmpregado."Cód. Empregado", Empregado."No.");
                TabContratoEmpregado.SetFilter(TabContratoEmpregado."Data Inicio Contrato", '<=%1', VarData);
                TabContratoEmpregado.SetFilter(TabContratoEmpregado."Data Fim Contrato", '>=%1|=%2', VarData, 0D);
                if TabContratoEmpregado.Find('-') then begin
                    //2009.03.18 - Empregados que entram no presente ano, independentemente do tipo de contrato têm
                    //direito a 2 dias por mes de contrato num maximo de 20 dias
                    //----------------------------------------------------------------------------------------------
                    if TabContratoEmpregado."Tipo Contrato" = TabContratoEmpregado."Tipo Contrato"::"Sem Termo" then begin
                        if Date2DMY(Empregado."Employment Date", 3) < varAno then
                            AnoCorrenteDireito := 22;
                        if Date2DMY(Empregado."Employment Date", 3) = varAno then begin
                            AnoCorrenteDireito := 2 * (12 - Date2DMY(TabContratoEmpregado."Data Inicio Contrato", 2));
                            if AnoCorrenteDireito > 20 then AnoCorrenteDireito := 20;
                        end;
                    end;
                    if TabContratoEmpregado."Tipo Contrato" = TabContratoEmpregado."Tipo Contrato"::"A Termo" then begin
                        //2009.03.18 - se o empregado entrou no presente ano, tem direito a 2 dias por cada mês, desde o mês
                        //de admissão até o mês de fim de contrato
                        //---------------------------------------------------------------------------------
                        if Date2DMY(Empregado."Employment Date", 3) = varAno then begin
                            AnoCorrenteDireito := 2 * (Date2DMY(TabContratoEmpregado."Data Fim Contrato", 2) -
                                                  Date2DMY(Empregado."Employment Date", 2));
                            if AnoCorrenteDireito > 20 then AnoCorrenteDireito := 20;
                        end;
                        //Se o empregado tem um contrato que começa no ano anterior e acaba no ano corrente, então
                        //adquire o direito de 22 dias no actual, mais o do ano anterior até um total de 30
                        //-------------------------------------------------------------------------------
                        TabContratoEmpregado.TestField("Data Fim Contrato");
                        if (Date2DMY(TabContratoEmpregado."Data Inicio Contrato", 3) = varAno - 1) and
                            (Date2DMY(TabContratoEmpregado."Data Fim Contrato", 3) = varAno) then
                            AnoCorrenteDireito := 22;
                    end;
                end;

                //Dias do ano anterior
                //********************
                if TabContratoEmpregado."Tipo Contrato" = TabContratoEmpregado."Tipo Contrato"::"Sem Termo" then begin
                    //Para empregados sem termo que entraram no ano anterior conta quantos dias eles tinham direito no ano anterior
                    //e desconta os já gozados
                    //------------------------------------------------------------------------
                    if Date2DMY(Empregado."Employment Date", 3) = varAno - 1 then begin
                        AnoAnteriorDireito := 2 * (12 - Date2DMY(Empregado."Employment Date", 2));
                        TabFeriasEmpregado.Reset;
                        TabFeriasEmpregado.SetRange(TabFeriasEmpregado."No. Empregado", Empregado."No.");
                        TabFeriasEmpregado.SetRange(TabFeriasEmpregado.Data, DMY2Date(1, 1, varAno - 1),
                                                    DMY2Date(31, 12, varAno - 1));
                        TabFeriasEmpregado.SetRange(TabFeriasEmpregado.Gozada, true);
                        TabFeriasEmpregado.SetRange(Tipo, 0);
                        if TabFeriasEmpregado.FindFirst then
                            AnoAnteriorDireito := AnoAnteriorDireito - TabFeriasEmpregado.Count;
                    end;
                    //Para empregados sem termo que entraram há mais de 2 anos conta qts dias marcados n foram gozados, pois eu n sei no
                    //ano passado quantos dias tinha direito por causa dos extra
                    //------------------------------------------------------------------------
                    if Date2DMY(Empregado."Employment Date", 3) < varAno - 1 then begin
                        TabFeriasEmpregado.Reset;
                        TabFeriasEmpregado.SetRange(TabFeriasEmpregado."No. Empregado", Empregado."No.");
                        TabFeriasEmpregado.SetRange(TabFeriasEmpregado.Data, DMY2Date(1, 1, varAno - 1),
                                                  DMY2Date(31, 12, varAno - 1));
                        TabFeriasEmpregado.SetRange(TabFeriasEmpregado.Gozada, false);
                        TabFeriasEmpregado.SetRange(Tipo, 0);
                        if TabFeriasEmpregado.Find('-') then
                            AnoAnteriorDireito := TabFeriasEmpregado.Count;
                    end;
                end;

                if TabContratoEmpregado."Tipo Contrato" = TabContratoEmpregado."Tipo Contrato"::"A Termo" then begin
                    //Para empregados cujo contrato começou no ano anterior e continua no presente ano
                    //conta quantos dias eles tinham direito no ano anterior e desconta os já gozados
                    //-----------------------------------------------------------------------------
                    if (Date2DMY(TabContratoEmpregado."Data Inicio Contrato", 3) = varAno - 1) and
                        (Date2DMY(TabContratoEmpregado."Data Fim Contrato", 3) = varAno) then begin
                        //Entrou no ano transacto e é o 1º contrato
                        if Empregado."Employment Date" = TabContratoEmpregado."Data Inicio Contrato" then begin
                            AnoAnteriorDireito := 2 * ((12 - Date2DMY(TabContratoEmpregado."Data Inicio Contrato", 2)) +
                                                  Date2DMY(TabContratoEmpregado."Data Fim Contrato", 2));
                            Flag := true;
                        end else begin
                            //Entrou no ano transacto, mas n é o primeiro contrato
                            if Date2DMY(Empregado."Employment Date", 3) = varAno - 1 then begin
                                AnoAnteriorDireito := 2 * (12 - Date2DMY(Empregado."Employment Date", 2));
                                if AnoAnteriorDireito > 20 then AnoAnteriorDireito := 20
                            end else
                                AnoAnteriorDireito := 22
                        end;
                    end;
                    TabFeriasEmpregado.Reset;
                    TabFeriasEmpregado.SetRange(TabFeriasEmpregado."No. Empregado", Empregado."No.");
                    TabFeriasEmpregado.SetRange(TabFeriasEmpregado.Data, DMY2Date(1, 1, varAno - 1),
                                                DMY2Date(31, 12, varAno - 1));
                    TabFeriasEmpregado.SetRange(TabFeriasEmpregado.Gozada, true);
                    TabFeriasEmpregado.SetRange(Tipo, 0);
                    if TabFeriasEmpregado.FindFirst then
                        AnoAnteriorDireito := AnoAnteriorDireito - TabFeriasEmpregado.Count;
                end;

                //Dias extra consoante houve faltas ou não
                //***************************************
                if (ConfigRH.Get) and (ConfigRH."Atribuição dias extra de féria" = true) then begin
                    if Date2DMY(Empregado."Employment Date", 3) < varAno - 1 then begin
                        TabHistAusencias.Reset;
                        TabHistAusencias.SetRange(TabHistAusencias."Employee No.", Empregado."No.");
                        TabHistAusencias.SetRange(TabHistAusencias."Influência No. dias férias", true);
                        TabHistAusencias.SetRange(TabHistAusencias."From Date", DMY2Date(1, 1, varAno - 1),
                                                                              DMY2Date(31, 12, varAno - 1));
                        TabHistAusencias.SetRange(TabHistAusencias.Justificada, false);
                        if TabHistAusencias.FindFirst then
                            DiasExtra := 0
                        else begin
                            TabHistAusencias.SetRange(TabHistAusencias.Justificada, true);
                            if TabHistAusencias.Find('-') then begin
                                repeat
                                    VarTotalFaltas := VarTotalFaltas + TabHistAusencias."Quantity (Base)";
                                until TabHistAusencias.Next = 0;
                            end;
                            if VarTotalFaltas <= 1 then
                                DiasExtra := 3
                            else
                                if VarTotalFaltas <= 2 then
                                    DiasExtra := 2
                                else
                                    if VarTotalFaltas <= 3 then
                                        DiasExtra := 1;
                        end;
                    end;
                end;

                //Total de dias
                //***************************************
                if Flag = true then begin
                    TotalaMarcar := AnoCorrenteDireito + AnoAnteriorDireito;
                    if TotalaMarcar > 30 then TotalaMarcar := 30;
                end else
                    TotalaMarcar := AnoCorrenteDireito + AnoAnteriorDireito + DiasExtra;

                //Férias Ano corrente Marcadas
                TabFeriasEmpregado.Reset;
                TabFeriasEmpregado.SetRange(TabFeriasEmpregado."No. Empregado", Empregado."No.");
                TabFeriasEmpregado.SetRange(TabFeriasEmpregado.Data, DMY2Date(1, 1, varAno), DMY2Date(31, 12, varAno));
                TabFeriasEmpregado.SetRange(TabFeriasEmpregado."Ano a que se refere", varAno);
                TabFeriasEmpregado.SetRange(Tipo, 0);
                if TabFeriasEmpregado.FindLast then
                    AnoCorrenteMarcadas := TabFeriasEmpregado.Count;

                //Férias Ano corrente gozadas
                TabFeriasEmpregado.Reset;
                TabFeriasEmpregado.SetRange(TabFeriasEmpregado."No. Empregado", Empregado."No.");
                TabFeriasEmpregado.SetRange(TabFeriasEmpregado.Data, DMY2Date(1, 1, varAno), DMY2Date(31, 12, varAno));
                TabFeriasEmpregado.SetRange(TabFeriasEmpregado."Ano a que se refere", varAno);
                TabFeriasEmpregado.SetRange(TabFeriasEmpregado.Gozada, true);
                TabFeriasEmpregado.SetRange(Tipo, 0);
                if TabFeriasEmpregado.FindLast then
                    AnoCorrenteGozadas := TabFeriasEmpregado.Count;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Listagem de Férias")
                {
                    Caption = 'Listagem de Férias';
                    field(VarData; VarData)
                    {
                        ApplicationArea = All;
                        Caption = 'Date';
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
        VarData := WorkDate;
        varAno := Date2DMY(VarData, 3);

        TabConfEmpresa.Get;
        TabConfEmpresa.CalcFields(TabConfEmpresa.Picture);
    end;

    var
        TabConfEmpresa: Record "Company Information";
        VarData: Date;
        TabFeriasEmpregado: Record "Férias Empregados";
        AnoCorrenteDireito: Integer;
        AnoAnteriorDireito: Integer;
        AnoCorrenteMarcadas: Integer;
        AnoCorrenteGozadas: Integer;
        TabHistAusencias: Record "Histórico Ausências";
        VarTotalFaltas: Decimal;
        TabContratoEmpregado: Record "Contrato Empregado";
        ConfigRH: Record "Config. Recursos Humanos";
        varAno: Integer;
        TotalaMarcar: Integer;
        DiasExtra: Integer;
        Flag: Boolean;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        EmpregadoCaptionLbl: Label 'Empregado';
        Ano_CorrenteCaptionLbl: Label 'Ano Corrente';
        MarcadasCaptionLbl: Label 'Marcadas';
        GozadasCaptionLbl: Label 'Gozadas';
        "Total_Dias_FériasCaptionLbl": Label 'Total Dias Férias';
        Presente_AnoCaptionLbl: Label 'Presente Ano';
        Ano_AnteriorCaptionLbl: Label 'Ano Anterior';
        Total_a_MarcarCaptionLbl: Label 'Total a Marcar';
        Dias_ExtraCaptionLbl: Label 'Dias Extra';
}

