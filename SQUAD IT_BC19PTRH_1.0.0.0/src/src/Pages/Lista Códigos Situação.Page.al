#pragma implicitwith disable
page 53116 "Lista Códigos Situação"
{
    PageType = List;
    SourceTable = "Códigos Situação";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Cód. Situação"; Rec."Cód. Situação")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Rec."Descrição")
                {
                    ApplicationArea = All;

                }
                field("Perdas Efectivas"; Rec."Perdas Efectivas")
                {
                    ApplicationArea = All;

                }
                field(Diuturnidades; Rec.Diuturnidades)
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

