xmlport 53042 "RU - Anexo F - IPS"
{
    Encoding = UTF8;

    schema
    {
        textelement("ru:relatorio_unico")
        {
            textattribute(XML_DATA)
            {

                trigger OnBeforePassVariable()
                begin
                    XML_DATA := '3.2.0';
                end;
            }
            textattribute("xmlns:ru")
            {

                trigger OnBeforePassVariable()
                begin
                    "xmlns:ru" := 'http://www.gee.min-economia.pt/sguri/ru';
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

                    "xsi:schemaLocation" := 'http://www.gee.min-economia.pt/sguri/ru relatorio-ips-3.2.xsd ';
                    "xsi:schemaLocation" += 'http://www.gee.min-economia.pt/sguri/tipos_comuns tipos-comus-1.3.xsd';
                    "xsi:schemaLocation" += 'http://www.gee.min-economia.pt/sguri/ru/anexo_ips anexo-ips-1.0.xsd';
                end;
            }
            textelement("ru:header")
            {
                textelement("ru:aplicacao")
                {
                    textelement("ru:nome")
                    {

                        trigger OnBeforePassVariable()
                        begin
                            "ru:nome" := 'Microsoft Dynamics NAV';
                        end;
                    }
                    textelement("ru:versao")
                    {

                        trigger OnBeforePassVariable()
                        begin
                            "ru:versao" := '5.1.0';
                        end;
                    }
                    textelement("ru:empresa")
                    {

                        trigger OnBeforePassVariable()
                        begin
                            "ru:empresa" := rCompInf.Name;
                        end;
                    }
                }
            }
            textelement("ru:body")
            {
                textelement("ru:anexos")
                {
                    textelement(anexo_ips)
                    {
                        textattribute(xmlns)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                xmlns := 'http://www.gep.mtss.gov.pt/sguri/ru/anexo_fest';
                            end;
                        }
                        textattribute(xml_data1)
                        {
                            XmlName = 'XML_DATA';

                            trigger OnBeforePassVariable()
                            begin
                                XML_DATA1 := '1.1.0';
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
                        textelement(exist_prest_serv)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                exist_prest_serv := 'N';

                                rEmpregado.Reset;
                                rEmpregado.SetRange(rEmpregado."Tipo Contribuinte", rEmpregado."Tipo Contribuinte"::"Trabalhador Independente");
                                rEmpregado.SetRange(rEmpregado."Employment Date", DMY2Date(1, 1, vAno), DMY2Date(31, 12, vAno));
                                if rEmpregado.FindFirst then
                                    exist_prest_serv := 'S';
                            end;
                        }
                        textelement(dados_ips)
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
                            textelement(prestadores)
                            {
                                tableelement(empregado; Empregado)
                                {
                                    XmlName = 'prestador';
                                    SourceTableView = WHERE("Tipo Contribuinte" = CONST("Trabalhador Independente"));
                                    fieldelement(nif; Empregado."No. Contribuinte")
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
                                    textelement(tipo)
                                    {
                                        textattribute(tbl_tipo)
                                        {
                                            XmlName = 'tbl';

                                            trigger OnBeforePassVariable()
                                            begin
                                                tbl_tipo := 'RU_TPREST';
                                            end;
                                        }

                                        trigger OnBeforePassVariable()
                                        begin
                                            tipo := '1'; // 1-singular   2-coletivo
                                        end;
                                    }
                                    textelement(tipo_activ)
                                    {
                                        textattribute(tbl_tipo_activ)
                                        {
                                            XmlName = 'tbl';

                                            trigger OnBeforePassVariable()
                                            begin
                                                tbl_tipo_activ := 'RU_TACTIV';
                                            end;
                                        }

                                        trigger OnBeforePassVariable()
                                        begin
                                            tipo_activ := '2';   // 1-CAE   2-CIRS
                                        end;
                                    }
                                    textelement(cirs)
                                    {
                                        textattribute(tbl_cae)
                                        {
                                            XmlName = 'tbl';
                                        }
                                    }
                                    textelement(prestacoes)
                                    {
                                        tableelement("<contrato empregado>"; "Contrato Empregado")
                                        {
                                            XmlName = 'prestacao';
                                            fieldelement(data_inicio; "<Contrato Empregado>"."Data Inicio Contrato")
                                            {
                                            }
                                            fieldelement(data_fim; "<Contrato Empregado>"."Data Fim Contrato")
                                            {
                                            }
                                            textelement(num_horas)
                                            {
                                            }
                                        }

                                        trigger OnBeforePassVariable()
                                        begin
                                            "<Contrato Empregado>".SetRange("<Contrato Empregado>"."Cód. Empregado", Empregado."No.");
                                        end;
                                    }

                                    trigger OnPreXmlItem()
                                    begin
                                        rEmpregado.Reset;
                                        rEmpregado.ModifyAll(rEmpregado.Marcado, false);
                                        rEmpregado.Reset;
                                        if rEmpregado.FindSet(true, false) then begin
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
        rEmpregado: Record Employee;
        rCompInf: Record "Company Information";
        rContratoEmpregado: Record "Contrato Empregado";
        rContrato: Record "Contrato Trabalho";
        rHistHorasExtra: Record "Histórico Horas Extra";
        rHorasExtra: Record "Tipos Horas Extra";
        TempEmpregado: Record Employee temporary;
        rConfRH: Record "Config. Recursos Humanos";
        optSit_prof: Option ,"1","2","3","4","8";
        vAno: Integer;
        dec_horas_1art227: Decimal;
        dec_horas_2art227: Decimal;
}

