#pragma implicitwith disable
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
                field("No. Empregado"; Rec."No. Empregado")
                {
                    ;

                }
                field("Cód. Cat. Prof. QP"; Rec."Cód. Cat. Prof. QP")
                {
                    ;

                }
                field(Description; Rec.Description)
                {
                    ;

                }
                field("Data Inicio Cat. Prof."; Rec."Data Inicio Cat. Prof.")
                {
                    ;

                }
                field("Data Fim Cat. Prof."; Rec."Data Fim Cat. Prof.")
                {
                    ;

                }
                field(Comment; Rec.Comment)
                {
                    ;

                }
                field(Reconversion; Rec.Reconversion)
                {
                    ;

                    Editable = ReconversaoEditable;

                    trigger OnValidate()
                    begin
                        ReconversaoOnAfterValidate;
                    end;
                }
                field("Promotion Reason"; Rec."Promotion Reason")
                {
                    ;

                    Editable = "Motivo promoçãoEditable";

                    trigger OnValidate()
                    begin
                        Motivopromo231227oOnAfterValid;
                    end;
                }
                field("Reconversion Date"; Rec."Reconversion Date")
                {
                    ;

                    Editable = "Data reconversãoEditable";
                }
                field("Reconversion Reason"; Rec."Reconversion Reason")
                {
                    ;

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
                    ;

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
        fx_OnAfterGetCurrRecord;
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
        fx_OnAfterGetCurrRecord;
    end;

    var

        ReconversaoEditable: Boolean;

        "Data reconversãoEditable": Boolean;

        "Motivo reconversãoEditable": Boolean;

        "Motivo promoçãoEditable": Boolean;

    local procedure ReconversaoOnAfterValidate()
    begin
        CurrPage.Update(true);
    end;

    local procedure Motivopromo231227oOnAfterValid()
    begin
        if Rec."Promotion Reason" <> 0 then begin
            ReconversaoEditable := false;
            "Data reconversãoEditable" := false;
            "Motivo reconversãoEditable" := false;
        end
        else begin
            ReconversaoEditable := true;
        end;
    end;

    local procedure fx_OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        //No caso de o campo reconversao ter o pisco os campos "Data reconversão" e "Motivo reconversão" ficam editaveis para o utilizador
        //Se tiver um valor no campo motivo promoção então ja nao se pode fazer nada relacionada com reconversão
        //validações feitas no onvalidate do campo

        if Rec.Reconversion then begin
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

#pragma implicitwith restore

