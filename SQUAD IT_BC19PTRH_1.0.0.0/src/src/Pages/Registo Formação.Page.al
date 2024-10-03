#pragma implicitwith disable
page 53121 "Registo Formação"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Formação Empregado";
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("No. Empregado"; Rec."No. Empregado")
                {


                }
                field("Cód. Acção"; Rec."Cód. Acção")
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
                field("Entidade Prestadora"; Rec."Entidade Prestadora")
                {


                }
                field("Custo Acção"; Rec."Custo Acção")
                {


                }
                field("Iniciativa da Formação"; Rec."Iniciativa da Formação")
                {


                }
                field("Horário Formação"; Rec."Horário Formação")
                {


                }
                field("Tipo Certificado/Diploma"; Rec."Tipo Certificado/Diploma")
                {


                }
                field("Avaliação"; Rec."Avaliação")
                {


                }
                field("Observações"; Rec."Observações")
                {


                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&ormação")
            {
                Caption = 'F&ormação';
                action("Formação Colectiva")
                {


                    Caption = 'Formação Colectiva';
                    Image = Campaign;

                    trigger OnAction()
                    begin
                        REPORT.RunModal(53090);
                    end;
                }
                action("Situação Face à Frequência")
                {


                    Caption = 'Situação Face à Frequência';
                    Image = Form;
                    RunObject = Page "Formação - Período Referência";
                    RunPageLink = "No. Empregado" = FIELD("No. Empregado"),
                                  "Cód. Acção" = FIELD("Cód. Acção");
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //HG
        exit(Employee.Get(Rec."No. Empregado"));
    end;

    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("Data Início", "Cód. Acção", "No. Empregado"); //2008.05.09
    end;

    var
        Employee: Record Empregado;
}

#pragma implicitwith restore

