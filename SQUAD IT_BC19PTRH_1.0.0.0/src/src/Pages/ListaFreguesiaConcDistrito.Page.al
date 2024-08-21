#pragma implicitwith disable
page 53095 "Lista Freguesia/Conc/Distrito"
{
    PageType = List;
    SourceTable = "Cód. Freguesia/Conc/Distrito";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Código"; Rec."Código")
                {
                    ;

                }
                field(Freguesia; Rec.Freguesia)
                {
                    ;

                }
                field(Concelho; Rec.Concelho)
                {
                    ;

                }
                field(Distrito; Rec.Distrito)
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

