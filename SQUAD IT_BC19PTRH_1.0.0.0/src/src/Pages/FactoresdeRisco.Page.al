page 31003144 "Factores de Risco"
{
    PageType = List;
    SourceTable = "Factores de Risco";

    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field(Data; Data)
                {
                    ApplicationArea = All;

                }
                field("Tipo de Risco"; "Tipo de Risco")
                {
                    ApplicationArea = All;

                }
                field(Agente; Agente)
                {
                    ApplicationArea = All;

                }
                field("No. Trab. Expostos H"; "No. Trab. Expostos H")
                {
                    ApplicationArea = All;

                }
                field("No. Trab. Expostos M"; "No. Trab. Expostos M")
                {
                    ApplicationArea = All;

                }
                field("No. Avaliações Efectuadas"; "No. Avaliações Efectuadas")
                {
                    ApplicationArea = All;

                }
                field("No. Ordem - Código"; "No. Ordem - Código")
                {
                    ApplicationArea = All;

                }
                field("Identificação do Agente"; "Identificação do Agente")
                {
                    ApplicationArea = All;

                }
                field("Menção ou Frase de Risco"; "Menção ou Frase de Risco")
                {
                    ApplicationArea = All;

                }
                field("Classificação do Agente"; "Classificação do Agente")
                {
                    ApplicationArea = All;

                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Medidas Adoptadas")
            {
                ApplicationArea = All;

                Caption = 'Medidas Adoptadas';
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Medidas Adoptadas";
                RunPageLink = "No. Mov." = FIELD("No. Mov.");
            }
        }
    }
}

