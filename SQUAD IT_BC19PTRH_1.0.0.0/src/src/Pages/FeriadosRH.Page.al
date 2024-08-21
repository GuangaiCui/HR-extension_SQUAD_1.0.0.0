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


                }
                field("Descritivo feriado"; Rec."Descritivo feriado")
                {


                    Caption = 'Descritivo do feriado';
                }
                field(Nacional; Rec.Nacional)
                {


                }
                field(Estabelecimento; Rec.Estabelecimento)
                {


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

