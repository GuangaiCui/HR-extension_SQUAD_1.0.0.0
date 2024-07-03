page 31003114 "Feriados RH"
{
    Caption = 'Human Resource Units of Measure';
    PageType = List;
    SourceTable = "Feriados RH";
    ApplicationArea = HumanResourcesAppArea;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Data; Data)
                {
                    ApplicationArea = All;

                }
                field("Descritivo feriado"; "Descritivo feriado")
                {
                    ApplicationArea = All;

                    Caption = 'Descritivo do feriado';
                }
                field(Nacional; Nacional)
                {
                    ApplicationArea = All;

                }
                field(Estabelecimento; Estabelecimento)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        SetCurrentKey(Data);
    end;
}

