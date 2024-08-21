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


                }
                field("Desc. Situação"; Rec."Desc. Situação")
                {


                }
                field(Motivo; Rec.Motivo)
                {


                }
                field("Desc. Motivo"; Rec."Desc. Motivo")
                {


                }
                field("Data Início"; Rec."Data Início")
                {


                }
                field("Data Fim"; Rec."Data Fim")
                {


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

