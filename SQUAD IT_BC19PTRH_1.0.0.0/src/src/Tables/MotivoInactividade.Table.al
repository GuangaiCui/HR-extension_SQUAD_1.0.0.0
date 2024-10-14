table 53045 "Motivo Inactividade"
{
    Caption = 'Cause of Inactivity';
    DrillDownPageID = "Motivos Inactividade";
    LookupPageID = "Motivos Inactividade";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Código';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Descrição';
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

