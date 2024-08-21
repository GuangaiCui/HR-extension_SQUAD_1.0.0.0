#pragma implicitwith disable
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
                field(Ano; Rec.Ano)
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
                    ;

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

#pragma implicitwith restore

