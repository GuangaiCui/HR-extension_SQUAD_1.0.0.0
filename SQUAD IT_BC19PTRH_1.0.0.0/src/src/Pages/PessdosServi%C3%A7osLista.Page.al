page 53154 "Pess. dos Serviços Lista"
{
    CardPageID = "Pessoal dos Serviços";
    Editable = false;
    PageType = List;
    SourceTable = "Pessoal dos Serviços";
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field(Ano; Ano)
                {
                    ApplicationArea = All;

                }
                field("Nome Dir/Resp dos Serviços Seg"; "Nome Dir/Resp dos Serviços Seg")
                {
                    ApplicationArea = All;

                }
                field("Seg. - NIF"; "Seg. - NIF")
                {
                    ApplicationArea = All;

                }
                field("Nome Dir/Resp dos Serviços Saú"; "Nome Dir/Resp dos Serviços Saú")
                {
                    ApplicationArea = All;

                }
                field("Saúde - NIF"; "Saúde - NIF")
                {
                    ApplicationArea = All;

                }
                field("Nome Empregador"; "Nome Empregador")
                {
                    ApplicationArea = All;

                }
                field("Emp. - No. Autorização"; "Emp. - No. Autorização")
                {
                    ApplicationArea = All;

                }
                field("Nome Trabalhador Designado"; "Nome Trabalhador Designado")
                {
                    ApplicationArea = All;

                }
                field("Trab. - No. Autorização"; "Trab. - No. Autorização")
                {
                    ApplicationArea = All;

                }
                field("Nome Representante do Emp."; "Nome Representante do Emp.")
                {
                    ApplicationArea = All;

                }
                field("Médicos do Trabalho"; "Médicos do Trabalho")
                {
                    ApplicationArea = All;

                }
                field(Enfermeiros; Enfermeiros)
                {
                    ApplicationArea = All;

                }
                field("Técnicos Superiores de SHT"; "Técnicos Superiores de SHT")
                {
                    ApplicationArea = All;

                }
                field("Técnicos de SHT"; "Técnicos de SHT")
                {
                    ApplicationArea = All;

                }
                field("Outro Pessoal"; "Outro Pessoal")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Pessoal dos Serviços")
            {
                Caption = '&Pessoal dos Serviços';
                action(Ficha)
                {
                    ApplicationArea = All;

                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Pessoal dos Serviços";
                    RunPageLink = Ano = FIELD(Ano);
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }
}

