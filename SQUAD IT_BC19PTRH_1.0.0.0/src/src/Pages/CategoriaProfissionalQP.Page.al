#pragma implicitwith disable
page 53076 "Categoria Profissional QP"
{
    PageType = List;
    SourceTable = "Categoria Profissional QP";

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Código"; Rec."Código")
                {


                }
                field("Descrição"; Rec."Descrição")
                {


                }
                field("No. Empregados"; Rec."No. Empregados")
                {


                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //HG 11.07.05
        //Isto serve para filtrar as cat. Prof para que só apareçam os que estão em vigor
        //ou seja, os que têm a data de inicio anterior à Workdate
        // e que têm a data de fim  posterior à workdate
        Rec.SetFilter("Data Filtro Inicio", '<=%1', WorkDate);
        Rec.SetFilter("Data Filtro Fim", '>=%1|%2', WorkDate, 0D);
        //HG - Fim
    end;
}

#pragma implicitwith restore

