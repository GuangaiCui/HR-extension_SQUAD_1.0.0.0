#pragma implicitwith disable
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
                field("No. Empregado"; Rec."No. Empregado")
                {
                    ApplicationArea = All;

                }
                field(Data; Rec.Data)
                {
                    ApplicationArea = All;

                }
                field(Tipo; Rec.Tipo)
                {
                    ApplicationArea = All;

                }
                field("Ano a que se refere"; Rec."Ano a que se refere")
                {
                    ApplicationArea = All;

                }
                field("Qtd."; Rec."Qtd.")
                {
                    ApplicationArea = All;

                }
                field(Gozada; Rec.Gozada)
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

#pragma implicitwith restore

