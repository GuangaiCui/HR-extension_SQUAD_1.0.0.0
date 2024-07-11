#pragma implicitwith disable
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
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;

                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;

                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;

                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;

                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;

                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;

                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;

                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;

                }
            }
            group("Comunicação")
            {
                Caption = 'Communication';
                field("Phone No.2"; Rec."Phone No.")
                {
                    ApplicationArea = All;

                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;

                }
                field("E-Mail"; Rec."E-Mail")
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
        if Employee.Get(Rec."Employee No.") then
            exit(Rec."Employee No." + ' ' + Employee.FullName + ' ' + Rec.Code);

        exit(Text000);
    end;
}

#pragma implicitwith restore

