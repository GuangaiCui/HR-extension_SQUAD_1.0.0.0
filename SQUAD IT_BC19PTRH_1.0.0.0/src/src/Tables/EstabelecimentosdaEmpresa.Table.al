table 53075 "Estabelecimentos da Empresa"
{
    DrillDownPageID = "Estabelecimentos da Empresa";
    LookupPageID = "Estabelecimentos da Empresa";

    fields
    {
        field(1; "Número da Unidade Local"; Code[4])
        {
            Caption = 'Local Unit No.';
        }
        field(2; "Descrição"; Text[200])
        {
            Caption = 'Description';
        }
        field(3; Morada; Text[200])
        {
            Caption = 'Address';
        }
        field(4; "Cód. Postal"; Code[10])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code".Code;

            trigger OnValidate()
            begin

                PostCode.ValidatePostCode(Cidade, "Cód. Postal", varCounty, País, (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(5; Cidade; Text[30])
        {
            Caption = 'City';

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(Cidade, "Cód. Postal", varCounty, País, (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(6; Telefone; Text[30])
        {
            Caption = 'Phone No.';
            Numeric = true;
        }
        field(7; Fax; Text[30])
        {
            Caption = 'Fax';
            Numeric = true;
        }
        field(8; Localidade; Text[100])
        {
            Caption = 'Town';
        }
        field(9; "País"; Code[10])
        {
            Caption = 'Country';
            TableRelation = "Country/Region";
        }
        field(10; "E-mail"; Text[60])
        {
            Caption = 'E-mail';
        }
        field(11; "Cód. Distrito/Concelho/Freg."; Code[6])
        {
            Caption = 'Parish/County/District Code';
            TableRelation = "Cód. Freguesia/Conc/Distrito"."Código";

            trigger OnValidate()
            begin

                TabCodFregueConcDist.Reset;
                if TabCodFregueConcDist.Get("Cód. Distrito/Concelho/Freg.") then
                    "Descrição Freguesia" := TabCodFregueConcDist.Freguesia;
            end;
        }
        field(12; "Descrição Freguesia"; Text[60])
        {
            // Caption = 'Parish';
        }
        field(15; "Instituição Seg. Social"; Code[20])
        {
            Caption = 'Social Security Office';
            Description = 'RU';
            TableRelation = "Instituição Seg. Social".Code;
        }
        field(20; "CAE Code"; Code[10])
        {
            Caption = 'Código CAE';
            TableRelation = "Actividades Económicas";

            trigger OnValidate()
            begin
                //HG - Preenche o campo CAE Description a partir da tabela Actividades Económicas
                TabActvidadesEcono.Reset;
                if TabActvidadesEcono.Get("CAE Code") then
                    "CAE Description" := TabActvidadesEcono.Descrição;
            end;
        }
        field(21; "CAE Description"; Text[180])
        {
            Caption = 'CAE Descrição';
        }
        field(50; "Data Inicio"; Date)
        {
            Caption = 'Start Date';
            Description = 'RU';
        }
        field(60; Sede; Boolean)
        {
            Caption = 'Head Office';
            Description = 'RU';
        }
        field(61; "ID Unidade Local"; Text[6])
        {
            Caption = 'Local Unit Id.';
            Description = 'RU';
        }
        field(60000; "Região"; Option)
        {
            Caption = 'Region';
            Description = 'HR.02 - BS';
            OptionCaption = 'Continente,R.A.Madeira,R.A.Açores';
            OptionMembers = Continente,"R.A.Madeira","R.A.Açores";
        }
    }

    keys
    {
        key(Key1; "Número da Unidade Local")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Número da Unidade Local", "Descrição", Morada, Telefone)
        {
        }
    }

    var
        PostCode: Record "Post Code";
        TabActvidadesEcono: Record "Actividades Económicas";
        TabCodFregueConcDist: Record "Cód. Freguesia/Conc/Distrito";
        varCounty: Text[30];
}

