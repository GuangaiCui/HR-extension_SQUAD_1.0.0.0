table 31003092 "Acções Formação"
{
    DrillDownPageID = "Registo Formação";
    LookupPageID = "Lista Acções Formação";

    fields
    {
        field(1; "Código"; Code[10])
        {
            Caption = 'Code';
        }
        field(3; "Descrição"; Text[100])
        {
            Caption = 'Description';
        }
        field(5; Tipo; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Interna,Externa,Outra';
            OptionMembers = " ",Interna,Externa,Outra;
        }
        field(6; "No. Horas Acção"; Decimal)
        {
            Caption = 'Duration in Hours';
        }
        field(7; "Data Início"; Date)
        {
            Caption = 'Start Date';
        }
        field(8; "Data Fim"; Date)
        {
            Caption = 'End Date';
        }
        field(9; "Local"; Text[30])
        {
            Caption = 'Local';
        }
        field(10; "Nome Entidade Prestadora"; Text[30])
        {
            Caption = 'Training Organization Name';
        }
        field(11; "Nome Formador"; Text[30])
        {
            Caption = 'Trainer Name';
        }
        field(12; "Custo Acção"; Decimal)
        {
            Caption = 'Cost';
        }
        field(13; "Max. Participantes"; Integer)
        {
            Caption = 'Maximum of Trainees';
        }
        field(14; "Participantes Inscritos"; Integer)
        {
            CalcFormula = Count ("Formação Empregado" WHERE ("Cód. Acção" = FIELD ("Código")));
            Caption = 'Enrolled Trainees';
            FieldClass = FlowField;
        }
        field(20; Objectivos; Text[250])
        {
            Caption = 'Goals';
            Description = 'MISI';
        }
        field(30; "Cod. Área de Educ./Formação"; Code[10])
        {
            Caption = 'Education Area Code';
            Description = 'RU';
            TableRelation = "RU - Tabelas"."Código" WHERE (Tipo = CONST (AreaEdu));

            trigger OnValidate()
            begin
                RuTabelas.Reset;
                RuTabelas.SetRange(RuTabelas.Tipo, RuTabelas.Tipo::AreaEdu);
                RuTabelas.SetRange(RuTabelas.Código, "Cod. Área de Educ./Formação");
                if RuTabelas.FindFirst then
                    "Área de Educação/Formação" := RuTabelas.Descrição
                else
                    "Área de Educação/Formação" := '';
            end;
        }
        field(31; "Área de Educação/Formação"; Text[250])
        {
            Caption = 'Education Area';
            Description = 'RU';
        }
        field(32; "Cod. Modalidade"; Code[10])
        {
            Caption = 'Modality Code';
            Description = 'RU';
            TableRelation = "RU - Tabelas"."Código" WHERE (Tipo = CONST (ModFor));

            trigger OnValidate()
            begin
                RuTabelas.Reset;
                RuTabelas.SetRange(RuTabelas.Tipo, RuTabelas.Tipo::ModFor);
                RuTabelas.SetRange(RuTabelas.Código, "Cod. Modalidade");
                if RuTabelas.FindFirst then
                    Modalidade := RuTabelas.Descrição
                else
                    Modalidade := '';
            end;
        }
        field(33; Modalidade; Text[250])
        {
            Caption = 'Modality';
            Description = 'RU';
        }
        field(35; "Cod. Entidade Formadora"; Code[10])
        {
            Caption = 'Training Organization Code';
            Description = 'RU';
            TableRelation = "RU - Tabelas"."Código" WHERE (Tipo = CONST (EntFor));

            trigger OnValidate()
            begin
                RuTabelas.Reset;
                RuTabelas.SetRange(RuTabelas.Tipo, RuTabelas.Tipo::EntFor);
                RuTabelas.SetRange(RuTabelas.Código, "Cod. Entidade Formadora");
                if RuTabelas.FindFirst then
                    "Entidade Formadora" := RuTabelas.Descrição
                else
                    "Entidade Formadora" := ''
            end;
        }
        field(36; "Entidade Formadora"; Text[250])
        {
            Caption = 'Training Organization';
            Description = 'RU';
        }
        field(39; "Cód. Nível Qualificação Form."; Code[10])
        {
            Caption = 'Code of Qualification Training Level';
            Description = 'RU';
            TableRelation = "RU - Tabelas"."Código" WHERE (Tipo = CONST (QualFor));

            trigger OnValidate()
            begin
                RuTabelas.Reset;
                RuTabelas.SetRange(RuTabelas.Tipo, RuTabelas.Tipo::QualFor);
                RuTabelas.SetRange(RuTabelas.Código, "Cód. Nível Qualificação Form.");
                if RuTabelas.FindFirst then
                    "Nível Qualificação Formação" := RuTabelas.Descrição;
            end;
        }
        field(40; "Nível Qualificação Formação"; Text[250])
        {
            Caption = 'Qualification Training Level';
            Description = 'RU';
        }
        field(41; "Temp No. Accao"; Integer)
        {
            Caption = 'Training Temp';
            Description = 'RU';
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

    var
        RuTabelas: Record "RU - Tabelas";
}

