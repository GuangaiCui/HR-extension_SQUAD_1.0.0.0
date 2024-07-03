report 53081 "Sobretaxa em Sede IRS 2013"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Empregado; Empregado)
        {
            DataItemTableView = SORTING("No.") WHERE(Status = FILTER(<> Terminated), "Tipo Contribuinte" = FILTER("Conta de Outrem" | Pensionista));
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                rPeriodosProces.Reset;
                rPeriodosProces.SetRange(rPeriodosProces."Cód. Processamento", CodProc);
                if rPeriodosProces.FindFirst then;

                //Valida se o Empregado tem processamento
                rCabMovEmpregado.Reset;
                rCabMovEmpregado.SetFilter(rCabMovEmpregado."Tipo Processamento", '<>%1', rCabMovEmpregado."Tipo Processamento"::Encargos);
                rCabMovEmpregado.SetRange(rCabMovEmpregado."Cód. Processamento", CodProc);
                rCabMovEmpregado.SetRange(rCabMovEmpregado."No. Empregado", Empregado."No.");
                if not rCabMovEmpregado.FindFirst then
                    CurrReport.Skip;

                Clear(ValorIncidenciaIRS);
                Clear(ValorIRS);
                Clear(ValorSS);
                Clear(ValorCGA);
                Clear(ValorADSE);
                Clear(ValorImposto);
                Clear(numlinha);
                Clear(DuoOrdenadoMinimoSF);
                Clear(DuoOrdenadoMinimoSN);
                Clear(ValorSubFerias);
                Clear(ValorSubNatal);
                Clear(OrdenadoMinimo);
                Clear(ValorEscalaoSobretaxa);
                Clear(PerSobretaxa);

                //2016.01.08 - Sobretaxa 2016 - apurar o escalão da sobretaxa do empregado
                ValorEscalaoSobretaxa := rCabMovEmpregado."Valor para Escalão Sobretaxa";
                rEscaloesSobretaxa.Reset;

                if ((Empregado."Estado Civil" = Empregado."Estado Civil"::Casado) or
                    (Empregado."Estado Civil" = Empregado."Estado Civil"::"União Facto")) and
                   (Empregado."Titular Rendimentos" = Empregado."Titular Rendimentos"::"Único Titular") then
                    rEscaloesSobretaxa.SetRange(rEscaloesSobretaxa.Table, rEscaloesSobretaxa.Table::Cas1Tit)
                else
                    rEscaloesSobretaxa.SetRange(rEscaloesSobretaxa.Table, rEscaloesSobretaxa.Table::NCasCas2Tit);
                rEscaloesSobretaxa.SetFilter(rEscaloesSobretaxa."Minimum Value", '<%1', ValorEscalaoSobretaxa);
                rEscaloesSobretaxa.SetFilter(rEscaloesSobretaxa."Maximum Value", '>=%1', ValorEscalaoSobretaxa);
                if rEscaloesSobretaxa.FindFirst then
                    PerSobretaxa := rEscaloesSobretaxa."Tax %";
                //2016.01.08 - Fim

                //Valor Incidência IRS
                ValorIncidenciaIRS := rCabMovEmpregado."Valor Incidência IRS";

                //Procurar os descontos
                rLinhasMovEmpregado.Reset;
                rLinhasMovEmpregado.SetFilter(rLinhasMovEmpregado."Tipo Processamento", '<>%1', rLinhasMovEmpregado."Tipo Processamento"::Encargos);
                rLinhasMovEmpregado.SetRange(rLinhasMovEmpregado."Cód. Processamento", CodProc);
                rLinhasMovEmpregado.SetRange(rLinhasMovEmpregado."No. Empregado", Empregado."No.");
                rLinhasMovEmpregado.SetRange(rLinhasMovEmpregado."Tipo Rubrica", rLinhasMovEmpregado."Tipo Rubrica"::Desconto);
                if rLinhasMovEmpregado.FindSet then begin
                    repeat
                        //IRS
                        rRubSal.Reset;
                        rRubSal.SetRange(rRubSal.Código, rLinhasMovEmpregado."Cód. Rubrica");
                        rRubSal.SetFilter(rRubSal.Genero, '%1|%2|%3', rRubSal.Genero::IRS, rRubSal.Genero::"IRS Sub. Férias",
                                          rRubSal.Genero::"IRS Sub. Natal");
                        rRubSal.SetRange(rRubSal."Imposto Extraordinário", false);
                        rRubSal.SetRange(rRubSal."Sobretaxa em Sede de IRS", false);
                        if rRubSal.FindFirst then
                            ValorIRS := ValorIRS + Abs(rLinhasMovEmpregado.Valor);

                        //SS
                        rRubSal.Reset;
                        rRubSal.SetRange(rRubSal.Código, rLinhasMovEmpregado."Cód. Rubrica");
                        rRubSal.SetRange(rRubSal.Genero, rRubSal.Genero::SS);
                        if rRubSal.FindFirst then
                            ValorSS := rLinhasMovEmpregado.Valor;

                        //ADSE
                        rRubSal.Reset;
                        rRubSal.SetRange(rRubSal.Código, rLinhasMovEmpregado."Cód. Rubrica");
                        rRubSal.SetRange(rRubSal.Genero, rRubSal.Genero::ADSE);
                        if rRubSal.FindFirst then
                            ValorADSE := rLinhasMovEmpregado.Valor;

                        //CGA
                        if Empregado."Professor Acumulação" = false then begin
                            rRubSal.Reset;
                            rRubSal.SetRange(rRubSal.Código, rLinhasMovEmpregado."Cód. Rubrica");
                            rRubSal.SetRange(rRubSal.Genero, rRubSal.Genero::CGA);
                            if rRubSal.FindFirst then
                                ValorCGA := rLinhasMovEmpregado.Valor;
                        end;
                    until rLinhasMovEmpregado.Next = 0;
                end;

                //Para saber se este processamento tem rubrica de VB (pois no caso de proc. autonomo de Seb. férias não existe VB)
                rLinhasMovEmpregado3.Reset;
                rLinhasMovEmpregado3.SetRange(rLinhasMovEmpregado3."Cód. Processamento", CodProc);
                rLinhasMovEmpregado3.SetRange(rLinhasMovEmpregado3."No. Empregado", Empregado."No.");
                rLinhasMovEmpregado3.SetRange(rLinhasMovEmpregado3.NATREM, rLinhasMovEmpregado3.NATREM::"Remuneração Permanente");
                if rLinhasMovEmpregado3.FindSet then
                    OrdenadoMinimo := rConfRH."Ordenado Mínimo";

                //Para saber se este empregado tem admissões ou demissões, pq se tiver tem de fazer o equivalente em ordenado minimo
                rRubSal.Reset;
                rRubSal.SetRange(rRubSal.Genero, rRubSal.Genero::"Admissão-Demissão");
                if rRubSal.FindFirst then begin
                    rLinhasMovEmpregado3.Reset;
                    rLinhasMovEmpregado3.SetRange(rLinhasMovEmpregado3."Cód. Processamento", CodProc);
                    rLinhasMovEmpregado3.SetRange(rLinhasMovEmpregado3."No. Empregado", Empregado."No.");
                    rLinhasMovEmpregado3.SetRange(rLinhasMovEmpregado3."Cód. Rubrica", rRubSal.Código);
                    if rLinhasMovEmpregado3.FindFirst then
                        OrdenadoMinimo := Abs(rConfRH."Ordenado Mínimo" * (Empregado."Valor Vencimento Base" - Abs(rLinhasMovEmpregado3.Valor)) / Empregado."Valor Vencimento Base");
                end;

                //Para saber o Prop. do Ordenado minimo relativamente ao Sub. Férias e Duo SF
                rLinhasMovEmpregado3.Reset;
                rLinhasMovEmpregado3.SetRange(rLinhasMovEmpregado3."Cód. Processamento", CodProc);
                rLinhasMovEmpregado3.SetRange(rLinhasMovEmpregado3."No. Empregado", Empregado."No.");
                rLinhasMovEmpregado3.SetRange(rLinhasMovEmpregado3.NATREM, rLinhasMovEmpregado3.NATREM::"Cód. Sub. Férias");
                if rLinhasMovEmpregado3.FindSet then begin
                    repeat
                        ValorSubFerias := ValorSubFerias + rLinhasMovEmpregado3.Valor;
                    until rLinhasMovEmpregado3.Next = 0;
                    DuoOrdenadoMinimoSF := rConfRH."Ordenado Mínimo" * (100 * ValorSubFerias / Empregado."Valor Vencimento Base" / 100);
                end;

                //Para saber o Prop. do Ordenado minimo relativamente ao Sub. Natal e Duo SN
                rLinhasMovEmpregado3.Reset;
                rLinhasMovEmpregado3.SetRange(rLinhasMovEmpregado3."Cód. Processamento", CodProc);
                rLinhasMovEmpregado3.SetRange(rLinhasMovEmpregado3."No. Empregado", Empregado."No.");
                rLinhasMovEmpregado3.SetRange(rLinhasMovEmpregado3.NATREM, rLinhasMovEmpregado3.NATREM::"Cód. Sub. Natal");
                if rLinhasMovEmpregado3.FindSet then begin
                    repeat
                        ValorSubNatal := ValorSubNatal + rLinhasMovEmpregado3.Valor;
                    until rLinhasMovEmpregado3.Next = 0;
                    DuoOrdenadoMinimoSN := rConfRH."Ordenado Mínimo" * (100 * ValorSubNatal / Empregado."Valor Vencimento Base" / 100);
                end;

                //Calcular valor imposto
                ValorImposto := ValorIncidenciaIRS - (Abs(ValorIRS) + Abs(ValorSS) + Abs(ValorCGA) + Abs(ValorADSE));
                if ValorImposto > (OrdenadoMinimo + DuoOrdenadoMinimoSF + DuoOrdenadoMinimoSN) then
                    ValorImposto := (ValorImposto - (OrdenadoMinimo + DuoOrdenadoMinimoSF + DuoOrdenadoMinimoSN)) * PerSobretaxa / 100
                else
                    ValorImposto := 0;

                //Ver se a linha do imposto já exite, e se existir apaga-a
                rLinhasMovEmpregado.Reset;
                rLinhasMovEmpregado.SetRange(rLinhasMovEmpregado."Cód. Processamento", CodProc);
                rLinhasMovEmpregado.SetRange(rLinhasMovEmpregado."No. Empregado", Empregado."No.");
                rLinhasMovEmpregado.SetRange(rLinhasMovEmpregado."Cód. Rubrica", CodRub);
                if rLinhasMovEmpregado.FindFirst then
                    rLinhasMovEmpregado.Delete;

                rAbonosDesc.Reset;
                rAbonosDesc.SetRange(rAbonosDesc."No. Empregado", Empregado."No.");
                rAbonosDesc.SetRange(rAbonosDesc."Cód. Rubrica", CodRub);
                if rAbonosDesc.FindFirst then
                    rAbonosDesc.Delete;

                //Lançar o imposto
                if ValorImposto > 0 then begin
                    ValorImposto := Round(ValorImposto, 1, '<');

                    //Procura a rubrica para saber as contas poc
                    rRubSal.Reset;
                    rRubSal.SetRange(rRubSal.Código, CodRub);
                    rRubSal.SetRange(rRubSal.Genero, rRubSal.Genero::IRS);
                    rRubSal.SetRange(rRubSal."Sobretaxa em Sede de IRS", true);
                    rRubSal.SetRange(rRubSal."Tipo Rubrica", rRubSal."Tipo Rubrica"::Desconto);
                    if rRubSal.FindFirst then;

                    //Procura o ultimo numero linha usado
                    rLinhasMovEmpregado.Reset;
                    rLinhasMovEmpregado.SetCurrentKey("Cód. Processamento", "No. Empregado", "No. Linha");
                    rLinhasMovEmpregado.SetRange(rLinhasMovEmpregado."Cód. Processamento", CodProc);
                    rLinhasMovEmpregado.SetRange(rLinhasMovEmpregado."No. Empregado", Empregado."No.");
                    if rLinhasMovEmpregado.FindLast then
                        numlinha := rLinhasMovEmpregado."No. Linha" + 10000;

                    //Insere a linha
                    rLinhasMovEmpregado2.Init;
                    rLinhasMovEmpregado2.Validate(rLinhasMovEmpregado2."Cód. Processamento", CodProc);
                    rLinhasMovEmpregado2."Tipo Processamento" := rPeriodosProces."Tipo Processamento";
                    rLinhasMovEmpregado2.Validate(rLinhasMovEmpregado2."No. Empregado", Empregado."No.");
                    rLinhasMovEmpregado2."No. Linha" := numlinha;
                    rLinhasMovEmpregado2."Data Registo" := rPeriodosProces."Data Registo";
                    rLinhasMovEmpregado2.Validate(rLinhasMovEmpregado2."Cód. Rubrica", CodRub);
                    rLinhasMovEmpregado2."No. Conta a Debitar" := rRubSal."No. Conta a Debitar";
                    rLinhasMovEmpregado2."No. Conta a Creditar" := rRubSal."No. Conta a Creditar";
                    rLinhasMovEmpregado2.Quantidade := PerSobretaxa;
                    rLinhasMovEmpregado2.Valor := -ValorImposto;
                    rLinhasMovEmpregado2.Insert;

                    rAbonosDesc.Init;
                    rAbonosDesc.Validate(rAbonosDesc."No. Empregado", Empregado."No.");
                    rAbonosDesc.Data := rPeriodosProces."Data Registo";
                    rAbonosDesc.Validate(rAbonosDesc."Cód. Rubrica", CodRub);
                    rAbonosDesc.Quantidade := PerSobretaxa;
                    rAbonosDesc.UnidadeMedida := '';
                    rAbonosDesc."Valor Unitário" := ValorImposto;
                    rAbonosDesc."Valor Total" := ValorImposto;
                    rAbonosDesc."Abono - Desconto Bloqueado" := true;
                    rAbonosDesc.Insert(true);
                end;
            end;

            trigger OnPreDataItem()
            begin
                //Valida que existe a rúbrica escolhida
                rRubSal.Reset;
                rRubSal.SetRange(rRubSal.Código, CodRub);
                rRubSal.SetRange(rRubSal.Genero, rRubSal.Genero::IRS);
                rRubSal.SetRange(rRubSal."Sobretaxa em Sede de IRS", true);
                rRubSal.SetRange(rRubSal."Tipo Rubrica", rRubSal."Tipo Rubrica"::Desconto);
                if not rRubSal.FindFirst then
                    Error(Text0003);

                //2015.04.17 - para a sobretaxa ser calculada no momento do processamento
                if FlagVemdoProcessamento then begin
                    Empregado.CopyFilters(AuxEmpregado);
                    Empregado.SetRange(Empregado."Tipo Contribuinte", Empregado."Tipo Contribuinte"::"Conta de Outrem");//Normatica 2015.07.01
                end;
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
                group("Periodo Processamento")
                {
                    Caption = 'Periodo Processamento';
                    field(CodProc; CodProc)
                    {
                        ApplicationArea = All;
                        Caption = 'Código Processamento';
                        TableRelation = "Periodos Processamento";
                    }
                    field(CodRub; CodRub)
                    {
                        ApplicationArea = All;
                        Caption = 'Cód. Rúbrica Imposto Extraordinário';
                        TableRelation = "Rubrica Salarial";
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin

            rRubSal.Reset;
            rRubSal.SetRange(rRubSal.Genero, rRubSal.Genero::IRS);
            rRubSal.SetRange(rRubSal."Sobretaxa em Sede de IRS", true);
            rRubSal.SetRange(rRubSal."Tipo Rubrica", rRubSal."Tipo Rubrica"::Desconto);
            if rRubSal.FindFirst then
                CodRub := rRubSal.Código
            else
                Error(Text0004);
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        Message(Text0005);
    end;

    trigger OnPreReport()
    begin
        rConfRH.Get;

        if CodProc = '' then
            Error(Text0001);
        if CodRub = '' then
            Error(Text0004);

        rPeriodosProces.Reset;
        rPeriodosProces.SetRange(rPeriodosProces."Cód. Processamento", CodProc);
        if rPeriodosProces.FindFirst then
            if rPeriodosProces.Estado = rPeriodosProces.Estado::Fechado then
                Error(Text0002);
    end;

    var
        rPeriodosProces: Record "Periodos Processamento";
        rCabMovEmpregado: Record "Cab. Movs. Empregado";
        rLinhasMovEmpregado: Record "Linhas Movs. Empregado";
        rLinhasMovEmpregado2: Record "Linhas Movs. Empregado";
        rLinhasMovEmpregado3: Record "Linhas Movs. Empregado";
        rRubSal: Record "Rubrica Salarial";
        rAbonosDesc: Record "Abonos - Descontos Extra";
        rConfRH: Record "Config. Recursos Humanos";
        CodProc: Code[10];
        Text0001: Label 'Escolha um Código de Processamento aberto.';
        Text0002: Label 'O processamento escolhido, tem de estar aberto.';
        CodRub: Code[20];
        ValorIncidenciaIRS: Decimal;
        ValorIRS: Decimal;
        ValorSS: Decimal;
        ValorCGA: Decimal;
        ValorADSE: Decimal;
        ValorImposto: Decimal;
        numlinha: Integer;
        Text0003: Label 'A rubrica escolhida, tem de ser do tipo IRS e do tipo Sobretaxa em sede IRS.';
        Text0004: Label 'Tem de configurar uma rúbrica de desconto do tipo IRS e do tipo Sobretaxa em sede IRS.';
        Text0005: Label 'Processo Concluído.';
        DuoOrdenadoMinimoSF: Decimal;
        DuoOrdenadoMinimoSN: Decimal;
        OrdenadoMinimo: Decimal;
        ValorSubFerias: Decimal;
        ValorSubNatal: Decimal;
        AuxEmpregado: Record Empregado;
        FlagVemdoProcessamento: Boolean;
        ValorEscalaoSobretaxa: Decimal;
        PerSobretaxa: Decimal;
        rEscaloesSobretaxa: Record "Tabelas Sobretaxa";


    procedure SetFiltros(pCodProcessamento: Code[10]; var pEmpregado: Record Empregado)
    begin
        //2015.04.17 -  sobretaxa ser calculada no momento do processamento
        FlagVemdoProcessamento := true;

        AuxEmpregado.CopyFilters(pEmpregado);
        CodProc := pCodProcessamento;

        rRubSal.Reset;
        rRubSal.SetRange(rRubSal.Genero, rRubSal.Genero::IRS);
        rRubSal.SetRange(rRubSal."Sobretaxa em Sede de IRS", true);
        rRubSal.SetRange(rRubSal."Tipo Rubrica", rRubSal."Tipo Rubrica"::Desconto);
        if rRubSal.FindFirst then
            CodRub := rRubSal.Código;

        CurrReport.UseRequestPage(false);
    end;
}

