#pragma implicitwith disable
page 53159 Destacamentos
{
    AutoSplitKey = true;
    PageType = List;
    SourceTable = Destacamentos;
    ApplicationArea = HumanResourcesAppArea;
    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field("Local de Destacamento"; Rec."Place of Detachment")
                {


                }
                field("Data Início Destacamento"; Rec."Detachment Begin Date")
                {


                }
                field("Data Fim Destacamento"; Rec."Detachment End Date")
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

