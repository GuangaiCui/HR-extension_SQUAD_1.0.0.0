page 53119 "Lista Férias Empregado"
{
    PageType = List;
    SourceTable = "Férias Empregados";
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("No. Empregado"; "No. Empregado")
                {
                    ApplicationArea = All;

                }
                field(Data; Data)
                {
                    ApplicationArea = All;

                }
                field(Tipo; Tipo)
                {
                    ApplicationArea = All;

                }
                field("Ano a que se refere"; "Ano a que se refere")
                {
                    ApplicationArea = All;

                }
                field("Qtd."; "Qtd.")
                {
                    ApplicationArea = All;

                }
                field(Gozada; Gozada)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Marcação por períodos")
            {
                ApplicationArea = All;

                Caption = 'Marcação por períodos';
                Image = Holiday;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    REPORT.Run(53092);
                end;
            }
        }
    }
}

