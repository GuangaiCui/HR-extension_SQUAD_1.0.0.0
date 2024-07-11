#pragma implicitwith disable
page 53114 "Feriados RH"
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
                field(Data; Rec.Data)
                {
                    ApplicationArea = All;

                }
                field("Descritivo feriado"; Rec."Descritivo feriado")
                {
                    ApplicationArea = All;

                    Caption = 'Descritivo do feriado';
                }
                field(Nacional; Rec.Nacional)
                {
                    ApplicationArea = All;

                }
                field(Estabelecimento; Rec.Estabelecimento)
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
        Rec.SetCurrentKey(Data);
    end;
}

#pragma implicitwith restore

