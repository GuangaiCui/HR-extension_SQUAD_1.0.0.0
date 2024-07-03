page 53139 "Pessoal dos Serviços"
{
    Caption = 'Pessoal dos Serviços';
    PageType = Card;
    SourceTable = "Pessoal dos Serviços";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            group(Control31022890)
            {
                Caption = 'General';
                field(Ano; Ano)
                {
                    ApplicationArea = All;

                    Style = Strong;
                    StyleExpr = TRUE;
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
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Pessoal dos Serviços")
            {
                Caption = 'Pessoal dos Serviços';
                action(Internos)
                {
                    ApplicationArea = All;

                    Caption = 'Internos';
                    Image = SalesPurchaseTeam;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Pessoal dos Serviços Internos";
                    RunPageLink = Ano = FIELD(Ano);
                }
                action(Externos)
                {
                    ApplicationArea = All;

                    Caption = 'Externos';
                    Image = SalesPurchaseTeam;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Pessoal dos Serviços Ext";
                    RunPageLink = Ano = FIELD(Ano);
                }
            }
        }
    }
}

