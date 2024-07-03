table 53041 "Absence Reason"
{
    Caption = 'Absence Reason';
    DrillDownPageID = "Motivos Ausência";
    LookupPageID = "Motivos Ausência";

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
        field(3; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Unid. Medida Recursos Humanos";
        }
        field(4; "Total Absence (Base)"; Decimal)
        {
            CalcFormula = Sum("Histórico Ausências"."Quantity (Base)" WHERE("Cause of Absence Code" = FIELD(Code),
                                                                             "Employee No." = FIELD("Employee No. Filter"),
                                                                             "From Date" = FIELD("Date Filter")));
            Caption = 'Total Absence (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(6; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(7; "Employee No. Filter"; Code[20])
        {
            Caption = 'Employee No. Filter';
            FieldClass = FlowFilter;
            TableRelation = Empregado;
        }
        field(8; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(12; "Rubric Code"; Code[20])
        {
            Caption = 'Salary Item Code';
            TableRelation = "Rubrica Salarial";
        }
        field(15; Justified; Boolean)
        {
            Caption = 'Justify';
        }
        field(16; "Remuneration Loss"; Boolean)
        {
            Caption = 'With Loss of Pay';
        }
        field(17; "Food Subsidy Loss"; Boolean)
        {
            Caption = 'With Loss of Lunch Subsidy';
        }
        field(22; "Vacation Days Influence"; Boolean)
        {
            Caption = 'Influence the No. of Vacation Days';
            Description = 'Util para o mapa de férias';
        }
        field(23; License; Option)
        {
            Caption = 'Licence';
            OptionCaption = ' ,Com Vencimento,Sem Vencimento';
            OptionMembers = " ","Com Vencimento","Sem Vencimento";
        }
        field(24; "Not Working Hours Reason Code"; Code[10])
        {
            Caption = 'Reason Code of Non Work Hours';
            Description = 'RU';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(MotHNTrab));

            trigger OnValidate()
            begin
                RUTabelas.Reset;
                RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::MotHNTrab);
                RUTabelas.SetRange(RUTabelas.Código, "Not Working Hours Reason Code");
                if RUTabelas.FindFirst then begin
                    "Not Working Hours Reason Desc." := RUTabelas.Descrição;
                    "Cod. Mot. Horas Normais N Rem" := RUTabelas.Classificação;
                end;
            end;
        }
        field(25; "Not Working Hours Reason Desc."; Text[250])
        {
            Caption = 'Reason Description of Non Work Hours';
            Description = 'RU';
        }
        field(26; "Cod. Mot. Horas Normais N Rem"; Code[10])
        {
            Caption = 'Reason Code of Non Pay Work Hours';
            Description = 'RU';
        }
        field(27; "Holiday Subsidy Influence"; Boolean)
        {
            Caption = 'Influence Vacation Salary';
        }
        field(28; "Christmas Subsidy Influence"; Boolean)
        {
            Caption = 'Influence Christmas Salary';
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
        RUTabelas: Record "RU - Tabelas";
}

