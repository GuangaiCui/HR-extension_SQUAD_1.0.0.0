table 53129 "Table IRS 2023"
//table 60000 in NAV
{
    DrillDownPageID = "List Table IRS 2023";
    LookupPageID = "List Table IRS 2023";

    fields
    {
        field(1; "Line No."; Integer)
        {
        }
        field(2; "Region"; Option)
        {
            OptionMembers = Continente,"Açores",Madeira;
        }
        field(3; "Table"; Option)
        {
            OptionMembers = ,I,II,III,IV,V,VI,VII,VIII,IX,X,XI,XII,XIII,XIV,XV,XVI;
        }
        field(4; Description; Text[100])
        {
        }
        field(5; "Value"; Decimal)
        {
        }
        field(6; Tax; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Value to Substract"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Factor to Substract"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Fixed Value to Substract"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Value to Substract/dependente"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "From Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "From Date", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "From Date", Region, Table, Value)
        {

        }
    }

    fieldgroups
    {
    }
}

