report 53106 "Importar Férias"
{

    UseRequestPage = false;


    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPreReport()
    begin
        //TODO:Test this.
        varAno := Date2DMY(WorkDate, 3);

        //---------------------------
        //IMPORTAR OS DADOS DO EXCEL
        //---------------------------
        //Clear(Excel);
        //Create(Excel, false, true);
        //Excel := Excel.Application;


        //FicheiroFerias := currXMLport.Filename;
        UploadIntoStream('', '', '*.xlsx|*.*', FicheiroFerias, InStr);
        // Upload('', '', '*.xlsx|*.*', '', FicheiroFerias);


        /*
        //Excel.Workbooks._Open(FicheiroFerias);
        ExcelBuffer.OpenExcelWithName(FicheiroFerias);
        xlActWBook := Excel.ActiveWorkbook;
        xlSheets := xlActWBook.Worksheets;
        */

        ExcelBuffer.GetSheetsNameListFromStream(InStr, TempNameValueBufferOut);


        If TempNameValueBufferOut.findset then begin
            ExcelBuffer.OpenBookStream(InStr, TempNameValueBufferOut.Value);

            //XlWrkBkReader := XlWrkBkReader.Open(FicheiroFerias);

            repeat
                ExcelBuffer.ReadSheetContinous(TempNameValueBufferOut.Value, false);

                Clear(VarDiasdeFerias);
                Clear(VarTotalFaltas);
                Clear(VarDiasMarcados);
                //xlActPage := xlSheets.Item(I);
                TabEmpregado.Reset;
                //if TabEmpregado.Get(xlActPage.Name) then begin
                if TabEmpregado.Get(TempNameValueBufferOut.Value) then begin

                    //----------------------------------------------
                    //Se o empregado já tem férias marcadas vamos perguntar ao utilizador se as quer substituir
                    //Resposta=sim, então as férias já gozadas ficam iguais e todas as outras desse ano são eliminadas
                    //e substituidas pelas novas
                    //Resposta=não - não faz nada
                    //----------------------------------------------
                    TabFeriasEmpregado.Init;
                    TabFeriasEmpregado.SetRange(TabFeriasEmpregado."No. Empregado", TabEmpregado."No.");
                    TabFeriasEmpregado.SetRange(TabFeriasEmpregado.Data, DMY2Date(1, 1, varAno),
                                                DMY2Date(31, 12, varAno));
                    if TabFeriasEmpregado.Find('-') then begin
                        if Confirm(Text0002, false, TabEmpregado.Name, varAno) then begin
                            TabFeriasEmpregado2.Init;
                            TabFeriasEmpregado2.SetRange(TabFeriasEmpregado2."No. Empregado", TabEmpregado."No.");
                            TabFeriasEmpregado2.SetRange(TabFeriasEmpregado2.Data, DMY2Date(1, 1, varAno),
                                                    DMY2Date(31, 12, varAno));
                            TabFeriasEmpregado2.SetFilter(TabFeriasEmpregado2.Gozada, '%1', false);
                            if TabFeriasEmpregado2.Find('-') then
                                TabFeriasEmpregado2.DeleteAll;
                            MarcarFerias;

                        end;
                    end else
                        MarcarFerias;

                end;
            until TempNameValueBufferOut.next = 0;
        end;
    end;

    var
        ExcelBuffer: Record "Excel Buffer";
        TempNameValueBufferOut: Record "Name/Value Buffer" temporary;
        Fich: File;
        InStr: InStream;
        //XlWrkBkReader: DotNet WorkbookReader;
        //SheetNames: DotNet ArrayList;
        //CellPosition: DotNet CellPosition;
        //CellData: DotNet CellData;
        SheetName: Text[250];
        SheetsFound: Boolean;
        FicheiroFerias: Text[250];
        Ficheiro: File;
        TabEmpregado: Record Empregado;
        TabFeriasEmpregado: Record "Férias Empregados";
        TabHistAusencias: Record "Histórico Ausências";
        I: Integer;
        IColuna: Integer;
        Coluna: Text[2];
        Linha: Integer;
        VarDiasdeFerias: Integer;
        VarTotalFaltas: Decimal;
        VarDiasMarcados: Integer;
        TabFeriasEmpregado2: Record "Férias Empregados";
        TabContratoEmpregado: Record "Contrato Empregado";
        TabFeriasEmpregado3: Record "Férias Empregados";
        varAno: Integer;
        AnoCorrenteDireito: Integer;
        AnoAnteriorDireito: Integer;
        Flag: Boolean;
        ConfigRH: Record "Config. Recursos Humanos";
        DiasExtra: Integer;
        Text0001: Label 'O empregado %1 tem direito a %2 dias de férias e introduziu %3. \A operação de importação vai ser abortada.';
        Text0002: Label 'Já existem férias marcadas para o empregado %1, para o ano de %2. Deseja substituí-las?';


    procedure IncrCol(OldCol: Text[30]) NewCol: Text[30]
    begin
        if OldCol = 'A' then
            NewCol := 'B';

        if OldCol = 'B' then
            NewCol := 'C';

        if OldCol = 'C' then
            NewCol := 'D';

        if OldCol = 'D' then
            NewCol := 'E';
        if OldCol = 'E' then
            NewCol := 'F';
        if OldCol = 'F' then
            NewCol := 'G';

        if OldCol = 'G' then
            NewCol := 'H';
        if OldCol = 'H' then
            NewCol := 'I';
        if OldCol = 'I' then
            NewCol := 'J';

        if OldCol = 'J' then
            NewCol := 'K';

        if OldCol = 'K' then
            NewCol := 'L';
        if OldCol = 'L' then
            NewCol := 'M';

        if OldCol = 'M' then
            NewCol := 'N';
        if OldCol = 'N' then
            NewCol := 'O';
    end;


    procedure MarcarFerias()
    begin

        //------------------------------------------------
        //Saber quantos dias tem este empregado para gozar
        //------------------------------------------------

        //Dias por direito
        //******************
        TabContratoEmpregado.Reset;
        TabContratoEmpregado.SetRange(TabContratoEmpregado."Cód. Empregado", TabEmpregado."No.");
        TabContratoEmpregado.SetFilter(TabContratoEmpregado."Data Inicio Contrato", '<=%1', WorkDate);
        TabContratoEmpregado.SetFilter(TabContratoEmpregado."Data Fim Contrato", '>=%1|=%2', WorkDate, 0D);
        if TabContratoEmpregado.Find('-') then begin

            //2009.03.18 - Empregados que entram no presente ano, independentemente do tipo de contrato têm
            //direito a 2 dias por mes de contrato num maximo de 20 dias
            //----------------------------------------------------------------------------------------------
            if TabContratoEmpregado."Tipo Contrato" = TabContratoEmpregado."Tipo Contrato"::"Sem Termo" then begin

                if Date2DMY(TabEmpregado."Employment Date", 3) < varAno then
                    AnoCorrenteDireito := 22;

                if Date2DMY(TabEmpregado."Employment Date", 3) = varAno then begin
                    AnoCorrenteDireito := 2 * (12 - Date2DMY(TabContratoEmpregado."Data Inicio Contrato", 2));
                    if AnoCorrenteDireito > 20 then AnoCorrenteDireito := 20;
                end;
            end;

            if TabContratoEmpregado."Tipo Contrato" = TabContratoEmpregado."Tipo Contrato"::"A Termo" then begin
                //2009.03.18 - se o empregado entrou no presente ano, tem direito a 2 dias por cada mês, desde o mês
                //de admissão até o mês de fim de contrato
                //---------------------------------------------------------------------------------
                if Date2DMY(TabEmpregado."Employment Date", 3) = varAno then begin
                    AnoCorrenteDireito := 2 * (Date2DMY(TabContratoEmpregado."Data Fim Contrato", 2) -
                                          Date2DMY(TabEmpregado."Employment Date", 2));
                    if AnoCorrenteDireito > 20 then AnoCorrenteDireito := 20;
                end;

                //Se o empregado tem um contrato que começa no ano anterior e acaba no ano corrente, então
                //adquire o direito de 22 dias no actual, mais o do ano anterior até um total de 30
                //-------------------------------------------------------------------------------
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
            if Date2DMY(TabEmpregado."Employment Date", 3) = varAno - 1 then begin
                AnoAnteriorDireito := 2 * (12 - Date2DMY(TabEmpregado."Employment Date", 2));

                TabFeriasEmpregado.Reset;
                TabFeriasEmpregado.SetRange(TabFeriasEmpregado."No. Empregado", TabEmpregado."No.");
                TabFeriasEmpregado.SetRange(TabFeriasEmpregado.Data, DMY2Date(1, 1, varAno - 1),
                                            DMY2Date(31, 12, varAno - 1));
                TabFeriasEmpregado.SetRange(TabFeriasEmpregado.Gozada, true);
                if TabFeriasEmpregado.Find('-') then
                    AnoAnteriorDireito := AnoAnteriorDireito - TabFeriasEmpregado.Count;
            end;

            //Para empregados sem termo que entraram há mais de 2 anos conta qts dias marcados n foram gozados, pois eu n sei no
            //ano passado quantos dias tinha direito por causa dos extra
            //------------------------------------------------------------------------
            if Date2DMY(TabEmpregado."Employment Date", 3) < varAno - 1 then begin
                TabFeriasEmpregado.Reset;
                TabFeriasEmpregado.SetRange(TabFeriasEmpregado."No. Empregado", TabEmpregado."No.");
                TabFeriasEmpregado.SetRange(TabFeriasEmpregado.Data, DMY2Date(1, 1, varAno - 1),
                                          DMY2Date(31, 12, varAno - 1));
                TabFeriasEmpregado.SetRange(TabFeriasEmpregado.Gozada, false);
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
                if TabEmpregado."Employment Date" = TabContratoEmpregado."Data Inicio Contrato" then begin
                    AnoAnteriorDireito := 2 * ((12 - Date2DMY(TabContratoEmpregado."Data Inicio Contrato", 2)) +
                                          Date2DMY(TabContratoEmpregado."Data Fim Contrato", 2));
                    Flag := true;
                end else begin
                    //Entrou no ano transacto, mas n é o primeiro contrato
                    if Date2DMY(TabEmpregado."Employment Date", 3) = varAno - 1 then begin
                        AnoAnteriorDireito := 2 * (12 - Date2DMY(TabEmpregado."Employment Date", 2));
                        if AnoAnteriorDireito > 20 then AnoAnteriorDireito := 20
                    end else
                        AnoAnteriorDireito := 22
                end;
            end;

            TabFeriasEmpregado.Reset;
            TabFeriasEmpregado.SetRange(TabFeriasEmpregado."No. Empregado", TabEmpregado."No.");
            TabFeriasEmpregado.SetRange(TabFeriasEmpregado.Data, DMY2Date(1, 1, varAno - 1),
                                        DMY2Date(31, 12, varAno - 1));
            TabFeriasEmpregado.SetRange(TabFeriasEmpregado.Gozada, true);
            if TabFeriasEmpregado.Find('-') then
                AnoAnteriorDireito := AnoAnteriorDireito - TabFeriasEmpregado.Count;

        end;


        //Dias extra consoante houve faltas ou não
        //***************************************
        if (ConfigRH.Get) and (ConfigRH."Atribuição dias extra de féria" = true) then begin

            if Date2DMY(TabEmpregado."Employment Date", 3) < varAno - 1 then begin
                TabHistAusencias.Reset;
                TabHistAusencias.SetRange(TabHistAusencias."Employee No.", TabEmpregado."No.");
                TabHistAusencias.SetRange(TabHistAusencias."Influência No. dias férias", true);
                TabHistAusencias.SetRange(TabHistAusencias."From Date", DMY2Date(1, 1, varAno - 1),
                                                                     DMY2Date(31, 12, varAno - 1));
                TabHistAusencias.SetRange(TabHistAusencias.Justificada, false);
                if TabHistAusencias.Find('-') then
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
            VarDiasdeFerias := AnoCorrenteDireito + AnoAnteriorDireito;
            if VarDiasdeFerias > 30 then VarDiasdeFerias := 30;
        end else
            VarDiasdeFerias := AnoCorrenteDireito + AnoAnteriorDireito + DiasExtra;



        //---------------------------
        //FIM
        //---------------------------

        Coluna := 'A';
        for IColuna := 1 to 12 do begin
            Coluna := IncrCol(Coluna);
            for Linha := 3 to 33 do begin
                ExcelBuffer.get(Linha, IColuna);
                //if (Format(xlActPage.Range(Coluna + Format(Linha)).Value) = 'X') or
                //   (Format(xlActPage.Range(Coluna + Format(Linha)).Value) = 'A') then begin
                if (ExcelBuffer."Cell Value as Text" = 'A') or
                    (ExcelBuffer."Cell Value as Text" = 'X') then begin
                    TabFeriasEmpregado.Init;
                    TabFeriasEmpregado."No. Empregado" := TabEmpregado."No.";
                    TabFeriasEmpregado.Data := DMY2Date(Linha - 2, IColuna, Date2DMY(WorkDate, 3));
                    if (ExcelBuffer."Cell Value as Text" = 'A') then
                        TabFeriasEmpregado."Ano a que se refere" := varAno - 1;
                    TabFeriasEmpregado."Qtd." := 1;
                    VarDiasMarcados := VarDiasMarcados + 1;
                    TabFeriasEmpregado3.Reset;
                    if not TabFeriasEmpregado3.Get(TabEmpregado."No.", DMY2Date(Linha - 2, IColuna, Date2DMY(WorkDate, 3))) then
                        TabFeriasEmpregado.Insert;
                end;
            end;
        end;
        if VarDiasMarcados > VarDiasdeFerias then Error(Text0001, TabEmpregado."No.", VarDiasdeFerias, VarDiasMarcados);
    end;
}

