table 53067 "Instituição Seg. Social"
{
    DrillDownPageID = "Regime Seg. Social";
    LookupPageID = "Instituição Seg. Social";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Código';
        }
        field(2; Description; Text[200])
        {
            Caption = 'Descrição';
        }
        field(3; Address; Text[30])
        {
            Caption = 'Endereço';
        }
        field(4; "Post Code"; Code[10])
        {
            Caption = 'Cód. Postal';
            TableRelation = "Post Code".Code;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(5; City; Text[30])
        {
            Caption = 'Cidade';

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(6; "Phone No."; Text[30])
        {
            Caption = 'Telefone';
            Numeric = true;
        }
        field(7; Fax; Text[30])
        {
            Caption = 'Fax';
            Numeric = true;
        }
        field(8; County; Text[30])
        {
            Caption = 'Distrito';
        }
        field(10; NIPC; Text[9])
        {
            Caption = 'NIPC';
            Description = 'DMR';
        }
        field(11; "Country Code"; Code[10])
        {
            Caption = 'Cód. País';
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

