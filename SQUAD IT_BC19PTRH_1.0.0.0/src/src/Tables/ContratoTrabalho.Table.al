table 53046 "Contrato Trabalho"
{
    Caption = 'Employment Contract';
    DataCaptionFields = "Code", Description;
    DrillDownPageID = "Contratos Trabalho";
    LookupPageID = "Contratos Trabalho";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "No. of Contracts"; Integer)
        {
            CalcFormula = Count("Contrato Empregado" WHERE("Cód. Contrato" = FIELD(Code),
                                                            "Data Inicio Contrato" = FIELD("Data Filtro Inicio"),
                                                            "Data Fim Contrato" = FIELD("Data Filtro Fim")));
            Caption = 'No. of Contracts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Tipo Contrato"; Option)
        {
            Caption = 'Contract Type';
            OptionCaption = ' ,Sem Termo,A Termo,Por Tempo Indeterminado,Contrato de trabalho temporário,Situação Residual';
            OptionMembers = " ","Sem Termo","A Termo","Por Tempo Indeterminado","Contrato de trabalho temporário","Situação Residual";
        }
        field(5; "Cód. Tipo Contrato"; Code[10])
        {
            Caption = 'Contract Type Code';
            Description = 'RU';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(TCont));

            trigger OnValidate()
            begin
                RUTabelas.Reset;
                RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::TCont);
                RUTabelas.SetRange(RUTabelas.Código, "Cód. Tipo Contrato");
                if RUTabelas.FindFirst then
                    "Desc. Tipo Contrato" := RUTabelas.Descrição
                else
                    "Desc. Tipo Contrato" := '';
            end;
        }
        field(6; "Desc. Tipo Contrato"; Text[100])
        {
            Caption = 'Contract Type Description';
            Description = 'RU';
        }
        field(10; "Data Filtro Inicio"; Date)
        {
            Caption = 'Start Date Filter';
            FieldClass = FlowFilter;
        }
        field(11; "Data Filtro Fim"; Date)
        {
            Caption = 'End Date Filter';
            FieldClass = FlowFilter;
        }
        field(20; "Template Contrato"; BLOB)
        {
            Caption = 'Contract Template';
            Compressed = false;
            Description = 'Funcionalidade Contratos';
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
        VarUserID: Text[30];
        SearchDirectory: Text[200];
        Path: Text[256];
        Filename: Text[256];
        PathFile: Text[256];
        Link: Text[255];
        AttachmentManagement: Codeunit AttachmentManagement;
        FuncoesRH: Codeunit "Funções RH";
        Text001: Label 'O não existe ficheiro associado ao contrato.';
        Text002: Label 'O contrato %1 foi exportado com sucesso!';
        RUTabelas: Record "RU - Tabelas";
        FileMgt: Codeunit "File Management";


    procedure ImportarContrato()
    var
        _varText: Text[255];
        _varTextA: Text[255];
        _varTextB: Text[255];
        _varTextC: Text[255];
        _varTextD: Text[255];
        _varTextE: Text[255];
        Text001: Label 'Selecionar o Caminho do Documento';
        Text002: Label '*.*';
        Text003: Label ' ';
        Text011: Label 'Selecionar o Caminho do Documento';
        Text012: Label '*.*';
        Text013: Label ' ';
        Text004: Label '*.doc';
        Text005: Label 'O ficheiro tem que ser do tipo .Doc ou .XDoc.';
        Text006: Label 'O ficheiro %1 foi importado com sucesso!';
    begin
        Clear(Link);

        Link := FileMgt.OpenFileDialog(Text011, Filename, Format('Word (*.doc*)|*.doc*'));
        if StrLen(Link) > 0 then begin
            "Template Contrato".Import(Link);
            Modify;
            Message(Text006, Link);
        end;
    end;


    procedure ExportarContrato()
    var
        Text011: Label 'Selecionar o Caminho do Documento';
        Text012: Label '*.*';
        Text013: Label ' ';
        _DestinoFile: Text[255];
        _DestinoFileAux: Text[255];
    begin
        CalcFields("Template Contrato");
        if "Template Contrato".HasValue then begin
            Clear(Link);
            Link := FuncoesRH.SaveDirectoryPath;
            Clear(_DestinoFile);
            _DestinoFile := Link + '\' + Format(Code) + '.doc';
            if (Link <> '') and (_DestinoFile <> '') then begin
                "Template Contrato".Export(_DestinoFile);
            end;
        end else
            Error(Text001);
    end;


    procedure VisualizarContrato()
    var
        [RunOnClient]
        DirectoryHelper: DotNet BCTestDirectory;
        environment: DotNet BCTestEnvironment;
    begin
        CalcFields("Template Contrato");
        if "Template Contrato".HasValue then begin
            VarUserID := UserId;
            SearchDirectory := Format(environment.GetEnvironmentVariable('temp')) + '\NAV_' + VarUserID;
            if not FileMgt.ClientDirectoryExists(SearchDirectory) then
                DirectoryHelper.CreateDirectory(SearchDirectory);
            Path := SearchDirectory + '\';
            Filename := Format(Code);
            PathFile := Path + Filename + '.DOC';
            if PathFile <> '' then begin
                "Template Contrato".Export(PathFile);
                HyperLink(PathFile);
            end;
        end else begin
            Error(Text001);
        end;
    end;
}

