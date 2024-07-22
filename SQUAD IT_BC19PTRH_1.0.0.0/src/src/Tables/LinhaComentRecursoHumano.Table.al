table 53043 "Linha Coment. Recurso Humano"
{
    Caption = 'Human Resource Comment Line';
    DataCaptionFields = "No.";
    DrillDownPageID = "Lista Comentários RH";
    LookupPageID = "Lista Comentários RH";

    fields
    {
        field(1; "Table Name"; Option)
        {
            Caption = 'Table Name';
            OptionCaption = 'Employee,Alternative Address,Employee Qualification,Employee Relative,Employee Absence,Misc. Article Information,Confidential Information';
            OptionMembers = Emp,"Edç",Qual,Fam,Aus,InfArt,Cont,Inac,CatProf,CatProfQP,Grau,HAus,HorEx,HHorEx;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF ("Table Name" = CONST(Emp)) Employee."No."
            ELSE
            IF ("Table Name" = CONST("Edç")) "Endereço Alternativo"."Employee No."
            ELSE
            IF ("Table Name" = CONST(Qual)) "Qualificação Empregado"."Employee No."
            ELSE
            IF ("Table Name" = CONST(InfArt)) "Informação Artigos Div."."Employee No."
            ELSE
            IF ("Table Name" = CONST(Aus)) "Ausência Empregado"."Employee No."
            ELSE
            IF ("Table Name" = CONST(Fam)) "Familiar Empregado"."Employee No."
            ELSE
            IF ("Table Name" = CONST(Cont)) "Contrato Empregado"."Cód. Empregado"
            ELSE
            IF ("Table Name" = CONST(Inac)) "Inactividade Empregado"."No. Empregado"
            ELSE
            IF ("Table Name" = CONST(CatProfQP)) "Cat. Prof. QP Empregado"."No. Empregado"
            ELSE
            IF ("Table Name" = CONST(CatProf)) "Cat. Prof. Int. Empregado"."No. Empregado"
            ELSE
            IF ("Table Name" = CONST(Grau)) "Grau Função Empregado"."No. Empregado"
            ELSE
            IF ("Table Name" = CONST(HAus)) "Histórico Ausências"."Employee No."
            ELSE
            IF ("Table Name" = CONST(HorEx)) "Horas Extra Empregado"."No. Empregado"
            ELSE
            IF ("Table Name" = CONST(HHorEx)) "Histórico Horas Extra"."No. Empregado";
        }
        field(3; "Table Line No."; Integer)
        {
            Caption = 'Table Line No.';
        }
        field(4; "Alternative Address Code"; Code[10])
        {
            Caption = 'Alternative Address Code';
            TableRelation = IF ("Table Name" = CONST("Edç")) "Endereço Alternativo".Code WHERE("Employee No." = FIELD("No."));
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(7; Date; Date)
        {
            Caption = 'Date';
        }
        field(8; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(9; Comment; Text[80])
        {
            Caption = 'Comment';
        }
    }

    keys
    {
        key(Key1; "Table Name", "No.", "Table Line No.", "Alternative Address Code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure SetUpNewLine()
    var
        HumanResCommentLine: Record "Linha Coment. Recurso Humano";
    begin
        HumanResCommentLine := Rec;
        HumanResCommentLine.SetRecFilter;
        HumanResCommentLine.SetRange("Line No.");
        HumanResCommentLine.SetRange(Date, WorkDate);
        if not HumanResCommentLine.Find('-') then
            Date := WorkDate;
    end;
}

