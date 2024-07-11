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
                    ApplicationArea = All;

                }
                field("Data Início Destacamento"; Rec."Data Início Destacamento")
                {
                    ApplicationArea = All;

                }
                field("Data Fim Destacamento"; Rec."Data Fim Destacamento")
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

