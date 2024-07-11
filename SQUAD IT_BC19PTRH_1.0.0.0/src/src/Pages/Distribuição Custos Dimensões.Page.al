#pragma implicitwith disable
page 53113 "Distribuição Custos -Dimensões"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Distribuição Custos";

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
                field("Data Inicio"; Rec."Data Inicio")
                {
                    ApplicationArea = All;

                }
                field("Data Fim"; Rec."Data Fim")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;

                }
                field(Percentagem; Rec.Percentagem)
                {
                    ApplicationArea = All;

                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;

                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;

                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ApplicationArea = All;

                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ApplicationArea = All;

                }
                field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                {
                    ApplicationArea = All;

                }
                field("Shortcut Dimension 8 Code"; Rec."Shortcut Dimension 8 Code")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        TotalPercentagem: Decimal;
    begin
        //2009.03.10 - Testa se as linhas prefazem 100% caso contrário dá erro
        TotalPercentagem := 0;
        DistribDim.Reset;
        DistribDim.SetRange(DistribDim."No. Empregado", Rec."No. Empregado");
        if DistribDim.Find('-') then begin
            repeat
                TotalPercentagem := TotalPercentagem + DistribDim.Percentagem;
            until DistribDim.Next = 0;
        end;

        if (TotalPercentagem <> 0) and (TotalPercentagem <> 1) then begin
            Message(Text0001);
            exit(false);
        end;
    end;

    var
        DistribDim: Record "Distribuição Custos";
        Text0001: Label 'O total das percentagens não perfaz 100%.';
}

#pragma implicitwith restore

