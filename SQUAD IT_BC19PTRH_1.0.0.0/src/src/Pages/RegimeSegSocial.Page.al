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
                field("Código"; Código)
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Descrição)
                {
                    ApplicationArea = All;

                }
                field("Tipo Dedução SS"; "Tipo Dedução SS")
                {
                    ApplicationArea = All;

                }
                field("Taxa Contributiva Empregado"; "Taxa Contributiva Empregado")
                {
                    ApplicationArea = All;

                }
                field("Taxa Contributiva Ent Patronal"; "Taxa Contributiva Ent Patronal")
                {
                    ApplicationArea = All;

                }
                field(Majorante; Majorante)
                {
                    ApplicationArea = All;

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

