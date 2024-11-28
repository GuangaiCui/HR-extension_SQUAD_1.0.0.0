table 53131 "Regimes IRS Jovem"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[60])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; Ano; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Regime; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Escalao; Integer)
        {
            Caption = 'Escalão';
            //ToolTip = 'Em que ano do escalão se encontra';
            Description = '1º ano, 2º ano, 3º ano. 4º ano, 5º ano';
            DataClassification = ToBeClassified;
        }
        field(5; "Isenção"; Decimal)
        {
            Caption = 'Isenção %';
            DataClassification = ToBeClassified;
        }
        field(6; Limite; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; Regime, Ano, Code)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        Code := StrSubstNo('%1_%2', Ano, Regime);
    end;

    trigger OnModify()
    var
        ExistingRec: Record "Regimes IRS Jovem";
    begin
        Code := StrSubstNo('%1_%2', Ano, Regime);
    end;
}