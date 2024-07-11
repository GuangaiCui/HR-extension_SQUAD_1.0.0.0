
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
                field("No. Empregado"; Rec."No. Empregado")
                {
                    ApplicationArea = All;

                }
                field(Nome; Rec.Nome)
                {
                    ApplicationArea = All;

                }
                field("Data Acidente"; Rec."Data Acidente")
                {
                    ApplicationArea = All;

                }
                field("Hora Acidente"; Rec."Hora Acidente")
                {
                    ApplicationArea = All;

                }
                field("Local Acidente"; Rec."Local Acidente")
                {
                    ApplicationArea = All;

                }
                field("Cód. Localização"; Rec."Cód. Localização")
                {
                    ApplicationArea = All;

                }
                field("Localização"; Rec."Localização")
                {
                    ApplicationArea = All;

                }
                field("Descrição Acidente"; Rec."Descrição Acidente")
                {
                    ApplicationArea = All;

                }
                field("Dias de trabalho perdidos"; Rec."Dias de trabalho perdidos")
                {
                    ApplicationArea = All;

                }
                field("Data ínicio da interrupção"; Rec."Data ínicio da interrupção")
                {
                    ApplicationArea = All;

                }
                field("Data fim da interrupção"; Rec."Data fim da interrupção")
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

