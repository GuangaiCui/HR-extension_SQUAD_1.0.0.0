table 53067 "Instituição Seg. Social"
{
    DrillDownPageID = "Regime Seg. Social";
    LookupPageID = "Instituição Seg. Social";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[200])
        {
        }
        field(3; Address; Text[30])
        {
        }
        field(4; "Post Code"; Code[10])
        {
            TableRelation = "Post Code".Code;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(5; City; Text[30])
        {

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(6; "Phone No."; Text[30])
        {
            Numeric = true;
        }
        field(7; Fax; Text[30])
        {
            Numeric = true;
        }
        field(8; County; Text[30])
        {
        }
        field(10; NIPC; Text[9])
        {
            Description = 'DMR';
        }
        field(11; "Country Code"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description)
        {
        }
    }

    var
        PostCode: Record "Post Code";
}

