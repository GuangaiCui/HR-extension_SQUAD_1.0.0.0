page 31003056 "Informação Confidencial"
{
    AutoSplitKey = true;
    Caption = 'Confidential Information';
    DataCaptionFields = "Employee No.";
    PageType = List;
    SourceTable = "Informação Confidencial";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Confidential Code"; "Confidential Code")
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
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

