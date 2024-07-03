page 53098 "Ficha Rubrica Salarial"
{
    //  IT001 - CPA:Novo campo para a funcionalidade de acertos de Duodécimos
    // 
    // IT003 - CPA - 207.07.03 -  No campo VB não quer que apareça o valor dos complementos

    PageType = Card;
    SourceTable = "Rubrica Salarial";

    layout
    {
        area(content)
        {
            group(Geral)
            {
                Caption = 'Geral';
                field("Código"; Código)
                {
                    ApplicationArea = All;

                }
                field("Tipo Rubrica"; "Tipo Rubrica")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Descrição)
                {
                    ApplicationArea = All;

                }
                field(Periodicidade; Periodicidade)
                {
                    ApplicationArea = All;

                }
                field("Mês Início Periocidade"; "Mês Início Periocidade")
                {
                    ApplicationArea = All;

                }
                field("No. Conta a Debitar"; "No. Conta a Debitar")
                {
                    ApplicationArea = All;

                }
                field("No. Conta a Creditar"; "No. Conta a Creditar")
                {
                    ApplicationArea = All;

                }
                field(Quantidade; Quantidade)
                {
                    ApplicationArea = All;


                    trigger OnValidate()
                    begin
                        Validacao;
                    end;
                }
                field("Valor Unitário"; "Valor Unitário")
                {
                    ApplicationArea = All;


                    trigger OnValidate()
                    begin
                        Validacao;
                    end;
                }
                field("Valor Total"; "Valor Total")
                {
                    ApplicationArea = All;


                    trigger OnValidate()
                    begin
                        Validacao;
                    end;
                }
                field("Tipo Rendimento Cat.A"; "Tipo Rendimento Cat.A")
                {
                    ApplicationArea = All;

                }
                field("Vencimento Base"; "Vencimento Base")
                {
                    ApplicationArea = All;

                    Caption = 'Vencimento Base do Recibo';
                }
            }
            part(RubricaSalarialLinhas; "Subform Rubrica Salarial")
            {
                ApplicationArea = All;

                Caption = 'Rubrica Salarial Fillhas';
                Editable = RubricaSalarialLinhasEditable;
                SubPageLink = "Cód. Rubrica" = FIELD("Código");
            }
            group("Dados Seg. Social")
            {

                Caption = 'Dados Seg. Social';
                field(NATREM; NATREM)
                {
                    ApplicationArea = All;

                    Caption = 'NATREM';
                    OptionCaption = '';
                }
            }
            group("Relatório Único")
            {
                Caption = 'Relatório Único';
                field("Tipo de Remuneração"; "Tipo de Remuneração")
                {
                    ApplicationArea = All;

                }
            }
            group(CGA)
            {
                Caption = 'CGA';
                field("Cód. Situação"; "Cód. Situação")
                {
                    ApplicationArea = All;

                }
                field("Cód. Movimento"; "Cód. Movimento")
                {
                    ApplicationArea = All;

                }
                field(Acertos; Acertos)
                {
                    ApplicationArea = All;

                }
            }
            group("Características")
            {
                Caption = 'Características';
                field(Genero; Rec.Genero)
                {
                    ApplicationArea = All;

                    //OptionCaption = ' ,Rúbrica de Vencimento Base,Rúbrica de IRS,Rúbrica de Seg. Social,Rúbrica Sub. Alimentação,Rúbrica IRS Sub. Férias,Rúbrica IRS Sub. Natal,Rúbrica Enc. Seg. Social,Rúbrica IVA,Rúbrica CGA,Rúbrica Falta,Rúbrica Hora Extra,Rúbrica Enc. CGA,Sindicato,ADSE,Admissão-Demissão,Enc. ADSE,Duo. Sub. Férias,Duo. Sub. Natal,Fundo Compensação Trabalho / FGCT';
                }
                field("Actualização Vencimento"; Rec."Actualização Vencimento")
                {
                    ApplicationArea = All;

                }
                field("Sobretaxa em Sede de IRS"; "Sobretaxa em Sede de IRS")
                {
                    ApplicationArea = All;

                }
                field("Imposto Extraordinário"; "Imposto Extraordinário")
                {
                    ApplicationArea = All;

                }
                field("Rubrica Acerto Duo"; "Rubrica Acerto Duo")
                {
                    ApplicationArea = All;

                }
            }
            group("Ausências")
            {
                Caption = 'Ausências';
                field(Faults; Faults)
                {
                    ApplicationArea = All;

                }
            }
            group("Rubrica de Fecho")
            {
                Caption = 'Rubrica de Fecho';
                field("Genero Rubrica Fecho"; Rec."Genero Rubrica Fecho")
                {
                    ApplicationArea = All;

                }
                field("Usado no cálculo indemnização"; "Usado no cálculo indemnização")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        SetRange(Código);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        //HG - 10.05.07 não deixar apagar uma rubrical se esta já tiver sido usada num processamento fechado
        TabHisLinhasMovEmp.Reset;
        TabHisLinhasMovEmp.SetRange(TabHisLinhasMovEmp."Cód. Rubrica", Código);
        if TabHisLinhasMovEmp.Find('-') then begin
            Error(Text0005);
            exit(false);
        end;


        //HG - quando apaga uma rubrica salarial "Mãe"
        //    1 - tem de apagar em todo o lado onde ela é filha
        //    2 - tem de apagar as filhas dela

        TabRubricaLinhas.Reset;
        TabRubricaLinhas.SetRange(TabRubricaLinhas."Cód. Rubrica Filha", Código);
        if TabRubricaLinhas.Find('-') then begin
            if not Confirm(Text0003, false, Código) then
                exit(false);
        end else begin
            TabRubricaLinhas.Reset;
            TabRubricaLinhas.SetRange(TabRubricaLinhas."Cód. Rubrica", Código);
            if TabRubricaLinhas.Find('-') then
                if not Confirm(Text0003, false, Código) then
                    exit(false);

        end;
    end;

    trigger OnInit()
    begin
        RubricaSalarialLinhasEditable := true;
    end;

    trigger OnModifyRecord(): Boolean
    begin

        //Alertar que vai alterar uma rubrica salarial que já foi usada num processamento fechado
        TabHisLinhasMovEmp.Reset;
        TabHisLinhasMovEmp.SetRange(TabHisLinhasMovEmp."Cód. Rubrica", Código);
        if TabHisLinhasMovEmp.Find('-') then begin
            if not Confirm(Text0004) then
                exit(false);
        end;
    end;

    var
        Text0001: Label 'Não pode associar Rúbricas enquanto houver Quantidade ou Valor atribuido à Rubrica %1.';
        TabRubricaLinhas: Record "Rubrica Salarial Linhas";
        Text0002: Label 'Não pode definir valores enquanto houver rubricas associadas à rúbrica %1.';
        Text0003: Label 'A rúbrica %1 tem rúbricas associadas e/ou é usada como rúbrica filha em outras rúbricas. Tem a certeza que a deseja eliminar?';
        TabHisLinhasMovEmp: Record "Hist. Linhas Movs. Empregado";
        Text0004: Label 'Tem a certeza que quer alterar uma rúbrica que já foi usada num processamento fechado.';
        Text0005: Label 'Não pode apagar uma rúbrica que já tenha sido usada num processamento fechado.';
        [InDataSet]
        RubricaSalarialLinhasEditable: Boolean;
        Text19055726: Label 'Códigos NATREM:';


    procedure Validacao()
    begin
        //HG 21.10.05 - Não deixar uma Rubrica ter valor e Rubricas Filhas ao mesmo tempo

        if (Quantidade = 0) and ("Valor Unitário" = 0) and ("Valor Total" = 0) then
            RubricaSalarialLinhasEditable := true
        else
            RubricaSalarialLinhasEditable := false;

        TabRubricaLinhas.Reset;
        TabRubricaLinhas.SetRange(TabRubricaLinhas."Cód. Rubrica", Código);
        if TabRubricaLinhas.Find('-') then begin
            Quantidade := 0;
            "Valor Unitário" := 0;
            "Valor Total" := 0;
            Message(Text0002, Código);
        end;
    end;

    local procedure RubricaSalarialLinhasOnActivat()
    begin
        if RubricaSalarialLinhasEditable = false then
            Message(Text0001, Código);
    end;
}

