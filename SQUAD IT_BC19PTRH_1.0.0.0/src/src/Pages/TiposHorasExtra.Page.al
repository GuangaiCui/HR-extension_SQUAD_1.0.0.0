#pragma implicitwith disable
page 53089 "Tipos Horas Extra"
{
    PageType = List;
    SourceTable = "Tipos Horas Extra";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Código"; Rec."Code")
                {


                }
                field("Descrição"; Rec.Description)
                {


                }
                field("Payroll Item Code"; Rec."Payroll Item Code")
                {


                }
                field(Factor; Rec.Factor)
                {


                }
                field("Lei n. 7/2009 de 12 Fevereiro"; Rec."Lei n. 7/2009 de 12 Fevereiro")
                {


                }
                field("Dia semanal"; Rec."Weekly Schedule")
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

