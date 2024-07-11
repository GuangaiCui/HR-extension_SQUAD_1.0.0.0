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
                    ApplicationArea = All;

                }
                field("Descrição"; Rec."Descrição")
                {
                    ApplicationArea = All;

                }
                field("Cód. Rubrica"; Rec."Cód. Rubrica")
                {
                    ApplicationArea = All;

                }
                field(Factor; Rec.Factor)
                {
                    ApplicationArea = All;

                }
                field("Lei n. 7/2009 de 12 Fevereiro"; Rec."Lei n. 7/2009 de 12 Fevereiro")
                {
                    ApplicationArea = All;

                }
                field("Dia semanal"; Rec."Dia semanal")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

