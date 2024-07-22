#pragma implicitwith disable
page 53037 "Imagem Empregado"
{
    Caption = 'Employee Picture';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Card;
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            field(Picture; Rec.Image)
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

