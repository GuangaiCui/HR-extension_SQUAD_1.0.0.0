#pragma implicitwith disable
page 53038 "Ficha Endç. Alternativo"
{
    Caption = 'Alternative Address Card';
    DataCaptionExpression = Caption;
    PageType = Card;
    PopulateAllFields = true;
    SourceTable = "Endereço Alternativo";
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(Geral)
            {
                Caption = 'General';
                field("Code"; Rec.Code)
                {


                }
                field(Name; Rec.Name)
                {


                }
                field(Address; Rec.Address)
                {


                }
                field("Address 2"; Rec."Address 2")
                {


                }
                field("Post Code"; Rec."Post Code")
                {


                }
                field(City; Rec.City)
                {


                }
                field(County; Rec.County)
                {


                }
                field("Phone No."; Rec."Phone No.")
                {


                }
            }
            group("Comunicação")
            {
                Caption = 'Communication';
                field("Phone No.2"; Rec."Phone No.")
                {


                }
                field("Fax No."; Rec."Fax No.")
                {


                }
                field("E-Mail"; Rec."E-Mail")
                {


                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {


                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {


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


                    Caption = '&Lista';
                    RunObject = Page "Lista Endereços Alternativos";
                }
                action("Co&mments")
                {


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

