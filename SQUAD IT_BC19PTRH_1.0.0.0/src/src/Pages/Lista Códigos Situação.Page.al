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
                    ;

                }
                field("Descrição"; Rec."Descrição")
                {
                    ;

                }
                field("Perdas Efectivas"; Rec."Perdas Efectivas")
                {
                    ;

                }
                field(Diuturnidades; Rec.Diuturnidades)
                {
                    ;

                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

