table 53041 "Absence Reason"
{
    Caption = 'Absence Reason';
    DrillDownPageID = "Motivos Ausência";
    LookupPageID = "Motivos Ausência";

    fields
    {
        field(1; "Code"; Code[10])
        {
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Unit of Measure Code"; Code[10])
        {
            TableRelation = "Unid. Medida Recursos Humanos";
        }
        field(4; "Total Absence (Base)"; Decimal)
        {
            CalcFormula = Sum("Histórico Ausências"."Quantity (Base)" WHERE("Cause of Absence Code" = FIELD(Code),
                                                                             "Employee No." = FIELD("Employee No. Filter"),
                                                                             "From Date" = FIELD("Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(6; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(7; "Employee No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Empregado;
        }
        field(8; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(12; "Payroll Item Code"; Code[20])
        {
            TableRelation = "Payroll Item";
        }
        field(15; Justified; Boolean)
        {
        }
        field(16; "Remuneration Loss"; Boolean)
        {
        }
        field(17; "Food Subsidy Loss"; Boolean)
        {
        }
        field(22; "Vacation Days Influence"; Boolean)
        {
            Description = 'Util para o mapa de férias';
        }
        field(23; License; Option)
        {
            OptionCaption = ' ,Com Vencimento,Sem Vencimento';
            OptionMembers = " ","Com Vencimento","Sem Vencimento";
        }
        field(24; "Not Working Hours Reason Code"; Code[10])
        {
            Description = 'RU';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(MotHNTrab));

            trigger OnValidate()
            begin
                RUTabelas.Reset;
                RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::MotHNTrab);
                RUTabelas.SetRange(RUTabelas.Código, "Not Working Hours Reason Code");
                if RUTabelas.FindFirst then begin
                    "Not Working Hours Reason Desc." := RUTabelas.Descrição;
                    "Non-Paid Hours Reason Code" := RUTabelas.Classificação;
                end;
            end;
        }
        field(25; "Not Working Hours Reason Desc."; Text[250])
        {
            Description = 'RU';
        }
        field(26; "Non-Paid Hours Reason Code"; Code[10])
        {
            Caption = 'Non Paid Normal Hours Reason Code';
            Description = 'RU';
        }
        field(27; "Holiday Subsidy Influence"; Boolean)
        {
        }
        field(28; "Christmas Subsidy Influence"; Boolean)
        {
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

