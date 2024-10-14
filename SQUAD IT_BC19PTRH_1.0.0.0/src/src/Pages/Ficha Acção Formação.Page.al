#pragma implicitwith disable
page 53133 "Ficha Acção Formação"
{
    PageType = Card;
    SourceTable = "Acções Formação";
    ApplicationArea = HumanResourcesAppArea;
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
                field("Descrição"; Rec."Descrição")
                {


                }
                field(Tipo; Rec.Tipo)
                {


                }
                field("No. Horas Acção"; Rec."No. Horas Acção")
                {


                }
                field("Data Início"; Rec."Data Início")
                {


                }
                field("Data Fim"; Rec."Data Fim")
                {


                }
                field("Local"; Rec."Local")
                {


                }
                field("Nome Entidade Prestadora"; Rec."Nome Entidade Prestadora")
                {


                }
                field("Nome Formador"; Rec."Nome Formador")
                {


                }
                field("Custo Acção"; Rec."Custo Acção")
                {


                }
                field("Max. Participantes"; Rec."Max. Participantes")
                {


                }
                field("Participantes Inscritos"; Rec."Participantes Inscritos")
                {


                }
                field(Objectivos; Rec.Objectivos)
                {


                    MultiLine = true;
                }
                field("Cod. Área de Educ./Formação"; Rec."Cod. Área de Educ./Formação")
                {


                }
                field("Área de Educação/Formação"; Rec."Área de Educação/Formação")
                {


                }
                field("Cod. Modalidade"; Rec."Cod. Modalidade")
                {


                }
                field(Modalidade; Rec.Modalidade)
                {


                }
                field("Cod. Entidade Formadora"; Rec."Cod. Entidade Formadora")
                {


                }
                field("Entidade Formadora"; Rec."Entidade Formadora")
                {


                }
                field("Cód. Nível Qualificação Form."; Rec."Cód. Nível Qualificação Form.")
                {


                }
                field("Nível Qualificação Formação"; Rec."Nível Qualificação Formação")
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

