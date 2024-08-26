#pragma implicitwith disable
page 53142 "Actividades dos Serviços"
{
    PageType = List;
    SourceTable = "Actividades dos Serviços";
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field("Data Actividade"; Rec."Data Actividade")
                {


                }
                field(Actividade; Rec.Actividade)
                {


                }
                field("Descrição Actividade"; Rec."Descrição Actividade")
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

