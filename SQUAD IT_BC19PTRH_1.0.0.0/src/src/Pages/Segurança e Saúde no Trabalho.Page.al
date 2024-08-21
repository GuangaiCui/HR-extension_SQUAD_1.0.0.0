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


                Style = Strong;
                StyleExpr = TRUE;
            }
            group("Organização dos Serviços")
            {
                Caption = 'Organização dos Serviços';
                field("Foram Organizados Serv. Seg. T"; Rec."Foram Organizados Serv. Seg. T")
                {


                }
                field("Foram Organizados Serv. Sau. T"; Rec."Foram Organizados Serv. Sau. T")
                {


                }
                field("No. Trabalhadores Afectos"; Rec."No. Trabalhadores Afectos")
                {


                }
                field("Actividades SST Organizadas"; Rec."Actividades SST Organizadas")
                {


                }
                field("Foram Completados os Serv."; Rec."Foram Completados os Serv.")
                {


                }
                group("Modalidade no domínio da Segurança")
                {
                    Caption = 'Modalidade no domínio da Segurança';
                    field("Seg-Serviço Interno"; Rec."Seg-Serviço Interno")
                    {


                    }
                    field("Seg-Serviço Comum/Partilhado"; Rec."Seg-Serviço Comum/Partilhado")
                    {


                    }
                    field("Seg-Serviço Externo"; Rec."Seg-Serviço Externo")
                    {


                    }
                    field("Seg-Act. Exer. pelo Empregador"; Rec."Seg-Act. Exer. pelo Empregador")
                    {


                    }
                    field("Seg-Act. Exer. pelo Trabalhado"; Rec."Seg-Act. Exer. pelo Trabalhado")
                    {


                    }
                }
                group("Modalidade no domínio da Saúde")
                {
                    Caption = 'Modalidade no domínio da Saúde';
                    field("Sau-Serviço Interno"; Rec."Sau-Serviço Interno")
                    {


                    }
                    field("Sau-Serviço Comum/Partilhado"; Rec."Sau-Serviço Comum/Partilhado")
                    {


                    }
                    field("Sau-Serviço Externo"; Rec."Sau-Serviço Externo")
                    {


                    }
                    field("Sau-Ser. Nac/Reg de Saúde"; Rec."Sau-Ser. Nac/Reg de Saúde")
                    {


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


                    }
                    field("Enc. Org./Mod. dos Espaços"; Rec."Enc. Org./Mod. dos Espaços")
                    {


                    }
                    field("Enc. Aquisição Bens e Equipame"; Rec."Enc. Aquisição Bens e Equipame")
                    {


                    }
                }
                field("Enc. Formação, Inf. e Consulta"; Rec."Enc. Formação, Inf. e Consulta")
                {


                }
                field("Enc. Outros"; Rec."Enc. Outros")
                {


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

