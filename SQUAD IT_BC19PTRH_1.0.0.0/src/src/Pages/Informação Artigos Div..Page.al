#pragma implicitwith disable
page 53054 "Informação Artigos Div."
{
    AutoSplitKey = true;
    Caption = 'Misc. Article Information';
    DataCaptionFields = "Employee No.";
    PageType = List;
    SourceTable = "Informação Artigos Div.";
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Employee No."; Rec."Employee No.")
                {
                    ;

                    Visible = false;
                }
                field("Misc. Article Code"; Rec."Misc. Article Code")
                {
                    ;

                }
                field(Description; Rec.Description)
                {
                    ;

                }
                field("Serial No."; Rec."Serial No.")
                {
                    ;

                }
                field("From Date"; Rec."From Date")
                {
                    ;

                }
                field("To Date"; Rec."To Date")
                {
                    ;

                }
                field("In Use"; Rec."In Use")
                {
                    ;

                }
                field(Comment; Rec.Comment)
                {
                    ;

                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Artigo Diverso")
            {
                Caption = 'Mi&sc. Article';
                action("Co&mentários")
                {
                    ;

                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Folha Comentários RH";
                    RunPageLink = "Table Name" = CONST(InfArt),
                                  "No." = FIELD("Employee No."),
                                  "Alternative Address Code" = FIELD("Misc. Article Code"),
                                  "Table Line No." = FIELD("Line No.");
                }
                separator(Action1101490001)
                {

                }
                action("Vista Artigos Div.")
                {
                    ;

                    Caption = 'Vista Artigos Div.';
                    Image = Filed;
                    RunObject = Page "Vista Artigos Diversos";
                }
            }
        }
    }
}

#pragma implicitwith restore

