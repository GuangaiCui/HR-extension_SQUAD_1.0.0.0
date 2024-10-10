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
                field("Entry No."; Rec."Entry No.")
                {


                }
                field("Employee No."; Rec."Employee No.")
                {


                }
                field(Data; Rec.Date)
                {


                }
                field("Payroll Item Code"; Rec."Payroll Item Code")
                {


                }
                field("Payroll Item Type"; Rec."Payroll Item Type")
                {


                }
                field("Payroll Item Description"; Rec."Payroll Item Description")
                {


                }
                field(Quantity; Rec.Quantity)
                {


                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {


                }
                field("Unit Value"; Rec."Unit Value")
                {


                }
                field("Valor Total"; Rec."Valor Total")
                {


                }
                field("Anular Falta"; Rec."Cancel Absence")
                {


                }
                field("Reference Date"; Rec."Reference Date")
                {


                }
                field("Qtd. Perca Sub. Alimentação"; Rec."Qtd. Perca Sub. Alimentação")
                {


                }
                field("Earning - Blocked Deduction"; Rec."Earning - Blocked Deduction")
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
        if (Rec."Earning - Blocked Deduction" = true) and (Flag = false) then begin
            Message(Text0001);
            Flag := true;
        end;

        CurrPage.SetSelectionFilter(AbonDescExtra);
        if (AbonDescExtra.Find('-')) and (AbonDescExtra.Count = 1) then
            Flag := false;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        exit(Employee.Get(Rec."Employee No."));
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //HG
        Rec."Employee No." := Rec.GetFilter("Employee No.");
    end;

    var
        Text0001: Label 'Este Abono-Desconto Extra já foi processado, será necessário refazer o processamento para este empregado.';
        Employee: Record Empregado;
        Flag: Boolean;
        AbonDescExtra: Record "Abonos - Descontos Extra";
}

#pragma implicitwith restore

