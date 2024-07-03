page 31003063 "Vista Artigos Diversos"
{
    AutoSplitKey = true;
    Caption = 'Misc. Article Information';
    DataCaptionFields = "Employee No.";
    PageType = List;
    SourceTable = "Informação Artigos Div.";
    SourceTableView = SORTING("Employee No.", "Misc. Article Code", "Line No.")
                      ORDER(Ascending)
                      WHERE("Employee No." = FILTER(<> ''));
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

                    Visible = boolVisible;
                }
                field("recEmpregado.FullName"; recEmpregado.FullName)
                {
                    ApplicationArea = All;

                    Caption = 'Name';
                    Visible = boolVisible;
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
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if recEmpregado.Get("Employee No.") then;
        //MESSAGE('%1 <> %2', Rec."Employee No.",xRec."Employee No.");
        if Rec."Employee No." <> xRec."Employee No." then
            boolVisible := true
        else
            boolVisible := false;
    end;

    trigger OnInit()
    begin
        boolShow := false;
        boolVisible := false;
    end;

    var
        recEmpregado: Record Empregado;
        boolShow: Boolean;
        boolVisible: Boolean;
}

