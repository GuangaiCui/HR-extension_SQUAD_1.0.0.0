table 53113 "Integração Contabilistica"
{
    DrillDownPageID = "Lista Hist. Movs. Empregado";
    LookupPageID = "Lista Hist. Movs. Empregado";

    fields
    {
        field(1; "Cód. Processamento"; Code[10])
        {
        }
        field(2; "Tipo Processamento"; Option)
        {
            OptionCaption = 'Vencimentos,Encargos,Sub. Natal,Sub. Férias';
            OptionMembers = Vencimentos,Encargos,SubNatal,SubFerias;
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'No. Empregado';
            TableRelation = Empregado;

            trigger OnValidate()
            begin
                CreateDim(
                  DATABASE::Empregado, "Employee No.",
                  DATABASE::"Periodos Processamento", "Cód. Processamento");
            end;
        }
        field(4; "No. Linha"; Integer)
        {
        }
        field(6; "Data Registo"; Date)
        {
        }
        field(13; "Designação Empregado"; Text[75])
        {
        }
        field(19; "Payroll Item Code"; Code[20])
        {
            TableRelation = "Payroll Item";
        }
        field(20; "Payroll Item Description"; Text[100])
        {
            Caption = 'Descrição Rubrica';
        }
        field(21; "Payroll Item Type"; Option)
        {
            Caption = 'Tipo Rubrica';
            OptionCaption = 'Abono,Desconto';
            OptionMembers = Abono,Desconto;
        }
        field(25; "No. Conta"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(40; "Valor Débito"; Decimal)
        {
        }
        field(41; "Valor Crédito"; Decimal)
        {
        }
        field(42; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Cód. Atalho Dimensão 1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(43; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Cód. Atalho Dimensão 2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(110; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Cód. Dimensão 1 Global';
            Description = 'Para as horas extra';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(111; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Cód. Dimensão 2 Global';
            Description = 'Para as horas extra';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'ID Conj. Dimensões';
            TableRelation = "Dimension Set Entry";
        }
    }

    keys
    {
        key(Key1; "Cód. Processamento", "Tipo Processamento", "Employee No.", "No. Linha")
        {
            Clustered = true;
        }
        key(Key2; "Employee No.")
        {
        }
        key(Key3; "No. Conta")
        {
        }
        key(Key4; "Employee No.", "Payroll Item Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DimMgt: Codeunit DimensionManagement;


    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
        HRFunctions: Codeunit "Funções RH";

    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          HRFunctions.EditDimensionSet2(
            "Dimension Set ID", StrSubstNo('%1 %2', "Cód. Processamento", "Tipo Processamento"),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        if OldDimSetID <> "Dimension Set ID" then begin
            Modify;
        end;
    end;


    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: Integer;
        No: Code[20];
        OldDimSetID: Integer;
        DimMgt: Codeunit DimensionManagement;
        DefaultDimSource: List of [Dictionary of [Integer, code[20]]];
    begin
        SourceCodeSetup.Get;
        TableID := Type1;
        No := No1;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        OldDimSetID := "Dimension Set ID";

        //TODO:Check if the Dimension set ID is filled properly
        DimMgt.AddDimSource(DefaultDimSource, TableID, No);
        "Dimension Set ID" :=
          DimMgt.GetDefaultDimID(DefaultDimSource, SourceCodeSetup.Sales, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);


        if (OldDimSetID <> "Dimension Set ID") then begin
            Modify;
        end;
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if "Cód. Processamento" <> '' then
            Modify;
        if OldDimSetID <> "Dimension Set ID" then begin
            Modify;
        end;
    end;


}

