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
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field("Misc. Article Code"; "Misc. Article Code")
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
                {
                    ApplicationArea = All;

                }
                field("Serial No."; "Serial No.")
                {
                    ApplicationArea = All;

                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = All;

                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = All;

                }
                field("In Use"; "In Use")
                {
                    ApplicationArea = All;

                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;

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
                    ApplicationArea = All;

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
                    ApplicationArea = All;

                    Caption = 'Vista Artigos Div.';
                    Image = Filed;
                    RunObject = Page "Vista Artigos Diversos";
                }
            }
        }
    }
}

