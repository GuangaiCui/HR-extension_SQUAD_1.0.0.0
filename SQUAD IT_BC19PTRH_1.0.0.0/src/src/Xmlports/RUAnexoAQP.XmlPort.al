xmlport 53036 "RU - Anexo A - QP"
{
    // IT001 - Correção Processo exportação - 30-04-2018
    //           -Estava a exportar registo de trabalhador mesmo quando não existem.
    //              - Como exporta por estabelecimento empresa e, neste caso, a "Sede" não tem empregados ele exportava um registo em branco de trabalhador
    //                e origina erros nas validações.

    Encoding = UTF8;
    DefaultNamespace = 'http://www.gep.mtss.gov.pt/sguri/ru';
    UseDefaultNamespace = true;
    //Namespaces = 'http://www.gep.mtss.gov.pt/sguri/ru';

    schema
    {
        textelement(relatorio_unico)
        {
            textattribute(xml_data)
            {
                XmlName = 'XML_DATA';

                trigger OnBeforePassVariable()
                begin
                    XML_DATA := '3.3.0';
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
            textattribute("xsi:schemaLocation")
            {

                trigger OnBeforePassVariable()
                begin
                    "xsi:schemaLocation" := 'http://www.gep.mtss.gov.pt/sguri/ru relatorio-qp-3.30.xsd ';
                    "xsi:schemaLocation" := "xsi:schemaLocation" + 'http://www.gep.mtss.gov.pt/sguri/tipos_comuns tipos-comuns-1.4.0.xsd ';
                    "xsi:schemaLocation" := "xsi:schemaLocation" + 'http://www.gep.mtss.gov.pt/sguri/ru/anexo_qp anexo-qp-1.4.0.xsd';
                end;
            }
            textelement(header)
            {
                textelement(aplicacao)
                {
                    textelement(nome)
                    {
                        XmlName = 'nome';

                        trigger OnBeforePassVariable()
                        begin
                            nome := 'MICROSFT DYNAMICS NAV'
                        end;
                    }
                    textelement(versao)
                    {
                        XmlName = 'versao';

                        trigger OnBeforePassVariable()
                        begin
                            versao := Utils.CodProductVersion();
                        end;
                    }
                    textelement(empresa)
                    {
                        XmlName = 'empresa';

                        trigger OnBeforePassVariable()
                        begin
                            empresa := rCompInf.Name;
                        end;
                    }
                }
            }
            textelement(body)
            {
                textelement(anexos)
                {
                    textelement(anexo_qp)
                    {
                        textattribute(xmlns2)
                        {
                            XmlName = 'xmlns';

                            trigger OnBeforePassVariable()
                            begin

                                //xmlns2 := 'http://www.gep.mtss.gov.pt/sguri/ru/anexo_qp';
                                xmlns2 := 'http://www.gep.mtss.gov.pt/sguri/ru';
                            end;
                        }
                        textattribute(xml_data2)
                        {
                            XmlName = 'XML_DATA';

                            trigger OnBeforePassVariable()
                            begin
                                XML_DATA2 := '1.4.0';
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
                        textelement(total_pess_servico_31Out)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                Clear(vConta);
                                rEmpregado.Reset;
                                rEmpregado.SetRange(rEmpregado."Tipo Contribuinte", rEmpregado."Tipo Contribuinte"::"Conta de Outrem");
                                if rEmpregado.FindSet then begin
                                    repeat
                                        rHistCabMovEmp.Reset;
                                        rHistCabMovEmp.SetRange(rHistCabMovEmp."Employee No.", rEmpregado."No.");
                                        rHistCabMovEmp.SetRange(rHistCabMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                        rHistCabMovEmp.SetRange(rHistCabMovEmp."Data Registo", DMY2Date(1, 10, vAno), DMY2Date(31, 10, vAno));
                                        if rHistCabMovEmp.FindSet then
                                            vConta := vConta + 1;
                                    until rEmpregado.Next = 0;
                                end;


                                //Abater os ausentes à mais de um mês
                                rEmpregado.Reset;
                                rEmpregado.SetRange(rEmpregado."Tipo Contribuinte", rEmpregado."Tipo Contribuinte"::"Conta de Outrem");
                                if rEmpregado.FindSet then begin
                                    repeat
                                        rHistCabMovEmp.Reset;
                                        rHistCabMovEmp.SetRange(rHistCabMovEmp."Employee No.", rEmpregado."No.");
                                        rHistCabMovEmp.SetRange(rHistCabMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                        rHistCabMovEmp.SetRange(rHistCabMovEmp."Data Registo", DMY2Date(1, 10, vAno), DMY2Date(31, 10, vAno));
                                        rHistCabMovEmp.SetRange(rHistCabMovEmp.Valor, 0);
                                        if rHistCabMovEmp.FindFirst then begin
                                            rHistAusencia.Next;
                                            rHistAusencia.SetRange(rHistAusencia."Employee No.", rHistCabMovEmp."Employee No.");
                                            rHistAusencia.SetRange(rHistAusencia."To Date", DMY2Date(30, 9, vAno));
                                            if rHistAusencia.FindFirst then
                                                vConta := vConta - 1;
                                        end;
                                    until rEmpregado.Next = 0;
                                end;


                                total_pess_servico_31Out := Format(vConta);
                            end;
                        }
                        textelement(cae_31Out)
                        {
                            textattribute(tbl_cae_31out)
                            {
                                XmlName = 'tbl';

                                trigger OnBeforePassVariable()
                                begin
                                    tbl_cae_31Out := 'RU_CAE_5DIG';
                                end;
                            }

                            trigger OnBeforePassVariable()
                            begin
                                cae_31Out := rCompInf."PTSS CAE Code";
                            end;
                        }
                        textelement(natJur_31Out)
                        {
                            textattribute(tbl_natjur_31out)
                            {
                                XmlName = 'tbl';

                                trigger OnBeforePassVariable()
                                begin
                                    tbl_natJur_31Out := 'RU_NATJUR';
                                end;
                            }

                            trigger OnBeforePassVariable()
                            begin
                                natJur_31Out := rCompInf."Legal Nature Code";
                            end;
                        }
                        tableelement("estabelecimentos da empresa"; "Estabelecimentos da Empresa")
                        {
                            XmlName = 'estabs';
                            textelement(estab)
                            {
                                fieldattribute(id; "Estabelecimentos da Empresa"."ID Unidade Local")
                                {
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
                                textelement(pess_servico_31Out)
                                {

                                    trigger OnBeforePassVariable()
                                    begin
                                        Clear(vConta);
                                        Clear(pess_servico_31Out);
                                        rEmpregado.Reset;
                                        rEmpregado.SetRange(rEmpregado.Estabelecimento, "Estabelecimentos da Empresa"."Número da Unidade Local");
                                        rEmpregado.SetRange(rEmpregado."Tipo Contribuinte", rEmpregado."Tipo Contribuinte"::"Conta de Outrem");
                                        if rEmpregado.FindSet then begin
                                            repeat
                                                rHistCabMovEmp.Reset;
                                                rHistCabMovEmp.SetRange(rHistCabMovEmp."Employee No.", rEmpregado."No.");
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
                                                rHistCabMovEmp.SetRange(rHistCabMovEmp."Employee No.", rEmpregado."No.");
                                                rHistCabMovEmp.SetRange(rHistCabMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                                rHistCabMovEmp.SetRange(rHistCabMovEmp."Data Registo", DMY2Date(1, 10, vAno), DMY2Date(31, 10, vAno));
                                                rHistCabMovEmp.SetRange(rHistCabMovEmp.Valor, 0);
                                                if rHistCabMovEmp.FindFirst then begin
                                                    rHistAusencia.Next;
                                                    rHistAusencia.SetRange(rHistAusencia."Employee No.", rHistCabMovEmp."Employee No.");
                                                    rHistAusencia.SetRange(rHistAusencia."To Date", DMY2Date(30, 9, vAno));
                                                    if rHistAusencia.FindFirst then
                                                        vConta := vConta - 1;
                                                end;
                                            until rEmpregado.Next = 0;
                                        end;


                                        pess_servico_31Out := Format(vConta);
                                    end;
                                }
                                fieldelement(cae_31Out; "Estabelecimentos da Empresa"."CAE Code")
                                {
                                    textattribute(tbl_estab_cae_31out)
                                    {
                                        XmlName = 'tbl';

                                        trigger OnBeforePassVariable()
                                        begin
                                            tbl_estab_cae_31Out := 'RU_CAE_5DIG';
                                        end;
                                    }
                                }
                                textelement(trabalhadores)
                                {
                                    tableelement(empregado; Empregado)
                                    {
                                        XmlName = 'trabalhador';
                                        fieldelement(nome; Empregado.Name)
                                        {
                                        }
                                        fieldelement(ident_reg_apli; Empregado."Cod. Regime Reforma Aplicado")
                                        {
                                            textattribute(tbl_ident_reg_apli)
                                            {
                                                XmlName = 'tbl';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    tbl_ident_reg_apli := 'RU_REREAP';
                                                end;
                                            }
                                        }
                                        textelement(niss)
                                        {

                                            trigger OnBeforePassVariable()
                                            begin
                                                //Normatica 2013.04.16
                                                if Empregado."Cod. Regime Reforma Aplicado" = '1' then niss := Empregado."No. Segurança Social";
                                                if Empregado."Cod. Regime Reforma Aplicado" = '2' then niss := Empregado."Nº CGA";
                                            end;
                                        }
                                        textelement(sexo)
                                        {
                                            textattribute(tbl_sexo)
                                            {
                                                XmlName = 'tbl';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    tbl_sexo := 'RU_SX';
                                                end;
                                            }

                                            trigger OnBeforePassVariable()
                                            begin
                                                if Empregado.Sex = Empregado.Sex::Male then sexo := Format(1);
                                                if Empregado.Sex = Empregado.Sex::Female then sexo := Format(2);
                                            end;
                                        }
                                        textelement(data_nasc)
                                        {

                                            trigger OnBeforePassVariable()
                                            begin
                                                Clear(data_nasc);
                                                data_nasc := Format(Empregado."Birth Date", 0, '<year4>-<Month,2>');
                                            end;
                                        }
                                        textelement(data_entr_emp)
                                        {

                                            trigger OnBeforePassVariable()
                                            begin
                                                Clear(data_entr_emp);
                                                data_entr_emp := Format(Empregado."Employment Date", 0, '<year4>-<Month,2>');
                                            end;
                                        }
                                        textelement(data_ult_prom)
                                        {

                                            trigger OnBeforePassVariable()
                                            begin
                                                Clear(data_ult_prom);
                                                rCatProfQP.Reset;
                                                rCatProfQP.SetRange(rCatProfQP."Employee No.", Empregado."No.");
                                                rCatProfQP.SetRange(rCatProfQP."Data Inicio Cat. Prof.", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                rCatProfQP.SetFilter(rCatProfQP."Promotion Reason", '<>0');
                                                if rCatProfQP.FindLast then
                                                    data_ult_prom := Format(rCatProfQP."Data Inicio Cat. Prof.", 0, '<year4>-<Month,2>');
                                            end;
                                        }
                                        textelement(tipo_contr)
                                        {
                                            textattribute(tbl_tipo_contr)
                                            {
                                                XmlName = 'tbl';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    tbl_tipo_contr := 'RU_TIPCON';
                                                end;
                                            }

                                            trigger OnBeforePassVariable()
                                            begin
                                                Clear(tipo_contr);
                                                rContratoEmpregado.Reset;
                                                rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", Empregado."No.");
                                                if rContratoEmpregado.FindLast then begin
                                                    rContrato.Reset;
                                                    if rContrato.Get(rContratoEmpregado."Cód. Contrato") then
                                                        tipo_contr := Format(rContrato."Cód. Tipo Contrato");
                                                end;
                                            end;
                                        }
                                        fieldelement(nacionalidade; Empregado.Nacionalidade)
                                        {
                                            textattribute(tbl_nacionalidade)
                                            {
                                                XmlName = 'tbl';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    tbl_nacionalidade := 'RU_CODPAIS'
                                                end;
                                            }
                                        }
                                        fieldelement(habil_lit; Empregado."Cód. Habilitações")
                                        {
                                            textattribute(tbl_habil_lit)
                                            {
                                                XmlName = 'tbl';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    tbl_habil_lit := 'RU_HABLIT';
                                                end;
                                            }
                                        }
                                        textelement(sit_prof)
                                        {
                                            textattribute(tbl_sit_prof)
                                            {
                                                XmlName = 'tbl';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    tbl_sit_prof := 'RU_SITPROF';
                                                end;
                                            }

                                            trigger OnBeforePassVariable()
                                            begin
                                                Clear(optSit_prof);
                                                optSit_prof := Empregado."Situação Profissional";
                                                sit_prof := Format(optSit_prof);
                                            end;
                                        }
                                        fieldelement(profissao; Empregado."Class. Nac. Profi.")
                                        {
                                            textattribute(tbl_profissao)
                                            {
                                                XmlName = 'tbl';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    tbl_profissao := 'RU_CPP';
                                                end;
                                            }
                                        }
                                        fieldelement(irct; Empregado."Cód. IRCT")
                                        {
                                            textattribute(tbl_irct)
                                            {
                                                XmlName = 'tbl';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    tbl_irct := 'RU_IRCT';
                                                end;
                                            }
                                        }
                                        textelement(aplic_irct)
                                        {
                                            textattribute(tbl_aplic_irct)
                                            {
                                                XmlName = 'tbl';

                                                trigger OnBeforePassVariable()
                                                begin

                                                    tbl_aplic_irct := 'RU_APLICIRCT';
                                                end;
                                            }

                                            trigger OnBeforePassVariable()
                                            begin
                                                Clear(optAplic_irct);
                                                Clear(aplic_irct);
                                                optAplic_irct := Empregado."Aplicabilidade do IRCT";
                                                aplic_irct := Format(optAplic_irct);
                                            end;
                                        }
                                        fieldelement(cat_prof; Empregado."Cód. Cat. Prof QP")
                                        {
                                            textattribute(tbl_cat_prof)
                                            {
                                                XmlName = 'tbl';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    tbl_cat_prof := 'RU_CATPROF';
                                                end;
                                            }
                                        }
                                        textelement(nivel_qual)
                                        {
                                            textattribute(tbl_nivel_qual)
                                            {
                                                XmlName = 'tbl';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    tbl_nivel_qual := 'RU_NVLQLF';
                                                end;
                                            }

                                            trigger OnBeforePassVariable()
                                            begin
                                                Clear(nivel_qual);
                                                rQualificacaoEmp.Reset;
                                                rQualificacaoEmp.SetRange(rQualificacaoEmp."Employee No.", Empregado."No.");
                                                rQualificacaoEmp.SetRange(rQualificacaoEmp.Type, rQualificacaoEmp.Type::"Qualificações RU");
                                                if rQualificacaoEmp.FindLast then
                                                    nivel_qual := Format(rQualificacaoEmp."Internal Qualification", 0, '<number>')
                                                else
                                                    Message(Text0003, Empregado."No.");
                                            end;
                                        }
                                        textelement(rdt)
                                        {
                                            textattribute(tbl_rdt)
                                            {
                                                XmlName = 'tbl';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    tbl_rdt := 'RU_RG_DU_TRB';
                                                end;
                                            }

                                            trigger OnBeforePassVariable()
                                            begin
                                                Clear(intRdt);
                                                Clear(rdt);
                                                intRdt := Empregado."Regime Duração Trabalho";
                                                rdt := Format(intRdt);
                                            end;
                                        }
                                        textelement(pnt)
                                        {
                                            XmlName = 'pnt';

                                            trigger OnBeforePassVariable()
                                            begin
                                                Clear(pnt);
                                                pnt := Format(Round(Empregado."No. Horas Semanais Totais", 1));
                                                pnt := DelChr(pnt, '=', ',');
                                                if StrLen(pnt) = 2 then pnt := pnt + '0';
                                                if StrLen(pnt) = 1 then pnt := '0' + pnt + '0';
                                            end;
                                        }
                                        fieldelement(dur_temp_trab; Empregado."Duração do Tempo de Trabalho")
                                        {
                                            textattribute(tbl_dur_temp_trab)
                                            {
                                                XmlName = 'tbl';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    tbl_dur_temp_trab := 'RU_DU_TMP_TRB';
                                                end;
                                            }
                                        }
                                        textelement(org_temp_trab)
                                        {
                                            XmlName = 'org_temp_trab';
                                            textattribute(tbl_org_temp_trab)
                                            {
                                                XmlName = 'tbl';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    tbl_org_temp_trab := 'RU_ORG_TMP_TRB';
                                                end;
                                            }

                                            trigger OnBeforePassVariable()
                                            begin
                                                Clear(intOrg_temp_trab);
                                                Clear(org_temp_trab);
                                                rHorarioEmp.Reset;
                                                rHorarioEmp.SetRange(rHorarioEmp."Employee No.", Empregado."No.");
                                                rHorarioEmp.SetFilter(rHorarioEmp."Data Iníco Horário", '<=%1', DMY2Date(1, 10, vAno));
                                                rHorarioEmp.SetFilter(rHorarioEmp."Data Fim Horário", '>=%1|%2', DMY2Date(31, 10, vAno), 0D);
                                                if rHorarioEmp.FindLast then begin
                                                    if rHorarioEmp."Organização Tempo Trabalho" <> 0 then begin
                                                        intOrg_temp_trab := rHorarioEmp."Organização Tempo Trabalho";
                                                        org_temp_trab := Format(intOrg_temp_trab);
                                                    end else
                                                        Message(Text0001, Empregado."No.");
                                                end else
                                                    Message(Text0002, Empregado."No.", vAno);
                                            end;
                                        }
                                        textelement(rem_devida_out)
                                        {
                                            XmlName = 'rem_devida_Out';

                                            trigger OnBeforePassVariable()
                                            begin
                                                Clear(valor);
                                                Clear(rem_devida_Out);
                                                rHistLinhasMovEmp.Reset;
                                                rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Tipo Processamento", rHistLinhasMovEmp."Tipo Processamento"::Vencimentos);
                                                rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Data Registo", DMY2Date(1, 10, vAno),
                                                                          DMY2Date(31, 10, vAno));
                                                rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Employee No.", Empregado."No.");
                                                rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Tipo Rubrica", rHistLinhasMovEmp."Tipo Rubrica"::Abono);
                                                rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp.NATREM, rHistLinhasMovEmp.NATREM::"Remuneração Permanente");
                                                if rHistLinhasMovEmp.FindSet then begin
                                                    repeat
                                                        valor := valor + rHistLinhasMovEmp.Valor;
                                                    until rHistLinhasMovEmp.Next = 0;
                                                end;


                                                rem_devida_Out := ConvertStr(DelChr(Format(Round(valor, 0.01)), '=', '.'), ',', '.');
                                            end;
                                        }
                                        textelement(rem_paga_Out)
                                        {

                                            trigger OnBeforePassVariable()
                                            begin
                                                Clear(rem_paga_Out);
                                                Clear(valor);
                                                Clear(Filtro);

                                                rHistLinhasMovEmp.Reset;
                                                rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Tipo Processamento", rHistLinhasMovEmp."Tipo Processamento"::Vencimentos);
                                                rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Data Registo", DMY2Date(1, 10, vAno),
                                                                          DMY2Date(31, 10, vAno));
                                                rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Employee No.", Empregado."No.");
                                                rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Tipo Rubrica", rHistLinhasMovEmp."Tipo Rubrica"::Abono);
                                                rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp.NATREM, rHistLinhasMovEmp.NATREM::"Remuneração Permanente");
                                                if rHistLinhasMovEmp.FindSet then begin
                                                    repeat
                                                        valor := valor + rHistLinhasMovEmp.Valor;

                                                    until rHistLinhasMovEmp.Next = 0;
                                                end;


                                                //Abater as faltas
                                                rHistAusencia.Reset;
                                                rHistAusencia.SetRange(rHistAusencia."Employee No.", rHistLinhasMovEmp."Employee No.");
                                                rHistAusencia.SetRange(rHistAusencia."From Date", DMY2Date(1, 10, vAno), DMY2Date(31, 10, vAno));
                                                rHistAusencia.SetRange(rHistAusencia."Com Perca de Remuneração", true);
                                                if rHistAusencia.FindSet then begin
                                                    repeat
                                                        rMotAusencia.Reset;
                                                        rMotAusencia.SetRange(rMotAusencia.Code, rHistAusencia."Cause of Absence Code");
                                                        if rMotAusencia.FindFirst then
                                                            if rMotAusencia."Cod. Mot. Horas Normais N Rem" <> '' then begin
                                                                if Filtro = '' then
                                                                    Filtro := rMotAusencia.Code
                                                                else
                                                                    Filtro := Filtro + '|' + rMotAusencia.Code;
                                                            end;
                                                    until rHistAusencia.Next = 0;
                                                end;

                                                if Filtro <> '' then begin
                                                    rRubricaSal.Reset;
                                                    rRubricaSal.SetRange(rRubricaSal.Genero, rRubricaSal.Genero::Falta);
                                                    if rRubricaSal.FindSet then begin
                                                        repeat
                                                            rHistLinhasMovEmp.Reset;
                                                            rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Tipo Processamento", rHistLinhasMovEmp."Tipo Processamento"::Vencimentos);
                                                            rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Data Registo", DMY2Date(1, 10, vAno),
                                                                                      DMY2Date(31, 10, vAno));
                                                            rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Employee No.", Empregado."No.");
                                                            rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Cód. Rubrica", rRubricaSal.Código);
                                                            if rHistLinhasMovEmp.FindSet then begin
                                                                repeat
                                                                    valor := valor - Abs(rHistLinhasMovEmp.Valor);
                                                                until rHistLinhasMovEmp.Next = 0;
                                                            end;

                                                        until rRubricaSal.Next = 0;
                                                    end;
                                                end;

                                                rem_paga_Out := ConvertStr(DelChr(Format(Round(valor, 0.01)), '=', '.'), ',', '.');
                                            end;
                                        }
                                        tableelement("motivo ausência"; "Absence Reason")
                                        {
                                            MinOccurs = Zero;
                                            XmlName = 'mot_rem_inf_Out';
                                            fieldelement(motivo; "Motivo Ausência"."Cod. Mot. Horas Normais N Rem")
                                            {
                                                MaxOccurs = Unbounded;
                                                MinOccurs = Once;
                                                textattribute(tbl_motivo)
                                                {
                                                    XmlName = 'tbl';

                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        if Filtro <> '' then
                                                            tbl_motivo := 'RU_MOT_H_NREM';
                                                    end;
                                                }
                                            }

                                            trigger OnPreXmlItem()
                                            begin
                                                if Filtro <> '' then
                                                    "Motivo Ausência".SetFilter("Motivo Ausência".Code, Filtro)
                                                else
                                                    "Motivo Ausência".SetFilter("Motivo Ausência".Code, 'x')
                                            end;
                                        }
                                        textelement(horas_remun_Out)
                                        {

                                            trigger OnBeforePassVariable()
                                            var
                                                HistMovEmp: Record "Hist. Linhas Movs. Empregado";
                                                TabRubrica: Record "Rubrica Salarial";
                                                TabUniMed: Record "Unid. Medida Recursos Humanos";
                                                HorasNormais: Decimal;
                                                FaltasDias: Integer;
                                                FaltasHoras: Decimal;
                                                VarHorasNormais: Text[30];
                                                HorasMensais: Decimal;
                                            begin
                                                Clear(HorasMensais);
                                                Clear(FaltasHoras);
                                                Clear(FaltasDias);
                                                Clear(HorasNormais);
                                                Clear(VarHorasNormais);
                                                Clear(horas_remun_Out);

                                                Empregado.TestField(Empregado."No. Horas Semanais Totais");
                                                Empregado.TestField(Empregado."No. dias de Trabalho Semanal");

                                                //HorasMensais := Empregado."Nº Horas Semanais Totais" *52 /12;
                                                //Normatica 2013.04.18 - saber o Nº horas em Outubro
                                                HorasMensais := Empregado."No. Horas Semanais Totais" / Empregado."No. dias de Trabalho Semanal" *
                                                                cFuncoesRH.CalcularDiasUteisMes(Empregado.Estabelecimento, DMY2Date(1, 10, vAno), DMY2Date(31, 10, vAno));

                                                HistMovEmp.Reset;
                                                HistMovEmp.SetRange(HistMovEmp."Employee No.", Empregado."No.");
                                                HistMovEmp.SetRange(HistMovEmp."Data Registo", DMY2Date(1, 10, vAno), DMY2Date(31, 10, vAno));
                                                if HistMovEmp.Find('-') then begin
                                                    repeat
                                                        TabRubrica.Reset;
                                                        TabRubrica.SetRange(TabRubrica.Código, HistMovEmp."Cód. Rubrica");
                                                        if TabRubrica.Find('-') then begin

                                                            if TabRubrica.Genero = TabRubrica.Genero::Falta then begin
                                                                TabUniMed.Reset;
                                                                TabUniMed.SetRange(TabUniMed."Designação Interna", TabUniMed."Designação Interna"::Hora);
                                                                if TabUniMed.Find('-') then
                                                                    if HistMovEmp.UnidadeMedida = TabUniMed.Code then
                                                                        FaltasHoras := FaltasHoras + Abs(HistMovEmp.Quantity);

                                                                TabUniMed.Reset;
                                                                TabUniMed.SetRange(TabUniMed."Designação Interna", TabUniMed."Designação Interna"::Dia);
                                                                if TabUniMed.Find('-') then
                                                                    if HistMovEmp.UnidadeMedida = TabUniMed.Code then
                                                                        FaltasDias := FaltasDias + Round(Abs(HistMovEmp.Quantity), 1);

                                                            end;
                                                        end;

                                                    until HistMovEmp.Next = 0;
                                                end;


                                                HorasNormais := HorasMensais
                                                                - (FaltasDias * HorasMensais / 30)
                                                                - ((FaltasHoras * 8) * 30 / ((Empregado."No. Horas Semanais Totais" /
                                                                                     Empregado."No. dias de Trabalho Semanal") * 30));

                                                HorasNormais := Round(HorasNormais, 0.01);


                                                VarHorasNormais := CopyStr(Format(HorasNormais, 4, '<Sign><Integer><Decimals,3>'), 1,
                                                        StrPos(Format(HorasNormais, 4, '<Sign><Integer><Decimals,3>'), ',') - 1);

                                                VarHorasNormais := PadStr('0', 3 - StrLen(VarHorasNormais), '0') + VarHorasNormais;


                                                horas_remun_Out := VarHorasNormais;
                                            end;
                                        }
                                        textelement(sub_ref_out)
                                        {
                                            XmlName = 'sub_ref_Out';

                                            trigger OnBeforePassVariable()
                                            begin
                                                Clear(decSub_ref_Out);
                                                Clear(sub_ref_Out);
                                                rRubricaSalarial.Reset;
                                                rRubricaSalarial.SetRange(rRubricaSalarial.Genero, rRubricaSalarial.Genero::"Sub. Alimentação");
                                                if rRubricaSalarial.FindSet then begin
                                                    repeat
                                                        rHistLinhasMovEmp.Reset;
                                                        rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                                        rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Data Registo", DMY2Date(1, 10, vAno),
                                                                                  DMY2Date(31, 10, vAno));
                                                        rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Employee No.", Empregado."No.");
                                                        rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Cód. Rubrica", rRubricaSalarial.Código);
                                                        if rHistLinhasMovEmp.FindSet then begin
                                                            repeat
                                                                decSub_ref_Out := decSub_ref_Out + Abs(rHistLinhasMovEmp.Valor);
                                                            until rHistLinhasMovEmp.Next = 0;
                                                        end;

                                                    until rRubricaSalarial.Next = 0;
                                                end;
                                                sub_ref_Out := ConvertStr(Format(Round(decSub_ref_Out, 0.01)), ',', '.');

                                                if sub_ref_Out = '0' then sub_ref_Out := '0.0'
                                            end;
                                        }
                                        textelement(sub_turn_out)
                                        {
                                            XmlName = 'sub_turn_Out';

                                            trigger OnBeforePassVariable()
                                            begin
                                                Clear(decSub_turn_Out);
                                                Clear(sub_turn_Out);
                                                rRubricaSalarial.Reset;
                                                rRubricaSalarial.SetRange(rRubricaSalarial."Tipo de Remuneração", rRubricaSalarial."Tipo de Remuneração"::"Subsídio Turno");
                                                if rRubricaSalarial.FindSet then begin
                                                    repeat
                                                        rHistLinhasMovEmp.Reset;
                                                        rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                                        rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Data Registo", DMY2Date(1, 10, vAno),
                                                                                  DMY2Date(31, 10, vAno));
                                                        rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Employee No.", Empregado."No.");
                                                        rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Cód. Rubrica", rRubricaSalarial.Código);
                                                        if rHistLinhasMovEmp.FindSet then begin
                                                            repeat
                                                                decSub_turn_Out := decSub_turn_Out + Abs(rHistLinhasMovEmp.Valor);
                                                            until rHistLinhasMovEmp.Next = 0;
                                                        end;

                                                    until rRubricaSalarial.Next = 0;
                                                end;
                                                sub_turn_Out := ConvertStr(Format(Round(decSub_turn_Out, 0.01)), ',', '.');

                                                if sub_turn_Out = '0' then sub_turn_Out := '0.0';
                                            end;
                                        }
                                        textelement(out_sub_out)
                                        {
                                            XmlName = 'out_sub_Out';

                                            trigger OnBeforePassVariable()
                                            begin
                                                Clear(decOut_sub_Out);
                                                Clear(out_sub_Out);
                                                rRubricaSalarial.Reset;
                                                rRubricaSalarial.SetRange(rRubricaSalarial."Tipo de Remuneração",
                                                                     rRubricaSalarial."Tipo de Remuneração"::"Prémios e Subsídios Regulares");
                                                if rRubricaSalarial.FindSet then begin
                                                    repeat
                                                        rHistLinhasMovEmp.Reset;
                                                        rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                                        rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Data Registo", DMY2Date(1, 10, vAno),
                                                                                  DMY2Date(31, 10, vAno));
                                                        rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Employee No.", Empregado."No.");
                                                        rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Cód. Rubrica", rRubricaSalarial.Código);
                                                        if rHistLinhasMovEmp.FindSet then begin
                                                            repeat
                                                                decOut_sub_Out := decOut_sub_Out + Abs(rHistLinhasMovEmp.Valor);
                                                            until rHistLinhasMovEmp.Next = 0;
                                                        end;

                                                    until rRubricaSalarial.Next = 0;
                                                end;
                                                //out_sub_Out := CONVERTSTR(FORMAT(ROUND(decOut_sub_Out,0.01)),',','.');
                                                out_sub_Out := ConvertStr(DelChr(Format(Round(decOut_sub_Out, 0.01)), '=', '.'), ',', '.'); //Normatica

                                                if out_sub_Out = '0' then out_sub_Out := '0.0';
                                            end;
                                        }
                                        textelement(prest_ir_out)
                                        {
                                            XmlName = 'prest_ir_Out';

                                            trigger OnBeforePassVariable()
                                            begin
                                                Clear(decPrest_ir_Out);
                                                Clear(prest_ir_Out);
                                                rRubricaSalarial.Reset;
                                                rRubricaSalarial.SetRange(rRubricaSalarial."Tipo de Remuneração",
                                                                     rRubricaSalarial."Tipo de Remuneração"::"Prestações Irregulares");
                                                if rRubricaSalarial.FindSet then begin
                                                    repeat
                                                        rHistLinhasMovEmp.Reset;
                                                        rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                                        rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Data Registo", DMY2Date(1, 10, vAno),
                                                                                  DMY2Date(31, 10, vAno));
                                                        rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Employee No.", Empregado."No.");
                                                        rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Cód. Rubrica", rRubricaSalarial.Código);
                                                        if rHistLinhasMovEmp.FindSet then begin
                                                            repeat
                                                                decPrest_ir_Out := decPrest_ir_Out + Abs(rHistLinhasMovEmp.Valor);
                                                            until rHistLinhasMovEmp.Next = 0;
                                                        end;

                                                    until rRubricaSalarial.Next = 0;
                                                end;
                                                //prest_ir_Out := CONVERTSTR(FORMAT(ROUND(decPrest_ir_Out,0.01)),',','.');

                                                prest_ir_Out := ConvertStr(DelChr(Format(Round(decPrest_ir_Out, 0.01)), '=', '.'), ',', '.'); //Normatica


                                                if prest_ir_Out = '0' then prest_ir_Out := '0.0';
                                            end;
                                        }
                                        textelement(r_supl_out)
                                        {
                                            XmlName = 'r_supl_Out';

                                            trigger OnBeforePassVariable()
                                            begin
                                                Clear(decR_supl_Out);
                                                Clear(decHoras_supl_Out);
                                                Clear(r_supl_Out);

                                                rRubricaSalarial.Reset;
                                                rRubricaSalarial.SetRange(rRubricaSalarial.Genero, rRubricaSalarial.Genero::"Hora Extra");
                                                if rRubricaSalarial.FindSet then begin
                                                    repeat
                                                        rHistLinhasMovEmp.Reset;
                                                        rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Tipo Processamento", rHistCabMovEmp."Tipo Processamento"::Vencimentos);
                                                        rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Data Registo", DMY2Date(1, 10, vAno),
                                                                                  DMY2Date(31, 10, vAno));
                                                        rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Employee No.", Empregado."No.");
                                                        rHistLinhasMovEmp.SetRange(rHistLinhasMovEmp."Cód. Rubrica", rRubricaSalarial.Código);
                                                        if rHistLinhasMovEmp.FindSet then begin
                                                            repeat
                                                                decR_supl_Out := decR_supl_Out + Abs(rHistLinhasMovEmp.Valor);
                                                                decHoras_supl_Out := decHoras_supl_Out + Abs(rHistLinhasMovEmp.Quantity);
                                                            until rHistLinhasMovEmp.Next = 0;
                                                        end;

                                                    until rRubricaSalarial.Next = 0;
                                                end;
                                                //r_supl_Out := CONVERTSTR(FORMAT(ROUND(decR_supl_Out,1)),',','.');
                                                r_supl_Out := ConvertStr(DelChr(Format(Round(decR_supl_Out, 0.01)), '=', '.'), ',', '.'); //Normatica

                                                if r_supl_Out = '0' then r_supl_Out := '0.0';
                                            end;
                                        }
                                        textelement(horas_supl_out)
                                        {
                                            XmlName = 'horas_supl_Out';

                                            trigger OnBeforePassVariable()
                                            begin
                                                horas_supl_Out := DelChr(Format(Round(decHoras_supl_Out, 0.01)), '=', ',');
                                            end;
                                        }
                                        textelement(t_horas_1art227)
                                        {
                                            XmlName = 't_horas_1art227';

                                            trigger OnBeforePassVariable()
                                            begin

                                                Clear(decT_horas_1art227);
                                                Clear(t_horas_1art227);

                                                rHistHorasExtra.Reset;
                                                rHistHorasExtra.SetRange(rHistHorasExtra.Data, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                rHistHorasExtra.SetRange(rHistHorasExtra."Employee No.", Empregado."No.");
                                                if rHistHorasExtra.FindSet then begin
                                                    repeat
                                                        rHorasExtra.Reset;
                                                        if (rHorasExtra.Get(rHistHorasExtra."Cód. Hora Extra")) and
                                                           (rHorasExtra."Lei n. 7/2009 de 12 Fevereiro" = rHorasExtra."Lei n. 7/2009 de 12 Fevereiro"::"No. 1 do Artigo 227") then
                                                            decT_horas_1art227 := decT_horas_1art227 + rHistHorasExtra.Quantity;
                                                    until rHistHorasExtra.Next = 0;
                                                end;


                                                t_horas_1art227 := DelChr(Format(Round(decT_horas_1art227, 1)), '=', ',');
                                            end;
                                        }
                                        textelement(t_horas_2art227)
                                        {
                                            XmlName = 't_horas_2art227';

                                            trigger OnBeforePassVariable()
                                            begin

                                                Clear(decT_horas_2art227);
                                                Clear(t_horas_2art227);

                                                rHistHorasExtra.Reset;
                                                rHistHorasExtra.SetRange(rHistHorasExtra.Data, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                                rHistHorasExtra.SetRange(rHistHorasExtra."Employee No.", Empregado."No.");
                                                if rHistHorasExtra.FindSet then begin
                                                    repeat
                                                        rHorasExtra.Reset;
                                                        if (rHorasExtra.Get(rHistHorasExtra."Cód. Hora Extra")) and
                                                           (rHorasExtra."Lei n. 7/2009 de 12 Fevereiro" = rHorasExtra."Lei n. 7/2009 de 12 Fevereiro"::"No. 2 do Artigo 227") then
                                                            decT_horas_2art227 := decT_horas_2art227 + rHistHorasExtra.Quantity;
                                                    until rHistHorasExtra.Next = 0;
                                                end;


                                                t_horas_2art227 := DelChr(Format(Round(decT_horas_2art227, 1)), '=', ',');
                                            end;
                                        }

                                        trigger OnPreXmlItem()
                                        begin
                                            Empregado.SetRange(Empregado.Estabelecimento, "Estabelecimentos da Empresa"."Número da Unidade Local");
                                            Empregado.SetFilter(Empregado."Employment Date", '<%1', DMY2Date(31, 10, vAno));
                                            Empregado.SetFilter(Empregado."End Date", '%1|>%2', 0D, DMY2Date(1, 10, vAno));
                                            //Normatica 2013.04.16
                                            Empregado.SetFilter(Empregado."Tipo Contribuinte", '<>%1', Empregado."Tipo Contribuinte"::"Trabalhador Independente");
                                            //IT001,sn
                                            if not Empregado.FindFirst then
                                                currXMLport.Break;
                                            //IT001,en
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
        rHistEmpregado: Record "Historico Empregado";
        rCompInf: Record "Company Information";
        rEstabelecimento: Record "Estabelecimentos da Empresa";
        rContratoEmpregado: Record "Contrato Empregado";
        rContrato: Record "Contrato Trabalho";
        rHorarioEmp: Record "Horário Empregado";
        rHistCabMovEmp: Record "Hist. Cab. Movs. Empregado";
        rHistLinhasMovEmp: Record "Hist. Linhas Movs. Empregado";
        rRubricaSalarial: Record "Rubrica Salarial";
        rHorasExtra: Record "Tipos Horas Extra";
        rHistHorasExtra: Record "Histórico Horas Extra";
        rCatProfQP: Record "Cat. Prof. QP Empregado";
        rQualificacaoEmp: Record "Qualificação Empregado";
        rEmpregado: Record Empregado;
        rHistAusencia: Record "Histórico Ausências";
        rMotAusencia: Record "Absence Reason";
        rRubricaSal: Record "Rubrica Salarial";
        TempMotHorasNRem: Record "Absence Reason" temporary;
        rConfRH: Record "Config. Recursos Humanos";
        cFuncoesRH: Codeunit "Funções RH";
        optSit_prof: Option ,"1","2","3","4","8";
        intRdt: Integer;
        intOrg_temp_trab: Integer;
        decSub_ref_Out: Decimal;
        decSub_turn_Out: Decimal;
        decOut_sub_Out: Decimal;
        decPrest_ir_Out: Decimal;
        decR_supl_Out: Decimal;
        decHoras_supl_Out: Decimal;
        decT_horas_1art227: Decimal;
        decT_horas_2art227: Decimal;
        vAno: Integer;
        optAplic_irct: Option "01","02","03","04","05","06","07";
        vConta: Integer;
        valor: Decimal;
        Filtro: Text[100];
        Text0001: Label 'Preencha o campo Organização do Tempo de trabalho, no horário do empregado %1.';
        Text0002: Label 'Preencha um horário para o empregado %1, para o mês de Outubro de %2.';
        Text0003: Label 'Preencha o campo Qualificação para o empregado %1.';
        Utils: Codeunit "PTSS Export SAF-T PT";
}

