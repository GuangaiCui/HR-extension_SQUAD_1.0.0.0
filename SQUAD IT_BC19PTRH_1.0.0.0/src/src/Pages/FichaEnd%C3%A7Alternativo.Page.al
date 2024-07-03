page 53038 "Ficha Endç. Alternativo"
{
    Caption = 'Alternative Address Card';
    DataCaptionExpression = Caption;
    PageType = Card;
    PopulateAllFields = true;
    SourceTable = "Endereço Alternativo";

    layout
    {
        area(content)
        {
            group(Geral)
            {
                Caption = 'General';
                field("Code"; Code)
                {
                    ApplicationArea = All;

                }
                field(Name; Name)
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

                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = All;

                }
                field(City; City)
                {
                    ApplicationArea = All;

                }
                field(County; County)
                {
                    ApplicationArea = All;

                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = All;

                }
            }
            group("Comunicação")
            {
                Caption = 'Communication';
                field("Phone No.2"; "Phone No.")
                {
                    ApplicationArea = All;

                }
                field("Fax No."; "Fax No.")
                {
                    ApplicationArea = All;

                }
                field("E-Mail"; "E-Mail")
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
                Caption = '&Endereço';
                Image = Addresses;
                action("&Lista")
                {
                    ApplicationArea = All;

                    Caption = '&Lista';
                    RunObject = Page "Lista Endereços Alternativos";
                }
                action("Co&mments")
                {
                    ApplicationArea = All;

                    Caption = '&Comentários';
                    Image = ViewComments;
                    RunObject = Page "Folha Comentários RH";
                    RunPageLink = "Table Name" = CONST("Edç"),
                                  "No." = FIELD("Employee No."),
                                  "Alternative Address Code" = FIELD(Code);
                }
            }
        }
    }

    var
        Text000: Label 'untitled';
        Employee: Record Empregado;


    procedure Caption(): Text[110]
    begin
        if Employee.Get("Employee No.") then
            exit("Employee No." + ' ' + Employee.FullName + ' ' + Code);

        exit(Text000);
    end;
}

