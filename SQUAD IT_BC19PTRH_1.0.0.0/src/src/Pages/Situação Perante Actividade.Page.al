#pragma implicitwith disable
page 53157 "Situação Perante Actividade"
{
    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Situação Perante Actividade";

    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field("Situação"; Rec."Situação")
                {
                    ApplicationArea = All;

                }
                field("Desc. Situação"; Rec."Desc. Situação")
                {
                    ApplicationArea = All;

                }
                field(Motivo; Rec.Motivo)
                {
                    ApplicationArea = All;

                }
                field("Desc. Motivo"; Rec."Desc. Motivo")
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
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        TabEstabelecimentos.Reset;
        if TabEstabelecimentos.Get(Rec."Cod. Estabelecimento") then
            Rec.CAE := TabEstabelecimentos."CAE Code";
    end;

    var
        TabEstabelecimentos: Record "Estabelecimentos da Empresa";
}

#pragma implicitwith restore

