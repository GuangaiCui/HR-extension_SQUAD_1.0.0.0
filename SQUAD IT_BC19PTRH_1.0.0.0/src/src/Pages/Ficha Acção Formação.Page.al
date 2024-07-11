#pragma implicitwith disable
page 53133 "Ficha Acção Formação"
{
    PageType = Card;
    SourceTable = "Acções Formação";

    layout
    {
        area(content)
        {
            group(Geral)
            {
                Caption = 'Geral';
                field("Código"; Rec."Código")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Rec."Descrição")
                {
                    ApplicationArea = All;

                }
                field(Tipo; Rec.Tipo)
                {
                    ApplicationArea = All;

                }
                field("No. Horas Acção"; Rec."No. Horas Acção")
                {
                    ApplicationArea = All;

                }
                field("Data Início"; Rec."Data Início")
                {
                    ApplicationArea = All;

                }
                field("Data Fim"; Rec."Data Fim")
                {
                    ApplicationArea = All;

                }
                field("Local"; Rec."Local")
                {
                    ApplicationArea = All;

                }
                field("Nome Entidade Prestadora"; Rec."Nome Entidade Prestadora")
                {
                    ApplicationArea = All;

                }
                field("Nome Formador"; Rec."Nome Formador")
                {
                    ApplicationArea = All;

                }
                field("Custo Acção"; Rec."Custo Acção")
                {
                    ApplicationArea = All;

                }
                field("Max. Participantes"; Rec."Max. Participantes")
                {
                    ApplicationArea = All;

                }
                field("Participantes Inscritos"; Rec."Participantes Inscritos")
                {
                    ApplicationArea = All;

                }
                field(Objectivos; Rec.Objectivos)
                {
                    ApplicationArea = All;

                    MultiLine = true;
                }
                field("Cod. Área de Educ./Formação"; Rec."Cod. Área de Educ./Formação")
                {
                    ApplicationArea = All;

                }
                field("Área de Educação/Formação"; Rec."Área de Educação/Formação")
                {
                    ApplicationArea = All;

                }
                field("Cod. Modalidade"; Rec."Cod. Modalidade")
                {
                    ApplicationArea = All;

                }
                field(Modalidade; Rec.Modalidade)
                {
                    ApplicationArea = All;

                }
                field("Cod. Entidade Formadora"; Rec."Cod. Entidade Formadora")
                {
                    ApplicationArea = All;

                }
                field("Entidade Formadora"; Rec."Entidade Formadora")
                {
                    ApplicationArea = All;

                }
                field("Cód. Nível Qualificação Form."; Rec."Cód. Nível Qualificação Form.")
                {
                    ApplicationArea = All;

                }
                field("Nível Qualificação Formação"; Rec."Nível Qualificação Formação")
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
        Rec.SetRange(Código);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        //HG - 29.04.08 não deixar apagar uma acção se esta já tiver sido associada a um empregado

        FormacaoEmpregado.Reset;
        FormacaoEmpregado.SetRange(FormacaoEmpregado."Cód. Acção", Rec."Código");
        if FormacaoEmpregado.Find('-') then begin
            Error(Text0001);
            exit(false);
        end;
    end;

    var
        Text0001: Label 'Não pode apagar uma acção que já tenha sido associada a um empregado.';
        FormacaoEmpregado: Record "Formação Empregado";
}

#pragma implicitwith restore

