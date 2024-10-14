#pragma implicitwith disable
page 53141 "Pessoal dos Serviços Ext"
{
    AutoSplitKey = true;
    Caption = 'Pessoal dos Serviços Externos';
    PageType = List;
    SourceTable = "Pessoal dos Serviços Ext";
    ApplicationArea = HumanResourcesAppArea;
    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field("Tipo Serviço"; Rec."Tipo Serviço")
                {


                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
                field("Denominação Serv. Externo"; Rec."Denominação Serv. Externo")
                {


                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
                field(NIF; Rec.NIF)
                {


                }
                field("Tipo de Empresa"; Rec."Tipo de Empresa")
                {


                }
                field("Desc. do Tipo de Empresa"; Rec."Desc. do Tipo de Empresa")
                {


                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

