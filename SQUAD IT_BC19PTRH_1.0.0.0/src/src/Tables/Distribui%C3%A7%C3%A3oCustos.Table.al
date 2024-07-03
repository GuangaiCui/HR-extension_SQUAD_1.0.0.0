table 31003099 "Distribuição Custos"
{

    fields
    {
        field(1; "No. Empregado"; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Empregado."No.";

            trigger OnValidate()
            begin
                //CreateDim(
                //  DATABASE::Empregado,"No. Empregado");
            end;
        }
        field(7; Percentagem; Decimal)
        {
            Caption = 'Percentage';
            MaxValue = 1;
            MinValue = 0;
        }
        field(8; "Data Inicio"; Date)
        {
            Caption = 'Start Date';
        }
        field(9; "Data Fim"; Date)
        {
            Caption = 'End Date';
        }
        field(15; "No. Horas"; Decimal)
        {
            Caption = 'Total Time';

            trigger OnValidate()
            begin
                //HG - este código tem a ver com uma necessidade específica de que o
                //utilizador pode querer lançar para diferentes centros de custos
                // x horas de formação em vez de percentagem.
                //Então a aplicação tem em conta o Nº de horas Semanais desse
                //empregado e ao ser preenchida esta quantidade, o sistema preenche
                //automaticamente a percentagem tendo como referência o Nº de horas semanais.

                if TabEmpregado.Get("No. Empregado") then begin
                    TabEmpregado.TestField(TabEmpregado."No. Horas Semanais");
                    Percentagem := "No. Horas" * 100 / TabEmpregado."No. Horas Semanais" / 100;
                end;
            end;
        }
        field(21; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(22; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(83; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';

            trigger OnLookup()
            begin
                DimMgt.LookupDimValueCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(84; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';

            trigger OnLookup()
            begin
                DimMgt.LookupDimValueCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(85; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';

            trigger OnLookup()
            begin
                DimMgt.LookupDimValueCode(5, "Shortcut Dimension 5 Code");
            end;
        }
        field(86; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';

            trigger OnLookup()
            begin
                DimMgt.LookupDimValueCode(6, "Shortcut Dimension 6 Code");
            end;
        }
        field(87; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';

            trigger OnLookup()
            begin
                DimMgt.LookupDimValueCode(7, "Shortcut Dimension 7 Code");
            end;
        }
        field(88; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';

            trigger OnLookup()
            begin
                DimMgt.LookupDimValueCode(8, "Shortcut Dimension 8 Code");
            end;
        }
        field(89; "Dimension Set ID"; Integer)
        {
            Description = 'Dimensões';
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDocDim;
            end;
        }
    }

    keys
    {
        key(Key1; "No. Empregado", "Data Inicio", "Global Dimension 1 Code", "Global Dimension 2 Code", "Shortcut Dimension 3 Code", "Shortcut Dimension 4 Code", "Shortcut Dimension 5 Code", "Shortcut Dimension 6 Code", "Shortcut Dimension 7 Code", "Shortcut Dimension 8 Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        TabEmpregado: Record Empregado;
        rConfigRecursosHumanos: Record "Config. Recursos Humanos";
        DimMgt: Codeunit DimensionManagement;


    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
        HRFunctions: Codeunit "Funções RH";

    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          HRFunctions.EditDimensionSet2(
            "Dimension Set ID", StrSubstNo('%1 %2', "No. Empregado", "Data Inicio"),
            "Global Dimension 1 Code", "Global Dimension 2 Code");
        if OldDimSetID <> "Dimension Set ID" then begin
            Modify;
        end;
    end;


    procedure CreateDim(Type1: Integer; No1: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        OldDimSetID: Integer;
    begin
        SourceCodeSetup.Get;
        TableID[1] := Type1;
        No[1] := No1;
        "Global Dimension 1 Code" := '';
        "Global Dimension 2 Code" := '';
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.GetDefaultDimID(TableID, No, SourceCodeSetup.Sales, "Global Dimension 1 Code", "Global Dimension 2 Code", 0, 0);

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
        if "No. Empregado" <> '' then
            Modify;
        if OldDimSetID <> "Dimension Set ID" then begin
            Modify;
        end;
    end;
}

