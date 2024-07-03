page 31003089 "Tipos Horas Extra"
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
                field("Código"; Código)
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Descrição)
                {
                    ApplicationArea = All;

                }
                field("Cód. Rubrica"; "Cód. Rubrica")
                {
                    ApplicationArea = All;

                }
                field(Factor; Factor)
                {
                    ApplicationArea = All;

                }
                field("Lei n. 7/2009 de 12 Fevereiro"; "Lei n. 7/2009 de 12 Fevereiro")
                {
                    ApplicationArea = All;

                }
                field("Dia semanal"; "Dia semanal")
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

