page 53159 Destacamentos
{
    AutoSplitKey = true;
    PageType = List;
    SourceTable = Destacamentos;

    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field("Local de Destacamento"; "Local de Destacamento")
                {
                    ApplicationArea = All;

                }
                field("Data Início Destacamento"; "Data Início Destacamento")
                {
                    ApplicationArea = All;

                }
                field("Data Fim Destacamento"; "Data Fim Destacamento")
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

