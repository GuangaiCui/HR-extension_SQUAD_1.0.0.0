#pragma implicitwith disable
page 53056 "Informação Confidencial"
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
                field("Confidential Code"; Rec."Confidential Code")
                {


                }
                field(Description; Rec.Description)
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

