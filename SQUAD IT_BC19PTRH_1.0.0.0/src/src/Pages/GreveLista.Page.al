#pragma implicitwith disable
page 53163 "Greve Lista"
{
    Caption = 'Lista Greve';
    CardPageID = Greve;
    Editable = false;
    PageType = List;
    SourceTable = Greves;
    SourceTableView = WHERE(Type = CONST(Cabecalho));
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {

                ShowCaption = false;
                field(Year; Rec.Year)
                {


                }
                field("Strike Code"; Rec."Strike Code")
                {


                }
                field("Strike Description"; Rec."Strike Description")
                {


                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Greve)
            {
                Caption = 'Greve';
                action(Ficha)
                {


                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page Greve;
                    RunPageLink = Type = FIELD(Type),
                                  Year = FIELD(Year),
                                  "Strike Code" = FIELD("Strike Code");
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }


    procedure GetSelectionFilter(): Code[80]
    var
        Cust: Record Customer;
        FirstCust: Code[30];
        LastCust: Code[30];
        SelectionFilter: Code[250];
        CustCount: Integer;
        More: Boolean;
    begin
        CurrPage.SetSelectionFilter(Cust);
        CustCount := Cust.Count;
        if CustCount > 0 then begin
            Cust.Find('-');
            while CustCount > 0 do begin
                CustCount := CustCount - 1;
                Cust.MarkedOnly(false);
                FirstCust := Cust."No.";
                LastCust := FirstCust;
                More := (CustCount > 0);
                while More do
                    if Cust.Next = 0 then
                        More := false
                    else
                        if not Cust.Mark then
                            More := false
                        else begin
                            LastCust := Cust."No.";
                            CustCount := CustCount - 1;
                            if CustCount = 0 then
                                More := false;
                        end;
                if SelectionFilter <> '' then
                    SelectionFilter := SelectionFilter + '|';
                if FirstCust = LastCust then
                    SelectionFilter := SelectionFilter + FirstCust
                else
                    SelectionFilter := SelectionFilter + FirstCust + '..' + LastCust;
                if CustCount > 0 then begin
                    Cust.MarkedOnly(true);
                    Cust.Next;
                end;
            end;
        end;
        exit(SelectionFilter);
    end;


    procedure SetSelection(var Cust: Record Customer)
    begin
        CurrPage.SetSelectionFilter(Cust);
    end;
}

#pragma implicitwith restore

