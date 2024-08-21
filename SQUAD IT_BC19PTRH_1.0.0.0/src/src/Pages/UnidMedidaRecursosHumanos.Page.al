#pragma implicitwith disable
page 53071 "Unid. Medida Recursos Humanos"
{
    Caption = 'Human Resource Units of Measure';
    PageType = List;
    SourceTable = "Unid. Medida Recursos Humanos";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ;

                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ;

                }
                field("Designação Interna"; Rec."Designação Interna")
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

