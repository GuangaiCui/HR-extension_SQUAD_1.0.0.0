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
                field("No. Empregado"; "No. Empregado")
                {
                    ApplicationArea = All;

                }
                field("Data Inicio"; "Data Inicio")
                {
                    ApplicationArea = All;

                }
                field("Data Fim"; "Data Fim")
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
                field(Percentagem; Percentagem)
                {
                    ApplicationArea = All;

                }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;

                }
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;

                }
                field("Shortcut Dimension 5 Code"; "Shortcut Dimension 5 Code")
                {
                    ApplicationArea = All;

                }
                field("Shortcut Dimension 6 Code"; "Shortcut Dimension 6 Code")
                {
                    ApplicationArea = All;

                }
                field("Shortcut Dimension 7 Code"; "Shortcut Dimension 7 Code")
                {
                    ApplicationArea = All;

                }
                field("Shortcut Dimension 8 Code"; "Shortcut Dimension 8 Code")
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
        DistribDim.SetRange(DistribDim."No. Empregado", "No. Empregado");
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

