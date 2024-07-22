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
        field(3; "No. Empregado"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                CreateDim(
                  DATABASE::Employee, "No. Empregado",
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
        field(19; "Cód. Rubrica"; Code[20])
        {
            TableRelation = "Rubrica Salarial";
        }
        field(20; "Descrição Rubrica"; Text[100])
        {
        }
        field(21; "Tipo Rubrica"; Option)
        {
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
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(43; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(110; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Para as horas extra';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(111; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'Para as horas extra';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            TableRelation = "Dimension Set Entry";
        }
    }

    keys
    {
        key(Key1; "Cód. Processamento", "Tipo Processamento", "No. Empregado", "No. Linha")
        {
            Clustered = true;
        }
        key(Key2; "No. Empregado")
        {
        }
        key(Key3; "No. Conta")
        {
        }
        key(Key4; "No. Empregado", "Cód. Rubrica")
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
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        OldDimSetID: Integer;
    begin
        SourceCodeSetup.Get;
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;

        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.GetDefaultDimID(TableID, No, SourceCodeSetup.Sales, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);
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

