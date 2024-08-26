#pragma implicitwith disable
page 53084 "Regime Seg. Social"
{
    PageType = List;
    SourceTable = "Regime Seg. Social";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Código"; Rec."Código")
                {


                }
                field("Descrição"; Rec."Descrição")
                {


                }
                field("Tipo Dedução SS"; Rec."Tipo Dedução SS")
                {


                }
                field("Taxa Contributiva Empregado"; Rec."Taxa Contributiva Empregado")
                {


                }
                field("Taxa Contributiva Ent Patronal"; Rec."Taxa Contributiva Ent Patronal")
                {


                }
                field(Majorante; Rec.Majorante)
                {


                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        TabRegSS: Record "Regime Seg. Social";


    procedure GetSelectionFilter(): Code[80]
    var
        GLAcc: Record "G/L Account";
        FirstAcc: Text[20];
        LastAcc: Text[20];
        SelectionFilter: Code[80];
        GLAccCount: Integer;
        More: Boolean;
    begin
        CurrPage.SetSelectionFilter(TabRegSS);

        TabRegSS.MarkedOnly(true);
        if TabRegSS.Find('-') then
            exit(TabRegSS.Código);
    end;
}

#pragma implicitwith restore

