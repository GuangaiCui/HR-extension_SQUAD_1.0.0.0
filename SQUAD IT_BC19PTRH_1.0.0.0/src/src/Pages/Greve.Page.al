page 53160 Greve
{
    PageType = Card;
    SourceTable = Greves;
    UsageCategory = Tasks;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            group(Greve)
            {
                Caption = 'Greve';
                field(Year; Year)
                {
                    ApplicationArea = All;

                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Strike Code"; "Strike Code")
                {
                    ApplicationArea = All;

                }
                field("Strike Description"; "Strike Description")
                {
                    ApplicationArea = All;

                    Editable = false;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
            }
            part(Control1102065000; "Reivindicações")
            {
                ApplicationArea = All;

                SubPageLink = Type = CONST(Linha1),
                              Year = FIELD(Year),
                              "Strike Code" = FIELD("Strike Code");
            }
            part("Registo Greve"; "Greve Subform")
            {
                ApplicationArea = All;

                Caption = 'Registo Greve';
                SubPageLink = Type = CONST(Linha2),
                              Year = FIELD(Year),
                              "Strike Code" = FIELD("Strike Code");
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Line No." := 10000;
    end;
}

