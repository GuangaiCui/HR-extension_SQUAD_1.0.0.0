#pragma implicitwith disable
page 53117 "Simulador de Remunerações"
{
    Caption = 'Remuneration Simulator';
    /**/
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ShowFilter = false;
    UsageCategory = Tasks;
    ApplicationArea = HumanResourcesAppArea;
    SaveValues = true;
    Editable = true;
    /**/
    PageType = Document;
    DelayedInsert = true;
    SourceTable = Employee;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group("Dados Contribuinte")
            {
                Caption = 'Dados Contribuinte';
                field(TipoContribuinte; TipoContribuinte)
                {


                    Caption = 'Tipo Contribuinte';
                    OptionCaption = ' ,Conta de Outrém,,Pensionista';
                    //ShowMandatory = true;
                    //StyleExpr = TRUE;

                    trigger OnValidate()
                    begin
                        TipoContribuinte := TipoContribuinte;
                    end;
                }
                field(LocalObtenRend; LocalObtenRend)
                {


                    Caption = 'Local Obtenção Rendimento';
                    OptionCaption = ' ,Continente,Região da Madeira,Região dos Açores';
                    ShowMandatory = true;
                    StyleExpr = TRUE;

                    trigger OnValidate()
                    begin
                        TipoContribuinte := TipoContribuinte;
                    end;
                }
                field(EstadoCivil; EstadoCivil)
                {


                    Caption = 'Estado Civil';
                    ShowMandatory = true;
                }
                field(TitularRendimentos; TitularRendimentos)
                {


                    Caption = 'Titular Rendimentos';
                    ShowMandatory = true;
                }
                field(Deficiente; Rec.Deficiente)
                {


                    Caption = 'Deficiente';
                }
                field(ConjDeficiente; ConjDeficiente)
                {


                    Caption = 'Cônjuge deficiente';
                }
                field(NDependentes; NDependentes)
                {


                    Caption = 'Nº Dependentes';
                    ShowMandatory = true;
                }
                field(l_TaxaIRS; l_TaxaIRS)
                {


                    Caption = 'Taxa IRS';
                    Editable = false;
                }
                field(RegSS; RegSS)
                {


                    Caption = 'Regime Seg. Social';
                    ShowMandatory = true;

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        if PAGE.RunModal(PAGE::"Regime Seg. Social", TabRegSS) = ACTION::LookupOK then begin
                            RegSS := TabRegSS.Código;
                            TaxaSS := TabRegSS."Taxa Contributiva Empregado";
                        end;
                    end;
                }
                field(TaxaSS; TaxaSS)
                {


                    Caption = 'Taxa Seg. Social';
                    Editable = false;
                }
                field(TaxaCGA; TaxaCGA)
                {


                    Caption = 'Taxa CGA';
                }
            }
            group("Cálculo do vencimento líquido a partir do bruto")
            {
                Caption = 'Cálculo do vencimento líquido a partir do bruto';
                group("Remuneração Bruta")
                {
                    Caption = 'Remuneração Bruta';
                    field(L_RemuneracaoBruta1; L_RemuneracaoBruta1)
                    {


                        Caption = 'Valor';
                        ShowMandatory = true;
                        Style = Strong;
                        StyleExpr = TRUE;
                    }
                    field("usaIRS[1]"; usaIRS[1])
                    {


                        Caption = 'Incide IRS';
                    }
                    field("usaSS[1]"; usaSS[1])
                    {


                        Caption = 'Incide Seg. Social';
                    }
                    field("usaCGA[1]"; usaCGA[1])
                    {


                        Caption = 'Incide CGA';
                    }
                }
                group("Outra Remuneração")
                {
                    Caption = 'Outra Remuneração';
                    field(L_RemuneracaoBruta2; L_RemuneracaoBruta2)
                    {


                        Caption = 'Valor';
                    }
                    field("usaIRS[2]"; usaIRS[2])
                    {


                        Caption = 'Incide IRS';
                    }
                    field("usaSS[2]"; usaSS[2])
                    {


                        Caption = 'Incide Seg. Social';
                    }
                    field("usaCGA[2]"; usaCGA[2])
                    {


                        Caption = 'Incide CGA';
                    }
                }
                group(Control1000000002)
                {
                    Caption = 'Outra Remuneração';
                    field(L_RemuneracaoBruta3; L_RemuneracaoBruta3)
                    {


                        Caption = 'Valor';
                    }
                    field("usaIRS[3]"; usaIRS[3])
                    {


                        Caption = 'Incide IRS';
                    }
                    field("usaSS[3]"; usaSS[3])
                    {


                        Caption = 'Incide Seg. Social';
                    }
                    field("usaCGA[3]"; usaCGA[3])
                    {


                        Caption = 'Incide CGA';
                    }
                }
                group(Control15)
                {
                    Caption = 'Valores Calculados';
                    //ShowCaption = false;
                    //cuegroup(Control3)
                    group(Control3)
                    {

                        ShowCaption = false;
                        field("L_RemuneracaoBruta1 + L_RemuneracaoBruta2 + L_RemuneracaoBruta3"; L_RemuneracaoBruta1 + L_RemuneracaoBruta2 + L_RemuneracaoBruta3)
                        {


                            Caption = 'Total Remunerações';

                            Editable = false;
                            Enabled = false;
                            Style = Favorable;
                            StyleExpr = TRUE;

                        }
                        field(DescontoIRS; DescontoIRS)
                        {


                            Caption = 'Desconto IRS';
                            Editable = false;
                            Style = Unfavorable;
                            StyleExpr = TRUE;
                        }
                        field(DescontoSS; DescontoSS)
                        {


                            Caption = 'Desconto Seg. Social';
                            Editable = false;
                            Style = Unfavorable;
                            StyleExpr = TRUE;
                        }
                        field(DEscontoCGA; DEscontoCGA)
                        {


                            Caption = 'Desconto CGA';
                            Editable = false;
                            Style = Unfavorable;
                            StyleExpr = TRUE;
                        }
                        field(L_VencimentoLiquido; L_VencimentoLiquido)
                        {


                            Caption = 'Vencimento Líquido';
                            Editable = false;
                            Enabled = false;
                            Style = Favorable;
                            StyleExpr = TRUE;
                        }
                    }
                }
            }
            group("Cálculo do vencimento bruto a partir do líquido")
            {
                Caption = 'Cálculo do vencimento bruto a partir do líquido';
                group(Control8)
                {
                    ShowCaption = false;
                    field(B_VencimentoLiquido; B_VencimentoLiquido)
                    {


                        Caption = 'Vencimento Líquido';
                        ShowMandatory = true;
                        Style = Strong;
                        StyleExpr = TRUE;
                    }
                    field("usaIRS[4]"; usaIRS[4])
                    {


                        Caption = 'Incide IRS';
                        Style = Unfavorable;
                        StyleExpr = TRUE;
                    }
                    field("usaSS[4]"; usaSS[4])
                    {


                        Caption = 'Incide Seg. Social';
                        Style = Unfavorable;
                        StyleExpr = TRUE;
                    }
                    field("usaCGA[4]"; usaCGA[4])
                    {


                        Caption = 'Incide CGA';
                        Style = Unfavorable;
                        StyleExpr = TRUE;
                    }
                }
                group(Control14)
                {
                    Caption = 'Valores Calculados';
                    //ShowCaption = false;
                    //cuegroup(Control13)
                    group(Control13)
                    {
                        ShowCaption = false;
                        field(B_RemuneracaoBruta1; B_RemuneracaoBruta1)
                        {


                            Caption = 'Remuneração Bruta';
                            Editable = false;
                            Style = Favorable;
                            StyleExpr = TRUE;
                        }
                        field(TaxIRS1; TaxIRS1)
                        {


                            BlankZero = true;
                            Caption = 'Incidência IRS';
                            Editable = false;
                            Style = Unfavorable;
                            StyleExpr = TRUE;
                        }
                        field(B_RemuneracaoBruta2; B_RemuneracaoBruta2)
                        {


                            Caption = 'Outra Remuneração';
                            Editable = false;
                            Style = Favorable;
                            StyleExpr = TRUE;
                        }
                        field(TaxIRS2; TaxIRS2)
                        {


                            BlankZero = true;
                            Caption = 'Incidência IRS';
                            Editable = false;
                            Style = Unfavorable;
                            StyleExpr = TRUE;
                        }
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Calcular1)
            {
                Caption = 'Calcular';
                action("Calcular Líquido")
                {


                    Caption = 'Calcular Líquido';
                    Image = CalculateCost;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Calcular;
                        CalcularLiq;
                        CurrPage.Update();
                    end;
                }
                action("Calcular Bruto")
                {


                    Caption = 'Calcular Bruto';
                    Image = CalculateBalanceAccount;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Calcular;
                        CalcularBru;
                    end;
                }
            }
        }
    }

    var
        L_RemuneracaoBruta1: Decimal;
        L_RemuneracaoBruta2: Decimal;
        L_RemuneracaoBruta3: Decimal;
        L_VencimentoLiquido: Decimal;
        B_RemuneracaoBruta1: Decimal;
        B_RemuneracaoBruta2: Decimal;
        B_RemuneracaoBruta3: Decimal;
        B_VencimentoLiquido: Decimal;
        TipoContribuinte: Option " ","Conta de Outrem",,Pensionista;
        LocalObtenRend: Option " ",C,RM,RA;
        EstadoCivil: Option Solteiro,Casado,Divorciado,"Viúvo",Outro;
        TitularRendimentos: Option " ","Único Titular","Dois Titulares";
        Deficiente: Option "Não",Sim,"Forças Armadas";
        ConjDeficiente: Boolean;
        NDependentes: Integer;
        TabRegSS: Record "Regime Seg. Social";
        RegSS: Code[10];
        TempEmpregado: Record Employee temporary;
        FuncoesRH: Codeunit "Funções RH";
        l_TaxaIRS: Decimal;
        b_TaxaIRS: Decimal;
        TaxaSS: Decimal;
        TaxaCGA: Decimal;
        varAno: Integer;
        TabelaIRS: Record "Tabela IRS";
        TabelaIRS2: Record "Tabela IRS";
        TabelaIRS3: Record "Tabela IRS";
        Tabela: Integer;
        Flag: Integer;
        Text0001: Label 'Tem de preencher o campo Local Obtenção Rendimentos.';
        usaIRS: array[4] of Boolean;
        usaSS: array[4] of Boolean;
        usaCGA: array[4] of Boolean;
        ValorSujeitoIRS: Decimal;
        ValorSujeitoSS: Decimal;
        ValorSujeitoCGA: Decimal;
        ValorTotal: Decimal;
        Text0002: Label 'Tem de preencher o campo Titular Rendimentos.';
        Text0003: Label 'Tem de preencher o campo Regime Seg. Social.';
        Text0004: Label 'Tem de preencher o campo Taxa CGA.';
        Text0005: Label 'Tem de preencher o campo Remuneração Bruta 1 no separador Cálculo Rem. Líquida.';
        Text0006: Label 'Tem de preencher o campo Vencimento Líquido no separador Cálculo Rem. Bruta.';
        i: Integer;
        Text0007: Label 'Tem de preencher o campo Tipo Contribuinte.';
        TaxaIRSAux: Decimal;
        DescontoIRS: Decimal;
        DescontoSS: Decimal;
        DEscontoCGA: Decimal;
        TaxIRS1: Decimal;
        TaxIRS2: Decimal;
        TaxIRS3: Decimal;
        Text19046795: Label 'Resultados Possíveis';
        Text19012696: Label 'IRS';
        Text19080001: Label 'IRS';
        Text19038728: Label 'Seg. Social';
        Text19080002: Label 'Seg. Social';


    procedure Calcular()
    begin

        if LocalObtenRend = 0 then Error(Text0001);
        if TitularRendimentos = 0 then Error(Text0002);
        if TipoContribuinte = 0 then Error(Text0007);


        TempEmpregado.DeleteAll;

        TempEmpregado.Init;
        TempEmpregado."Tipo Contribuinte" := TipoContribuinte;
        if L_RemuneracaoBruta1 <> 0 then
            TempEmpregado."Valor Vencimento Base" := L_RemuneracaoBruta1
        else
            TempEmpregado."Valor Vencimento Base" := B_RemuneracaoBruta1;

        TempEmpregado."Local Obtenção Rendimento" := LocalObtenRend;
        TempEmpregado.Deficiente := Rec.Deficiente;
        TempEmpregado."Estado Civil" := EstadoCivil;
        TempEmpregado."Titular Rendimentos" := TitularRendimentos;
        TempEmpregado."Conjuge Deficiente" := ConjDeficiente;
        TempEmpregado."No. Dependentes" := NDependentes;
        TempEmpregado.Insert;

        Clear(ValorSujeitoIRS);
        Clear(ValorSujeitoSS);
        Clear(ValorSujeitoCGA);
    end;


    procedure CalcularLiq()
    begin

        //*******Calculo do Liquido*************************************
        if L_RemuneracaoBruta1 = 0 then Error(Text0005);

        TempEmpregado.Reset;
        if TempEmpregado.Find('-') then
            ValorTotal := L_RemuneracaoBruta1 + L_RemuneracaoBruta2 + L_RemuneracaoBruta3;

        if usaIRS[1] then ValorSujeitoIRS := ValorSujeitoIRS + L_RemuneracaoBruta1;
        if usaIRS[2] then ValorSujeitoIRS := ValorSujeitoIRS + L_RemuneracaoBruta2;
        if usaIRS[3] then ValorSujeitoIRS := ValorSujeitoIRS + L_RemuneracaoBruta3;

        if usaSS[1] then ValorSujeitoSS := ValorSujeitoSS + L_RemuneracaoBruta1;
        if usaSS[2] then ValorSujeitoSS := ValorSujeitoSS + L_RemuneracaoBruta2;
        if usaSS[3] then ValorSujeitoSS := ValorSujeitoSS + L_RemuneracaoBruta3;
        if ValorSujeitoSS <> 0 then
            if RegSS = '' then Error(Text0003);

        if usaCGA[1] then ValorSujeitoCGA := ValorSujeitoCGA + L_RemuneracaoBruta1;
        if usaCGA[2] then ValorSujeitoCGA := ValorSujeitoCGA + L_RemuneracaoBruta2;
        if usaCGA[3] then ValorSujeitoCGA := ValorSujeitoCGA + L_RemuneracaoBruta3;
        if ValorSujeitoCGA <> 0 then
            if TaxaCGA = 0 then Error(Text0004);

        l_TaxaIRS := FuncoesRH.CalcularTaxaIRS(ValorSujeitoIRS, TempEmpregado, Date2DMY(WorkDate, 3));
        L_VencimentoLiquido := ValorTotal - (ValorSujeitoIRS * l_TaxaIRS / 100) - (ValorSujeitoSS * TaxaSS / 100)
                             - (ValorSujeitoCGA * TaxaCGA / 100);


        DescontoIRS := ValorSujeitoIRS * l_TaxaIRS / 100;
        DescontoSS := ValorSujeitoSS * TaxaSS / 100;
        DEscontoCGA := ValorSujeitoCGA * TaxaCGA / 100;
    end;


    procedure CalcularBru()
    begin

        //*******Calculo do Bruto*************************************
        Clear(B_RemuneracaoBruta1);
        Clear(B_RemuneracaoBruta2);
        Clear(B_RemuneracaoBruta3);
        Clear(TaxIRS1);
        Clear(TaxIRS2);
        Clear(TaxIRS3);


        if B_VencimentoLiquido = 0 then Error(Text0006);

        TempEmpregado.Reset;
        if TempEmpregado.Find('-') then begin

            varAno := Date2DMY(WorkDate, 3);
            Tabela := SaberTabelaIRS(TempEmpregado, varAno);

            Flag := 0;

            TabelaIRS.Reset;
            TabelaIRS.SetRange(TabelaIRS.Ano, varAno);
            if not TabelaIRS.Find('-') then begin
                varAno := varAno - 1;
                TabelaIRS.SetRange(TabelaIRS.Ano, varAno);
            end;
            TabelaIRS.SetRange(TabelaIRS.Tabela, Tabela);
            TabelaIRS.SetRange(TabelaIRS.Região, TempEmpregado."Local Obtenção Rendimento" - 1);
            if TabelaIRS.Find('+') then begin
                repeat

                    if (Tabela <> 6) and (Tabela <> 7) and (Tabela <> 8) then begin
                        if TempEmpregado."No. Dependentes" = 0 then b_TaxaIRS := TabelaIRS."TD 0 Dependentes";
                        if TempEmpregado."No. Dependentes" = 1 then b_TaxaIRS := TabelaIRS."TD 1 Dependentes";
                        if TempEmpregado."No. Dependentes" = 2 then b_TaxaIRS := TabelaIRS."TD 2 Dependentes";
                        if TempEmpregado."No. Dependentes" = 3 then b_TaxaIRS := TabelaIRS."TD 3 Dependentes";
                        if TempEmpregado."No. Dependentes" = 4 then b_TaxaIRS := TabelaIRS."TD 4 Dependentes";
                        if TempEmpregado."No. Dependentes" >= 5 then b_TaxaIRS := TabelaIRS."TD 5ou Mais Dependentes";
                    end else begin
                        if (TempEmpregado."Estado Civil" = 1) and (TempEmpregado."Titular Rendimentos" = 2) then
                            b_TaxaIRS := TabelaIRS.PenCas2Tit;
                        if (TempEmpregado."Estado Civil" <> 1) then
                            b_TaxaIRS := TabelaIRS.PenNCas;
                        if (TempEmpregado."Estado Civil" = 1) and (TempEmpregado."Titular Rendimentos" = 1) then
                            b_TaxaIRS := TabelaIRS.PenCas1Tit;
                    end;


                    if usaIRS[4] = false then
                        b_TaxaIRS := 0;

                    if usaSS[4] = false then begin
                        TaxaSS := 0;
                        RegSS := '';
                    end else
                        if RegSS = '' then Error(Text0003);

                    if usaCGA[4] = false then
                        TaxaCGA := 0
                    else
                        if TaxaCGA = 0 then Error(Text0004);


                    B_RemuneracaoBruta1 := B_VencimentoLiquido / (1 - (b_TaxaIRS / 100) - (TaxaSS / 100) - (TaxaCGA / 100));

                    TabelaIRS2.Reset;
                    TabelaIRS2.Copy(TabelaIRS);
                    TabelaIRS2.Next(-1);
                    //MESSAGE('%1-%2-%3-%4',B_RemuneracaoBruta1,TabelaIRS.Valor,TabelaIRS2.Valor,b_TaxaIRS);


                    if Flag = 0 then begin
                        if (B_RemuneracaoBruta1 <= TabelaIRS.Valor) and (B_RemuneracaoBruta1 > TabelaIRS2.Valor) then begin
                            Flag := 1;
                            TaxaIRSAux := b_TaxaIRS;
                        end;
                    end else begin
                        if (B_RemuneracaoBruta1 <= TabelaIRS.Valor) and (B_RemuneracaoBruta1 > TabelaIRS2.Valor) then begin
                            B_RemuneracaoBruta2 := B_RemuneracaoBruta1;
                            TaxIRS2 := b_TaxaIRS;
                        end;
                        b_TaxaIRS := TaxaIRSAux;
                        B_RemuneracaoBruta1 := B_VencimentoLiquido / (1 - (b_TaxaIRS / 100) - (TaxaSS / 100) - (TaxaCGA / 100));
                        TaxIRS1 := b_TaxaIRS;
                        Flag := 2;
                    end;
                until (TabelaIRS.Next(-1) = 0) or (Flag = 2);
            end;
        end;
    end;


    procedure SaberTabelaIRS(Empregado: Record Employee; Ano: Integer) Tabela: Integer
    begin


        //-------TABELA I - TRABALHO DEPENDENTE NÃO CASADO-------------------
        if (Empregado."Tipo Contribuinte" = 1) and (Empregado."Estado Civil" <> 1) and (Empregado.Deficiente = 0) then
            Tabela := 1;

        //-------TABELA II - TRABALHO DEPENDENTE CASADO, ÚNICO TITULAR----------------
        if (Empregado."Tipo Contribuinte" = 1) and (Empregado."Estado Civil" = 1) and (Empregado.Deficiente = 0) and
           (Empregado."Titular Rendimentos" = 1) then
            Tabela := 2;

        //------TABELA III - TRABALHO DEPENDENTE CASADO, DOIS TITULARES---------------
        if (Empregado."Tipo Contribuinte" = 1) and (Empregado."Estado Civil" = 1) and (Empregado.Deficiente = 0) and
           (Empregado."Titular Rendimentos" = 2) then
            Tabela := 3;

        //------TABELA IV - TRABALHO DEPENDENTE NÃO CASADO DEFICIENTE---------------
        if (Empregado."Tipo Contribuinte" = 1) and (Empregado."Estado Civil" <> 1) and (Empregado.Deficiente = 1) then
            Tabela := 4;

        //-------TABELA V - TRABALHO DEPENDENTE CASADO ÚNICO TITULAR DEFICIENTE------------
        if (Empregado."Tipo Contribuinte" = 1) and (Empregado."Estado Civil" = 1) and (Empregado.Deficiente = 1) and
           (Empregado."Titular Rendimentos" = 1) then
            Tabela := 5;

        //-------TABELA VI - TRABALHO DEPENDENTE CASADO, DOIS TITULARES DEFICIENTES--------------
        if (Empregado."Tipo Contribuinte" = 1) and (Empregado."Estado Civil" = 1) and (Empregado.Deficiente = 1) and
           (Empregado."Titular Rendimentos" = 2) then
            Tabela := 6;


        //----------TABELA VII - PENSÕES ---------------------------------
        if (Empregado."Tipo Contribuinte" = 3) and (Empregado.Deficiente = 0) then
            Tabela := 7;


        //------TABELA VIII - RENDIMENTOS DE PENSÕES/TITULARES DEFICIENTES--------
        if (Empregado."Tipo Contribuinte" = 3) and (Empregado.Deficiente = 1) then
            Tabela := 8;


        //---TABELA IX - PENSÕES. TITULARES DEFICENTES DAS FORÇAS ARMADAS------
        if (Empregado."Tipo Contribuinte" = 3) and (Empregado.Deficiente = 2) then
            Tabela := 9;
    end;
}

#pragma implicitwith restore

