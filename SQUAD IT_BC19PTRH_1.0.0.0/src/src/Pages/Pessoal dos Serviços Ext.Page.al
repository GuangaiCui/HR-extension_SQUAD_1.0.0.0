#pragma implicitwith disable
page 53141 "Pessoal dos Serviços Ext"
{
    AutoSplitKey = true;
    Caption = 'Pessoal dos Serviços Externos';
    PageType = List;
    SourceTable = "Pessoal dos Serviços Ext";

    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field("Tipo Serviço"; Rec."Tipo Serviço")
                {
                    ApplicationArea = All;

                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
                field("Denominação Serv. Externo"; Rec."Denominação Serv. Externo")
                {
                    ApplicationArea = All;

                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
                field(NIF; Rec.NIF)
                {
                    ApplicationArea = All;

                }
                field("Tipo de Empresa"; Rec."Tipo de Empresa")
                {
                    ApplicationArea = All;

                }
                field("Desc. do Tipo de Empresa"; Rec."Desc. do Tipo de Empresa")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

