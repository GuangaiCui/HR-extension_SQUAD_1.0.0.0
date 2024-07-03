table 31003126 Greves
{
    DrillDownPageID = "Greve Lista";
    LookupPageID = "Greve Lista";

    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Tipo';
            OptionMembers = Cabecalho,Linha1,Linha2;
        }
        field(2; Year; Integer)
        {
            Caption = 'Ano';
        }
        field(3; "Strike Code"; Code[10])
        {
            Caption = 'Cód. Greve';
            TableRelation = "RU - Tabelas"."Código" WHERE (Tipo = CONST (Grv));

            trigger OnValidate()
            begin
                rRuTabelas.Reset;
                rRuTabelas.SetRange(rRuTabelas.Tipo, rRuTabelas.Tipo::Grv);
                rRuTabelas.SetRange(rRuTabelas.Código, "Strike Code");
                if rRuTabelas.FindSet then
                    "Strike Description" := rRuTabelas.Descrição
                else
                    "Strike Description" := '';
            end;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Nº Linha';
        }
        field(5; "Strike Description"; Text[100])
        {
            Caption = 'Descrição Greve';
        }
        field(10; Claim; Code[10])
        {
            Caption = 'Reivindicação';
            TableRelation = "RU - Tabelas"."Código" WHERE (Tipo = CONST (Rvd));

            trigger OnValidate()
            begin
                rRuTabelas.Reset;
                rRuTabelas.SetRange(rRuTabelas.Tipo, rRuTabelas.Tipo::Rvd);
                rRuTabelas.SetRange(rRuTabelas.Código, Claim);
                if rRuTabelas.FindSet then
                    "Claim Description" := rRuTabelas.Descrição
                else
                    "Claim Description" := '';
            end;
        }
        field(11; "Claim Description"; Text[100])
        {
            Caption = 'Descrição da Reivindicação';
        }
        field(12; Result; Option)
        {
            Caption = 'Resultado';
            OptionCaption = ' ,Totalmente aceite,Parcialmente aceite,Recusado';
            OptionMembers = " ","1","2","3";
        }
        field(15; "Strike Date"; Date)
        {
            Caption = 'Data Greve';
        }
        field(16; "Normal Working Period"; Decimal)
        {
            Caption = 'Período Normal de Trabalho';
            DecimalPlaces = 2 : 2;
        }
        field(17; "Strike Number of Workers"; Integer)
        {
            Caption = 'Nº trabalhadores em Greve';
        }
        field(18; "Stop Time (Hours)"; Integer)
        {
            Caption = 'Duração paralização (horas)';
        }
        field(19; "Stop Time (Minutes)"; Integer)
        {
            Caption = 'Duração paralização (minutos)';
            MaxValue = 60;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1; Type, Year, "Strike Code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        rRuTabelas: Record "RU - Tabelas";
}

