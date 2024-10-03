xmlport 53037 "RU - Anexo B - FEST"
{
    Encoding = UTF8;
    Namespaces = ru = 'http://www.gep.mtss.gov.pt/sguri/ru',
                 xsi = 'http://www.w3.org/2001/XMLSchema-instance';

    schema
    {
        textelement("relatorio_unico")
        //textelement(ru)
        {
            NamespacePrefix = 'ru';
            //XmlName = 'ru:relatorio_unico';
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
                    "xsi:schemaLocation" := 'http://www.gep.mtss.gov.pt/sguri/ru relatorio-fest-3.3.0.xsd ';
                    "xsi:schemaLocation" += 'http://www.gep.mtss.gov.pt/sguri/ru/anexo_fest/anexo-fest-1.4.0.xsd';
                end;
            }
            textelement("header")
            {
                NamespacePrefix = 'ru';
                textelement("aplicacao")
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
                    textelement(anexo_fest)
                    {
                        textattribute(xmlns)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                //xmlns2 := 'http://www.gep.mtss.gov.pt/sguri/ru/anexo_fest';
                            end;
                        }
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
                                nome_entidade := rCompInf.Name;
                            end;
                        }
                        textelement(exist_entradas_saidas)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                exist_entradas_saidas := 'N';

                                rEmpregado.Reset;
                                rEmpregado.SetRange(rEmpregado."Tipo Contribuinte", rEmpregado."Tipo Contribuinte"::"Conta de Outrem");
                                rEmpregado.SetRange(rEmpregado."Employment Date", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                if rEmpregado.FindFirst then
                                    exist_entradas_saidas := 'S';

                                rEmpregado.Reset;
                                rEmpregado.SetRange(rEmpregado."Tipo Contribuinte", rEmpregado."Tipo Contribuinte"::"Conta de Outrem");
                                rEmpregado.SetRange(rEmpregado."End Date", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                if rEmpregado.FindFirst then
                                    exist_entradas_saidas := 'S';
                            end;
                        }
                        textelement(dados_fest)
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
                            textelement(trabalhadores)
                            {
                                tableelement(empregado; Empregado)
                                {
                                    XmlName = 'trabalhador';
                                    MinOccurs = Zero;
                                    SourceTableView = WHERE("Tipo Contribuinte" = CONST("Conta de Outrem"));
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

                                        trigger OnBeforePassField()
                                        begin
                                            Empregado.TestField(Empregado."Cod. Regime Reforma Aplicado");
                                        end;
                                    }
                                    fieldelement(niss; Empregado."No. Segurança Social")
                                    {
                                    }
                                    fieldelement(nome; Empregado.Name)
                                    {
                                    }
                                    textelement(tipo_contrato)
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
                                            Clear(tipo_contrato);
                                            rContratoEmpregado.Reset;
                                            rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", Empregado."No.");
                                            if (Empregado."End Date" >= DMY2Date(1, 1, vAno)) and (Empregado."End Date" <= DMY2Date(31, 12, vAno)) then begin
                                                rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', Empregado."End Date");
                                                rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '>=%1|=%2', Empregado."End Date", 0D);
                                            end;
                                            if (Empregado."Employment Date" >= DMY2Date(1, 1, vAno)) and (Empregado."Employment Date" <= DMY2Date(31, 12, vAno)) then begin
                                                rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', Empregado."Employment Date");
                                                rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '>=%1|=%2', Empregado."Employment Date", 0D);
                                            end;
                                            if rContratoEmpregado.FindFirst then begin
                                                rContrato.Reset;
                                                if rContrato.Get(rContratoEmpregado."Cód. Contrato") then begin
                                                    rContrato.TestField(rContrato."Cód. Tipo Contrato");
                                                    tipo_contrato := Format(rContrato."Cód. Tipo Contrato");
                                                end;
                                            end;
                                        end;
                                    }
                                    textelement(entrada)
                                    {
                                        textelement(data_entrada)
                                        {
                                            XmlName = 'data';

                                            trigger OnBeforePassVariable()
                                            begin
                                                Clear(data_entrada);
                                                if (Empregado."Employment Date" >= DMY2Date(1, 1, vAno)) and (Empregado."Employment Date" <= DMY2Date(31, 12, vAno)) then begin
                                                    Empregado.TestField(Empregado."Employment Date");
                                                    data_entrada := Format(Empregado."Employment Date", 0, '<year4>-<Month,2>');

                                                end;
                                            end;
                                        }
                                        textelement(motivo_entrada)
                                        {
                                            XmlName = 'motivo';
                                            textattribute(tbl_motivo_entrada)
                                            {
                                                XmlName = 'tbl';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    tbl_motivo_entrada := 'RU_MEEE';
                                                end;
                                            }

                                            trigger OnBeforePassVariable()
                                            begin
                                                Clear(motivo_entrada);
                                                if (Empregado."Employment Date" >= DMY2Date(1, 1, vAno)) and (Empregado."Employment Date" <= DMY2Date(31, 12, vAno)) then begin
                                                    rContratoEmpregado.Reset;
                                                    rContratoEmpregado.SetRange(rContratoEmpregado."Cód. Empregado", Empregado."No.");
                                                    rContratoEmpregado.SetFilter(rContratoEmpregado."Data Inicio Contrato", '<=%1', Empregado."Employment Date");
                                                    rContratoEmpregado.SetFilter(rContratoEmpregado."Data Fim Contrato", '>=%1|=%2', Empregado."Employment Date", 0D);
                                                    rContratoEmpregado.SetRange(rContratoEmpregado."Tipo Contrato", rContratoEmpregado."Tipo Contrato"::"A Termo");
                                                    if rContratoEmpregado.FindFirst then begin
                                                        rContratoEmpregado.TestField(rContratoEmpregado."Motivo Entrada");
                                                        motivo_entrada := Format(rContratoEmpregado."Motivo Entrada")
                                                    end else
                                                        motivo_entrada := '';
                                                end;
                                            end;
                                        }
                                    }
                                    textelement(saida)
                                    {
                                        textelement(data_saida)
                                        {
                                            XmlName = 'data';

                                            trigger OnBeforePassVariable()
                                            begin
                                                Clear(data_saida);
                                                if (Empregado."End Date" >= DMY2Date(1, 1, vAno)) and (Empregado."End Date" <= DMY2Date(31, 12, vAno)) then begin
                                                    Empregado.TestField(Empregado."End Date");
                                                    data_saida := Format(Empregado."End Date", 0, '<year4>-<Month,2>');
                                                end;
                                            end;
                                        }
                                        textelement(motivo_saida)
                                        {
                                            XmlName = 'motivo';
                                            textattribute(tbl_motivo_saida)
                                            {
                                                XmlName = 'tbl';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    tbl_motivo_saida := 'RU_MSEE';
                                                end;
                                            }

                                            trigger OnBeforePassVariable()
                                            begin
                                                Clear(motivo_saida);
                                                if (Empregado."End Date" >= DMY2Date(1, 1, vAno)) and (Empregado."End Date" <= DMY2Date(31, 12, vAno)) then begin
                                                    Empregado.TestField(Empregado."Motivo de Terminação");
                                                    motivo_saida := Format(Empregado."Motivo de Terminação");
                                                end;
                                            end;
                                        }
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
                                            Clear(sit_prof);
                                            Clear(optSit_prof);
                                            optSit_prof := Empregado."Situação Profissional";
                                            sit_prof := Format(optSit_prof);
                                        end;
                                    }
                                    fieldelement(prof; Empregado."Class. Nac. Profi.")
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
                                    textelement(h_1art227)
                                    {

                                        trigger OnBeforePassVariable()
                                        var
                                            dec_horas_1art227: Decimal;
                                        begin
                                            Clear(dec_horas_1art227);
                                            rHistHorasExtra.Reset;
                                            rHistHorasExtra.SetRange(rHistHorasExtra.Data, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                            rHistHorasExtra.SetRange(rHistHorasExtra."No. Empregado", Empregado."No.");
                                            if rHistHorasExtra.FindSet then begin
                                                repeat
                                                    rHorasExtra.Reset;
                                                    if (rHorasExtra.Get(rHistHorasExtra."Cód. Hora Extra")) and
                                                       (rHorasExtra."Lei n. 7/2009 de 12 Fevereiro" = rHorasExtra."Lei n. 7/2009 de 12 Fevereiro"::"No. 1 do Artigo 227") then
                                                        dec_horas_1art227 := dec_horas_1art227 + rHistHorasExtra.Quantidade;
                                                until rHistHorasExtra.Next = 0;
                                            end;


                                            h_1art227 := DelChr(Format(Round(dec_horas_1art227, 1)), '=', ',');
                                        end;
                                    }
                                    textelement(h_2art227)
                                    {

                                        trigger OnBeforePassVariable()
                                        begin
                                            Clear(dec_horas_2art227);
                                            rHistHorasExtra.Reset;
                                            rHistHorasExtra.SetRange(rHistHorasExtra.Data, DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                            rHistHorasExtra.SetRange(rHistHorasExtra."No. Empregado", Empregado."No.");
                                            if rHistHorasExtra.FindSet then begin
                                                repeat
                                                    rHorasExtra.Reset;
                                                    if (rHorasExtra.Get(rHistHorasExtra."Cód. Hora Extra")) and
                                                       (rHorasExtra."Lei n. 7/2009 de 12 Fevereiro" = rHorasExtra."Lei n. 7/2009 de 12 Fevereiro"::"No. 2 do Artigo 227") then
                                                        dec_horas_2art227 := dec_horas_2art227 + rHistHorasExtra.Quantidade;
                                                until rHistHorasExtra.Next = 0;
                                            end;


                                            h_2art227 := DelChr(Format(Round(dec_horas_2art227, 1)), '=', ',');
                                        end;
                                    }

                                    trigger OnPreXmlItem()
                                    begin
                                        rEmpregado.Reset;
                                        rEmpregado.ModifyAll(rEmpregado.Marcado, false);
                                        rEmpregado.Reset;
                                        if rEmpregado.FindSet then begin
                                            repeat
                                                if (rEmpregado."Employment Date" >= DMY2Date(1, 1, vAno)) and (rEmpregado."Employment Date" <= DMY2Date(31, 12, vAno)) then
                                                    rEmpregado.Marcado := true;
                                                if (rEmpregado."End Date" >= DMY2Date(1, 1, vAno)) and (rEmpregado."End Date" <= DMY2Date(31, 12, vAno)) then
                                                    rEmpregado.Marcado := true;
                                                rEmpregado.Modify;
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
    end;

    var
        rEmpregado: Record Empregado;
        rCompInf: Record "Company Information";
        rContratoEmpregado: Record "Contrato Empregado";
        rContrato: Record "Contrato Trabalho";
        rHistHorasExtra: Record "Histórico Horas Extra";
        rHorasExtra: Record "Tipos Horas Extra";
        TempEmpregado: Record Empregado temporary;
        rConfRH: Record "Config. Recursos Humanos";
        optSit_prof: Option ,"1","2","3","4","8";
        vAno: Integer;
        dec_horas_1art227: Decimal;
        dec_horas_2art227: Decimal;
        Utils: Codeunit "PTSS Export SAF-T PT";
}

