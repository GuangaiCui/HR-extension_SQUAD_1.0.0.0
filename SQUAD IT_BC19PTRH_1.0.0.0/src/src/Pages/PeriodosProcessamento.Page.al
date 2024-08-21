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
                    ;

                    Editable = boolEnable;
                }
                field("Tipo Processamento"; Rec."Tipo Processamento")
                {
                    ;

                    Editable = boolEnable;
                }
                field("Data Registo"; Rec."Data Registo")
                {
                    ;

                    Editable = boolEnable;
                }
                field(Estado; Rec.Estado)
                {
                    ;

                    Editable = false;
                }
                field("Data Inicio Processamento"; Rec."Data Inicio Processamento")
                {
                    ;

                    Editable = boolEnable;
                    Enabled = boolEnable;
                }
                field("Data Fim Processamento"; Rec."Data Fim Processamento")
                {
                    ;

                    Editable = boolEnable;
                    Enabled = boolEnable;
                }
                field("Integrado na Contabilidade"; Rec."Integrado na Contabilidade")
                {
                    ;

                    Editable = false;
                    Enabled = boolEnable;
                }
                field("Data Inicio Proces. Faltas"; Rec."Data Inicio Proces. Faltas")
                {
                    ;

                    Editable = false;
                }
                field("Data Fim Proces. Faltas"; Rec."Data Fim Proces. Faltas")
                {
                    ;

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
                ;

                Caption = 'fsf';
                Image = PaymentDays;
                RunObject = Report "Processamento Vencimentos";
            }
            action("Fecho Mês")
            {
                ;

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

