
page 53098 "Ficha Rubrica Salarial"
{
    //  IT001 - CPA:Novo campo para a funcionalidade de acertos de Duodécimos
    // 
    // IT003 - CPA - 207.07.03 -  No campo VB não quer que apareça o valor dos complementos

    ApplicationArea = All;
    Caption = 'Ficha Rubrica Salarial';
    PageType = Card;
    SourceTable = "Rubrica Salarial";

    layout
    {
        area(content)
        {
            group(Geral)
            {
                Caption = 'Geral';
                field("Código"; Rec."Código")
                {


                }
                field("Tipo Rubrica"; Rec."Tipo Rubrica")
                {


                }
                field("Descrição"; Rec."Descrição")
                {


                }
                field(Periodicidade; Rec.Periodicidade)
                {


                }
                field("Mês Início Periocidade"; Rec."Mês Início Periocidade")
                {


                }
                field("No. Conta a Debitar"; Rec."No. Conta a Debitar")
                {


                }
                field("No. Conta a Creditar"; Rec."No. Conta a Creditar")
                {


                }
                field(Quantidade; Rec.Quantidade)
                {



                    trigger OnValidate()
                    begin
                        Validacao;
                    end;
                }
                field("Valor Unitário"; Rec."Valor Unitário")
                {



                    trigger OnValidate()
                    begin
                        Validacao;
                    end;
                }
                field("Valor Total"; Rec."Valor Total")
                {



                    trigger OnValidate()
                    begin
                        Validacao;
                    end;
                }
                field("Tipo Rendimento Cat.A"; Rec."Tipo Rendimento Cat.A")
                {


                }
                field("Vencimento Base"; Rec."Vencimento Base")
                {


                    Caption = 'Vencimento Base do Recibo';
                }
            }
            part("RubricaSalarialLinhas"; "Subform Rubrica Salarial")
            {
                // Filter on the sales orders that relate to the customer in the card page.


                Caption = 'Rubrica Salarial Fillhas';
                Editable = RubricaSalarialLinhasEditable;
                SubPageLink = "Cód. Rubrica" = FIELD("Código");
            }
            group("Dados Seg. Social")
            {

                Caption = 'Dados Seg. Social';
                field(NATREM; Rec.NATREM)
                {


                    Caption = 'NATREM';
                }
            }
            group("Relatório Único")
            {
                Caption = 'Relatório Único';
                field("Tipo de Remuneração"; Rec."Tipo de Remuneração")
                {


                }
            }
            group(CGA)
            {
                Caption = 'CGA';
                field("Cód. Situação"; Rec."Cód. Situação")
                {


                }
                field("Cód. Movimento"; Rec."Cód. Movimento")
                {


                }
                field(Acertos; Rec.Acertos)
                {


                }
            }
            group("Características")
            {
                Caption = 'Características';
                field(Genero; Rec.Genero)
                {


                    //OptionCaption = ' ,Rúbrica de Vencimento Base,Rúbrica de IRS,Rúbrica de Seg. Social,Rúbrica Sub. Alimentação,Rúbrica IRS Sub. Férias,Rúbrica IRS Sub. Natal,Rúbrica Enc. Seg. Social,Rúbrica IVA,Rúbrica CGA,Rúbrica Falta,Rúbrica Hora Extra,Rúbrica Enc. CGA,Sindicato,ADSE,Admissão-Demissão,Enc. ADSE,Duo. Sub. Férias,Duo. Sub. Natal,Fundo Compensação Trabalho / FGCT';
                }
                field("Actualização Vencimento"; Rec."Actualização Vencimento")
                {


                }
                field("Sobretaxa em Sede de IRS"; Rec."Sobretaxa em Sede de IRS")
                {


                }
                field("Imposto Extraordinário"; Rec."Imposto Extraordinário")
                {


                }
                field("Rubrica Acerto Duo"; Rec."Rubrica Acerto Duo")
                {


                }
            }
            group("Ausências")
            {
                Caption = 'Ausências';
                field(Faults; Rec.Faults)
                {


                }
            }
            group("Rubrica de Fecho")
            {
                Caption = 'Rubrica de Fecho';
                field("Genero Rubrica Fecho"; Rec."Genero Rubrica Fecho")
                {


                }
                field("Usado no cálculo indemnização"; Rec."Usado no cálculo indemnização")
                {


                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SetRange(Código);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        //HG - 10.05.07 não deixar apagar uma rubrical se esta já tiver sido usada num processamento fechado
        TabHisLinhasMovEmp.Reset;
        TabHisLinhasMovEmp.SetRange(TabHisLinhasMovEmp."Cód. Rubrica", Rec."Código");
        if TabHisLinhasMovEmp.Find('-') then begin
            Error(Text0005);
            exit(false);
        end;


        //HG - quando apaga uma rubrica salarial "Mãe"
        //    1 - tem de apagar em todo o lado onde ela é filha
        //    2 - tem de apagar as filhas dela

        TabRubricaLinhas.Reset;
        TabRubricaLinhas.SetRange(TabRubricaLinhas."Cód. Rubrica Filha", Rec."Código");
        if TabRubricaLinhas.Find('-') then begin
            if not Confirm(Text0003, false, Rec."Código") then
                exit(false);
        end else begin
            TabRubricaLinhas.Reset;
            TabRubricaLinhas.SetRange(TabRubricaLinhas."Cód. Rubrica", Rec."Código");
            if TabRubricaLinhas.Find('-') then
                if not Confirm(Text0003, false, Rec."Código") then
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
        TabHisLinhasMovEmp.SetRange(TabHisLinhasMovEmp."Cód. Rubrica", Rec."Código");
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
        RubricaSalarialLinhasEditable: Boolean;
        Text19055726: Label 'Códigos NATREM:';


    procedure Validacao()
    begin
        //HG 21.10.05 - Não deixar uma Rubrica ter valor e Rubricas Filhas ao mesmo tempo

        if (Rec.Quantidade = 0) and (Rec."Valor Unitário" = 0) and (Rec."Valor Total" = 0) then
            RubricaSalarialLinhasEditable := true
        else
            RubricaSalarialLinhasEditable := false;

        TabRubricaLinhas.Reset;
        TabRubricaLinhas.SetRange(TabRubricaLinhas."Cód. Rubrica", Rec."Código");
        if TabRubricaLinhas.Find('-') then begin
            Rec.Quantidade := 0;
            Rec."Valor Unitário" := 0;
            Rec."Valor Total" := 0;
            Message(Text0002, Rec."Código");
        end;
    end;

    local procedure RubricaSalarialLinhasOnActivat()
    begin
        if RubricaSalarialLinhasEditable = false then
            Message(Text0001, Rec."Código");
    end;
}

