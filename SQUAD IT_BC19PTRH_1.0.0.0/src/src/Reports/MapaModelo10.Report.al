report 53049 "Mapa Modelo 10"
{
    // //-------------------------------------------------------
    //               Ficheiro Anexo J
    // //--------------------------------------------------------
    // É um ficheiro que deve ser entregue anualmente às finanças,
    // pela empresa, com os rendimentos e rentenções de cada empregado
    // 
    // Este mapa deve sair em formato txt e como tal numa primeira fase
    // exporta os dados para uma tabela criada para este tipo de mapas
    // (Tabela Temp Ficheiro Texto) e depois corre um dataport (Temp Ficheiro Texto)
    // para criar o ficheiro txt
    // 
    // Tipos de Registo:
    //   001 - Header do Ficheiro
    //   003 - Header da Declaração
    //   003 - Header da Declaração Anual
    //   004 - Detalhe da Declaração Anual
    //   005 - Trailer da Declaração Anual
    // 
    //   J01 - Header Anexo J/Modelo 10
    //   J02 - Detalhe Anexo J/Modelo 10
    //   J99 - Trailer Anexo J/Modelo 10
    // 
    //   006 - Trailer da Declaração
    //   999 - Trailer do Ficheiro
    // //-------------------------------------------------------
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\MapaModelo10.rdl';

    Permissions = TableData "Tabela Temp Ficheiros Texto" = rimd;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(EmpregadoFiltro; Empregado)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                //Copia os registo do EmpregadoFiltro para a tabela temporária para
                //ficar só com os empregados que devo comtemplar
                TabTempEmpregado.Init;
                TabTempEmpregado.TransferFields(EmpregadoFiltro);
                TabTempEmpregado.Insert;

                //18.05.2007 - Como estes campos passaram a ser flowfields faço o calcfields
                TabTempEmpregado.CalcFields(TabTempEmpregado."Emplymt. Contract Code", TabTempEmpregado."Cód. Cat. Profissional",
                                            TabTempEmpregado."Cód. Cat. Prof QP", TabTempEmpregado."Grau Função", TabTempEmpregado."Cód. Horário");
                TabTempEmpregado.CalcFields(TabTempEmpregado."Descrição Cat Prof", TabTempEmpregado."Descrição Cat Prof QP",
                                            TabTempEmpregado."Descrição Grau Função");
            end;
        }
        dataitem(ImpostoExtraSobretaxa; "Hist. Linhas Movs. Empregado")
        {
            DataItemTableView = SORTING("Employee No.", "Tipo Rendimento") WHERE("Tipo Rendimento" = FILTER(<> A));

            trigger OnAfterGetRecord()
            begin
                //Para não apanhar os empregados que não foram contemplados no EmpregadoFiltro
                TabTempEmpregado.Reset;
                if not TabTempEmpregado.Get(ImpostoExtraSobretaxa."Employee No.") then
                    CurrReport.Skip;

                valorSobreTaxa := valorSobreTaxa + Round(ImpostoExtraSobretaxa.Valor, 0.01);
            end;

            trigger OnPreDataItem()
            begin
                TabRubrica.Reset;

                //2014.01.06 - Em 2014 o Modelo 10 relativo a 2013 tem de exportar no campo Sobretaxa a Sobretaxa em sede de IRS
                if Date2DMY(DataIni, 3) = 2011 then
                    TabRubrica.SetRange(TabRubrica."Imposto Extraordinário", true)
                else
                    TabRubrica.SetRange(TabRubrica."Sobretaxa em Sede de IRS", true);
                //Fim

                if TabRubrica.FindFirst then
                    ImpostoExtraSobretaxa.SetRange(ImpostoExtraSobretaxa."Payroll Item Code", TabRubrica.Código);

                ImpostoExtraSobretaxa.SetRange(ImpostoExtraSobretaxa."Data Registo", DataIni, DataFim);
            end;
        }
        dataitem("Hist. Linhas Movs. Empregado"; "Hist. Linhas Movs. Empregado")
        {
            DataItemTableView = SORTING("Employee No.", "Tipo Rendimento") WHERE("Tipo Rendimento" = FILTER(<> A));

            trigger OnAfterGetRecord()
            begin
                //Para apanhar só os registos que são do Genero IRS ou IRS Sub. Férias  ou IRS Sub. NAtal

                TabRubrica.Reset;
                TabRubrica.SetRange(TabRubrica.Código, "Hist. Linhas Movs. Empregado"."Payroll Item Code");
                if TabRubrica.FindFirst then begin
                    if (TabRubrica.Genero <> TabRubrica.Genero::IRS) and
                      (TabRubrica.Genero <> TabRubrica.Genero::"IRS Sub. Férias") and
                      (TabRubrica.Genero <> TabRubrica.Genero::"IRS Sub. Natal") then
                        CurrReport.Skip
                    else begin
                        if (TabRubrica."Imposto Extraordinário") or (TabRubrica."Sobretaxa em Sede de IRS") then
                            CurrReport.Skip
                        else begin
                            //Para não apanhar os empregados que não foram contemplados no EmpregadoFiltro
                            TabTempEmpregado.Reset;
                            if not TabTempEmpregado.Get("Hist. Linhas Movs. Empregado"."Employee No.") then
                                CurrReport.Skip
                            else begin
                                if "Hist. Linhas Movs. Empregado"."Tipo Rendimento" = "Hist. Linhas Movs. Empregado"."Tipo Rendimento"::A then
                                    TotalA := TotalA + Valor;
                                if "Hist. Linhas Movs. Empregado"."Tipo Rendimento" = "Hist. Linhas Movs. Empregado"."Tipo Rendimento"::B then
                                    TotalB := TotalB + Valor;
                                if "Hist. Linhas Movs. Empregado"."Tipo Rendimento" = "Hist. Linhas Movs. Empregado"."Tipo Rendimento"::E then
                                    TotalE := TotalE + Valor;
                                if "Hist. Linhas Movs. Empregado"."Tipo Rendimento" = "Hist. Linhas Movs. Empregado"."Tipo Rendimento"::EE then
                                    TotalEE := TotalEE + Valor;
                                if "Hist. Linhas Movs. Empregado"."Tipo Rendimento" = "Hist. Linhas Movs. Empregado"."Tipo Rendimento"::F then
                                    TotalF := TotalF + Valor;
                                if "Hist. Linhas Movs. Empregado"."Tipo Rendimento" = "Hist. Linhas Movs. Empregado"."Tipo Rendimento"::G then
                                    TotalG := TotalG + Valor;
                                if "Hist. Linhas Movs. Empregado"."Tipo Rendimento" = "Hist. Linhas Movs. Empregado"."Tipo Rendimento"::H then
                                    TotalH := TotalH + Valor;
                            end;
                        end;
                    end;
                end;
            end;

            trigger OnPostDataItem()
            begin
                //>>>>>>  LINHA J01 - Header Anexo J >>>>>>>>>>>>>>>>>>>>>>>>>>
                TabelaTempFichTexto.Init;
                TabelaTempFichTexto."Tipo Ficheiro" := TabelaTempFichTexto."Tipo Ficheiro"::AnexoJ;
                TabelaTempFichTexto.NLinha := TabelaTempFichTexto.NLinha + 1;
                TabelaTempFichTexto.Texto1 := 'J01'
                + PadStr('0', 9 - StrLen(InfEmpresa."VAT Registration No."), '0') + InfEmpresa."VAT Registration No."  //NIF
                + Format(DataIni, 0, '<Year4>')                                                                      //Ano
                + DelChr(ConvertStr(Format(Abs(Round(TotalA, 0.01)), 14, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')              //Rentenções A
                + DelChr(ConvertStr(Format(Abs(Round(TotalB, 0.01)), 14, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')              //Rentenções B
                + DelChr(ConvertStr(Format(Abs(Round(TotalE, 0.01)), 14, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')              //Rentenções E
                + DelChr(ConvertStr(Format(Abs(Round(TotalEE, 0.01)), 14, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')             //Rentenções EE
                + DelChr(ConvertStr(Format(Abs(Round(TotalF, 0.01)), 14, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')              //Rentenções F
                + DelChr(ConvertStr(Format(Abs(Round(TotalG, 0.01)), 14, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')              //Rentenções G
                + DelChr(ConvertStr(Format(Abs(Round(TotalH, 0.01)), 14, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')              //Rentenções H
                + DelChr(ConvertStr(Format(Round(RetencoesIRC, 0.01), 14, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')             //Ren. IRC
                + DelChr(ConvertStr(Format(Round(RetencoesA, 0.01), 14, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')               //Ren. A
                + DelChr(ConvertStr(Format(Round(Compensacoes, 0.01), 14, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')             //Compensacoes
                + DelChr(ConvertStr(Format(Abs(Round(valorSobreTaxa, 0.01)), 14, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')      //SobreTaxa
                + PadStr(' ', 13, ' ');
                TabelaTempFichTexto.Insert;
            end;

            trigger OnPreDataItem()
            begin
                "Hist. Linhas Movs. Empregado".SetRange("Hist. Linhas Movs. Empregado"."Data Registo", DataIni, DataFim);
            end;
        }
        dataitem("Hist. Linhas Movs. Empregado2"; "Hist. Linhas Movs. Empregado")
        {
            DataItemTableView = SORTING("Employee No.", "Tipo Rendimento") WHERE("Tipo Rendimento" = FILTER(<> A));

            trigger OnAfterGetRecord()
            var
                rAuxEmp: Record Empregado;
            begin
                //Novo codigo versão 2013 que estava no Group Section
                if "Hist. Linhas Movs. Empregado2"."Employee No." <> CodEmp then begin
                    if rAuxEmp.Get(CodEmp) then;
                    CodEmp := "Hist. Linhas Movs. Empregado2"."Employee No.";
                    //Para não apanhar os empregados que não foram contemplados no EmpregadoFiltro
                    TabTempEmpregado.Reset;
                    if TabTempEmpregado.Get("Hist. Linhas Movs. Empregado2"."Employee No.") then begin
                        TotalRendimentosAno := TotalRendimentosAno + RendimentosAno;
                        //>>>>>>  LINHA J02 - Detalhe Anexo J >>>>>>>>>>>>>>>>>>>>>>>>>>
                        Empregado.SetRange(Empregado."No.", "Hist. Linhas Movs. Empregado2"."Employee No.");
                        Empregado.FindFirst;
                        if (Abs(Round(RendimentosAno, 0.01)) <> 0.0) or
                            (Abs(Round(ImportanciasRetidas, 0.01)) <> 0.0) then begin
                            NLinha := NLinha + 1;
                            TabelaTempFichTexto.Init;
                            TabelaTempFichTexto."Tipo Ficheiro" := TabelaTempFichTexto."Tipo Ficheiro"::AnexoJ;
                            TabelaTempFichTexto.NLinha := TabelaTempFichTexto.NLinha + 1;
                            TabelaTempFichTexto.Texto1 := 'J02'
                            + PadStr('0', 7 - StrLen(Format(NLinha)), '0') + Format(NLinha)                             //nlinha
                            + PadStr('0', 9 - StrLen(rAuxEmp."No. Contribuinte"), '0') + rAuxEmp."No. Contribuinte"   //NIF
                            + '00000000000000'                                                                      //Rendimentos anos anteriores
                            + '00'                                                                                  //Nº ANos
                            + DelChr(ConvertStr(Format(Abs(Round(RendimentosAno, 0.01)), 15, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')//Rendimentos Ano
                                                                                                                                                 //+ PADSTR(FORMAT("Hist. Linhas Movs. Empregado2"."Tipo Rendimento"),2,' ')
                            + PadStr(Format(rAuxEmp."Tipo Rendimento"), 3, ' ')//tipo rendimento
                            + PadStr(Format(rAuxEmp."Local Obtenção Rendimento"), 2, ' ')                                               //Local rendimento
                            + DelChr(ConvertStr(Format(Abs(Round(ImportanciasRetidas, 0.01)), 14, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')
                            + DelChr(ConvertStr(Format(Abs(Round(Desconto, 0.01)), 14, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')
                            + DelChr(ConvertStr(Format(Abs(Round(ValorSindicato, 0.01)), 14, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')
                            + DelChr(ConvertStr(Format(Abs(SobreTaxa), 14, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')
                            + PadStr(' ', 66, ' ');
                            TabelaTempFichTexto.Insert;
                            TotalRegistosJ99 := TotalRegistosJ99 + 1;
                        end;
                    end;
                end;
                TabTempEmpregado.Reset;
                if TabTempEmpregado.Get("Hist. Linhas Movs. Empregado2"."Employee No.") then begin
                    //--------------------------------------------------------
                    //Limpar Variáveis
                    //--------------------------------------------------------
                    if ("Hist. Linhas Movs. Empregado2"."Employee No." <> AuxEmp) or
                       ("Hist. Linhas Movs. Empregado2"."Tipo Rendimento" <> AuxTipoRend) then begin
                        RendimentosAno := 0;
                        ImportanciasRetidas := 0;
                        Desconto := 0;
                        ValorSindicato := 0;
                        SobreTaxa := 0;
                    end;
                    AuxEmp := "Hist. Linhas Movs. Empregado2"."Employee No.";
                    AuxTipoRend := "Hist. Linhas Movs. Empregado2"."Tipo Rendimento";
                    //-----------------------------------------------------------------
                    //Calcular qual os rendimentos do ano - sobre os quais incide irs
                    //-----------------------------------------------------------------
                    Flag := false;//HG 21.01.08
                    TabRubrica.Reset;
                    TabRubrica.SetFilter(TabRubrica.Genero, '%1|%2|%3',
                                         TabRubrica.Genero::IRS,
                                         TabRubrica.Genero::"IRS Sub. Férias",
                                         TabRubrica.Genero::"IRS Sub. Natal");
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
                                        RendimentosAno := RendimentosAno + "Hist. Linhas Movs. Empregado2".Valor - varLimite;
                                        Flag := true;
                                    end;
                                until (TabRubricaLinhas.Next = 0) or (Flag);
                            end;
                        until (TabRubrica.Next = 0) or (Flag = true);

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
                    //2014.01.06 - Em 2014 o Modelo 10 relativo a 2013 tem de exportar no campo Sobretaxa a Sobretaxa em sede de IRS
                    if Date2DMY(DataIni, 3) = 2011 then
                        TabRubrica.SetRange(TabRubrica."Imposto Extraordinário", true)//2011.12.29
                    else
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
            end;

            trigger OnPostDataItem()
            var
                rAuxEmp: Record Empregado;
            begin
                //Novo codigo versão 2013 que estava no Group Section
                if rAuxEmp.Get("Hist. Linhas Movs. Empregado2"."Employee No.") then begin
                    //Para não apanhar os empregados que não foram contemplados no EmpregadoFiltro
                    TabTempEmpregado.Reset;
                    if TabTempEmpregado.Get("Hist. Linhas Movs. Empregado2"."Employee No.") then begin
                        TotalRendimentosAno := TotalRendimentosAno + RendimentosAno;
                        //>>>>>>  LINHA J02 - Detalhe Anexo J >>>>>>>>>>>>>>>>>>>>>>>>>>
                        Empregado.SetRange(Empregado."No.", "Hist. Linhas Movs. Empregado2"."Employee No.");
                        Empregado.Find('-');
                        if (Abs(Round(RendimentosAno, 0.01)) <> 0.0) or
                            (Abs(Round(ImportanciasRetidas, 0.01)) <> 0.0) then begin
                            NLinha := NLinha + 1;
                            TabelaTempFichTexto.Init;
                            TabelaTempFichTexto."Tipo Ficheiro" := TabelaTempFichTexto."Tipo Ficheiro"::AnexoJ;
                            TabelaTempFichTexto.NLinha := TabelaTempFichTexto.NLinha + 1;
                            TabelaTempFichTexto.Texto1 := 'J02'
                            + PadStr('0', 7 - StrLen(Format(NLinha)), '0') + Format(NLinha)                             //nlinha
                            + PadStr('0', 9 - StrLen(rAuxEmp."No. Contribuinte"), '0') + rAuxEmp."No. Contribuinte"   //NIF
                            + '00000000000000'                                                                      //Rendimentos anos anteriores
                            + '00'                                                                                  //Nº ANos
                            + DelChr(ConvertStr(Format(Abs(Round(RendimentosAno, 0.01)), 15, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')//Rendimentos Ano
                            + PadStr(Format(rAuxEmp."Tipo Rendimento"), 3, ' ')//tipo rendimento
                            + PadStr(Format(rAuxEmp."Local Obtenção Rendimento"), 2, ' ')                                               //Local rendimento
                            + DelChr(ConvertStr(Format(Abs(Round(ImportanciasRetidas, 0.01)), 14, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')
                            + DelChr(ConvertStr(Format(Abs(Round(Desconto, 0.01)), 14, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')
                            + DelChr(ConvertStr(Format(Abs(Round(ValorSindicato, 0.01)), 14, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')
                            + DelChr(ConvertStr(Format(Abs(SobreTaxa), 14, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')
                            + PadStr(' ', 66, ' ');
                            TabelaTempFichTexto.Insert;
                            TotalRegistosJ99 := TotalRegistosJ99 + 1;
                        end;
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                "Hist. Linhas Movs. Empregado2".SetRange("Hist. Linhas Movs. Empregado2"."Data Registo", DataIni, DataFim);
                TotalRendimentosAno := 0;
                CodEmp := '';
            end;
        }
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("No.");

            trigger OnAfterGetRecord()
            begin
                //2008.06.06 - apanhar os fornecedores para o Anexo J
                Clear(ImportanciasRetidas);
                Clear(RendimentosAno);

                if ConfRH.Get() and (ConfRH."Mod10 - Incluir Fornecedores") then begin
                    if (Vendor."Income Type HR" <> Vendor."Income Type HR"::B) and
                       (Vendor."Income Type HR" <> Vendor."Income Type HR"::F) then begin
                        CurrReport.Skip;
                    end else begin
                        TabGLEntry.Reset;
                        TabGLEntry.SetRange(TabGLEntry."Posting Date", DataIni, DataFim);
                        TabGLEntry.SetRange(TabGLEntry."Source Type", TabGLEntry."Source Type"::Vendor);
                        TabGLEntry.SetRange(TabGLEntry."Source No.", Vendor."No.");
                        TabGLEntry.SetFilter(TabGLEntry."G/L Account No.", ConfRH."Mod10-Forn - Conta Valor Reten");
                        if TabGLEntry.FindSet then
                            repeat
                                ImportanciasRetidas := ImportanciasRetidas + TabGLEntry.Amount;
                            until TabGLEntry.Next = 0;
                        TabGLEntry.Reset;
                        TabGLEntry.SetRange(TabGLEntry."Posting Date", DataIni, DataFim);
                        TabGLEntry.SetRange(TabGLEntry."Source Type", TabGLEntry."Source Type"::Vendor);
                        TabGLEntry.SetRange(TabGLEntry."Source No.", Vendor."No.");
                        TabGLEntry.SetFilter(TabGLEntry."G/L Account No.", ConfRH."Mod10-Forn - Conta Valor Sujei");
                        if TabGLEntry.FindSet then
                            repeat
                                RendimentosAno := RendimentosAno + TabGLEntry.Amount;
                            until TabGLEntry.Next = 0;

                        TotalImpRetidas := TotalImpRetidas + ImportanciasRetidas;
                        TotalRendimentosAno := TotalRendimentosAno + RendimentosAno;
                        if (ImportanciasRetidas = 0) and (RendimentosAno = 0) then
                            CurrReport.Skip
                        else begin
                            NLinha := NLinha + 1;//2009.02.09
                            TabelaTempFichTexto.Init;
                            TabelaTempFichTexto."Tipo Ficheiro" := TabelaTempFichTexto."Tipo Ficheiro"::AnexoJ;
                            TabelaTempFichTexto.NLinha := TabelaTempFichTexto.NLinha + 1;
                            TabelaTempFichTexto.Texto1 := 'J02'
                            + PadStr('0', 7 - StrLen(Format(NLinha)), '0') + Format(NLinha)                             //nlinha
                            + PadStr('0', 9 - StrLen(Vendor."VAT Registration No."), '0') + Vendor."VAT Registration No."   //NIF
                            + '00000000000000'                                                                      //Rendimentos anos anteriores
                            + '00'                                                                                  //Nº ANos
                           + DelChr(ConvertStr(Format(Abs(Round(RendimentosAno, 0.01)), 15, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')//Rendimentos Ano
                           + PadStr(Format(Vendor."Income Type HR"), 3, ' ')                                     //tipo rendimento
                           + PadStr(Format(Vendor."Retention Income Local"), 2, ' ')                                               //Local rendimento
                          + DelChr(ConvertStr(Format(Abs(Round(ImportanciasRetidas, 0.01)), 14, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')
                          + DelChr(ConvertStr(Format(Abs(Round(Desconto, 0.01)), 14, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')
                          + DelChr(ConvertStr(Format(Abs(Round(ValorSindicato, 0.01)), 14, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',') + PadStr(' ', 79, ' ');
                            TabelaTempFichTexto.Insert;
                            TotalRegistosJ99 := TotalRegistosJ99 + 1;
                        end;
                    end;
                end else
                    CurrReport.Skip;
            end;
        }
        dataitem(Total; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

            trigger OnAfterGetRecord()
            begin
                //>>>>>>  LINHA J99 - Trailer Anexo J >>>>>>>>>>>>>>>>>>>>>>>>>>
                TabelaTempFichTexto.Init;
                TabelaTempFichTexto."Tipo Ficheiro" := TabelaTempFichTexto."Tipo Ficheiro"::AnexoJ;
                TabelaTempFichTexto.NLinha := TabelaTempFichTexto.NLinha + 1;
                TabelaTempFichTexto.Texto1 := 'J99'
                + DelChr(ConvertStr(Format(Round(Abs(TotalA + TotalB + TotalE + TotalEE + TotalF + TotalG + TotalH)
                        + RetencoesIRC, 0.01), 16, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')
                + DelChr(ConvertStr(Format(Round(Abs(TotalA + TotalB + TotalE + TotalEE + TotalF + TotalG + TotalH)
                        + RetencoesIRC + RetencoesA - Compensacoes, 0.01), 16, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')
                + DelChr(ConvertStr(Format(Abs(Round(TotalImpRetidas, 0.01)), 16, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')
                + DelChr(ConvertStr(Format(Abs(Round(TotalRendimentosAno, 0.01)), 16, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')
                + '000000000000000'
                + DelChr(ConvertStr(Format(Abs(Round(TotalDescontos, 0.01)), 15, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')
                + DelChr(ConvertStr(Format(Abs(Round(TotalSindicato, 0.01)), 15, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')
                + DelChr(ConvertStr(Format(Abs(Round(TotSobreTaxa, 0.01)), 15, '<Sign><Integer><Decimals,3>'), ' ', '0'), '=', ',')
                + ConvertStr(Format(TotalRegistosJ99, 7, '<Sign><Integer>'), ' ', '0')       //Nº pessoas ao serviço
                + PadStr(' ', 45, ' ');

                TabelaTempFichTexto.Insert;
            end;
        }
        dataitem("Company Information"; "Company Information")
        {
            column(CompInf_Name; "Company Information".Name)
            {
            }
            column(CompInf_Name2; "Company Information"."Name 2")
            {
            }
            column(CompInf_Address; "Company Information".Address)
            {
            }
            column(CompInf_Address2; "Company Information"."Address 2")
            {
            }
            column(CompInf_City; "Company Information".City)
            {
            }
            column(CompInf_PostCode; "Company Information"."Post Code")
            {
            }
            column(CompInf_Picture; "Company Information".Picture)
            {
            }
            column(CompInf_Phone; 'Nº Telefone: ' + "Company Information"."Phone No.")
            {
            }
            column(CompInf_VatNo; 'Nº Contribuinte: ' + "Company Information"."VAT Registration No.")
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            var
                l_PeriodosProc: Record "Periodos Processamento";
            begin
            end;
        }
        dataitem("Tabela Temp Ficheiros Texto"; "Tabela Temp Ficheiros Texto")
        {
            DataItemTableView = SORTING("Tipo Ficheiro", NLinha) WHERE("Tipo Ficheiro" = CONST(AnexoJ), NLinha = CONST(6));
            column(NIF; CopyStr("Tabela Temp Ficheiros Texto".Texto1, 4, 9))
            {
            }
            column(ANO; CopyStr("Tabela Temp Ficheiros Texto".Texto1, 13, 4))
            {
            }
            column(A_TrabDep; CopyStr("Tabela Temp Ficheiros Texto".Texto1, 17, 13))
            {
            }
            column(B_RendEmp; CopyStr("Tabela Temp Ficheiros Texto".Texto1, 30, 13))
            {
            }
            column(E_OutrosCap; CopyStr("Tabela Temp Ficheiros Texto".Texto1, 43, 13))
            {
            }
            column(EE_SaldosCredores; CopyStr("Tabela Temp Ficheiros Texto".Texto1, 56, 13))
            {
            }
            column(F_Prediais; CopyStr("Tabela Temp Ficheiros Texto".Texto1, 69, 13))
            {
            }
            column(G_IncPatrim; CopyStr("Tabela Temp Ficheiros Texto".Texto1, 82, 13))
            {
            }
            column(H_Pens; CopyStr("Tabela Temp Ficheiros Texto".Texto1, 95, 13))
            {
            }
            column(RentIRC; CopyStr("Tabela Temp Ficheiros Texto".Texto1, 108, 13))
            {
            }
            column(RentTaxLib; CopyStr("Tabela Temp Ficheiros Texto".Texto1, 121, 13))
            {
            }
            column(CompIRS_IRC; CopyStr("Tabela Temp Ficheiros Texto".Texto1, 134, 13))
            {
            }
            column(RentSobretaxa; CopyStr("Tabela Temp Ficheiros Texto".Texto1, 147, 13))
            {
            }
        }
        dataitem(Body; "Tabela Temp Ficheiros Texto")
        {
            DataItemTableView = SORTING("Tipo Ficheiro", NLinha) WHERE("Tipo Ficheiro" = CONST(AnexoJ), NLinha = FILTER(> 7));
            column(NIFSuj; CopyStr(Body.Texto1, 11, 9))
            {
            }
            column(RendAnosAnt_valores; CopyStr(Body.Texto1, 20, 14))
            {
            }
            column(RendAnosAnt_ano; CopyStr(Body.Texto1, 34, 2))
            {
            }
            column(RendAno; CopyStr(Body.Texto1, 36, 14))
            {
            }
            column(TipoRend; CopyStr(Body.Texto1, 50, 3))
            {
            }
            column(LocalRend; CopyStr(Body.Texto1, 53, 2))
            {
            }
            column(ImpRetidas; CopyStr(Body.Texto1, 55, 13))
            {
            }
            column(DescObrg; CopyStr(Body.Texto1, 68, 13))
            {
            }
            column(QuotSind; CopyStr(Body.Texto1, 81, 13))
            {
            }
            column(Sobretaxa; CopyStr(Body.Texto1, 94, 13))
            {
            }

            trigger OnAfterGetRecord()
            begin
                if CopyStr(Body.Texto1, 1, 3) = 'J99' then
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
                group(Options)
                {
                    Caption = 'Options';
                    field(DataIni; DataIni)
                    {

                        Caption = 'Periodo de:';
                    }
                    field(DataFim; DataFim)
                    {

                        Caption = 'a:';
                    }
                    field(CodRepFinancas; CodRepFinancas)
                    {

                        Caption = 'Cód. Rep.Finanças';
                    }
                    field(PercVolNegocios; PercVolNegocios)
                    {

                        Caption = '% Vol. Negócios';
                    }
                    field(CodActividade; CodActividade)
                    {

                        Caption = 'Cód. Actividade';
                    }
                    field(Tipodeclaracao; Tipodeclaracao)
                    {

                        Caption = 'Tipo Declaração';
                    }
                    field(NIFRepLegal; NIFRepLegal)
                    {

                        Caption = 'NIF Representante Legal';
                    }
                    field(NIFTecOficialContas; NIFTecOficialContas)
                    {

                        Caption = 'NIF Tec. Oficial Contas';
                    }
                    field(RetencoesIRC; RetencoesIRC)
                    {

                        Caption = 'Retenções IRC';
                    }
                    field(RetencoesA; RetencoesA)
                    {

                        Caption = 'Retenções A';
                    }
                    field(Compensacoes; Compensacoes)
                    {

                        Caption = 'Compensações IRS/IRC';
                    }
                    field("Declaraçao"; Declaraçao)
                    {

                        Caption = 'Declaração';

                        trigger OnValidate()
                        begin
                            //JPC
                            if Declaraçao = Declaraçao::Sim then
                                campoDataEditable := true
                            else
                                campoDataEditable := false;
                        end;
                    }
                    field(campoData; DataAlteração)
                    {

                        Caption = 'Data de alteração';
                        Editable = campoDataEditable;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            campoDataEditable := true;
            InfEmpresa.Get;
            NIFRepLegal := InfEmpresa."PTSS Legal Rep. VAT Reg. No.";
            NIFTecOficialContas := InfEmpresa."PTSS TOC VAT Reg. No.";
            CodRepFinancas := InfEmpresa."PTSS Tax Authority Code"
        end;

        trigger OnOpenPage()
        begin
            //JPC
            if Declaraçao = Declaraçao::Sim then
                campoDataEditable := true
            else
                campoDataEditable := false;
            //
        end;
    }

    labels
    {
        lblTitulo = 'MODELO 10';
        lblNIF = 'NIF';
        lblAno = 'ANO';
        lblATrabDep = 'A - TRABALHO DEPENDENTE';
        lblBRenEmp = 'B - RENDIMENTOS EMPRESARIAIS E PROFISSINAIS';
        lblEOutRend = 'E - OUTROS RENDIMENTOS DE CAPITAIS';
        lblEESaldosCred = 'EE - SALDOS CREDORES';
        lblFPrediais = 'F - PREDIAIS';
        lblGIncPat = 'G - INCREMENTOS PATRIMONIAIS';
        lblHPensoes = 'H - PENSÕES';
        lblRenIRC = 'RETENÇÕES DE IRC (Artº 88º do CIRS)';
        lblSoma1a8 = 'SOMA (01 a 08)';
        lblRentTaxaLib = 'RETENÇÕES A TAXAS LIBERATÓRIAS';
        lblCompIRS = 'COMPENSAÇÕES DE IRS / IRC';
        lblTotal9_10_11 = ' TOTAL (09 + 10 + 11)';
        lblRentSobretaxa = 'RETENÇÃO DE SOBRETAXA';
        lblNIFSuj = 'Sujeito Passivo (NIF)';
        lblRenAnoAntVal = 'Rendimentos de anos anteriores - Valores';
        lblRenAnoAntAno = 'Rendimentos de anos anteriores - Nº de Anos';
        lblRendAno = 'Rendimentos do Ano';
        lblTipoRend = 'Tipo Rendim.';
        lblLocalRend = 'Local de Obten. do Rendim.';
        lblImpRetidas = 'Importâncias Retidas';
        lblDescObrg = 'Descont. Obrig.';
        lblQuatSind = 'Quot. Sindicais';
        lblSobretaxa = 'Sobretaxa';
    }

    trigger OnPostReport()
    var
        ExportFicheirosTexto: XMLport "Export Ficheiro Texto";
    begin
        //>>>>>>  LINHA 006 - Trailer Declaração>>>>>>>>>>>>>>>>>>>>>>>>>>
        TabelaTempFichTexto.Init;
        TabelaTempFichTexto."Tipo Ficheiro" := TabelaTempFichTexto."Tipo Ficheiro"::AnexoJ;
        TabelaTempFichTexto.NLinha := TabelaTempFichTexto.NLinha + 1;
        TabelaTempFichTexto.Texto1 := '006'
        + ConvertStr(Format(TotalRegistosJ99 + 5, 9, '<Sign><Integer>'), ' ', '0')
        + PadStr(' ', 160, ' ');
        TabelaTempFichTexto.Insert;

        //>>>>>>  LINHA 999 - Trailer Ficheiro>>>>>>>>>>>>>>>>>>>>>>>>>>
        TabelaTempFichTexto.Init;
        TabelaTempFichTexto."Tipo Ficheiro" := TabelaTempFichTexto."Tipo Ficheiro"::AnexoJ;
        TabelaTempFichTexto.NLinha := TabelaTempFichTexto.NLinha + 1;
        TabelaTempFichTexto.Texto1 := '999'
        + ConvertStr(Format(TotalRegistosJ99 + 7, 9, '<Sign><Integer>'), ' ', '0')
        + PadStr(' ', 160, ' ');
        TabelaTempFichTexto.Insert;
    end;

    trigger OnPreReport()
    begin
        ConfRH.Get;

        TabelaTempFichTexto.SetRange(TabelaTempFichTexto."Tipo Ficheiro", TabelaTempFichTexto."Tipo Ficheiro"::AnexoJ);
        if TabelaTempFichTexto.FindFirst then
            TabelaTempFichTexto.DeleteAll;

        //>>>>>>  LINHA 001 - Header do ficheiro >>>>>>>>>>>>>>>>>>>>>>>>>>
        TabelaTempFichTexto.Init;
        TabelaTempFichTexto."Tipo Ficheiro" := TabelaTempFichTexto."Tipo Ficheiro"::AnexoJ;
        TabelaTempFichTexto.NLinha := 1;
        TabelaTempFichTexto.Texto1 := '001ASCII10'

        + Format(WorkDate, 0, '<Year4><Month,2><Day,2>')
        + PadStr(' ', 154, ' ');
        TabelaTempFichTexto.Insert;

        //>>>>>>  LINHA 002 - Header de declaração >>>>>>>>>>>>>>>>>>>>>>>>>>
        TabelaTempFichTexto.Init;
        TabelaTempFichTexto."Tipo Ficheiro" := TabelaTempFichTexto."Tipo Ficheiro"::AnexoJ;
        TabelaTempFichTexto.NLinha := TabelaTempFichTexto.NLinha + 1;
        TabelaTempFichTexto.Texto1 := '002DANUAL'
        + PadStr('0', 9 - StrLen(InfEmpresa."VAT Registration No."), '0') + InfEmpresa."VAT Registration No."  //NIF
        + Format(DataIni, 0, '<Year4><Month,2><Day,2>')                                                      //Periodo de
        + Format(DataFim, 0, '<Year4><Month,2><Day,2>')                                                      //Periodo a
        + CopyStr(Format(DataIni, 0, '<Year4><Month,2><Day,2>'), 1, 4)                                         //Ano
        + 'EUR'
        + PadStr(' ', 131, ' ');
        TabelaTempFichTexto.Insert;

        //>>>>>>  LINHA 003 - Header de declaração anual >>>>>>>>>>>>>>>>>>>>>>>>>>
        TabelaTempFichTexto.Init;
        TabelaTempFichTexto."Tipo Ficheiro" := TabelaTempFichTexto."Tipo Ficheiro"::AnexoJ;
        TabelaTempFichTexto.NLinha := TabelaTempFichTexto.NLinha + 1;
        TabelaTempFichTexto.Texto1 := '003'
        + PadStr('0', 4 - StrLen(CodRepFinancas), '0') + CodRepFinancas                                        //Cod. Rep. finanças
        + PadStr('0', 5 - StrLen(InfEmpresa."PTSS CAE Code"), '0') + InfEmpresa."PTSS CAE Code"                          //CAE
        + PadStr('0', 3 - StrLen(PercVolNegocios), '0') + PercVolNegocios                                      //Perc vol neg
        + PadStr('0', 4 - StrLen(CodActividade), '0') + CodActividade                                          //Perc vol neg
        + '00000';

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
        + PadStr('0', 9 - StrLen(NIFRepLegal), '0') + NIFRepLegal                                               //Perc vol neg
        + PadStr('0', 9 - StrLen(NIFTecOficialContas), '0') + NIFTecOficialContas                               //Perc vol neg
        + PadStr(' ', 120, ' ');
        TabelaTempFichTexto.Insert;

        //>>>>>>  LINHA 004 - Detalhe de declaração anual >>>>>>>>>>>>>>>>>>>>>>>>>>
        TabelaTempFichTexto.Init;
        TabelaTempFichTexto."Tipo Ficheiro" := TabelaTempFichTexto."Tipo Ficheiro"::AnexoJ;
        TabelaTempFichTexto.NLinha := TabelaTempFichTexto.NLinha + 1;
        TabelaTempFichTexto.Texto1 := '004'
        + '0000000001000000'
        + PadStr(' ', 153, ' ');
        TabelaTempFichTexto.Insert;

        //>>>>>>  LINHA 005 - Trailer de declaração anual >>>>>>>>>>>>>>>>>>>>>>>>>>
        TabelaTempFichTexto.Init;
        TabelaTempFichTexto."Tipo Ficheiro" := TabelaTempFichTexto."Tipo Ficheiro"::AnexoJ;
        TabelaTempFichTexto.NLinha := TabelaTempFichTexto.NLinha + 1;
        TabelaTempFichTexto.Texto1 := '005'
        + '001'
        + PadStr(' ', 166, ' ');
        TabelaTempFichTexto.Insert;
    end;

    var
        TotalFor: Label 'Total de ';
        TabRubrica: Record "Payroll Item";
        TabRubricaLinhas: Record "Rubrica Salarial Linhas";
        DataIni: Date;
        DataFim: Date;
        TabelaTempFichTexto: Record "Tabela Temp Ficheiros Texto";
        Lnoprocesso: Integer;
        InfEmpresa: Record "Company Information";
        ConfRH: Record "Config. Recursos Humanos";
        NLinha: Integer;
        CodRepFinancas: Text[4];
        PercVolNegocios: Text[3];
        CodActividade: Text[4];
        Tipodeclaracao: Option "1ª Declaração do ano","Declaração de Substituição";
        NIFRepLegal: Text[9];
        NIFTecOficialContas: Text[9];
        TotalA: Decimal;
        TotalB: Decimal;
        TotalE: Decimal;
        TotalEE: Decimal;
        TotalF: Decimal;
        TotalG: Decimal;
        TotalH: Decimal;
        RetencoesIRC: Decimal;
        RetencoesA: Decimal;
        Compensacoes: Decimal;
        RendimentosAno: Decimal;
        TotalRendimentosAno: Decimal;
        ImportanciasRetidas: Decimal;
        TotalImpRetidas: Decimal;
        AuxEmp: Code[20];
        Empregado: Record Empregado;
        TotalRegistosJ99: Integer;
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
        TabGLEntry: Record "G/L Entry";
        SobreTaxa: Decimal;
        valorSobreTaxa: Decimal;
        TotSobreTaxa: Decimal;

        campoDataEditable: Boolean;
        Text19075912: Label 'Declaração apresentada nos termos da al. d), nº1, art.º 119 do CIRS';
        CodEmp: Code[20];
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

