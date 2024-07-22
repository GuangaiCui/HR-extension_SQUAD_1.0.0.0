codeunit 53037 "Funções RH"
{
    // IT001 - CPA: não passar o campo Nav User ID - APD - 25-11-2014
    //       - A pedido do cliente para que não seja transportado da ficha do Empregado para a Ficha do Professor o campo "NAV User ID"
    // 
    // IT002 - 2016.07.28 - porque o addon de RH usa uma tabela diferente para as freguesias
    //CGA SQD changed record empregado to record employee in functions 


    trigger OnRun()
    begin
    end;

    var
        AsciiStr: Text[350];
        AnsiStr: Text[350];
        CharVar: array[32] of Char;
        text000001: Label 'Folder Selection';
        PeriodosProce: Integer;
        FormatAddress: Codeunit "Format Address";


    procedure CalcularTaxaIRS(ValorVencimento: Decimal; Empregado: Record Employee; Ano: Integer) TaxaIRS: Decimal
    var
        TabelaIRS: Record "Tabela IRS";
        Passou: Boolean;
    begin
        Empregado.TestField(Empregado."Tipo Contribuinte");
        Empregado.TestField(Empregado."Local Obtenção Rendimento");

        //Procura a Tabela de IRS do ano do processamento, se não encontrar usa a no ano anterior
        TabelaIRS.SetRange(TabelaIRS.Ano, Ano);
        if not TabelaIRS.Find('-') then
            TabelaIRS.SetRange(TabelaIRS.Ano, Ano - 1);

        //-------------------------------------------------------------------
        //-------TABELA I - TRABALHO DEPENDENTE NÃO CASADO-------------------
        //-------------------------------------------------------------------
        if (Empregado."Tipo Contribuinte" = 1) and (Empregado."Estado Civil" <> 1) and (Empregado."Estado Civil" <> 5)
           and (Empregado.Deficiente = 0) then begin
            TabelaIRS.SetRange(TabelaIRS.Tabela, 1);
            TabelaIRS.SetRange(TabelaIRS.Região, Empregado."Local Obtenção Rendimento" - 1);
            if TabelaIRS.Find('-') then begin
                repeat
                    if ValorVencimento <= TabelaIRS.Valor then begin
                        if Empregado."No. Dependentes" = 0 then TaxaIRS := TabelaIRS."TD 0 Dependentes";
                        if Empregado."No. Dependentes" = 1 then TaxaIRS := TabelaIRS."TD 1 Dependentes";
                        if Empregado."No. Dependentes" = 2 then TaxaIRS := TabelaIRS."TD 2 Dependentes";
                        if Empregado."No. Dependentes" = 3 then TaxaIRS := TabelaIRS."TD 3 Dependentes";
                        if Empregado."No. Dependentes" = 4 then TaxaIRS := TabelaIRS."TD 4 Dependentes";
                        if Empregado."No. Dependentes" >= 5 then TaxaIRS := TabelaIRS."TD 5ou Mais Dependentes";
                        exit;
                    end;
                until TabelaIRS.Next = 0;
                if TabelaIRS.Find('+') then begin
                    if Empregado."No. Dependentes" = 0 then TaxaIRS := TabelaIRS."TD 0 Dependentes";
                    if Empregado."No. Dependentes" = 1 then TaxaIRS := TabelaIRS."TD 1 Dependentes";
                    if Empregado."No. Dependentes" = 2 then TaxaIRS := TabelaIRS."TD 2 Dependentes";
                    if Empregado."No. Dependentes" = 3 then TaxaIRS := TabelaIRS."TD 3 Dependentes";
                    if Empregado."No. Dependentes" = 4 then TaxaIRS := TabelaIRS."TD 4 Dependentes";
                    if Empregado."No. Dependentes" >= 5 then TaxaIRS := TabelaIRS."TD 5ou Mais Dependentes";
                    exit;
                end;
            end;
        end;


        //----------------------------------------------------------------------------
        //-------TABELA II - TRABALHO DEPENDENTE CASADO, ÚNICO TITULAR----------------
        //----------------------------------------------------------------------------
        if (Empregado."Tipo Contribuinte" = 1) and ((Empregado."Estado Civil" = 1) or (Empregado."Estado Civil" = 5))
           and (Empregado.Deficiente = 0) and (Empregado."Titular Rendimentos" = 1) then begin
            TabelaIRS.SetRange(TabelaIRS.Tabela, 2);
            TabelaIRS.SetRange(TabelaIRS.Região, Empregado."Local Obtenção Rendimento" - 1);
            if TabelaIRS.Find('-') then begin
                repeat
                    if ValorVencimento <= TabelaIRS.Valor then begin
                        if Empregado."No. Dependentes" = 0 then TaxaIRS := TabelaIRS."TD 0 Dependentes";
                        if Empregado."No. Dependentes" = 1 then TaxaIRS := TabelaIRS."TD 1 Dependentes";
                        if Empregado."No. Dependentes" = 2 then TaxaIRS := TabelaIRS."TD 2 Dependentes";
                        if Empregado."No. Dependentes" = 3 then TaxaIRS := TabelaIRS."TD 3 Dependentes";
                        if Empregado."No. Dependentes" = 4 then TaxaIRS := TabelaIRS."TD 4 Dependentes";
                        if Empregado."No. Dependentes" >= 5 then TaxaIRS := TabelaIRS."TD 5ou Mais Dependentes";
                        exit;
                    end;
                until TabelaIRS.Next = 0;
                if TabelaIRS.Find('+') then begin
                    if Empregado."No. Dependentes" = 0 then TaxaIRS := TabelaIRS."TD 0 Dependentes";
                    if Empregado."No. Dependentes" = 1 then TaxaIRS := TabelaIRS."TD 1 Dependentes";
                    if Empregado."No. Dependentes" = 2 then TaxaIRS := TabelaIRS."TD 2 Dependentes";
                    if Empregado."No. Dependentes" = 3 then TaxaIRS := TabelaIRS."TD 3 Dependentes";
                    if Empregado."No. Dependentes" = 4 then TaxaIRS := TabelaIRS."TD 4 Dependentes";
                    if Empregado."No. Dependentes" >= 5 then TaxaIRS := TabelaIRS."TD 5ou Mais Dependentes";
                    exit;
                end;
            end;
        end;


        //----------------------------------------------------------------------------
        //------TABELA III - TRABALHO DEPENDENTE CASADO, DOIS TITULARES---------------
        //----------------------------------------------------------------------------
        if (Empregado."Tipo Contribuinte" = 1) and ((Empregado."Estado Civil" = 1) or (Empregado."Estado Civil" = 5))
           and (Empregado.Deficiente = 0) and (Empregado."Titular Rendimentos" = 2) then begin
            TabelaIRS.SetRange(TabelaIRS.Tabela, 3);
            TabelaIRS.SetRange(TabelaIRS.Região, Empregado."Local Obtenção Rendimento" - 1);
            if TabelaIRS.Find('-') then begin
                repeat
                    if ValorVencimento <= TabelaIRS.Valor then begin
                        if Empregado."No. Dependentes" = 0 then TaxaIRS := TabelaIRS."TD 0 Dependentes";
                        if Empregado."No. Dependentes" = 1 then TaxaIRS := TabelaIRS."TD 1 Dependentes";
                        if Empregado."No. Dependentes" = 2 then TaxaIRS := TabelaIRS."TD 2 Dependentes";
                        if Empregado."No. Dependentes" = 3 then TaxaIRS := TabelaIRS."TD 3 Dependentes";
                        if Empregado."No. Dependentes" = 4 then TaxaIRS := TabelaIRS."TD 4 Dependentes";
                        if Empregado."No. Dependentes" >= 5 then TaxaIRS := TabelaIRS."TD 5ou Mais Dependentes";
                        exit;
                    end;
                until TabelaIRS.Next = 0;
                if TabelaIRS.Find('+') then begin
                    if Empregado."No. Dependentes" = 0 then TaxaIRS := TabelaIRS."TD 0 Dependentes";
                    if Empregado."No. Dependentes" = 1 then TaxaIRS := TabelaIRS."TD 1 Dependentes";
                    if Empregado."No. Dependentes" = 2 then TaxaIRS := TabelaIRS."TD 2 Dependentes";
                    if Empregado."No. Dependentes" = 3 then TaxaIRS := TabelaIRS."TD 3 Dependentes";
                    if Empregado."No. Dependentes" = 4 then TaxaIRS := TabelaIRS."TD 4 Dependentes";
                    if Empregado."No. Dependentes" >= 5 then TaxaIRS := TabelaIRS."TD 5ou Mais Dependentes";
                    exit;
                end;
            end;
        end;



        //--------------------------------------------------------------------------
        //------TABELA IV - TRABALHO DEPENDENTE NÃO CASADO DEFICIENTE---------------
        //--------------------------------------------------------------------------
        if (Empregado."Tipo Contribuinte" = 1) and (Empregado."Estado Civil" <> 1) and (Empregado."Estado Civil" <> 5)
           and (Empregado.Deficiente = 1) then begin
            TabelaIRS.SetRange(TabelaIRS.Tabela, 4);
            TabelaIRS.SetRange(TabelaIRS.Região, Empregado."Local Obtenção Rendimento" - 1);
            if TabelaIRS.Find('-') then begin
                repeat
                    if ValorVencimento <= TabelaIRS.Valor then begin
                        if Empregado."No. Dependentes" = 0 then TaxaIRS := TabelaIRS."TD 0 Dependentes";
                        if Empregado."No. Dependentes" = 1 then TaxaIRS := TabelaIRS."TD 1 Dependentes";
                        if Empregado."No. Dependentes" = 2 then TaxaIRS := TabelaIRS."TD 2 Dependentes";
                        if Empregado."No. Dependentes" = 3 then TaxaIRS := TabelaIRS."TD 3 Dependentes";
                        if Empregado."No. Dependentes" = 4 then TaxaIRS := TabelaIRS."TD 4 Dependentes";
                        if Empregado."No. Dependentes" >= 5 then TaxaIRS := TabelaIRS."TD 5ou Mais Dependentes";
                        exit;
                    end;
                until TabelaIRS.Next = 0;
                if TabelaIRS.Find('+') then begin
                    if Empregado."No. Dependentes" = 0 then TaxaIRS := TabelaIRS."TD 0 Dependentes";
                    if Empregado."No. Dependentes" = 1 then TaxaIRS := TabelaIRS."TD 1 Dependentes";
                    if Empregado."No. Dependentes" = 2 then TaxaIRS := TabelaIRS."TD 2 Dependentes";
                    if Empregado."No. Dependentes" = 3 then TaxaIRS := TabelaIRS."TD 3 Dependentes";
                    if Empregado."No. Dependentes" = 4 then TaxaIRS := TabelaIRS."TD 4 Dependentes";
                    if Empregado."No. Dependentes" >= 5 then TaxaIRS := TabelaIRS."TD 5ou Mais Dependentes";
                    exit;
                end;
            end;
        end;



        //----------------------------------------------------------------------------------
        //-------TABELA V - TRABALHO DEPENDENTE CASADO ÚNICO TITULAR DEFICIENTE------------
        //----------------------------------------------------------------------------------
        if (Empregado."Tipo Contribuinte" = 1) and ((Empregado."Estado Civil" = 1) or (Empregado."Estado Civil" = 5))
           and (Empregado.Deficiente = 1) and (Empregado."Titular Rendimentos" = 1) then begin
            TabelaIRS.SetRange(TabelaIRS.Tabela, 5);
            TabelaIRS.SetRange(TabelaIRS.Região, Empregado."Local Obtenção Rendimento" - 1);
            if TabelaIRS.Find('-') then begin
                repeat
                    if ValorVencimento <= TabelaIRS.Valor then begin
                        if Empregado."No. Dependentes" = 0 then TaxaIRS := TabelaIRS."TD 0 Dependentes";
                        if Empregado."No. Dependentes" = 1 then TaxaIRS := TabelaIRS."TD 1 Dependentes";
                        if Empregado."No. Dependentes" = 2 then TaxaIRS := TabelaIRS."TD 2 Dependentes";
                        if Empregado."No. Dependentes" = 3 then TaxaIRS := TabelaIRS."TD 3 Dependentes";
                        if Empregado."No. Dependentes" = 4 then TaxaIRS := TabelaIRS."TD 4 Dependentes";
                        if Empregado."No. Dependentes" >= 5 then TaxaIRS := TabelaIRS."TD 5ou Mais Dependentes";
                        exit;
                    end;
                until TabelaIRS.Next = 0;
                if TabelaIRS.Find('+') then begin
                    if Empregado."No. Dependentes" = 0 then TaxaIRS := TabelaIRS."TD 0 Dependentes";
                    if Empregado."No. Dependentes" = 1 then TaxaIRS := TabelaIRS."TD 1 Dependentes";
                    if Empregado."No. Dependentes" = 2 then TaxaIRS := TabelaIRS."TD 2 Dependentes";
                    if Empregado."No. Dependentes" = 3 then TaxaIRS := TabelaIRS."TD 3 Dependentes";
                    if Empregado."No. Dependentes" = 4 then TaxaIRS := TabelaIRS."TD 4 Dependentes";
                    if Empregado."No. Dependentes" >= 5 then TaxaIRS := TabelaIRS."TD 5ou Mais Dependentes";
                    exit;
                end;
            end;
        end;




        //---------------------------------------------------------------------------------------
        //-------TABELA VI - TRABALHO DEPENDENTE CASADO, DOIS TITULARES DEFICIENTES--------------
        //---------------------------------------------------------------------------------------
        if (Empregado."Tipo Contribuinte" = 1) and ((Empregado."Estado Civil" = 1) or (Empregado."Estado Civil" = 5))
           and (Empregado.Deficiente = 1) and (Empregado."Titular Rendimentos" = 2) then begin
            TabelaIRS.SetRange(TabelaIRS.Tabela, 6);
            TabelaIRS.SetRange(TabelaIRS.Região, Empregado."Local Obtenção Rendimento" - 1);
            if TabelaIRS.Find('-') then begin
                repeat
                    if ValorVencimento <= TabelaIRS.Valor then begin
                        if Empregado."No. Dependentes" = 0 then TaxaIRS := TabelaIRS."TD 0 Dependentes";
                        if Empregado."No. Dependentes" = 1 then TaxaIRS := TabelaIRS."TD 1 Dependentes";
                        if Empregado."No. Dependentes" = 2 then TaxaIRS := TabelaIRS."TD 2 Dependentes";
                        if Empregado."No. Dependentes" = 3 then TaxaIRS := TabelaIRS."TD 3 Dependentes";
                        if Empregado."No. Dependentes" = 4 then TaxaIRS := TabelaIRS."TD 4 Dependentes";
                        if Empregado."No. Dependentes" >= 5 then TaxaIRS := TabelaIRS."TD 5ou Mais Dependentes";
                        exit;
                    end;
                until TabelaIRS.Next = 0;
                if TabelaIRS.Find('+') then begin
                    if Empregado."No. Dependentes" = 0 then TaxaIRS := TabelaIRS."TD 0 Dependentes";
                    if Empregado."No. Dependentes" = 1 then TaxaIRS := TabelaIRS."TD 1 Dependentes";
                    if Empregado."No. Dependentes" = 2 then TaxaIRS := TabelaIRS."TD 2 Dependentes";
                    if Empregado."No. Dependentes" = 3 then TaxaIRS := TabelaIRS."TD 3 Dependentes";
                    if Empregado."No. Dependentes" = 4 then TaxaIRS := TabelaIRS."TD 4 Dependentes";
                    if Empregado."No. Dependentes" >= 5 then TaxaIRS := TabelaIRS."TD 5ou Mais Dependentes";
                    exit;
                end;
            end;
        end;


        //----------------------------------------------------------------
        //----------TABELA VII - PENSÕES ---------------------------------
        //----------------------------------------------------------------
        if (Empregado."Tipo Contribuinte" = 3) and (Empregado.Deficiente = 0) then begin
            TabelaIRS.SetRange(TabelaIRS.Tabela, 7);
            TabelaIRS.SetRange(TabelaIRS.Região, Empregado."Local Obtenção Rendimento" - 1);
            if TabelaIRS.Find('-') then begin
                repeat
                    if ValorVencimento <= TabelaIRS.Valor then begin
                        if ((Empregado."Estado Civil" = 1) or (Empregado."Estado Civil" = 5))
                           and (Empregado."Titular Rendimentos" = 2) then
                            TaxaIRS := TabelaIRS.PenCas2Tit;
                        if (Empregado."Estado Civil" <> 1) and (Empregado."Estado Civil" <> 5) then TaxaIRS := TabelaIRS.PenNCas;
                        if ((Empregado."Estado Civil" = 1) or (Empregado."Estado Civil" = 5))
                           and (Empregado."Titular Rendimentos" = 1) then
                            TaxaIRS := TabelaIRS.PenCas1Tit;
                        exit;
                    end;
                until TabelaIRS.Next = 0;
                if TabelaIRS.Find('+') then begin
                    if ((Empregado."Estado Civil" = 1) or (Empregado."Estado Civil" = 5))
                       and (Empregado."Titular Rendimentos" = 2) then
                        TaxaIRS := TabelaIRS.PenCas2Tit;
                    if (Empregado."Estado Civil" <> 1) and (Empregado."Estado Civil" <> 5) then TaxaIRS := TabelaIRS.PenNCas;
                    if ((Empregado."Estado Civil" = 1) or (Empregado."Estado Civil" = 5))
                       and (Empregado."Titular Rendimentos" = 1) then
                        TaxaIRS := TabelaIRS.PenCas1Tit;
                    exit;
                end;
            end;
        end;


        //------------------------------------------------------------------------
        //------TABELA VIII - RENDIMENTOS DE PENSÕES/TITULARES DEFICIENTES--------
        //------------------------------------------------------------------------
        if (Empregado."Tipo Contribuinte" = 3) and (Empregado.Deficiente = 1) then begin
            TabelaIRS.SetRange(TabelaIRS.Tabela, 8);
            TabelaIRS.SetRange(TabelaIRS.Região, Empregado."Local Obtenção Rendimento" - 1);
            if TabelaIRS.Find('-') then begin
                repeat
                    if ValorVencimento <= TabelaIRS.Valor then begin
                        if ((Empregado."Estado Civil" = 1) or (Empregado."Estado Civil" = 5))
                           and (Empregado."Titular Rendimentos" = 2) then
                            TaxaIRS := TabelaIRS.PenCas2Tit;
                        if (Empregado."Estado Civil" <> 1) and (Empregado."Estado Civil" <> 5) then TaxaIRS := TabelaIRS.PenNCas;
                        if ((Empregado."Estado Civil" = 1) or (Empregado."Estado Civil" = 5))
                           and (Empregado."Titular Rendimentos" = 1) then
                            TaxaIRS := TabelaIRS.PenCas1Tit;
                        exit;
                    end;
                until TabelaIRS.Next = 0;
                if TabelaIRS.Find('+') then begin
                    if ((Empregado."Estado Civil" = 1) or (Empregado."Estado Civil" = 5))
                       and (Empregado."Titular Rendimentos" = 2) then
                        TaxaIRS := TabelaIRS.PenCas2Tit;
                    if (Empregado."Estado Civil" <> 1) and (Empregado."Estado Civil" <> 5) then TaxaIRS := TabelaIRS.PenNCas;
                    if ((Empregado."Estado Civil" = 1) or (Empregado."Estado Civil" = 5))
                       and (Empregado."Titular Rendimentos" = 1) then
                        TaxaIRS := TabelaIRS.PenCas1Tit;
                    exit;
                end;
            end;
        end;

        //---------------------------------------------------------------------
        //---TABELA IX - PENSÕES. TITULARES DEFICENTES DAS FORÇAS ARMADAS------
        //---------------------------------------------------------------------
        if (Empregado."Tipo Contribuinte" = 3) and (Empregado.Deficiente = 2) then begin
            TabelaIRS.SetRange(TabelaIRS.Tabela, 9);
            TabelaIRS.SetRange(TabelaIRS.Região, Empregado."Local Obtenção Rendimento" - 1);
            if TabelaIRS.Find('-') then begin
                repeat
                    if ValorVencimento <= TabelaIRS.Valor then begin
                        if ((Empregado."Estado Civil" = 1) or (Empregado."Estado Civil" = 5))
                           and (Empregado."Titular Rendimentos" = 2) then
                            TaxaIRS := TabelaIRS.PenCas2Tit;
                        if (Empregado."Estado Civil" <> 1) and (Empregado."Estado Civil" <> 5) then TaxaIRS := TabelaIRS.PenNCas;
                        if ((Empregado."Estado Civil" = 1) or (Empregado."Estado Civil" = 5))
                           and (Empregado."Titular Rendimentos" = 1) then
                            TaxaIRS := TabelaIRS.PenCas1Tit;
                        exit;
                    end;
                until TabelaIRS.Next = 0;
                if TabelaIRS.Find('+') then begin
                    if ((Empregado."Estado Civil" = 1) or (Empregado."Estado Civil" = 5))
                       and (Empregado."Titular Rendimentos" = 2) then
                        TaxaIRS := TabelaIRS.PenCas2Tit;
                    if (Empregado."Estado Civil" <> 1) and (Empregado."Estado Civil" <> 5) then TaxaIRS := TabelaIRS.PenNCas;
                    if ((Empregado."Estado Civil" = 1) or (Empregado."Estado Civil" = 5))
                       and (Empregado."Titular Rendimentos" = 1) then
                        TaxaIRS := TabelaIRS.PenCas1Tit;
                    exit;
                end;
            end;
        end;
    end;


    procedure GetPeriodicidade(TabRubrica: Record "Rubrica Salarial"; Data: Date) Processar: Boolean
    var
        i: Integer;
        VarPeriodicidade: Integer;
    begin
        //HG - Saber se este mês (mês de processamento) deve correr esta rubrica tendo em conta a sua periodicidade

        if TabRubrica."Mês Início Periocidade" = 0 then begin
            Processar := false;
            exit;
        end;

        if (TabRubrica.Periodicidade <> 4) and (TabRubrica.Periodicidade <> 5) then VarPeriodicidade := TabRubrica.Periodicidade;
        if TabRubrica.Periodicidade = 4 then VarPeriodicidade := 5;
        if TabRubrica.Periodicidade = 5 then VarPeriodicidade := 11;

        for i := TabRubrica."Mês Início Periocidade" to 12 do begin
            if Date2DMY(Data, 2) = i then begin
                Processar := true;
                exit;
            end;

            i := i + VarPeriodicidade;

        end;

        Processar := false;
    end;


    procedure CalcularVencimentoBase(Data: Date; Empregado: Record Employee) VencimentoBase: Decimal
    var
        TabRubricaSalEmpregado: Record "Rubrica Salarial Empregado";
        TabRubrica: Record "Rubrica Salarial";
        TabRubricaLinhas: Record "Rubrica Salarial Linhas";
        TabRubricaSalEmpregado2: Record "Rubrica Salarial Empregado";
    begin
        //HG - Obter numa precisa Data qual o Vencimento Base de um Empregado

        TabRubricaSalEmpregado.Reset;
        TabRubricaSalEmpregado.SetRange(TabRubricaSalEmpregado."No. Empregado", Empregado."No.");
        TabRubricaSalEmpregado.SetFilter(TabRubricaSalEmpregado."Data Início", '<=%1', Data);
        TabRubricaSalEmpregado.SetFilter(TabRubricaSalEmpregado."Data Fim", '>=%1|=%2', Data, 0D);
        if TabRubricaSalEmpregado.Find('-') then begin
            repeat
                if (TabRubrica.Get(TabRubricaSalEmpregado."Cód. Rúbrica Salarial")) and
                   (TabRubrica.Genero = TabRubrica.Genero::"Vencimento Base") then begin
                    //HG 19.01.09 - rubricas como o IHT não tem valor é uma % então temos de ir calcular 1º o valor
                    if TabRubricaSalEmpregado."Valor Total" = 0 then begin
                        TabRubricaLinhas.Reset;
                        TabRubricaLinhas.SetRange(TabRubricaLinhas."Cód. Rubrica", TabRubricaSalEmpregado."Cód. Rúbrica Salarial");
                        if TabRubricaLinhas.Find('-') then begin
                            repeat
                                TabRubricaSalEmpregado2.Reset;
                                TabRubricaSalEmpregado2.SetRange(TabRubricaSalEmpregado2."No. Empregado", Empregado."No.");
                                TabRubricaSalEmpregado2.SetFilter(TabRubricaSalEmpregado2."Data Início", '<=%1', Data);
                                TabRubricaSalEmpregado2.SetFilter(TabRubricaSalEmpregado2."Data Fim", '>=%1|=%2', Data, 0D);
                                TabRubricaSalEmpregado2.SetRange(TabRubricaSalEmpregado2."Cód. Rúbrica Salarial",
                                                                 TabRubricaLinhas."Cód. Rubrica Filha");
                                if TabRubricaSalEmpregado2.Find('-') then
                                    VencimentoBase := VencimentoBase +
                                    (TabRubricaSalEmpregado2."Valor Total" * TabRubricaLinhas.Percentagem / 100);

                            until TabRubricaLinhas.Next = 0;
                        end;

                    end else
                        //HG 19.01.09 - fim

                        VencimentoBase := VencimentoBase + TabRubricaSalEmpregado."Valor Total";
                end;
            until TabRubricaSalEmpregado.Next = 0;
        end;
    end;


    procedure CalcularVencimentoBaseFaltas(Data: Date; Empregado: Record Employee) VencimentoBase: Decimal
    var
        TabRubricaSalEmpregado: Record "Rubrica Salarial Empregado";
        TabRubrica: Record "Rubrica Salarial";
        TabRubricaLinhas: Record "Rubrica Salarial Linhas";
        TabRubricaSalEmpregado2: Record "Rubrica Salarial Empregado";
    begin
        //HG - Obter numa precisa Data qual o Vencimento Base de um Empregado
        VencimentoBase := 0;
        TabRubricaSalEmpregado.Reset;
        TabRubricaSalEmpregado.SetRange(TabRubricaSalEmpregado."No. Empregado", Empregado."No.");
        TabRubricaSalEmpregado.SetFilter(TabRubricaSalEmpregado."Data Início", '<=%1', Data);
        TabRubricaSalEmpregado.SetFilter(TabRubricaSalEmpregado."Data Fim", '>=%1|=%2', Data, 0D);
        if TabRubricaSalEmpregado.Find('-') then begin
            repeat
                if (TabRubrica.Get(TabRubricaSalEmpregado."Cód. Rúbrica Salarial")) and
                   //(TabRubrica.NATREM =TabRubrica.NATREM::"Remuneração Permanente") AND
                   (TabRubrica.Faults) then begin

                    //HG 04.05.07 - como o IHT não tem valor é uma % então temos de ir calcular 1º o valor
                    if TabRubricaSalEmpregado."Valor Total" = 0 then begin
                        TabRubricaLinhas.Reset;
                        TabRubricaLinhas.SetRange(TabRubricaLinhas."Cód. Rubrica", TabRubricaSalEmpregado."Cód. Rúbrica Salarial");
                        if TabRubricaLinhas.Find('-') then begin
                            repeat
                                TabRubricaSalEmpregado2.Reset;
                                TabRubricaSalEmpregado2.SetRange(TabRubricaSalEmpregado2."No. Empregado", Empregado."No.");
                                TabRubricaSalEmpregado2.SetFilter(TabRubricaSalEmpregado2."Data Início", '<=%1', Data);
                                TabRubricaSalEmpregado2.SetFilter(TabRubricaSalEmpregado2."Data Fim", '>=%1|=%2', Data, 0D);
                                TabRubricaSalEmpregado2.SetRange(TabRubricaSalEmpregado2."Cód. Rúbrica Salarial",
                                                                 TabRubricaLinhas."Cód. Rubrica Filha");
                                if TabRubricaSalEmpregado2.Find('-') then
                                    VencimentoBase := VencimentoBase +
                                    (TabRubricaSalEmpregado2."Valor Total" * TabRubricaLinhas.Percentagem / 100);

                            until TabRubricaLinhas.Next = 0;
                        end;

                    end else
                        //HG 04.05.07 - fim

                        VencimentoBase := VencimentoBase + TabRubricaSalEmpregado."Valor Total";
                end
                else
                    if (TabRubrica.Get(TabRubricaSalEmpregado."Cód. Rúbrica Salarial")) and
                       (TabRubrica.Genero = TabRubrica.Genero::"Vencimento Base") then begin

                        //HG 19.01.10 - como o IHT não tem valor é uma % então temos de ir calcular 1º o valor
                        if TabRubricaSalEmpregado."Valor Total" = 0 then begin
                            TabRubricaLinhas.Reset;
                            TabRubricaLinhas.SetRange(TabRubricaLinhas."Cód. Rubrica", TabRubricaSalEmpregado."Cód. Rúbrica Salarial");
                            if TabRubricaLinhas.Find('-') then begin
                                repeat
                                    TabRubricaSalEmpregado2.Reset;
                                    TabRubricaSalEmpregado2.SetRange(TabRubricaSalEmpregado2."No. Empregado", Empregado."No.");
                                    TabRubricaSalEmpregado2.SetFilter(TabRubricaSalEmpregado2."Data Início", '<=%1', Data);
                                    TabRubricaSalEmpregado2.SetFilter(TabRubricaSalEmpregado2."Data Fim", '>=%1|=%2', Data, 0D);
                                    TabRubricaSalEmpregado2.SetRange(TabRubricaSalEmpregado2."Cód. Rúbrica Salarial",
                                                                     TabRubricaLinhas."Cód. Rubrica Filha");
                                    if TabRubricaSalEmpregado2.Find('-') then
                                        VencimentoBase := VencimentoBase +
                                        (TabRubricaSalEmpregado2."Valor Total" * TabRubricaLinhas.Percentagem / 100);

                                until TabRubricaLinhas.Next = 0;
                            end;

                        end else
                            //HG 19.01.10 - fim

                            VencimentoBase := VencimentoBase + TabRubricaSalEmpregado."Valor Total";
                    end;

            until TabRubricaSalEmpregado.Next = 0;
        end;
    end;


    procedure CalcularValorDia(VencimentoBase: Decimal; Empregado: Record Employee) ValorDia: Decimal
    begin
        //HG - Obter o Valor Dia Empregado dado um Vencimento Base
        //FBC - RH-013
        //ValorDia := VencimentoBase / 30
        //FBC - RH-019
        //ValorDia := VencimentoBase / 30;
        if Empregado."Tipo Contribuinte" <> Empregado."Tipo Contribuinte"::"Trabalhador Independente" then
            ValorDia := VencimentoBase / Empregado."No. Dias Trabalho Mensal"//Normatica 2014.10.09 -por causa dos empregados tempo parcia
        else
            ValorDia := VencimentoBase / 30;

        //ValorDia := ROUND((VencimentoBase * 12 / 52 / Empregado."Nº Horas Semanais") * (Empregado."Nº Horas Semanais"/5),0.01) ;
        //
    end;


    procedure CalcularValorHora(VencimentoBase: Decimal; Empregado: Record Employee) ValorHora: Decimal
    var
        ConfRH: Record "Config. Recursos Humanos";
    begin
        //HG - Obter o Valor Hora Empregado dado um Vencimento Base
        //FBC - RH-013
        //ValorHora := VencimentoBase * 12 / 52 / Empregado."Nº Horas Semanais";

        //HG 08.01.08 - a partir de agora podemos escolher se o valor hora é com base só nas horas lectivas ou nas totais
        //Para isso criou-se um novo campo na ficha do empregado onde se regista a horas totais e na
        //Conf. dos recursos humanos o campo "Valor calculo ausencias" foi alterado para definir se as ausencias em horas
        //são calculadas com o valor hora lectiva ou total
        if Empregado."Tipo Contribuinte" = Empregado."Tipo Contribuinte"::"Conta de Outrem" then begin
            if ConfRH.Get() then begin
                Empregado.TestField(Empregado."No. Horas Semanais");//2009.03.06
                ValorHora := Round(VencimentoBase * 12 / 52 / Empregado."No. Horas Semanais", 0.00001);
            end;
        end;
        //
    end;


    procedure CalcularDiasUteisMes(VarEstabelecimento: Code[4]; DataInicioProce: Date; DataFimProce: Date) NDias: Integer
    var
        I: Date;
        FERIADOS: Record "Feriados RH";
    begin
        //FUNÇÃO UTILIZADA PARA O PROCESSAMENTO DOS VENCIMENTOS ONDE PARA O CÁLCULO DO SUB. DE ALIMENTAÇÃO
        //É NECESSÁRIO SABER OS DIAS UTEIS DO MES TIRANDOS OS FERIADOS FIXOS E VARIÁVEIS(MUNICIPAIS)


        for I := DataInicioProce to DataFimProce do begin
            if Date2DWY(I, 1) < 6 then begin // OS VALORES 6 E 7 CORRESPONDEM A SÁBADO E DOMINGO

                //PROCURA SE É FERIADO
                FERIADOS.SetRange(FERIADOS.Data, I);
                if FERIADOS.Find('-') then begin
                    //HÁ UM FERIADO NESTA DATA

                    if (FERIADOS.Nacional = false) and (FERIADOS.Estabelecimento <> VarEstabelecimento) then begin
                        //HÁ FERIADO VARIÁVEL MAS NÃO É DO ESTABELECIMENTO DO EMPREGADO
                        NDias := NDias + 1;
                    end;

                end else begin
                    //NÃO HÁ NENHUM FERIADO NESTA DATA
                    NDias := NDias + 1;
                end;
            end;
        end;
    end;


    procedure CriarClienteContratoEmpregado(InrecEmpregado: Record Employee): Code[20]
    var
        recCustomer: Record Customer;
        recRHSetup: Record "Config. Recursos Humanos";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        //2009.03.04 - Função que cria um cliente para um determinado empregado, com fim a registar o imposto selo

        InrecEmpregado.TestField("Cod. Cliente", '');

        recRHSetup.Get;


        recCustomer.Init;

        // fica igual ao Nº Empregado
        recCustomer."No." := InrecEmpregado."No.";
        recCustomer.Name := CopyStr(InrecEmpregado.Name, 1, 100);
        recCustomer.Address := CopyStr(InrecEmpregado.Address, 1, 30);
        recCustomer."Address 2" := CopyStr(InrecEmpregado."Address 2", 1, 30);
        recCustomer."Name 2" := CopyStr(InrecEmpregado.Name, 1, 30);

        recCustomer.City := InrecEmpregado.City;
        recCustomer."Phone No." := InrecEmpregado."Phone No.";
        recCustomer."Country/Region Code" := InrecEmpregado."Country/Region Code";
        recCustomer."Fax No." := InrecEmpregado."Company Phone No.";
        recCustomer."Post Code" := InrecEmpregado."Post Code";
        recCustomer."E-Mail" := InrecEmpregado."E-Mail";
        recCustomer."VAT Registration No." := InrecEmpregado."No. Contribuinte";

        recCustomer.Validate("Gen. Bus. Posting Group", recRHSetup."Gr. Contabilístico Negócio");
        recCustomer.Validate("Customer Posting Group", recRHSetup."Gr. Contabilístico Cliente");
        recCustomer.Validate("VAT Bus. Posting Group", recRHSetup."Gr. Registo IVA negócio");
        recCustomer.Validate("Payment Terms Code", recRHSetup."Cód. Termos Pagamento");
        recCustomer.Validate("Payment Method Code", recRHSetup."Cód. Forma Pagamento");

        if recCustomer.Insert() = true then begin
            exit(recCustomer."No.");
        end
        else begin
            exit('');
        end;
    end;


    procedure SaveDirectoryPath() Foldertxt: Text[1024]
    var
        TextLocal001: Label 'Define Path';
        FileMgt: Codeunit "File Management";
        DirectoryHelper: DotNet BCTestDirectory;
        SearchDirectory: Text[50];
    begin
        SearchDirectory := FileMgt.BrowseForFolderDialog(text000001, '', true);

        if SearchDirectory <> '' then begin
            Foldertxt := Format(SearchDirectory);

            if not FileMgt.ClientDirectoryExists(SearchDirectory) then
                DirectoryHelper.CreateDirectory(SearchDirectory);
        end;
    end;


    procedure Ansi2Ascii(_Text: Text[350]): Text[350]
    begin
        MakeVars;
        exit(ConvertStr(_Text, AnsiStr, AsciiStr));
    end;


    procedure Ascii2Ansi(_Text: Text[350]): Text[350]
    begin
        MakeVars;
        exit(ConvertStr(_Text, AsciiStr, AnsiStr));
    end;


    procedure MakeVars()
    begin
        AsciiStr := ' ÇüéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜø£Ø×ƒáíóúñÑªº¿®¬½¼¡«»¦¦¦¦¦ÁÂÀ©¦¦++¢¥++--+-+ãÃ++--¦-+';
        AsciiStr := AsciiStr + '¤ðÐÊËÈiÍÎÏ++¦_¦Ì¯ÓßÔÒõÕµþÞÚÛÙýÝ¯´­±=¾¶§÷¸°¨·¹³²¦ ';
        CharVar[1] := 196;
        CharVar[2] := 197;
        CharVar[3] := 201;
        CharVar[4] := 242;
        CharVar[5] := 220;
        CharVar[6] := 186;
        CharVar[7] := 191;
        CharVar[8] := 188;
        CharVar[9] := 187;
        CharVar[10] := 193;
        CharVar[11] := 194;
        CharVar[12] := 192;
        CharVar[13] := 195;
        CharVar[14] := 202;
        CharVar[15] := 203;
        CharVar[16] := 200;
        CharVar[17] := 205;
        CharVar[18] := 206;
        CharVar[19] := 204;
        CharVar[20] := 175;
        CharVar[21] := 223;
        CharVar[22] := 213;
        CharVar[23] := 254;
        CharVar[24] := 218;
        CharVar[25] := 219;
        CharVar[26] := 217;
        CharVar[27] := 180;
        CharVar[28] := 177;
        CharVar[29] := 176;
        CharVar[30] := 185;
        CharVar[31] := 179;
        CharVar[32] := 178;
        AnsiStr := ' Ã³ÚÔõÓÕþÛÙÞ´¯ý' + Format(CharVar[1]) + Format(CharVar[2]) + Format(CharVar[3]) + 'µã¶÷' + Format(CharVar[4]);
        AnsiStr := AnsiStr + '¹¨ Í' + Format(CharVar[5]) + '°úÏÎâßÝ¾·±Ð¬' + Format(CharVar[6]) + Format(CharVar[7]);
        AnsiStr := AnsiStr + '«¼¢' + Format(CharVar[8]) + 'í½' + Format(CharVar[9]) + '___ªª' + Format(CharVar[10]) + Format(CharVar[11]);
        AnsiStr := AnsiStr + Format(CharVar[12]) + '®ªª++óÑ++--+-+Ò' + Format(CharVar[13]) + '++--ª-+ñ­ð';
        AnsiStr := AnsiStr + Format(CharVar[14]) + Format(CharVar[15]) + Format(CharVar[16]) + 'i' + Format(CharVar[17]) + Format(CharVar[18]);
        AnsiStr := AnsiStr + '¤++__ª' + Format(CharVar[19]) + Format(CharVar[20]) + 'Ë' + Format(CharVar[21]) + 'ÈÊ§';
        AnsiStr := AnsiStr + Format(CharVar[22]) + 'Á' + Format(CharVar[23]) + 'Ì' + Format(CharVar[24]) + Format(CharVar[25]);
        AnsiStr := AnsiStr + Format(CharVar[26]) + '²¦»' + Format(CharVar[27]) + '¡' + Format(CharVar[28]) + '=¥Âº¸©' + Format(CharVar[29]
        );
        AnsiStr := AnsiStr + '¿À' + Format(CharVar[30]) + Format(CharVar[31]) + Format(CharVar[32]) + '_ ';
    end;


    procedure CalcularDiasMes(pEmpregado: Record Employee) Numdia: Decimal
    var
        rConfRH: Record "Config. Recursos Humanos";
        NHorasTotaisMensais: Decimal;
        DiasTrabParcial: Decimal;
        DiasTrabParcialExtra: Decimal;
    begin
        //Normatica 2014.10.08 -se o empregado está inscrito na seg, social como tempo parcial
        //por cada 6 horas de trabalho conta 1 dia
        //por cada excendente <= 3 conta 1/2 dia
        //por cada excendente > 3 conta 1 dia

        if rConfRH.Get then;
        pEmpregado.TestField(pEmpregado."Regime Duração Trabalho");

        Clear(DiasTrabParcial);
        Clear(DiasTrabParcialExtra);
        Clear(NHorasTotaisMensais);
        if pEmpregado."Regime Duração Trabalho" = 1 then
            exit(30);
        if pEmpregado."Regime Duração Trabalho" = 2 then begin
            if rConfRH."Valor Cálculo Ausências" = rConfRH."Valor Cálculo Ausências"::"Valor Hora Total" then
                NHorasTotaisMensais := pEmpregado."No. Horas Semanais Totais" * 52 / 12
            else
                NHorasTotaisMensais := pEmpregado."No. Horas Semanais" * 52 / 12;


            DiasTrabParcialExtra := NHorasTotaisMensais - ((NHorasTotaisMensais div 6) * 6);
            if DiasTrabParcialExtra <> 0 then begin
                if DiasTrabParcialExtra > 3 then
                    DiasTrabParcialExtra := 1
                else
                    DiasTrabParcialExtra := 0.5;
            end;
            DiasTrabParcial := (NHorasTotaisMensais div 6) + DiasTrabParcialExtra;
            exit(DiasTrabParcial);
        end;
        //Normatica 2014.10.08 - fim
    end;


    procedure Ascii2Ascii7bit(_Text: Text[350]): Text[350]
    var
        AsciiNormal: Text[100];
        Ascii7Bits: Text[100];
    begin
        //**************************************************************************
        // TIRA OS CARACTERES PORTUGUESES - USADO NO FICHEIRO CGA
        //**************************************************************************
        AsciiNormal := 'áàãéíóúçÁÀÃÉÍÓÚÇºª';
        Ascii7Bits := 'aaaeioucAAAEIOUCoa';
        exit(ConvertStr(_Text, AsciiNormal, Ascii7Bits));
    end;

    procedure FormatAddressEmpregado(var AddrArray: array[8] of Text[75]; var Empregado: Record Employee)
    begin
        //HR10.0 Nova função Empregado usada nos mapas dos Recursos Humanos
        FormatAddress.FormatAddr(
              AddrArray, CopyStr(Empregado.FullName, 1, 50), '', '', Empregado.Address, Empregado."Address 2",
              Empregado.City, Empregado."Post Code", Empregado.County, Empregado."Country/Region Code");
    end;

    procedure FormatAddressEmpregadoAltAddr(var AddrArray: array[8] of Text[75]; var Empregado: Record Employee)
    var
        AlternativeAddr: Record "Endereço Alternativo";
    begin
        //HR10.0 Nova função EmpregadoAltAddr usada nos mapas dos Recursos Humanos

        AlternativeAddr.Get(Empregado."No.", Empregado."Alt. Address Code");
        FormatAddress.FormatAddr(
              AddrArray, CopyStr(Empregado.FullName, 1, 50), '', '', AlternativeAddr.Address,
              AlternativeAddr."Address 2", AlternativeAddr.City, AlternativeAddr."Post Code", AlternativeAddr.County, AlternativeAddr."Country Code");
    end;

    procedure EditDimensionSet2(DimSetID: Integer; NewCaption: Text[250]; VAR GlobalDimVal1: Code[20]; VAR GlobalDimVal2: Code[20]): Integer
    var
        DimSetEntry: Record "Dimension Set Entry";
        EditDimSetEntries: Page "Edit Dimension Set Entries";
        NewDimSetID: Integer;
        DimMng: Codeunit "DimensionManagement";
    begin
        NewDimSetID := DimSetID;
        DimSetEntry.RESET;
        DimSetEntry.FILTERGROUP(2);
        DimSetEntry.SETRANGE("Dimension Set ID", DimSetID);
        DimSetEntry.FILTERGROUP(0);
        EditDimSetEntries.SETTABLEVIEW(DimSetEntry);
        EditDimSetEntries.SetFormCaption(NewCaption);
        EditDimSetEntries.RUNMODAL;
        NewDimSetID := EditDimSetEntries.GetDimensionID;
        DimMng.UpdateGlobalDimFromDimSetID(NewDimSetID, GlobalDimVal1, GlobalDimVal2);
        EXIT(NewDimSetID);

    end;
}

