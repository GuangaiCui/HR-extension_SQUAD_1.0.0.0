#pragma implicitwith disable
page 53096 "Registo Abonos-Descontos Extra"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Abonos - Descontos Extra";
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("No. Mov."; Rec."No. Mov.")
                {


                }
                field("No. Empregado"; Rec."No. Empregado")
                {


                }
                field(Data; Rec.Data)
                {


                }
                field("Cód. Rubrica"; Rec."Cód. Rubrica")
                {


                }
                field("Tipo Rubrica"; Rec."Tipo Rubrica")
                {


                }
                field("Descrição Rubrica"; Rec."Descrição Rubrica")
                {


                }
                field(Quantidade; Rec.Quantidade)
                {


                }
                field(UnidadeMedida; Rec.UnidadeMedida)
                {


                }
                field("Valor Unitário"; Rec."Valor Unitário")
                {


                }
                field("Valor Total"; Rec."Valor Total")
                {


                }
                field("Anular Falta"; Rec."Anular Falta")
                {


                }
                field("Data a que se refere o Mov."; Rec."Data a que se refere o Mov.")
                {


                }
                field("Qtd. Perca Sub. Alimentação"; Rec."Qtd. Perca Sub. Alimentação")
                {


                }
                field("Abono - Desconto Bloqueado"; Rec."Abono - Desconto Bloqueado")
                {


                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {


                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {


                }
                field("Garnishmen No."; Rec."Garnishmen No.")
                {


                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin
        //Não deixar apagar Abono-Desconto bloqueadas

        //2009.03.24 - a mensagem só deve aparecer uma vez por cada delete e não por cada registo
        if (Rec."Abono - Desconto Bloqueado" = true) and (Flag = false) then begin
            Message(Text0001);
            Flag := true;
        end;

        CurrPage.SetSelectionFilter(AbonDescExtra);
        if (AbonDescExtra.Find('-')) and (AbonDescExtra.Count = 1) then
            Flag := false;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        exit(Employee.Get(Rec."No. Empregado"));
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //HG
        Rec."No. Empregado" := Rec.GetFilter("No. Empregado");
    end;

    var
        Text0001: Label 'Este Abono-Desconto Extra já foi processado, será necessário refazer o processamento para este empregado.';
        Employee: Record Empregado;
        Flag: Boolean;
        AbonDescExtra: Record "Abonos - Descontos Extra";
}

#pragma implicitwith restore

