#pragma implicitwith disable
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
                field("Local de Destacamento"; Rec."Local de Destacamento")
                {


                }
                field("Data Início Destacamento"; Rec."Data Início Destacamento")
                {


                }
                field("Data Fim Destacamento"; Rec."Data Fim Destacamento")
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

