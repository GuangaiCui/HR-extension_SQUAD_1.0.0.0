table 53069 "Tabela IRS"
{
    DrillDownPageID = "Lista Tabela IRS";
    LookupPageID = "Lista Tabela IRS";

    fields
    {
        field(1; "Line No."; Integer)
        {
        }
        field(2; "Região"; Option)
        {
            Caption = 'Region';
            OptionMembers = Continente,"Açores",Madeira;
        }
        field(3; "Até"; Text[30])
        {
            Caption = 'Until';
        }
        field(4; Tabela; Option)
        {
            Caption = 'Table';
            OptionMembers = " ",I,II,III,IV,V,VI,VII,VIII,IX,X,XI,XII,XIII;
        }
        field(5; "Descrição"; Text[100])
        {
            Caption = 'Description';
        }
        field(6; Valor; Decimal)
        {
            Caption = 'Value';
        }
        field(7; "TD 0 Dependentes"; Decimal)
        {
            Caption = 'TD 0 Children';
        }
        field(8; "TD 1 Dependentes"; Decimal)
        {
            Caption = 'TD 1 Children';
        }
        field(9; "TD 2 Dependentes"; Decimal)
        {
            Caption = 'TD 2 Children';
        }
        field(10; "TD 3 Dependentes"; Decimal)
        {
            Caption = 'TD 3 Children';
        }
        field(11; "TD 4 Dependentes"; Decimal)
        {
            Caption = 'TD 4 Children';
        }
        field(12; "TD 5ou Mais Dependentes"; Decimal)
        {
            Caption = 'TD 5 or more Children';
        }
        field(13; PenCas2Tit; Decimal)
        {
            Caption = 'Senior Mar. 2 Persons';
        }
        field(14; PenNCas; Decimal)
        {
            Caption = 'Senior Not Married';
        }
        field(15; PenCas1Tit; Decimal)
        {
            Caption = 'Senior Mar. 1 Person';
        }
        field(16; Ano; Integer)
        {
            Caption = 'Year';
        }
    }

    keys
    {
        key(Key1; Ano, "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

