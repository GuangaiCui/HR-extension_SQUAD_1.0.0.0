codeunit 53045 Itimews
{
    trigger OnRun()
    begin
        siglaEmpresa := 'WEBDEMO';
        endpoint := 'https://itimeweb.com:9876/itimews/itimews.asmx';

        SetUtilizadores(true);
        SetRubricas(true);
    end;


    #region SERVICE CALLS
    local procedure GetUtilizadores()
    var
        soapContentRequest: Text;
        soapAction: Text;
        xmlNodeListRes: XmlNodeList;
        index: Integer;
        xmlNode: XmlNode;
        numero: Text;
        nome: Text;
    begin
        soapContentRequest :=
            '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:itim="https://itimeweb.com/">' +
                '<soap:Header/>' +
                '<soap:Body>' +
                    '<itim:getUtilizadores>' +
                        '<itim:sigla>' + siglaEmpresa + '</itim:sigla>' +
                    '</itim:getUtilizadores>' +
                '</soap:Body>' +
            '</soap:Envelope>';

        soapAction := 'https://itimeweb.com/getUtilizadores';


        xmlNodeListRes := GetNodes(MakeCall(soapContentRequest, soapAction), '//*[local-name()="cUtilizadores"]');

        for index := 1 to xmlNodeListRes.Count() do begin
            Clear(xmlNode);
            Clear(numero);
            Clear(nome);
            xmlNodeListRes.Get(index, xmlNode);
            numero := GetValueFromNode('//*[local-name()="nNumero"]', xmlNode);
            nome := GetValueFromNode('//*[local-name()="mNome"]', xmlNode);
        end;
    end;

    /// <summary>
    /// Sincronizes all "Empregados" table with the Itime system.
    /// </summary>
    local procedure SetUtilizadores(runAsDemo: Boolean)
    var
        empregados: Record Empregado;
        soapContentRequest: Text;
        soapAction: Text;
        name: Text;
        no: Text;
        dataIni: Text;
        dataFim: Text;
        contratoEmpregado: Record "Contrato Empregado";
    begin
        if empregados.FindSet() then
            repeat
                Clear(no);
                Clear(name);
                Clear(dataFim);
                Clear(dataIni);

                no := empregados."No.";
                name := empregados.Name;

                Clear(contratoEmpregado);
                if contratoEmpregado.Get(empregados."No.") then begin
                    dataIni := Format(contratoEmpregado."Data Inicio Contrato", 0, '<Year4>-<Month>-<Day>');
                    dataFim := Format(contratoEmpregado."Data Fim Contrato", 0, '<Year4>-<Month>-<Day>');

                    if contratoEmpregado."Data Fim Contrato" <> 0D then begin
                        dataFim := Format(contratoEmpregado."Data Fim Contrato", 0, '<Year4>-<Month>-<Day>');
                    end else begin
                        dataFim := '2099-01-01';
                    end;
                end;

                if runAsDemo = true then begin
                    soapContentRequest :=
                                    '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:itim="https://itimeweb.com/">' +
                                    '<soap:Header/>' +
                                    '<soap:Body>' +
                                        '<itim:setUtilizador>' +
                                            '<itim:nNumero>' + no + '</itim:nNumero>' +
                                            '<itim:mNome>' + 'NOME_SQ' + '</itim:mNome>' +
                                            '<itim:dataini>' + '2022-01-01' + '</itim:dataini>' +
                                            '<itim:datafim>' + '2040-01-01' + '</itim:datafim>' +
                                            '<itim:sigla>' + 'WEBDEMO' + '</itim:sigla>' +
                                        '</itim:setUtilizador>' +
                                    '</soap:Body>' +
                                    '</soap:Envelope>';
                end else begin
                    soapContentRequest :=
                                    '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:itim="https://itimeweb.com/">' +
                                    '<soap:Header/>' +
                                    '<soap:Body>' +
                                        '<itim:setUtilizador>' +
                                            '<itim:nNumero>' + no + '</itim:nNumero>' +
                                            '<itim:mNome>' + name + '</itim:mNome>' +
                                            '<itim:dataini>' + dataIni + '</itim:dataini>' +
                                            '<itim:datafim>' + dataFim + '</itim:datafim>' +
                                            '<itim:sigla>' + siglaEmpresa + '</itim:sigla>' +
                                        '</itim:setUtilizador>' +
                                    '</soap:Body>' +
                                    '</soap:Envelope>';
                end;

                soapAction := 'https://itimeweb.com/setUtilizador';

                MakeCall(soapContentRequest, soapAction);

            until empregados.Next() = 0
    end;

    /// <summary>
    /// Syncronizes all Payroll Items with itime system.
    /// </summary>
    local procedure SetRubricas(runAsDemo: Boolean)
    var
        rubrica: Record "Payroll Item";
        soapContentRequest: Text;
        soapAction: Text;
    begin

        soapAction := 'https://itimeweb.com/setRubricas';

        if rubrica.FindSet() then
            repeat
                Clear(soapContentRequest);

                if runAsDemo = true then begin
                    soapContentRequest :=
                                   '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:itim="https://itimeweb.com/">' +
                                    '<soapenv:Header/>' +
                                    '<soapenv:Body>' +
                                        '<itim:setRubricas>' +
                                            '<itim:sigla>' + 'WEBDEMO' + '</itim:sigla>' +
                                            '<itim:cRubrica>' + 'CODE_SQ' + '</itim:cRubrica>' +
                                            '<itim:nRubrica>' + 'DESCRIPTION' + '</itim:nRubrica>' +
                                            '<itim:tipo></itim:tipo>' +
                                        '</itim:setRubricas>' +
                                    '</soapenv:Body>' +
                                    '</soapenv:Envelope>';
                end else begin
                    soapContentRequest :=
                                   '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:itim="https://itimeweb.com/">' +
                                    '<soapenv:Header/>' +
                                    '<soapenv:Body>' +
                                        '<itim:setRubricas>' +
                                            '<itim:sigla>' + siglaEmpresa + '</itim:sigla>' +
                                            '<itim:cRubrica>' + rubrica."Código" + '</itim:cRubrica>' +
                                            '<itim:nRubrica>' + rubrica."Descrição" + '</itim:nRubrica>' +
                                            '<itim:tipo></itim:tipo>' +
                                        '</itim:setRubricas>' +
                                    '</soapenv:Body>' +
                                    '</soapenv:Envelope>';
                end;


                MakeCall(soapContentRequest, soapAction);

            until rubrica.Next() = 0
    end;

    /// <summary>
    /// Syncronizes the vacation days with itime.
    /// </summary>
    local procedure SetDireitoFerias()
    begin
        //TOOD. Que tabela dá match
    end;
    #endregion

    #region SOAP REQUEST AND XML PROCESSING
    /// <summary>
    /// Gets all nodes from an doc
    /// </summary>
    /// <param name="xmlDoc">The document to query</param>
    /// <param name="regExp">Regular expression to query the doc</param>
    /// <returns></returns>
    local procedure GetNodes(xmlDoc: XmlDocument; regExp: Text): XmlNodeList
    var
        nodes: XmlNodeList;
    begin
        xmlDoc.SelectNodes(regExp, nodes);
        exit(nodes);
    end;

    /// <summary>
    /// Gets a text value from a node.
    /// </summary>
    /// <param name="value">regular expression to query the inner node.</param>
    /// <param name="xmlNode">the node to query</param>
    /// <returns></returns>
    local procedure GetValueFromNode(regex: Text; xmlNode: XmlNode): Text
    var
        node: XmlNode;
    begin
        xmlNode.SelectSingleNode(regex, node);
        if node.IsXmlElement() then begin
            exit(node.AsXmlElement().InnerText());
        end;
    end;


    /// <summary>
    /// Makes a generic call to a Soap service
    /// </summary>
    /// <param name="soapContentRequest"></param>
    /// <returns>a XmlDocument containing the response</returns>
    local procedure MakeCall(soapContentRequest: Text; soapAction: Text): XmlDocument
    var
        client: HttpClient;
        content: HttpContent;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        contentHeaders: HttpHeaders;
        requestHeaders: HttpHeaders;
        responseText: Text;
        xmlDoc: XmlDocument;
    begin
        content.WriteFrom(soapContentRequest);

        //Headers
        content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/soap+xml;charset=utf-8;action="' + soapAction + '"');
        //contentHeaders.Add('Content-Type', 'text/xml;charset=UTF-8');
        //contentHeaders.Add('SOAPAction', soapAction);

        //Uri and content
        request.SetRequestUri(endpoint);
        request.Method('POST');
        request.Content := content;

        client.Send(request, response);

        if response.HttpStatusCode = 200 then begin
            response.Content.ReadAs(responseText);
            //Tratar do XML
            XmlDocument.ReadFrom(responseText, xmlDoc);
            exit(xmlDoc);
        end else begin
            exit(xmlDoc);
        end;
    end;

    #endregion

    local procedure LogMessage(message: Text)
    begin

    end;

    var
        endpoint: Text;
        siglaEmpresa: Text;
}