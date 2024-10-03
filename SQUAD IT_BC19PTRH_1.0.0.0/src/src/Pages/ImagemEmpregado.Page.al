#pragma implicitwith disable
page 53037 "Imagem Empregado"
{
    Caption = 'Employee Picture';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Card;
    SourceTable = Empregado;

    layout
    {
        area(content)
        {
            field(Picture; Rec.Picture)
            {


            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

