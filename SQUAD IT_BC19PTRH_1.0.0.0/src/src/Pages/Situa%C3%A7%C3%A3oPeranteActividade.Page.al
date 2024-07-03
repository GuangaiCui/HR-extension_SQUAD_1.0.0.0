page 31003157 "Situação Perante Actividade"
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
                field("Situação"; Situação)
                {
                    ApplicationArea = All;

                }
                field("Desc. Situação"; "Desc. Situação")
                {
                    ApplicationArea = All;

                }
                field(Motivo; Motivo)
                {
                    ApplicationArea = All;

                }
                field("Desc. Motivo"; "Desc. Motivo")
                {
                    ApplicationArea = All;

                }
                field("Data Início"; "Data Início")
                {
                    ApplicationArea = All;

                }
                field("Data Fim"; "Data Fim")
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
        if TabEstabelecimentos.Get("Cod. Estabelecimento") then
            CAE := TabEstabelecimentos."CAE Code";
    end;

    var
        TabEstabelecimentos: Record "Estabelecimentos da Empresa";
}

