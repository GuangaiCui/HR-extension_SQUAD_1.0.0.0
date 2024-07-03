page 31003151 "Acidentes de Trabalho"
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
                field("No. Empregado"; "No. Empregado")
                {
                    ApplicationArea = All;

                }
                field(Nome; Nome)
                {
                    ApplicationArea = All;

                }
                field("Data Acidente"; "Data Acidente")
                {
                    ApplicationArea = All;

                }
                field("Hora Acidente"; "Hora Acidente")
                {
                    ApplicationArea = All;

                }
                field("Local Acidente"; "Local Acidente")
                {
                    ApplicationArea = All;

                }
                field("Cód. Localização"; "Cód. Localização")
                {
                    ApplicationArea = All;

                }
                field("Localização"; Localização)
                {
                    ApplicationArea = All;

                }
                field("Descrição Acidente"; "Descrição Acidente")
                {
                    ApplicationArea = All;

                }
                field("Dias de trabalho perdidos"; "Dias de trabalho perdidos")
                {
                    ApplicationArea = All;

                }
                field("Data ínicio da interrupção"; "Data ínicio da interrupção")
                {
                    ApplicationArea = All;

                }
                field("Data fim da interrupção"; "Data fim da interrupção")
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

