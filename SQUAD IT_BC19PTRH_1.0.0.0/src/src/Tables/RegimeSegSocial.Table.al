table 53068 "Regime Seg. Social"
{
    DrillDownPageID = "Regime Seg. Social";
    LookupPageID = "Regime Seg. Social";

    fields
    {
        field(1; "Código"; Code[10])
        {
            //Caption = 'Code';
        }
        field(5; "Descrição"; Text[200])
        {
            //Caption = 'Description';
        }
        field(6; "Tipo Dedução SS"; Text[30])
        {
            //Caption = 'Soc. Sec. Deduction Type';
        }
        field(7; "Taxa Contributiva Empregado"; Decimal)
        {
            //Caption = 'Emloyee Rate';
            MaxValue = 100;
            MinValue = 0;
        }
        field(8; "Taxa Contributiva Ent Patronal"; Decimal)
        {
            //Caption = 'Company Rate';
            MaxValue = 100;
            MinValue = 0;
        }
        field(15; Majorante; Decimal)
        {
            //Caption = 'Upper Bound';
        }
    }

    keys
    {
        key(Key1; "Código")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Código", "Descrição")
        {
        }
    }
}

