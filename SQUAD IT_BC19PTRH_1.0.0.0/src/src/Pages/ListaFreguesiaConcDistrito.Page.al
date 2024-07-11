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
                    ApplicationArea = All;

                }
                field(Freguesia; Rec.Freguesia)
                {
                    ApplicationArea = All;

                }
                field(Concelho; Rec.Concelho)
                {
                    ApplicationArea = All;

                }
                field(Distrito; Rec.Distrito)
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

