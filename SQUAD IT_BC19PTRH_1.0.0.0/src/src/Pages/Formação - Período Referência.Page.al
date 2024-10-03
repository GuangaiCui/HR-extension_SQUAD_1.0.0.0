#pragma implicitwith disable
page 53164 "Formação - Período Referência"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Formação - Período Referência";
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Período Ref. Formação"; Rec."Período Ref. Formação")
                {


                }
                field("Descrição"; Rec."Descrição")
                {


                }
            }
        }
    }

    actions
    {
    }

    var
        Employee: Record Empregado;
}

#pragma implicitwith restore

