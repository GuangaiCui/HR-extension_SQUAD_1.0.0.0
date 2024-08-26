#pragma implicitwith disable
page 53089 "Tipos Horas Extra"
{
    PageType = List;
    SourceTable = "Tipos Horas Extra";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

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
                field("Cód. Rubrica"; Rec."Cód. Rubrica")
                {


                }
                field(Factor; Rec.Factor)
                {


                }
                field("Lei n. 7/2009 de 12 Fevereiro"; Rec."Lei n. 7/2009 de 12 Fevereiro")
                {


                }
                field("Dia semanal"; Rec."Dia semanal")
                {


                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

