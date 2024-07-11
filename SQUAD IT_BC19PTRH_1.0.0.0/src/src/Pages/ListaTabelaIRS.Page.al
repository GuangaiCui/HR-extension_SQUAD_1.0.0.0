#pragma implicitwith disable
page 53059 "Lista Tabela IRS"
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
                field(Ano; Rec.Ano)
                {
                    ApplicationArea = All;

                }
                field("Região"; Rec."Região")
                {
                    ApplicationArea = All;

                }
                field("Até"; Rec."Até")
                {
                    ApplicationArea = All;

                }
                field(Tabela; Rec.Tabela)
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Rec."Descrição")
                {
                    ApplicationArea = All;

                }
                field(Valor; Rec.Valor)
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

