table 31003056 "Contrato Empregado"
{
    DataCaptionFields = "Cód. Empregado";
    DrillDownPageID = "Lista Contrato Empregado";
    LookupPageID = "Lista Contrato Empregado";

    fields
    {
        field(1; "Cód. Empregado"; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Empregado."No.";
        }
        field(2; "No. Linha"; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Cód. Contrato"; Code[10])
        {
            Caption = 'Contract Code';
            TableRelation = "Contrato Trabalho".Code;

            trigger OnValidate()
            begin
                TabContratoTrabalho.Get("Cód. Contrato");
                Descrição := TabContratoTrabalho.Description;
                "Tipo Contrato" := TabContratoTrabalho."Tipo Contrato";
                "Cód. Tipo Contrato" := TabContratoTrabalho."Cód. Tipo Contrato";
            end;
        }
        field(4; "Descrição"; Text[50])
        {
            Caption = 'Description';
        }
        field(5; "Tipo Contrato"; Option)
        {
            Caption = 'Contract Type';
            OptionCaption = ',Sem Termo,A Termo,Por Tempo Indeterminado,A Termo p/ Cedência Temporária,Situação Residual';
            OptionMembers = ,"Sem Termo","A Termo","Por Tempo Indeterminado","A Termo p/ Cedência Temporária","Situação Residual";
        }
        field(6; "Duração Contrato"; Text[30])
        {
            Caption = 'Contract Duration';
        }
        field(7; "Data Inicio Contrato"; Date)
        {
            Caption = 'Contract Start Date';
        }
        field(8; "Data Fim Contrato"; Date)
        {
            Caption = 'Contract End Date';
        }
        field(9; "Cód. Motivo Terminação"; Code[10])
        {
            Caption = 'Termnation Reason Code';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(MotSai));
        }
        field(10; "Comentário"; Boolean)
        {
            CalcFormula = Exist("Linha Coment. Recurso Humano" WHERE("Table Name" = CONST(Cont),
                                                                      "No." = FIELD("Cód. Empregado"),
                                                                      "Table Line No." = FIELD("No. Linha")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "No. Contrato Trabalho"; Code[20])
        {
            Caption = 'Contract No.';
            Description = 'Funcionalidade Contratos';
            Editable = true;
        }
        field(20; "Ficheiro Contrato Trabalho"; BLOB)
        {
            Caption = 'Contract File';
            Compressed = false;
            Description = 'Funcionalidade Contratos';
            SubType = UserDefined;
        }
        field(22; "Extensão Ficheiro"; Text[4])
        {
            Caption = 'File Extension';
        }
        field(30; "Cód. Tipo Contrato"; Code[10])
        {
            Caption = 'Contract Type Code';
            Description = 'RU';
        }
        field(35; "Motivo Entrada"; Code[20])
        {
            Caption = 'Admission Reason';
            Description = 'RU';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(MEnt));
        }
        field(143; "Cod. Cliente"; Code[20])
        {
            Caption = 'Customer Code';
            Description = 'Funcionalidade Contratos - para facturar o Imposto Selo';
            TableRelation = Customer."No.";
        }
    }

    keys
    {
        key(Key1; "Cód. Empregado", "Cód. Contrato", "No. Linha")
        {
            Clustered = true;
        }
        key(Key2; "Cód. Empregado", "Data Inicio Contrato")
        {
        }
        key(Key3; "Tipo Contrato", "Data Fim Contrato")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if "No. Contrato Trabalho" <> '' then
            Error(Text004);
    end;

    var
        TabContratoTrabalho: Record "Contrato Trabalho";
        TabEmpregado: Record Empregado;
        Pergunta: Text[200];
        VarUserID: Text[30];
        SearchDirectory: Text[200];
        Path: Text[256];
        Filename: Text[256];
        PathFile: Text[256];
        Link: Text[255];
        AttachmentManagement: Codeunit AttachmentManagement;
        Text001: Label 'O não existe ficheiro associado ao contrato.';
        FuncoesRH: Codeunit "Funções RH";
        Text002: Label 'O contrato %1 foi exportado com sucesso!';
        text1: Text[512];
        text2: Text[512];
        fals: Boolean;
        tru: Boolean;
        wdfindas: Integer;
        wdreplaceon: Integer;
        Text003: Label 'Não existe ficheiro associado ao contrato.';
        ValorHoraTexto: Text[1024];
        ArrayExt: array[2] of Text[50];
        ReportCheck: Report Check;
        ArrayExt2: array[2] of Text[50];
        ContratoEmpregado: Record "Contrato Empregado";
        ContratoEmpregadoTEMP: Record "Contrato Empregado" temporary;
        Text004: Label 'Não pode eliminar linhas que têm um nº Contrato associado.';
        Text005: Label 'Este contrato ja se encontra registado.';
        Text006: Label 'Não pode importar o contrato porque o mesmo ja foi registado.';
        Text007: Label 'Não pode alterar o contrato de trabalho porque já foi gerado.';
        FileMgt: Codeunit "File Management";
        [RunOnClient]
        DirectoryHelper: DotNet BCTestDirectory;
        MyOutStream: OutStream;
        MyFile: File;
        wdRange: DotNet WordRange;
        wdDoc: DotNet WordDocument;
        wdApp: DotNet WordApplicationClass;


    procedure CriarContratoConformeTemplate()
    var
        _ContratoEmp: Record "Contrato Empregado";
        _DestinoFile: Text[255];
        _SaveFile: Boolean;
        _Emp: Record Empregado;
        _Habilita: Record "Habilitação";
        _Estab_Emp: Record "Estabelecimentos da Empresa";
        _Company: Record "Company Information";
        _HabLitForm: Record "Habilitação";
        _HabLitText: Text[1024];
        _DataText: Text[1024];
        _PostCode: Record "Post Code";
        _Emp2: Record Empregado;
    begin

        if "No. Contrato Trabalho" <> '' then
            Error(Text006);

        if TabContratoTrabalho.Get("Cód. Contrato") then begin
            TabContratoTrabalho.CalcFields("Template Contrato");
            if TabContratoTrabalho."Template Contrato".HasValue then begin
                VarUserID := UserId;
                SearchDirectory := Format('C:\temp') + '\NAV_' + VarUserID;
                if not FileMgt.ClientDirectoryExists(SearchDirectory) then
                    DirectoryHelper.CreateDirectory(SearchDirectory);

                Path := Format('C:\temp') + '\NAV_' + VarUserID + '\';
                _DestinoFile := Path + Format("Cód. Empregado") + '-' + Format("Cód. Contrato") + '.DOC';
                if (Path <> '') and (_DestinoFile <> '') then
                    TabContratoTrabalho."Template Contrato".Export(_DestinoFile);
            end;

            wdApp := wdapp.ApplicationClass();

            wdApp.Documents.Add(_DestinoFile);

            _Company.Get;

            text1 := '«EMPRESA NOME»';
            text2 := _Company.Name;
            fals := false;
            tru := true;
            wdfindas := 0;
            wdreplaceon := 2;
            wdApp.Width := 7;
            wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);

            text1 := '«EMPRESA N CONTRIB»';
            text2 := _Company."VAT Registration No.";
            fals := false;
            tru := true;
            wdfindas := 0;
            wdreplaceon := 2;
            wdApp.Width := 7;
            wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);

            text1 := '«EMPRESA ENDERECO»';
            if _Company."Address 2" = '' then
                text2 := _Company.Address
            else
                text2 := _Company.Address + ' ' + _Company."Address 2";
            fals := false;
            tru := true;
            wdfindas := 0;
            wdreplaceon := 2;
            wdApp.Width := 7;
            wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);

            text1 := '«EMPRESA COD POSTAL»';
            text2 := _Company."Post Code";
            fals := false;
            tru := true;
            wdfindas := 0;
            wdreplaceon := 2;
            wdApp.Width := 7;
            wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);

            text1 := '«EMPRESA CIDADE»';
            text2 := _Company.City;
            fals := false;
            tru := true;
            wdfindas := 0;
            wdreplaceon := 2;
            wdApp.Width := 7;
            wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);

            text1 := '«CONSERV. REG. COMERCIAL»';
            text2 := _Company."PTSS Registration Authority";
            fals := false;
            tru := true;
            wdfindas := 0;
            wdreplaceon := 2;
            wdApp.Width := 7;
            wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);

            text1 := '«N REGISTO»';
            text2 := _Company."Registration No.";
            fals := false;
            tru := true;
            wdfindas := 0;
            wdreplaceon := 2;
            wdApp.Width := 7;
            wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);

            text1 := '«NIF EMPRESA»';
            text2 := _Company."VAT Registration No.";
            fals := false;
            tru := true;
            wdfindas := 0;
            wdreplaceon := 2;
            wdApp.Width := 7;
            wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);

            text1 := '«DESCRICAO CAE»';
            text2 := _Company."PTSS CAE Description";
            fals := false;
            tru := true;
            wdfindas := 0;
            wdreplaceon := 2;
            wdApp.Width := 7;
            wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);

            if _Emp.Get("Cód. Empregado") then begin

                text1 := '«NOME»';
                text2 := _Emp.Name;
                fals := false;
                tru := true;
                wdfindas := 0;
                wdreplaceon := 2;
                wdApp.Width := 7;
                wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);

                text1 := '«NACIONALIDADE»';
                text2 := _Emp."Nacionalidade Descrição";
                fals := false;
                tru := true;
                wdfindas := 0;
                wdreplaceon := 2;
                wdApp.Width := 7;
                wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);

                text1 := '«MORADA COMPLETA»';
                text2 := _Emp.Address + ' ' + _Emp."Address 2" + ' ' + _Emp."Post Code" + ' ' + _Emp.City;
                fals := false;
                tru := true;
                wdfindas := 0;
                wdreplaceon := 2;
                wdApp.Width := 7;
                wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);

                text1 := '«NIF EMPREGADO»';
                text2 := _Emp."No. Contribuinte";
                fals := false;
                tru := true;
                wdfindas := 0;
                wdreplaceon := 2;
                wdApp.Width := 7;
                wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);

                text1 := '«TIPO DOC IDENTIFICACAO»';
                if _Emp."Documento Identificação" <> 0 then
                    text2 := Format(_Emp."Documento Identificação")
                else
                    //text2:= FORMAT(_Emp."Outros Documentos");
                    fals := false;
                tru := true;
                wdfindas := 0;
                wdreplaceon := 2;
                wdApp.Width := 7;
                wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);

                text1 := '«N DOC IDENT»';
                text2 := _Emp."No. Doc. Identificação";
                fals := false;
                tru := true;
                wdfindas := 0;
                wdreplaceon := 2;
                wdApp.Width := 7;
                wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);

                text1 := '«DATA VAL DOC IDENT»';
                if _Emp."Documento Identificação" <> 0 then
                    text2 := Format(_Emp."Data Validade Doc. Ident.")
                else
                    //text2:= FORMAT(_Emp."Data Validade Outros Doc");

                    fals := false;
                tru := true;
                wdfindas := 0;
                wdreplaceon := 2;
                wdApp.Width := 7;
                wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);


                text1 := '«ESTADO CIVIL»';
                text2 := Format(_Emp."Estado Civil");
                fals := false;
                tru := true;
                wdfindas := 0;
                wdreplaceon := 2;
                wdApp.Width := 7;
                wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);




                text1 := '«LOCAL EMISSAO»';
                text2 := _Emp."Local Emissão Doc. Ident.";
                fals := false;
                tru := true;
                wdfindas := 0;
                wdreplaceon := 2;
                wdApp.Width := 7;
                wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);

                text1 := '«N HORAS SEMANAIS»';
                text2 := Format(_Emp."No. Horas Semanais");
                fals := false;
                tru := true;
                wdfindas := 0;
                wdreplaceon := 2;
                wdApp.Width := 7;
                wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);


                text1 := '«DISTRITO»';
                text2 := _Emp.County;
                fals := false;
                tru := true;
                wdfindas := 0;
                wdreplaceon := 2;
                wdApp.Width := 7;
                wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);


                _Emp.CalcFields(_Emp."Cód. Cat. Prof QP");
                text1 := '«CATEGORIA PROFISSIONAL»';
                text2 := _Emp."Descrição Cat Prof QP";
                fals := false;
                tru := true;
                wdfindas := 0;
                wdreplaceon := 2;
                wdApp.Width := 7;
                wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);


                text1 := '«VENCIMENTO BASE»';
                text2 := Format(_Emp."Valor Vencimento Base");
                fals := false;
                tru := true;
                wdfindas := 0;
                wdreplaceon := 2;
                wdApp.Width := 7;
                wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);


                text1 := '«DATA INI CONTRATO»';
                text2 := Format("Data Inicio Contrato");
                fals := false;
                tru := true;
                wdfindas := 0;
                wdreplaceon := 2;
                wdApp.Width := 7;
                wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);

                text1 := '«DATA FIM CONTRATO»';
                text2 := Format("Data Fim Contrato");
                fals := false;
                tru := true;
                wdfindas := 0;
                wdreplaceon := 2;
                wdApp.Width := 7;
                wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);


                text1 := '«data de trabalho»';
                text2 := Format(WorkDate);
                fals := false;
                tru := true;
                wdfindas := 0;
                wdreplaceon := 2;
                wdApp.Width := 7;
                wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);


                text1 := '«HAB LITERARIAS»';
                text2 := _Emp."Descrição Habilitações";
                fals := false;
                tru := true;
                wdfindas := 0;
                wdreplaceon := 2;
                wdApp.Width := 7;
                wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);

            end;

            _Estab_Emp.Reset;
            _Estab_Emp.SetRange(_Estab_Emp."Número da Unidade Local", _Emp.Estabelecimento);
            if _Estab_Emp.FindFirst then begin
                text1 := '«ESTABELECIMENTO»';
                text2 := _Estab_Emp.Descrição;
                fals := false;
                tru := true;
                wdfindas := 0;
                wdreplaceon := 2;
                wdApp.Width := 7;
                wdApp.Selection.Find.Execute(text1, fals, fals, fals, fals, fals, tru, wdfindas, fals, text2, wdreplaceon);
            end;

            /////////////////////////
            //Fim preencher template Word
            /////////////////////////

            wdApp.Visible := true;
            wdApp.ActiveDocument.Fields.Unlink;
            Clear(wdDoc);
            Clear(wdApp);

        end;
    end;


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
        Text004: Label '*.pdf';
        Text005: Label 'O ficheiro tem que ser do tipo PDF.';
        Text006: Label 'O ficheiro %1 foi importado com sucesso!';
    begin
        //Funcionalidade Contratos
        //Permite importar uma template para este empregado, para este contrato

        if "No. Contrato Trabalho" <> '' then
            Error(Text006);

        Clear(_varText);
        Clear(Link);

        Link := FileMgt.OpenFileDialog(Text011, Filename, Format(Text004));
        if StrLen(Link) > 0 then begin
            _varText := CopyStr(Link, (StrLen(Link) - 3), 5);

            if (UpperCase(_varText) <> '.PDF') then
                Error(Text005);

            if StrLen(Link) > 0 then begin
                "Ficheiro Contrato Trabalho".Import(Link);
                "Extensão Ficheiro" := '.PDF';
                Modify;
                Message(Text006, Link);
            end;
        end;
        Modify;
    end;


    procedure ExportarContrato()
    var
        Text011: Label 'Selecionar o Caminho do Documento';
        Text012: Label '*.*';
        Text013: Label ' ';
        _DestinoFile: Text[255];
        _DestinoFileAux: Text[255];
    begin
        //Funcionalidade Contratos
        //Permite exportar o contrato previamente importado

        CalcFields("Ficheiro Contrato Trabalho");
        if "Ficheiro Contrato Trabalho".HasValue then begin

            Clear(Link);
            Link := FuncoesRH.SaveDirectoryPath;

            Clear(_DestinoFile);

            _DestinoFile := Link + Format("Cód. Empregado") + '-' + Format("Cód. Contrato") + "Extensão Ficheiro";
            if (Link <> '') and (_DestinoFile <> '') then begin
                Link := "Ficheiro Contrato Trabalho".Export(_DestinoFile);
            end;
        end else
            Error(Text001);
    end;


    procedure VisualizarContrato()
    begin
        //Funcionalidade Contratos
        //Abre o contrato, mostrando-0

        //CLEAR(rtFileSystem);
        CalcFields("Ficheiro Contrato Trabalho");
        if "Ficheiro Contrato Trabalho".HasValue then begin
            VarUserID := UserId;
            SearchDirectory := Format('C:\temp') + '\NAV_' + VarUserID;

            if not FileMgt.ClientDirectoryExists(SearchDirectory) then
                DirectoryHelper.CreateDirectory(SearchDirectory);

            Path := Format('C:\temp') + '\NAV_' + VarUserID + '\';
            Filename := Format("Cód. Empregado") + '_' + Format("Cód. Contrato");

            PathFile := Path + Filename + "Extensão Ficheiro";

            if PathFile <> '' then begin
                "Ficheiro Contrato Trabalho".Export(PathFile);
                HyperLink(PathFile);
            end;
        end else begin
            Error(Text001);
        end;
    end;
}

