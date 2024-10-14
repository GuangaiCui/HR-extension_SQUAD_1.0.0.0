table 53093 "Formação Empregado"
{
    // C+ -LCF-HR.02 BS criei a seguinte chave "Nº Empregado,Data Início,Tipo"

    DrillDownPageID = "Registo Formação";
    LookupPageID = "Registo Formação";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'No. Empregado';
            TableRelation = Empregado."No.";
        }
        field(2; "Cód. Acção"; Code[10])
        {
            Caption = 'Training Code';
            TableRelation = "Acções Formação"."Código";

            trigger OnValidate()
            begin
                if TabAccoesFormacao.Get("Cód. Acção") then begin
                    Descrição := TabAccoesFormacao.Descrição;
                    Tipo := TabAccoesFormacao.Tipo;
                    //C+ - AMFB - 170408  - Passar os novos campos tb
                    "No. Horas Acção" := TabAccoesFormacao."No. Horas Acção";
                    "Data Início" := TabAccoesFormacao."Data Início";
                    "Data Fim" := TabAccoesFormacao."Data Fim";
                    "Custo Acção" := TabAccoesFormacao."Custo Acção";
                    "Local" := TabAccoesFormacao."Local";
                    "Entidade Prestadora" := TabAccoesFormacao."Nome Entidade Prestadora";
                    //C+
                end;
            end;
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
        field(10; "No. Horas Acção"; Decimal)
        {
            Caption = 'Total Hours';
        }
        field(11; "Data Início"; Date)
        {
            Caption = 'Start Date';
        }
        field(12; "Data Fim"; Date)
        {
            Caption = 'End Date';
        }
        field(13; "Custo Acção"; Decimal)
        {
            Caption = 'Cost';
        }
        field(14; "Observações"; Text[250])
        {
            Caption = 'Observations';
        }
        field(15; "Local"; Text[30])
        {
            Caption = 'Local';
        }
        field(16; "Entidade Prestadora"; Text[30])
        {
            Caption = 'Training Organization Name';
        }
        field(20; "Avaliação"; Text[30])
        {
            Caption = 'Score';
        }
        field(32; "Iniciativa da Formação"; Option)
        {
            Caption = 'Training Origin';
            Description = 'RU';
            OptionCaption = 'Da responsabilidade do empregador,Da iniciativa do trabalhador,Da iniciativa da empresa utilizadora de mão-de-obra';
            OptionMembers = "01","02","03";
        }
        field(34; "Horário Formação"; Option)
        {
            Caption = 'Training Schedule';
            Description = 'RU';
            OptionCaption = 'Laboral,Pós-Laboral,Misto';
            OptionMembers = "01","02","03";
        }
        field(37; "Tipo Certificado/Diploma"; Code[10])
        {
            Caption = 'Certificate Type';
            Description = 'RU';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(Cert));
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Cód. Acção", "Data Início")
        {
            Clustered = true;
        }
        key(Key2; "Employee No.", "Data Início", Tipo)
        {
        }
        key(Key3; "Cód. Acção", "Employee No.", "Data Início")
        {
        }
        key(Key4; "Data Início", "Cód. Acção", "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //2008.05.04 - Valida o nº máximo de inscrições
        if TabAccoesFormacao.Get("Cód. Acção") then begin
            TabAccoesFormacao.CalcFields(TabAccoesFormacao."Participantes Inscritos");
            if TabAccoesFormacao."Participantes Inscritos" >= TabAccoesFormacao."Max. Participantes" then
                Error(Text0001);
        end;
    end;

    var
        TabAccoesFormacao: Record "Acções Formação";
        Text0001: Label 'Execedeu o limite de inscrições permitidas para esta Acção de Formação.';
        RuTabelas: Record "RU - Tabelas";
}

