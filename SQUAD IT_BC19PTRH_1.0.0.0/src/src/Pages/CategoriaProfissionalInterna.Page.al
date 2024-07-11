#pragma implicitwith disable
page 53074 "Categoria Profissional Interna"
{
    PageType = List;
    SourceTable = "Categoria Profissional Interna";

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Código"; Rec."Código")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Rec."Descrição")
                {
                    ApplicationArea = All;

                }
                field("No. Empregados"; Rec."No. Empregados")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter("Data Filtro Inicio", '<=%1', WorkDate);
        Rec.SetFilter("Data Filtro Fim", '>=%1|%2', WorkDate, 0D);
    end;
}

#pragma implicitwith restore

