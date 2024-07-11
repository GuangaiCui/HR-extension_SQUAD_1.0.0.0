#pragma implicitwith disable
page 53105 "Periodos Processamento"
{
    Caption = 'Abertura do Processamento';
    PageType = List;
    SourceTable = "Periodos Processamento";
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Cód. Processamento"; Rec."Cód. Processamento")
                {
                    ApplicationArea = All;

                    Editable = boolEnable;
                }
                field("Tipo Processamento"; Rec."Tipo Processamento")
                {
                    ApplicationArea = All;

                    Editable = boolEnable;
                }
                field("Data Registo"; Rec."Data Registo")
                {
                    ApplicationArea = All;

                    Editable = boolEnable;
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;

                    Editable = false;
                }
                field("Data Inicio Processamento"; Rec."Data Inicio Processamento")
                {
                    ApplicationArea = All;

                    Editable = boolEnable;
                    Enabled = boolEnable;
                }
                field("Data Fim Processamento"; Rec."Data Fim Processamento")
                {
                    ApplicationArea = All;

                    Editable = boolEnable;
                    Enabled = boolEnable;
                }
                field("Integrado na Contabilidade"; Rec."Integrado na Contabilidade")
                {
                    ApplicationArea = All;

                    Editable = false;
                    Enabled = boolEnable;
                }
                field("Data Inicio Proces. Faltas"; Rec."Data Inicio Proces. Faltas")
                {
                    ApplicationArea = All;

                    Editable = false;
                }
                field("Data Fim Proces. Faltas"; Rec."Data Fim Proces. Faltas")
                {
                    ApplicationArea = All;

                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Processamento Vencimentos")
            {
                ApplicationArea = All;

                Caption = 'fsf';
                Image = PaymentDays;
                RunObject = Report "Processamento Vencimentos";
            }
            action("Fecho Mês")
            {
                ApplicationArea = All;

                Caption = 'Fecho Mês';
                Image = StopPayment;
                RunObject = Report "Fecho Mês";
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        boolEnable := true;
        if Rec.Estado = Rec.Estado::Fechado then
            boolEnable := false;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        boolEnable := true;
        if Rec.Estado = Rec.Estado::Fechado then
            boolEnable := false;
    end;

    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("Data Registo");
    end;

    var
        boolEnable: Boolean;
}

#pragma implicitwith restore

