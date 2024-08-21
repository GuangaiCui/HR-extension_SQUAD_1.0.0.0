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
                    ;

                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Médicos do Trabalho"; Rec."Médicos do Trabalho")
                {
                    ;

                }
                field(Enfermeiros; Rec.Enfermeiros)
                {
                    ;

                }
                field("Técnicos Superiores de SHT"; Rec."Técnicos Superiores de SHT")
                {
                    ;

                }
                field("Técnicos de SHT"; Rec."Técnicos de SHT")
                {
                    ;

                }
                field("Outro Pessoal"; Rec."Outro Pessoal")
                {
                    ;

                }
                field("Nome Dir/Resp dos Serviços Seg"; Rec."Nome Dir/Resp dos Serviços Seg")
                {
                    ;

                }
                field("Seg. - NIF"; Rec."Seg. - NIF")
                {
                    ;

                }
                field("Nome Dir/Resp dos Serviços Saú"; Rec."Nome Dir/Resp dos Serviços Saú")
                {
                    ;

                }
                field("Saúde - NIF"; Rec."Saúde - NIF")
                {
                    ;

                }
                field("Nome Empregador"; Rec."Nome Empregador")
                {
                    ;

                }
                field("Emp. - No. Autorização"; Rec."Emp. - No. Autorização")
                {
                    ;

                }
                field("Nome Trabalhador Designado"; Rec."Nome Trabalhador Designado")
                {
                    ;

                }
                field("Trab. - No. Autorização"; Rec."Trab. - No. Autorização")
                {
                    ;

                }
                field("Nome Representante do Emp."; Rec."Nome Representante do Emp.")
                {
                    ;

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
                    ;

                    Caption = 'Internos';
                    Image = SalesPurchaseTeam;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Pessoal dos Serviços Internos";
                    RunPageLink = Ano = FIELD(Ano);
                }
                action(Externos)
                {
                    ;

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

