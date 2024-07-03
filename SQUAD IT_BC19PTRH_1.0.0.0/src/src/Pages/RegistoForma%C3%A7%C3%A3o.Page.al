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
                field("No. Empregado"; "No. Empregado")
                {
                    ApplicationArea = All;

                }
                field("Cód. Acção"; "Cód. Acção")
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
                field("Entidade Prestadora"; "Entidade Prestadora")
                {
                    ApplicationArea = All;

                }
                field("Custo Acção"; "Custo Acção")
                {
                    ApplicationArea = All;

                }
                field("Iniciativa da Formação"; "Iniciativa da Formação")
                {
                    ApplicationArea = All;

                }
                field("Horário Formação"; "Horário Formação")
                {
                    ApplicationArea = All;

                }
                field("Tipo Certificado/Diploma"; "Tipo Certificado/Diploma")
                {
                    ApplicationArea = All;

                }
                field("Avaliação"; Avaliação)
                {
                    ApplicationArea = All;

                }
                field("Observações"; Observações)
                {
                    ApplicationArea = All;

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
                    ApplicationArea = All;

                    Caption = 'Formação Colectiva';
                    Image = Campaign;

                    trigger OnAction()
                    begin
                        REPORT.RunModal(53090);
                    end;
                }
                action("Situação Face à Frequência")
                {
                    ApplicationArea = All;

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
        exit(Employee.Get("No. Empregado"));
    end;

    trigger OnOpenPage()
    begin
        SetCurrentKey("Data Início", "Cód. Acção", "No. Empregado"); //2008.05.09
    end;

    var
        Employee: Record Empregado;
}

