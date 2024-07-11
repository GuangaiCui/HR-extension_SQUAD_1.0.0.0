#pragma implicitwith disable
page 53129 "Segurança e Saúde no Trabalho"
{
    PageType = Card;
    SourceTable = "Segurança e Saúde no Trabalho";
    UsageCategory = Tasks;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            field(Ano; Rec.Ano)
            {
                ApplicationArea = All;

                Style = Strong;
                StyleExpr = TRUE;
            }
            group("Organização dos Serviços")
            {
                Caption = 'Organização dos Serviços';
                field("Foram Organizados Serv. Seg. T"; Rec."Foram Organizados Serv. Seg. T")
                {
                    ApplicationArea = All;

                }
                field("Foram Organizados Serv. Sau. T"; Rec."Foram Organizados Serv. Sau. T")
                {
                    ApplicationArea = All;

                }
                field("No. Trabalhadores Afectos"; Rec."No. Trabalhadores Afectos")
                {
                    ApplicationArea = All;

                }
                field("Actividades SST Organizadas"; Rec."Actividades SST Organizadas")
                {
                    ApplicationArea = All;

                }
                field("Foram Completados os Serv."; Rec."Foram Completados os Serv.")
                {
                    ApplicationArea = All;

                }
                group("Modalidade no domínio da Segurança")
                {
                    Caption = 'Modalidade no domínio da Segurança';
                    field("Seg-Serviço Interno"; Rec."Seg-Serviço Interno")
                    {
                        ApplicationArea = All;

                    }
                    field("Seg-Serviço Comum/Partilhado"; Rec."Seg-Serviço Comum/Partilhado")
                    {
                        ApplicationArea = All;

                    }
                    field("Seg-Serviço Externo"; Rec."Seg-Serviço Externo")
                    {
                        ApplicationArea = All;

                    }
                    field("Seg-Act. Exer. pelo Empregador"; Rec."Seg-Act. Exer. pelo Empregador")
                    {
                        ApplicationArea = All;

                    }
                    field("Seg-Act. Exer. pelo Trabalhado"; Rec."Seg-Act. Exer. pelo Trabalhado")
                    {
                        ApplicationArea = All;

                    }
                }
                group("Modalidade no domínio da Saúde")
                {
                    Caption = 'Modalidade no domínio da Saúde';
                    field("Sau-Serviço Interno"; Rec."Sau-Serviço Interno")
                    {
                        ApplicationArea = All;

                    }
                    field("Sau-Serviço Comum/Partilhado"; Rec."Sau-Serviço Comum/Partilhado")
                    {
                        ApplicationArea = All;

                    }
                    field("Sau-Serviço Externo"; Rec."Sau-Serviço Externo")
                    {
                        ApplicationArea = All;

                    }
                    field("Sau-Ser. Nac/Reg de Saúde"; Rec."Sau-Ser. Nac/Reg de Saúde")
                    {
                        ApplicationArea = All;

                    }
                }
            }
            group(Encargos)
            {
                Caption = 'Encargos';
                group("Encargos no Âmbito da Segurança e Saúde no Trabalho")
                {
                    Caption = 'Encargos no Âmbito da Segurança e Saúde no Trabalho';
                    field("Enc. Org.Serv. SST"; Rec."Enc. Org.Serv. SST")
                    {
                        ApplicationArea = All;

                    }
                    field("Enc. Org./Mod. dos Espaços"; Rec."Enc. Org./Mod. dos Espaços")
                    {
                        ApplicationArea = All;

                    }
                    field("Enc. Aquisição Bens e Equipame"; Rec."Enc. Aquisição Bens e Equipame")
                    {
                        ApplicationArea = All;

                    }
                }
                field("Enc. Formação, Inf. e Consulta"; Rec."Enc. Formação, Inf. e Consulta")
                {
                    ApplicationArea = All;

                }
                field("Enc. Outros"; Rec."Enc. Outros")
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
            group("&Org. Serviços")
            {
                Caption = '&Org. Serviços';
                action("Organização Serviços")
                {
                    ApplicationArea = All;

                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Org. dos Serviços Lista";
                    ShortCutKey = 'Shift+Ctrl+L';
                }
            }
        }
    }
}

#pragma implicitwith restore

