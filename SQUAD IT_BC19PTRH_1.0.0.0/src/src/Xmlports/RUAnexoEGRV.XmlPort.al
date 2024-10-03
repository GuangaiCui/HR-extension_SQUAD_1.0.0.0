xmlport 53040 "RU - Anexo E - GRV"
{
    Encoding = UTF8;
    Namespaces = ru = 'http://www.gep.mtss.gov.pt/sguri/ru', t = 'http://www.gep.mtss.gov.pt/sguri/tipos_comuns',
                 xsi = 'http://www.w3.org/2001/XMLSchema-instance';

    schema
    {
        textelement(relatorio_unico)
        {
            NamespacePrefix = 'ru';
            textattribute(XML_DATA)
            {

                trigger OnBeforePassVariable()
                begin
                    XML_DATA := '3.3.0';
                end;
            }
            /*
            textattribute("xmlns:ru")
            {

                trigger OnBeforePassVariable()
                begin
                    "xmlns:ru" := 'http://www.gep.mtss.gov.pt/sguri/ru';
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

                trigger OnBeforePassVariable()
                begin
                    "xsi:schemaLocation" := 'http://www.gep.mtss.gov.pt/sguri/ru relatorio-grv-3.3.0.xsd ';
                    //"xsi:schemaLocation" += 'http://www.gep.mtss.gov.pt/sguri/tipos_comuns tipos-comuns-1.1.xsd ';
                    "xsi:schemaLocation" += 'http://www.gep.mtss.gov.pt/sguri/ru/anexo_grv anexo-grv-3.3.0.xsd';
                end;
            }
            textelement(header)
            {
                NamespacePrefix = 'ru';
                textelement(aplicacao)
                {
                    NamespacePrefix = 'ru';
                    textelement(nome)
                    {
                        NamespacePrefix = 'ru';

                        trigger OnBeforePassVariable()
                        begin
                            nome := 'Microsoft Dynamics NAV';
                        end;
                    }
                    textelement(versao)
                    {

                        NamespacePrefix = 'ru';

                        trigger OnBeforePassVariable()
                        begin
                            versao := Utils.CodProductVersion();
                        end;
                    }
                    textelement(empresa)
                    {

                        NamespacePrefix = 'ru';

                        trigger OnBeforePassVariable()
                        begin
                            empresa := rCompInf.Name;
                        end;
                    }
                }
            }
            textelement(body)
            {
                NamespacePrefix = 'ru';

                textelement(anexos)
                {
                    NamespacePrefix = 'ru';

                    textelement(anexo_grv)
                    {
                        textattribute(xmlns2)
                        {
                            XmlName = 'xmlns';

                            trigger OnBeforePassVariable()
                            begin
                                //xmlns2 := 'http://www.gep.mtss.gov.pt/sguri/ru/anexo_grv';
                            end;
                        }
                        textattribute(xml_data1)
                        {
                            XmlName = 'XML_DATA';

                            trigger OnBeforePassVariable()
                            begin
                                XML_DATA1 := '3.3.0';
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
                                nome_entidade := rCompInf.Name;
                            end;
                        }
                        textelement(exist_greves)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                rGreves.Reset;
                                rGreves.SetRange(rGreves.Year, vAno);
                                if rGreves.FindFirst then
                                    exist_greves := 'S'
                                else
                                    exist_greves := 'N';
                            end;
                        }
                        tableelement("estabelecimentos da empresa"; "Estabelecimentos da Empresa")
                        {
                            XmlName = 'estab';
                            fieldattribute(id; "Estabelecimentos da Empresa"."ID Unidade Local")
                            {
                            }
                            textattribute(estab_exist_greves)
                            {
                                XmlName = 'exist_greves';

                                trigger OnBeforePassVariable()
                                begin
                                    rGreves.Reset;
                                    rGreves.SetRange(rGreves.Year, vAno);
                                    if rGreves.FindFirst then
                                        Estab_exist_greves := 'S'
                                    else
                                        Estab_exist_greves := 'N';
                                end;
                            }
                            textattribute(sede)
                            {

                                trigger OnBeforePassVariable()
                                begin
                                    if "Estabelecimentos da Empresa".Sede = true then
                                        sede := 'S'
                                    else
                                        sede := 'N';
                                end;
                            }
                            fieldelement(cae_31Dez; "Estabelecimentos da Empresa"."CAE Code")
                            {
                                textattribute(tbl_estab_cae_31dez)
                                {
                                    XmlName = 'tbl';

                                    trigger OnBeforePassVariable()
                                    begin
                                        tbl_estab_cae_31Dez := 'RU_CAE_5DIG';
                                    end;
                                }
                            }
                            textelement(pess_servico_31Dez)
                            {

                                trigger OnBeforePassVariable()
                                begin
                                    if Estab_exist_greves = 'S' then begin
                                        Clear(vConta);
                                        Clear(pess_servico_31Dez);
                                        rEmpregado.Reset;
                                        rEmpregado.SetRange(rEmpregado.Estabelecimento, "Estabelecimentos da Empresa"."Número da Unidade Local");
                                        rEmpregado.SetRange(rEmpregado."Tipo Contribuinte", rEmpregado."Tipo Contribuinte"::"Conta de Outrem");
                                        if rEmpregado.FindSet then begin
                                            repeat
                                                rHistCabMovEmp.Reset;
                                                rHistCabMovEmp.SetRange(rHistCabMovEmp."No. Empregado", rEmpregado."No.");
                                                rHistCabMovEmp.SetRange(rHistCabMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                                rHistCabMovEmp.SetRange(rHistCabMovEmp."Data Registo", DMY2Date(1, 10, vAno), DMY2Date(31, 10, vAno));
                                                if rHistCabMovEmp.FindSet then
                                                    vConta := vConta + 1;
                                            until rEmpregado.Next = 0;
                                        end;


                                        //Abater os ausentes à mais de um mês
                                        rEmpregado.Reset;
                                        rEmpregado.SetRange(rEmpregado.Estabelecimento, "Estabelecimentos da Empresa"."Número da Unidade Local");
                                        rEmpregado.SetRange(rEmpregado."Tipo Contribuinte", rEmpregado."Tipo Contribuinte"::"Conta de Outrem");
                                        if rEmpregado.FindSet then begin
                                            repeat
                                                rHistCabMovEmp.Reset;
                                                rHistCabMovEmp.SetRange(rHistCabMovEmp."No. Empregado", rEmpregado."No.");
                                                rHistCabMovEmp.SetRange(rHistCabMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                                rHistCabMovEmp.SetRange(rHistCabMovEmp."Data Registo", DMY2Date(1, 10, vAno), DMY2Date(31, 10, vAno));
                                                rHistCabMovEmp.SetRange(rHistCabMovEmp.Valor, 0);
                                                if rHistCabMovEmp.FindFirst then begin
                                                    rHistAusencia.Next;
                                                    rHistAusencia.SetRange(rHistAusencia."Employee No.", rHistCabMovEmp."No. Empregado");
                                                    rHistAusencia.SetRange(rHistAusencia."To Date", DMY2Date(30, 9, vAno));
                                                    if rHistAusencia.FindFirst then
                                                        vConta := vConta - 1;
                                                end;
                                            until rEmpregado.Next = 0;
                                        end;


                                        pess_servico_31Dez := Format(vConta);
                                    end;
                                end;
                            }
                            textelement(nr_medio_anual_tco)
                            {

                                trigger OnBeforePassVariable()
                                begin
                                    if Estab_exist_greves = 'S' then begin
                                        Clear(vTotPessoas);
                                        vDate := DMY2Date(1, 1, vAno);

                                        for i := 1 to 12 do begin
                                            rHistCabMovEmp.Reset;
                                            rHistCabMovEmp.SetRange(rHistCabMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                            rHistCabMovEmp.SetRange(rHistCabMovEmp."Data Registo", vDate, CalcDate('+1M-1D', vDate));
                                            if rHistCabMovEmp.FindSet then begin
                                                repeat
                                                    rEmpregado.Reset;
                                                    rEmpregado.SetRange(rEmpregado."No.", rHistCabMovEmp."No. Empregado");
                                                    rEmpregado.SetRange(rEmpregado.Estabelecimento, "Estabelecimentos da Empresa"."Número da Unidade Local");
                                                    rEmpregado.SetRange(rEmpregado."Tipo Contribuinte", rEmpregado."Tipo Contribuinte"::"Conta de Outrem");
                                                    if rEmpregado.FindFirst then
                                                        vTotPessoas := vTotPessoas + 1;
                                                until rHistCabMovEmp.Next = 0;
                                            end;
                                            vDate := CalcDate('+1M', vDate);
                                        end;

                                        nr_medio_anual_tco := Format(Round(vTotPessoas / 12, 1));
                                    end;
                                end;
                            }
                            textelement(xgreves)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                XmlName = 'greves';
                                tableelement(greves; Greves)
                                {
                                    MinOccurs = Zero;
                                    XmlName = 'greve';
                                    SourceTableView = WHERE(Type = CONST(Cabecalho));
                                    fieldelement(ident_greve; Greves."Strike Code")
                                    {
                                        textattribute(tbl_ident_greve)
                                        {
                                            XmlName = 'tbl';

                                            trigger OnBeforePassVariable()
                                            begin
                                                tbl_ident_greve := 'RU_GREVE';
                                            end;
                                        }
                                    }
                                    textelement(reivindicacoes_princ)
                                    {
                                        tableelement(greves1; Greves)
                                        {
                                            XmlName = 'reivindicacao_princ';
                                            SourceTableView = WHERE(Type = CONST(Linha1));
                                            fieldelement(reivindicacao; Greves1.Claim)
                                            {
                                                textattribute(tbl_reivindicacao)
                                                {
                                                    XmlName = 'tbl';

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        tbl_reivindicacao := 'RU_GRE_REIV';
                                                    end;
                                                }
                                            }
                                            textelement(res)
                                            {
                                                textattribute(tbl_res)
                                                {
                                                    XmlName = 'tbl';

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        tbl_res := 'RU_GRE_RESULT';
                                                    end;
                                                }

                                                trigger OnBeforePassVariable()
                                                begin
                                                    Clear(intResultado);
                                                    intResultado := Greves1.Result;
                                                    res := Format(intResultado);
                                                end;
                                            }

                                            trigger OnPreXmlItem()
                                            begin
                                                Greves1.SetRange(Greves1.Year, Greves.Year);
                                                Greves1.SetRange(Greves1."Strike Code", Greves."Strike Code");
                                            end;
                                        }
                                    }
                                    textelement(datas_greve)
                                    {
                                        tableelement(greves2; Greves)
                                        {
                                            XmlName = 'data_greve';
                                            SourceTableView = WHERE(Type = CONST(Linha2));
                                            textelement(data)
                                            {

                                                trigger OnBeforePassVariable()
                                                begin
                                                    Clear(data);
                                                    data := Format(Greves2."Strike Date", 0, '<Month,2>-<day,2>');
                                                end;
                                            }
                                            textelement(pnt)
                                            {

                                                trigger OnBeforePassVariable()
                                                begin
                                                    Clear(pnt);
                                                    pnt := ConvertStr(Format(Greves2."Normal Working Period"), ',', ':');
                                                end;
                                            }
                                            fieldelement(n_trab_grv; Greves2."Strike Number of Workers")
                                            {
                                            }
                                            textelement(duracao)
                                            {

                                                trigger OnBeforePassVariable()
                                                begin

                                                    Clear(duracao);
                                                    if StrLen(Format(Greves2."Stop Time (Hours)")) = 1 then
                                                        duracao := '0' + Format(Greves2."Stop Time (Hours)")
                                                    else
                                                        duracao := Format(Greves2."Stop Time (Hours)");
                                                    duracao := duracao + ':';
                                                    if StrLen(Format(Greves2."Stop Time (Minutes)")) = 1 then
                                                        duracao := duracao + '0' + Format(Greves2."Stop Time (Minutes)")
                                                    else
                                                        duracao := duracao + Format(Greves2."Stop Time (Minutes)");
                                                end;
                                            }

                                            trigger OnPreXmlItem()
                                            begin
                                                Greves2.SetRange(Greves2.Year, Greves.Year);
                                                Greves2.SetRange(Greves2."Strike Code", Greves."Strike Code");
                                            end;
                                        }
                                    }

                                    trigger OnPreXmlItem()
                                    begin
                                        Greves.SetRange(Greves.Year, vAno);
                                    end;
                                }

                                trigger OnBeforePassVariable()
                                begin
                                    if Estab_exist_greves = 'N' then
                                        currXMLport.Skip;
                                end;
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
        if rCompInf.Get then;
        vAno := Date2DMY(WorkDate, 3) - 1;
    end;

    var
        rEmpregado: Record Empregado;
        rCompInf: Record "Company Information";
        rGreves: Record Greves;
        rConfRH: Record "Config. Recursos Humanos";
        vAno: Integer;
        intResultado: Integer;
        vConta: Integer;
        rHistCabMovEmp: Record "Hist. Cab. Movs. Empregado";
        rHistAusencia: Record "Histórico Ausências";
        vTotPessoas: Integer;
        vDate: Date;
        i: Integer;
        Utils: Codeunit "PTSS Export SAF-T PT";
}

