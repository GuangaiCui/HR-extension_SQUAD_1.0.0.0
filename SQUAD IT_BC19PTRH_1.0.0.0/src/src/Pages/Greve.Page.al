#pragma implicitwith disable
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
                field(Year; Rec.Year)
                {


                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Strike Code"; Rec."Strike Code")
                {


                }
                field("Strike Description"; Rec."Strike Description")
                {


                    Editable = false;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
            }
            part(Control1102065000; "Reivindicações")
            {


                SubPageLink = Type = CONST(Linha1),
                              Year = FIELD(Year),
                              "Strike Code" = FIELD("Strike Code");
            }
            part("Registo Greve"; "Greve Subform")
            {


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
        Rec."Line No." := 10000;
    end;
}

#pragma implicitwith restore

