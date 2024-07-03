page 53111 "Estabelecimentos da Empresa"
{
    AutoSplitKey = false;
    PageType = List;
    RefreshOnActivate = false;
    SourceTable = "Estabelecimentos da Empresa";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field(Sede; Sede)
                {
                    ApplicationArea = All;

                }
                field("ID Unidade Local"; "ID Unidade Local")
                {
                    ApplicationArea = All;

                }
                field("Número da Unidade Local"; "Número da Unidade Local")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Descrição)
                {
                    ApplicationArea = All;

                }
                field(Morada; Morada)
                {
                    ApplicationArea = All;

                }
                field(Localidade; Localidade)
                {
                    ApplicationArea = All;

                }
                field("Cód. Postal"; "Cód. Postal")
                {
                    ApplicationArea = All;

                }
                field(Cidade; Cidade)
                {
                    ApplicationArea = All;

                }
                field("Cód. Distrito/Concelho/Freg."; "Cód. Distrito/Concelho/Freg.")
                {
                    ApplicationArea = All;

                }
                field("Descrição Freguesia"; "Descrição Freguesia")
                {
                    ApplicationArea = All;

                }
                field("País"; País)
                {
                    ApplicationArea = All;

                }
                field(Telefone; Telefone)
                {
                    ApplicationArea = All;

                }
                field(Fax; Fax)
                {
                    ApplicationArea = All;

                }
                field("E-mail"; "E-mail")
                {
                    ApplicationArea = All;

                }
                field("Data Inicio"; "Data Inicio")
                {
                    ApplicationArea = All;

                }
                field("CAE Code"; "CAE Code")
                {
                    ApplicationArea = All;

                }
                field("CAE Description"; "CAE Description")
                {
                    ApplicationArea = All;

                }
                field("Instituição Seg. Social"; "Instituição Seg. Social")
                {
                    ApplicationArea = All;

                }
                field("Região"; Região)
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
            action("Situação perante actividade")
            {
                ApplicationArea = All;

                Caption = 'Situação perante actividade';
                Image = Answers;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Situação Perante Actividade";
                RunPageLink = "Cod. Estabelecimento" = FIELD("Número da Unidade Local");
            }
        }
    }
}

