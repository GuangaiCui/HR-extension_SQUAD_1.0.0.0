xmlport 53035 "RU - Anexo 0"
{
    Encoding = UTF8;
    //DefaultNamespace = 'http://www.gep.mtss.gov.pt/sguri/ru/anexo_zero';
    //UseDefaultNamespace = true;
    Namespaces = ru = 'http://www.gep.mtss.gov.pt/sguri/ru', t = 'http://www.gep.mtss.gov.pt/sguri/tipos_comuns',
                 xsi = 'http://www.w3.org/2001/XMLSchema-instance';

    schema
    {

        textelement("relatorio_unico")
        {
            NamespacePrefix = 'ru';
            textattribute(xml_data)
            {
                XmlName = 'XML_DATA';

                trigger OnBeforePassVariable()
                begin
                    XML_DATA := '3.3.0';
                end;
            }
            /*textattribute(xmlns_ru)
            {

                XmlName = 'xmlns:ru';

                trigger OnBeforePassVariable()
                begin
                    xmlns_ru := 'http://www.gep.mtss.gov.pt/sguri/ru';
                end;
            }
            textattribute("xmlns:t")
            {

                trigger OnBeforePassVariable()
                begin
                    "xmlns:t" := 'http://www.gep.mtss.gov.pt/sguri/tipos_comuns';
                end;
            }
            textattribute("xmlns:xsi")
            {

                trigger OnBeforePassVariable()
                begin
                    "xmlns:xsi" := 'http://www.w3.org/2001/XMLSchema-instance';
                end;
            }
            */
            textattribute("xsi:schemaLocation")
            {

                //NamespacePrefix = 'xsi';

                trigger OnBeforePassVariable()
                begin
                    "xsi:schemaLocation" := 'http://www.gep.mtss.gov.pt/sguri/ru relatorio-zero-3.3.0.xsd ';
                    "xsi:schemaLocation" += 'http://www.gep.mtss.gov.pt/sguri/tipos_comuns tipos-comuns-1.4.0.xsd ';
                    "xsi:schemaLocation" += 'http://www.gep.mtss.gov.pt/sguri/ru/anexo_zero anexo-zero-1.4.0.xsd';
                end;
            }
            //textelement("ru:header")
            textelement("header")
            {
                NamespacePrefix = 'ru';
                //textelement("ru:aplicacao")
                textelement("aplicacao")
                {
                    NamespacePrefix = 'ru';
                    //textelement("ru:nome")
                    textelement("nome")
                    {
                        NamespacePrefix = 'ru';

                        trigger OnBeforePassVariable()
                        begin
                            //"ru:nome" := 'Microsoft Dynamics NAV';
                            "nome" := 'Microsoft Business Central';
                        end;
                    }
                    //textelement("ru:versao")
                    textelement("versao")
                    {

                        NamespacePrefix = 'ru';

                        trigger OnBeforePassVariable()
                        begin
                            //"ru:versao" := '5.1.0';
                            "versao" := Utils.CodProductVersion();
                        end;
                    }
                    //textelement("ru:empresa")
                    textelement("empresa")
                    {
                        NamespacePrefix = 'ru';

                        trigger OnBeforePassVariable()
                        begin
                            //"ru:empresa" := rInfEmpresa.Name;
                            "empresa" := rInfEmpresa.Name;
                        end;
                    }
                }
            }
            //textelement("ru:body")
            textelement("body")
            {
                NamespacePrefix = 'ru';

                //textelement("ru:anexos")
                textelement("anexos")
                {
                    NamespacePrefix = 'ru';

                    textelement(anexo_zero)
                    {
                        //NamespacePrefix = '';
                        /**/
                        textattribute(xmlns)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                //xmlns := 'http://www.gep.mtss.gov.pt/sguri/ru/anexo_zero';
                            end;
                        }
                        /**/
                        textattribute(xml_data1)
                        {
                            XmlName = 'XML_DATA';

                            trigger OnBeforePassVariable()
                            begin
                                XML_DATA1 := '1.4.0';
                            end;
                        }
                        textattribute(ano)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                ano := Format(vAno);
                            end;
                        }
                        textattribute(entidade)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                if rConfRH.Get then
                                    rConfRH.TestField(rConfRH.Entidade);
                                entidade := rConfRH.Entidade;
                            end;
                        }
                        textelement(nome_entidade)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                nome_entidade := rInfEmpresa.Name;
                            end;
                        }
                        textelement(cae_31Dez)
                        {
                            textattribute(tbl_cae_31dez)
                            {
                                XmlName = 'tbl';

                                trigger OnBeforePassVariable()
                                begin
                                    tbl_cae_31Dez := 'RU_CAE_5DIG';
                                end;
                            }

                            trigger OnBeforePassVariable()
                            begin
                                cae_31Dez := rInfEmpresa."PTSS CAE Code";
                            end;
                        }
                        textelement(pessoas_servico_31Dez)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                Clear(vTotPessoas);

                                rHistCabMovEmp.Reset;
                                rHistCabMovEmp.SetRange(rHistCabMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                rHistCabMovEmp.SetRange(rHistCabMovEmp."Data Registo", DMY2Date(1, 12, vAno), DMY2Date(31, 12, vAno));
                                if rHistCabMovEmp.Find('+') then
                                    vTotPessoas := rHistCabMovEmp.Count;

                                //Ausentes à mais de um mes
                                rHistCabMovEmp.Reset;
                                rHistCabMovEmp.SetRange(rHistCabMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                rHistCabMovEmp.SetRange(rHistCabMovEmp."Data Registo", DMY2Date(1, 12, vAno), DMY2Date(31, 12, vAno));
                                rHistCabMovEmp.SetRange(rHistCabMovEmp.Valor, 0);
                                if rHistCabMovEmp.FindSet then begin
                                    repeat
                                        rHistAusen.Next;
                                        rHistAusen.SetRange(rHistAusen."Employee No.", rHistCabMovEmp."Employee No.");
                                        rHistAusen.SetRange(rHistAusen."To Date", DMY2Date(30, 11, vAno));
                                        if rHistAusen.FindFirst then
                                            vTotPessoas := vTotPessoas - 1;

                                    until rHistCabMovEmp.Next = 0;
                                end;

                                pessoas_servico_31Dez := Format(vTotPessoas);
                            end;
                        }
                        textelement(pessoas_servico_medio)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                Clear(vTotPessoas);
                                vDate := DMY2Date(1, 1, vAno);

                                for i := 1 to 12 do begin
                                    rHistCabMovEmp.Reset;
                                    rHistCabMovEmp.SetRange(rHistCabMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                    rHistCabMovEmp.SetRange(rHistCabMovEmp."Data Registo", vDate, CalcDate('+1M-1D', vDate));
                                    if rHistCabMovEmp.Find('+') then
                                        vTotPessoas := vTotPessoas + rHistCabMovEmp.Count;
                                    vDate := CalcDate('+1M', vDate);
                                end;

                                pessoas_servico_medio := Format(Round(vTotPessoas / 12, 1));
                            end;
                        }
                        textelement(trab_conta_outrem_31Dez)
                        {

                            trigger OnBeforePassVariable()
                            begin

                                Clear(vConta);
                                rHistCabMovEmp.Reset;
                                rHistCabMovEmp.SetRange(rHistCabMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                rHistCabMovEmp.SetRange(rHistCabMovEmp."Data Registo", DMY2Date(1, 12, vAno), DMY2Date(31, 12, vAno));
                                if rHistCabMovEmp.FindSet then begin
                                    repeat
                                        rEmpregado.Reset;
                                        if rEmpregado.Get(rHistCabMovEmp."Employee No.") then begin
                                            if rEmpregado."Tipo Contribuinte" = rEmpregado."Tipo Contribuinte"::"Conta de Outrem" then
                                                vConta := vConta + 1;
                                        end;
                                    until rHistCabMovEmp.Next = 0;
                                end;

                                //Ausentes à mais de um mes
                                rHistCabMovEmp.Reset;
                                rHistCabMovEmp.SetRange(rHistCabMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                rHistCabMovEmp.SetRange(rHistCabMovEmp."Data Registo", DMY2Date(1, 12, vAno), DMY2Date(31, 12, vAno));
                                rHistCabMovEmp.SetRange(rHistCabMovEmp.Valor, 0);
                                if rHistCabMovEmp.FindSet then begin
                                    repeat
                                        rHistAusen.Next;
                                        rHistAusen.SetRange(rHistAusen."Employee No.", rHistCabMovEmp."Employee No.");
                                        rHistAusen.SetRange(rHistAusen."To Date", DMY2Date(30, 11, vAno));
                                        if rHistAusen.FindFirst then
                                            vConta := vConta - 1;

                                    until rHistCabMovEmp.Next = 0;
                                end;


                                trab_conta_outrem_31Dez := Format(vConta);
                            end;
                        }
                        textelement(trab_conta_outrem_medio)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                Clear(vTotPessoas);
                                vDate := DMY2Date(1, 1, vAno);

                                for i := 1 to 12 do begin


                                    rHistCabMovEmp.Reset;
                                    rHistCabMovEmp.SetRange(rHistCabMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                    rHistCabMovEmp.SetRange(rHistCabMovEmp."Data Registo", vDate, CalcDate('+1M-1D', vDate));
                                    if rHistCabMovEmp.FindSet then begin
                                        repeat
                                            rEmpregado.Reset;
                                            if rEmpregado.Get(rHistCabMovEmp."Employee No.") then begin
                                                if rEmpregado."Tipo Contribuinte" = rEmpregado."Tipo Contribuinte"::"Conta de Outrem" then
                                                    vTotPessoas := vTotPessoas + 1;
                                            end;
                                        until rHistCabMovEmp.Next = 0;
                                    end;
                                    vDate := CalcDate('+1M', vDate);

                                end;

                                trab_conta_outrem_medio := Format(Round(vTotPessoas / 12, 1));
                            end;
                        }
                        textelement(trab_destacados)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                rDestacamentos.Reset;
                                rDestacamentos.SetRange(rDestacamentos."Detachment Begin Date", DMY2Date(1, 1, vAno),
                                                        DMY2Date(31, 12, vAno));
                                if rDestacamentos.Find('-') then begin
                                    repeat
                                        tempDestacamentos.Init;
                                        tempDestacamentos."Employee No." := rDestacamentos."Employee No.";
                                        if not tempDestacamentos.Insert then;
                                    until rDestacamentos.Next = 0;
                                end;


                                trab_destacados := Format(tempDestacamentos.Count);
                            end;
                        }
                        textelement(n_destacamentos)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                rDestacamentos.Reset;
                                rDestacamentos.SetRange(rDestacamentos."Detachment Begin Date", DMY2Date(1, 1, vAno),
                                                        DMY2Date(31, 12, vAno));
                                if rDestacamentos.FindLast then
                                    n_destacamentos := Format(rDestacamentos.Count);
                            end;
                        }
                        textelement(n_trab_sindic_31Out)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                rRubricaSalarial.Reset;
                                rRubricaSalarial.SetRange(rRubricaSalarial.Genero, rRubricaSalarial.Genero::Sindicato);
                                if rRubricaSalarial.FindFirst then begin
                                    rHistLinhasMovEmp.Reset;
                                    rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Data Registo", DMY2Date(1, 10, vAno), DMY2Date(31, 10, vAno));
                                    rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Payroll Item Code", rRubricaSalarial.Código);
                                    if rHistLinhasMovEmp.FindLast then
                                        n_trab_sindic_31Out := Format(rHistLinhasMovEmp.Count);

                                end;
                            end;
                        }
                        tableelement("associações empregadores"; "Associações Empregadores")
                        {
                            XmlName = 'associacoes';
                            textattribute(inscrita)
                            {

                                trigger OnBeforePassVariable()
                                begin
                                    rAssociacoes.Reset;
                                    rAssociacoes.SetFilter("Data de Adesão", '<=%1', DMY2Date(31, 12, vAno));
                                    if rAssociacoes.FindFirst then
                                        inscrita := 'S'
                                    else
                                        inscrita := 'N';
                                end;
                            }
                            fieldelement(associacao; "Associações Empregadores"."Associação de Empregadores")
                            {
                                textattribute(tbl_associacao)
                                {
                                    XmlName = 'tbl';

                                    trigger OnBeforePassVariable()
                                    begin
                                        tbl_associacao := 'RU_ASSPROF';
                                    end;
                                }
                            }

                            trigger OnPreXmlItem()
                            begin
                                "Associações Empregadores".SetFilter("Associações Empregadores"."Data de Adesão", '<=%1', DMY2Date(31, 12, vAno));
                            end;
                        }
                        textelement(trab_suplementar)
                        {
                            textattribute(horas_realizadas)
                            {

                                trigger OnBeforePassVariable()
                                begin
                                    rHistHorasExtra.Reset;
                                    rHistHorasExtra.SetRange(rHistHorasExtra.Data, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                    if rHistHorasExtra.FindFirst then
                                        horas_realizadas := 'S'
                                    else
                                        horas_realizadas := 'N'
                                end;
                            }
                            textelement(relacao_nominal_visada)
                            {

                                trigger OnBeforePassVariable()
                                begin

                                    if rRu."Trab. Suplementar visado" then
                                        relacao_nominal_visada := 'S'
                                    else
                                        relacao_nominal_visada := 'N'
                                end;
                            }
                        }
                        textelement(n_trab_temp_31Out)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                n_trab_temp_31Out := Format(rRu."Núm. Trab. Temp 31 Out");
                            end;
                        }
                        textelement(n_trab_temp_31Dez)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                n_trab_temp_31Dez := Format(rRu."Núm. Trab. Temp 31 Dez");
                            end;
                        }
                        textelement(n_trab_temp_medio)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                n_trab_temp_medio := Format(rRu."Núm. Trab. Médio durante ano");
                            end;
                        }
                        textelement(fluxo_entradas_saidas)
                        {
                            textelement(entradas)
                            {
                                textelement(entradas_h)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        entradas_h := Format(rRu."Entradas durante ano - H")
                                    end;
                                }
                                textelement(entradas_m)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        entradas_m := Format(rRu."Entradas durante ano - M")
                                    end;
                                }
                            }
                            textelement(saidas)
                            {
                                textelement(saidas_h)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        saidas_h := Format(rRu."Saídas durante ano - H")
                                    end;
                                }
                                textelement(saidas_m)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        saidas_m := Format(rRu."Saídas durante ano - M")
                                    end;
                                }
                            }
                        }
                        textelement(dist_grupos_etarios_total)
                        {
                            textelement(etmen_18a)
                            {
                                XmlName = 'men_18';
                                textelement(etha1)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Male) then begin
                                                    if Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') < 18 then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        ethA1 := Format(i);
                                    end;
                                }
                                textelement(etma1)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Female) then begin
                                                    if Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') < 18 then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        etmA1 := Format(i);
                                    end;
                                }
                            }
                            textelement(etde_18_a_34a)
                            {
                                XmlName = 'de_18_a_34';
                                textelement(etha2)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Male) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 18) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 34) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        ethA2 := Format(i);
                                    end;
                                }
                                textelement(etma2)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Female) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 18) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 34) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        etmA2 := Format(i);
                                    end;
                                }
                            }
                            textelement(etde_35_a_44a)
                            {
                                XmlName = 'de_35_a_44';
                                textelement(etha3)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Male) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 35) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 44) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        ethA3 := Format(i);
                                    end;
                                }
                                textelement(etma3)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Female) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 35) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 44) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        etmA3 := Format(i);
                                    end;
                                }
                            }
                            textelement(etde_45_a_64a)
                            {
                                XmlName = 'de_45_a_64';
                                textelement(etha4)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Male) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 45) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 64) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        ethA4 := Format(i);
                                    end;
                                }
                                textelement(etma4)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Female) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 45) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 64) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        etmA4 := Format(i);
                                    end;
                                }
                            }
                            textelement(etde_65_a_maisa)
                            {
                                XmlName = 'de_65_a_mais';
                                textelement(etha5)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Male) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 65) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        ethA5 := Format(i);
                                    end;
                                }
                                textelement(etma5)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Female) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 65) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        etmA5 := Format(i);
                                    end;
                                }
                            }
                        }
                        textelement(dist_grupos_etarios_incap_inf60)
                        {
                            textelement(etmen_18b)
                            {
                                XmlName = 'men_18';
                                textelement(ethb1)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Inferior a 60%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Male) then begin
                                                    if Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') < 18 then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        ethB1 := Format(i);
                                    end;
                                }
                                textelement(etmb1)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Inferior a 60%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Female) then begin
                                                    if Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') < 18 then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        etmB1 := Format(i);
                                    end;
                                }
                            }
                            textelement(etde_18_a_34b)
                            {
                                XmlName = 'de_18_a_34';
                                textelement(ethb2)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Inferior a 60%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Male) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 18) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 34) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        ethB2 := Format(i);
                                    end;
                                }
                                textelement(etmb2)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Inferior a 60%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Female) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 18) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 34) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        etmB2 := Format(i);
                                    end;
                                }
                            }
                            textelement(etde_35_a_44b)
                            {
                                XmlName = 'de_35_a_44';
                                textelement(ethb3)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Inferior a 60%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Male) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 35) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 44) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        ethB3 := Format(i);
                                    end;
                                }
                                textelement(etmb3)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Inferior a 60%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Female) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 35) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 44) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        etmB3 := Format(i);
                                    end;
                                }
                            }
                            textelement(etde_45_a_64b)
                            {
                                XmlName = 'de_45_a_64';
                                textelement(ethb4)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Inferior a 60%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Male) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 45) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 64) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        ethB4 := Format(i);
                                    end;
                                }
                                textelement(etmb4)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Inferior a 60%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Female) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 45) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 64) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        etmB4 := Format(i);
                                    end;
                                }
                            }
                            textelement(etde_65_a_maisb)
                            {
                                XmlName = 'de_65_a_mais';
                                textelement(ethb5)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Inferior a 60%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Male) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 65) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        ethB5 := Format(i);
                                    end;
                                }
                                textelement(etmb5)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Inferior a 60%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Female) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 65) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        etmB5 := Format(i);
                                    end;
                                }
                            }
                        }
                        textelement(dist_grupos_etarios_incap_60_a80)
                        {
                            textelement(etmen_18c)
                            {
                                XmlName = 'men_18';
                                textelement(ethc1)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"De 60% e Inferior a 80%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Male) then begin
                                                    if Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') < 18 then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        ethC1 := Format(i);
                                    end;
                                }
                                textelement(etmc1)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"De 60% e Inferior a 80%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Female) then begin
                                                    if Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') < 18 then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        etmC1 := Format(i);
                                    end;
                                }
                            }
                            textelement(etde_18_a_34c)
                            {
                                XmlName = 'de_18_a_34';
                                textelement(ethc2)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"De 60% e Inferior a 80%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Male) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 18) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 34) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        ethC2 := Format(i);
                                    end;
                                }
                                textelement(etmc2)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"De 60% e Inferior a 80%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Female) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 18) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 34) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        etmC2 := Format(i);
                                    end;
                                }
                            }
                            textelement(etde_35_a_44c)
                            {
                                XmlName = 'de_35_a_44';
                                textelement(ethc3)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"De 60% e Inferior a 80%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Male) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 35) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 44) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        ethC3 := Format(i);
                                    end;
                                }
                                textelement(etmc3)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"De 60% e Inferior a 80%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Female) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 35) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 44) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        etmC3 := Format(i);
                                    end;
                                }
                            }
                            textelement(etde_45_a_64c)
                            {
                                XmlName = 'de_45_a_64';
                                textelement(ethc4)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"De 60% e Inferior a 80%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Male) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 45) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 64) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        ethC4 := Format(i);
                                    end;
                                }
                                textelement(etmc4)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"De 60% e Inferior a 80%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Female) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 45) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 64) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        etmC4 := Format(i);
                                    end;
                                }
                            }
                            textelement(etde_65_a_maisc)
                            {
                                XmlName = 'de_65_a_mais';
                                textelement(ethc5)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"De 60% e Inferior a 80%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Male) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 65) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        ethC5 := Format(i);
                                    end;
                                }
                                textelement(etmc5)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"De 60% e Inferior a 80%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Female) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 65) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        etmC5 := Format(i);
                                    end;
                                }
                            }
                        }
                        textelement(dist_grupos_etarios_sup80)
                        {
                            textelement(etmen_18d)
                            {
                                XmlName = 'men_18';
                                textelement(ethd1)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Igual ou Superior a 80%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Male) then begin
                                                    if Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') < 18 then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        ethD1 := Format(i);
                                    end;
                                }
                                textelement(etmd1)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Igual ou Superior a 80%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Female) then begin
                                                    if Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') < 18 then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        etmD1 := Format(i);
                                    end;
                                }
                            }
                            textelement(etde_18_a_34d)
                            {
                                XmlName = 'de_18_a_34';
                                textelement(ethd2)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Igual ou Superior a 80%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Male) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 18) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 34) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        ethD2 := Format(i);
                                    end;
                                }
                                textelement(etmd2)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Igual ou Superior a 80%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Female) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 18) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 34) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        etmD2 := Format(i);
                                    end;
                                }
                            }
                            textelement(etde_35_a_44d)
                            {
                                XmlName = 'de_35_a_44';
                                textelement(ethd3)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Igual ou Superior a 80%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Male) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 35) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 44) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        ethD3 := Format(i);
                                    end;
                                }
                                textelement(etmd3)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Igual ou Superior a 80%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Female) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 35) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 44) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        etmD3 := Format(i);
                                    end;
                                }
                            }
                            textelement(etde_45_a_64d)
                            {
                                XmlName = 'de_45_a_64';
                                textelement(ethd4)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Igual ou Superior a 80%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Male) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 45) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 64) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        ethD4 := Format(i);
                                    end;
                                }
                                textelement(etmd4)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Igual ou Superior a 80%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Female) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 45) and
                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 64) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        etmD4 := Format(i);
                                    end;
                                }
                            }
                            textelement(etde_65_a_maisd)
                            {
                                XmlName = 'de_65_a_mais';
                                textelement(ethd5)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Igual ou Superior a 80%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Male) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 65) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        ethD5 := Format(i);
                                    end;
                                }
                                textelement(etmd5)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rPerdAnomEmp.Reset;
                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Igual ou Superior a 80%");
                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                        if rPerdAnomEmp.FindSet then begin
                                            repeat
                                                if (rEmpregado.Get(rPerdAnomEmp."Employee No.")) and (rEmpregado.Sex = rEmpregado.Sex::Female) then begin
                                                    if (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 65) then
                                                        i := i + 1;
                                                end;
                                            until rPerdAnomEmp.Next = 0;
                                        end;
                                        etmD5 := Format(i);
                                    end;
                                }
                            }
                        }
                        textelement(dist_habil_lit_total)
                        {
                            textelement(hainf_3cicloa)
                            {
                                XmlName = 'inf_3ciclo';
                                textelement(haha1)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1|%2|%3', rHabilitacao.Nível::"Inf 1Ciclo",
                                        rHabilitacao.Nível::"1Ciclo", rHabilitacao.Nível::"2Ciclo");
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Male);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hahA1 := Format(i);
                                    end;
                                }
                                textelement(hama1)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1|%2|%3', rHabilitacao.Nível::"Inf 1Ciclo",
                                        rHabilitacao.Nível::"1Ciclo", rHabilitacao.Nível::"2Ciclo");
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Female);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hamA1 := Format(i);
                                    end;
                                }
                            }
                            textelement(ha_3cicloa)
                            {
                                XmlName = '_3ciclo';
                                textelement(haha2)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::"3Ciclo");
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Male);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hahA2 := Format(i);
                                    end;
                                }
                                textelement(hama2)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::"3Ciclo");
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Female);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hamA2 := Format(i);
                                    end;
                                }
                            }
                            textelement(haens_secundarioa)
                            {
                                XmlName = 'ens_secundario';
                                textelement(haha3)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::Sec);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Male);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hahA3 := Format(i);
                                    end;
                                }
                                textelement(hama3)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::Sec);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Female);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hamA3 := Format(i);
                                    end;
                                }
                            }
                            textelement(haens_pos_secundarioa)
                            {
                                XmlName = 'ens_pos_secundario';
                                textelement(haha4)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::PosSec);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Male);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hahA4 := Format(i);
                                    end;
                                }
                                textelement(hama4)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::PosSec);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Female);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hamA4 := Format(i);
                                    end;
                                }
                            }
                            textelement(haens_superiora)
                            {
                                XmlName = 'ens_superior';
                                textelement(haha5)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1|%2|%3|%4', rHabilitacao.Nível::Barc, rHabilitacao.Nível::Lic,
                                        rHabilitacao.Nível::Mes, rHabilitacao.Nível::Dou);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Male);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hahA5 := Format(i);
                                    end;
                                }
                                textelement(hama5)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1|%2|%3|%4', rHabilitacao.Nível::Barc, rHabilitacao.Nível::Lic,
                                        rHabilitacao.Nível::Mes, rHabilitacao.Nível::Dou);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Female);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hamA5 := Format(i);
                                    end;
                                }
                            }
                        }
                        textelement(dist_habil_incap_inf60)
                        {
                            textelement(hainf_3ciclob)
                            {
                                XmlName = 'inf_3ciclo';
                                textelement(hahb1)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1|%2|%3', rHabilitacao.Nível::"Inf 1Ciclo",
                                        rHabilitacao.Nível::"1Ciclo", rHabilitacao.Nível::"2Ciclo");
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Male);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Inferior a 60%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hahB1 := Format(i);
                                    end;
                                }
                                textelement(hamb1)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1|%2|%3', rHabilitacao.Nível::"Inf 1Ciclo",
                                        rHabilitacao.Nível::"1Ciclo", rHabilitacao.Nível::"2Ciclo");
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Female);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Inferior a 60%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hamB1 := Format(i);
                                    end;
                                }
                            }
                            textelement(ha_3ciclob)
                            {
                                XmlName = '_3ciclo';
                                textelement(hahb2)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::"3Ciclo");
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Male);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Inferior a 60%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hahB2 := Format(i);
                                    end;
                                }
                                textelement(hamb2)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::"3Ciclo");
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Female);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Inferior a 60%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hamB2 := Format(i);
                                    end;
                                }
                            }
                            textelement(haens_secundariob)
                            {
                                XmlName = 'ens_secundario';
                                textelement(hahb3)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::Sec);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Male);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Inferior a 60%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hahB3 := Format(i);
                                    end;
                                }
                                textelement(hamb3)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::Sec);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Female);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Inferior a 60%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hamB3 := Format(i);
                                    end;
                                }
                            }
                            textelement(haens_pos_secundariob)
                            {
                                XmlName = 'ens_pos_secundario';
                                textelement(hahb4)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::PosSec);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Male);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Inferior a 60%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hahB4 := Format(i);
                                    end;
                                }
                                textelement(hamb4)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::PosSec);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Female);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Inferior a 60%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hamB4 := Format(i);
                                    end;
                                }
                            }
                            textelement(haens_superiorb)
                            {
                                XmlName = 'ens_superior';
                                textelement(hahb5)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1|%2|%3|%4', rHabilitacao.Nível::Barc, rHabilitacao.Nível::Lic,
                                        rHabilitacao.Nível::Mes, rHabilitacao.Nível::Dou);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Male);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Inferior a 60%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hahB5 := Format(i);
                                    end;
                                }
                                textelement(hamb5)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1|%2|%3|%4', rHabilitacao.Nível::Barc, rHabilitacao.Nível::Lic,
                                        rHabilitacao.Nível::Mes, rHabilitacao.Nível::Dou);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Female);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Inferior a 60%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hamB5 := Format(i);
                                    end;
                                }
                            }
                        }
                        textelement(dist_habil_incap_60_a80)
                        {
                            textelement(hainf_3cicloc)
                            {
                                XmlName = 'inf_3ciclo';
                                textelement(hahc1)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1|%2|%3', rHabilitacao.Nível::"Inf 1Ciclo",
                                        rHabilitacao.Nível::"1Ciclo", rHabilitacao.Nível::"2Ciclo");
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Male);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"De 60% e Inferior a 80%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hahC1 := Format(i);
                                    end;
                                }
                                textelement(hamc1)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1|%2|%3', rHabilitacao.Nível::"Inf 1Ciclo",
                                        rHabilitacao.Nível::"1Ciclo", rHabilitacao.Nível::"2Ciclo");
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Female);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"De 60% e Inferior a 80%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hamC1 := Format(i);
                                    end;
                                }
                            }
                            textelement(ha_3cicloc)
                            {
                                XmlName = '_3ciclo';
                                textelement(hahc2)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::"3Ciclo");
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Male);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"De 60% e Inferior a 80%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hahC2 := Format(i);
                                    end;
                                }
                                textelement(hamc2)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::"3Ciclo");
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Female);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"De 60% e Inferior a 80%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hamC2 := Format(i);
                                    end;
                                }
                            }
                            textelement(haens_secundarioc)
                            {
                                XmlName = 'ens_secundario';
                                textelement(hahc3)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::Sec);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Male);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"De 60% e Inferior a 80%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hahC3 := Format(i);
                                    end;
                                }
                                textelement(hamc3)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::Sec);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Female);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"De 60% e Inferior a 80%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hamC3 := Format(i);
                                    end;
                                }
                            }
                            textelement(haens_pos_secundarioc)
                            {
                                XmlName = 'ens_pos_secundario';
                                textelement(hahc4)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::PosSec);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Male);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"De 60% e Inferior a 80%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hahC4 := Format(i);
                                    end;
                                }
                                textelement(hamc4)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::PosSec);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Female);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"De 60% e Inferior a 80%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hamC4 := Format(i);
                                    end;
                                }
                            }
                            textelement(haens_superiorc)
                            {
                                XmlName = 'ens_superior';
                                textelement(hahc5)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1|%2|%3|%4', rHabilitacao.Nível::Barc, rHabilitacao.Nível::Lic,
                                        rHabilitacao.Nível::Mes, rHabilitacao.Nível::Dou);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Male);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"De 60% e Inferior a 80%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hahC5 := Format(i);
                                    end;
                                }
                                textelement(hamc5)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1|%2|%3|%4', rHabilitacao.Nível::Barc, rHabilitacao.Nível::Lic,
                                        rHabilitacao.Nível::Mes, rHabilitacao.Nível::Dou);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Female);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"De 60% e Inferior a 80%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hamC5 := Format(i);
                                    end;
                                }
                            }
                        }
                        textelement(dist_habil_sup80)
                        {
                            textelement(hainf_3ciclod)
                            {
                                XmlName = 'inf_3ciclo';
                                textelement(hahd1)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1|%2|%3', rHabilitacao.Nível::"Inf 1Ciclo", rHabilitacao.Nível::"1Ciclo",
                                        rHabilitacao.Nível::"2Ciclo");
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Male);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Igual ou Superior a 80%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hahD1 := Format(i);
                                    end;
                                }
                                textelement(hamd1)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1|%2|%3', rHabilitacao.Nível::"Inf 1Ciclo", rHabilitacao.Nível::"1Ciclo",
                                        rHabilitacao.Nível::"2Ciclo");
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Female);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Igual ou Superior a 80%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hamD1 := Format(i);
                                    end;
                                }
                            }
                            textelement(ha_3ciclod)
                            {
                                XmlName = '_3ciclo';
                                textelement(hahd2)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::"3Ciclo");
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Male);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Igual ou Superior a 80%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hahD2 := Format(i);
                                    end;
                                }
                                textelement(hamd2)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::"3Ciclo");
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Female);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Igual ou Superior a 80%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hamD2 := Format(i);
                                    end;
                                }
                            }
                            textelement(haens_secundariod)
                            {
                                XmlName = 'ens_secundario';
                                textelement(hahd3)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::Sec);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Male);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Igual ou Superior a 80%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hahD3 := Format(i);
                                    end;
                                }
                                textelement(hamd3)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::Sec);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Female);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Igual ou Superior a 80%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hamD3 := Format(i);
                                    end;
                                }
                            }
                            textelement(haens_pos_secundariod)
                            {
                                XmlName = 'ens_pos_secundario';
                                textelement(hahd4)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::PosSec);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Male);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Igual ou Superior a 80%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hahD4 := Format(i);
                                    end;
                                }
                                textelement(hamd4)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1', rHabilitacao.Nível::PosSec);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Female);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Igual ou Superior a 80%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hamD4 := Format(i);
                                    end;
                                }
                            }
                            textelement(haens_superiord)
                            {
                                XmlName = 'ens_superior';
                                textelement(hahd5)
                                {
                                    XmlName = 'h';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1|%2|%3|%4', rHabilitacao.Nível::Barc, rHabilitacao.Nível::Lic,
                                        rHabilitacao.Nível::Mes, rHabilitacao.Nível::Dou);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Male);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Igual ou Superior a 80%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hahD5 := Format(i);
                                    end;
                                }
                                textelement(hamd5)
                                {
                                    XmlName = 'm';

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(i);
                                        rHabilitacao.Reset;
                                        rHabilitacao.SetFilter(rHabilitacao.Nível, '%1|%2|%3|%4', rHabilitacao.Nível::Barc, rHabilitacao.Nível::Lic,
                                        rHabilitacao.Nível::Mes, rHabilitacao.Nível::Dou);
                                        if rHabilitacao.FindSet then begin
                                            repeat
                                                rEmpregado.Reset;
                                                rEmpregado.SetRange(rEmpregado.Sex, rEmpregado.Sex::Female);
                                                rEmpregado.SetRange(rEmpregado."Cód. Habilitações", rHabilitacao.Código);
                                                if rEmpregado.Find('-') then begin
                                                    repeat
                                                        rPerdAnomEmp.Reset;
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Employee No.", rEmpregado."No.");
                                                        rPerdAnomEmp.SetRange(rPerdAnomEmp."Grau de Incapacidade", rPerdAnomEmp."Grau de Incapacidade"::"Igual ou Superior a 80%");
                                                        rPerdAnomEmp.SetFilter(rPerdAnomEmp."Data Grau de Incapacidade", '<=%1', DMY2Date(31, 12, vAno));
                                                        if rPerdAnomEmp.FindFirst then
                                                            i := i + 1;
                                                    until rEmpregado.Next = 0;
                                                end;

                                            until rHabilitacao.Next = 0;
                                        end;
                                        hamD5 := Format(i);
                                    end;
                                }
                            }
                        }
                        textelement(vol_negocios)
                        {
                            textattribute(ano_vol_negocios)
                            {
                                XmlName = 'ano';

                                trigger OnBeforePassVariable()
                                begin
                                    ano_vol_negocios := Format(vAno);
                                end;
                            }

                            trigger OnBeforePassVariable()
                            begin
                                vol_negocios := Format(rInfEmpresa."Business Volume", 0, '<integer>');
                            end;
                        }
                        textelement(capital_social)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                //capital_social := Format(rInfEmpresa."PTSS Share Capital", 0, '<integer>');
                                capital_social := rInfEmpresa."PTSS Share Capital";
                            end;
                        }
                        textelement(cap_social_priv_nac)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                cap_social_priv_nac := ConvertStr(Format(rInfEmpresa."National Private Percentage"), ',', '.');
                            end;
                        }
                        textelement(cap_social_estrang)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                cap_social_estrang := ConvertStr(Format(rInfEmpresa."Foreign Percentage"), ',', '.');
                            end;
                        }
                        textelement(cap_social_pub_nac)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                cap_social_pub_nac := ConvertStr(Format(rInfEmpresa."Public Percentage"), ',', '.');
                            end;
                        }
                        textelement(finan_ent)
                        {

                            trigger OnBeforePassVariable()
                            begin

                                finan_ent := Format((rRu."ForProf. Mont. Horas Form." + rRu."ForProf. Restanre Financia."), 0, '<integer>');
                            end;
                        }
                        textelement(mont_remun_horas_form)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                mont_remun_horas_form := Format(rRu."ForProf. Mont. Horas Form.", 0, '<integer>');
                            end;
                        }
                        textelement(rest_finan_ent)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                rest_finan_ent := Format(rRu."ForProf. Restanre Financia.", 0, '<integer>');
                            end;
                        }
                        textelement(finan_ext_ent)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                finan_ext_ent := Format((rRu."ForProf. Fundo Social Europeu" + rRu."ForProf. Outras Fontes Finan."), 0, '<integer>');
                            end;
                        }
                        textelement(finan_fse)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                finan_fse := Format(rRu."ForProf. Fundo Social Europeu", 0, '<integer>');
                            end;
                        }
                        textelement(finan_outras_fontes)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                finan_outras_fontes := Format(rRu."ForProf. Outras Fontes Finan.", 0, '<integer>');
                            end;
                        }
                        textelement(encarg_globais_form_prof)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                encarg_globais_form_prof := Format((rRu."ForProf. Mont. Horas Form." + rRu."ForProf. Restanre Financia."
                                                         + rRu."ForProf. Fundo Social Europeu" + rRu."ForProf. Outras Fontes Finan."), 0, '<integer>');
                            end;
                        }
                        textelement(encarg_org_sst)
                        {

                            trigger OnBeforePassVariable()
                            begin

                                if not rSST.Get(Format(vAno)) then
                                    Error(Text0002);

                                encarg_org_sst := Format(rSST."Enc. Org.Serv. SST", 0, '<integer>');
                            end;
                        }
                        textelement(encarg_org_esp_trab)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                encarg_org_esp_trab := Format(rSST."Enc. Org./Mod. dos Espaços", 0, '<integer>');
                            end;
                        }
                        textelement(encarg_aqui_bens)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                encarg_aqui_bens := Format(rSST."Enc. Aquisição Bens e Equipame", 0, '<integer>');
                            end;
                        }
                        textelement(encarg_form)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                encarg_form := Format(rSST."Enc. Formação, Inf. e Consulta", 0, '<integer>');
                            end;
                        }
                        textelement(encarg_outros)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                encarg_outros := Format(rSST."Enc. Outros", 0, '<integer>');
                            end;
                        }
                        textelement(encarg_total)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                encarg_total := Format((rSST."Enc. Org.Serv. SST" + rSST."Enc. Org./Mod. dos Espaços" +
                                                      rSST."Enc. Aquisição Bens e Equipame" + rSST."Enc. Formação, Inf. e Consulta" +
                                                      rSST."Enc. Outros"), 0, '<integer>');
                            end;
                        }
                        textelement(outros_dados_comp_31Out)
                        {
                            textelement(vab)
                            {
                                textattribute(vab_ano)
                                {
                                    XmlName = 'ano';

                                    trigger OnBeforePassVariable()
                                    begin
                                        vab_ano := Format(vAno);
                                    end;
                                }

                                trigger OnBeforePassVariable()
                                begin
                                    vab := Format(rRu."Valor Acrescentado Bruto (VAB)");
                                end;
                            }
                            textelement(custos_pessoal)
                            {

                                trigger OnBeforePassVariable()
                                begin


                                    rGLAccount.Reset;
                                    rGLAccount.SetRange(rGLAccount."No.", rRu."Custos com Pessoal");
                                    rGLAccount.SetRange(rGLAccount."Date Filter", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                    if rGLAccount.FindFirst then begin
                                        rGLAccount.CalcFields(rGLAccount."Net Change");
                                        custos_pessoal := Format(rGLAccount."Net Change", 0, '<integer>');
                                    end else
                                        custos_pessoal := '0';
                                end;
                            }
                            textelement(amort_exerc)
                            {

                                trigger OnBeforePassVariable()
                                begin
                                    rGLAccount.Reset;
                                    rGLAccount.SetRange(rGLAccount."No.", rRu."Amortizações do Exercício");
                                    rGLAccount.SetRange(rGLAccount."Date Filter", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                    if rGLAccount.FindFirst then begin
                                        rGLAccount.CalcFields(rGLAccount."Net Change");
                                        amort_exerc := Format(rGLAccount."Net Change", 0, '<integer>');
                                    end else
                                        amort_exerc := '0';
                                end;
                            }
                            textelement(provi_exerc)
                            {

                                trigger OnBeforePassVariable()
                                begin
                                    rGLAccount.Reset;
                                    rGLAccount.SetRange(rGLAccount."No.", rRu."Provisões do Exercício");
                                    rGLAccount.SetRange(rGLAccount."Date Filter", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                    if rGLAccount.FindFirst then begin
                                        rGLAccount.CalcFields(rGLAccount."Net Change");
                                        provi_exerc := Format(rGLAccount."Net Change", 0, '<integer>');
                                    end else
                                        provi_exerc := '0';
                                end;
                            }
                            textelement(custos_perdas)
                            {

                                trigger OnBeforePassVariable()
                                begin

                                    rGLAccount.Reset;
                                    rGLAccount.SetRange(rGLAccount."No.", rRu."Custos e Perdas Financeiras");
                                    rGLAccount.SetRange(rGLAccount."Date Filter", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                    if rGLAccount.FindFirst then begin
                                        rGLAccount.CalcFields(rGLAccount."Net Change");
                                        custos_perdas := Format(rGLAccount."Net Change", 0, '<Sign><Integer>');
                                    end else
                                        custos_perdas := '0';
                                end;
                            }
                            textelement(impost_rend)
                            {

                                trigger OnBeforePassVariable()
                                begin

                                    rGLAccount.Reset;
                                    rGLAccount.SetRange(rGLAccount."No.", rRu."Imposto sobre Rendimento");
                                    rGLAccount.SetRange(rGLAccount."Date Filter", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                    if rGLAccount.FindFirst then begin
                                        rGLAccount.CalcFields(rGLAccount."Net Change");
                                        impost_rend := Format(rGLAccount."Net Change", 0, '<Sign><Integer>');
                                    end else
                                        impost_rend := '0';
                                end;
                            }
                            textelement(res_liquido)
                            {

                                trigger OnBeforePassVariable()
                                begin

                                    rGLAccount.Reset;
                                    rGLAccount.SetRange(rGLAccount."No.", rRu."Resultado Líquido do Exercício");
                                    rGLAccount.SetRange(rGLAccount."Date Filter", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                    if rGLAccount.FindFirst then begin
                                        rGLAccount.CalcFields(rGLAccount."Net Change");
                                        res_liquido := Format(rGLAccount."Net Change", 0, '<Sign><Integer>');
                                    end else
                                        res_liquido := '0';
                                end;
                            }
                            textelement(encarg_admin)
                            {
                                textelement(admin_subs_doenca)
                                {
                                    XmlName = 'subs_doenca';
                                    textelement(valor_admin_subs_doenca)
                                    {
                                        XmlName = 'valor';

                                        trigger OnBeforePassVariable()
                                        begin
                                            valor_admin_subs_doenca := Format(rRu."Enc. Adm. Subsídio por Doença", 0, '<integer>');
                                        end;
                                    }
                                    textelement(origem_admin_subs_doenca)
                                    {
                                        XmlName = 'origem_encargo';
                                        textattribute(tbl_admin_subs_doenca)
                                        {
                                            XmlName = 'tbl';

                                            trigger OnBeforePassVariable()
                                            begin
                                                tbl_admin_subs_doenca := 'RU_ORIENC'
                                            end;
                                        }

                                        trigger OnBeforePassVariable()
                                        begin
                                            origem_admin_subs_doenca := Format(rRu."Origem Enc. A- Subsídio Doen");
                                        end;
                                    }
                                }
                                textelement(admin_pensoes)
                                {
                                    XmlName = 'pensoes';
                                    textelement(valor_admin_pensoes)
                                    {
                                        XmlName = 'valor';

                                        trigger OnBeforePassVariable()
                                        begin
                                            valor_admin_pensoes := Format(rRu."Enc. Adm. Pensões Velhice", 0, '<integer>');
                                        end;
                                    }
                                    textelement(origem_admin_pensoes)
                                    {
                                        XmlName = 'origem_encargo';
                                        textattribute(tbl_admin_pensoes)
                                        {
                                            XmlName = 'tbl';

                                            trigger OnBeforePassVariable()
                                            begin
                                                tbl_admin_pensoes := 'RU_ORIENC';
                                            end;
                                        }

                                        trigger OnBeforePassVariable()
                                        begin
                                            origem_admin_pensoes := Format(rRu."Origem Enc. A- Pensões Velhice");
                                        end;
                                    }
                                }
                                textelement(admin_outras)
                                {
                                    XmlName = 'outras';
                                    textelement(valor_admin_outras)
                                    {
                                        XmlName = 'valor';

                                        trigger OnBeforePassVariable()
                                        begin
                                            valor_admin_outras := Format(rRu."Enc. Adm. Outras Prestações", 0, '<integer>');
                                        end;
                                    }
                                    textelement(origem_admin_outras)
                                    {
                                        XmlName = 'origem_encargo';
                                        textattribute(tbl_admin_outras)
                                        {
                                            XmlName = 'tbl';

                                            trigger OnBeforePassVariable()
                                            begin
                                                tbl_admin_outras := 'RU_ORIENC';
                                            end;
                                        }

                                        trigger OnBeforePassVariable()
                                        begin
                                            origem_admin_outras := Format(rRu."Origem Enc. A- Outras Prestaç");
                                        end;
                                    }
                                }
                            }
                            textelement(encarg_n_admin)
                            {
                                textelement(nadmin_subs_doenca)
                                {
                                    XmlName = 'subs_doenca';
                                    textelement(valor_n_admin_subs_doenca)
                                    {
                                        XmlName = 'valor';

                                        trigger OnBeforePassVariable()
                                        begin
                                            valor_n_admin_subs_doenca := Format(rRu."Enc. não Adm. Subsídio por Doe", 0, '<integer>');
                                        end;
                                    }
                                    textelement(origem_n_admin_subs_doenca)
                                    {
                                        XmlName = 'origem_encargo';
                                        textattribute(tbl_n_admin_subs_doenca)
                                        {
                                            XmlName = 'tbl';

                                            trigger OnBeforePassVariable()
                                            begin
                                                tbl_n_admin_subs_doenca := 'RU_ORIENC';
                                            end;
                                        }

                                        trigger OnBeforePassVariable()
                                        begin
                                            origem_n_admin_subs_doenca := Format(rRu."Origem Enc. NA- Subsídio Doen");
                                        end;
                                    }
                                }
                                textelement(nadmin_pensoes)
                                {
                                    XmlName = 'pensoes';
                                    textelement(valor_n_admin_pensoes)
                                    {
                                        XmlName = 'valor';

                                        trigger OnBeforePassVariable()
                                        begin
                                            valor_n_admin_pensoes := Format(rRu."Enc. não Adm. Pensões Velhice", 0, '<integer>');
                                        end;
                                    }
                                    textelement(origem_n_admin_pensoes)
                                    {
                                        XmlName = 'origem_encargo';
                                        textattribute(tbl_n_admin_pensoes)
                                        {
                                            XmlName = 'tbl';

                                            trigger OnBeforePassVariable()
                                            begin
                                                tbl_n_admin_pensoes := 'RU_ORIENC';
                                            end;
                                        }

                                        trigger OnBeforePassVariable()
                                        begin
                                            origem_n_admin_pensoes := Format(rRu."Origem Enc. NA- Pensões Velhic");
                                        end;
                                    }
                                }
                                textelement(nadmin_outras)
                                {
                                    XmlName = 'outras';
                                    textelement(valor_n_admin_outras)
                                    {
                                        XmlName = 'valor';

                                        trigger OnBeforePassVariable()
                                        begin
                                            valor_n_admin_outras := Format(rRu."Enc. não Adm. Outras Prestaç", 0, '<integer>');
                                        end;
                                    }
                                    textelement(origem_n_admin_outras)
                                    {
                                        XmlName = 'origem_encargo';
                                        textattribute(tbl_n_admin_outras)
                                        {
                                            XmlName = 'tbl';

                                            trigger OnBeforePassVariable()
                                            begin
                                                tbl_n_admin_outras := 'RU_ORIENC';
                                            end;
                                        }

                                        trigger OnBeforePassVariable()
                                        begin
                                            origem_n_admin_outras := Format(rRu."Origem Enc. NA- Outras Prestaç");
                                        end;
                                    }
                                }
                            }
                            textelement(encarg_accao)
                            {

                                trigger OnBeforePassVariable()
                                begin
                                    encarg_accao := Format(rRu."Enc. de Acção e Apoio Social", 0, '<integer>');
                                end;
                            }
                            textelement(poten_max_anual)
                            {

                                trigger OnBeforePassVariable()
                                var
                                    DataIni: Date;
                                    DataFim: Date;
                                    vContaHoras: Decimal;
                                begin
                                    Clear(vContaDiasUteis);
                                    Clear(vContaDiasEmp);
                                    Clear(vContaDiasTotais);
                                    Clear(vContaHoras);//Normatica 2014.04.10
                                                       //encontrar quantos dias uteis há no ano
                                    rData.Reset;
                                    rData.SetRange(rData."Period Type", rData."Period Type"::Date);
                                    rData.SetRange(rData."Period Start", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                    if rData.FindSet then begin
                                        repeat
                                            if rData."Period No." < 6 then
                                                vContaDiasUteis := vContaDiasUteis + 1;
                                        until rData.Next = 0;
                                    end;


                                    rEmpregado.Reset;
                                    rEmpregado.SetRange(rEmpregado."Tipo Contribuinte", rEmpregado."Tipo Contribuinte"::"Conta de Outrem");
                                    if rEmpregado.FindSet then begin
                                        repeat
                                            vContaDiasEmp := vContaDiasUteis;
                                            DataIni := DMY2Date(1, 1, vAno);
                                            DataFim := DMY2Date(31, 12, vAno);

                                            if (rEmpregado."End Date" = 0D) or (rEmpregado."End Date" > DMY2Date(1, 1, vAno)) then begin
                                                //caso o empregado entre ou saia a meio do ano
                                                if ((rEmpregado."Employment Date" >= DMY2Date(1, 1, vAno)) and (rEmpregado."Employment Date" <= DMY2Date(31, 12, vAno))) or
                                                   ((rEmpregado."End Date" >= DMY2Date(1, 1, vAno)) and (rEmpregado."End Date" <= DMY2Date(31, 12, vAno))) then begin
                                                    if rEmpregado."Employment Date" >= DMY2Date(1, 1, vAno) then
                                                        DataIni := rEmpregado."Employment Date";
                                                    if rEmpregado."End Date" <= DMY2Date(31, 12, vAno) then
                                                        DataFim := rEmpregado."End Date";
                                                    Clear(vContaDiasEmp);
                                                    rData.Reset;
                                                    rData.SetRange(rData."Period Type", rData."Period Type"::Date);
                                                    rData.SetRange(rData."Period Start", DataIni, DataFim);
                                                    if rData.FindSet then begin
                                                        repeat
                                                            if rData."Period No." < 6 then
                                                                vContaDiasEmp := vContaDiasEmp + 1;
                                                        until rData.Next = 0;
                                                    end;

                                                end;

                                                //Tirar os feriados
                                                rFeriados.Reset;
                                                rFeriados.SetRange(rFeriados.Data, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                rFeriados.SetRange(rFeriados.Estabelecimento, rEmpregado.Estabelecimento);
                                                if rFeriados.FindLast then
                                                    vContaDiasEmp := vContaDiasEmp - rFeriados.Count;
                                                //tirar as férias
                                                rFeriasEmpregado.Reset;
                                                rFeriasEmpregado.SetRange(rFeriasEmpregado."Employee No.", rEmpregado."No.");
                                                rFeriasEmpregado.SetRange(rFeriasEmpregado.Data, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                rFeriasEmpregado.SetRange(rFeriasEmpregado.Gozada, true);
                                                if rFeriasEmpregado.FindLast then
                                                    vContaDiasEmp := vContaDiasEmp - rFeriasEmpregado.Count;

                                                //vContaDiasTotais := vContaDiasTotais + vContaDiasEmp;
                                                //Normatica 2014.04.10 - deve ver qts horas o empregado faz por dia
                                                vContaHoras := vContaHoras +
                                                (vContaDiasEmp * rEmpregado."No. Horas Semanais" / rEmpregado."No. dias de Trabalho Semanal")
                                                //Normatica 2014.04.10 - fim
                                            end;
                                        until rEmpregado.Next = 0;
                                    end;

                                    //poten_max_anual := FORMAT(vContaDiasTotais *8); //Normatica 2013.03.18 - é em horas
                                    poten_max_anual := Format(Round(vContaHoras, 0.01)); //Normatica 2014.04.10
                                end;
                            }
                            textelement(horas_n_trab_ano)
                            {
                                tableelement(mothorntrab; "RU - Tabelas")
                                {
                                    XmlName = 'horas_n_trab';
                                    SourceTableView = WHERE(Tipo = CONST(MotHNTrab));
                                    fieldelement(motivo; MotHorNTrab."Código")
                                    {
                                        textattribute(tbl_mothntrab)
                                        {
                                            XmlName = 'tbl';

                                            trigger OnBeforePassVariable()
                                            begin
                                                tbl_mothntrab := 'RU_MHNT';
                                            end;
                                        }
                                    }
                                    textelement(horas_aus_remun)
                                    {
                                        MinOccurs = Zero;
                                        textelement(horas_aus_remun_h)
                                        {
                                            MinOccurs = Zero;
                                            XmlName = 'h';

                                            trigger OnBeforePassVariable()
                                            begin
                                                if vContH <> 0 then
                                                    horas_aus_remun_h := Format(vContH, 0, '<Integer>')
                                                else
                                                    currXMLport.Skip;
                                            end;
                                        }
                                        textelement(horas_aus_remun_m)
                                        {
                                            MinOccurs = Zero;
                                            XmlName = 'm';

                                            trigger OnBeforePassVariable()
                                            begin
                                                if vContM <> 0 then
                                                    horas_aus_remun_m := Format(vContM, 0, '<Integer>')
                                                else
                                                    currXMLport.Skip;
                                            end;
                                        }

                                        trigger OnBeforePassVariable()
                                        var
                                            vDia: Code[10];
                                            vHora: Code[10];
                                        begin
                                            Clear(vContM);
                                            Clear(vContH);
                                            Clear(Qtd);
                                            rUniMedHR.Reset;
                                            rUniMedHR.SetRange(rUniMedHR."Designação Interna", rUniMedHR."Designação Interna"::Dia);
                                            if rUniMedHR.FindFirst then
                                                vDia := rUniMedHR.Code;

                                            rUniMedHR.Reset;
                                            rUniMedHR.SetRange(rUniMedHR."Designação Interna", rUniMedHR."Designação Interna"::Hora);
                                            if rUniMedHR.FindFirst then
                                                vHora := rUniMedHR.Code;


                                            rMotAus.Reset;
                                            rMotAus.SetRange(rMotAus."Not Working Hours Reason Code", MotHorNTrab.Código);
                                            if rMotAus.FindSet then begin
                                                repeat
                                                    rHistAusen.Reset;
                                                    rHistAusen.SetRange(rHistAusen."From Date", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                    rHistAusen.SetRange(rHistAusen."Cause of Absence Code", rMotAus.Code);
                                                    rHistAusen.SetRange(rHistAusen."Com Perca de Remuneração", false);
                                                    if rHistAusen.FindSet then begin
                                                        repeat
                                                            Clear(Qtd);
                                                            if rEmpregado.Get(rHistAusen."Employee No.") then;

                                                            if rHistAusen."Unit of Measure Code" = vDia then
                                                                //Qtd := rHistAusen.Quantity*8;
                                                                //Normatica 2013.04.10 - nem todos os empregados trabalham 8 horas
                                                                Qtd := rHistAusen.Quantity * (rEmpregado."No. Horas Semanais" / rEmpregado."No. dias de Trabalho Semanal");

                                                            if rHistAusen."Unit of Measure Code" = vHora then
                                                                Qtd := rHistAusen.Quantity;

                                                            if rEmpregado.Get(rHistAusen."Employee No.") then begin
                                                                if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + Qtd;
                                                                if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + Qtd;
                                                            end;


                                                        until rHistAusen.Next = 0;
                                                    end;
                                                until rMotAus.Next = 0;
                                            end;

                                            if (vContH = 0) and (vContM = 0) then
                                                currXMLport.Skip;
                                        end;
                                    }
                                    textelement(horas_aus_n_remun)
                                    {
                                        MinOccurs = Zero;
                                        XmlName = 'horas_aus_n_remun_h';
                                        textelement(horas_aus_n_remun_h)
                                        {
                                            MinOccurs = Zero;
                                            XmlName = 'h';

                                            trigger OnBeforePassVariable()
                                            begin
                                                if vContH <> 0 then
                                                    horas_aus_n_remun_h := Format(vContH, 0, '<Integer>')
                                                else
                                                    currXMLport.Skip;
                                            end;
                                        }
                                        textelement(horas_aus_n_remun_m)
                                        {
                                            MinOccurs = Zero;
                                            XmlName = 'm';

                                            trigger OnBeforePassVariable()
                                            begin
                                                if vContM <> 0 then
                                                    horas_aus_n_remun_m := Format(vContM, 0, '<Integer>')
                                                else
                                                    currXMLport.Skip;
                                            end;
                                        }

                                        trigger OnBeforePassVariable()
                                        var
                                            vDia: Code[10];
                                            vHora: Code[10];
                                        begin
                                            Clear(vContM);
                                            Clear(vContH);
                                            Clear(Qtd);
                                            rUniMedHR.Reset;
                                            rUniMedHR.SetRange(rUniMedHR."Designação Interna", rUniMedHR."Designação Interna"::Dia);
                                            if rUniMedHR.FindFirst then
                                                vDia := rUniMedHR.Code;

                                            rUniMedHR.Reset;
                                            rUniMedHR.SetRange(rUniMedHR."Designação Interna", rUniMedHR."Designação Interna"::Hora);
                                            if rUniMedHR.FindFirst then
                                                vHora := rUniMedHR.Code;


                                            rMotAus.Reset;
                                            rMotAus.SetRange(rMotAus."Not Working Hours Reason Code", MotHorNTrab.Código);
                                            if rMotAus.FindSet then begin
                                                repeat
                                                    rHistAusen.Reset;
                                                    rHistAusen.SetRange(rHistAusen."From Date", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                    rHistAusen.SetRange(rHistAusen."Cause of Absence Code", rMotAus.Code);
                                                    rHistAusen.SetRange(rHistAusen."Com Perca de Remuneração", true);
                                                    if rHistAusen.FindSet then begin
                                                        repeat
                                                            Clear(Qtd);
                                                            if rEmpregado.Get(rHistAusen."Employee No.") then;

                                                            //      IF rHistAusen."Unit of Measure Code" = vDia THEN
                                                            //         Qtd := rHistAusen.Quantity*8;

                                                            //      Normatica 2013.04.10 - tem de ver só os dias uteis e nem todos os empregados trabalham 8 horas
                                                            if rHistAusen."Unit of Measure Code" = vDia then begin

                                                                rData.Reset;
                                                                rData.SetRange(rData."Period Type", rData."Period Type"::Date);
                                                                rData.SetRange(rData."Period Start", rHistAusen."From Date", rHistAusen."To Date");
                                                                if rData.FindSet then begin
                                                                    repeat
                                                                        if (Date2DWY(rData."Period Start", 1) <> 6) and (Date2DWY(rData."Period Start", 1) <> 7) then
                                                                            Qtd := Qtd + (rEmpregado."No. Horas Semanais" / rEmpregado."No. dias de Trabalho Semanal");
                                                                    until rData.Next = 0;
                                                                end;
                                                            end;
                                                            //      Normatica 2013.04.10 - fim

                                                            if rHistAusen."Unit of Measure Code" = vHora then
                                                                Qtd := rHistAusen.Quantity;

                                                            if (rEmpregado.Get(rHistAusen."Employee No.")) and
                                                               (rEmpregado."Tipo Contribuinte" = rEmpregado."Tipo Contribuinte"::"Conta de Outrem") then begin
                                                                if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + Qtd;
                                                                if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + Qtd;
                                                            end;


                                                        until rHistAusen.Next = 0;
                                                    end;
                                                until rMotAus.Next = 0;
                                            end;

                                            if (vContH = 0) and (vContM = 0) then
                                                currXMLport.Skip;
                                        end;
                                    }

                                    trigger OnAfterGetRecord()
                                    begin
                                        Flag := false;
                                        rMotAus.Reset;
                                        rMotAus.SetRange(rMotAus."Not Working Hours Reason Code", MotHorNTrab.Código);
                                        if rMotAus.FindSet then begin
                                            repeat
                                                rHistAusen.Reset;
                                                rHistAusen.SetRange(rHistAusen."From Date", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                rHistAusen.SetRange(rHistAusen."Cause of Absence Code", rMotAus.Code);
                                                if rHistAusen.FindSet then
                                                    Flag := true;
                                            until rMotAus.Next = 0;
                                        end;

                                        if Flag = false then
                                            currXMLport.Skip;
                                    end;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort()
    begin
        if rInfEmpresa.Get then;
        vAno := Date2DMY(WorkDate, 3) - 1;
        if not rRu.Get(Format(vAno)) then
            Error(Text0001, vAno);
    end;

    var
        rHistEmpregado: Record "Historico Empregado";
        rDestacamentos: Record Destacamentos;
        rEmpregado: Record Empregado;
        rAssociacoes: Record "Associações Empregadores";
        rPerdAnomEmp: Record "Perdas e Anomalias Emp.";
        rHabilitacao: Record "Habilitação";
        rInfEmpresa: Record "Company Information";
        rRu: Record RU;
        rSST: Record "Segurança e Saúde no Trabalho";
        tempDestacamentos: Record Destacamentos temporary;
        rHistLinhasMovEmp: Record "Hist. Linhas Movs. Empregado";
        rRubricaSalarial: Record "Payroll Item";
        rHistCabMovEmp: Record "Hist. Cab. Movs. Empregado";
        rHistHorasExtra: Record "Histórico Horas Extra";
        rGLEntry: Record "G/L Entry";
        rGLAccount: Record "G/L Account";
        rMotAus: Record "Absence Reason";
        rHistAusen: Record "Histórico Ausências";
        rUniMedHR: Record "Unid. Medida Recursos Humanos";
        rData: Record Date;
        rFeriados: Record "Feriados RH";
        rFeriasEmpregado: Record "Férias Empregados";
        rConfRH: Record "Config. Recursos Humanos";
        i: Integer;
        vDate: Date;
        vTotPessoas: Integer;
        vAno: Integer;
        vConta: Integer;
        Text0001: Label 'Tem de parametrizar as configurações do Relatório único para o ano de %1.';
        Text0002: Label 'Tem de parametrizar as configurações da Segurança e Saúde no Trabalho para o ano de %1.';
        Flag: Boolean;
        vContM: Decimal;
        vContH: Decimal;
        Qtd: Decimal;
        vContaDiasUteis: Integer;
        vContaDiasEmp: Integer;
        vContaDiasTotais: Integer;
        Utils: Codeunit "PTSS Export SAF-T PT";
}

