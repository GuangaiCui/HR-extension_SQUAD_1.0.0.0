page 53112 "Preparação Fecho Contas"
{
    // #001 - JTP - 2020.06.24 - Quando há férias não gozadas de 2 anos diferentes
    // 
    // #002 - JTP - 2021.03.08 - Proporcionais Subsídios

    PageType = NavigatePage;
    SaveValues = true;
    UsageCategory = Tasks;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            group(FrameEmp)
            {
                Caption = 'Empregado';
                Visible = FrameEmpVisible;
                field(txtEmpregado; Empregado)
                {
                    ApplicationArea = All;

                    Caption = 'Empregado';
                    TableRelation = Employee;

                    trigger OnValidate()
                    begin
                        Clear(DataTerminacao);
                        Clear(MotivoTerminacao);
                        Clear(NDiasAvisoEmp);
                        Clear(NDiasAvisoEmpresa);
                        Clear(FeriasTotal);
                        Clear(FeriasAnoAnterior);
                        Clear(FeriasAnoCorrente);
                        Clear(NHorasFormacao);
                        EmpregadoOnFormat;
                        MotivoOnFormat;
                    end;
                }
                field(NomeEmp; NomeEmp)
                {
                    ApplicationArea = All;

                    Editable = false;
                    ShowCaption = false;
                }
                field(txtDataTerminacao; DataTerminacao)
                {
                    ApplicationArea = All;

                    Caption = 'Data Terminação';
                }
                field(txtMotivoTerm; CodTerminacao)
                {
                    ApplicationArea = All;

                    Caption = 'Motivo Terminação';
                    TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(MotSai));

                    trigger OnValidate()
                    begin
                        MotivoOnFormat;
                    end;
                }
                field(PeriodoExp; PeriodoExperimental)
                {
                    ApplicationArea = All;

                    Caption = 'Encontra-se dentro do período experimental';
                    Visible = PeriodoExpVisible;
                }
                field(DescTerminacao; DescTerminacao)
                {
                    ApplicationArea = All;

                    Editable = false;
                    ShowCaption = false;
                }
            }
            group(FrameAvisos)
            {
                Caption = 'Avisos';
                Visible = FrameAvisosVisible;
                field(TxtNDiasAvisoEmp; NDiasAvisoEmp)
                {
                    ApplicationArea = All;

                    Caption = 'Nº Dias Pré-Aviso não Cumprido pelo Empregado';
                    Visible = TxtNDiasAvisoEmpVisible;
                }
                field(TxtNDiasAvisoEmpresa; NDiasAvisoEmpresa)
                {
                    ApplicationArea = All;

                    Caption = 'Nº Dias Pré-Aviso não Cumprido pela Empresa';
                    Visible = TxtNDiasAvisoEmpresaVisible;
                }
            }
            group(FrameFerias)
            {
                Caption = 'Férias Não Gozadas';
                Visible = FrameFeriasVisible;
                field(TxtferiasAA; FeriasAnoAnterior)
                {
                    ApplicationArea = All;

                    Caption = 'Nº dias férias não gozadas ano anterior';
                }
                field(TxtferiasAC; FeriasAnoCorrente)
                {
                    ApplicationArea = All;

                    Caption = 'Nº dias férias não gozadas ano corrente';
                }
            }
            group(FrameFormacao)
            {
                Caption = 'Crédito Horas Formação';
                Visible = FrameFormacaoVisible;
                field(TxtNHorasFormacao; NHorasFormacao)
                {
                    ApplicationArea = All;

                    Caption = 'Crédito Horas Formação';
                }
            }
            group(FrameRub)
            {
                Caption = 'Rubricas Salariais';
                Visible = FrameRubVisible;
                field(Rubrica1; CodRubIndemAcordo)
                {
                    ApplicationArea = All;

                    Caption = 'Rub. Idemnização Acordo Mutuo ou Desp.';
                    TableRelation = "Rubrica Salarial";
                }
                field(Rubrica2; CodRubIndemFaltaAvisoEmpregado)
                {
                    ApplicationArea = All;

                    Caption = 'Rub. Idemnização Falta Aviso Prévio do Empregado';
                    TableRelation = "Rubrica Salarial";
                }
                field(Rubrica3; CodRubIndemFaltaAvisoEmpresa)
                {
                    ApplicationArea = All;

                    Caption = 'Rub. Idemnização Falta Aviso Prévio do Empresa';
                    TableRelation = "Rubrica Salarial";
                }
                field(Rubrica4; CodRubCompenFimContrato)
                {
                    ApplicationArea = All;

                    Caption = 'Rub. Compensação Fim Contrato';
                    TableRelation = "Rubrica Salarial";
                }
                field(Rubrica5; CodRubFeriasNaoGozadas)
                {
                    ApplicationArea = All;

                    Caption = 'Rub. Férias Não Gozadas';
                    TableRelation = "Rubrica Salarial";
                }
                field(Rubrica6; CodRubPropSubFerias)
                {
                    ApplicationArea = All;

                    Caption = 'Rub. Proporcionais Sub. Férias';
                    TableRelation = "Rubrica Salarial";
                }
                field(Rubrica7; CodRubPropFerias)
                {
                    ApplicationArea = All;

                    Caption = 'Rub. Proporcionais Férias';
                    TableRelation = "Rubrica Salarial";
                }
                field(Rubrica8; CodRubPropSubNatal)
                {
                    ApplicationArea = All;

                    Caption = 'Rub. Proporcionais Sub. Natal';
                    TableRelation = "Rubrica Salarial";
                }
                field(Rubrica9; CodRubSubFeriasAnoAnterior)
                {
                    ApplicationArea = All;

                    Caption = 'Rub. Sub. Férias (ano anterior)';
                    TableRelation = "Rubrica Salarial";
                }
                field(Rubrica10; CodRubHorasFormacao)
                {
                    ApplicationArea = All;

                    Caption = 'Rub. Crédito Horas Formação';
                    TableRelation = "Rubrica Salarial";
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Anterior)
            {
                ApplicationArea = All;

                Caption = 'Anterior';
                Image = PreviousRecord;
                InFooterBar = true;
                //Promoted = false;
                Visible = AnteriorVisible;

                trigger OnAction()
                begin
                    CurFrame -= 1;

                    if CurFrame = 2 then begin
                        if (MotivoTerminacao = MotivoTerminacao::"Inic Trab período exp.") or
                           (MotivoTerminacao = MotivoTerminacao::"Desp Imp.Trab") or
                           (MotivoTerminacao = MotivoTerminacao::"Inic Trab c aviso") or
                           (MotivoTerminacao = MotivoTerminacao::"Inic Trab s aviso") or
                           (MotivoTerminacao = MotivoTerminacao::"Ref Invali") or
                           (MotivoTerminacao = MotivoTerminacao::"Ref velhice") or
                           (MotivoTerminacao = MotivoTerminacao::"Pré-Ref") or
                           (PeriodoExperimental = true) then begin
                            CurFrame -= 1;
                        end;
                    end;

                    if CurFrame = 1 then begin
                        if Empregado = '' then Error(Text0001);
                        if DataTerminacao = 0D then Error(Text0002);
                        if MotivoTerminacao = MotivoTerminacao::"Inic Trab s aviso" then begin
                            TxtNDiasAvisoEmpVisible := true;
                            TxtNDiasAvisoEmpresaVisible := false;
                        end;

                        if (MotivoTerminacao = MotivoTerminacao::"Inic Emp período exp.") or
                           (MotivoTerminacao = MotivoTerminacao::"Desp Colect") or
                           (MotivoTerminacao = MotivoTerminacao::Desp) or
                           (MotivoTerminacao = MotivoTerminacao::"Ces contr. t-certo") or
                           (MotivoTerminacao = MotivoTerminacao::"Ces contr. t-incerto") then begin
                            TxtNDiasAvisoEmpVisible := false;
                            TxtNDiasAvisoEmpresaVisible := true;
                        end;

                        if (MotivoTerminacao = MotivoTerminacao::"Mútuo Acordo") or
                           (MotivoTerminacao = MotivoTerminacao::"Desp Imp.Trab") or
                           (MotivoTerminacao = MotivoTerminacao::"Inic Trab c aviso") or
                           (MotivoTerminacao = MotivoTerminacao::"Ref Invali") or
                           (MotivoTerminacao = MotivoTerminacao::"Ref velhice") or
                           (MotivoTerminacao = MotivoTerminacao::"Pré-Ref") or
                           (PeriodoExperimental = true) then begin
                            CurFrame -= 1;
                        end;
                    end;




                    SetLayout;
                end;
            }
            action(Seguinte)
            {
                ApplicationArea = All;

                Caption = 'Seguinte';
                Image = NextRecord;
                InFooterBar = true;
                //Promoted = false;
                Visible = SeguinteVisible;

                trigger OnAction()
                begin
                    CurFrame += 1;

                    if CurFrame = 1 then begin
                        if Empregado = '' then Error(Text0001);
                        if DataTerminacao = 0D then Error(Text0002);
                        if (MotivoTerminacao = MotivoTerminacao::"Inic Trab s aviso") or
                           (MotivoTerminacao = MotivoTerminacao::"Inic Trab justa causa") then begin
                            TxtNDiasAvisoEmpVisible := true;
                            TxtNDiasAvisoEmpresaVisible := false;
                        end;


                        if (MotivoTerminacao = MotivoTerminacao::"Desp Colect") or
                           (MotivoTerminacao = MotivoTerminacao::Desp) or
                           (MotivoTerminacao = MotivoTerminacao::"Ces contr. t-certo") or
                           (MotivoTerminacao = MotivoTerminacao::"Ces contr. t-incerto") then begin
                            TxtNDiasAvisoEmpVisible := false;
                            TxtNDiasAvisoEmpresaVisible := true;
                        end;

                        if (MotivoTerminacao = MotivoTerminacao::"Mútuo Acordo") or
                           (MotivoTerminacao = MotivoTerminacao::"Desp Imp.Trab") or
                           (MotivoTerminacao = MotivoTerminacao::"Inic Trab c aviso") or
                           (MotivoTerminacao = MotivoTerminacao::"Ref Invali") or
                           (MotivoTerminacao = MotivoTerminacao::"Ref velhice") or
                           (MotivoTerminacao = MotivoTerminacao::"Pré-Ref") or
                           (PeriodoExperimental = true) then begin
                            CurFrame += 1;
                        end;
                    end;

                    if CurFrame = 2 then begin
                        if (MotivoTerminacao = MotivoTerminacao::"Inic Trab período exp.") or
                           (MotivoTerminacao = MotivoTerminacao::"Desp Imp.Trab") or
                           (MotivoTerminacao = MotivoTerminacao::"Inic Trab c aviso") or
                           (MotivoTerminacao = MotivoTerminacao::"Inic Trab s aviso") or
                           (MotivoTerminacao = MotivoTerminacao::"Ref Invali") or
                           (MotivoTerminacao = MotivoTerminacao::"Ref velhice") or
                           (MotivoTerminacao = MotivoTerminacao::"Pré-Ref") or
                           (PeriodoExperimental = true) then begin
                            CurFrame += 1;
                        end;
                    end;





                    SetLayout;
                end;
            }
            action(Concluir1)
            {
                ApplicationArea = All;

                Caption = 'Concluir';
                Image = Save;
                InFooterBar = true;
                //Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                Visible = ConcluirVisible;

                trigger OnAction()
                begin
                    Concluir;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        TxtIndemMesVisible := true;
        TxtIndemDiasVisible := true;
        ConcluirVisible := true;
        AnteriorVisible := true;
        SeguinteVisible := true;
        FrameRubVisible := true;
        FrameFeriasVisible := true;
        FrameAvisosVisible := true;
        FrameEmpVisible := true;
        FrameFormacaoVisible := true;
        TxtNDiasAvisoEmpresaVisible := true;
        TxtNDiasAvisoEmpVisible := true;
        if ConfRH.Get then;
    end;

    trigger OnOpenPage()
    begin
        CurFrame := 0;
        TempButPos := SeguinteXPos;
        FrmWidth := 9700;
        SetLayout;
        EmpregadoOnFormat;
        MotivoOnFormat;
    end;

    var
        ConfRH: Record "Config. Recursos Humanos";
        CurFrame: Integer;
        TempButPos: Integer;
        Empregado: Code[20];
        NomeEmp: Text[75];
        DataTerminacao: Date;
        CodTerminacao: Code[10];
        DescTerminacao: Text[250];
        MotivoTerminacao: Option " ","Inic Emp período exp.","Inic Trab período exp.","Mútuo Acordo","Desp Imp.Trab","Desp Colect",Desp,"Ref velhice","Ref Invali","Inic Trab justa causa","Inic Trab c aviso","Inic Trab s aviso","Ces contr. t-certo","Ces contr. t-incerto","Pré-Ref","Sit. esp. saida imped. prolong.";
        NDiasAvisoEmp: Integer;
        Text0001: Label 'Tem de escolher um empregado.';
        Text0002: Label 'Tem de preencher a data de terminação.';
        NDiasAvisoEmpresa: Integer;
        FeriasAnoAnterior: Integer;
        FeriasAnoCorrente: Integer;
        FeriasTotal: Integer;
        TabContratoEmp: Record "Contrato Empregado";
        TabFeriasEmp: Record "Férias Empregados";
        TabEmpregado: Record Employee;
        AbonosDescExtra: Record "Abonos - Descontos Extra";
        TabRubricaEmp: Record "Rubrica Salarial Empregado";
        TabRubSal: Record "Rubrica Salarial";
        TabRubSal2: Record "Rubrica Salarial";
        TabRU: Record "RU - Tabelas";
        ValorTotal: Decimal;
        Text0003: Label 'Não existe nenhuma Rúbrica definida como Indem. Mútuo Acordo ou Despedimento.';
        Text0004: Label 'Não existe nenhuma Rúbrica definida como Indem. Falta Aviso Prévio do Empregado.';
        Text0005: Label 'Não existe nenhuma Rúbrica definida como Indem. Falta Aviso Prévio do Empresa.';
        Text0006: Label 'Não existe nenhuma Rúbrica definida como Compensação fim contrato.';
        Text0007: Label 'Não existe nenhuma Rúbrica definida como Férias não gozadas.';
        Text0008: Label 'Não existe nenhuma Rúbrica definida como Proporcional Sub. Férias.';
        Text0009: Label 'Não existe nenhuma Rúbrica definida como Proporcional Sub. Natal.';
        Text0010: Label 'Não existe nenhuma Rúbrica definida como Admissão-demissão.';
        AnosdeCasa: Integer;
        MesesdeCasa: Integer;
        PeriodoExperimental: Boolean;
        DiasNTrabalhados: Integer;
        Text0011: Label 'Não existe nenhuma Rúbrica definida como Sub. Férias Ano Anterior.';
        CodRubIndemAcordo: Code[20];
        CodRubIndemFaltaAvisoEmpregado: Code[20];
        CodRubIndemFaltaAvisoEmpresa: Code[20];
        CodRubCompenFimContrato: Code[20];
        CodRubFeriasNaoGozadas: Code[20];
        CodRubPropSubFerias: Code[20];
        CodRubPropFerias: Code[20];
        CodRubPropSubNatal: Code[20];
        CodRubSubFeriasAnoAnterior: Code[20];
        CodRubHorasFormacao: Code[20];

        PeriodoExpVisible: Boolean;
        SeguinteXPos: Integer;
        FrmWidth: Integer;

        TxtNDiasAvisoEmpVisible: Boolean;

        TxtNDiasAvisoEmpresaVisible: Boolean;

        FrameEmpVisible: Boolean;

        FrameAvisosVisible: Boolean;

        FrameFeriasVisible: Boolean;

        FrameRubVisible: Boolean;
        FrameFormacaoVisible: Boolean;

        SeguinteVisible: Boolean;

        AnteriorVisible: Boolean;

        ConcluirVisible: Boolean;

        TxtIndemDiasVisible: Boolean;

        TxtIndemMesVisible: Boolean;
        ConcluirXPos: Integer;
        FrameAvisosXPos: Integer;
        FrameEmpXPos: Integer;
        FrameIndemCompXPos: Integer;
        FrameFeriasXPos: Integer;
        FrameRubXPos: Integer;
        FrameFornacaoXPos: Integer;
        NHorasFormacao: Integer;
        text0012: Label 'Não existe nenhuma Rúbrica definida como Crédito Horas Formação.';
        NDiasCaducidadeCont: Decimal;
        NDiasIndemn: Decimal;
        ValorCompensacao: Decimal;


    procedure SetLayout()
    begin
        case CurFrame of
            0:
                begin
                    FrameEmpVisible := true;
                    FrameAvisosVisible := false;
                    FrameFeriasVisible := false;
                    FrameRubVisible := false;
                    FrameFormacaoVisible := false;
                    SeguinteVisible := true;
                    AnteriorVisible := false;
                    ConcluirVisible := false;
                    SeguinteXPos := ConcluirXPos;
                end;
            1:
                begin
                    FrameEmpVisible := false;
                    FrameAvisosVisible := true;
                    FrameFeriasVisible := false;
                    FrameRubVisible := false;
                    FrameFormacaoVisible := false;
                    FrameAvisosXPos := FrameEmpXPos;
                    SeguinteVisible := true;
                    AnteriorVisible := true;
                    ConcluirVisible := false;

                end;

            2:
                begin
                    FrameEmpVisible := false;
                    FrameAvisosVisible := false;
                    FrameFeriasVisible := true;
                    FrameRubVisible := false;
                    FrameFormacaoVisible := false;
                    FrameFeriasXPos := FrameEmpXPos;
                    SeguinteVisible := true;
                    AnteriorVisible := true;
                    ConcluirVisible := false;

                    TabFeriasEmp.Reset;
                    TabFeriasEmp.SetRange(TabFeriasEmp."No. Empregado", Empregado);
                    TabFeriasEmp.SetRange(TabFeriasEmp.Gozada, false);
                    if TabFeriasEmp.Find('+') then
                        FeriasTotal := TabFeriasEmp.Count;

                end;

            3:
                begin
                    FrameEmpVisible := false;
                    FrameAvisosVisible := false;
                    FrameFeriasVisible := false;
                    FrameFormacaoVisible := true;
                    FrameFornacaoXPos := FrameEmpXPos;
                    FrameRubVisible := false;
                    SeguinteVisible := true;
                    AnteriorVisible := true;
                    ConcluirVisible := false;

                end;

            4:
                begin
                    FrameEmpVisible := false;
                    FrameAvisosVisible := false;
                    FrameFeriasVisible := false;
                    FrameRubVisible := true;
                    FrameFormacaoVisible := false;
                    FrameRubXPos := FrameEmpXPos;
                    SeguinteVisible := false;
                    AnteriorVisible := true;
                    ConcluirVisible := true;

                    //----
                    TabRubSal2.Reset;
                    TabRubSal2.SetRange(TabRubSal2."Genero Rubrica Fecho",
                                        TabRubSal2."Genero Rubrica Fecho"::"Indem. Mútuo Acordo ou Despedimento");
                    if TabRubSal2.FindLast then
                        if TabRubSal2.Count = 1 then
                            CodRubIndemAcordo := TabRubSal2.Código;

                    //----
                    TabRubSal2.Reset;
                    TabRubSal2.SetRange(TabRubSal2."Genero Rubrica Fecho",
                                        TabRubSal2."Genero Rubrica Fecho"::"Indem. Falta Aviso Prévio do Empregado");
                    if TabRubSal2.FindLast then
                        if TabRubSal2.Count = 1 then
                            CodRubIndemFaltaAvisoEmpregado := TabRubSal2.Código;

                    //----
                    TabRubSal2.Reset;
                    TabRubSal2.SetRange(TabRubSal2."Genero Rubrica Fecho",
                                        TabRubSal2."Genero Rubrica Fecho"::"Indem. Falta Aviso Prévio da Empresa");
                    if TabRubSal2.FindLast then
                        if TabRubSal2.Count = 1 then
                            CodRubIndemFaltaAvisoEmpresa := TabRubSal2.Código;

                    //----
                    TabRubSal2.Reset;
                    TabRubSal2.SetRange(TabRubSal2."Genero Rubrica Fecho",
                                        TabRubSal2."Genero Rubrica Fecho"::"Compensação fim contrato");
                    if TabRubSal2.FindLast then
                        if TabRubSal2.Count = 1 then
                            CodRubCompenFimContrato := TabRubSal2.Código;


                    //----
                    //Credito horas formação
                    TabRubSal2.Reset;
                    TabRubSal2.SetRange(TabRubSal2."Genero Rubrica Fecho",
                                        TabRubSal2."Genero Rubrica Fecho"::"Cred. Formacao");
                    if TabRubSal2.FindLast then
                        if TabRubSal2.Count = 1 then
                            CodRubHorasFormacao := TabRubSal2.Código;


                    //----
                    //Nº de dias de Férias que o Empregado adquiriu em 1 janeiro
                    // + (mais) nº de dias férias correspondentes aos meses trabalhados este ano
                    // - (menos) os dias de férias já gozou
                    TabRubSal2.Reset;
                    TabRubSal2.SetRange(TabRubSal2."Genero Rubrica Fecho",
                                        TabRubSal2."Genero Rubrica Fecho"::"Férias não gozadas");
                    if TabRubSal2.FindLast then
                        if TabRubSal2.Count = 1 then
                            CodRubFeriasNaoGozadas := TabRubSal2.Código;

                    //----
                    //Valor do Sub. de Férias correspondente ao tempo que o emprgado trabalhou este ano
                    TabRubSal2.Reset;
                    TabRubSal2.SetRange(TabRubSal2."Genero Rubrica Fecho",
                                        TabRubSal2."Genero Rubrica Fecho"::"Proporcional Sub. Férias");
                    if TabRubSal2.FindLast then
                        if TabRubSal2.Count = 1 then
                            CodRubPropSubFerias := TabRubSal2.Código;

                    //----
                    //Valor do Sub. de Natal correspondente ao tempo que o emprgado trabalhou este ano
                    TabRubSal2.Reset;
                    TabRubSal2.SetRange(TabRubSal2."Genero Rubrica Fecho",
                                        TabRubSal2."Genero Rubrica Fecho"::"Proporcional Sub. Natal");
                    if TabRubSal2.FindLast then
                        if TabRubSal2.Count = 1 then
                            CodRubPropSubNatal := TabRubSal2.Código;

                    //----
                    //Valor do Sub. de Férias adquirido a 1 janeiro
                    TabRubSal2.Reset;
                    TabRubSal2.SetRange(TabRubSal2."Genero Rubrica Fecho",
                                        TabRubSal2."Genero Rubrica Fecho"::"Sub. Férias Ano Anterior");
                    if TabRubSal2.FindLast then
                        if TabRubSal2.Count = 1 then
                            CodRubSubFeriasAnoAnterior := TabRubSal2.Código;


                    //----
                    // Prop. Férias
                    //Como no mês em que gozamos férias, recebemos na mesma ordenado
                    //Este valor refere-se a isso
                    //Na Seg. Social esta rubrica tem o código das férias não gozadas
                    TabRubSal2.Reset;
                    TabRubSal2.SetRange(TabRubSal2."Genero Rubrica Fecho",
                                        TabRubSal2."Genero Rubrica Fecho"::"Prop. Férias");
                    if TabRubSal2.FindLast then
                        if TabRubSal2.Count = 1 then
                            CodRubPropFerias := TabRubSal2.Código;


                end;


        end;
    end;


    procedure Concluir()
    begin
        TabEmpregado.Reset;
        if TabEmpregado.Get(Empregado) then begin
            TabEmpregado."End Date" := DataTerminacao;
            TabEmpregado."Motivo de Terminação" := CodTerminacao;
            TabEmpregado.Modify;
        end;

        FeriasTotal := FeriasAnoAnterior + FeriasAnoCorrente;




        //***************************************
        //*************Indemnização**************
        //***************************************
        if (MotivoTerminacao = MotivoTerminacao::"Mútuo Acordo") or
           (MotivoTerminacao = MotivoTerminacao::"Desp Colect") or (MotivoTerminacao = MotivoTerminacao::Desp) or
           (MotivoTerminacao = MotivoTerminacao::"Inic Trab justa causa") then begin

            ////////Saber quais os abonos que entram para o calculo da indemnização///////////////
            Clear(ValorTotal);
            TabRubricaEmp.Reset;
            TabRubricaEmp.SetCurrentKey("No. Empregado", "No. Linha");
            TabRubricaEmp.SetRange("Tipo Rubrica", TabRubricaEmp."Tipo Rubrica"::Abono);
            TabRubricaEmp.SetRange("No. Empregado", Empregado);
            TabRubricaEmp.SetFilter(TabRubricaEmp."Data Início", '<=%1', DataTerminacao);
            TabRubricaEmp.SetFilter(TabRubricaEmp."Data Fim", '>=%1|=%2', DataTerminacao, 0D);
            if TabRubricaEmp.Find('-') then begin
                repeat
                    TabRubSal.Reset;
                    if (TabRubSal.Get(TabRubricaEmp."Cód. Rúbrica Salarial")) and (TabRubSal."Usado no cálculo indemnização" = true) then
                        ValorTotal := ValorTotal + TabRubricaEmp."Valor Total";
                until TabRubricaEmp.Next = 0;
            end;


            ////////Saber os dias a que tem direito///////////////
            Clear(NDiasIndemn);
            Clear(AnosdeCasa);
            TabContratoEmp.Reset;
            TabContratoEmp.SetRange(TabContratoEmp."Cód. Empregado", Empregado);
            if TabContratoEmp.FindSet then begin
                repeat
                    //Contratos com Data Inicio anterior a 01-11-2011
                    //-----------------------------------------------
                    if TabContratoEmp."Data Inicio Contrato" < 20111101D then begin
                        //Contrato sem termo
                        if TabContratoEmp."Tipo Contrato" = TabContratoEmp."Tipo Contrato"::"Sem Termo" then begin
                            AnosdeCasa := Round((DataTerminacao - TabContratoEmp."Data Inicio Contrato" + 1) / 365, 0.01);
                            if (DataTerminacao <= 20121031D) then
                                NDiasIndemn := NDiasIndemn + (AnosdeCasa * 30)
                            else begin
                                if (DataTerminacao >= 20121101D) and (DataTerminacao <= 20130930D) then begin
                                    NDiasIndemn := NDiasIndemn + ((20121031D - TabContratoEmp."Data Inicio Contrato" + 1) / 365 * 30);
                                    NDiasIndemn := NDiasIndemn + ((DataTerminacao - 20121101D + 1) / 365 * 20);
                                end else begin
                                    if AnosdeCasa <= 3 then
                                        NDiasIndemn := NDiasIndemn + (AnosdeCasa * 18)
                                    else begin
                                        NDiasIndemn := NDiasIndemn + (3 * 18);
                                        NDiasIndemn := NDiasIndemn + (AnosdeCasa - 3 * 12);
                                    end;
                                end;
                            end;
                        end;

                        //Contrato a termo ou temporario
                        if (TabContratoEmp."Tipo Contrato" = TabContratoEmp."Tipo Contrato"::"A Termo") or
                           (TabContratoEmp."Tipo Contrato" = TabContratoEmp."Tipo Contrato"::"A Termo p/ Cedência Temporária") then begin
                            if (TabContratoEmp."Data Fim Contrato" <= 20121031D) then begin
                                if (TabContratoEmp."Data Fim Contrato" - TabContratoEmp."Data Inicio Contrato" + 1) < 180 then
                                    NDiasIndemn := NDiasIndemn + ((TabContratoEmp."Data Fim Contrato" - TabContratoEmp."Data Inicio Contrato" + 1) / 30 * 3)
                                else
                                    NDiasIndemn := NDiasIndemn + ((TabContratoEmp."Data Fim Contrato" - TabContratoEmp."Data Inicio Contrato" + 1) / 30 * 2)
                            end;
                            if (DataTerminacao <= 20121031D) then begin
                                if (DataTerminacao - TabContratoEmp."Data Inicio Contrato" + 1) < 180 then
                                    NDiasIndemn := NDiasIndemn + ((DataTerminacao - TabContratoEmp."Data Inicio Contrato" + 1) / 30 * 3)
                                else
                                    NDiasIndemn := NDiasIndemn + ((DataTerminacao - TabContratoEmp."Data Inicio Contrato" + 1) / 30 * 2)
                            end else begin
                                if (DataTerminacao >= 20121101D) and (DataTerminacao <= 20130930D) then begin
                                    NDiasIndemn := NDiasIndemn + ((20121031D - TabContratoEmp."Data Inicio Contrato" + 1) / 30 * 2);
                                    NDiasIndemn := NDiasIndemn + ((DataTerminacao - 20121101D + 1) / 365 * 20);
                                end else begin
                                    if (DataTerminacao >= 20150101D) then begin
                                        NDiasIndemn := NDiasIndemn + ((20121031D - TabContratoEmp."Data Inicio Contrato" + 1) / 30 * 2);
                                        NDiasIndemn := NDiasIndemn + ((20130930D - 20121101D + 1) / 365 * 20);
                                        NDiasIndemn := NDiasIndemn + ((DataTerminacao - 20150101D + 1) / 365 * 18);
                                    end;
                                end;
                            end;
                        end;
                    end;
                    //Contratos com Data Inicio superior a 01-11-2011 e anterior a 30-09-2013
                    //-----------------------------------------------------------------------
                    if (TabContratoEmp."Data Inicio Contrato" >= 20111101D) and (TabContratoEmp."Data Inicio Contrato" <= 20130930D) then begin
                        //Contrato sem termo e a termo
                        if (TabContratoEmp."Tipo Contrato" = TabContratoEmp."Tipo Contrato"::"Sem Termo") or
                           (TabContratoEmp."Tipo Contrato" = TabContratoEmp."Tipo Contrato"::"A Termo") then begin
                            if (DataTerminacao <= 20130930D) then begin
                                NDiasIndemn := NDiasIndemn + ((DataTerminacao - TabContratoEmp."Data Inicio Contrato" + 1) / 365 * 20);
                            end else begin
                                NDiasIndemn := NDiasIndemn + ((20130930D - TabContratoEmp."Data Inicio Contrato" + 1) / 365 * 20);
                                AnosdeCasa := Round((DataTerminacao - 20150101D + 1) / 365, 0.01);
                                if AnosdeCasa <= 3 then
                                    NDiasIndemn := NDiasIndemn + (3 * 18)
                                else begin
                                    NDiasIndemn := NDiasIndemn + (3 * 18);
                                    NDiasIndemn := NDiasIndemn + (AnosdeCasa - 3 * 12);
                                end;
                            end;
                        end;
                    end;

                    //Contratos com Data Inicio superior a 01-10-2013
                    //-----------------------
                    if (TabContratoEmp."Data Inicio Contrato" >= 20150101D) then begin
                        //Contrato sem termo
                        if (TabContratoEmp."Tipo Contrato" = TabContratoEmp."Tipo Contrato"::"Sem Termo") then begin
                            if MotivoTerminacao = MotivoTerminacao::"Mútuo Acordo" then begin
                                AnosdeCasa := Round((DataTerminacao - TabContratoEmp."Data Inicio Contrato" + 1) / 365, 0.01);
                                if AnosdeCasa <= 3 then
                                    NDiasIndemn := NDiasIndemn + (AnosdeCasa * 18)
                                else begin
                                    NDiasIndemn := NDiasIndemn + (3 * 18);
                                    NDiasIndemn := NDiasIndemn + (AnosdeCasa - 3 * 12);
                                end;
                            end;
                            if MotivoTerminacao = MotivoTerminacao::"Desp Colect" then begin
                                AnosdeCasa := Round((DataTerminacao - TabContratoEmp."Data Inicio Contrato" + 1) / 365, 0.01);
                                NDiasIndemn := NDiasIndemn + (AnosdeCasa * 12)
                            end;
                        end else begin
                            //Contratos a termo
                            if (TabContratoEmp."Tipo Contrato" = TabContratoEmp."Tipo Contrato"::"A Termo") then begin
                                if MotivoTerminacao = MotivoTerminacao::"Mútuo Acordo" then begin
                                    AnosdeCasa := Round((DataTerminacao - TabContratoEmp."Data Inicio Contrato" + 1) / 365, 0.01);
                                    NDiasIndemn := NDiasIndemn + (AnosdeCasa * 18)
                                end;
                                if MotivoTerminacao = MotivoTerminacao::"Desp Colect" then begin
                                    AnosdeCasa := Round((DataTerminacao - TabContratoEmp."Data Inicio Contrato" + 1) / 365, 0.01);
                                    if AnosdeCasa <= 3 then
                                        NDiasIndemn := NDiasIndemn + (AnosdeCasa * 18)
                                    else begin
                                        NDiasIndemn := NDiasIndemn + (3 * 18);
                                        NDiasIndemn := NDiasIndemn + (AnosdeCasa - 3 * 12);
                                    end;
                                end;
                            end;
                        end;
                    end;

                until TabContratoEmp.Next = 0;
            end;


            if CodRubIndemAcordo <> '' then begin
                AbonosDescExtra.Init;
                AbonosDescExtra."No. Empregado" := Empregado;
                AbonosDescExtra.Data := DataTerminacao;
                AbonosDescExtra.Validate(AbonosDescExtra."Cód. Rubrica", CodRubIndemAcordo);
                AbonosDescExtra.Quantidade := Round(NDiasIndemn, 0.01);
                if ((NDiasIndemn * ValorTotal / 30) > (12 * ValorTotal)) and
                   ((NDiasIndemn * ValorTotal / 30) > (240 * ConfRH."Ordenado Mínimo")) then begin
                    if (12 * ValorTotal) > (240 * ConfRH."Ordenado Mínimo") then
                        AbonosDescExtra."Valor Total" := 12 * ValorTotal
                    else
                        AbonosDescExtra."Valor Total" := 240 * ConfRH."Ordenado Mínimo";
                end else
                    AbonosDescExtra.Validate(AbonosDescExtra."Valor Unitário", ValorTotal / 30);

                AbonosDescExtra.Insert(true);
            end else
                Error(Text0003);
        end;


        //***************************************
        //*****Falta Aviso Prévio - Empregado****
        //***************************************
        if (NDiasAvisoEmp <> 0) then begin
            if CodRubIndemFaltaAvisoEmpregado <> '' then begin
                AbonosDescExtra.Init;
                AbonosDescExtra."No. Empregado" := Empregado;
                AbonosDescExtra.Data := DataTerminacao;
                AbonosDescExtra.Validate(AbonosDescExtra."Cód. Rubrica", CodRubIndemFaltaAvisoEmpregado);
                AbonosDescExtra.Quantidade := NDiasAvisoEmp;
                AbonosDescExtra.Validate(AbonosDescExtra."Valor Unitário", TabEmpregado."Valor Dia");
                AbonosDescExtra.Insert(true);
            end else
                Error(Text0004);
        end;


        //***************************************
        //*****Falta Aviso Prévio - Empresa******
        //***************************************
        if (NDiasAvisoEmpresa <> 0) and ((MotivoTerminacao = MotivoTerminacao::"Inic Emp período exp.") or
           (MotivoTerminacao = MotivoTerminacao::"Desp Colect")
           or (MotivoTerminacao = MotivoTerminacao::Desp)
           or (MotivoTerminacao = MotivoTerminacao::"Ces contr. t-certo")
           or (MotivoTerminacao = MotivoTerminacao::"Ces contr. t-incerto"))
           then begin
            if CodRubIndemFaltaAvisoEmpresa <> '' then begin
                AbonosDescExtra.Init;
                AbonosDescExtra."No. Empregado" := Empregado;
                AbonosDescExtra.Data := DataTerminacao;
                AbonosDescExtra.Validate(AbonosDescExtra."Cód. Rubrica", CodRubIndemFaltaAvisoEmpresa);
                AbonosDescExtra.Quantidade := NDiasAvisoEmpresa;
                AbonosDescExtra.Validate(AbonosDescExtra."Valor Unitário", TabEmpregado."Valor Dia");
                AbonosDescExtra.Insert(true);
            end else
                Error(Text0005);
        end;


        //***************************************
        //*******Compensação Fim Contrato********
        //***************************************
        if ((MotivoTerminacao = MotivoTerminacao::"Ces contr. t-certo")
           or (MotivoTerminacao = MotivoTerminacao::"Ces contr. t-incerto")) then begin

            Clear(ValorTotal);
            TabRubricaEmp.Reset;
            TabRubricaEmp.SetCurrentKey("No. Empregado", "No. Linha");
            TabRubricaEmp.SetRange("Tipo Rubrica", TabRubricaEmp."Tipo Rubrica"::Abono);
            TabRubricaEmp.SetRange("No. Empregado", Empregado);
            TabRubricaEmp.SetFilter(TabRubricaEmp."Data Início", '<=%1', DataTerminacao);
            TabRubricaEmp.SetFilter(TabRubricaEmp."Data Fim", '>=%1|=%2', DataTerminacao, 0D);
            if TabRubricaEmp.Find('-') then begin
                repeat
                    TabRubSal.Reset;
                    if (TabRubSal.Get(TabRubricaEmp."Cód. Rúbrica Salarial")) and (TabRubSal."Usado no cálculo indemnização" = true) then
                        ValorTotal := ValorTotal + TabRubricaEmp."Valor Total";

                until TabRubricaEmp.Next = 0;
            end;


            ////////Saber os dias a que tem direito///////////////
            Clear(NDiasCaducidadeCont);
            Clear(ValorCompensacao);
            Clear(AnosdeCasa);
            if (MotivoTerminacao = MotivoTerminacao::"Ces contr. t-certo") or (MotivoTerminacao = MotivoTerminacao::"Ces contr. t-incerto") then begin
                TabContratoEmp.Reset;
                TabContratoEmp.SetRange(TabContratoEmp."Cód. Empregado", Empregado);
                if TabContratoEmp.FindSet then begin
                    repeat
                        //Contratos com Data Inicio entre 01-11-2011 e 30-09-2013
                        //-----------------------
                        if (TabContratoEmp."Data Inicio Contrato" >= 20111101D) and (TabContratoEmp."Data Inicio Contrato" <= 20130930D) then begin
                            if TabContratoEmp."Data Fim Contrato" <= 20130930D then
                                NDiasCaducidadeCont := NDiasCaducidadeCont + ((TabContratoEmp."Data Fim Contrato" - TabContratoEmp."Data Inicio Contrato" + 1) / 365 * 20)
                            else begin
                                NDiasCaducidadeCont := NDiasCaducidadeCont + ((20130930D - TabContratoEmp."Data Inicio Contrato" + 1) / 365 * 20);
                                AnosdeCasa := Round((TabContratoEmp."Data Fim Contrato" - 20150101D + 1) / 365, 0.01);
                                if AnosdeCasa <= 3 then
                                    NDiasCaducidadeCont := NDiasCaducidadeCont + (AnosdeCasa * 18)
                                else begin
                                    NDiasCaducidadeCont := NDiasCaducidadeCont + (3 * 18);
                                    NDiasCaducidadeCont := NDiasCaducidadeCont + (AnosdeCasa - 3 * 12);
                                end;
                            end;
                        end;
                        //Contratos com Data Inicio posterior 30-09-2013
                        //-----------------------
                        if (TabContratoEmp."Data Inicio Contrato" > 20130930D) then begin
                            if (MotivoTerminacao = MotivoTerminacao::"Ces contr. t-certo") then
                                NDiasCaducidadeCont := NDiasCaducidadeCont + ((TabContratoEmp."Data Fim Contrato" - TabContratoEmp."Data Inicio Contrato" + 1) / 365 * 18)
                            else begin
                                AnosdeCasa := Round((TabContratoEmp."Data Fim Contrato" - TabContratoEmp."Data Inicio Contrato" + 1) / 365, 0.01);
                                if AnosdeCasa <= 3 then
                                    NDiasCaducidadeCont := NDiasCaducidadeCont + (AnosdeCasa * 18)
                                else begin
                                    NDiasCaducidadeCont := NDiasCaducidadeCont + (3 * 18);
                                    NDiasCaducidadeCont := NDiasCaducidadeCont + (AnosdeCasa - 3 * 12);
                                end;
                            end;

                        end;
                    until TabContratoEmp.Next = 0;
                end;
            end;


            if CodRubCompenFimContrato <> '' then begin
                AbonosDescExtra.Init;
                AbonosDescExtra."No. Empregado" := Empregado;
                AbonosDescExtra.Data := DataTerminacao;
                AbonosDescExtra.Validate(AbonosDescExtra."Cód. Rubrica", CodRubCompenFimContrato);
                AbonosDescExtra.Quantidade := Round(NDiasCaducidadeCont, 0.01);
                if ((NDiasCaducidadeCont * ValorTotal / 30) > (12 * ValorTotal)) and
                   ((NDiasCaducidadeCont * ValorTotal / 30) > (240 * ConfRH."Ordenado Mínimo")) then begin
                    if (12 * ValorTotal) > (240 * ConfRH."Ordenado Mínimo") then
                        AbonosDescExtra."Valor Total" := 12 * ValorTotal
                    else
                        AbonosDescExtra."Valor Total" := 240 * ConfRH."Ordenado Mínimo";
                end else
                    AbonosDescExtra.Validate(AbonosDescExtra."Valor Unitário", ValorTotal / 30);
                AbonosDescExtra.Insert(true);
            end else
                Error(Text0006);
        end;

        //***************************************
        //**********Credito Horas Formação***********
        //***************************************
        if NHorasFormacao <> 0 then begin
            if CodRubHorasFormacao <> '' then begin
                AbonosDescExtra.Init;
                AbonosDescExtra."No. Empregado" := Empregado;
                AbonosDescExtra.Data := DataTerminacao;
                AbonosDescExtra.Validate(AbonosDescExtra."Cód. Rubrica", CodRubHorasFormacao);
                AbonosDescExtra.Quantidade := NHorasFormacao;
                AbonosDescExtra.Validate(AbonosDescExtra."Valor Unitário",
                  (TabEmpregado."Valor Vencimento Base" * 12) / (52 * TabEmpregado."No. Horas Semanais"));
                AbonosDescExtra.Insert(true);
            end else
                Error(text0012);
        end;


        //***************************************
        //**********Férias Não Gozadas***********
        //***************************************
        if FeriasTotal <> 0 then begin
            if CodRubFeriasNaoGozadas <> '' then begin
                //#001 - JTP - 2020.06.24 - Begin
                if (FeriasAnoAnterior <> 0) and (FeriasAnoCorrente <> 0) then begin
                    AbonosDescExtra.Init;
                    AbonosDescExtra."No. Empregado" := Empregado;
                    AbonosDescExtra.Data := DataTerminacao;
                    AbonosDescExtra."Data a que se refere o Mov." := CalcDate('-CM-1D', DataTerminacao);
                    AbonosDescExtra.Validate(AbonosDescExtra."Cód. Rubrica", CodRubFeriasNaoGozadas);
                    AbonosDescExtra.Quantidade := FeriasAnoAnterior;
                    AbonosDescExtra.Validate(AbonosDescExtra."Valor Unitário", TabEmpregado."Valor Vencimento Base" / 22);
                    AbonosDescExtra.Insert(true);

                    AbonosDescExtra.Init;
                    AbonosDescExtra."No. Empregado" := Empregado;
                    AbonosDescExtra.Data := DataTerminacao;
                    AbonosDescExtra.Validate(AbonosDescExtra."Cód. Rubrica", CodRubFeriasNaoGozadas);
                    AbonosDescExtra.Quantidade := FeriasAnoCorrente;
                    AbonosDescExtra.Validate(AbonosDescExtra."Valor Unitário", TabEmpregado."Valor Vencimento Base" / 22);
                    AbonosDescExtra.Insert(true);
                end
                else begin
                    //#001 - JTP - 2020.06.24 - End
                    AbonosDescExtra.Init;
                    AbonosDescExtra."No. Empregado" := Empregado;
                    AbonosDescExtra.Data := DataTerminacao;
                    AbonosDescExtra.Validate(AbonosDescExtra."Cód. Rubrica", CodRubFeriasNaoGozadas);
                    AbonosDescExtra.Quantidade := FeriasTotal;
                    AbonosDescExtra.Validate(AbonosDescExtra."Valor Unitário", TabEmpregado."Valor Vencimento Base" / 22);
                    AbonosDescExtra.Insert(true);
                end;
            end else
                Error(Text0007);
        end;


        //***************************************
        //**********Prop. Sub. Férias************
        //***************************************

        if CodRubPropSubFerias <> '' then begin
            AbonosDescExtra.Init;
            AbonosDescExtra."No. Empregado" := Empregado;
            AbonosDescExtra.Data := DataTerminacao;
            AbonosDescExtra.Validate(AbonosDescExtra."Cód. Rubrica", CodRubPropSubFerias);
            AbonosDescExtra.Quantidade := 1;
            AbonosDescExtra.Validate(AbonosDescExtra."Valor Unitário", ProporcionaisSF(Empregado));
            AbonosDescExtra.Insert(true);
        end else
            Error(Text0008);

        //***************************************
        //**********Prop. Férias************
        //***************************************

        if CodRubPropFerias <> '' then begin
            if PropFerias(Empregado) <> 0 then begin
                AbonosDescExtra.Init;
                AbonosDescExtra."No. Empregado" := Empregado;
                AbonosDescExtra.Data := DataTerminacao;
                AbonosDescExtra.Validate(AbonosDescExtra."Cód. Rubrica", CodRubPropFerias);
                AbonosDescExtra.Quantidade := 1;
                AbonosDescExtra.Validate(AbonosDescExtra."Valor Unitário", PropFerias(Empregado));
                AbonosDescExtra.Insert(true);
            end;
        end else
            Error(Text0008);


        //***************************************
        //****Prop. Sub. Férias Ano Anterior*****
        //***************************************

        if DataTerminacao - TabEmpregado."Employment Date" > 365 then begin
            if CodRubSubFeriasAnoAnterior <> '' then begin
                AbonosDescExtra.Init;
                AbonosDescExtra."No. Empregado" := Empregado;
                AbonosDescExtra.Data := DataTerminacao;
                AbonosDescExtra.Validate(AbonosDescExtra."Cód. Rubrica", CodRubSubFeriasAnoAnterior);
                AbonosDescExtra.Quantidade := 1;
                AbonosDescExtra.Validate(AbonosDescExtra."Valor Unitário", ProporcionaisSFAnoAnterior(Empregado));
                AbonosDescExtra.Insert(true);
            end else
                Error(Text0011);

        end;
        //***************************************
        //**********Prop. Sub. Natal************
        //***************************************
        if CodRubPropSubNatal <> '' then begin
            AbonosDescExtra.Init;
            AbonosDescExtra."No. Empregado" := Empregado;
            AbonosDescExtra.Data := DataTerminacao;
            AbonosDescExtra.Validate(AbonosDescExtra."Cód. Rubrica", CodRubPropSubNatal);
            AbonosDescExtra.Quantidade := 1;
            AbonosDescExtra.Validate(AbonosDescExtra."Valor Unitário", ProporcionaisSN(Empregado));
            AbonosDescExtra.Insert(true);
        end else
            Error(Text0009);



        //***************************************
        //**********Admissão/Demissão************
        //***************************************
        if (CalcDate('30D-1D', DMY2Date(1, Date2DMY(DataTerminacao, 2), Date2DMY(DataTerminacao, 3))) - DataTerminacao) > 0 then begin

            //Se entrou no mesmo mes que saiu, tem de descontar esses dias
            if (Date2DMY(DataTerminacao, 2) = Date2DMY(TabEmpregado."Employment Date", 2)) and
               (Date2DMY(DataTerminacao, 3) = Date2DMY(TabEmpregado."Employment Date", 3)) then
                DiasNTrabalhados := TabEmpregado."Employment Date" -
                DMY2Date(1, Date2DMY(TabEmpregado."Employment Date", 2), Date2DMY(TabEmpregado."Employment Date", 3));

            TabRubSal.Reset;
            TabRubSal.SetRange(TabRubSal.Genero, TabRubSal.Genero::"Admissão-Demissão");
            if TabRubSal.Find('-') then begin
                AbonosDescExtra.Init;
                AbonosDescExtra."No. Empregado" := Empregado;
                AbonosDescExtra.Data := DataTerminacao;
                AbonosDescExtra.Validate(AbonosDescExtra."Cód. Rubrica", TabRubSal.Código);
                AbonosDescExtra.Quantidade := (CalcDate('30D-1D', DMY2Date(1, Date2DMY(DataTerminacao, 2), Date2DMY(DataTerminacao, 3))) -
                                              DataTerminacao) + DiasNTrabalhados;
                AbonosDescExtra.Validate(AbonosDescExtra."Valor Unitário", TabEmpregado."Valor Dia");
                AbonosDescExtra.Insert(true);
            end else
                Error(Text0010);
        end;


        CurrPage.Close;
    end;


    procedure ProporcionaisSF(CodigoEmp: Code[20]) Valor: Decimal
    var
        RubricaSalarial: Record "Rubrica Salarial";
        RubricaSalariaLinhas: Record "Rubrica Salarial Linhas";
        RubricaSalaEmpregado: Record "Rubrica Salarial Empregado";
        RubricaSalariaLinhas2: Record "Rubrica Salarial Linhas";
        RubricaSalaEmpregado2: Record "Rubrica Salarial Empregado";
        HistLinhaMovEmp: Record "Hist. Linhas Movs. Empregado";
        DataUltAcertoSF: Date;
        varPercentagem: Decimal;
        MesesTrabalhados: Decimal;
        DataInicioAno: Date;
        ValorJaPago: Decimal;
    begin

        RubricaSalarial.Reset;
        //aqui usamos a rubrica do SF e não a do proporcional, porque esta nao tem filhas, mas depois lancamos com o codigo de PSF
        RubricaSalarial.SetRange(RubricaSalarial.Código, CodRubSubFeriasAnoAnterior);
        if RubricaSalarial.Find('-') then begin
            RubricaSalariaLinhas.Reset;
            RubricaSalariaLinhas.SetRange(RubricaSalariaLinhas."Cód. Rubrica", RubricaSalarial.Código);
            if RubricaSalariaLinhas.Find('-') then begin
                repeat
                    RubricaSalaEmpregado.Reset;
                    RubricaSalaEmpregado.SetRange(RubricaSalaEmpregado."No. Empregado", CodigoEmp);
                    RubricaSalaEmpregado.SetRange(RubricaSalaEmpregado."Cód. Rúbrica Salarial", RubricaSalariaLinhas."Cód. Rubrica Filha");
                    RubricaSalaEmpregado.SetFilter(RubricaSalaEmpregado."Data Início", '<=%1', DataTerminacao);
                    RubricaSalaEmpregado.SetFilter(RubricaSalaEmpregado."Data Fim", '>=%1|=%2', DataTerminacao, 0D);
                    if RubricaSalaEmpregado.Find('-') then begin
                        repeat
                            RubricaSalariaLinhas2.Reset;
                            RubricaSalariaLinhas2.SetRange(RubricaSalariaLinhas2."Cód. Rubrica", RubricaSalariaLinhas."Cód. Rubrica Filha");
                            if RubricaSalariaLinhas2.Find('-') then begin
                                repeat
                                    RubricaSalaEmpregado2.Reset;
                                    RubricaSalaEmpregado2.SetRange(RubricaSalaEmpregado2."No. Empregado", CodigoEmp);
                                    RubricaSalaEmpregado2.SetRange(RubricaSalaEmpregado2."Cód. Rúbrica Salarial",
                                      RubricaSalariaLinhas2."Cód. Rubrica Filha");
                                    RubricaSalaEmpregado2.SetFilter(RubricaSalaEmpregado2."Data Início", '<=%1', DataTerminacao);
                                    RubricaSalaEmpregado2.SetFilter(RubricaSalaEmpregado2."Data Fim", '>=%1|=%2', DataTerminacao, 0D);
                                    if RubricaSalaEmpregado2.Find('-') then
                                        Valor := Round(Valor +
                                                  ((RubricaSalaEmpregado2."Valor Total" * RubricaSalariaLinhas2.Percentagem / 100)), 0.01);
                                until RubricaSalariaLinhas2.Next = 0;
                            end else
                                Valor := Round(Valor +
                                         ((RubricaSalaEmpregado."Valor Total" * RubricaSalariaLinhas.Percentagem / 100)), 0.01);

                        until RubricaSalaEmpregado.Next = 0;
                    end;
                until RubricaSalariaLinhas.Next = 0;
            end;
        end;


        DataInicioAno := DMY2Date(1, 1, Date2DMY(DataTerminacao, 3));

        //Meses de Trabalho
        //#002 - JTP - 2021.03.08
        if Date2DMY(TabEmpregado."Employment Date", 3) = Date2DMY(DataTerminacao, 3) then begin
            //IF (DATE2DMY(TabEmpregado."Employment Date",3) = DATE2DMY(DataTerminacao,3)) OR
            //  (DATE2DMY(DataTerminacao, 2) <> 12) THEN BEGIN
            //Normatica 2014.06.26 - Para entradas e saidas no mesmo ano
            //Os proporcionais Sub. Férias é o VB/22 * Numero de meses trabalho * 2 (dois dias por cada mês)
            MesesTrabalhados := (DataTerminacao - TabEmpregado."Employment Date" + 2) / 30;

            Valor := Valor / 22 * MesesTrabalhados * 2;

        end else begin
            //Normatica 2014.05.26 - Estes proporcionais são do presente ano, que se venceriam no ano seguinte
            //Os proporcionais é o VB/12 * Numero de meses completos de trabalho + dias
            MesesTrabalhados := Date2DMY(DataTerminacao, 2) - Date2DMY(DataInicioAno, 2) +
                                ((DataTerminacao - DMY2Date(1, Date2DMY(DataTerminacao, 2), Date2DMY(DataTerminacao, 3))) + 1) / 30;

            //#002 - JTP - 2021.03.08 - Start
            if (Date2DMY(DataTerminacao, 2) <> 12) then
                Valor := Valor / 22 * MesesTrabalhados * 2
            else
                //#002 - JTP - 2021.03.08 - Stop
                Valor := Valor / 12 * MesesTrabalhados;
        end;


        //Tirar o valor já pago
        Clear(ValorJaPago);
        RubricaSalarial.Reset;
        RubricaSalarial.SetRange(RubricaSalarial.NATREM, RubricaSalarial.NATREM::"Cód. Sub. Férias");
        if RubricaSalarial.FindSet then begin
            repeat
                HistLinhaMovEmp.Reset;
                HistLinhaMovEmp.SetRange(HistLinhaMovEmp."No. Empregado", CodigoEmp);
                HistLinhaMovEmp.SetRange(HistLinhaMovEmp."Cód. Rubrica", RubricaSalarial.Código);
                HistLinhaMovEmp.SetRange(HistLinhaMovEmp."Data Registo", DataInicioAno, DataTerminacao);
                if HistLinhaMovEmp.FindSet then begin
                    repeat
                        ValorJaPago := ValorJaPago + HistLinhaMovEmp.Valor;
                    until HistLinhaMovEmp.Next = 0;
                end;
            until RubricaSalarial.Next = 0;
        end;

        Valor := Valor - ValorJaPago;
        //Normatica 2014.05.26 - Fim

        exit(Valor);
    end;


    procedure ProporcionaisSN(CodigoEmp: Code[20]) Valor: Decimal
    var
        RubricaSalarial: Record "Rubrica Salarial";
        RubricaSalariaLinhas: Record "Rubrica Salarial Linhas";
        RubricaSalaEmpregado: Record "Rubrica Salarial Empregado";
        RubricaSalariaLinhas2: Record "Rubrica Salarial Linhas";
        RubricaSalaEmpregado2: Record "Rubrica Salarial Empregado";
        AuxRubricaSalaEmpregado: Record "Rubrica Salarial Empregado";
        HistLinhaMovEmp: Record "Hist. Linhas Movs. Empregado";
        DataUltAcertoSF: Date;
        varPercentagem: Decimal;
        ValorJaPago: Decimal;
        DiasTrabalhados: Decimal;
        DataInicioAno: Date;
        Flag: Boolean;
    begin
        //Sub. Natal referente ao ano corrente
        Flag := false;
        RubricaSalarial.Reset;
        RubricaSalarial.SetRange(RubricaSalarial.NATREM, RubricaSalarial.NATREM::"Cód. Sub. Natal");
        if RubricaSalarial.Find('-') then begin
            repeat
                AuxRubricaSalaEmpregado.Reset;
                AuxRubricaSalaEmpregado.SetRange(AuxRubricaSalaEmpregado."No. Empregado", CodigoEmp);
                AuxRubricaSalaEmpregado.SetRange(AuxRubricaSalaEmpregado."Cód. Rúbrica Salarial", RubricaSalarial.Código);
                if AuxRubricaSalaEmpregado.Find('-') then begin
                    RubricaSalariaLinhas.Reset;
                    RubricaSalariaLinhas.SetRange(RubricaSalariaLinhas."Cód. Rubrica", RubricaSalarial.Código);
                    if RubricaSalariaLinhas.Find('-') then begin
                        repeat
                            RubricaSalaEmpregado.Reset;
                            RubricaSalaEmpregado.SetRange(RubricaSalaEmpregado."No. Empregado", CodigoEmp);
                            RubricaSalaEmpregado.SetRange(RubricaSalaEmpregado."Cód. Rúbrica Salarial", RubricaSalariaLinhas."Cód. Rubrica Filha");
                            RubricaSalaEmpregado.SetFilter(RubricaSalaEmpregado."Data Início", '<=%1', DataTerminacao);
                            RubricaSalaEmpregado.SetFilter(RubricaSalaEmpregado."Data Fim", '>=%1|=%2', DataTerminacao, 0D);
                            if RubricaSalaEmpregado.Find('-') then begin
                                repeat
                                    RubricaSalariaLinhas2.Reset;
                                    RubricaSalariaLinhas2.SetRange(RubricaSalariaLinhas2."Cód. Rubrica", RubricaSalariaLinhas."Cód. Rubrica Filha");
                                    if RubricaSalariaLinhas2.Find('-') then begin
                                        repeat
                                            RubricaSalaEmpregado2.Reset;
                                            RubricaSalaEmpregado2.SetRange(RubricaSalaEmpregado2."No. Empregado", CodigoEmp);
                                            RubricaSalaEmpregado2.SetRange(RubricaSalaEmpregado2."Cód. Rúbrica Salarial",
                                              RubricaSalariaLinhas2."Cód. Rubrica Filha");
                                            RubricaSalaEmpregado2.SetFilter(RubricaSalaEmpregado2."Data Início", '<=%1', DataTerminacao);
                                            RubricaSalaEmpregado2.SetFilter(RubricaSalaEmpregado2."Data Fim", '>=%1|=%2', DataTerminacao, 0D);
                                            if RubricaSalaEmpregado2.Find('-') then begin
                                                Valor := Round(Valor + RubricaSalaEmpregado2."Valor Total", 0.01);
                                                Flag := true;
                                            end;
                                        until RubricaSalariaLinhas2.Next = 0;
                                    end else begin
                                        Valor := Round(Valor + RubricaSalaEmpregado."Valor Total", 0.01);
                                        Flag := true;
                                    end;
                                until RubricaSalaEmpregado.Next = 0;
                            end;
                        until RubricaSalariaLinhas.Next = 0;
                    end;
                end;
            until (RubricaSalarial.Next = 0) or (Flag = true);
        end;

        //Se o empregado foi admitido no mesmo ano em que sai então ainda n recebeu sub. Natal e terá de receber desde a data entrada até à
        //data de terminação
        //Se a data da admissão é anterior ao ano corrente então terá de receber desde o inicio do ano até á data terminação



        DataInicioAno := DMY2Date(1, 1, Date2DMY(DataTerminacao, 3));

        //#002 - JTP - 2021.03.08 - Start
        /*
          //Meses de Trabalho
          IF  DATE2DMY(TabEmpregado."Employment Date",3) = DATE2DMY(DataTerminacao,3) THEN
            //Normatica 2014.06.26 - Os proporcionais é o VB/12 * Numero de meses de trabalho - valor já recebido
            //Mesestrabalhados := (DataTerminacao - TabEmpregado."Employment Date" + 2)/30
            //Normatica 2014.11.05 - Os proporcionais é o VB/12 * Numero de meses de trabalho - valor já recebido
            //não posso fazer as contas aos dias e dividir por 30 por causa dos meses de 30 e 31 dias e 28
            //Mesestrabalhados := DATE2DMY(DataTerminacao,2) - DATE2DMY(TabEmpregado."Employment Date",2)
        
            Mesestrabalhados := ROUND(DATE2DMY(DataTerminacao,2) - DATE2DMY(TabEmpregado."Employment Date",2)  +
                                             (30 - DATE2DMY(TabEmpregado."Employment Date",1)+1) /30,0.01)
          ELSE
            //Normatica 2014.05.26 - Os proporcionais é o VB/12 * Numero de meses completos de trabalho + dias - valor já recebido
            Mesestrabalhados := DATE2DMY(DataTerminacao,2) - DATE2DMY(DataInicioAno,2) +
                                ((DataTerminacao - DMY2DATE(1,DATE2DMY(DataTerminacao,2),DATE2DMY(DataTerminacao,3)))+1) /30;
        
          Valor  := Valor / 12 * Mesestrabalhados;
        */
        DiasTrabalhados := DataTerminacao - DataInicioAno + 1;

        Valor := Valor / 365 * DiasTrabalhados;
        //#002 - JTP - 2021.03.08 - Start


        //Tirar o valor já pago
        Clear(ValorJaPago);
        RubricaSalarial.Reset;
        RubricaSalarial.SetRange(RubricaSalarial.NATREM, RubricaSalarial.NATREM::"Cód. Sub. Natal");
        if RubricaSalarial.Find('-') then begin
            repeat
                HistLinhaMovEmp.Reset;
                HistLinhaMovEmp.SetRange(HistLinhaMovEmp."No. Empregado", CodigoEmp);
                HistLinhaMovEmp.SetRange(HistLinhaMovEmp."Cód. Rubrica", RubricaSalarial.Código);
                HistLinhaMovEmp.SetRange(HistLinhaMovEmp."Data Registo", DataInicioAno, DataTerminacao);
                if HistLinhaMovEmp.FindSet then begin
                    repeat
                        ValorJaPago := ValorJaPago + HistLinhaMovEmp.Valor;
                    until HistLinhaMovEmp.Next = 0;
                end;
            until RubricaSalarial.Next = 0;
        end;

        Valor := Valor - ValorJaPago;
        //Normatica 2014.05.26 - Fim



        exit(Valor);

    end;


    procedure ProporcionaisSFAnoAnterior(CodigoEmp: Code[20]) Valor: Decimal
    var
        RubricaSalarial: Record "Rubrica Salarial";
        RubricaSalariaLinhas: Record "Rubrica Salarial Linhas";
        RubricaSalaEmpregado: Record "Rubrica Salarial Empregado";
        RubricaSalariaLinhas2: Record "Rubrica Salarial Linhas";
        RubricaSalaEmpregado2: Record "Rubrica Salarial Empregado";
        HistLinhaMovEmp: Record "Hist. Linhas Movs. Empregado";
        DataUltAcertoSF: Date;
        varPercentagem: Decimal;
        ValorJaPago: Decimal;
        DataInicioAno: Date;
    begin
        RubricaSalarial.Reset;
        RubricaSalarial.SetRange(RubricaSalarial.Código, CodRubSubFeriasAnoAnterior);
        if RubricaSalarial.Find('-') then begin
            RubricaSalariaLinhas.Reset;
            RubricaSalariaLinhas.SetRange(RubricaSalariaLinhas."Cód. Rubrica", RubricaSalarial.Código);
            if RubricaSalariaLinhas.Find('-') then begin
                repeat
                    RubricaSalaEmpregado.Reset;
                    RubricaSalaEmpregado.SetRange(RubricaSalaEmpregado."No. Empregado", CodigoEmp);
                    RubricaSalaEmpregado.SetRange(RubricaSalaEmpregado."Cód. Rúbrica Salarial", RubricaSalariaLinhas."Cód. Rubrica Filha");
                    RubricaSalaEmpregado.SetFilter(RubricaSalaEmpregado."Data Início", '<=%1', DataTerminacao);
                    RubricaSalaEmpregado.SetFilter(RubricaSalaEmpregado."Data Fim", '>=%1|=%2', DataTerminacao, 0D);
                    if RubricaSalaEmpregado.Find('-') then begin
                        repeat
                            RubricaSalariaLinhas2.Reset;
                            RubricaSalariaLinhas2.SetRange(RubricaSalariaLinhas2."Cód. Rubrica", RubricaSalariaLinhas."Cód. Rubrica Filha");
                            if RubricaSalariaLinhas2.Find('-') then begin
                                repeat
                                    RubricaSalaEmpregado2.Reset;
                                    RubricaSalaEmpregado2.SetRange(RubricaSalaEmpregado2."No. Empregado", CodigoEmp);
                                    RubricaSalaEmpregado2.SetRange(RubricaSalaEmpregado2."Cód. Rúbrica Salarial",
                                      RubricaSalariaLinhas2."Cód. Rubrica Filha");
                                    RubricaSalaEmpregado2.SetFilter(RubricaSalaEmpregado2."Data Início", '<=%1', DataTerminacao);
                                    RubricaSalaEmpregado2.SetFilter(RubricaSalaEmpregado2."Data Fim", '>=%1|=%2', DataTerminacao, 0D);
                                    if RubricaSalaEmpregado2.Find('-') then
                                        Valor := Round(Valor +
                                                  ((RubricaSalaEmpregado2."Valor Total" * RubricaSalariaLinhas2.Percentagem / 100)), 0.01);
                                until RubricaSalariaLinhas2.Next = 0;
                            end else
                                Valor := Round(Valor +
                                         ((RubricaSalaEmpregado."Valor Total" * RubricaSalariaLinhas.Percentagem / 100)), 0.01);

                        until RubricaSalaEmpregado.Next = 0;
                    end;
                until RubricaSalariaLinhas.Next = 0;
            end;
        end;

        //Normatica 2014.05.26 - O sub férias ano anterior é o que ele tem direito num ano int
        //                       (menos) - o que já recebeu este ano (pois pode estar em regime de duodécimos)

        DataInicioAno := DMY2Date(1, 1, Date2DMY(DataTerminacao, 3));

        //Tirar o valor já pago
        Clear(ValorJaPago);
        RubricaSalarial.Reset;
        RubricaSalarial.SetRange(RubricaSalarial.NATREM, RubricaSalarial.NATREM::"Cód. Sub. Férias");
        if RubricaSalarial.Find('-') then begin
            repeat
                HistLinhaMovEmp.Reset;
                HistLinhaMovEmp.SetRange(HistLinhaMovEmp."No. Empregado", CodigoEmp);
                HistLinhaMovEmp.SetRange(HistLinhaMovEmp."Cód. Rubrica", RubricaSalarial.Código);
                HistLinhaMovEmp.SetRange(HistLinhaMovEmp."Data Registo", DataInicioAno, DataTerminacao);
                if HistLinhaMovEmp.FindSet then begin
                    repeat
                        ValorJaPago := ValorJaPago + HistLinhaMovEmp.Valor;
                    until HistLinhaMovEmp.Next = 0;
                end;
            until RubricaSalarial.Next = 0;
        end;

        Valor := Valor - ValorJaPago;
        //Normatica 2014.05.26 - Fim



        exit(Valor);
    end;


    procedure PropFerias(CodigoEmp: Code[20]) Valor: Decimal
    var
        RubricaSalarial: Record "Rubrica Salarial";
        RubricaSalariaLinhas: Record "Rubrica Salarial Linhas";
        RubricaSalaEmpregado: Record "Rubrica Salarial Empregado";
        RubricaSalariaLinhas2: Record "Rubrica Salarial Linhas";
        RubricaSalaEmpregado2: Record "Rubrica Salarial Empregado";
        HistLinhaMovEmp: Record "Hist. Linhas Movs. Empregado";
        DataUltAcertoSF: Date;
        varPercentagem: Decimal;
        MesesTrabalhados: Decimal;
        DataInicioAno: Date;
        ValorJaPago: Decimal;
    begin

        RubricaSalarial.Reset;
        //aqui usamos a rubrica do SF e não a do proporcional, porque esta nao tem filhas, mas depois lancamos com o codigo de PSF
        RubricaSalarial.SetRange(RubricaSalarial.Código, CodRubSubFeriasAnoAnterior);
        if RubricaSalarial.Find('-') then begin
            RubricaSalariaLinhas.Reset;
            RubricaSalariaLinhas.SetRange(RubricaSalariaLinhas."Cód. Rubrica", RubricaSalarial.Código);
            if RubricaSalariaLinhas.Find('-') then begin
                repeat
                    RubricaSalaEmpregado.Reset;
                    RubricaSalaEmpregado.SetRange(RubricaSalaEmpregado."No. Empregado", CodigoEmp);
                    RubricaSalaEmpregado.SetRange(RubricaSalaEmpregado."Cód. Rúbrica Salarial", RubricaSalariaLinhas."Cód. Rubrica Filha");
                    RubricaSalaEmpregado.SetFilter(RubricaSalaEmpregado."Data Início", '<=%1', DataTerminacao);
                    RubricaSalaEmpregado.SetFilter(RubricaSalaEmpregado."Data Fim", '>=%1|=%2', DataTerminacao, 0D);
                    if RubricaSalaEmpregado.Find('-') then begin
                        repeat
                            RubricaSalariaLinhas2.Reset;
                            RubricaSalariaLinhas2.SetRange(RubricaSalariaLinhas2."Cód. Rubrica", RubricaSalariaLinhas."Cód. Rubrica Filha");
                            if RubricaSalariaLinhas2.Find('-') then begin
                                repeat
                                    RubricaSalaEmpregado2.Reset;
                                    RubricaSalaEmpregado2.SetRange(RubricaSalaEmpregado2."No. Empregado", CodigoEmp);
                                    RubricaSalaEmpregado2.SetRange(RubricaSalaEmpregado2."Cód. Rúbrica Salarial",
                                      RubricaSalariaLinhas2."Cód. Rubrica Filha");
                                    RubricaSalaEmpregado2.SetFilter(RubricaSalaEmpregado2."Data Início", '<=%1', DataTerminacao);
                                    RubricaSalaEmpregado2.SetFilter(RubricaSalaEmpregado2."Data Fim", '>=%1|=%2', DataTerminacao, 0D);
                                    if RubricaSalaEmpregado2.Find('-') then
                                        Valor := Round(Valor +
                                                  ((RubricaSalaEmpregado2."Valor Total" * RubricaSalariaLinhas2.Percentagem / 100)), 0.01);
                                until RubricaSalariaLinhas2.Next = 0;
                            end else
                                Valor := Round(Valor +
                                         ((RubricaSalaEmpregado."Valor Total" * RubricaSalariaLinhas.Percentagem / 100)), 0.01);

                        until RubricaSalaEmpregado.Next = 0;
                    end;
                until RubricaSalariaLinhas.Next = 0;
            end;
        end;


        DataInicioAno := DMY2Date(1, 1, Date2DMY(DataTerminacao, 3));

        //Meses de Trabalho
        if Date2DMY(TabEmpregado."Employment Date", 3) = Date2DMY(DataTerminacao, 3) then begin
            //Normatica 2014.06.26 - Tem de ver se já gozou as férias deste ano
            Valor := Valor / 22 * FeriasAnoCorrente;

        end else begin
            //Normatica 2014.05.26 - Estes proporcionais são do presente ano, que se venceriam no ano seguinte
            //Os proporcionais é o VB/12 * Numero de meses completos de trabalho + dias
            MesesTrabalhados := Date2DMY(DataTerminacao, 2) - Date2DMY(DataInicioAno, 2) +
                                ((DataTerminacao - DMY2Date(1, Date2DMY(DataTerminacao, 2), Date2DMY(DataTerminacao, 3))) + 1) / 30;

            Valor := Valor / 12 * MesesTrabalhados;
        end;


        //Normatica 2014.05.26 - Fim

        exit(Valor);
    end;

    local procedure CodTerminacaoOnAfterInput(var Text: Text[1024])
    begin
        TabRU.Reset;
        TabRU.SetRange(TabRU.Tipo, TabRU.Tipo::MotSai);
        TabRU.SetRange(TabRU.Código, Text);
        if TabRU.FindFirst then begin
            DescTerminacao := TabRU.Descrição;
            MotivoTerminacao := TabRU."Mot. Terminação";
        end;

        if (MotivoTerminacao = MotivoTerminacao::"Inic Trab período exp.") or
           (MotivoTerminacao = MotivoTerminacao::"Inic Emp período exp.") or
           (MotivoTerminacao = MotivoTerminacao::Desp) then begin

            PeriodoExpVisible := true;
            PeriodoExperimental := false;

            TabContratoEmp.Reset;
            TabContratoEmp.SetRange(TabContratoEmp."Cód. Empregado", Empregado);
            TabContratoEmp.SetFilter(TabContratoEmp."Data Inicio Contrato", '<%1', DataTerminacao);
            TabContratoEmp.SetFilter(TabContratoEmp."Data Fim Contrato", '>=%1|%2', DataTerminacao, 0D);
            if TabContratoEmp.Find('-') then begin
                if TabContratoEmp."Tipo Contrato" = TabContratoEmp."Tipo Contrato"::"Sem Termo" then begin
                    if DataTerminacao - TabEmpregado."Employment Date" < 180 then
                        PeriodoExperimental := true;
                end else begin
                    if DataTerminacao - TabEmpregado."Employment Date" < 30 then
                        PeriodoExperimental := true;
                end;
            end;

        end else begin
            PeriodoExpVisible := false;
            PeriodoExperimental := false;
        end;
    end;

    local procedure EmpregadoOnFormat()
    begin
        if TabEmpregado.Get(Empregado) then begin
            NomeEmp := TabEmpregado.Name;
        end;
    end;


    procedure MotivoOnFormat()
    begin
        TabRU.Reset;
        TabRU.SetRange(TabRU.Tipo, TabRU.Tipo::MotSai);
        TabRU.SetFilter(Código, CodTerminacao);
        if TabRU.FindFirst then begin
            DescTerminacao := TabRU.Descrição;
            MotivoTerminacao := TabRU."Mot. Terminação";
        end;



        if (MotivoTerminacao = MotivoTerminacao::"Inic Trab período exp.") or
           (MotivoTerminacao = MotivoTerminacao::"Inic Emp período exp.") or
           (MotivoTerminacao = MotivoTerminacao::Desp) then begin

            PeriodoExpVisible := true;
            PeriodoExperimental := false;

            TabContratoEmp.Reset;
            TabContratoEmp.SetRange(TabContratoEmp."Cód. Empregado", Empregado);
            TabContratoEmp.SetFilter(TabContratoEmp."Data Inicio Contrato", '<%1', DataTerminacao);
            TabContratoEmp.SetFilter(TabContratoEmp."Data Fim Contrato", '>=%1|%2', DataTerminacao, 0D);
            if TabContratoEmp.Find('-') then begin
                if TabContratoEmp."Tipo Contrato" = TabContratoEmp."Tipo Contrato"::"Sem Termo" then begin
                    if DataTerminacao - TabEmpregado."Employment Date" < 180 then
                        PeriodoExperimental := true;
                end else begin
                    if DataTerminacao - TabEmpregado."Employment Date" < 30 then
                        PeriodoExperimental := true;
                end;
            end;

        end else begin
            PeriodoExpVisible := false;
            PeriodoExperimental := false;
        end;
    end;
}

