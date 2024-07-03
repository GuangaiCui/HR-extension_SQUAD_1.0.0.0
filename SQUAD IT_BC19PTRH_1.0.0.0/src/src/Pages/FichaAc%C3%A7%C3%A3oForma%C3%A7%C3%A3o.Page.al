page 31003133 "Ficha Acção Formação"
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
                field("Código"; Código)
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Descrição)
                {
                    ApplicationArea = All;

                }
                field(Tipo; Tipo)
                {
                    ApplicationArea = All;

                }
                field("No. Horas Acção"; "No. Horas Acção")
                {
                    ApplicationArea = All;

                }
                field("Data Início"; "Data Início")
                {
                    ApplicationArea = All;

                }
                field("Data Fim"; "Data Fim")
                {
                    ApplicationArea = All;

                }
                field("Local"; "Local")
                {
                    ApplicationArea = All;

                }
                field("Nome Entidade Prestadora"; "Nome Entidade Prestadora")
                {
                    ApplicationArea = All;

                }
                field("Nome Formador"; "Nome Formador")
                {
                    ApplicationArea = All;

                }
                field("Custo Acção"; "Custo Acção")
                {
                    ApplicationArea = All;

                }
                field("Max. Participantes"; "Max. Participantes")
                {
                    ApplicationArea = All;

                }
                field("Participantes Inscritos"; "Participantes Inscritos")
                {
                    ApplicationArea = All;

                }
                field(Objectivos; Objectivos)
                {
                    ApplicationArea = All;

                    MultiLine = true;
                }
                field("Cod. Área de Educ./Formação"; "Cod. Área de Educ./Formação")
                {
                    ApplicationArea = All;

                }
                field("Área de Educação/Formação"; "Área de Educação/Formação")
                {
                    ApplicationArea = All;

                }
                field("Cod. Modalidade"; "Cod. Modalidade")
                {
                    ApplicationArea = All;

                }
                field(Modalidade; Modalidade)
                {
                    ApplicationArea = All;

                }
                field("Cod. Entidade Formadora"; "Cod. Entidade Formadora")
                {
                    ApplicationArea = All;

                }
                field("Entidade Formadora"; "Entidade Formadora")
                {
                    ApplicationArea = All;

                }
                field("Cód. Nível Qualificação Form."; "Cód. Nível Qualificação Form.")
                {
                    ApplicationArea = All;

                }
                field("Nível Qualificação Formação"; "Nível Qualificação Formação")
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
        //HG - 29.04.08 não deixar apagar uma acção se esta já tiver sido associada a um empregado

        FormacaoEmpregado.Reset;
        FormacaoEmpregado.SetRange(FormacaoEmpregado."Cód. Acção", Código);
        if FormacaoEmpregado.Find('-') then begin
            Error(Text0001);
            exit(false);
        end;
    end;

    var
        Text0001: Label 'Não pode apagar uma acção que já tenha sido associada a um empregado.';
        FormacaoEmpregado: Record "Formação Empregado";
}

