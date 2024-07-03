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
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = All;

                }
                field("Code"; Code)
                {
                    ApplicationArea = All;

                }
                field(Address; Address)
                {
                    ApplicationArea = All;

                }
                field("Address 2"; "Address 2")
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field(City; City)
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field(County; County)
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = All;

                }
                field("Fax No."; "Fax No.")
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;

                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = All;

                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = All;

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
                    ApplicationArea = All;

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

