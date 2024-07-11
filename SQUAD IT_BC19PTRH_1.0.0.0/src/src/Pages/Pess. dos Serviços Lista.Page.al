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

#pragma implicitwith restore

