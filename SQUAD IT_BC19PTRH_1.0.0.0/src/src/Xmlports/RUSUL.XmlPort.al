xmlport 53041 "RU - SUL"
{
    Encoding = UTF8;

    schema
    {
        textelement(entity_data)
        {
            textattribute(xmlns1)
            {
                XmlName = 'xmlns';

                trigger OnBeforePassVariable()
                begin
                    xmlns1 := 'http://www.gep.mtss.gov.pt/sguri/ru';
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
                    "xsi:schemaLocation" :=
                    'http://www.gep.mtss.gov.pt/sguri/ru relatorio-unico-1.0.xsd http://www.gep.mtss.gov.pt/sguri/sul sul-1.0.xsd'
                end;
            }
            textelement(active_estabs)
            {
                textattribute(year_ref)
                {

                    trigger OnBeforePassVariable()
                    begin
                        year_ref := Format(vAno);
                    end;
                }
                textelement(estabsees)
                {
                    XmlName = 'estabs';
                    textattribute(annexees)
                    {
                        XmlName = 'annex';

                        trigger OnBeforePassVariable()
                        begin
                            annexEeS := 'EeS';
                        end;
                    }
                    tableelement("estabelecimentos da empresa1"; "Estabelecimentos da Empresa")
                    {
                        XmlName = 'estab';
                        fieldattribute(id; "Estabelecimentos da Empresa1"."Número da Unidade Local")
                        {
                        }
                        textattribute(hq1)
                        {
                            XmlName = 'hq';

                            trigger OnBeforePassVariable()
                            begin
                                if "Estabelecimentos da Empresa1".Sede = true then
                                    hq1 := 'true'
                                else
                                    hq1 := 'false';
                            end;
                        }
                    }
                }
                textelement(estabsgre)
                {
                    XmlName = 'estabs';
                    textattribute(annexgre)
                    {
                        XmlName = 'annex';

                        trigger OnBeforePassVariable()
                        begin
                            annexGRE := 'GRE';
                        end;
                    }
                    tableelement("estabelecimentos da empresa2"; "Estabelecimentos da Empresa")
                    {
                        XmlName = 'estab';
                        fieldattribute(id; "Estabelecimentos da Empresa2"."Número da Unidade Local")
                        {
                        }
                        textattribute(hq2)
                        {
                            XmlName = 'hq';

                            trigger OnBeforePassVariable()
                            begin
                                if "Estabelecimentos da Empresa2".Sede = true then
                                    hq2 := 'true'
                                else
                                    hq2 := 'false';
                            end;
                        }
                    }
                }
                textelement(estabsqp)
                {
                    XmlName = 'estabs';
                    textattribute(annexqp)
                    {
                        XmlName = 'annex';

                        trigger OnBeforePassVariable()
                        begin
                            annexQP := 'QP';
                        end;
                    }
                    tableelement("estabelecimentos da empresa3"; "Estabelecimentos da Empresa")
                    {
                        XmlName = 'estab';
                        fieldattribute(id; "Estabelecimentos da Empresa3"."Número da Unidade Local")
                        {
                        }
                        textattribute(hq3)
                        {
                            XmlName = 'hq';

                            trigger OnBeforePassVariable()
                            begin
                                if "Estabelecimentos da Empresa3".Sede = true then
                                    hq3 := 'true'
                                else
                                    hq3 := 'false';
                            end;
                        }
                    }
                }
                textelement(estabssst)
                {
                    XmlName = 'estabs';
                    textattribute(annexsst)
                    {
                        XmlName = 'annex';

                        trigger OnBeforePassVariable()
                        begin
                            annexSST := 'SST';
                        end;
                    }
                    tableelement("estabelecimentos da empresa4"; "Estabelecimentos da Empresa")
                    {
                        XmlName = 'estab';
                        fieldattribute(id; "Estabelecimentos da Empresa4"."Número da Unidade Local")
                        {
                        }
                        textattribute(hq4)
                        {
                            XmlName = 'hq';

                            trigger OnBeforePassVariable()
                            begin
                                if "Estabelecimentos da Empresa4".Sede = true then
                                    hq4 := 'true'
                                else
                                    hq4 := 'false';
                            end;
                        }
                    }
                }
                textelement(estabszero)
                {
                    XmlName = 'estabs';
                    textattribute(annexzero)
                    {
                        XmlName = 'annex';

                        trigger OnBeforePassVariable()
                        begin
                            annexZERO := 'ZERO';
                        end;
                    }
                    tableelement("estabelecimentos da empresa5"; "Estabelecimentos da Empresa")
                    {
                        XmlName = 'estab';
                        fieldattribute(id; "Estabelecimentos da Empresa5"."Número da Unidade Local")
                        {
                        }
                        textattribute(hq5)
                        {
                            XmlName = 'hq';

                            trigger OnBeforePassVariable()
                            begin
                                if "Estabelecimentos da Empresa5".Sede = true then
                                    hq5 := 'true'
                                else
                                    hq5 := 'false';
                            end;
                        }
                    }
                }
            }
            tableelement("company information"; "Company Information")
            {
                XmlName = 'entity';
                textattribute(xmlns)
                {

                    trigger OnBeforePassVariable()
                    begin
                        xmlns := 'http://www.gep.mtss.gov.pt/sguri/sul';
                    end;
                }
                textelement(entity_id)
                {
                }
                fieldelement(nif; "Company Information"."VAT Registration No.")
                {
                }
                fieldelement(niss; "Company Information"."Social Security No.")
                {
                }
                fieldelement(name; "Company Information".Name)
                {
                }
                textelement(address)
                {
                    fieldelement(address; "Company Information".Address)
                    {
                    }
                    fieldelement(location; "Company Information".Local)
                    {
                    }
                    fieldelement(zipcode; "Company Information"."Post Code")
                    {
                    }
                    fieldelement(zipcode_description; "Company Information".City)
                    {
                    }
                }
                fieldelement(dcf; "Company Information"."Cód. Distrito/Concelho/Freg.")
                {
                    textattribute(tbl)
                    {

                        trigger OnBeforePassVariable()
                        begin
                            tbl := 'RU_DCF';
                        end;
                    }
                }
                fieldelement(dcf_description; "Company Information".Parish)
                {
                }
                fieldelement(country; "Company Information"."Country/Region Code")
                {
                    textattribute(tbl1)
                    {
                        XmlName = 'tbl';

                        trigger OnBeforePassVariable()
                        begin
                            tbl1 := 'RU_CODPAIS';
                        end;
                    }
                }
                fieldelement(phone; "Company Information"."Phone No.")
                {
                }
                fieldelement(email; "Company Information"."E-Mail")
                {
                }
                fieldelement(cae; "Company Information"."PTSS CAE Code")
                {
                    textattribute(tbl2)
                    {
                        XmlName = 'tbl';

                        trigger OnBeforePassVariable()
                        begin
                            tbl2 := 'RU_CAE_5DIG';
                        end;
                    }
                }
                fieldelement(cae_description; "Company Information"."PTSS CAE Description")
                {
                }
                textelement(statusempresa)
                {
                    XmlName = 'status';
                    textattribute(tbl3)
                    {
                        XmlName = 'tbl';

                        trigger OnBeforePassVariable()
                        begin
                            tbl3 := 'XXX';
                        end;
                    }
                }
                textelement(status_descriptionempresa)
                {
                    XmlName = 'status_description';
                }
                fieldelement(ln; "Company Information"."Legal Nature Code")
                {
                    textattribute(tbl4)
                    {
                        XmlName = 'tbl';

                        trigger OnBeforePassVariable()
                        begin
                            tbl4 := 'RU_NATJUR';
                        end;
                    }
                }
                fieldelement(ln_description; "Company Information"."Legal Nature")
                {
                }
                textelement(est_date)
                {

                    trigger OnBeforePassVariable()
                    begin
                        est_date := Format("Company Information"."Constitution Date", 0, '<year4>-<month,2>');
                    end;
                }
                textelement(employeesempresa)
                {
                    XmlName = 'employees';
                }
                textelement(tcosempresa)
                {
                    XmlName = 'tcos';
                }
                textelement(estabs)
                {
                    tableelement("estabelecimentos da empresa"; "Estabelecimentos da Empresa")
                    {
                        XmlName = 'estab';
                        fieldelement(estab_id; "Estabelecimentos da Empresa"."Número da Unidade Local")
                        {
                        }
                        textelement(hq)
                        {
                            XmlName = 'hq';

                            trigger OnBeforePassVariable()
                            begin
                                if "Estabelecimentos da Empresa".Sede = true then
                                    hq := 'true'
                                else
                                    hq := 'false';
                            end;
                        }
                        textelement(num)
                        {
                        }
                        fieldelement(nif; "Company Information"."VAT Registration No.")
                        {
                        }
                        fieldelement(name; "Estabelecimentos da Empresa"."Descrição")
                        {
                        }
                        textelement("<address1")
                        {
                            XmlName = 'address';
                            fieldelement(address; "Estabelecimentos da Empresa".Morada)
                            {
                            }
                            fieldelement(location; "Estabelecimentos da Empresa".Localidade)
                            {
                            }
                            fieldelement(zipcode; "Estabelecimentos da Empresa"."Cód. Postal")
                            {
                            }
                            fieldelement(zipcode_description; "Estabelecimentos da Empresa".Cidade)
                            {
                            }
                            fieldelement(dcf; "Estabelecimentos da Empresa"."Cód. Distrito/Concelho/Freg.")
                            {
                                textattribute(tbl5)
                                {
                                    XmlName = 'tbl';

                                    trigger OnBeforePassVariable()
                                    begin
                                        tbl5 := 'RU_DCF';
                                    end;
                                }
                            }
                            fieldelement(dcf_description; "Estabelecimentos da Empresa"."Descrição Freguesia")
                            {
                            }
                            fieldelement(country; "Estabelecimentos da Empresa"."País")
                            {
                                textattribute(tbl6)
                                {
                                    XmlName = 'tbl';

                                    trigger OnBeforePassVariable()
                                    begin
                                        tbl6 := 'RU_CODPAIS';
                                    end;
                                }
                            }
                            textelement(country_description)
                            {
                            }
                            fieldelement(phone; "Estabelecimentos da Empresa".Telefone)
                            {
                            }
                            fieldelement(email; "Estabelecimentos da Empresa"."E-mail")
                            {
                            }
                            fieldelement(cae; "Estabelecimentos da Empresa"."CAE Code")
                            {
                                textattribute(tbl7)
                                {
                                    XmlName = 'tbl';

                                    trigger OnBeforePassVariable()
                                    begin
                                        tbl7 := 'RU_CAE_5DIG';
                                    end;
                                }
                            }
                            fieldelement(cae_description; "Estabelecimentos da Empresa"."CAE Description")
                            {
                            }
                            fieldelement(start_date; "Estabelecimentos da Empresa"."Data Inicio")
                            {
                            }
                            textelement(status)
                            {
                                textattribute(tbl8)
                                {
                                    XmlName = 'tbl';
                                }
                            }
                            textelement(status_description)
                            {
                            }
                            textelement(employees)
                            {
                            }
                            textelement(tcos)
                            {
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
        vAno := Date2DMY(WorkDate, 3) - 1;
    end;

    var
        vAno: Integer;
}

