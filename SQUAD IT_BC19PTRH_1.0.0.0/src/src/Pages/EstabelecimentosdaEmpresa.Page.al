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


                }
                field("ID Unidade Local"; Rec."ID Unidade Local")
                {


                }
                field("Número da Unidade Local"; Rec."Número da Unidade Local")
                {


                }
                field("Descrição"; Rec."Descrição")
                {


                }
                field(Morada; Rec.Morada)
                {


                }
                field(Localidade; Rec.Localidade)
                {


                }
                field("Cód. Postal"; Rec."Cód. Postal")
                {


                }
                field(Cidade; Rec.Cidade)
                {


                }
                field("Cód. Distrito/Concelho/Freg."; Rec."Cód. Distrito/Concelho/Freg.")
                {


                }
                field("Descrição Freguesia"; Rec."Descrição Freguesia")
                {


                }
                field("País"; Rec."País")
                {


                }
                field(Telefone; Rec.Telefone)
                {


                }
                field(Fax; Rec.Fax)
                {


                }
                field("E-mail"; Rec."E-mail")
                {


                }
                field("Data Inicio"; Rec."Data Inicio")
                {


                }
                field("CAE Code"; Rec."CAE Code")
                {


                }
                field("CAE Description"; Rec."CAE Description")
                {


                }
                field("Instituição Seg. Social"; Rec."Instituição Seg. Social")
                {


                }
                field("Região"; Rec."Região")
                {


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

