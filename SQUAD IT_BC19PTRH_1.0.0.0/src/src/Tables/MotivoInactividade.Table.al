table 31003045 "Motivo Inactividade"
{
    Caption = 'Cause of Inactivity';
    DrillDownPageID = "Motivos Inactividade";
    LookupPageID = "Motivos Inactividade";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
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
}

