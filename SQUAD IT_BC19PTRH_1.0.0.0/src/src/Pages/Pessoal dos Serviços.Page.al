#pragma implicitwith disable
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
                field(Ano; Rec.Ano)
                {
                    ApplicationArea = All;

                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Médicos do Trabalho"; Rec."Médicos do Trabalho")
                {
                    ApplicationArea = All;

                }
                field(Enfermeiros; Rec.Enfermeiros)
                {
                    ApplicationArea = All;

                }
                field("Técnicos Superiores de SHT"; Rec."Técnicos Superiores de SHT")
                {
                    ApplicationArea = All;

                }
                field("Técnicos de SHT"; Rec."Técnicos de SHT")
                {
                    ApplicationArea = All;

                }
                field("Outro Pessoal"; Rec."Outro Pessoal")
                {
                    ApplicationArea = All;

                }
                field("Nome Dir/Resp dos Serviços Seg"; Rec."Nome Dir/Resp dos Serviços Seg")
                {
                    ApplicationArea = All;

                }
                field("Seg. - NIF"; Rec."Seg. - NIF")
                {
                    ApplicationArea = All;

                }
                field("Nome Dir/Resp dos Serviços Saú"; Rec."Nome Dir/Resp dos Serviços Saú")
                {
                    ApplicationArea = All;

                }
                field("Saúde - NIF"; Rec."Saúde - NIF")
                {
                    ApplicationArea = All;

                }
                field("Nome Empregador"; Rec."Nome Empregador")
                {
                    ApplicationArea = All;

                }
                field("Emp. - No. Autorização"; Rec."Emp. - No. Autorização")
                {
                    ApplicationArea = All;

                }
                field("Nome Trabalhador Designado"; Rec."Nome Trabalhador Designado")
                {
                    ApplicationArea = All;

                }
                field("Trab. - No. Autorização"; Rec."Trab. - No. Autorização")
                {
                    ApplicationArea = All;

                }
                field("Nome Representante do Emp."; Rec."Nome Representante do Emp.")
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

#pragma implicitwith restore

