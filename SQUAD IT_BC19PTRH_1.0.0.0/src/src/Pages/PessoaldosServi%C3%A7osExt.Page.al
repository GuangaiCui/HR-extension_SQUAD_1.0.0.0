page 31003141 "Pessoal dos Serviços Ext"
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
                field("Tipo Serviço"; "Tipo Serviço")
                {
                    ApplicationArea = All;

                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
                field("Denominação Serv. Externo"; "Denominação Serv. Externo")
                {
                    ApplicationArea = All;

                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
                field(NIF; NIF)
                {
                    ApplicationArea = All;

                }
                field("Tipo de Empresa"; "Tipo de Empresa")
                {
                    ApplicationArea = All;

                }
                field("Desc. do Tipo de Empresa"; "Desc. do Tipo de Empresa")
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

