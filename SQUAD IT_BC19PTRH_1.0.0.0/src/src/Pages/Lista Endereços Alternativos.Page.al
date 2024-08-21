#pragma implicitwith disable
page 53039 "Lista Endereços Alternativos"
{
    Caption = 'Alternative Address List';
    CardPageID = "Ficha Endç. Alternativo";
    DataCaptionFields = "Employee No.";
    Editable = false;
    PageType = List;
    SourceTable = "Endereço Alternativo";

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

                }
                field("Code"; Rec.Code)
                {
                    ;

                }
                field(Address; Rec.Address)
                {
                    ;

                }
                field("Address 2"; Rec."Address 2")
                {
                    ;

                    Visible = false;
                }
                field(City; Rec.City)
                {
                    ;

                    Visible = false;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ;

                    Visible = false;
                }
                field(County; Rec.County)
                {
                    ;

                    Visible = false;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ;

                }
                field("Fax No."; Rec."Fax No.")
                {
                    ;

                    Visible = false;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ;

                    Visible = false;
                }
                field(Comment; Rec.Comment)
                {
                    ;

                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ;

                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ;

                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Address")
            {
                Caption = '&Address';
                Image = Addresses;
                action("Co&mments")
                {
                    ;

                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Alternative Address"),
                                  "No." = FIELD("Employee No."),
                                  "Alternative Address Code" = FIELD(Code);
                }
            }
        }
    }
}

#pragma implicitwith restore

