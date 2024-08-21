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
                    ;

                }
                field("Região"; Rec."Região")
                {
                    ;

                }
                field("Até"; Rec."Até")
                {
                    ;

                }
                field(Tabela; Rec.Tabela)
                {
                    ;

                }
                field("Descrição"; Rec."Descrição")
                {
                    ;

                }
                field(Valor; Rec.Valor)
                {
                    ;

                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

