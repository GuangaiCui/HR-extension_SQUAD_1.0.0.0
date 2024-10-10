xmlport 53039 "RU - Anexo D - SST"
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
                    "xsi:schemaLocation" := 'http://www.gep.mtss.gov.pt/sguri/ru relatorio-sst-3.3.0.xsd ';
                    "xsi:schemaLocation" += 'http://www.gep.mtss.gov.pt/sguri/tipos_comuns tipos-comuns-1.4.0.xsd ';
                    "xsi:schemaLocation" += 'http://www.gep.mtss.gov.pt/sguri/ru/anexo_sst anexo-sst-2.4.0.xsd';
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
                    textelement(anexo_sst)
                    {
                        textattribute(xmlns2)
                        {
                            XmlName = 'xmlns';

                            trigger OnBeforePassVariable()
                            begin
                                //xmlns2 := 'http://www.gep.mtss.gov.pt/sguri/ru/anexo_sst';
                            end;
                        }
                        textattribute(xml_data1)
                        {
                            XmlName = 'XML_DATA';

                            trigger OnBeforePassVariable()
                            begin
                                XML_DATA1 := '2.4.0';
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
                        textelement(estabs)
                        {
                            tableelement("estabelecimentos da empresa"; "Estabelecimentos da Empresa")
                            {
                                XmlName = 'estab';
                                fieldattribute(id; "Estabelecimentos da Empresa"."ID Unidade Local")
                                {
                                }
                                textattribute(sede)
                                {

                                    trigger OnBeforePassVariable()
                                    begin
                                        if "Estabelecimentos da Empresa".Sede then
                                            sede := 'S'
                                        else
                                            sede := 'N';
                                    end;
                                }
                                textelement(exist_trab_serv)
                                {

                                    trigger OnBeforePassVariable()
                                    begin
                                        rHistEmpregado.Reset;
                                        rHistEmpregado.SetRange(rHistEmpregado.Status, rHistEmpregado.Status::Active);
                                        rHistEmpregado.SetRange(rHistEmpregado."Data Registo", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                        rHistEmpregado.SetRange(rHistEmpregado.Estabelecimento, "Estabelecimentos da Empresa"."Número da Unidade Local");
                                        if rHistEmpregado.Find('+') then
                                            exist_trab_serv := 'S'
                                        else
                                            exist_trab_serv := 'N';
                                    end;
                                }
                                textelement(dados_sst)
                                {
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
                                            cae_31Dez := rCompInf."PTSS CAE Code";
                                        end;
                                    }
                                    textelement(n_medio_trab)
                                    {
                                        textelement(vinc)
                                        {
                                            textelement(total_vinc)
                                            {
                                                XmlName = 'total';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    Clear(vTotPessoas);
                                                    Clear(vContM);
                                                    Clear(vContH);
                                                    vDate := DMY2Date(1, 1, vAno);

                                                    for i := 1 to 12 do begin
                                                        rHistCabMovEmp.Reset;
                                                        rHistCabMovEmp.SetRange(rHistCabMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                                        rHistCabMovEmp.SetRange(rHistCabMovEmp."Data Registo", vDate, CalcDate('+1M-1D', vDate));
                                                        if rHistCabMovEmp.FindSet then begin
                                                            repeat
                                                                if (rEmpregado.Get(rHistCabMovEmp."Employee No.")) and
                                                                   (rEmpregado.Estabelecimento = "Estabelecimentos da Empresa"."Número da Unidade Local") then begin

                                                                    rContratoEmpregado.Reset;
                                                                    rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", rEmpregado."No.");
                                                                    rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', CalcDate('+1M-1D', vDate));
                                                                    rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '=%1|>=%2', 0D, CalcDate('+1M-1D', vDate));
                                                                    if rContratoEmpregado.FindFirst then begin
                                                                        if (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"Sem Termo") or
                                                                           (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"A Termo") then begin
                                                                            vTotPessoas := vTotPessoas + 1;
                                                                            if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                            if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                        end else begin

                                                                            if (rContratoTrab.Get(rContratoEmpregado."Cód. Contrato")) and
                                                                              ((rContratoTrab."Cód. Tipo Contrato" = '12') or (rContratoTrab."Cód. Tipo Contrato" = '22')
                                                                              or (rContratoTrab."Cód. Tipo Contrato" = '32') or (rContratoTrab."Cód. Tipo Contrato" = '14')
                                                                              or (rContratoTrab."Cód. Tipo Contrato" = '11') or (rContratoTrab."Cód. Tipo Contrato" = '21')) then begin
                                                                                vTotPessoas := vTotPessoas + 1;
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                            end;


                                                                        end;
                                                                    end;
                                                                end;
                                                            until rHistCabMovEmp.Next = 0;
                                                        end;
                                                        vDate := CalcDate('+1M', vDate);
                                                    end;

                                                    total_vinc := Format(Round(vTotPessoas / 12, 1));
                                                    int_h_vinc := Round(vContH / 12, 1);
                                                    int_m_vinc := Round(vContM / 12, 1);

                                                    int_total_vinc := Round(vTotPessoas / 12, 1);
                                                end;
                                            }
                                            textelement(h_vinc)
                                            {
                                                XmlName = 'h';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    h_vinc := Format(Round(vContH / 12, 1));
                                                end;
                                            }
                                            textelement(m_vinc)
                                            {
                                                XmlName = 'm';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    m_vinc := Format(Round(vContM / 12, 1));
                                                end;
                                            }
                                        }
                                        textelement(vinc_a_trab)
                                        {
                                            textelement(total_vinc_a_trab)
                                            {
                                                XmlName = 'total';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    Clear(vTotPessoas);
                                                    Clear(vContM);
                                                    Clear(vContH);
                                                    vDate := DMY2Date(1, 1, vAno);

                                                    for i := 1 to 12 do begin
                                                        rHistCabMovEmp.Reset;
                                                        rHistCabMovEmp.SetRange(rHistCabMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                                        rHistCabMovEmp.SetRange(rHistCabMovEmp."Data Registo", vDate, CalcDate('+1M-1D', vDate));
                                                        if rHistCabMovEmp.FindSet then begin
                                                            repeat
                                                                if (rEmpregado.Get(rHistCabMovEmp."Employee No.")) and
                                                                   (rEmpregado.Estabelecimento = "Estabelecimentos da Empresa"."Número da Unidade Local") then begin
                                                                    rContratoEmpregado.Reset;
                                                                    rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", rEmpregado."No.");
                                                                    rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', CalcDate('+1M-1D', vDate));
                                                                    rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '=%1|>=%2', 0D, CalcDate('+1M-1D', vDate));
                                                                    if rContratoEmpregado.FindFirst then begin
                                                                        if (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"Sem Termo") or
                                                                           (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"A Termo") then begin
                                                                            vTotPessoas := vTotPessoas + 1;
                                                                            if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                            if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                        end;
                                                                    end;
                                                                end;
                                                            until rHistCabMovEmp.Next = 0;
                                                        end;
                                                        vDate := CalcDate('+1M', vDate);
                                                    end;

                                                    total_vinc_a_trab := Format(Round(vTotPessoas / 12, 1));
                                                end;
                                            }
                                            textelement(h_vinc_a_trab)
                                            {
                                                XmlName = 'h';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    h_vinc_a_trab := Format(Round(vContH / 12, 1));
                                                end;
                                            }
                                            textelement(m_vinc_a_trab)
                                            {
                                                XmlName = 'm';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    m_vinc_a_trab := Format(Round(vContM / 12, 1));
                                                end;
                                            }
                                        }
                                        textelement(vinc_trab_fora)
                                        {
                                            textelement(total_vinc_trab_fora)
                                            {
                                                XmlName = 'total';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    Clear(vTotPessoas);
                                                    Clear(vContM);
                                                    Clear(vContH);
                                                    vDate := DMY2Date(1, 1, vAno);

                                                    for i := 1 to 12 do begin
                                                        rHistCabMovEmp.Reset;
                                                        rHistCabMovEmp.SetRange(rHistCabMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                                        rHistCabMovEmp.SetRange(rHistCabMovEmp."Data Registo", vDate, CalcDate('+1M-1D', vDate));
                                                        if rHistCabMovEmp.FindSet then begin
                                                            repeat
                                                                if (rEmpregado.Get(rHistCabMovEmp."Employee No.")) and
                                                                   (rEmpregado.Estabelecimento = "Estabelecimentos da Empresa"."Número da Unidade Local") then begin

                                                                    rContratoEmpregado.Reset;
                                                                    rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", rEmpregado."No.");
                                                                    rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', CalcDate('+1M-1D', vDate));
                                                                    rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '=%1|>=%2', 0D, CalcDate('+1M-1D', vDate));
                                                                    if rContratoEmpregado.FindFirst then begin
                                                                        if (rContratoTrab.Get(rContratoEmpregado."Cód. Contrato")) and
                                                                           ((rContratoTrab."Cód. Tipo Contrato" = '12') or (rContratoTrab."Cód. Tipo Contrato" = '22')
                                                                           or (rContratoTrab."Cód. Tipo Contrato" = '32') or (rContratoTrab."Cód. Tipo Contrato" = '14')
                                                                           or (rContratoTrab."Cód. Tipo Contrato" = '11') or (rContratoTrab."Cód. Tipo Contrato" = '21')) then begin
                                                                            vTotPessoas := vTotPessoas + 1;
                                                                            if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                            if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                        end;
                                                                    end;
                                                                end;
                                                            until rHistCabMovEmp.Next = 0;
                                                        end;
                                                        vDate := CalcDate('+1M', vDate);
                                                    end;

                                                    total_vinc_trab_fora := Format(Round(vTotPessoas / 12, 1));
                                                end;
                                            }
                                            textelement(h_vinc_trab_fora)
                                            {
                                                XmlName = 'h';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    h_vinc_trab_fora := Format(Round(vContH / 12, 1));
                                                end;
                                            }
                                            textelement(m_vinc_trab_fora)
                                            {
                                                XmlName = 'm';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    m_vinc_trab_fora := Format(Round(vContM / 12, 1));
                                                end;
                                            }
                                        }
                                        textelement(vinc_trab_fora_temp)
                                        {
                                            textelement(total_vinc_trab_fora_temp)
                                            {
                                                XmlName = 'total';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    Clear(vTotPessoas);
                                                    Clear(vContM);
                                                    Clear(vContH);
                                                    vDate := DMY2Date(1, 1, vAno);

                                                    for i := 1 to 12 do begin
                                                        rHistCabMovEmp.Reset;
                                                        rHistCabMovEmp.SetRange(rHistCabMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                                        rHistCabMovEmp.SetRange(rHistCabMovEmp."Data Registo", vDate, CalcDate('+1M-1D', vDate));
                                                        if rHistCabMovEmp.FindSet then begin
                                                            repeat
                                                                if (rEmpregado.Get(rHistCabMovEmp."Employee No.")) and
                                                                   (rEmpregado.Estabelecimento = "Estabelecimentos da Empresa"."Número da Unidade Local") then begin

                                                                    rContratoEmpregado.Reset;
                                                                    rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", rEmpregado."No.");
                                                                    rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', CalcDate('+1M-1D', vDate));
                                                                    rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '=%1|>=%2', 0D, CalcDate('+1M-1D', vDate));
                                                                    if rContratoEmpregado.FindFirst then begin
                                                                        if (rContratoTrab.Get(rContratoEmpregado."Cód. Contrato")) and
                                                                           ((rContratoTrab."Cód. Tipo Contrato" = '12') or (rContratoTrab."Cód. Tipo Contrato" = '22')
                                                                           or (rContratoTrab."Cód. Tipo Contrato" = '32')) then begin
                                                                            vTotPessoas := vTotPessoas + 1;
                                                                            if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                            if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                        end;
                                                                    end;
                                                                end;
                                                            until rHistCabMovEmp.Next = 0;
                                                        end;
                                                        vDate := CalcDate('+1M', vDate);
                                                    end;

                                                    total_vinc_trab_fora_temp := Format(Round(vTotPessoas / 12, 1));
                                                end;
                                            }
                                            textelement(h_vinc_trab_fora_temp)
                                            {
                                                XmlName = 'h';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    h_vinc_trab_fora_temp := Format(Round(vContH / 12, 1));
                                                end;
                                            }
                                            textelement(m_vinc_trab_fora_temp)
                                            {
                                                XmlName = 'm';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    m_vinc_trab_fora_temp := Format(Round(vContM / 12, 1));
                                                end;
                                            }
                                        }
                                        textelement(vinc_trab_fora_ocas)
                                        {
                                            textelement(total_vinc_trab_fora_ocas)
                                            {
                                                XmlName = 'total';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    Clear(vTotPessoas);
                                                    Clear(vContM);
                                                    Clear(vContH);
                                                    vDate := DMY2Date(1, 1, vAno);

                                                    for i := 1 to 12 do begin
                                                        rHistCabMovEmp.Reset;
                                                        rHistCabMovEmp.SetRange(rHistCabMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                                        rHistCabMovEmp.SetRange(rHistCabMovEmp."Data Registo", vDate, CalcDate('+1M-1D', vDate));
                                                        if rHistCabMovEmp.FindSet then begin
                                                            repeat
                                                                if (rEmpregado.Get(rHistCabMovEmp."Employee No.")) and
                                                                   (rEmpregado.Estabelecimento = "Estabelecimentos da Empresa"."Número da Unidade Local") then begin

                                                                    rContratoEmpregado.Reset;
                                                                    rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", rEmpregado."No.");
                                                                    rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', CalcDate('+1M-1D', vDate));
                                                                    rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '=%1|>=%2', 0D, CalcDate('+1M-1D', vDate));
                                                                    if rContratoEmpregado.FindFirst then begin
                                                                        if (rContratoTrab.Get(rContratoEmpregado."Cód. Contrato")) and
                                                                           ((rContratoTrab."Cód. Tipo Contrato" = '14')) then begin
                                                                            vTotPessoas := vTotPessoas + 1;
                                                                            if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                            if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                        end;
                                                                    end;
                                                                end;
                                                            until rHistCabMovEmp.Next = 0;
                                                        end;
                                                        vDate := CalcDate('+1M', vDate);
                                                    end;

                                                    total_vinc_trab_fora_ocas := Format(Round(vTotPessoas / 12, 1));
                                                end;
                                            }
                                            textelement(h_vinc_trab_fora_ocas)
                                            {
                                                XmlName = 'h';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    h_vinc_trab_fora_ocas := Format(Round(vContH / 12, 1));
                                                end;
                                            }
                                            textelement(m_vinc_trab_fora_ocas)
                                            {
                                                XmlName = 'm';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    m_vinc_trab_fora_ocas := Format(Round(vContM / 12, 1));
                                                end;
                                            }
                                        }
                                        textelement(vinc_trab_fora_outros)
                                        {
                                            textelement(total_vinc_trab_fora_outros)
                                            {
                                                XmlName = 'total';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    Clear(vTotPessoas);
                                                    Clear(vContM);
                                                    Clear(vContH);
                                                    vDate := DMY2Date(1, 1, vAno);

                                                    for i := 1 to 12 do begin
                                                        rHistCabMovEmp.Reset;
                                                        rHistCabMovEmp.SetRange(rHistCabMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                                        rHistCabMovEmp.SetRange(rHistCabMovEmp."Data Registo", vDate, CalcDate('+1M-1D', vDate));
                                                        if rHistCabMovEmp.FindSet then begin
                                                            repeat
                                                                if (rEmpregado.Get(rHistCabMovEmp."Employee No.")) and
                                                                   (rEmpregado.Estabelecimento = "Estabelecimentos da Empresa"."Número da Unidade Local") then begin

                                                                    rContratoEmpregado.Reset;
                                                                    rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", rEmpregado."No.");
                                                                    rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', CalcDate('+1M-1D', vDate));
                                                                    rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '=%1|>=%2', 0D, CalcDate('+1M-1D', vDate));
                                                                    if rContratoEmpregado.FindFirst then begin
                                                                        if (rContratoTrab.Get(rContratoEmpregado."Cód. Contrato")) and
                                                                           ((rContratoTrab."Cód. Tipo Contrato" = '11') or (rContratoTrab."Cód. Tipo Contrato" = '21')) then begin
                                                                            vTotPessoas := vTotPessoas + 1;
                                                                            if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                            if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                        end;
                                                                    end;
                                                                end;
                                                            until rHistCabMovEmp.Next = 0;
                                                        end;
                                                        vDate := CalcDate('+1M', vDate);
                                                    end;

                                                    total_vinc_trab_fora_outros := Format(Round(vTotPessoas / 12, 1));
                                                end;
                                            }
                                            textelement(h_vinc_trab_fora_outros)
                                            {
                                                XmlName = 'h';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    h_vinc_trab_fora_outros := Format(Round(vContH / 12, 1));
                                                end;
                                            }
                                            textelement(m_vinc_trab_fora_outros)
                                            {
                                                XmlName = 'm';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    m_vinc_trab_fora_outros := Format(Round(vContM / 12, 1));
                                                end;
                                            }
                                        }
                                        textelement(outros)
                                        {
                                            textelement(total_outros)
                                            {
                                                XmlName = 'total';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    Clear(vTotPessoas);
                                                    Clear(vContM);
                                                    Clear(vContH);
                                                    vDate := DMY2Date(1, 1, vAno);

                                                    for i := 1 to 12 do begin
                                                        rHistCabMovEmp.Reset;
                                                        rHistCabMovEmp.SetRange(rHistCabMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                                        rHistCabMovEmp.SetRange(rHistCabMovEmp."Data Registo", vDate, CalcDate('+1M-1D', vDate));
                                                        if rHistCabMovEmp.FindSet then begin
                                                            repeat
                                                                if (rEmpregado.Get(rHistCabMovEmp."Employee No.")) and
                                                                   (rEmpregado."Tipo Contribuinte" = rEmpregado."Tipo Contribuinte"::"Trabalhador Independente") and
                                                                   (rEmpregado.Estabelecimento = "Estabelecimentos da Empresa"."Número da Unidade Local") then begin
                                                                    vTotPessoas := vTotPessoas + 1;
                                                                    if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                    if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                end;
                                                            until rHistCabMovEmp.Next = 0;
                                                        end;
                                                        vDate := CalcDate('+1M', vDate);
                                                    end;

                                                    total_outros := Format(Round(vTotPessoas / 12, 1));

                                                    int_total_outros := Round(vTotPessoas / 12, 1);
                                                    int_h_outros := Round(vContH / 12, 1);
                                                    int_m_outros := Round(vContM / 12, 1);
                                                end;
                                            }
                                            textelement(h_outros)
                                            {
                                                XmlName = 'h';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    h_outros := Format(Round(vContH / 12, 1));
                                                end;
                                            }
                                            textelement(m_outros)
                                            {
                                                XmlName = 'm';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    m_outros := Format(Round(vContM / 12, 1));
                                                end;
                                            }
                                        }
                                        textelement(outros_ced)
                                        {
                                            textelement(total_outros_ced)
                                            {
                                                XmlName = 'total';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    total_outros_ced := '0';
                                                end;
                                            }
                                            textelement(h_outros_ced)
                                            {
                                                XmlName = 'h';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    h_outros_ced := '0';
                                                end;
                                            }
                                            textelement(m_outros_ced)
                                            {
                                                XmlName = 'm';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    m_outros_ced := '0';
                                                end;
                                            }
                                        }
                                        textelement(outros_ind)
                                        {
                                            textelement(total_outros_ind)
                                            {
                                                XmlName = 'total';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    Clear(vTotPessoas);
                                                    Clear(vContM);
                                                    Clear(vContH);
                                                    vDate := DMY2Date(1, 1, vAno);

                                                    for i := 1 to 12 do begin
                                                        rHistCabMovEmp.Reset;
                                                        rHistCabMovEmp.SetRange(rHistCabMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                                        rHistCabMovEmp.SetRange(rHistCabMovEmp."Data Registo", vDate, CalcDate('+1M-1D', vDate));
                                                        if rHistCabMovEmp.FindSet then begin
                                                            repeat
                                                                if (rEmpregado.Get(rHistCabMovEmp."Employee No.")) and
                                                                   (rEmpregado."Tipo Contribuinte" = rEmpregado."Tipo Contribuinte"::"Trabalhador Independente") then begin
                                                                    vTotPessoas := vTotPessoas + 1;
                                                                    if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                    if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                end;
                                                            until rHistCabMovEmp.Next = 0;
                                                        end;
                                                        vDate := CalcDate('+1M', vDate);
                                                    end;

                                                    total_outros_ind := Format(Round(vTotPessoas / 12, 1));
                                                end;
                                            }
                                            textelement(h_outros_ind)
                                            {
                                                XmlName = 'h';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    h_outros_ind := Format(Round(vContH / 12, 1));
                                                end;
                                            }
                                            textelement(m_outros_ind)
                                            {
                                                XmlName = 'm';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    m_outros_ind := Format(Round(vContM / 12, 1));
                                                end;
                                            }
                                        }
                                        textelement(outros_ocas)
                                        {
                                            textelement(total_outros_ocas)
                                            {
                                                XmlName = 'total';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    total_outros_ocas := '0';
                                                end;
                                            }
                                            textelement(h_outros_ocas)
                                            {
                                                XmlName = 'h';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    h_outros_ocas := '0';
                                                end;
                                            }
                                            textelement(m_outros_ocas)
                                            {
                                                XmlName = 'm';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    m_outros_ocas := '0';
                                                end;
                                            }
                                        }
                                        textelement(total)
                                        {
                                            textelement(total_total)
                                            {
                                                XmlName = 'total';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    total_total := Format(int_total_vinc + int_total_outros);
                                                end;
                                            }
                                            textelement(h_total)
                                            {
                                                XmlName = 'h';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    h_total := Format(int_h_vinc + int_h_outros);
                                                end;
                                            }
                                            textelement(m_total)
                                            {
                                                XmlName = 'm';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    m_total := Format(int_m_vinc + int_m_outros);
                                                end;
                                            }
                                        }
                                    }
                                    textelement(n_total_efec)
                                    {

                                        trigger OnBeforePassVariable()
                                        begin

                                            Clear(vContaDiasUteis);
                                            Clear(vContaDiasEmp);
                                            Clear(vContaHorasTotais);

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

                                            //saber os códigos
                                            rUniMedHR.Reset;
                                            rUniMedHR.SetRange(rUniMedHR."Designação Interna", rUniMedHR."Designação Interna"::Dia);
                                            if rUniMedHR.FindFirst then
                                                vDia := rUniMedHR.Code;
                                            rUniMedHR.Reset;
                                            rUniMedHR.SetRange(rUniMedHR."Designação Interna", rUniMedHR."Designação Interna"::Hora);
                                            if rUniMedHR.FindFirst then
                                                vHora := rUniMedHR.Code;


                                            rEmpregado.Reset;
                                            rEmpregado.SetRange(rEmpregado."Tipo Contribuinte", rEmpregado."Tipo Contribuinte"::"Conta de Outrem");
                                            rEmpregado.SetRange(rEmpregado.Estabelecimento, "Estabelecimentos da Empresa"."Número da Unidade Local");
                                            if rEmpregado.FindSet then begin
                                                repeat
                                                    rContratoEmpregado.Reset;
                                                    rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", rEmpregado."No.");
                                                    rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', CalcDate('+1M-1D', vDate));
                                                    rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '=%1|>=%2', 0D, CalcDate('+1M-1D', vDate));
                                                    if rContratoEmpregado.FindFirst then begin
                                                        if (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"Sem Termo") or
                                                           (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"A Termo") then begin

                                                            Faltas := 0;
                                                            qtd := 0;
                                                            HorasExtra := 0;
                                                            vContaDiasEmp := vContaDiasUteis;
                                                            DataIni := DMY2Date(1, 1, vAno);
                                                            DataFim := DMY2Date(31, 12, vAno);

                                                            if (rEmpregado."End Date" = 0D) or (rEmpregado."End Date" > DMY2Date(1, 1, vAno)) then begin
                                                                //caso o empregado entre ou saia a meio do ano
                                                                if ((rEmpregado."Employment Date" >= DMY2Date(1, 1, vAno)) and (rEmpregado."Employment Date" <= DMY2Date(31, 12, vAno)))
                                                      or
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


                                                                //tirar as ausencias
                                                                rHistAusen.Reset;
                                                                rHistAusen.SetRange(rHistAusen."Employee No.", rEmpregado."No.");
                                                                rHistAusen.SetRange(rHistAusen."From Date", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                                if rHistAusen.FindSet then begin
                                                                    repeat
                                                                        if rHistAusen."Unit of Measure Code" = vDia then qtd := rHistAusen.Quantity * 8;
                                                                        if rHistAusen."Unit of Measure Code" = vHora then qtd := rHistAusen.Quantity;
                                                                        Faltas := Faltas + qtd;
                                                                    until rHistAusen.Next = 0;
                                                                end;

                                                                //Horas extra
                                                                rHorasExtra.Reset;
                                                                rHorasExtra.SetRange(rHorasExtra."Employee No.", rEmpregado."No.");
                                                                rHorasExtra.SetRange(rHorasExtra.Data, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                                if rHorasExtra.FindSet then begin
                                                                    repeat
                                                                        HorasExtra := HorasExtra + rHorasExtra.Quantity;
                                                                    until rHorasExtra.Next = 0;
                                                                end;

                                                                vContaHorasTotais := vContaHorasTotais + (vContaDiasEmp * 8) - Round(Faltas, 1) + Round(HorasExtra, 1);
                                                            end;
                                                        end;
                                                    end;
                                                until rEmpregado.Next = 0;
                                            end;


                                            n_total_efec := Format(vContaHorasTotais);
                                        end;
                                    }
                                    textelement(organi_serv_seg)
                                    {

                                        trigger OnBeforePassVariable()
                                        begin
                                            rSegurancaeSaudeTrabalho.Reset;
                                            rSegurancaeSaudeTrabalho.SetRange(rSegurancaeSaudeTrabalho.Ano, Format(vAno));
                                            if rSegurancaeSaudeTrabalho.FindFirst then begin
                                                if rSegurancaeSaudeTrabalho."Foram Organizados Serv. Seg. T" = true then
                                                    organi_serv_seg := 'S'
                                                else
                                                    organi_serv_seg := 'N';
                                            end else
                                                Error(Text0001, vAno);
                                        end;
                                    }
                                    textelement(organi_serv_saude)
                                    {

                                        trigger OnBeforePassVariable()
                                        begin
                                            rSegurancaeSaudeTrabalho.Reset;
                                            rSegurancaeSaudeTrabalho.SetRange(rSegurancaeSaudeTrabalho.Ano, Format(vAno));
                                            if rSegurancaeSaudeTrabalho.FindFirst then begin
                                                if rSegurancaeSaudeTrabalho."Foram Organizados Serv. Sau. T" = true then
                                                    organi_serv_saude := 'S'
                                                else
                                                    organi_serv_saude := 'N';
                                            end else
                                                Error(Text0001, vAno);
                                        end;
                                    }
                                    tableelement("segurança e saúde no trabalho"; "Segurança e Saúde no Trabalho")
                                    {
                                        XmlName = 'servicos_sst';
                                        fieldelement(n_trab_afect; "Segurança e Saúde no Trabalho"."No. Trabalhadores Afectos")
                                        {
                                        }
                                        textelement(org_no_estab)
                                        {

                                            trigger OnBeforePassVariable()
                                            begin
                                                if "Segurança e Saúde no Trabalho"."Actividades SST Organizadas" =
                                                   "Segurança e Saúde no Trabalho"."Actividades SST Organizadas"::"Em Conjunto" then
                                                    org_no_estab := 'C';

                                                if "Segurança e Saúde no Trabalho"."Actividades SST Organizadas" =
                                                   "Segurança e Saúde no Trabalho"."Actividades SST Organizadas"::"Em Separado" then
                                                    org_no_estab := 'S';
                                            end;
                                        }
                                        textelement(modalidade)
                                        {
                                            tableelement("segurança no trabalho"; "Segurança e Saúde no Trabalho")
                                            {
                                                XmlName = 'seguranca';
                                                textelement(seg_serv_internos)
                                                {
                                                    XmlName = 'serv_internos';

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        if "Segurança no Trabalho"."Seg-Serviço Interno" then
                                                            seg_serv_internos := 'S'
                                                        else
                                                            seg_serv_internos := 'N';
                                                    end;
                                                }
                                                textelement(seg_serv_part)
                                                {
                                                    XmlName = 'serv_part';

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        if "Segurança no Trabalho"."Seg-Serviço Comum/Partilhado" then
                                                            seg_serv_part := 'S'
                                                        else
                                                            seg_serv_part := 'N';
                                                    end;
                                                }
                                                textelement(seg_serv_ext)
                                                {
                                                    XmlName = 'serv_ext';

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        if "Segurança no Trabalho"."Seg-Serviço Externo" then
                                                            seg_serv_ext := 'S'
                                                        else
                                                            seg_serv_ext := 'N';
                                                    end;
                                                }
                                                textelement(seg_act_empreg)
                                                {
                                                    XmlName = 'act_empreg';

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        if "Segurança no Trabalho"."Seg-Act. Exer. pelo Empregador" then
                                                            seg_act_empreg := 'S'
                                                        else
                                                            seg_act_empreg := 'N';
                                                    end;
                                                }
                                                textelement(seg_act_trab)
                                                {
                                                    XmlName = 'act_trab';

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        if "Segurança no Trabalho"."Seg-Act. Exer. pelo Trabalhado" then
                                                            seg_act_trab := 'S'
                                                        else
                                                            seg_act_trab := 'N';
                                                    end;
                                                }

                                                trigger OnPreXmlItem()
                                                begin
                                                    "Segurança no Trabalho".SetRange("Segurança no Trabalho".Ano, Format(vAno));
                                                end;
                                            }
                                            tableelement("saúde no trabalho"; "Segurança e Saúde no Trabalho")
                                            {
                                                XmlName = 'saude';
                                                textelement(sau_serv_internos)
                                                {
                                                    XmlName = 'serv_internos';

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        if "Saúde no Trabalho"."Sau-Serviço Interno" then
                                                            sau_serv_internos := 'S'
                                                        else
                                                            sau_serv_internos := 'N';
                                                    end;
                                                }
                                                textelement(sau_serv_part)
                                                {
                                                    XmlName = 'serv_part';

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        if "Saúde no Trabalho"."Sau-Serviço Comum/Partilhado" then
                                                            sau_serv_part := 'S'
                                                        else
                                                            sau_serv_part := 'N';
                                                    end;
                                                }
                                                textelement(sau_serv_ext)
                                                {
                                                    XmlName = 'serv_ext';

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        if "Saúde no Trabalho"."Sau-Serviço Externo" then
                                                            sau_serv_ext := 'S'
                                                        else
                                                            sau_serv_ext := 'N';
                                                    end;
                                                }
                                                textelement(sau_serv_saude)
                                                {
                                                    XmlName = 'serv_saude';

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        if "Saúde no Trabalho"."Sau-Ser. Nac/Reg de Saúde" then
                                                            sau_serv_saude := 'S'
                                                        else
                                                            sau_serv_saude := 'N';
                                                    end;
                                                }

                                                trigger OnPreXmlItem()
                                                begin
                                                    "Saúde no Trabalho".SetRange("Saúde no Trabalho".Ano, Format(vAno));
                                                end;
                                            }
                                        }
                                        textelement(compl)
                                        {

                                            trigger OnBeforePassVariable()
                                            begin
                                                rSegurancaeSaudeTrabalho.Reset;
                                                rSegurancaeSaudeTrabalho.SetRange(rSegurancaeSaudeTrabalho.Ano, Format(vAno));
                                                if rSegurancaeSaudeTrabalho.FindFirst then begin
                                                    if rSegurancaeSaudeTrabalho."Foram Completados os Serv." = true then
                                                        compl := 'S'
                                                    else
                                                        compl := 'N';
                                                end;
                                            end;
                                        }
                                        textelement(n_medicos)
                                        {

                                            trigger OnBeforePassVariable()
                                            begin
                                                rPessoalServicos.Reset;
                                                rPessoalServicos.SetRange(rPessoalServicos.Ano, Format(vAno));

                                                if rPessoalServicos.FindFirst then begin
                                                    rPessoalServicos.CalcFields(rPessoalServicos."Médicos do Trabalho", rPessoalServicos."Técnicos de SHT");
                                                    n_medicos := Format(rPessoalServicos."Médicos do Trabalho");
                                                end else
                                                    Error(Text0002, vAno);
                                            end;
                                        }
                                        textelement(n_enfer)
                                        {

                                            trigger OnBeforePassVariable()
                                            begin
                                                n_enfer := Format(rPessoalServicos.Enfermeiros);
                                            end;
                                        }
                                        textelement(n_tec_sup_sht)
                                        {

                                            trigger OnBeforePassVariable()
                                            begin
                                                rPessoalServicos.CalcFields(rPessoalServicos."Técnicos Superiores de SHT");
                                                n_tec_sup_sht := Format(rPessoalServicos."Técnicos Superiores de SHT");
                                            end;
                                        }
                                        textelement(n_tec_sht)
                                        {

                                            trigger OnBeforePassVariable()
                                            begin
                                                rPessoalServicos.CalcFields(rPessoalServicos."Médicos do Trabalho", rPessoalServicos."Técnicos de SHT");
                                                n_tec_sht := Format(rPessoalServicos."Técnicos de SHT");
                                            end;
                                        }
                                        textelement(outro_pess)
                                        {

                                            trigger OnBeforePassVariable()
                                            begin
                                                outro_pess := Format(rPessoalServicos."Outro Pessoal");
                                            end;
                                        }
                                        textelement(medicos)
                                        {
                                            tableelement("pessoal dos serviços int"; "Pessoal dos Serviços Int")
                                            {
                                                XmlName = 'medico';
                                                fieldelement(nome; "Pessoal dos Serviços Int".Name)
                                                {
                                                }
                                                fieldelement(n_cedula; "Pessoal dos Serviços Int"."No. da Cédula Profissional")
                                                {
                                                }
                                                textelement(n_horas_mes)
                                                {

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        n_horas_mes := Format("Pessoal dos Serviços Int"."No. de Horas Mensais Afectação", 0, '<Integer><Decimals,3>');
                                                    end;
                                                }

                                                trigger OnPreXmlItem()
                                                begin
                                                    "Pessoal dos Serviços Int".SetRange("Pessoal dos Serviços Int".Ano, Format(vAno));
                                                    "Pessoal dos Serviços Int".SetRange("Pessoal dos Serviços Int"."Tipo de Técnico",
                                                            "Pessoal dos Serviços Int"."Tipo de Técnico"::"Médico do Trabalho");
                                                end;
                                            }
                                        }
                                        textelement(tec_shts)
                                        {
                                            tableelement("pessoal dos serviços int2"; "Pessoal dos Serviços Int")
                                            {
                                                XmlName = 'tec_sht';
                                                fieldelement(nome; "Pessoal dos Serviços Int2".Name)
                                                {
                                                }
                                                fieldelement(cap; "Pessoal dos Serviços Int2"."No. Certificado Aptidão Prof.")
                                                {
                                                }

                                                trigger OnPreXmlItem()
                                                begin
                                                    "Pessoal dos Serviços Int2".SetRange("Pessoal dos Serviços Int2".Ano, Format(vAno));

                                                    "Pessoal dos Serviços Int2".SetFilter("Pessoal dos Serviços Int2"."Tipo de Técnico", '%1|%2',
                                                           "Pessoal dos Serviços Int"."Tipo de Técnico"::"Técnico de SHT",
                                                          "Pessoal dos Serviços Int"."Tipo de Técnico"::"Técnico Sup. de SHT");
                                                end;
                                            }
                                        }
                                        tableelement("pessoal dos serviços"; "Pessoal dos Serviços")
                                        {
                                            XmlName = 'resp_segu';
                                            fieldelement(nif; "Pessoal dos Serviços"."Seg. - NIF")
                                            {
                                            }
                                            fieldelement(nome; "Pessoal dos Serviços"."Nome Dir/Resp dos Serviços Seg")
                                            {
                                            }

                                            trigger OnPreXmlItem()
                                            begin
                                                "Pessoal dos Serviços".SetRange("Pessoal dos Serviços".Ano, Format(vAno));
                                            end;
                                        }
                                        tableelement("pessoal dos serviços2"; "Pessoal dos Serviços")
                                        {
                                            XmlName = 'resp_saud';
                                            fieldelement(nif; "Pessoal dos Serviços2"."Saúde - NIF")
                                            {
                                            }
                                            fieldelement(nome; "Pessoal dos Serviços2"."Nome Dir/Resp dos Serviços Saú")
                                            {
                                            }

                                            trigger OnPreXmlItem()
                                            begin
                                                "Pessoal dos Serviços2".SetRange("Pessoal dos Serviços2".Ano, Format(vAno));
                                            end;
                                        }
                                        tableelement("pessoal dos serviços3"; "Pessoal dos Serviços")
                                        {
                                            XmlName = 'empregador';
                                            fieldelement(nome; "Pessoal dos Serviços3"."Employer Name")
                                            {
                                            }
                                            fieldelement(n_autorizacao; "Pessoal dos Serviços3"."Emp. - No. Autorização")
                                            {
                                            }

                                            trigger OnPreXmlItem()
                                            begin
                                                "Pessoal dos Serviços3".SetRange("Pessoal dos Serviços3".Ano, Format(vAno));
                                            end;
                                        }
                                        tableelement("pessoal dos serviços4"; "Pessoal dos Serviços")
                                        {
                                            XmlName = 'trab_designado';
                                            fieldelement(nome; "Pessoal dos Serviços4"."Nome Trabalhador Designado")
                                            {
                                            }
                                            fieldelement(n_autorizacao; "Pessoal dos Serviços4"."Trab. - No. Autorização")
                                            {
                                            }

                                            trigger OnPreXmlItem()
                                            begin
                                                "Pessoal dos Serviços4".SetRange("Pessoal dos Serviços4".Ano, Format(vAno));
                                            end;
                                        }
                                        textelement(nome_repr)
                                        {

                                            trigger OnBeforePassVariable()
                                            begin
                                                rPessoalServicos.Reset;
                                                rPessoalServicos.SetRange(rPessoalServicos.Ano, Format(vAno));
                                                if rPessoalServicos.FindFirst then
                                                    nome_repr := rPessoalServicos."Nome Representante do Emp.";
                                            end;
                                        }
                                        textelement(servicos_ext)
                                        {
                                            textelement(servicos_seg)
                                            {
                                                tableelement("pessoal dos serviços ext"; "Pessoal dos Serviços Ext")
                                                {
                                                    XmlName = 'servico_seg';
                                                    fieldelement(nif; "Pessoal dos Serviços Ext".NIF)
                                                    {
                                                    }
                                                    fieldelement(denominacao; "Pessoal dos Serviços Ext"."Denominação Serv. Externo")
                                                    {
                                                    }
                                                    fieldelement(tipo; "Pessoal dos Serviços Ext"."Tipo de Empresa")
                                                    {
                                                        textattribute(tbl_tipo_servico_seg)
                                                        {
                                                            XmlName = 'tbl';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                tbl_tipo_servico_seg := 'RU_TEP';
                                                            end;
                                                        }
                                                    }

                                                    trigger OnPreXmlItem()
                                                    begin
                                                        "Pessoal dos Serviços Ext".SetRange("Pessoal dos Serviços Ext".Ano, Format(vAno));
                                                        "Pessoal dos Serviços Ext".SetRange("Pessoal dos Serviços Ext"."Tipo Serviço", "Pessoal dos Serviços Ext"."Tipo Serviço"::"Segurança"
                                                        );
                                                    end;
                                                }
                                            }
                                            textelement(servicos_saude)
                                            {
                                                tableelement("pessoal dos serviços ext2"; "Pessoal dos Serviços Ext")
                                                {
                                                    XmlName = 'servico_saude';
                                                    fieldelement(nif; "Pessoal dos Serviços Ext2".NIF)
                                                    {
                                                    }
                                                    fieldelement(denominacao; "Pessoal dos Serviços Ext2"."Denominação Serv. Externo")
                                                    {
                                                    }
                                                    fieldelement(tipo; "Pessoal dos Serviços Ext2"."Tipo de Empresa")
                                                    {
                                                        textattribute(tbl_tipo_servivo_saude)
                                                        {
                                                            XmlName = 'tbl';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                tbl_tipo_servivo_saude := 'RU_TEP';
                                                            end;
                                                        }
                                                    }

                                                    trigger OnPreXmlItem()
                                                    begin
                                                        "Pessoal dos Serviços Ext2".SetRange("Pessoal dos Serviços Ext2".Ano, Format(vAno));
                                                        "Pessoal dos Serviços Ext2".SetRange("Pessoal dos Serviços Ext2"."Tipo Serviço",
                                                                                    "Pessoal dos Serviços Ext2"."Tipo Serviço"::"Saúde");
                                                    end;
                                                }
                                            }
                                        }
                                        textelement(org_prog_prev)
                                        {

                                            trigger OnBeforePassVariable()
                                            begin
                                                rActividadesServicos.Reset;
                                                rActividadesServicos.SetRange(rActividadesServicos."Data Actividade", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                rActividadesServicos.SetRange(rActividadesServicos.Actividade,
                                                   rActividadesServicos.Actividade::"Programa de Prevenção de Riscos Profissionais");
                                                if rActividadesServicos.FindSet then
                                                    org_prog_prev := 'S'
                                                else
                                                    org_prog_prev := 'N';
                                            end;
                                        }
                                        textelement(org_prom_saude)
                                        {

                                            trigger OnBeforePassVariable()
                                            begin
                                                rActividadesServicos.Reset;
                                                rActividadesServicos.SetRange(rActividadesServicos."Data Actividade", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                rActividadesServicos.SetRange(rActividadesServicos.Actividade,
                                                   rActividadesServicos.Actividade::"Programa de Promoção da Saúde");
                                                if rActividadesServicos.FindSet then
                                                    org_prom_saude := 'S'
                                                else
                                                    org_prom_saude := 'N';
                                            end;
                                        }
                                        textelement(org_vigil_saude)
                                        {

                                            trigger OnBeforePassVariable()
                                            begin
                                                rActividadesServicos.Reset;
                                                rActividadesServicos.SetRange(rActividadesServicos."Data Actividade", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                rActividadesServicos.SetRange(rActividadesServicos.Actividade,
                                                   rActividadesServicos.Actividade::"Programa de Vigilância da Saúde");
                                                if rActividadesServicos.FindSet then
                                                    org_vigil_saude := 'S'
                                                else
                                                    org_vigil_saude := 'N';
                                            end;
                                        }
                                        textelement(org_audit)
                                        {

                                            trigger OnBeforePassVariable()
                                            begin
                                                rActividadesServicos.Reset;
                                                rActividadesServicos.SetRange(rActividadesServicos."Data Actividade", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                rActividadesServicos.SetRange(rActividadesServicos.Actividade,
                                                   rActividadesServicos.Actividade::"Realização de Auditoria");
                                                if rActividadesServicos.FindSet then
                                                    org_audit := 'S'
                                                else
                                                    org_audit := 'N';
                                            end;
                                        }
                                        textelement(org_insp)
                                        {

                                            trigger OnBeforePassVariable()
                                            begin
                                                rActividadesServicos.Reset;
                                                rActividadesServicos.SetRange(rActividadesServicos."Data Actividade", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                rActividadesServicos.SetRange(rActividadesServicos.Actividade,
                                                   rActividadesServicos.Actividade::"Realização de Inspecção");
                                                if rActividadesServicos.FindSet then
                                                    org_insp := 'S'
                                                else
                                                    org_insp := 'N';
                                            end;
                                        }
                                        textelement(accoes_inf)
                                        {
                                            textattribute(realizadas_accoes_inf)
                                            {
                                                XmlName = 'realizadas';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    rAccoesInfConFor.Reset;
                                                    rAccoesInfConFor.SetRange(rAccoesInfConFor."Data da Acção", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                    rAccoesInfConFor.SetRange(rAccoesInfConFor."Tipo de Acção", rAccoesInfConFor."Tipo de Acção"::"Informação");
                                                    if rAccoesInfConFor.FindFirst then
                                                        realizadas_accoes_inf := 'S'
                                                    else
                                                        realizadas_accoes_inf := 'N';
                                                end;
                                            }
                                            tableelement("acções de inf. cons. for"; "Acções de Inf. Cons. For")
                                            {
                                                XmlName = 'accao_inf';
                                                SourceTableView = WHERE("Tipo de Acção" = CONST("Informação"));
                                                fieldelement(situacao; "Acções de Inf. Cons. For".Code)
                                                {
                                                    textattribute(tbl_situacao_accao_inf)
                                                    {
                                                        XmlName = 'tbl';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            tbl_situacao_accao_inf := 'SST_ACC_INFO';
                                                        end;
                                                    }
                                                }
                                                fieldelement(n_accoes; "Acções de Inf. Cons. For"."No. Acções Realizadas")
                                                {
                                                }
                                                textelement(n_destinat)
                                                {

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        n_destinat := Format("Acções de Inf. Cons. For"."No. Participantes Homens" +
                                                                      "Acções de Inf. Cons. For"."No. Participantes Mulheres");
                                                    end;
                                                }

                                                trigger OnPreXmlItem()
                                                begin
                                                    "Acções de Inf. Cons. For".SetRange("Acções de Inf. Cons. For"."Data da Acção"
                                                                                        , DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                end;
                                            }
                                        }
                                        textelement(accoes_consult)
                                        {
                                            textattribute(realizadas_accoes_consult)
                                            {
                                                XmlName = 'realizadas';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    rAccoesInfConFor.Reset;
                                                    rAccoesInfConFor.SetRange(rAccoesInfConFor."Data da Acção", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                    rAccoesInfConFor.SetRange(rAccoesInfConFor."Tipo de Acção", rAccoesInfConFor."Tipo de Acção"::Consulta);
                                                    if rAccoesInfConFor.FindFirst then
                                                        realizadas_accoes_consult := 'S'
                                                    else
                                                        realizadas_accoes_consult := 'N';
                                                end;
                                            }
                                            tableelement("acções de inf. cons. for2"; "Acções de Inf. Cons. For")
                                            {
                                                XmlName = 'accao_consult';
                                                SourceTableView = WHERE("Tipo de Acção" = CONST(Consulta));
                                                fieldelement(razao; "Acções de Inf. Cons. For2".Code)
                                                {
                                                    textattribute(tbl_razao)
                                                    {
                                                        XmlName = 'tbl';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            tbl_razao := 'SST_ACC_CONS';
                                                        end;
                                                    }
                                                }
                                                fieldelement(n_accoes; "Acções de Inf. Cons. For2"."No. Acções Realizadas")
                                                {
                                                }
                                                textelement(n_participantes)
                                                {

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        n_participantes := Format("Acções de Inf. Cons. For2"."No. Participantes Homens" +
                                                                      "Acções de Inf. Cons. For2"."No. Participantes Mulheres");
                                                    end;
                                                }

                                                trigger OnPreXmlItem()
                                                begin
                                                    "Acções de Inf. Cons. For2".SetRange("Acções de Inf. Cons. For2"."Data da Acção"
                                                                                        , DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                end;
                                            }
                                        }
                                        textelement(accoes_form)
                                        {
                                            textattribute(realizadas_accoes_form)
                                            {
                                                XmlName = 'realizadas';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    rAccoesInfConFor.Reset;
                                                    rAccoesInfConFor.SetRange(rAccoesInfConFor."Data da Acção", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                    rAccoesInfConFor.SetRange(rAccoesInfConFor."Tipo de Acção", rAccoesInfConFor."Tipo de Acção"::"Formação");
                                                    if rAccoesInfConFor.FindFirst then
                                                        realizadas_accoes_form := 'S'
                                                    else
                                                        realizadas_accoes_form := 'N';
                                                end;
                                            }
                                            tableelement("acções de inf. cons. for3"; "Acções de Inf. Cons. For")
                                            {
                                                XmlName = 'accao_form';
                                                SourceTableView = WHERE("Tipo de Acção" = CONST("Formação"));
                                                fieldelement(tema; "Acções de Inf. Cons. For3"."Code")
                                                {
                                                    textattribute(tbl_tema)
                                                    {
                                                        XmlName = 'tbl';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            tbl_tema := 'SST_ACC_FORM';
                                                        end;
                                                    }
                                                }
                                                fieldelement(n_accoes; "Acções de Inf. Cons. For3"."No. Acções Realizadas")
                                                {
                                                }
                                                textelement(n_particip)
                                                {
                                                    textelement(h_n_particip)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_n_particip := Format("Acções de Inf. Cons. For3"."No. Participantes Homens");
                                                        end;
                                                    }
                                                    textelement(m_n_particip)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_n_particip := Format("Acções de Inf. Cons. For3"."No. Participantes Mulheres");
                                                        end;
                                                    }
                                                }

                                                trigger OnPreXmlItem()
                                                begin
                                                    "Acções de Inf. Cons. For3".SetRange("Acções de Inf. Cons. For3"."Data da Acção"
                                                                                        , DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                end;
                                            }
                                        }
                                        textelement(riscos_fisicos)
                                        {
                                            textattribute(identificados_riscos_fisicos)
                                            {
                                                XmlName = 'identificados';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    rFactoresdeRisco.Reset;
                                                    rFactoresdeRisco.SetRange(rFactoresdeRisco.Data, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                    rFactoresdeRisco.SetRange(rFactoresdeRisco."Tipo de Risco", rFactoresdeRisco."Tipo de Risco"::"Físico");
                                                    if rFactoresdeRisco.FindFirst then
                                                        identificados_riscos_fisicos := 'S'
                                                    else
                                                        identificados_riscos_fisicos := 'N';
                                                end;
                                            }
                                            tableelement("factores de risco"; "Factores de Risco")
                                            {
                                                XmlName = 'risco_fisico';
                                                SourceTableView = WHERE("Tipo de Risco" = CONST("Físico"));
                                                textelement(n_trab_expo)
                                                {
                                                    fieldelement(h; "Factores de Risco"."No. Trab. Expostos H")
                                                    {
                                                    }
                                                    fieldelement(m; "Factores de Risco"."No. Trab. Expostos M")
                                                    {
                                                    }
                                                }
                                                fieldelement(n_aval; "Factores de Risco"."No. Avaliações Efectuadas")
                                                {
                                                }
                                                fieldelement(agente; "Factores de Risco".Agente)
                                                {
                                                    textattribute(tbl_agente_risco_fisico)
                                                    {
                                                        XmlName = 'tbl';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            tbl_agente_risco_fisico := 'SST_FACT_RISCFIS';
                                                        end;
                                                    }
                                                }
                                                tableelement("medidas adoptadas"; "Medidas Adoptadas")
                                                {
                                                    XmlName = 'medidas_prev';
                                                    fieldelement(medida_prev; "Medidas Adoptadas"."Medida de Prevenção Adoptada")
                                                    {
                                                        textattribute(tbl_medida_prev_risco_fisico)
                                                        {
                                                            XmlName = 'tbl';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                tbl_medida_prev_risco_fisico := 'FRF_COD_AGENTE';
                                                            end;
                                                        }
                                                    }

                                                    trigger OnPreXmlItem()
                                                    begin
                                                        "Medidas Adoptadas".SetRange("Medidas Adoptadas"."Entry No.", "Factores de Risco"."Entry No.");
                                                    end;
                                                }

                                                trigger OnPreXmlItem()
                                                begin
                                                    "Factores de Risco".SetRange("Factores de Risco".Data, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                end;
                                            }
                                        }
                                        textelement(riscos_quim)
                                        {
                                            textattribute(identificados_riscos_quim)
                                            {
                                                XmlName = 'identificados';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    rFactoresdeRisco.Reset;
                                                    rFactoresdeRisco.SetRange(rFactoresdeRisco.Data, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                    rFactoresdeRisco.SetRange(rFactoresdeRisco."Tipo de Risco", rFactoresdeRisco."Tipo de Risco"::"Químico");
                                                    if rFactoresdeRisco.FindFirst then
                                                        identificados_riscos_quim := 'S'
                                                    else
                                                        identificados_riscos_quim := 'N';
                                                end;
                                            }
                                            tableelement("factores de risco2"; "Factores de Risco")
                                            {
                                                XmlName = 'risco_quim';
                                                SourceTableView = WHERE("Tipo de Risco" = CONST("Químico"));
                                                textelement("<n_trab_expo2>")
                                                {
                                                    XmlName = 'n_trab_expo';
                                                    fieldelement(h; "Factores de Risco2"."No. Trab. Expostos H")
                                                    {
                                                    }
                                                    fieldelement(m; "Factores de Risco2"."No. Trab. Expostos M")
                                                    {
                                                    }
                                                }
                                                fieldelement(n_aval; "Factores de Risco2"."No. Avaliações Efectuadas")
                                                {
                                                }
                                                fieldelement(einecs; "Factores de Risco2"."No. Ordem - Código")
                                                {
                                                    textattribute(tbl_einecs)
                                                    {
                                                        XmlName = 'tbl';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            tbl_einecs := 'SST_EINECS';
                                                        end;
                                                    }
                                                }
                                                fieldelement(mencao; "Factores de Risco2"."Menção ou Frase de Risco")
                                                {
                                                    textattribute(tbl_mencao)
                                                    {
                                                        XmlName = 'tbl';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            tbl_mencao := 'FRQ_MF_RISCO';
                                                        end;
                                                    }
                                                }
                                                tableelement("medidas adoptadas2"; "Medidas Adoptadas")
                                                {
                                                    XmlName = 'medidas_prev';
                                                    fieldelement(medida_prev; "Medidas Adoptadas2"."Medida de Prevenção Adoptada")
                                                    {
                                                        textattribute(tbl_medidas_prev_riscos_quim)
                                                        {
                                                            XmlName = 'tbl';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                tbl_medidas_prev_riscos_quim := 'FRQ_CM_PREV_ADOPT';
                                                            end;
                                                        }
                                                    }

                                                    trigger OnPreXmlItem()
                                                    begin
                                                        "Medidas Adoptadas2".SetRange("Medidas Adoptadas2"."Entry No.", "Factores de Risco2"."Entry No.");
                                                    end;
                                                }

                                                trigger OnPreXmlItem()
                                                begin
                                                    "Factores de Risco2".SetRange("Factores de Risco2".Data, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                end;
                                            }
                                        }
                                        textelement(riscos_bio)
                                        {
                                            textattribute(identificados_riscos_bio)
                                            {
                                                XmlName = 'identificados';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    rFactoresdeRisco.Reset;
                                                    rFactoresdeRisco.SetRange(rFactoresdeRisco.Data, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                    rFactoresdeRisco.SetRange(rFactoresdeRisco."Tipo de Risco", rFactoresdeRisco."Tipo de Risco"::"Biológico");
                                                    if rFactoresdeRisco.FindFirst then
                                                        identificados_riscos_bio := 'S'
                                                    else
                                                        identificados_riscos_bio := 'N';
                                                end;
                                            }
                                            tableelement("factores de risco3"; "Factores de Risco")
                                            {
                                                XmlName = 'risco_bio';
                                                SourceTableView = WHERE("Tipo de Risco" = CONST("Biológico"));
                                                textelement("<n_trab_expo3>")
                                                {
                                                    XmlName = 'n_trab_expo';
                                                    fieldelement(h; "Factores de Risco3"."No. Trab. Expostos H")
                                                    {
                                                    }
                                                    fieldelement(m; "Factores de Risco3"."No. Trab. Expostos M")
                                                    {
                                                    }
                                                }
                                                fieldelement(n_aval; "Factores de Risco3"."No. Avaliações Efectuadas")
                                                {
                                                }
                                                fieldelement(agente; "Factores de Risco3".Agente)
                                                {
                                                    textattribute(tbl_agente_riscos_bio)
                                                    {
                                                        XmlName = 'tbl';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            tbl_agente_riscos_bio := 'FRB_IC_AGENTE';
                                                        end;
                                                    }
                                                }
                                                tableelement("medidas adoptadas3"; "Medidas Adoptadas")
                                                {
                                                    XmlName = 'medidas_prev';
                                                    fieldelement(medida_prev; "Medidas Adoptadas3"."Medida de Prevenção Adoptada")
                                                    {
                                                        textattribute(tbl_medida_prev_riscos_bio)
                                                        {
                                                            XmlName = 'tbl';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                tbl_medida_prev_riscos_bio := 'FRB_CM_PREV_ADOPT';
                                                            end;
                                                        }
                                                    }

                                                    trigger OnPreXmlItem()
                                                    begin
                                                        "Medidas Adoptadas3".SetRange("Medidas Adoptadas3"."Entry No.", "Factores de Risco3"."Entry No.");
                                                    end;
                                                }

                                                trigger OnPreXmlItem()
                                                begin
                                                    "Factores de Risco3".SetRange("Factores de Risco3".Data, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                end;
                                            }
                                        }
                                        textelement(riscos_muscoe)
                                        {
                                            textattribute(identificados_riscos_muscoe)
                                            {
                                                XmlName = 'identificados';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    rFactoresdeRisco.Reset;
                                                    rFactoresdeRisco.SetRange(rFactoresdeRisco.Data, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                    rFactoresdeRisco.SetRange(rFactoresdeRisco."Tipo de Risco", rFactoresdeRisco."Tipo de Risco"::"Músculo-esquelético");
                                                    if rFactoresdeRisco.FindFirst then
                                                        identificados_riscos_muscoe := 'S'
                                                    else
                                                        identificados_riscos_muscoe := 'N';
                                                end;
                                            }
                                            tableelement("factores de risco4"; "Factores de Risco")
                                            {
                                                XmlName = 'risco_muscoe';
                                                SourceTableView = WHERE("Tipo de Risco" = CONST("Músculo-esquelético"));
                                                textelement("<n_trab_expo4>")
                                                {
                                                    XmlName = 'n_trab_expo';
                                                    fieldelement(h; "Factores de Risco4"."No. Trab. Expostos H")
                                                    {
                                                    }
                                                    fieldelement(m; "Factores de Risco4"."No. Trab. Expostos M")
                                                    {
                                                    }
                                                }
                                                fieldelement(n_aval; "Factores de Risco4"."No. Avaliações Efectuadas")
                                                {
                                                }
                                                fieldelement(agente; "Factores de Risco4".Agente)
                                                {
                                                    textattribute(tbl_agente_riscos_muscoe)
                                                    {
                                                        XmlName = 'tbl';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            tbl_agente_riscos_muscoe := 'FRRA_COD_AGENTE';
                                                        end;
                                                    }
                                                }
                                                tableelement("medidas adoptadas4"; "Medidas Adoptadas")
                                                {
                                                    XmlName = 'medidas_prev';
                                                    fieldelement(medida_prev; "Medidas Adoptadas4"."Medida de Prevenção Adoptada")
                                                    {
                                                        textattribute(tbl_medida_prev_riscos_muscoe)
                                                        {
                                                            XmlName = 'tbl';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                tbl_medida_prev_riscos_muscoe := 'FRRA_CM_PREV_ADOPT';
                                                            end;
                                                        }
                                                    }

                                                    trigger OnPreXmlItem()
                                                    begin
                                                        "Medidas Adoptadas4".SetRange("Medidas Adoptadas4"."Entry No.", "Factores de Risco4"."Entry No.");
                                                    end;
                                                }

                                                trigger OnPreXmlItem()
                                                begin
                                                    "Factores de Risco4".SetRange("Factores de Risco4".Data, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                end;
                                            }
                                        }
                                        textelement(riscos_psico)
                                        {
                                            textattribute(identificados_riscos_psico)
                                            {
                                                XmlName = 'identificados';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    rFactoresdeRisco.Reset;
                                                    rFactoresdeRisco.SetRange(rFactoresdeRisco.Data, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                    rFactoresdeRisco.SetRange(rFactoresdeRisco."Tipo de Risco", rFactoresdeRisco."Tipo de Risco"::Psicossociais);
                                                    if rFactoresdeRisco.FindFirst then
                                                        identificados_riscos_psico := 'S'
                                                    else
                                                        identificados_riscos_psico := 'N';
                                                end;
                                            }
                                            tableelement("factores de risco5"; "Factores de Risco")
                                            {
                                                XmlName = 'risco_psico';
                                                SourceTableView = WHERE("Tipo de Risco" = CONST(Psicossociais));
                                                textelement("<n_trab_expo5>")
                                                {
                                                    XmlName = 'n_trab_expo';
                                                    fieldelement(h; "Factores de Risco5"."No. Trab. Expostos H")
                                                    {
                                                    }
                                                    fieldelement(m; "Factores de Risco5"."No. Trab. Expostos M")
                                                    {
                                                    }
                                                }
                                                fieldelement(n_aval; "Factores de Risco5"."No. Avaliações Efectuadas")
                                                {
                                                }
                                                fieldelement(agente; "Factores de Risco5".Agente)
                                                {
                                                    textattribute(tbl_agente_riscos_psico)
                                                    {
                                                        XmlName = 'tbl';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            tbl_agente_riscos_psico := 'FRPO_COD_AGENTE';
                                                        end;
                                                    }
                                                }
                                                tableelement("medidas adoptadas5"; "Medidas Adoptadas")
                                                {
                                                    XmlName = 'medidas_prev';
                                                    fieldelement(medida_prev; "Medidas Adoptadas5"."Medida de Prevenção Adoptada")
                                                    {
                                                        textattribute(tbl_medida_prev_riscos_psico)
                                                        {
                                                            XmlName = 'tbl';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                tbl_medida_prev_riscos_psico := 'FRPO_CM_PREV_ADOPT';
                                                            end;
                                                        }
                                                    }

                                                    trigger OnPreXmlItem()
                                                    begin
                                                        "Medidas Adoptadas5".SetRange("Medidas Adoptadas5"."Entry No.", "Factores de Risco5"."Entry No.");
                                                    end;
                                                }

                                                trigger OnPreXmlItem()
                                                begin
                                                    "Factores de Risco5".SetRange("Factores de Risco5".Data, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                end;
                                            }
                                        }
                                        textelement(riscos_sst)
                                        {
                                            textattribute(identificados_riscos_sst)
                                            {
                                                XmlName = 'identificados';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    rFactoresdeRisco.Reset;
                                                    rFactoresdeRisco.SetRange(rFactoresdeRisco.Data, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                    rFactoresdeRisco.SetRange(rFactoresdeRisco."Tipo de Risco", rFactoresdeRisco."Tipo de Risco"::Outros);
                                                    if rFactoresdeRisco.FindFirst then
                                                        identificados_riscos_sst := 'S'
                                                    else
                                                        identificados_riscos_sst := 'N';
                                                end;
                                            }
                                            tableelement("factores de risco6"; "Factores de Risco")
                                            {
                                                XmlName = 'risco_sst';
                                                SourceTableView = WHERE("Tipo de Risco" = CONST(Outros));
                                                textelement("<n_trab_expo6>")
                                                {
                                                    XmlName = 'n_trab_expo';
                                                    fieldelement(h; "Factores de Risco6"."No. Trab. Expostos H")
                                                    {
                                                    }
                                                    fieldelement(m; "Factores de Risco6"."No. Trab. Expostos M")
                                                    {
                                                    }
                                                }
                                                fieldelement(n_aval; "Factores de Risco6"."No. Avaliações Efectuadas")
                                                {
                                                }
                                                fieldelement(agente; "Factores de Risco6".Agente)
                                                {
                                                    textattribute(tbl_agente_riscos_sst)
                                                    {
                                                        XmlName = 'tbl';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            tbl_agente_riscos_sst := 'OFRSS_COD_AGENTE';
                                                        end;
                                                    }
                                                }
                                                tableelement("medidas adoptadas6"; "Medidas Adoptadas")
                                                {
                                                    XmlName = 'medidas_prev';
                                                    fieldelement(medida_prev; "Medidas Adoptadas6"."Medida de Prevenção Adoptada")
                                                    {
                                                        textattribute(tbl_medida_prev_riscos_sst)
                                                        {
                                                            XmlName = 'tbl';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                tbl_medida_prev_riscos_sst := 'OFRSS_CM_PREV_ADOPT';
                                                            end;
                                                        }
                                                    }

                                                    trigger OnPreXmlItem()
                                                    begin
                                                        "Medidas Adoptadas6".SetRange("Medidas Adoptadas6"."Entry No.", "Factores de Risco6"."Entry No.");
                                                    end;
                                                }

                                                trigger OnPreXmlItem()
                                                begin
                                                    "Factores de Risco6".SetRange("Factores de Risco6".Data, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                end;
                                            }
                                        }
                                        textelement(exames)
                                        {
                                            textattribute(realizados_exames)
                                            {
                                                XmlName = 'realizados';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    flag := false;
                                                    rLinhasAccoesMedicas.Reset;
                                                    rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                    rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                    if rLinhasAccoesMedicas.FindSet then begin
                                                        repeat
                                                            if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) then begin
                                                                if (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Admissão") or
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Periódico") or
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") then
                                                                    flag := true;
                                                            end;
                                                        until (rLinhasAccoesMedicas.Next = 0) or (flag = true);
                                                    end;
                                                    if flag = true then
                                                        realizados_exames := 'S'
                                                    else
                                                        realizados_exames := 'N';
                                                end;
                                            }
                                            textelement(total_exames)
                                            {
                                                XmlName = 'total';
                                                textelement(total_exames2)
                                                {
                                                    XmlName = 'total';
                                                    textelement(h_total_exames2)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_total_exames2 := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_total_exames2)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_total_exames2 := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   ((rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Admissão") or
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Periódico") or
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional")) then begin
                                                                    if rEmpregado.Get(rLinhasAccoesMedicas."Employee No.") then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(inf_18_exames)
                                                {
                                                    XmlName = 'inf_18';
                                                    textelement(h_inf_18_exames)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_inf_18_exames := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_inf_18_exames)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_inf_18_exames := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   ((rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Admissão") or
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Periódico") or
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional")) then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') < 18) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_18a19_exames)
                                                {
                                                    XmlName = 'de_18a19';
                                                    textelement(h_de_18a19_exames)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_18a19_exames := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_18a19_exames)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_18a19_exames := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   ((rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Admissão") or
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Periódico") or
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional")) then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 18) or
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 19)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_20a49_exames)
                                                {
                                                    XmlName = 'de_20a49';
                                                    textelement(h_de_20a49_exames)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_20a49_exames := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_20a49_exames)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_20a49_exames := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   ((rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Admissão") or
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Periódico") or
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional")) then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 20) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 49)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_50amais_exames)
                                                {
                                                    XmlName = 'de_50amais';
                                                    textelement(h_de_50amais_exames)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_50amais_exames := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_50amais_exames)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_50amais_exames := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   ((rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Admissão") or
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Periódico") or
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional")) then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 50) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                            }
                                            textelement(total_exam_adm)
                                            {
                                                XmlName = 'total_exam_adm';
                                                textelement(total_exam_adm2)
                                                {
                                                    XmlName = 'total';
                                                    textelement(h_total_exam_adm2)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_total_exam_adm2 := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_total_exam_adm2)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_total_exam_adm2 := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Admissão") then begin
                                                                    if rEmpregado.Get(rLinhasAccoesMedicas."Employee No.") then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(inf_18_exam_adm)
                                                {
                                                    XmlName = 'inf_18';
                                                    textelement(h_inf_18_exam_adm)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_inf_18_exam_adm := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_inf_18_exam_adm)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_inf_18_exam_adm := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Admissão") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') < 18) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_18a19_exam_adm)
                                                {
                                                    XmlName = 'de_18a19';
                                                    textelement(h_de_18a19_exam_adm)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_18a19_exam_adm := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_18a19_exam_adm)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_18a19_exam_adm := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Admissão") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 18) or
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 19)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_20a49_exam_adm)
                                                {
                                                    XmlName = 'de_20a49';
                                                    textelement(h_de_20a49_exam_adm)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_20a49_exam_adm := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_20a49_exam_adm)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_20a49_exam_adm := Format(vContH);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Admissão") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 20) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 49)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_50amais_exam_adm)
                                                {
                                                    XmlName = 'de_50amais';
                                                    textelement(h_de_50amais_exam_adm)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_50amais_exam_adm := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_50amais_exam_adm)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_50amais_exam_adm := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Admissão") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 50) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                            }
                                            textelement(total_exam_peri)
                                            {
                                                XmlName = 'total_exam_peri';
                                                textelement(total_exam_peri2)
                                                {
                                                    XmlName = 'total';
                                                    textelement(h_total_exam_peri2)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_total_exam_peri2 := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_total_exam_peri2)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_total_exam_peri2 := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Periódico") then begin
                                                                    if rEmpregado.Get(rLinhasAccoesMedicas."Employee No.") then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(inf_18_exam_peri)
                                                {
                                                    XmlName = 'inf_18';
                                                    textelement(h_inf_18_exam_peri)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_inf_18_exam_peri := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_inf_18_exam_peri)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_inf_18_exam_peri := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Periódico") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') < 18) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_18a19_exam_peri)
                                                {
                                                    XmlName = 'de_18a19';
                                                    textelement(h_de_18a19_exam_peri)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_18a19_exam_peri := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_18a19_exam_peri)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_18a19_exam_peri := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Periódico") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 18) or
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 19)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_20a49_exam_peri)
                                                {
                                                    XmlName = 'de_20a49';
                                                    textelement(h_de_20a49_exam_peri)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_20a49_exam_peri := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_20a49_exam_peri)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_20a49_exam_peri := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Periódico") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 20) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 49)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_50amais_exam_peri)
                                                {
                                                    XmlName = 'de_50amais';
                                                    textelement(h_de_50amais_exam_peri)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_50amais_exam_peri := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_50amais_exam_peri)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_50amais_exam_peri := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Periódico") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 50) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                            }
                                            textelement(total_exam_ocas)
                                            {
                                                XmlName = 'total_exam_ocas';
                                                textelement(total_exam_ocas2)
                                                {
                                                    XmlName = 'total';
                                                    textelement(h_total_exam_ocas2)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_total_exam_ocas2 := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_total_exam_ocas2)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_total_exam_ocas2 := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") then begin
                                                                    if rEmpregado.Get(rLinhasAccoesMedicas."Employee No.") then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(inf_18_exam_ocas)
                                                {
                                                    XmlName = 'inf_18';
                                                    textelement(h_inf_18_exam_ocas)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_inf_18_exam_ocas := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_inf_18_exam_ocas)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_inf_18_exam_ocas := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') < 18) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_18a19_exam_ocas)
                                                {
                                                    XmlName = 'de_18a19';
                                                    textelement(h_de_18a19_exam_ocas)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_18a19_exam_ocas := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_18a19_exam_ocas)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_18a19_exam_ocas := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 18) or
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 19)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_20a49_exam_ocas)
                                                {
                                                    XmlName = 'de_20a49';
                                                    textelement(h_de_20a49_exam_ocas)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_20a49_exam_ocas := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_20a49_exam_ocas)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_20a49_exam_ocas := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 20) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 49)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_50amais_exam_ocas)
                                                {
                                                    XmlName = 'de_50amais';
                                                    textelement(h_de_50amais_exam_ocas)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_50amais_exam_ocas := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_50amais_exam_ocas)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_50amais_exam_ocas := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 50) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                            }
                                            textelement(mudam_posto)
                                            {
                                                textelement(total_mudam_posto)
                                                {
                                                    XmlName = 'total';
                                                    textelement(h_total_mudam_posto)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_total_mudam_posto := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_total_mudam_posto)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_total_mudam_posto := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin

                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Mudança de Posto Trab.") then begin
                                                                    if rEmpregado.Get(rLinhasAccoesMedicas."Employee No.") then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(inf_18_mudam_posto)
                                                {
                                                    XmlName = 'inf_18';
                                                    textelement(h_inf_18_mudam_posto)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_inf_18_mudam_posto := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_inf_18_mudam_posto)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_inf_18_mudam_posto := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Mudança de Posto Trab.") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') < 18) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_18a19_mudam_posto)
                                                {
                                                    XmlName = 'de_18a19';
                                                    textelement(h_de_18a19_mudam_posto)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_18a19_mudam_posto := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_18a19_mudam_posto)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_18a19_mudam_posto := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Mudança de Posto Trab.") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 18) or
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 19)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_20a49_mudam_posto)
                                                {
                                                    XmlName = 'de_20a49';
                                                    textelement(h_de_20a49_mudam_posto)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_20a49_mudam_posto := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_20a49_mudam_posto)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_20a49_mudam_posto := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Mudança de Posto Trab.") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 20) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 49)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_50amais_mudam_posto)
                                                {
                                                    XmlName = 'de_50amais';
                                                    textelement(h_de_50amais_mudam_posto)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_50amais_mudam_posto := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_50amais_mudam_posto)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_50amais_mudam_posto := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Mudança de Posto Trab.") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 50) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                            }
                                            textelement(alter_posto)
                                            {
                                                textelement(total_alter_posto)
                                                {
                                                    XmlName = 'total';
                                                    textelement(h_total_alter_posto)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_total_alter_posto := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_total_alter_posto)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_total_alter_posto := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Alterações no Posto Trab.") then begin
                                                                    if rEmpregado.Get(rLinhasAccoesMedicas."Employee No.") then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(inf_18_alter_posto)
                                                {
                                                    XmlName = 'inf_18';
                                                    textelement(h_inf_18_alter_posto)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_inf_18_alter_posto := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_inf_18_alter_posto)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_inf_18_alter_posto := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Alterações no Posto Trab.") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') < 18) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_18a19_alter_posto)
                                                {
                                                    XmlName = 'de_18a19';
                                                    textelement(h_de_18a19_alter_posto)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_18a19_alter_posto := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_18a19_alter_posto)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_18a19_alter_posto := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Alterações no Posto Trab.") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 18) or
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 19)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_20a49_alter_posto)
                                                {
                                                    XmlName = 'de_20a49';
                                                    textelement(h_de_20a49_alter_posto)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_20a49_alter_posto := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_20a49_alter_posto)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_20a49_alter_posto := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Alterações no Posto Trab.") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 20) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 49)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_50amais_alter_posto)
                                                {
                                                    XmlName = 'de_50amais';
                                                    textelement(h_de_50amais_alter_posto)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_50amais_alter_posto := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_50amais_alter_posto)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_50amais_alter_posto := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Alterações no Posto Trab.") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 50) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                            }
                                            textelement(reg_30dias)
                                            {
                                                textelement(total_reg_30dias)
                                                {
                                                    XmlName = 'total';
                                                    textelement(h_total_reg_30dias)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_total_reg_30dias := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_total_reg_30dias)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_total_reg_30dias := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   ((rCabAccoesMedicas.Reason =
                                                                   rCabAccoesMedicas.Reason::"Regresso ao Trab. após ausência sup. a 30 dias por acidente de trabalho") or
                                                                   (rCabAccoesMedicas.Reason =
                                                                   rCabAccoesMedicas.Reason::"Regresso ao Trab. após ausência sup. a 30 dias por doença")) then begin
                                                                    if rEmpregado.Get(rLinhasAccoesMedicas."Employee No.") then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(inf_18_reg_30dias)
                                                {
                                                    XmlName = 'inf_18';
                                                    textelement(h_inf_18_reg_30dias)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_inf_18_reg_30dias := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_inf_18_reg_30dias)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_inf_18_reg_30dias := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   ((rCabAccoesMedicas.Reason =
                                                                   rCabAccoesMedicas.Reason::"Regresso ao Trab. após ausência sup. a 30 dias por acidente de trabalho") or
                                                                   (rCabAccoesMedicas.Reason =
                                                                   rCabAccoesMedicas.Reason::"Regresso ao Trab. após ausência sup. a 30 dias por doença")) then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') < 18) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_18a19_reg_30dias)
                                                {
                                                    XmlName = 'de_18a19';
                                                    textelement(h_de_18a19_reg_30dias)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_18a19_reg_30dias := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_18a19_reg_30dias)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_18a19_reg_30dias := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   ((rCabAccoesMedicas.Reason =
                                                                   rCabAccoesMedicas.Reason::"Regresso ao Trab. após ausência sup. a 30 dias por acidente de trabalho") or
                                                                   (rCabAccoesMedicas.Reason =
                                                                   rCabAccoesMedicas.Reason::"Regresso ao Trab. após ausência sup. a 30 dias por doença")) then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 18) or
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 19)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_20a49_reg_30dias)
                                                {
                                                    XmlName = 'de_20a49';
                                                    textelement(h_de_20a49_reg_30dias)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_20a49_reg_30dias := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_20a49_reg_30dias)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_20a49_reg_30dias := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   ((rCabAccoesMedicas.Reason =
                                                                   rCabAccoesMedicas.Reason::"Regresso ao Trab. após ausência sup. a 30 dias por acidente de trabalho") or
                                                                   (rCabAccoesMedicas.Reason =
                                                                   rCabAccoesMedicas.Reason::"Regresso ao Trab. após ausência sup. a 30 dias por doença")) then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 20) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 49)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_50amais_reg_30dias)
                                                {
                                                    XmlName = 'de_50amais';
                                                    textelement(h_de_50amais_reg_30dias)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_50amais_reg_30dias := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_50amais_reg_30dias)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_50amais_reg_30dias := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   ((rCabAccoesMedicas.Reason =
                                                                   rCabAccoesMedicas.Reason::"Regresso ao Trab. após ausência sup. a 30 dias por acidente de trabalho") or
                                                                   (rCabAccoesMedicas.Reason =
                                                                   rCabAccoesMedicas.Reason::"Regresso ao Trab. após ausência sup. a 30 dias por doença")) then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 50) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                            }
                                            textelement(reg_30dias_acid)
                                            {
                                                textelement(total_reg_30dias_acid)
                                                {
                                                    XmlName = 'total';
                                                    textelement(h_total_reg_30dias_acid)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_total_reg_30dias_acid := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_total_reg_30dias_acid)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_total_reg_30dias_acid := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason =
                                                                   rCabAccoesMedicas.Reason::"Regresso ao Trab. após ausência sup. a 30 dias por acidente de trabalho") then begin
                                                                    if rEmpregado.Get(rLinhasAccoesMedicas."Employee No.") then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(inf_18_reg_30dias_acid)
                                                {
                                                    XmlName = 'inf_18';
                                                    textelement(h_inf_18_reg_30dias_acid)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_inf_18_reg_30dias_acid := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_inf_18_reg_30dias_acid)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_inf_18_reg_30dias_acid := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason =
                                                                   rCabAccoesMedicas.Reason::"Regresso ao Trab. após ausência sup. a 30 dias por acidente de trabalho") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') < 18) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_18a19_reg_30dias_acid)
                                                {
                                                    XmlName = 'de_18a19';
                                                    textelement(h_de_18a19_reg_30dias_acid)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_18a19_reg_30dias_acid := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_18a19_reg_30dias_acid)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_18a19_reg_30dias_acid := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason =
                                                                   rCabAccoesMedicas.Reason::"Regresso ao Trab. após ausência sup. a 30 dias por acidente de trabalho") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 18) or
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 19)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_20a49_reg_30dias_acid)
                                                {
                                                    XmlName = 'de_20a49';
                                                    textelement(h_de_20a49_reg_30dias_acid)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_20a49_reg_30dias_acid := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_20a49_reg_30dias_acid)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_20a49_reg_30dias_acid := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason =
                                                                   rCabAccoesMedicas.Reason::"Regresso ao Trab. após ausência sup. a 30 dias por acidente de trabalho") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 20) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 49)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_50amais_reg_30dias_acid)
                                                {
                                                    XmlName = 'de_50amais';
                                                    textelement(h_de_50amais_reg_30dias_acid)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_50amais_reg_30dias_acid := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_50amais_reg_30dias_acid)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_50amais_reg_30dias_acid := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason =
                                                                   rCabAccoesMedicas.Reason::"Regresso ao Trab. após ausência sup. a 30 dias por acidente de trabalho") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 50) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                            }
                                            textelement(reg_30dias_doen)
                                            {
                                                textelement(total_reg_30dias_doen)
                                                {
                                                    XmlName = 'total';
                                                    textelement(h_total_reg_30dias_doen)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_total_reg_30dias_doen := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_total_reg_30dias_doen)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_total_reg_30dias_doen := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason =
                                                                   rCabAccoesMedicas.Reason::"Regresso ao Trab. após ausência sup. a 30 dias por doença") then begin
                                                                    if rEmpregado.Get(rLinhasAccoesMedicas."Employee No.") then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(inf_18_reg_30dias_doen)
                                                {
                                                    XmlName = 'inf_18';
                                                    textelement(h_inf_18_reg_30dias_doen)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_inf_18_reg_30dias_doen := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_inf_18_reg_30dias_doen)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_inf_18_reg_30dias_doen := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason =
                                                                   rCabAccoesMedicas.Reason::"Regresso ao Trab. após ausência sup. a 30 dias por doença") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') < 18) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_18a19_reg_30dias_doen)
                                                {
                                                    XmlName = 'de_18a19';
                                                    textelement(h_de_18a19_reg_30dias_doen)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_18a19_reg_30dias_doen := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_18a19_reg_30dias_doen)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_18a19_reg_30dias_doen := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason =
                                                                   rCabAccoesMedicas.Reason::"Regresso ao Trab. após ausência sup. a 30 dias por doença") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 18) or
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 19)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_20a49_reg_30dias_doen)
                                                {
                                                    XmlName = 'de_20a49';
                                                    textelement(h_de_20a49_reg_30dias_doen)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_20a49_reg_30dias_doen := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_20a49_reg_30dias_doen)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_20a49_reg_30dias_doen := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason =
                                                                   rCabAccoesMedicas.Reason::"Regresso ao Trab. após ausência sup. a 30 dias por doença") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 20) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 49)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_50amais_reg_30dias_doen)
                                                {
                                                    XmlName = 'de_50amais';
                                                    textelement(h_de_50amais_reg_30dias_doen)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_50amais_reg_30dias_doen := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_50amais_reg_30dias_doen)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_50amais_reg_30dias_doen := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason =
                                                                   rCabAccoesMedicas.Reason::"Regresso ao Trab. após ausência sup. a 30 dias por doença") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 50) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                            }
                                            textelement(inic_medico)
                                            {
                                                textelement(total_inic_medico)
                                                {
                                                    XmlName = 'total';
                                                    textelement(h_total_inic_medico)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_total_inic_medico := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_total_inic_medico)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_total_inic_medico := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Iniciativa do médico") then begin
                                                                    if rEmpregado.Get(rLinhasAccoesMedicas."Employee No.") then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(inf_18_inic_medico)
                                                {
                                                    XmlName = 'inf_18';
                                                    textelement(h_inf_18_inic_medico)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_inf_18_inic_medico := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_inf_18_inic_medico)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_inf_18_inic_medico := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Iniciativa do médico") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') < 18) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_18a19_inic_medico)
                                                {
                                                    XmlName = 'de_18a19';
                                                    textelement(h_de_18a19_inic_medico)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_18a19_inic_medico := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_18a19_inic_medico)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_18a19_inic_medico := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Iniciativa do médico") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 18) or
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 19)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_20a49_inic_medico)
                                                {
                                                    XmlName = 'de_20a49';
                                                    textelement(h_de_20a49_inic_medico)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_20a49_inic_medico := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_20a49_inic_medico)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_20a49_inic_medico := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                    (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Iniciativa do médico") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 20) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 49)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_50amais_inic_medico)
                                                {
                                                    XmlName = 'de_50amais';
                                                    textelement(h_de_50amais_inic_medico)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_50amais_inic_medico := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_50amais_inic_medico)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_50amais_inic_medico := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Iniciativa do médico") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 50) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                            }
                                            textelement(pedido)
                                            {
                                                textelement(total_pedido)
                                                {
                                                    XmlName = 'total';
                                                    textelement(h_total_pedido)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_total_pedido := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_total_pedido)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_total_pedido := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Pedido do trabalhador") then begin
                                                                    if rEmpregado.Get(rLinhasAccoesMedicas."Employee No.") then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(inf_18_pedido)
                                                {
                                                    XmlName = 'inf_18';
                                                    textelement(h_inf_18_pedido)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_inf_18_pedido := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_inf_18_pedido)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_inf_18_pedido := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Pedido do trabalhador") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') < 18) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_18a19_pedido)
                                                {
                                                    XmlName = 'de_18a19';
                                                    textelement(h_de_18a19_pedido)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_18a19_pedido := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_18a19_pedido)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_18a19_pedido := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Pedido do trabalhador") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 18) or
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 19)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_20a49_pedido)
                                                {
                                                    XmlName = 'de_20a49';
                                                    textelement(h_de_20a49_pedido)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_20a49_pedido := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_20a49_pedido)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_20a49_pedido := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                    (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Pedido do trabalhador") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 20) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 49)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_50amais_pedido)
                                                {
                                                    XmlName = 'de_50amais';
                                                    textelement(h_de_50amais_pedido)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_50amais_pedido := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_50amais_pedido)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_50amais_pedido := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Pedido do trabalhador") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 50) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                            }
                                            textelement(cessacao_contr)
                                            {
                                                textelement(total_cessacao_contr)
                                                {
                                                    XmlName = 'total';
                                                    textelement(h_total_cessacao_contr)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_total_cessacao_contr := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_total_cessacao_contr)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_total_cessacao_contr := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Por cessação do contrato de trabalho") then begin
                                                                    if rEmpregado.Get(rLinhasAccoesMedicas."Employee No.") then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(inf_18_cessacao_contr)
                                                {
                                                    XmlName = 'inf_18';
                                                    textelement(h_inf_18_cessacao_contr)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_inf_18_cessacao_contr := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_inf_18_cessacao_contr)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_inf_18_cessacao_contr := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Por cessação do contrato de trabalho") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') < 18) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_18a19_cessacao_contr)
                                                {
                                                    XmlName = 'de_18a19';
                                                    textelement(h_de_18a19_cessacao_contr)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_18a19_cessacao_contr := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_18a19_cessacao_contr)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_18a19_cessacao_contr := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Por cessação do contrato de trabalho") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 18) or
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 19)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_20a49_cessacao_contr)
                                                {
                                                    XmlName = 'de_20a49';
                                                    textelement(h_de_20a49_cessacao_contr)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_20a49_cessacao_contr := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_20a49_cessacao_contr)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_20a49_cessacao_contr := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                    (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Por cessação do contrato de trabalho") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 20) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 49)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_50amais_cessacao_contr)
                                                {
                                                    XmlName = 'de_50amais';
                                                    textelement(h_de_50amais_cessacao_contr)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_50amais_cessacao_contr := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_50amais_cessacao_contr)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_50amais_cessacao_contr := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Por cessação do contrato de trabalho") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 50) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                            }
                                            textelement(outras_raz)
                                            {
                                                textelement(total_outras_raz)
                                                {
                                                    XmlName = 'total';
                                                    textelement(h_total_outras_raz)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_total_outras_raz := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_total_outras_raz)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_total_outras_raz := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Outras Razões") then begin
                                                                    if rEmpregado.Get(rLinhasAccoesMedicas."Employee No.") then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(inf_18_outras_raz)
                                                {
                                                    XmlName = 'inf_18';
                                                    textelement(h_inf_18_outras_raz)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_inf_18_outras_raz := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_inf_18_outras_raz)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_inf_18_outras_raz := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Outras Razões") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') < 18) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_18a19_outras_raz)
                                                {
                                                    XmlName = 'de_18a19';
                                                    textelement(h_de_18a19_outras_raz)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_18a19_outras_raz := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_18a19_outras_raz)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_18a19_outras_raz := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Outras Razões") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 18) or
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') = 19)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_20a49_outras_raz)
                                                {
                                                    XmlName = 'de_20a49';
                                                    textelement(h_de_20a49_outras_raz)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_20a49_outras_raz := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_20a49_outras_raz)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_20a49_outras_raz := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                    (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Outras Razões") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       ((Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 20) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') <= 49)) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(de_50amais_outras_raz)
                                                {
                                                    XmlName = 'de_50amais';
                                                    textelement(h_de_50amais_outras_raz)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_de_50amais_outras_raz := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_de_50amais_outras_raz)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_de_50amais_outras_raz := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                                   (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Ocasional") and
                                                                   (rCabAccoesMedicas.Reason = rCabAccoesMedicas.Reason::"Outras Razões") then begin
                                                                    if (rEmpregado.Get(rLinhasAccoesMedicas."Employee No.")) and
                                                                       (Round((DMY2Date(31, 12, vAno) - rEmpregado."Birth Date") / 365, 1, '<') >= 50) then begin
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                        if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                    end;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                            }
                                        }
                                        textelement(exames_compl)
                                        {
                                            textattribute(realizados_exames_compl)
                                            {
                                                XmlName = 'realizados';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    flag := false;
                                                    rLinhasAccoesMedicas.Reset;
                                                    rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                    rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                    if rLinhasAccoesMedicas.FindSet then begin
                                                        repeat
                                                            if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                               (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Exame Complementar") then
                                                                flag := true;
                                                        until (rLinhasAccoesMedicas.Next = 0) or (flag = true);
                                                    end;

                                                    if flag = true then
                                                        realizados_exames_compl := 'S'
                                                    else
                                                        realizados_exames_compl := 'N';
                                                end;
                                            }
                                            tableelement(examescomplementares; "Cab. Acções Médicas")
                                            {
                                                XmlName = 'exame_compl';
                                                SourceTableView = WHERE("Exam Type" = CONST("Exame Complementar"));
                                                fieldelement(exame; ExamesComplementares.Code)
                                                {
                                                    textattribute(tbl_exames_compl2)
                                                    {
                                                        XmlName = 'tbl';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            tbl_exames_compl2 := 'ECR_COD_EXAME';
                                                        end;
                                                    }
                                                }
                                                textelement(n_total)
                                                {

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas."Entry No.", ExamesComplementares."Entry No.");
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.Find('+') then
                                                            n_total := Format(rLinhasAccoesMedicas.Count);
                                                    end;
                                                }
                                                tableelement("factores risco - exames"; "Factores Risco - Exames")
                                                {
                                                    XmlName = 'factores_risco';
                                                    fieldelement(factor_risco; "Factores Risco - Exames"."Risk Factor")
                                                    {
                                                        textattribute(tbl_factor_risco)
                                                        {
                                                            XmlName = 'tbl';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                tbl_factor_risco := 'ECR_FACT_RISCO';
                                                            end;
                                                        }
                                                    }

                                                    trigger OnPreXmlItem()
                                                    begin
                                                        "Factores Risco - Exames".SetRange("Factores Risco - Exames"."Entry No.", rLinhasAccoesMedicas."Entry No.");
                                                    end;
                                                }

                                                trigger OnAfterGetRecord()
                                                begin
                                                    rLinhasAccoesMedicas.Reset;
                                                    rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas."Entry No.", ExamesComplementares."Entry No.");
                                                    rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                    rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                    if not rLinhasAccoesMedicas.FindFirst then
                                                        currXMLport.Skip;
                                                end;
                                            }
                                        }
                                        textelement(accoes_imun)
                                        {
                                            textattribute(realizadas_accoes_imun)
                                            {
                                                XmlName = 'realizadas';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    flag := false;
                                                    rLinhasAccoesMedicas.Reset;
                                                    rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                    rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                    if rLinhasAccoesMedicas.FindSet then begin
                                                        repeat
                                                            if (rCabAccoesMedicas.Get(rLinhasAccoesMedicas."Entry No.")) and
                                                               (rCabAccoesMedicas."Exam Type" = rCabAccoesMedicas."Exam Type"::"Acções Imunização") then
                                                                flag := true;
                                                        until (rLinhasAccoesMedicas.Next = 0) or (flag = true);
                                                    end;

                                                    if flag = true then
                                                        realizadas_accoes_imun := 'S'
                                                    else
                                                        realizadas_accoes_imun := 'N';
                                                end;
                                            }
                                            tableelement(accoesimunizacao; "Cab. Acções Médicas")
                                            {
                                                XmlName = 'accao_imun';
                                                SourceTableView = WHERE("Exam Type" = FILTER("Acções Imunização"));
                                                fieldelement(vacina; AccoesImunizacao.Code)
                                                {
                                                    textattribute(tbl_vacina)
                                                    {
                                                        XmlName = 'tbl';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            tbl_vacina := 'AI_COD_VACINA';
                                                        end;
                                                    }
                                                }
                                                textelement(n_inoc)
                                                {

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas."Entry No.", AccoesImunizacao."Entry No.");
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.Find('+') then
                                                            n_inoc := Format(rLinhasAccoesMedicas.Count);

                                                        Clear(vContM);
                                                        Clear(vContH);
                                                        rLinhasAccoesMedicas.Reset;
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas."Entry No.", AccoesImunizacao."Entry No.");
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                        rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                        if rLinhasAccoesMedicas.FindSet then begin
                                                            repeat
                                                                if rEmpregado.Get(rLinhasAccoesMedicas."Employee No.") then begin
                                                                    if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                    if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                end;
                                                            until rLinhasAccoesMedicas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                                textelement(n_trab_accoes_imun)
                                                {
                                                    XmlName = 'n_trab';
                                                    textelement(h_n_trab_accoes_imun)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin

                                                            h_n_trab_accoes_imun := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_n_trab_accoes_imun)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_n_trab_accoes_imun := Format(vContM);
                                                        end;
                                                    }
                                                }

                                                trigger OnPreXmlItem()
                                                begin
                                                    rLinhasAccoesMedicas.Reset;
                                                    rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas."Entry No.", AccoesImunizacao."Entry No.");
                                                    rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Date, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                    rLinhasAccoesMedicas.SetRange(rLinhasAccoesMedicas.Status, rLinhasAccoesMedicas.Status::Realizada);
                                                    if not rLinhasAccoesMedicas.FindFirst then
                                                        currXMLport.Skip;
                                                end;
                                            }
                                        }
                                        textelement(accoes_prom)
                                        {
                                            textattribute(realizadas_accoes_prom)
                                            {
                                                XmlName = 'realizadas';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    rAccoesPromSaude.Reset;
                                                    rAccoesPromSaude.SetRange(rAccoesPromSaude.Data, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                    if rAccoesPromSaude.FindFirst then
                                                        realizadas_accoes_prom := 'S'
                                                    else
                                                        realizadas_accoes_prom := 'N';
                                                end;
                                            }
                                            tableelement("accoespromosaude>"; "Acções Promoção da Saúde")
                                            {
                                                XmlName = 'accao_prom';
                                                fieldelement(actividade; "AccoesPromoSaude>"."Actividade Desenvolvida")
                                                {
                                                    textattribute(tbl_actividade)
                                                    {
                                                        XmlName = 'tbl';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            tbl_actividade := 'PST_COD_ACT_DESENV';
                                                        end;
                                                    }
                                                }
                                                fieldelement(n_accoes; "AccoesPromoSaude>"."No. Acções Realizadas")
                                                {
                                                }
                                                textelement(n_trab_accoes_prom)
                                                {
                                                    XmlName = 'n_trab';
                                                    fieldelement(h; "AccoesPromoSaude>"."No. Trabalhadores Abrangidos H")
                                                    {
                                                    }
                                                    fieldelement(m; "AccoesPromoSaude>"."No. Trabalhadores Abrangidos M")
                                                    {
                                                    }
                                                }
                                            }
                                        }
                                        textelement(aciden_trab_i311)
                                        {
                                            textattribute(ocorreram)
                                            {

                                                trigger OnBeforePassVariable()
                                                begin
                                                    ocorreram := 'N';
                                                    rAcidentesTrab.Reset;
                                                    rAcidentesTrab.SetRange(rAcidentesTrab."Data Acidente", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                    if rAcidentesTrab.FindSet then begin
                                                        repeat
                                                            if (rEmpregado.Get(rAcidentesTrab."Employee No.")) and
                                                               (rEmpregado.Estabelecimento = "Estabelecimentos da Empresa"."Número da Unidade Local") then begin
                                                                rContratoEmpregado.Reset;
                                                                rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", rEmpregado."No.");
                                                                rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', DMY2Date(31, 12, vAno));
                                                                rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '=%1|>=%2', 0D, DMY2Date(1, 1, vAno));
                                                                if rContratoEmpregado.FindFirst then begin
                                                                    if (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"Sem Termo") or
                                                                       (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"A Termo") then
                                                                        ocorreram := 'S';
                                                                end;
                                                            end;
                                                        until rAcidentesTrab.Next = 0;
                                                    end;
                                                end;
                                            }
                                            textelement(acidentes)
                                            {
                                                textelement(n_aciden_ocorr)
                                                {
                                                    textelement(totalacidentes)
                                                    {
                                                        XmlName = 'total';
                                                        textelement(h_total_acid)
                                                        {
                                                            XmlName = 'h';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                h_total_acid := Format(vContH);
                                                            end;
                                                        }
                                                        textelement(m_total_acid)
                                                        {
                                                            XmlName = 'm';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                m_total_acid := Format(vContM);
                                                            end;
                                                        }

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            Clear(vContM);
                                                            Clear(vContH);
                                                            Clear(vTotalAcidentes);
                                                            rAcidentesTrab.Reset;
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Data Acidente", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                            if rAcidentesTrab.FindSet then begin
                                                                repeat
                                                                    if (rEmpregado.Get(rAcidentesTrab."Employee No.")) and
                                                                       (rEmpregado.Estabelecimento = "Estabelecimentos da Empresa"."Número da Unidade Local") then begin
                                                                        rContratoEmpregado.Reset;
                                                                        rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", rEmpregado."No.");
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', DMY2Date(31, 12, vAno));
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '=%1|>=%2', 0D, DMY2Date(1, 1, vAno));
                                                                        if rContratoEmpregado.FindFirst then begin
                                                                            if (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"Sem Termo") or
                                                                               (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"A Termo") then begin
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                                vTotalAcidentes := vTotalAcidentes + 1;
                                                                            end;
                                                                        end;
                                                                    end;

                                                                until rAcidentesTrab.Next = 0;
                                                            end;
                                                        end;
                                                    }
                                                    textelement(de_1a3)
                                                    {
                                                        textelement(h_de_1a3)
                                                        {
                                                            XmlName = 'h';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                h_de_1a3 := Format(vContH);
                                                            end;
                                                        }
                                                        textelement(m_de_1a3)
                                                        {
                                                            XmlName = 'm';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                m_de_1a3 := Format(vContM);
                                                            end;
                                                        }

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            Clear(vContM);
                                                            Clear(vContH);
                                                            rAcidentesTrab.Reset;
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Data Acidente", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Dias de trabalho perdidos", rAcidentesTrab."Dias de trabalho perdidos"::"1a3");
                                                            if rAcidentesTrab.FindSet then begin
                                                                repeat
                                                                    if (rEmpregado.Get(rAcidentesTrab."Employee No.")) and
                                                                       (rEmpregado.Estabelecimento = "Estabelecimentos da Empresa"."Número da Unidade Local") then begin

                                                                        rContratoEmpregado.Reset;
                                                                        rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", rEmpregado."No.");
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', DMY2Date(31, 12, vAno));
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '=%1|>=%2', 0D, DMY2Date(1, 1, vAno));
                                                                        if rContratoEmpregado.FindFirst then begin
                                                                            if (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"Sem Termo") or
                                                                               (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"A Termo") then begin
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                            end;
                                                                        end;
                                                                    end;

                                                                until rAcidentesTrab.Next = 0;
                                                            end;
                                                        end;
                                                    }
                                                    textelement(de_4a30)
                                                    {
                                                        textelement(h_de_4a30)
                                                        {
                                                            XmlName = 'h';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                h_de_4a30 := Format(vContH);
                                                            end;
                                                        }
                                                        textelement(m_de_4a30)
                                                        {
                                                            XmlName = 'm';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                m_de_4a30 := Format(vContM);
                                                            end;
                                                        }

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            Clear(vContM);
                                                            Clear(vContH);
                                                            rAcidentesTrab.Reset;
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Data Acidente", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Dias de trabalho perdidos", rAcidentesTrab."Dias de trabalho perdidos"::"4a30");
                                                            if rAcidentesTrab.FindSet then begin
                                                                repeat
                                                                    if (rEmpregado.Get(rAcidentesTrab."Employee No.")) and
                                                                       (rEmpregado.Estabelecimento = "Estabelecimentos da Empresa"."Número da Unidade Local") then begin

                                                                        rContratoEmpregado.Reset;
                                                                        rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", rEmpregado."No.");
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', DMY2Date(31, 12, vAno));
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '=%1|>=%2', 0D, DMY2Date(1, 1, vAno));
                                                                        if rContratoEmpregado.FindFirst then begin
                                                                            if (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"Sem Termo") or
                                                                               (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"A Termo") then begin
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                            end;
                                                                        end;
                                                                    end;

                                                                until rAcidentesTrab.Next = 0;
                                                            end;
                                                        end;
                                                    }
                                                    textelement(sup_30)
                                                    {
                                                        textelement(h_sup_30)
                                                        {
                                                            XmlName = 'h';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                h_sup_30 := Format(vContH);
                                                            end;
                                                        }
                                                        textelement(m_sup_30)
                                                        {
                                                            XmlName = 'm';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                m_sup_30 := Format(vContM);
                                                            end;
                                                        }

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            Clear(vContM);
                                                            Clear(vContH);
                                                            rAcidentesTrab.Reset;
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Data Acidente", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Dias de trabalho perdidos", rAcidentesTrab."Dias de trabalho perdidos"::Sup30);
                                                            if rAcidentesTrab.FindSet then begin
                                                                repeat
                                                                    if (rEmpregado.Get(rAcidentesTrab."Employee No.")) and
                                                                       (rEmpregado.Estabelecimento = "Estabelecimentos da Empresa"."Número da Unidade Local") then begin
                                                                        rContratoEmpregado.Reset;
                                                                        rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", rEmpregado."No.");
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', DMY2Date(31, 12, vAno));
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '=%1|>=%2', 0D, DMY2Date(1, 1, vAno));
                                                                        if rContratoEmpregado.FindFirst then begin
                                                                            if (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"Sem Termo") or
                                                                               (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"A Termo") then begin
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                            end;
                                                                        end;
                                                                    end;

                                                                until rAcidentesTrab.Next = 0;
                                                            end;
                                                        end;
                                                    }
                                                    textelement(inf_1dia)
                                                    {
                                                        textelement(h_inf_1dia)
                                                        {
                                                            XmlName = 'h';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                h_inf_1dia := Format(vContH);
                                                            end;
                                                        }
                                                        textelement(m_inf_1dia)
                                                        {
                                                            XmlName = 'm';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                m_inf_1dia := Format(vContM);
                                                            end;
                                                        }

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            Clear(vContM);
                                                            Clear(vContH);
                                                            rAcidentesTrab.Reset;
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Data Acidente", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Dias de trabalho perdidos", rAcidentesTrab."Dias de trabalho perdidos"::inf1);
                                                            if rAcidentesTrab.FindSet then begin
                                                                repeat
                                                                    if (rEmpregado.Get(rAcidentesTrab."Employee No.")) and
                                                                       (rEmpregado.Estabelecimento = "Estabelecimentos da Empresa"."Número da Unidade Local") then begin
                                                                        rContratoEmpregado.Reset;
                                                                        rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", rEmpregado."No.");
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', DMY2Date(31, 12, vAno));
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '=%1|>=%2', 0D, DMY2Date(1, 1, vAno));
                                                                        if rContratoEmpregado.FindFirst then begin
                                                                            if (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"Sem Termo") or
                                                                               (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"A Termo") then begin
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                            end;
                                                                        end;

                                                                    end;

                                                                until rAcidentesTrab.Next = 0;
                                                            end;
                                                        end;
                                                    }
                                                    textelement(mortal)
                                                    {
                                                        textelement(h_mortal)
                                                        {
                                                            XmlName = 'h';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                h_mortal := Format(vContH);
                                                            end;
                                                        }
                                                        textelement(m_mortal)
                                                        {
                                                            XmlName = 'm';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                m_mortal := Format(vContM);
                                                            end;
                                                        }

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            Clear(vContM);
                                                            Clear(vContH);
                                                            rAcidentesTrab.Reset;
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Data Acidente", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Dias de trabalho perdidos", rAcidentesTrab."Dias de trabalho perdidos"::Mortal);
                                                            if rAcidentesTrab.FindSet then begin
                                                                repeat
                                                                    if (rEmpregado.Get(rAcidentesTrab."Employee No.")) and
                                                                       (rEmpregado.Estabelecimento = "Estabelecimentos da Empresa"."Número da Unidade Local") then begin
                                                                        rContratoEmpregado.Reset;
                                                                        rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", rEmpregado."No.");
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', DMY2Date(31, 12, vAno));
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '=%1|>=%2', 0D, DMY2Date(1, 1, vAno));
                                                                        if rContratoEmpregado.FindFirst then begin
                                                                            if (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"Sem Termo") or
                                                                               (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"A Termo") then begin
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                            end;
                                                                        end;
                                                                    end;

                                                                until rAcidentesTrab.Next = 0;
                                                            end;
                                                        end;
                                                    }
                                                }
                                                textelement(n_aciden_perdi)
                                                {
                                                    textelement(total_aciden_perdi)
                                                    {
                                                        XmlName = 'total';
                                                        textelement(h_total_aciden_perdi)
                                                        {
                                                            XmlName = 'h';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                h_total_aciden_perdi := Format(vContH);
                                                            end;
                                                        }
                                                        textelement(m_total_aciden_perdi)
                                                        {
                                                            XmlName = 'm';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                m_total_aciden_perdi := Format(vContM);
                                                            end;
                                                        }

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            Clear(vContM);
                                                            Clear(vContH);
                                                            Clear(vNumDiasPerdidos);
                                                            rAcidentesTrab.Reset;
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Data Acidente", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                            rAcidentesTrab.SetFilter(rAcidentesTrab."Dias de trabalho perdidos", '<>%1', 0);
                                                            if rAcidentesTrab.FindSet then begin
                                                                repeat
                                                                    Clear(NDias);
                                                                    rAcidentesTrab.TestField(rAcidentesTrab."Data ínicio da interrupção");
                                                                    rAcidentesTrab.TestField(rAcidentesTrab."Data fim da interrupção");
                                                                    NDias := rAcidentesTrab."Data fim da interrupção" - rAcidentesTrab."Data ínicio da interrupção" + 1;
                                                                    if (rEmpregado.Get(rAcidentesTrab."Employee No.")) and
                                                                       (rEmpregado.Estabelecimento = "Estabelecimentos da Empresa"."Número da Unidade Local") then begin
                                                                        rContratoEmpregado.Reset;
                                                                        rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", rEmpregado."No.");
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', DMY2Date(31, 12, vAno));
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '=%1|>=%2', 0D, DMY2Date(1, 1, vAno));
                                                                        if rContratoEmpregado.FindFirst then begin
                                                                            if (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"Sem Termo") or
                                                                               (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"A Termo") then begin
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + NDias;
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + NDias;
                                                                                vNumDiasPerdidos := vNumDiasPerdidos + 1;

                                                                            end;
                                                                        end;
                                                                    end;

                                                                until rAcidentesTrab.Next = 0;
                                                            end;
                                                        end;
                                                    }
                                                    textelement(de_1a3_aciden_perdi)
                                                    {
                                                        XmlName = 'de_1a3';
                                                        textelement(h_de_1a3_aciden_perdi)
                                                        {
                                                            XmlName = 'h';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                h_de_1a3_aciden_perdi := Format(vContH);
                                                            end;
                                                        }
                                                        textelement(m_de_1a3_aciden_perdi)
                                                        {
                                                            XmlName = 'm';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                m_de_1a3_aciden_perdi := Format(vContM);
                                                            end;
                                                        }

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            Clear(vContM);
                                                            Clear(vContH);
                                                            rAcidentesTrab.Reset;
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Data Acidente", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Dias de trabalho perdidos", rAcidentesTrab."Dias de trabalho perdidos"::"1a3");
                                                            if rAcidentesTrab.FindSet then begin
                                                                repeat
                                                                    Clear(NDias);
                                                                    rAcidentesTrab.TestField(rAcidentesTrab."Data ínicio da interrupção");
                                                                    rAcidentesTrab.TestField(rAcidentesTrab."Data fim da interrupção");
                                                                    NDias := rAcidentesTrab."Data fim da interrupção" - rAcidentesTrab."Data ínicio da interrupção" + 1;
                                                                    if (rEmpregado.Get(rAcidentesTrab."Employee No.")) and
                                                                       (rEmpregado.Estabelecimento = "Estabelecimentos da Empresa"."Número da Unidade Local") then begin
                                                                        rContratoEmpregado.Reset;
                                                                        rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", rEmpregado."No.");
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', DMY2Date(31, 12, vAno));
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '=%1|>=%2', 0D, DMY2Date(1, 1, vAno));
                                                                        if rContratoEmpregado.FindFirst then begin
                                                                            if (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"Sem Termo") or
                                                                               (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"A Termo") then begin
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + NDias;
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + NDias;
                                                                            end;
                                                                        end;
                                                                    end;

                                                                until rAcidentesTrab.Next = 0;
                                                            end;
                                                        end;
                                                    }
                                                    textelement(de_4a30_aciden_perdi)
                                                    {
                                                        XmlName = 'de_4a30';
                                                        textelement(h_de_4a30_aciden_perdi)
                                                        {
                                                            XmlName = 'h';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                h_de_4a30_aciden_perdi := Format(vContH);
                                                            end;
                                                        }
                                                        textelement(m_de_4a30_aciden_perdi)
                                                        {
                                                            XmlName = 'm';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                m_de_4a30_aciden_perdi := Format(vContM);
                                                            end;
                                                        }

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            Clear(vContM);
                                                            Clear(vContH);
                                                            rAcidentesTrab.Reset;
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Data Acidente", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Dias de trabalho perdidos", rAcidentesTrab."Dias de trabalho perdidos"::"4a30");
                                                            if rAcidentesTrab.FindSet then begin
                                                                repeat
                                                                    Clear(NDias);
                                                                    rAcidentesTrab.TestField(rAcidentesTrab."Data ínicio da interrupção");
                                                                    rAcidentesTrab.TestField(rAcidentesTrab."Data fim da interrupção");
                                                                    NDias := rAcidentesTrab."Data fim da interrupção" - rAcidentesTrab."Data ínicio da interrupção" + 1;
                                                                    if (rEmpregado.Get(rAcidentesTrab."Employee No.")) and
                                                                       (rEmpregado.Estabelecimento = "Estabelecimentos da Empresa"."Número da Unidade Local") then begin
                                                                        rContratoEmpregado.Reset;
                                                                        rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", rEmpregado."No.");
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', DMY2Date(31, 12, vAno));
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '=%1|>=%2', 0D, DMY2Date(1, 1, vAno));
                                                                        if rContratoEmpregado.FindFirst then begin
                                                                            if (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"Sem Termo") or
                                                                               (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"A Termo") then begin
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + NDias;
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + NDias;
                                                                            end;
                                                                        end;
                                                                    end;

                                                                until rAcidentesTrab.Next = 0;
                                                            end;
                                                        end;
                                                    }
                                                    textelement(sup_30__aciden_perdi)
                                                    {
                                                        XmlName = 'sup_30';
                                                        textelement(h_sup_30_aciden_perdi)
                                                        {
                                                            XmlName = 'h';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                h_sup_30_aciden_perdi := Format(vContH);
                                                            end;
                                                        }
                                                        textelement(m_sup_30_aciden_perdi)
                                                        {
                                                            XmlName = 'm';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                m_sup_30_aciden_perdi := Format(vContM);
                                                            end;
                                                        }

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            Clear(vContM);
                                                            Clear(vContH);
                                                            rAcidentesTrab.Reset;
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Data Acidente", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Dias de trabalho perdidos", rAcidentesTrab."Dias de trabalho perdidos"::Sup30);
                                                            if rAcidentesTrab.FindSet then begin
                                                                repeat
                                                                    Clear(NDias);
                                                                    rAcidentesTrab.TestField(rAcidentesTrab."Data ínicio da interrupção");
                                                                    rAcidentesTrab.TestField(rAcidentesTrab."Data fim da interrupção");
                                                                    NDias := rAcidentesTrab."Data fim da interrupção" - rAcidentesTrab."Data ínicio da interrupção" + 1;
                                                                    if (rEmpregado.Get(rAcidentesTrab."Employee No.")) and
                                                                       (rEmpregado.Estabelecimento = "Estabelecimentos da Empresa"."Número da Unidade Local") then begin
                                                                        rContratoEmpregado.Reset;
                                                                        rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", rEmpregado."No.");
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', DMY2Date(31, 12, vAno));
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '=%1|>=%2', 0D, DMY2Date(1, 1, vAno));
                                                                        if rContratoEmpregado.FindFirst then begin
                                                                            if (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"Sem Termo") or
                                                                               (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"A Termo") then begin
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + NDias;
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + NDias;
                                                                            end;
                                                                        end;
                                                                    end;

                                                                until rAcidentesTrab.Next = 0;
                                                            end;
                                                        end;
                                                    }
                                                }
                                                textelement(n_aciden_perdi_ant)
                                                {
                                                    textelement(total_aciden_perdi_ant)
                                                    {
                                                        XmlName = 'total';
                                                        textelement(h_total_aciden_perdi_ant)
                                                        {
                                                            XmlName = 'h';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                h_total_aciden_perdi_ant := Format(vContH);
                                                            end;
                                                        }
                                                        textelement(m_total_aciden_perdi_ant)
                                                        {
                                                            XmlName = 'm';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                m_total_aciden_perdi_ant := Format(vContM);
                                                            end;
                                                        }

                                                        trigger OnBeforePassVariable()
                                                        begin

                                                            Clear(vContM);
                                                            Clear(vContH);
                                                            rAcidentesTrab.Reset;
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Data Acidente", DMY2Date(1, 1, vAno - 1), DMY2Date(31, 12, vAno - 1));
                                                            rAcidentesTrab.SetFilter(rAcidentesTrab."Dias de trabalho perdidos", '<>%1', 0);
                                                            rAcidentesTrab.SetFilter(rAcidentesTrab."Data fim da interrupção", '>=%1', DMY2Date(1, 1, vAno));
                                                            if rAcidentesTrab.FindSet then begin
                                                                repeat
                                                                    Clear(NDias);
                                                                    rAcidentesTrab.TestField(rAcidentesTrab."Data ínicio da interrupção");
                                                                    rAcidentesTrab.TestField(rAcidentesTrab."Data fim da interrupção");
                                                                    NDias := rAcidentesTrab."Data fim da interrupção" - DMY2Date(1, 1, vAno) + 1;
                                                                    if (rEmpregado.Get(rAcidentesTrab."Employee No.")) and
                                                                       (rEmpregado.Estabelecimento = "Estabelecimentos da Empresa"."Número da Unidade Local") then begin
                                                                        rContratoEmpregado.Reset;
                                                                        rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", rEmpregado."No.");
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', DMY2Date(31, 12, vAno));
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '=%1|>=%2', 0D, DMY2Date(1, 1, vAno));
                                                                        if rContratoEmpregado.FindFirst then begin
                                                                            if (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"Sem Termo") or
                                                                               (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"A Termo") then begin
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + NDias;
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + NDias;
                                                                            end;
                                                                        end;
                                                                    end;

                                                                until rAcidentesTrab.Next = 0;
                                                            end;
                                                        end;
                                                    }
                                                    textelement(de_1a3_aciden_perdi_ant)
                                                    {
                                                        XmlName = 'de_1a3';
                                                        textelement(h_de_1a3_aciden_perdi_ant)
                                                        {
                                                            XmlName = 'h';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                h_de_1a3_aciden_perdi_ant := Format(vContH);
                                                            end;
                                                        }
                                                        textelement(m_de_1a3_aciden_perdi_ant)
                                                        {
                                                            XmlName = 'm';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                m_de_1a3_aciden_perdi_ant := Format(vContM);
                                                            end;
                                                        }

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            Clear(vContM);
                                                            Clear(vContH);
                                                            rAcidentesTrab.Reset;
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Data Acidente", DMY2Date(1, 1, vAno - 1), DMY2Date(31, 12, vAno - 1));
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Dias de trabalho perdidos", rAcidentesTrab."Dias de trabalho perdidos"::"1a3");
                                                            rAcidentesTrab.SetFilter(rAcidentesTrab."Data fim da interrupção", '>=%1', DMY2Date(1, 1, vAno));
                                                            if rAcidentesTrab.FindSet then begin
                                                                repeat
                                                                    Clear(NDias);
                                                                    rAcidentesTrab.TestField(rAcidentesTrab."Data ínicio da interrupção");
                                                                    rAcidentesTrab.TestField(rAcidentesTrab."Data fim da interrupção");
                                                                    NDias := rAcidentesTrab."Data fim da interrupção" - DMY2Date(1, 1, vAno) + 1;
                                                                    if (rEmpregado.Get(rAcidentesTrab."Employee No.")) and
                                                                       (rEmpregado.Estabelecimento = "Estabelecimentos da Empresa"."Número da Unidade Local") then begin
                                                                        rContratoEmpregado.Reset;
                                                                        rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", rEmpregado."No.");
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', DMY2Date(31, 12, vAno));
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '=%1|>=%2', 0D, DMY2Date(1, 1, vAno));
                                                                        if rContratoEmpregado.FindFirst then begin
                                                                            if (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"Sem Termo") or
                                                                               (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"A Termo") then begin
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + NDias;
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + NDias;
                                                                            end;
                                                                        end;
                                                                    end;

                                                                until rAcidentesTrab.Next = 0;
                                                            end;
                                                        end;
                                                    }
                                                    textelement(de_4a30_aciden_perdi_ant)
                                                    {
                                                        XmlName = 'de_4a30';
                                                        textelement(h_de_4a30_aciden_perdi_ant)
                                                        {
                                                            XmlName = 'h';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                h_de_4a30_aciden_perdi_ant := Format(vContH);
                                                            end;
                                                        }
                                                        textelement(m_de_4a30_aciden_perdi_ant)
                                                        {
                                                            XmlName = 'm';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                m_de_4a30_aciden_perdi_ant := Format(vContM);
                                                            end;
                                                        }

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            Clear(vContM);
                                                            Clear(vContH);
                                                            rAcidentesTrab.Reset;
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Data Acidente", DMY2Date(1, 1, vAno - 1), DMY2Date(31, 12, vAno - 1));
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Dias de trabalho perdidos", rAcidentesTrab."Dias de trabalho perdidos"::"4a30");
                                                            rAcidentesTrab.SetFilter(rAcidentesTrab."Data fim da interrupção", '>=%1', DMY2Date(1, 1, vAno));
                                                            if rAcidentesTrab.FindSet then begin
                                                                repeat
                                                                    Clear(NDias);
                                                                    rAcidentesTrab.TestField(rAcidentesTrab."Data ínicio da interrupção");
                                                                    rAcidentesTrab.TestField(rAcidentesTrab."Data fim da interrupção");
                                                                    NDias := rAcidentesTrab."Data fim da interrupção" - DMY2Date(1, 1, vAno) + 1;
                                                                    if (rEmpregado.Get(rAcidentesTrab."Employee No.")) and
                                                                       (rEmpregado.Estabelecimento = "Estabelecimentos da Empresa"."Número da Unidade Local") then begin
                                                                        rContratoEmpregado.Reset;
                                                                        rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", rEmpregado."No.");
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', DMY2Date(31, 12, vAno));
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '=%1|>=%2', 0D, DMY2Date(1, 1, vAno));
                                                                        if rContratoEmpregado.FindFirst then begin
                                                                            if (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"Sem Termo") or
                                                                               (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"A Termo") then begin
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + NDias;
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + NDias;
                                                                            end;
                                                                        end;
                                                                    end;

                                                                until rAcidentesTrab.Next = 0;
                                                            end;
                                                        end;
                                                    }
                                                    textelement(sup_30_aciden_perdi_ant)
                                                    {
                                                        XmlName = 'sup_30';
                                                        textelement(h_sup_30_aciden_perdi_ant)
                                                        {
                                                            XmlName = 'h';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                h_sup_30_aciden_perdi_ant := Format(vContH);
                                                            end;
                                                        }
                                                        textelement(m_sup_30_aciden_perdi_ant)
                                                        {
                                                            XmlName = 'm';

                                                            trigger OnBeforePassVariable()
                                                            begin
                                                                m_sup_30_aciden_perdi_ant := Format(vContM);
                                                            end;
                                                        }

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            Clear(vContM);
                                                            Clear(vContH);
                                                            rAcidentesTrab.Reset;
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Data Acidente", DMY2Date(1, 1, vAno - 1), DMY2Date(31, 12, vAno - 1));
                                                            rAcidentesTrab.SetRange(rAcidentesTrab."Dias de trabalho perdidos", rAcidentesTrab."Dias de trabalho perdidos"::Sup30);
                                                            rAcidentesTrab.SetFilter(rAcidentesTrab."Data fim da interrupção", '>=%1', DMY2Date(1, 1, vAno));
                                                            if rAcidentesTrab.FindSet then begin
                                                                repeat
                                                                    Clear(NDias);
                                                                    rAcidentesTrab.TestField(rAcidentesTrab."Data ínicio da interrupção");
                                                                    rAcidentesTrab.TestField(rAcidentesTrab."Data fim da interrupção");
                                                                    NDias := rAcidentesTrab."Data fim da interrupção" - DMY2Date(1, 1, vAno) + 1;
                                                                    if (rEmpregado.Get(rAcidentesTrab."Employee No.")) and
                                                                       (rEmpregado.Estabelecimento = "Estabelecimentos da Empresa"."Número da Unidade Local") then begin
                                                                        rContratoEmpregado.Reset;
                                                                        rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", rEmpregado."No.");
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', DMY2Date(31, 12, vAno));
                                                                        rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '=%1|>=%2', 0D, DMY2Date(1, 1, vAno));
                                                                        if rContratoEmpregado.FindFirst then begin
                                                                            if (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"Sem Termo") or
                                                                               (rContratoEmpregado."Tipo Contrato" = rContratoEmpregado."Tipo Contrato"::"A Termo") then begin
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + NDias;
                                                                                if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + NDias;
                                                                            end;
                                                                        end;
                                                                    end;

                                                                until rAcidentesTrab.Next = 0;
                                                            end;
                                                        end;
                                                    }
                                                }
                                                textelement(tax_freq)
                                                {

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        if vContaHorasTotais <> 0 then //Normatica 2013.04.16 - acrescentei o IF
                                                            tax_freq := Format(Round((vTotalAcidentes / vContaHorasTotais) * 1000000, 1), 0, '<Integer><Decimals,2>');
                                                    end;
                                                }
                                                textelement(tax_grav)
                                                {

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        if vContaHorasTotais <> 0 then //Normatica 2013.04.16 - acrescentei o IF
                                                            tax_grav := Format(Round((vNumDiasPerdidos / vContaHorasTotais) * 1000000, 1), 0, '<Integer><Decimals,2>');
                                                    end;
                                                }
                                            }
                                        }
                                        textelement(aciden_trab_i32)
                                        {
                                            textattribute(ocorreram_aciden_trab_i32)
                                            {
                                                XmlName = 'ocorreram';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    Clear(i32NumAcidMortais);
                                                    Clear(i32NumAcidNMortais);
                                                    ocorreram_aciden_trab_i32 := 'N';
                                                    rAcidentesTrab.Reset;
                                                    rAcidentesTrab.SetRange(rAcidentesTrab."Data Acidente", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                    if rAcidentesTrab.FindSet then begin
                                                        repeat
                                                            if (rEmpregado.Get(rAcidentesTrab."Employee No.")) and
                                                               (rEmpregado.Estabelecimento = "Estabelecimentos da Empresa"."Número da Unidade Local") and
                                                               (rEmpregado."Tipo Contribuinte" = rEmpregado."Tipo Contribuinte"::"Trabalhador Independente") then begin
                                                                ocorreram_aciden_trab_i32 := 'S';
                                                                if rAcidentesTrab."Dias de trabalho perdidos" = rAcidentesTrab."Dias de trabalho perdidos"::Mortal then
                                                                    i32NumAcidMortais := i32NumAcidMortais + 1
                                                                else
                                                                    i32NumAcidNMortais := i32NumAcidNMortais + 1;
                                                            end;
                                                        until rAcidentesTrab.Next = 0;
                                                    end;
                                                end;
                                            }
                                        }
                                        textelement(tax_incid_total)
                                        {

                                            trigger OnBeforePassVariable()
                                            begin
                                                if int_total_outros <> 0 then
                                                    tax_incid_total := Format(Round((i32NumAcidNMortais / int_total_outros) * 1000, 1), 0, '<Integer><Decimals,2>')
                                                else
                                                    tax_incid_total := '0.00';
                                            end;
                                        }
                                        textelement(tax_incid_mortals)
                                        {

                                            trigger OnBeforePassVariable()
                                            begin
                                                if int_total_outros <> 0 then
                                                    tax_incid_mortals := Format(Round((i32NumAcidMortais / int_total_outros) * 1000, 1), 0, '<Integer><Decimals,2>')
                                                else
                                                    tax_incid_mortals := '0.00';
                                            end;
                                        }
                                        textelement(doenc_partic)
                                        {
                                            textattribute(participadas_doenc_partic)
                                            {
                                                XmlName = 'participadas';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    rDoencas.Reset;
                                                    rDoencas.SetRange(rDoencas."Data Participação", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                    if rDoencas.FindSet then
                                                        participadas_doenc_partic := 'S'
                                                    else
                                                        participadas_doenc_partic := 'N';
                                                end;
                                            }
                                            tableelement(doencasprof; "Doenças Profissionais")
                                            {
                                                XmlName = 'doenc';
                                                fieldelement(fact_risco; DoencasProf."Factor Risco")
                                                {
                                                    textattribute(tbl_fact_risco_doenc_partic)
                                                    {
                                                        XmlName = 'tbl';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            tbl_fact_risco_doenc_partic := 'DPPO_COD_FACT_RISCO';
                                                        end;
                                                    }
                                                }
                                                fieldelement(doenca; DoencasProf."Doença Profissional")
                                                {
                                                    textattribute("tbl_doença_doenc_partic")
                                                    {
                                                        XmlName = 'tbl';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            tbl_doença_doenc_partic := 'DPPO_COD_DOENCA';
                                                        end;
                                                    }
                                                }
                                                textelement(n_casos_doenc_partic)
                                                {
                                                    XmlName = 'n_casos';
                                                    textelement(h_n_casos_doenc_partic)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_n_casos_doenc_partic := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_n_casos_doenc_partic)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_n_casos_doenc_partic := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rDoencas.Reset;
                                                        rDoencas.SetRange("Factor Risco", DoencasProf."Factor Risco");
                                                        rDoencas.SetRange("Doença Profissional", DoencasProf."Doença Profissional");
                                                        if rDoencas.FindSet then begin
                                                            repeat
                                                                if rEmpregado.Get(rDoencas."Employee No.") then begin
                                                                    if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                    if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                end;
                                                            until rDoencas.Next = 0;
                                                        end;
                                                    end;
                                                }

                                                trigger OnAfterGetRecord()
                                                begin
                                                    tempDoencas.Reset;
                                                    tempDoencas.SetRange("Factor Risco", DoencasProf."Factor Risco");
                                                    tempDoencas.SetRange("Doença Profissional", DoencasProf."Doença Profissional");
                                                    if not tempDoencas.FindFirst then begin
                                                        tempDoencas.Init;
                                                        tempDoencas.TransferFields(DoencasProf);
                                                        tempDoencas.Insert;
                                                    end else
                                                        currXMLport.Skip;
                                                end;

                                                trigger OnPreXmlItem()
                                                begin
                                                    DoencasProf.SetRange("Data Participação", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                    tempDoencas.Reset;
                                                    tempDoencas.DeleteAll;
                                                end;
                                            }
                                        }
                                        textelement(doenc_conf)
                                        {
                                            textattribute(confirmadas_doenc_conf)
                                            {
                                                XmlName = 'confirmadas';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    rDoencas.Reset;
                                                    rDoencas.SetRange(rDoencas."Data Participação", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                    rDoencas.SetFilter(rDoencas."Data Confirmação", '<>%1', 0D);
                                                    if rDoencas.FindSet then
                                                        confirmadas_doenc_conf := 'S'
                                                    else
                                                        confirmadas_doenc_conf := 'N';
                                                end;
                                            }
                                            tableelement(doencasprofconf; "Doenças Profissionais")
                                            {
                                                XmlName = 'doenc';
                                                fieldelement(fact_risco; DoencasProfConf."Factor Risco")
                                                {
                                                    textattribute(tbl_fact_risco_doenc_conf)
                                                    {
                                                        XmlName = 'tbl';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            tbl_fact_risco_doenc_conf := 'DPPO_COD_FACT_RISCO';
                                                        end;
                                                    }
                                                }
                                                fieldelement(doenca; DoencasProfConf."Doença Profissional")
                                                {
                                                    textattribute("tbl_doença_doenc_conf")
                                                    {
                                                        XmlName = 'tbl';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            tbl_doença_doenc_conf := 'DPPO_COD_DOENCA';
                                                        end;
                                                    }
                                                }
                                                textelement(n_casos_doenc_conf)
                                                {
                                                    XmlName = 'n_casos';
                                                    textelement(h_n_casos_doenc_conf)
                                                    {
                                                        XmlName = 'h';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            h_n_casos_doenc_conf := Format(vContH);
                                                        end;
                                                    }
                                                    textelement(m_n_casos_doenc_conf)
                                                    {
                                                        XmlName = 'm';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            m_n_casos_doenc_conf := Format(vContM);
                                                        end;
                                                    }

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        Clear(vContH);
                                                        Clear(vContM);
                                                        rDoencas.Reset;
                                                        rDoencas.SetRange("Factor Risco", DoencasProfConf."Factor Risco");
                                                        rDoencas.SetRange("Doença Profissional", DoencasProfConf."Doença Profissional");
                                                        if rDoencas.FindSet then begin
                                                            repeat
                                                                if rEmpregado.Get(rDoencas."Employee No.") then begin
                                                                    if rEmpregado.Sex = rEmpregado.Sex::Female then vContM := vContM + 1;
                                                                    if rEmpregado.Sex = rEmpregado.Sex::Male then vContH := vContH + 1;
                                                                end;
                                                            until rDoencas.Next = 0;
                                                        end;
                                                    end;
                                                }
                                            }
                                        }

                                        trigger OnPreXmlItem()
                                        begin
                                            "Segurança e Saúde no Trabalho".SetRange("Segurança e Saúde no Trabalho".Ano, Format(vAno));
                                        end;
                                    }
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
        if rCompInf.Get then;
        vAno := Date2DMY(WorkDate, 3) - 1;
    end;

    var
        rEmpregado: Record Empregado;
        rPessoalServicos: Record "Pessoal dos Serviços";
        rCompInf: Record "Company Information";
        rHistEmpregado: Record "Historico Empregado";
        rActividadesServicos: Record "Actividades dos Serviços";
        rSegurancaeSaudeTrabalho: Record "Segurança e Saúde no Trabalho";
        rAccoesInfConFor: Record "Acções de Inf. Cons. For";
        rFactoresdeRisco: Record "Factores de Risco";
        rLinhasAccoesMedicas: Record "Linhas Acções Médicas";
        rCabAccoesMedicas: Record "Cab. Acções Médicas";
        rAccoesPromSaude: Record "Acções Promoção da Saúde";
        rAcidentesTrab: Record "Acidentes de Trabalho";
        rDoencas: Record "Doenças Profissionais";
        tempDoencas: Record "Doenças Profissionais" temporary;
        rHistCabMovEmp: Record "Hist. Cab. Movs. Empregado";
        rContratoEmpregado: Record "Contrato Empregado";
        rContratoTrab: Record "Contrato Trabalho";
        rData: Record Date;
        rFeriados: Record "Feriados RH";
        rFeriasEmpregado: Record "Férias Empregados";
        rUniMedHR: Record "Unid. Medida Recursos Humanos";
        rHistAusen: Record "Histórico Ausências";
        rHorasExtra: Record "Histórico Horas Extra";
        rConfRH: Record "Config. Recursos Humanos";
        intSit_prof: Integer;
        vAno: Integer;
        flag: Boolean;
        vContH: Integer;
        vContM: Integer;
        Text0001: Label 'Preencha as configurações da Segurança e Saúde no Trabalho para o ano %1.';
        Text0002: Label 'Preencha o écran de Pessoal dos Serviços para o ano %1 em Segurança e Saúde no Trabalho.';
        NDias: Integer;
        vTotalAcidentes: Integer;
        vNumDiasPerdidos: Integer;
        vTotPessoas: Integer;
        vDate: Date;
        i: Integer;
        int_total_vinc: Integer;
        int_h_vinc: Integer;
        int_m_vinc: Integer;
        int_total_outros: Integer;
        int_h_outros: Integer;
        int_m_outros: Integer;
        vContaDiasUteis: Integer;
        vContaDiasEmp: Integer;
        vContaHorasTotais: Integer;
        DataIni: Date;
        DataFim: Date;
        vDia: Code[10];
        vHora: Code[10];
        qtd: Decimal;
        Faltas: Decimal;
        HorasExtra: Decimal;
        i32NumAcidNMortais: Integer;
        i32NumAcidMortais: Integer;
        Utils: Codeunit "PTSS Export SAF-T PT";
}

