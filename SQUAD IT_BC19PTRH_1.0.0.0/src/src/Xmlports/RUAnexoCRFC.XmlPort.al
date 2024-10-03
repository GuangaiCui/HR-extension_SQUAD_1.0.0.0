xmlport 53038 "RU - Anexo C - RFC"
{
    // IT001 - Correção Exportação - 30-04-2018
    //           - Estava a exportar registos mesmo quando não estava a encontrar registos e dava erro nas valições.
    Encoding = UTF8;
    Namespaces = ru = 'http://www.gep.mtss.gov.pt/sguri/ru', t = 'http://www.gep.mtss.gov.pt/sguri/tipos_comuns',
                 xsi = 'http://www.w3.org/2001/XMLSchema-instance';


    schema
    {
        textelement("relatorio_unico")
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
                    "xsi:schemaLocation" := 'http://www.gep.mtss.gov.pt/sguri/ru relatorio-rfc-3.3.0.xsd ';
                    "xsi:schemaLocation" += 'http://www.gep.mtss.gov.pt/sguri/tipos_comuns tipos-comuns-1.4.0.xsd ';
                    "xsi:schemaLocation" += 'http://www.gep.mtss.gov.pt/sguri/ru/anexo_rfc anexo-rfc-1.3.0.xsd';
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
                    textelement(anexo_rfc)
                    {
                        textattribute(xmlns)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                //xmlns := 'http://www.gep.mtss.gov.pt/sguri/ru/anexo_rfc';
                            end;
                        }
                        textattribute(xml_data1)
                        {
                            XmlName = 'XML_DATA';

                            trigger OnBeforePassVariable()
                            begin
                                XML_DATA1 := '1.3.0';
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
                        textelement(exist_trabalhadores)
                        {
                            XmlName = 'exist_trabalhadores';

                            trigger OnBeforePassVariable()
                            begin
                                exist_trabalhadores := 'S';
                            end;
                        }
                        textelement(dados_rfc)
                        {
                            textelement(cae_31Dez)
                            {
                                textattribute(tbl1)
                                {
                                    XmlName = 'tbl';

                                    trigger OnBeforePassVariable()
                                    begin
                                        tbl1 := 'RU_CAE_5DIG';
                                    end;
                                }

                                trigger OnBeforePassVariable()
                                begin
                                    cae_31Dez := rCompInf."PTSS CAE Code";
                                end;
                            }
                            textelement(formacoes)
                            {
                                tableelement("acções formação"; "Acções Formação")
                                {
                                    MaxOccurs = Unbounded;
                                    XmlName = 'formacao';
                                    fieldelement(area_educacao; "Acções Formação"."Cod. Área de Educ./Formação")
                                    {
                                        textattribute(tbl2)
                                        {
                                            XmlName = 'tbl';

                                            trigger OnBeforePassVariable()
                                            begin
                                                tbl2 := 'RU_AREAFORM';
                                            end;
                                        }
                                    }
                                    fieldelement(modalidade; "Acções Formação"."Cod. Modalidade")
                                    {
                                        textattribute(tbl3)
                                        {
                                            XmlName = 'tbl';

                                            trigger OnBeforePassVariable()
                                            begin
                                                tbl3 := 'RU_MODAL';
                                            end;
                                        }
                                    }
                                    textelement(duracao_accao)
                                    {

                                        trigger OnBeforePassVariable()
                                        begin

                                            duracao_accao := Format(Round("Acções Formação"."No. Horas Acção", 1));
                                        end;
                                    }
                                    fieldelement(entidade_formadora; "Acções Formação"."Cod. Entidade Formadora")
                                    {
                                        textattribute(tbl4)
                                        {
                                            XmlName = 'tbl';

                                            trigger OnBeforePassVariable()
                                            begin
                                                tbl4 := 'RU_ENTFORM';
                                            end;
                                        }
                                    }
                                    fieldelement(qualificacao; "Acções Formação"."Cód. Nível Qualificação Form.")
                                    {
                                        textattribute(tbl5)
                                        {
                                            XmlName = 'tbl';

                                            trigger OnBeforePassVariable()
                                            begin
                                                tbl5 := 'RU_QUALIF';
                                            end;
                                        }
                                    }

                                    trigger OnAfterGetRecord()
                                    begin
                                        nAccao := nAccao + 1;
                                        "Acções Formação"."Temp No. Accao" := nAccao;
                                        "Acções Formação".Modify;

                                        "Acções Formação".TestField("Acções Formação"."Cod. Área de Educ./Formação");
                                        "Acções Formação".TestField("Acções Formação"."Cod. Modalidade");
                                        "Acções Formação".TestField("Acções Formação"."No. Horas Acção");
                                        "Acções Formação".TestField("Acções Formação"."Cod. Entidade Formadora");
                                        "Acções Formação".TestField("Acções Formação"."Cód. Nível Qualificação Form.");
                                    end;

                                    trigger OnPreXmlItem()
                                    begin
                                        "Acções Formação".SetFilter("Acções Formação"."Data Início", '>=%1&<=%2', DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                    end;
                                }
                            }
                            textelement(trabalhadores)
                            {
                                tableelement(empregado; Empregado)
                                {
                                    XmlName = 'trabalhador';
                                    fieldelement(ident_reg_apli; Empregado."Cod. Regime Reforma Aplicado")
                                    {
                                        textattribute(tbl6)
                                        {
                                            XmlName = 'tbl';

                                            trigger OnBeforePassVariable()
                                            begin
                                                tbl6 := 'RU_REREAP';
                                            end;
                                        }
                                    }
                                    fieldelement(niss; Empregado."No. Segurança Social")
                                    {
                                    }
                                    fieldelement(nome; Empregado.Name)
                                    {
                                    }
                                    fieldelement(situacao_freq; Empregado."Formação-Situação face à freq.")
                                    {
                                        textattribute(tbl7)
                                        {
                                            XmlName = 'tbl';

                                            trigger OnBeforePassVariable()
                                            begin
                                                tbl7 := 'RU_SITFREQ';
                                            end;
                                        }
                                    }
                                    textelement(registos)
                                    {
                                        tableelement("formação empregado"; "Formação Empregado")
                                        {
                                            LinkFields = "No. Empregado" = FIELD("No.");
                                            LinkTable = Empregado;
                                            XmlName = 'registo';
                                            textelement(id_formacao_registo)
                                            {

                                                trigger OnBeforePassVariable()
                                                begin
                                                    id_formacao_registo := Format(rAccaoFormacao."Temp No. Accao");
                                                end;
                                            }
                                            textelement(iniciativa)
                                            {
                                                textattribute(tbl8)
                                                {
                                                    XmlName = 'tbl';

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        tbl8 := 'RU_INICIAT';
                                                    end;
                                                }

                                                trigger OnBeforePassVariable()
                                                begin
                                                    Clear(optIniciativaFor);
                                                    Clear(iniciativa);
                                                    optIniciativaFor := "Formação Empregado"."Iniciativa da Formação";
                                                    iniciativa := Format(optIniciativaFor);
                                                end;
                                            }
                                            textelement(horario_formacao)
                                            {
                                                textattribute(tbl9)
                                                {
                                                    XmlName = 'tbl';

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        tbl9 := 'RU_HORFORM';
                                                    end;
                                                }

                                                trigger OnBeforePassVariable()
                                                begin
                                                    Clear(optHorario);
                                                    Clear(horario_formacao);
                                                    optHorario := "Formação Empregado"."Horário Formação";
                                                    horario_formacao := Format(optHorario);
                                                end;
                                            }
                                            fieldelement(diploma; "Formação Empregado"."Tipo Certificado/Diploma")
                                            {
                                                textattribute(tbl10)
                                                {
                                                    XmlName = 'tbl';

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        tbl10 := 'RU_DIPLOM';
                                                    end;
                                                }

                                                trigger OnBeforePassField()
                                                begin
                                                    "Formação Empregado".TestField("Formação Empregado"."Tipo Certificado/Diploma");
                                                end;
                                            }
                                            tableelement("formação - período referência"; "Formação - Período Referência")
                                            {
                                                XmlName = 'periodos_ref';
                                                fieldelement(periodo_ref; "Formação - Período Referência"."Período Ref. Formação")
                                                {
                                                    textattribute(tbl11)
                                                    {
                                                        XmlName = 'tbl';

                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            tbl11 := 'RU_PEDREF';
                                                        end;
                                                    }
                                                }

                                                trigger OnPreXmlItem()
                                                begin
                                                    rAccaoFormacaoAux.Reset;
                                                    rAccaoFormacaoAux.SetRange(rAccaoFormacaoAux."Temp No. Accao", rAccaoFormacao."Temp No. Accao");
                                                    if rAccaoFormacaoAux.FindFirst then begin
                                                        "Formação - Período Referência".SetRange("Formação - Período Referência"."No. Empregado", Empregado."No.");
                                                        "Formação - Período Referência".SetRange("Formação - Período Referência"."Cód. Acção", rAccaoFormacaoAux.Código);
                                                    end;
                                                end;
                                            }

                                            trigger OnAfterGetRecord()
                                            begin
                                                if rAccaoFormacao.Get("Formação Empregado"."Cód. Acção") then;
                                            end;

                                            trigger OnPreXmlItem()
                                            begin
                                                //Normatica 2013.04.18 - para aparecer só acções deste ano
                                                "Formação Empregado".SetFilter("Formação Empregado"."Data Início", '>=%1&<=%2', DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                //IT001,sn
                                                if not "Formação Empregado".FindFirst then
                                                    currXMLport.Break;
                                                //IT001,en
                                            end;
                                        }
                                    }

                                    trigger OnAfterGetRecord()
                                    begin
                                        Empregado.TestField(Empregado."Cod. Regime Reforma Aplicado");
                                        Empregado.TestField(Empregado."Formação-Situação face à freq.");
                                    end;

                                    trigger OnPreXmlItem()
                                    begin
                                        rEmpregado.Reset;
                                        rEmpregado.ModifyAll(rEmpregado.Marcado, false);
                                        rEmpregado.Reset;
                                        if rEmpregado.FindSet then begin
                                            repeat
                                                rFormacaoEmp.Reset;
                                                rFormacaoEmp.SetRange(rFormacaoEmp."No. Empregado", rEmpregado."No.");
                                                rFormacaoEmp.SetFilter(rFormacaoEmp."Data Início", '>=%1&<=%2', DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                if rFormacaoEmp.FindFirst then begin
                                                    rEmpregado.Marcado := true;
                                                    rEmpregado.Modify;
                                                end;
                                            until rEmpregado.Next = 0;
                                        end;

                                        Empregado.SetRange(Marcado, true);
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
        if rCompInf.Get then;
        vAno := Date2DMY(WorkDate, 3) - 1;
        nAccao := 0;
    end;

    var
        rEmpregado: Record Empregado;
        rCompInf: Record "Company Information";
        rAccaoFormacao: Record "Acções Formação";
        rAccaoFormacaoAux: Record "Acções Formação";
        rFormacaoEmp: Record "Formação Empregado";
        rConfRH: Record "Config. Recursos Humanos";
        vAno: Integer;
        nAccao: Integer;
        optIniciativaFor: Option "01","02","03";
        optHorario: Option "01","02","03";
        Utils: Codeunit "PTSS Export SAF-T PT";
}

