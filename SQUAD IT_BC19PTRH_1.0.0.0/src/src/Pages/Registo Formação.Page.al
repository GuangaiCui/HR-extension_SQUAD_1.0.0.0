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
                    ApplicationArea = All;

                }
                field("Cód. Acção"; Rec."Cód. Acção")
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
                field("Entidade Prestadora"; Rec."Entidade Prestadora")
                {
                    ApplicationArea = All;

                }
                field("Custo Acção"; Rec."Custo Acção")
                {
                    ApplicationArea = All;

                }
                field("Iniciativa da Formação"; Rec."Iniciativa da Formação")
                {
                    ApplicationArea = All;

                }
                field("Horário Formação"; Rec."Horário Formação")
                {
                    ApplicationArea = All;

                }
                field("Tipo Certificado/Diploma"; Rec."Tipo Certificado/Diploma")
                {
                    ApplicationArea = All;

                }
                field("Avaliação"; Rec."Avaliação")
                {
                    ApplicationArea = All;

                }
                field("Observações"; Rec."Observações")
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
        exit(Employee.Get(Rec."No. Empregado"));
    end;

    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("Data Início", "Cód. Acção", "No. Empregado"); //2008.05.09
    end;

    var
        Employee: Record Employee;
}

#pragma implicitwith restore

