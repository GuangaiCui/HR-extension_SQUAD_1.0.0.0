codeunit 53039 "Gerar Relatório Único"
{

    trigger OnRun()
    var
        TempBlob: Codeunit "Temp Blob";
        inStream: InStream;
    begin

        if ConfRH.Get then;
        ConfRH.TestField(ConfRH."Caminho Exportação Rel. Único");

        for i := 1 to 6 do begin
            Clear(OutputFile);
            Clear(OutPutStream);
            Clear(inStream);


            //IF i = 1 THEN FilePath := ConfRH."Caminho Exportação Rel. Único" + '\ru.xml';

            //JTP - Temoprário para testar os outros XMLPORTS
            if i = 1 then begin
                FileName := 'Zero.xml';
                //TempFilePath := ConfRH."Caminho Exportação Rel. Único" + '\Zero_tmp.xml';
            end;
            if i = 2 then FileName := 'QP.xml';
            if i = 3 then FileName := 'FEST.xml';
            if i = 4 then FileName := 'RFC.xml';
            if i = 5 then FileName := 'SST.xml';
            if i = 6 then FileName := 'GRV.xml';

            if FileName <> '' then begin
                if ConfRH.CheckIsFileExists(ConfRH."Caminho Exportação Rel. Único", FileName) then
                    ConfRH.DeleteFile(ConfRH."Caminho Exportação Rel. Único" + '/' + FileName);

                TempBlob.CreateOutStream(OutPutStream);

                //JTP - 2022/05/10 - Estava comentado no CPA - dimuídos os i's
                //if i = 1 then
                //    XMLPORT.Export(XMLPORT::"RU - SUL", OutPutStream);

                //JTP - Temporário para testar os outros XMLPORTS
                if i = 1 then begin
                    XMLPORT.Export(XMLPORT::"RU - Anexo 0", OutPutStream);
                    inStream := TempBlob.CreateInStream();
                    ConfRH.CreateFileFromInStream(ConfRH."Caminho Exportação Rel. Único" + '/' + FileName, inStream);
                    //ProcessAnexo(TempFilePath, FilePath, 'http://www.gep.mtss.gov.pt/sguri/ru/anexo_zero');

                    //Clean Empty tags //
                    //   XmlDoc := XmlDoc.XmlDocument();
                    //   XMLDoc.load(FilePath);
                end;
                if i = 2 then begin
                    XMLPORT.Export(XMLPORT::"RU - Anexo A - QP", OutPutStream);
                    inStream := TempBlob.CreateInStream();
                    ConfRH.CreateFileFromInStream(ConfRH."Caminho Exportação Rel. Único" + '/' + FileName, inStream);
                    //ProcessAnexo(TempFilePath, FilePath, 'http://www.gep.mtss.gov.pt/sguri/ru/anexo_qp');

                    //Clean Empty tags //
                    //  XmlDoc := XmlDoc.XmlDocument();
                    //  XMLDoc.load(TempFilePath);
                end;
                if i = 3 then begin
                    XMLPORT.Export(XMLPORT::"RU - Anexo B - FEST", OutPutStream);
                    inStream := TempBlob.CreateInStream();
                    ConfRH.CreateFileFromInStream(ConfRH."Caminho Exportação Rel. Único" + '/' + FileName, inStream);
                    ////ProcessAnexo(TempFilePath, FilePath, 'http://www.gep.mtss.gov.pt/sguri/ru/anexo_fest');

                    //Clean Empty tags //
                    //XmlDoc := XmlDoc.XmlDocument();
                    // XMLDoc.load(FilePath);
                end;
                if i = 4 then begin
                    //Normatica 2013.04.18 - para limpar as acções do ano anterior
                    rAccoesFormacao.Reset;
                    rAccoesFormacao.ModifyAll(rAccoesFormacao."Temp No. Accao", 0);
                    //Normatica 2013.04.18 - fim
                    XMLPORT.Export(XMLPORT::"RU - Anexo C - RFC", OutPutStream);
                    inStream := TempBlob.CreateInStream();
                    ConfRH.CreateFileFromInStream(ConfRH."Caminho Exportação Rel. Único" + '/' + FileName, inStream);
                    //ProcessAnexo(TempFilePath, FilePath, 'http://www.gep.msss.gov.pt/sguri/ru/anexo_rfc');

                    //Clean Empty tags //
                    // XmlDoc := XmlDoc.XmlDocument();
                    // XMLDoc.load(FilePath);
                end;
                if i = 5 then begin
                    XMLPORT.Export(XMLPORT::"RU - Anexo D - SST", OutPutStream);
                    inStream := TempBlob.CreateInStream();
                    ConfRH.CreateFileFromInStream(ConfRH."Caminho Exportação Rel. Único" + '/' + FileName, inStream);

                    // ProcessAnexo(TempFilePath, FilePath, 'http://www.gep.mtss.gov.pt/sguri/ru/anexo_sst');

                    //Clean Empty tags //
                    //XmlDoc := XmlDoc.XmlDocument();
                    //XMLDoc.load(FilePath);
                end;
                if i = 6 then begin
                    XMLPORT.Export(XMLPORT::"RU - Anexo E - GRV", OutPutStream);
                    inStream := TempBlob.CreateInStream();
                    ConfRH.CreateFileFromInStream(ConfRH."Caminho Exportação Rel. Único" + '/' + FileName, inStream);

                    //ProcessAnexo(TempFilePath, FilePath, 'http://www.gep.mtss.gov.pt/sguri/ru/anexo_grv');

                    //Clean Empty tags //
                    // XmlDoc := XmlDoc.XmlDocument();
                    // XMLDoc.load(FilePath);

                end;

                //    EmptyElements := xmlDoc.SelectNodes('//*[not(node())]');

                //   for j := EmptyElements.Count - 1 downto 0 do begin
                //         CurrNode := EmptyElements.Item(j);
                //         CurrNode.ParentNode.RemoveChild(CurrNode);

                //      end;

                //xmlDoc.Save(FilePath);

            end;

        end;

        Message(Text0002);

    end;



    var
        ConfRH: Record "Config. Recursos Humanos";
        OutputFile: File;
        OutPutStream: OutStream;
        TempFilePath: Text[250];
        FileName: Text[250];
        InputStream: InStream;
        i: Integer;
        j: Integer;
        Text0001: Label 'Relatório Único';
        Text0002: Label 'Os ficheiros foram criados com sucesso.';
        rAccoesFormacao: Record "Acções Formação";
    //XmlDoc: DotNet SystemXmlDocument;
    //CurrNode: DotNet SystemXmlNode;
    //EmptyElements: DotNet SystemXmlNodeList;


    //VC_MIG.S
    /*procedure ProcessAnexo(TempFilePath: Text[250]; FilePath: Text[250]; NameSpace: Text)

    var
        InPutFile: File;
        OutputFile: File;
        Line: Text;
        pos: Integer;

    begin
        if TempFilePath <> '' then begin
            InPutFile.TextMode := true;
            InPutFile.WriteMode := false;
            if InPutFile.open(TempFilePath) then begin

                if FilePath <> '' then begin
                    if Exists(FilePath) then
                        Erase(FilePath);


                    OutPutFile.TextMode := true;
                    OutPutFile.WriteMode := true;
                    OutputFile.Create(FilePath);
                    while InPutFile.read(Line) <> 0 do begin
                        pos := strpos(Line, 'xmlns="');
                        if pos <> 0 then
                            Line := CopyStr(Line, 1, pos + 6) +
                                    NameSpace +
                                    CopyStr(Line, pos + 7);
                        OutputFile.write(Line);
                    end;
                    OutputFile.Close();
                    InPutFile.Close();
                    Erase(TempFilePath);
                end;
            end;
        end;

    end;

*/
}

