
#pragma implicitwith disable
page 53151 "Acidentes de Trabalho"
{
    PageType = List;
    SourceTable = "Acidentes de Trabalho";
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field("Employee No."; Rec."Employee No.")
                {


                }
                field(Nome; Rec.Nome)
                {


                }
                field("Data Acidente"; Rec."Data Acidente")
                {


                }
                field("Hora Acidente"; Rec."Hora Acidente")
                {


                }
                field("Local Acidente"; Rec."Local Acidente")
                {


                }
                field("Cód. Localização"; Rec."Cód. Localização")
                {


                }
                field("Localização"; Rec."Localização")
                {


                }
                field("Descrição Acidente"; Rec."Descrição Acidente")
                {


                }
                field("Dias de trabalho perdidos"; Rec."Dias de trabalho perdidos")
                {


                }
                field("Data ínicio da interrupção"; Rec."Data ínicio da interrupção")
                {


                }
                field("Data fim da interrupção"; Rec."Data fim da interrupção")
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

