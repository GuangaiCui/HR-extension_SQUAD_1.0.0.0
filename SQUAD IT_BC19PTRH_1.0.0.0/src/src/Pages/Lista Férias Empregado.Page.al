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
                field("Employee No."; Rec."Employee No.")
                {


                }
                field(Data; Rec.Data)
                {


                }
                field(Tipo; Rec.Tipo)
                {


                }
                field("Ano a que se refere"; Rec."Ano a que se refere")
                {


                }
                field("Qtd."; Rec."Qtd.")
                {


                }
                field(Gozada; Rec.Gozada)
                {


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

