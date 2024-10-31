#pragma implicitwith disable
page 53063 "Vista Artigos Diversos"
{
    AutoSplitKey = true;
    //Caption = 'Misc. Article Information';
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
                field("Employee No."; Rec."Employee No.")
                {


                    Visible = boolVisible;
                }
                field("recEmpregado.FullName"; recEmpregado.FullName)
                {


                    Caption = 'Name';
                    Visible = boolVisible;
                }
                field("Misc. Article Code"; Rec."Misc. Article Code")
                {


                }
                field(Description; Rec.Description)
                {


                }
                field("Serial No."; Rec."Serial No.")
                {


                }
                field("From Date"; Rec."From Date")
                {


                }
                field("To Date"; Rec."To Date")
                {


                }
                field("In Use"; Rec."In Use")
                {


                }
                field(Comment; Rec.Comment)
                {


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
        if recEmpregado.Get(Rec."Employee No.") then;
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

#pragma implicitwith restore

