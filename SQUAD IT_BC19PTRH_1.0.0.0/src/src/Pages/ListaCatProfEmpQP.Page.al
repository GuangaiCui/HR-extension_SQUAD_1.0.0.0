page 53077 "Lista Cat. Prof. Emp. QP"
{
    AutoSplitKey = true;
    Caption = 'Categoria Prof. Empregado QP';
    DataCaptionFields = "No. Empregado";
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Cat. Prof. QP Empregado";
    UsageCategory = Administration;
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
                field("Cód. Cat. Prof. QP"; "Cód. Cat. Prof. QP")
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
                {
                    ApplicationArea = All;

                }
                field("Data Inicio Cat. Prof."; "Data Inicio Cat. Prof.")
                {
                    ApplicationArea = All;

                }
                field("Data Fim Cat. Prof."; "Data Fim Cat. Prof.")
                {
                    ApplicationArea = All;

                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;

                }
                field(Reconversion; Reconversion)
                {
                    ApplicationArea = All;

                    Editable = ReconversaoEditable;

                    trigger OnValidate()
                    begin
                        ReconversaoOnAfterValidate;
                    end;
                }
                field("Promotion Reason"; "Promotion Reason")
                {
                    ApplicationArea = All;

                    Editable = "Motivo promoçãoEditable";

                    trigger OnValidate()
                    begin
                        Motivopromo231227oOnAfterValid;
                    end;
                }
                field("Reconversion Date"; "Reconversion Date")
                {
                    ApplicationArea = All;

                    Editable = "Data reconversãoEditable";
                }
                field("Reconversion Reason"; "Reconversion Reason")
                {
                    ApplicationArea = All;

                    Editable = "Motivo reconversãoEditable";
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Cat. Prof. Emp. QP e BS")
            {
                action("Comentários")
                {
                    ApplicationArea = All;

                    Caption = 'Comentários';
                    Image = ViewComments;
                    RunObject = Page "Folha Comentários RH";
                    RunPageLink = "Table Name" = CONST(CatProfQP),
                                  "No." = FIELD("No. Empregado"),
                                  "Table Line No." = FIELD("No. Linha");
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        "Motivo promoçãoEditable" := true;
        "Motivo reconversãoEditable" := true;
        "Data reconversãoEditable" := true;
        ReconversaoEditable := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    var
        [InDataSet]
        ReconversaoEditable: Boolean;
        [InDataSet]
        "Data reconversãoEditable": Boolean;
        [InDataSet]
        "Motivo reconversãoEditable": Boolean;
        [InDataSet]
        "Motivo promoçãoEditable": Boolean;

    local procedure ReconversaoOnAfterValidate()
    begin
        CurrPage.Update(true);
    end;

    local procedure Motivopromo231227oOnAfterValid()
    begin
        if "Promotion Reason" <> 0 then begin
            ReconversaoEditable := false;
            "Data reconversãoEditable" := false;
            "Motivo reconversãoEditable" := false;
        end
        else begin
            ReconversaoEditable := true;
        end;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        //No caso de o campo reconversao ter o pisco os campos "Data reconversão" e "Motivo reconversão" ficam editaveis para o utilizador
        //Se tiver um valor no campo motivo promoção então ja nao se pode fazer nada relacionada com reconversão
        //validações feitas no onvalidate do campo

        if Reconversion then begin
            "Motivo promoçãoEditable" := false;
            "Data reconversãoEditable" := true;
            "Motivo reconversãoEditable" := true;
        end else begin
            "Motivo promoçãoEditable" := true;
            "Data reconversãoEditable" := false;
            "Motivo reconversãoEditable" := false;
        end;
    end;
}

