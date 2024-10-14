#pragma implicitwith disable
page 53144 "Factores de Risco"
{
    PageType = List;
    SourceTable = "Factores de Risco";
    ApplicationArea = HumanResourcesAppArea;
    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field(Data; Rec.Data)
                {


                }
                field("Tipo de Risco"; Rec."Tipo de Risco")
                {


                }
                field(Agente; Rec.Agente)
                {


                }
                field("No. Trab. Expostos H"; Rec."No. Trab. Expostos H")
                {


                }
                field("No. Trab. Expostos M"; Rec."No. Trab. Expostos M")
                {


                }
                field("No. Avaliações Efectuadas"; Rec."No. Avaliações Efectuadas")
                {


                }
                field("No. Ordem - Código"; Rec."No. Ordem - Código")
                {


                }
                field("Identificação do Agente"; Rec."Identificação do Agente")
                {


                }
                field("Menção ou Frase de Risco"; Rec."Menção ou Frase de Risco")
                {


                }
                field("Classificação do Agente"; Rec."Classificação do Agente")
                {


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


                Caption = 'Medidas Adoptadas';
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Medidas Adoptadas";
                RunPageLink = "Entry No." = FIELD("Entry No.");
            }
        }
    }
}

#pragma implicitwith restore

