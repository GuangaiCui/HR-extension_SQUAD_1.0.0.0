#pragma implicitwith disable
page 53086 "Código IRCT"
{
    PageType = List;
    SourceTable = "Código IRCT";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Código IRCT"; Rec."Código IRCT")
                {
                    ApplicationArea = All;

                }
                field("Acordo Colectivo"; Rec."Acordo Colectivo")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Rec."Descrição")
                {
                    ApplicationArea = All;

                }
                field("No. Boletim do Trabalho"; Rec."No. Boletim do Trabalho")
                {
                    ApplicationArea = All;

                }
                field("Data Publicação"; Rec."Data Publicação")
                {
                    ApplicationArea = All;

                }
                field("Data da última Tabela Salarial"; Rec."Data da última Tabela Salarial")
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

