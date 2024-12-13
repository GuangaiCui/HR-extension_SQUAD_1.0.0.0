codeunit 53045 Itimews
{
    trigger OnRun()
    begin
        siglaEmpresa := 'WEBDEMO';
        endpoint := 'https://itimeweb.com:9876/itimews/itimews.asmx';

        SetUtilizadoresFull();
        SetRubricas();
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

    local procedure GetUtilizadoresFull()
    var
        soapContentRequest: Text;
        soapAction: Text;
        xmlNodeListRes: XmlNodeList;
        index: Integer;
        xmlNode: XmlNode;
        empregados: Record Empregado;
        numero: Text;
        lastUpdate: Text;
        lastUpdateDate: Date;
        dataInicioDate: Date;
        dataFimDate: Date;
        validateBIDate: Date;
        dataNascimentoDate: Date;
    begin
        soapAction := 'https://itimeweb.com/getUtilizadoresFull';

        soapContentRequest :=
            '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:itim="https://itimeweb.com/">' +
                '<soap:Header/>' +
                '<soap:Body>' +
                    '<itim:getUtilizadoresFull>' +
                        '<itim:sigla>' + siglaEmpresa + '</itim:sigla>' +
                    '</itim:getUtilizadoresFull>' +
                '</soap:Body>' +
            '</soap:Envelope>';

        xmlNodeListRes := GetNodes(MakeCall(soapContentRequest, soapAction), '//*[local-name()="cUtilizadoresFull"]');

        for index := 1 to xmlNodeListRes.Count() do begin
            Clear(xmlNode);
            Clear(numero);
            Clear(validateBIDate);

            empregados.Reset();
            xmlNodeListRes.Get(index, xmlNode);
            numero := GetValueFromNode('//*[local-name()="nNumero"]', xmlNode);
            lastUpdate := GetValueFromNode('//*[local-name()="lastUpdate"]', xmlNode);

            if empregados.Get(numero) then begin
                Clear(lastUpdateDate);
                Evaluate(lastUpdateDate, lastUpdate);

                if empregados."Last Date Modified" < lastUpdateDate then begin
                    //Updates empregado
                    Clear(dataInicioDate);
                    Clear(dataFimDate);
                    Clear(dataNascimentoDate);
                    Clear(validateBIDate);

                    empregados.Name := GetValueFromNode('//*[local-name()="mNome"]', xmlNode);

                    Evaluate(dataInicioDate, GetValueFromNode('//*[local-name()="dataini"]', xmlNode));
                    empregados."Employment Date" := dataInicioDate;

                    Evaluate(dataInicioDate, GetValueFromNode('//*[local-name()="datafim"]', xmlNode));
                    empregados."End Date" := dataInicioDate;

                    empregados.Address := GetValueFromNode('//*[local-name()="nMorada"]', xmlNode);
                    empregados."Post Code" := GetValueFromNode('//*[local-name()="nCodPostal"]', xmlNode);
                    empregados."No. Doc. Identificação" := GetValueFromNode('//*[local-name()="nBI"]', xmlNode);
                    empregados."No. Contribuinte" := GetValueFromNode('//*[local-name()="nNIF"]', xmlNode);


                    Evaluate(validateBIDate, GetValueFromNode('//*[local-name()="nValidadeBI"]', xmlNode));
                    empregados."Data Validade Doc. Ident." := validateBIDate;

                    Evaluate(dataNascimentoDate, GetValueFromNode('//*[local-name()="nDataNascimento"]', xmlNode));
                    empregados."Birth Date" := dataNascimentoDate;
                    //empregados."Estado Civil" := GetValueFromNode('//*[local-name()="nEstadoCivil"]', xmlNode); //potencial problemas com o option
                    empregados."Mobile Phone No." := GetValueFromNode('//*[local-name()="nTelefone"]', xmlNode);
                end;
            end;
        end;
    end;

    /// <summary>
    /// Sincronizes all "Empregados" table with the Itime system.
    /// </summary>
    local procedure SetUtilizadores_notused(runAsDemo: Boolean)
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
    /// Sincronza os utilizadores
    /// </summary>
    local procedure SetUtilizadoresFull()
    var
        empregado: Record Empregado;
        soapContentRequest: Text;
        soapAction: Text;
        codigoDepartamento: Code[20];
        descricaoDepartamento: Text;
        defaultDimensions: Record "Default Dimension";
        feriasEmpregados: Record "Férias Empregados";
        dataInicio: Text;
        dataFim: Text;
        numeroBi: Text;
        validadeBi: Text;
        dataNascimento: Text;
        nFeriasAnoAtual: Integer;
        nFeriasAnoAnterior: Integer;
        anoFerias: Integer;
    begin
        soapAction := 'https://itimeweb.com/setUtilizadorFull';

        //empregado.SetFilter(Status, Format(empregado.Status::Active)); //TODO: Validar
        empregado.SetRange(Status, empregado.Status::Active);
        if empregado.FindSet() then
            repeat
                Clear(dataInicio);
                Clear(dataFim);
                Clear(validadeBi);
                Clear(numeroBi);
                Clear(dataNascimento);
                Clear(descricaoDepartamento);
                Clear(codigoDepartamento);
                anoFerias := 0;
                nFeriasAnoAtual := 0;
                nFeriasAnoAnterior := 0;

                if empregado."Employment Date" <> 0D then begin
                    dataInicio := FORMAT(empregado."Employment Date", 0, '<Year4>-<Month>-<Day>');
                end;

                if empregado."End Date" <> 0D then begin
                    dataFim := FORMAT(empregado."End Date", 0, '<Year4>-<Month>-<Day>');
                end;

                if (empregado."Documento Identificação" = empregado."Documento Identificação"::BI) or
                (empregado."Documento Identificação" = empregado."Documento Identificação"::"Cartão Cidadão")
                then begin
                    numeroBi := empregado."No. Doc. Identificação";
                    validadeBi := FORMAT(empregado."Data Doc. Ident.", 0, '<Year4>-<Month>-<Day>');
                end;

                if empregado."Birth Date" <> 0D then begin
                    dataNascimento := FORMAT(empregado."Birth Date", 0, '<Year4>-<Month>-<Day>');
                end;

                defaultDimensions.Reset();
                defaultDimensions.SetFilter("No.", empregado."No.");
                defaultDimensions.SetFilter("Dimension Code", 'DEPARTMENT'); //TODO: Validar isto
                if defaultDimensions.FindFirst() then begin
                    codigoDepartamento := defaultDimensions."Dimension Value Code";
                    descricaoDepartamento := defaultDimensions."Dimension Value Name";
                end;

                feriasEmpregados.Reset();
                feriasEmpregados.SetFilter("Employee No.", empregado."No.");
                feriasEmpregados.SetFilter("Ano a que se refere", Format(Date2DMY(Today, 3)));
                if feriasEmpregados.Count() > 0 then begin
                    nFeriasAnoAtual := feriasEmpregados.Count();
                    anoFerias := Date2DMY(Today, 3);
                end;

                feriasEmpregados.Reset();
                feriasEmpregados.SetFilter("Employee No.", empregado."No.");
                feriasEmpregados.SetFilter("Ano a que se refere", Format(Date2DMY(Today, 3) - 1));
                feriasEmpregados.SetFilter(Gozada, Format(false));
                if feriasEmpregados.Count() > 0 then begin
                    nFeriasAnoAnterior := feriasEmpregados.Count();
                    anoFerias := Date2DMY(Today, 3);
                end;

                soapContentRequest :=
                '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:itim="https://itimeweb.com/">' +
                '<soapenv:Header/>' +
                '<soapenv:Body>' +
                    '<itim:setUtilizadorFull>' +
                        '<itim:nNumero>' + empregado."No." + '</itim:nNumero>' +
                        '<itim:mNome>' + empregado.Name + '</itim:mNome>' +
                        '<itim:dataini>' + dataInicio + '</itim:dataini>' +
                        '<itim:datafim>' + dataFim + '</itim:datafim>' +
                        '<itim:sigla>' + siglaEmpresa + '</itim:sigla>' +
                        '<itim:nMorada>' + empregado.Address + '</itim:nMorada>' +
                        '<itim:nCodPostal>' + empregado."Post Code" + '</itim:nCodPostal>' +
                        '<itim:nNIF>' + empregado."No. Contribuinte" + '</itim:nNIF>' +
                        '<itim:nBI>' + numeroBi + '</itim:nBI>' +
                        '<itim:nValidadeBI>' + validadeBi + '</itim:nValidadeBI>' +
                        '<itim:nDataNascimento>' + dataNascimento + '</itim:nDataNascimento>' +
                        '<itim:nEstadoCivil>' + Format(empregado."Estado Civil") + '</itim:nEstadoCivil>' +
                        '<itim:nTelefone>' + empregado."Mobile Phone No." + '</itim:nTelefone>' +
                        '<itim:nProfissao></itim:nProfissao>' +
                        '<itim:nDepartamento>' + codigoDepartamento + '</itim:nDepartamento>' +
                        '<itim:cDepartamento>' + descricaoDepartamento + '</itim:cDepartamento>' +
                         //<!--Optional:-->
                         //<itim:nSeccao>?</itim:nSeccao>
                         //<!--Optional:-->
                         //<itim:cSeccao>?</itim:cSeccao>
                         //<!--Optional:-->
                         //<itim:nSubSeccao>?</itim:nSubSeccao>
                         //<!--Optional:-->
                         //<itim:cSubSeccao>?</itim:cSubSeccao>
                         //<!--Optional:-->
                         //<itim:nCategoria>?</itim:nCategoria>
                         //<!--Optional:-->
                         //<itim:cCategoria>?</itim:cCategoria>
                         //<!--Optional:-->
                         //<itim:nCCusto>?</itim:nCCusto>
                         //<!--Optional:-->
                         //<itim:cCCusto>?</itim:cCCusto>
                         //<!--Optional:-->
                         //<itim:nLocal>?</itim:nLocal>
                         //<!--Optional:-->
                         //<itim:cLocal>?</itim:cLocal>
                         '<itim:nEmail>' + empregado."Company E-Mail" + '</itim:nEmail>' +
                         //'<itim:nChefia>?</itim:nChefia>' +
                         '<itim:fAno>' + Format(anoFerias) + '</itim:fAno>' +
                         '<itim:fAnoAtual>' + Format(nFeriasAnoAtual) + '</itim:fAnoAtual>' +
                         '<itim:fAnoAnterior>' + Format(nFeriasAnoAnterior) + '</itim:fAnoAnterior>' +
                     '</itim:setUtilizadorFull>' +
                     '</soapenv:Body>' +
                 '</soapenv:Envelope>';

                MakeCall(soapContentRequest, soapAction);

            until empregado.Next() = 0;
    end;

    /// <summary>
    /// Syncronizes all Payroll Items with itime system.
    /// </summary>
    local procedure SetRubricas()
    var
        rubrica: Record "Payroll Item";
        motivoAusencia: Record "Cause of Absence";
        soapContentRequest: Text;
        soapAction: Text;
    begin

        soapAction := 'https://itimeweb.com/setRubricas';

        //Só mandamos os abonos!
        rubrica.SetRange("Payroll Item Type", rubrica."Payroll Item Type"::Abono);
        if rubrica.FindSet() then
            repeat
                Clear(soapContentRequest);

                soapContentRequest :=
                               '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:itim="https://itimeweb.com/">' +
                                '<soapenv:Header/>' +
                                '<soapenv:Body>' +
                                    '<itim:setRubricas>' +
                                        '<itim:sigla>' + siglaEmpresa + '</itim:sigla>' +
                                        '<itim:cRubrica>' + rubrica."Código" + '</itim:cRubrica>' +
                                        '<itim:nRubrica>' + rubrica."Descrição" + '</itim:nRubrica>' +
                                        '<itim:tipo>{Tipo}</itim:tipo>' +
                                    '</itim:setRubricas>' +
                                '</soapenv:Body>' +
                                '</soapenv:Envelope>';

                if rubrica."Payroll Item Type" = rubrica."Payroll Item Type"::Abono then begin
                    soapContentRequest := soapContentRequest.Replace('{Tipo}', 'A');
                    //end else begin
                    //soapContentRequest := soapContentRequest.Replace('{Tipo}', 'F'); //TODO: Dúvida. Mandamos os descontos como falta?
                end;

                MakeCall(soapContentRequest, soapAction);
            until rubrica.Next() = 0;

        //Envia agora os motivos de ausencia
        if motivoAusencia.FindSet() then
            repeat
                Clear(soapContentRequest);

                soapContentRequest :=
                         '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:itim="https://itimeweb.com/">' +
                          '<soapenv:Header/>' +
                          '<soapenv:Body>' +
                              '<itim:setRubricas>' +
                                  '<itim:sigla>' + siglaEmpresa + '</itim:sigla>' +
                                  '<itim:cRubrica>' + motivoAusencia.Code + '</itim:cRubrica>' +
                                  '<itim:nRubrica>' + motivoAusencia.Description + '</itim:nRubrica>' +
                                  '<itim:tipo>F</itim:tipo>' +
                              '</itim:setRubricas>' +
                          '</soapenv:Body>' +
                          '</soapenv:Envelope>';

                MakeCall(soapContentRequest, soapAction);
            until motivoAusencia.Next() = 0
    end;

    /// <summary>
    /// Syncronizes the vacation days with itime.
    /// </summary>
    /// <param name="ano"></param>
    local procedure obsolete_SetDireitoFerias(year: Integer)
    var
        feriasEmpregados: Record "Férias Empregados";
        soapContentRequest: Text;
        soapAction: Text;
        empgregados: Record Empregado;
        horasGozadas: Decimal;
    begin
        soapAction := 'https://itimeweb.com/setDireitoFerias';

        if empgregados.FindSet() then
            repeat
                feriasEmpregados.Reset();
                feriasEmpregados.SetRange("Employee No.", empgregados."No.");
                feriasEmpregados.SetRange("Ano a que se refere", year);

                if feriasEmpregados.FindSet() then
                    repeat
                        if feriasEmpregados.Gozada = true then begin
                            if feriasEmpregados."Qtd." = 1 then begin
                                feriasEmpregados."Qtd." := 8;
                            end
                            else if feriasEmpregados."Qtd." = 5 then begin
                                feriasEmpregados."Qtd." := 4;
                            end;

                            horasGozadas := horasGozadas + feriasEmpregados."Qtd.";
                        end else begin
                        end;
                        // soapContentRequest :=
                        //         '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:itim="https://itimeweb.com/">' +
                        //         '<soapenv:Header/>' +
                        //         '<soapenv:Body>' +
                        //             '<itim:setDireitoFerias>' +
                        //             '<itim:nNumero>' + feriasEmpregados."Employee No." + '</itim:nNumero>' +
                        //             '<itim:Ano>' + Format(feriasEmpregados."Ano a que se refere") + '</itim:Ano>' +
                        //             '<itim:fAnoAtual>' + Format(feriasEmpregados."Qtd.") + '</itim:fAnoAtual>' +
                        //             '<itim:fAnoAnterior>' + '0' + '</itim:fAnoAnterior>' +
                        //             '<itim:sigla>' + siglaEmpresa + '</itim:sigla>' +
                        //         '</itim:setDireitoFerias>' +
                        //         '</soapenv:Body>' +
                        //         '</soapenv:Envelope>';

                        MakeCall(soapContentRequest, soapAction);

                    until feriasEmpregados.Next() = 0;
            until empgregados.Next() = 0;
    end;

    local procedure GetResultadosByTipo()
    var
        soapAction: Text;
        soapContentRequest: Text;
        result: XmlDocument;
        xmlNodeListRes: XmlNodeList;
        xmlNode: XmlNode;
        index: Integer;
        code: Text;
        tipo: Text;
        rubricas: Record "Payroll Item";
    begin
        soapAction := 'https://itimeweb.com/getResultadosByTipo';
        soapContentRequest :=
        '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:itim="https://itimeweb.com/">' +
        '<soapenv:Header/>' +
        '<soapenv:Body>' +
            '<itim:getResultadosByTipo>' +
                '<itim:sigla>' + siglaEmpresa + '</itim:sigla>' +
                '<itim:dataini>?</itim:dataini>' +
                '<itim:datafim>?</itim:datafim>' +
                '<itim:tipo>F</itim:tipo>' +
                '<itim:nNumero>0</itim:nNumero>' +
            '<itim:nRubrica>0</itim:nRubrica>' +
            '</itim:getResultadosByTipo>' +
        '</soapenv:Body>' +
        '</soapenv:Envelope>';

        result := MakeCall(soapContentRequest, soapAction);

        //DUVIDAS:
        //Que rubricas vamos ver aqui?!
        //Estamos a receber horas, dias ou minutos associadoss a um empregado.
        //O que representa a data de inicio e a data de fim do resultado
        //Que Datas vamos mandar no pedido?

        //Tratar o resultado
        xmlNodeListRes := GetNodes(MakeCall(soapContentRequest, soapAction), '//*[local-name()="cResultados"]');

        for index := 1 to xmlNodeListRes.Count() do begin
            Clear(xmlNode);
            Clear(tipo);
            Clear(code);

            xmlNodeListRes.Get(index, xmlNode);
            tipo := GetValueFromNode('//*[local-name()="mTipo"]', xmlNode);
            code := GetValueFromNode('//*[local-name()="mRubrica"]', xmlNode);

            rubricas.Reset();
            if rubricas.Get(code) then begin
            end;
        end;
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
            XmlDocument.ReadFrom(responseText, xmlDoc);
            exit(xmlDoc);
        end
        else begin
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