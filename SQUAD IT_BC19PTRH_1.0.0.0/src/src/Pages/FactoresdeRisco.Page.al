#pragma implicitwith disable
page 53144 "Factores de Risco"
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
                field(Data; Rec.Data)
                {
                    ApplicationArea = All;

                }
                field("Tipo de Risco"; Rec."Tipo de Risco")
                {
                    ApplicationArea = All;

                }
                field(Agente; Rec.Agente)
                {
                    ApplicationArea = All;

                }
                field("No. Trab. Expostos H"; Rec."No. Trab. Expostos H")
                {
                    ApplicationArea = All;

                }
                field("No. Trab. Expostos M"; Rec."No. Trab. Expostos M")
                {
                    ApplicationArea = All;

                }
                field("No. Avaliações Efectuadas"; Rec."No. Avaliações Efectuadas")
                {
                    ApplicationArea = All;

                }
                field("No. Ordem - Código"; Rec."No. Ordem - Código")
                {
                    ApplicationArea = All;

                }
                field("Identificação do Agente"; Rec."Identificação do Agente")
                {
                    ApplicationArea = All;

                }
                field("Menção ou Frase de Risco"; Rec."Menção ou Frase de Risco")
                {
                    ApplicationArea = All;

                }
                field("Classificação do Agente"; Rec."Classificação do Agente")
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

#pragma implicitwith restore

