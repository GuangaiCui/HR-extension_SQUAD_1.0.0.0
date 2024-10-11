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
            Caption = 'Cóodigo';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Descrição';
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
            //Caption = 'Contract Type';
            OptionCaption = ' ,Sem Termo,A Termo,Por Tempo Indeterminado,Contrato de trabalho temporário,Situação Residual';
            OptionMembers = " ","Sem Termo","A Termo","Por Tempo Indeterminado","Contrato de trabalho temporário","Situação Residual";
        }
        field(5; "Cód. Tipo Contrato"; Code[10])
        {
            //Caption = 'Contract Type Code';
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
            //Caption = 'Contract Type Description';
            Description = 'RU';
        }
        field(10; "Data Filtro Inicio"; Date)
        {
            //Caption = 'Start Date Filter';
            FieldClass = FlowFilter;
        }
        field(11; "Data Filtro Fim"; Date)
        {
            //Caption = 'End Date Filter';
            FieldClass = FlowFilter;
        }
        field(20; "Template Contrato"; BLOB)
        {
            //Caption = 'Contract Template';
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
        AFSFileClient: Codeunit "AFS File Client";

    //RH_MIG_VC.S
    procedure ImportarContrato()
    var
        Text011: Label 'Selecionar o Caminho do Documento';
        Text006: Label 'O ficheiro %1 foi importado com sucesso!';
        OutStr: OutStream;
        InStr: InStream;
        tempFileName: Text;

    begin
        Clear(tempFileName);
        UploadIntoStream(Text011, '', 'Word (*.doc*)|*.doc*', tempFileName, InStr);
        if tempFileName <> '' then begin
            rec."Template Contrato".CreateOutStream(OutStr);
            CopyStream(OutStr, InStr);
            rec.Modify();
            if rec."Template Contrato".HasValue then
                Message(Text006, tempFileName);
        end;
    end;

    procedure ExportarContrato()
    var
        ResponseStream: InStream;
        tempFileName: Text;
        ErrorAttachment: Label ' No File Available.';

    begin
        Rec.CalcFields("Template Contrato");
        if rec."Template Contrato".HasValue then begin

            rec."Template Contrato".CreateInStream(ResponseStream);
            clear(tempFileName);
            tempFileName := Format(Code) + '.doc';
            DownloadFromStream(ResponseStream, 'Export', '', 'AllFiles (*.*)|*.*', tempFileName);
        end
        else
            Error(Text001);
    end;
    /*

        procedure VisualizarContrato()
        var

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
        end;*/
    //RH_MIG_VC.E
}

