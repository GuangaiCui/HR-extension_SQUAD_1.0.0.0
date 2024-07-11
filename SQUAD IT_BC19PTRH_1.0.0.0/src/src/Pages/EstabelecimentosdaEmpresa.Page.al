#pragma implicitwith disable
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
                field(Sede; Rec.Sede)
                {
                    ApplicationArea = All;

                }
                field("ID Unidade Local"; Rec."ID Unidade Local")
                {
                    ApplicationArea = All;

                }
                field("Número da Unidade Local"; Rec."Número da Unidade Local")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Rec."Descrição")
                {
                    ApplicationArea = All;

                }
                field(Morada; Rec.Morada)
                {
                    ApplicationArea = All;

                }
                field(Localidade; Rec.Localidade)
                {
                    ApplicationArea = All;

                }
                field("Cód. Postal"; Rec."Cód. Postal")
                {
                    ApplicationArea = All;

                }
                field(Cidade; Rec.Cidade)
                {
                    ApplicationArea = All;

                }
                field("Cód. Distrito/Concelho/Freg."; Rec."Cód. Distrito/Concelho/Freg.")
                {
                    ApplicationArea = All;

                }
                field("Descrição Freguesia"; Rec."Descrição Freguesia")
                {
                    ApplicationArea = All;

                }
                field("País"; Rec."País")
                {
                    ApplicationArea = All;

                }
                field(Telefone; Rec.Telefone)
                {
                    ApplicationArea = All;

                }
                field(Fax; Rec.Fax)
                {
                    ApplicationArea = All;

                }
                field("E-mail"; Rec."E-mail")
                {
                    ApplicationArea = All;

                }
                field("Data Inicio"; Rec."Data Inicio")
                {
                    ApplicationArea = All;

                }
                field("CAE Code"; Rec."CAE Code")
                {
                    ApplicationArea = All;

                }
                field("CAE Description"; Rec."CAE Description")
                {
                    ApplicationArea = All;

                }
                field("Instituição Seg. Social"; Rec."Instituição Seg. Social")
                {
                    ApplicationArea = All;

                }
                field("Região"; Rec."Região")
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

#pragma implicitwith restore

