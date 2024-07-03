page 31003059 "Lista Tabela IRS"
{
    Editable = false;
    PageType = List;
    SourceTable = "Tabela IRS";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field(Ano; Ano)
                {
                    ApplicationArea = All;

                }
                field("Região"; Região)
                {
                    ApplicationArea = All;

                }
                field("Até"; Até)
                {
                    ApplicationArea = All;

                }
                field(Tabela; Tabela)
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Descrição)
                {
                    ApplicationArea = All;

                }
                field(Valor; Valor)
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

