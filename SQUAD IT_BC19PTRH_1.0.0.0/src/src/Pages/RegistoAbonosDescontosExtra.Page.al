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
                field("No. Mov."; "No. Mov.")
                {
                    ApplicationArea = All;

                }
                field("No. Empregado"; "No. Empregado")
                {
                    ApplicationArea = All;

                }
                field(Data; Data)
                {
                    ApplicationArea = All;

                }
                field("Cód. Rubrica"; "Cód. Rubrica")
                {
                    ApplicationArea = All;

                }
                field("Tipo Rubrica"; "Tipo Rubrica")
                {
                    ApplicationArea = All;

                }
                field("Descrição Rubrica"; "Descrição Rubrica")
                {
                    ApplicationArea = All;

                }
                field(Quantidade; Quantidade)
                {
                    ApplicationArea = All;

                }
                field(UnidadeMedida; UnidadeMedida)
                {
                    ApplicationArea = All;

                }
                field("Valor Unitário"; "Valor Unitário")
                {
                    ApplicationArea = All;

                }
                field("Valor Total"; "Valor Total")
                {
                    ApplicationArea = All;

                }
                field("Anular Falta"; "Anular Falta")
                {
                    ApplicationArea = All;

                }
                field("Data a que se refere o Mov."; "Data a que se refere o Mov.")
                {
                    ApplicationArea = All;

                }
                field("Qtd. Perca Sub. Alimentação"; "Qtd. Perca Sub. Alimentação")
                {
                    ApplicationArea = All;

                }
                field("Abono - Desconto Bloqueado"; "Abono - Desconto Bloqueado")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = All;

                }
                field("Garnishmen No."; "Garnishmen No.")
                {
                    ApplicationArea = All;

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
        if ("Abono - Desconto Bloqueado" = true) and (Flag = false) then begin
            Message(Text0001);
            Flag := true;
        end;

        CurrPage.SetSelectionFilter(AbonDescExtra);
        if (AbonDescExtra.Find('-')) and (AbonDescExtra.Count = 1) then
            Flag := false;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        exit(Employee.Get("No. Empregado"));
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //HG
        "No. Empregado" := GetFilter("No. Empregado");
    end;

    var
        Text0001: Label 'Este Abono-Desconto Extra já foi processado, será necessário refazer o processamento para este empregado.';
        Employee: Record Empregado;
        Flag: Boolean;
        AbonDescExtra: Record "Abonos - Descontos Extra";
}

