pageextension 53040 "Employee Card Ext" extends "Employee Card"
{
    //TODO: Check the order of fields(group etc.)
    layout
    {
        addafter("No.")
        {
            field(Name; Rec.Name)
            {
                ApplicationArea = All;
                Style = Strong;
                StyleExpr = TRUE;
            }
        }
        addafter("Address 2")
        {
            field(Locality; Rec.Locality)
            {
                ApplicationArea = All;
            }
        }
        addafter(City)
        {
            field("Cod. Freguesia"; Rec."Cod. Freguesia")
            {
                ApplicationArea = All;
            }
            field(Freguesia; Rec.Freguesia)
            {
                ApplicationArea = All;
            }
        }
        addafter("Job Title")
        {
            field("Tipo Empregado"; Rec."Tipo Empregado")
            {
                ApplicationArea = All;
            }
        }
        addafter("Last Date Modified")
        {
            field("No. antigo do Empregado"; Rec."No. antigo do Empregado")
            {
                ApplicationArea = All;
            }
            field("NAV User Id"; Rec."NAV User Id")
            {
                ApplicationArea = All;
            }
            field(Docente; Rec.Docente)
            {
                ApplicationArea = All;
            }
            field("Nº Professor"; Rec."Nº Professor")
            {
                ApplicationArea = All;
            }
            field("Exportar para o MISI"; Rec."Exportar para o MISI")
            {
                ApplicationArea = All;
            }
            field(Intern; Rec.Intern)
            {
                ApplicationArea = All;
            }
            field("Orgão Social"; Rec."Orgão Social")
            {
                ApplicationArea = All;
            }
            group("Comunicação")
            {
                Caption = 'Communication';
                field(CompanyMobilePhoneNo; Rec.CompanyMobilePhoneNo)
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Envio Recibo via E-Mail"; Rec."Envio Recibo via E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Endereço de Envio"; Rec."Endereço de Envio")
                {
                    ApplicationArea = All;
                }
            }
            group("Administração")
            {
                Caption = 'Administration';
                field(Estabelecimento; Rec.Estabelecimento)
                {
                    ApplicationArea = All;
                }
                field(Seguradora; Rec.Seguradora)
                {
                    ApplicationArea = All;
                }
                field("No. Apólice"; Rec."No. Apólice")
                {
                    ApplicationArea = All;
                }
                field("Data de Antiguidade"; Rec."Data de Antiguidade")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Motivo de Terminação"; Rec."Motivo de Terminação")
                {
                    ApplicationArea = All;
                }
                field("Cod. Regime Reforma Aplicado"; Rec."Cod. Regime Reforma Aplicado")
                {
                    ApplicationArea = All;
                }
                field("Regime Reforma Aplicado"; Rec."Regime Reforma Aplicado")
                {
                    ApplicationArea = All;
                }
                field("Usa Transf. Bancária"; Rec."Usa Transf. Bancária")
                {
                    ApplicationArea = All;
                }
                field("Cód. Banco Transf."; Rec."Cód. Banco Transf.")
                {
                    ApplicationArea = All;
                }
                field(Pagamento; Rec.Pagamento)
                {
                    ApplicationArea = All;
                }
                field("Nome Livro Diario Pag."; Rec."Nome Livro Diario Pag.")
                {
                    ApplicationArea = All;
                }
                field("Secção Diario Pag."; Rec."Secção Diario Pag.")
                {
                    ApplicationArea = All;

                }
                field("Conta Pag."; Rec."Conta Pag.")
                {
                    ApplicationArea = All;

                }
                field("NIB Cartao Ref"; Rec."NIB Cartao Ref")
                {
                }
            }
            group(Pessoal)
            {

                Caption = 'Personal';
                field(Naturalidade; Rec."Birth Date")
                {
                    ApplicationArea = All;

                }
                field("Naturalidade - Concelho"; Rec."Naturalidade - Concelho")
                {
                    ApplicationArea = All;

                }
                field(Nacionalidade; Rec.Nacionalidade)
                {
                    ApplicationArea = All;

                }
                field("Nacionalidade Descrição"; Rec."Nacionalidade Descrição")
                {
                    ApplicationArea = All;

                }
                field("Documento Identificação"; Rec."Documento Identificação")
                {
                    ApplicationArea = All;

                    Importance = Promoted;
                }
                field("No. Doc. Identificação"; Rec."No. Doc. Identificação")
                {
                    ApplicationArea = All;

                    Importance = Promoted;
                }
                field("Local Emissão Doc. Ident."; Rec."Local Emissão Doc. Ident.")
                {
                    ApplicationArea = All;

                }
                field("Data Doc. Ident."; Rec."Data Doc. Ident.")
                {
                    ApplicationArea = All;

                }
                field("Data Validade Doc. Ident."; Rec."Data Validade Doc. Ident.")
                {
                    ApplicationArea = All;

                }
                field("Vitalício"; Rec."Vitalício")
                {
                    ApplicationArea = All;

                }
            }
            group(IRS)
            {

                field("No. Contribuinte"; Rec."No. Contribuinte")
                {
                    ApplicationArea = All;

                    Importance = Promoted;
                }
                field("Tipo Contribuinte"; Rec."Tipo Contribuinte")
                {
                    ApplicationArea = All;

                    Importance = Promoted;
                }
                field("Cod. Repartição Finanças"; Rec."Cod. Repartição Finanças")
                {
                    ApplicationArea = All;

                }
                field("Repartição Finanças"; Rec."Repartição Finanças")
                {
                    ApplicationArea = All;

                }
                field("Data Emissão NIF"; Rec."Data Emissão NIF")
                {
                    ApplicationArea = All;

                }
                field("Tipo Rendimento"; Rec."Tipo Rendimento")
                {
                    ApplicationArea = All;

                }
                field("Local Obtenção Rendimento"; Rec."Local Obtenção Rendimento")
                {
                    ApplicationArea = All;

                }
                field("Estado Civil"; Rec."Estado Civil")
                {
                    ApplicationArea = All;

                }
                field("Civil State Date"; Rec."Civil State Date")
                {
                    ApplicationArea = All;

                }
                field("Titular Rendimentos"; Rec."Titular Rendimentos")
                {
                    ApplicationArea = All;

                }
                field(Deficiente; Rec.Deficiente)
                {
                    ApplicationArea = All;

                }
                field("Conjuge Deficiente"; Rec."Conjuge Deficiente")
                {
                    ApplicationArea = All;

                }
                field("No. Dependentes"; Rec."No. Dependentes")
                {
                    ApplicationArea = All;

                }
                field("No. Dependentes Deficientes"; Rec."No. Dependentes Deficientes")
                {
                    ApplicationArea = All;

                }
                field("Tabela IRS"; Rec."Tabela IRS")
                {
                    ApplicationArea = All;

                    Caption = 'Tabela IRS';
                    Editable = false;
                }
                field("Descrição Tabela IRS"; Rec."Descrição Tabela IRS")
                {
                    ApplicationArea = All;

                    Editable = false;
                }
                field("IRS %"; Rec."IRS %")
                {
                    ApplicationArea = All;

                    Editable = false;
                }
                field("IRS % Fixa"; Rec."IRS % Fixa")
                {
                    ApplicationArea = All;

                }
                field("IVA %"; Rec."IVA %")
                {
                    ApplicationArea = All;

                }
            }
            group("Seg. Social")
            {

                field("Subscritor SS"; Rec."Subscritor SS")
                {
                    ApplicationArea = All;

                }
                field("No. Segurança Social"; Rec."No. Segurança Social")
                {
                    ApplicationArea = All;

                    Importance = Promoted;
                }
                field("Data da Admissão SS"; Rec."Data da Admissão SS")
                {
                    ApplicationArea = All;

                }
                field("Data Emissão SS"; Rec."Data Emissão SS")
                {
                    ApplicationArea = All;

                }
                field("Cod. Instituição SS"; Rec."Cod. Instituição SS")
                {
                    ApplicationArea = All;

                }
                field("Cod. Regime SS"; Rec."Cod. Regime SS")
                {
                    ApplicationArea = All;

                }
                field("Cód. Rúbrica Enc. Seg. Social"; Rec."Cód. Rúbrica Enc. Seg. Social")
                {
                    ApplicationArea = All;

                }
            }
            group(CGA)
            {
                Caption = 'CGA';
                field("Subsccritor CGA"; Rec."Subsccritor CGA")
                {
                    ApplicationArea = All;

                }
                field("Nº CGA"; Rec."Nº CGA")
                {
                    ApplicationArea = All;

                }
                field("Data da Admissão CGA"; Rec."Data da Admissão CGA")
                {
                    ApplicationArea = All;

                }
                field("Data de Emissão CGA"; Rec."Data de Emissão CGA")
                {
                    ApplicationArea = All;

                }
                field("Nº Horas Docência Calc. Desct."; Rec."Nº Horas Docência Calc. Desct.")
                {
                    ApplicationArea = All;

                }
                field("Professor Acumulação"; Rec."Professor Acumulação")
                {
                    ApplicationArea = All;

                }
                field("CGA - Requisição"; Rec."CGA - Requisição")
                {
                    ApplicationArea = All;

                }
                field("Cód. Rúbrica Enc. CGA"; Rec."Cód. Rúbrica Enc. CGA")
                {
                    ApplicationArea = All;

                }
            }
            group(ADSE)
            {
                Caption = 'ADSE';
                field("Subscritor ADSE"; Rec."Subscritor ADSE")
                {
                    ApplicationArea = All;

                }
                field("Nº ADSE"; Rec."Nº ADSE")
                {
                    ApplicationArea = All;

                }
                field("Data da Admissão ADSE"; Rec."Data da Admissão ADSE")
                {
                    ApplicationArea = All;

                }
                field("Data de Emissão ADSE"; Rec."Data de Emissão ADSE")
                {
                    ApplicationArea = All;

                }
                field("Cód. Rúbrica Enc. ADSE"; Rec."Cód. Rúbrica Enc. ADSE")
                {
                    ApplicationArea = All;

                }
            }
            group(Processamentos)
            {
                Caption = 'Processing';
                field("Valor Vencimento Base"; Rec."Valor Vencimento Base")
                {
                    ApplicationArea = All;

                    Editable = false;
                    Importance = Promoted;
                }
                field("Valor Dia"; Rec."Valor Dia")
                {
                    ApplicationArea = All;

                    Editable = false;
                }
                field("Valor Hora"; Rec."Valor Hora")
                {
                    ApplicationArea = All;

                    Editable = false;
                }
                field("No. Horas Semanais"; Rec."No. Horas Semanais")
                {
                    ApplicationArea = All;

                    Caption = 'Week Hours No.';
                }
                field("No. Horas Semanais Totais"; Rec."No. Horas Semanais Totais")
                {
                    ApplicationArea = All;

                }
                field("No. dias de Trabalho Semanal"; Rec."No. dias de Trabalho Semanal")
                {
                    ApplicationArea = All;

                }
                field("No. Dias Trabalho Mensal"; Rec."No. Dias Trabalho Mensal")
                {
                    ApplicationArea = All;

                }
                field("Mês Proc. Sub. Férias"; Rec."Mês Proc. Sub. Férias")
                {
                    ApplicationArea = All;

                }
                field("Última data Proc. Sub. Férias"; Rec."Última data Proc. Sub. Férias")
                {
                    ApplicationArea = All;

                }
                field("Vacation Balance"; Rec."Vacation Balance")
                {
                    ApplicationArea = All;

                }
            }
            group(Categoria)
            {
                Caption = 'Category';
                field("Cód. IRCT"; Rec."Cód. IRCT")
                {
                    ApplicationArea = All;

                }
                field("Acordo Colectivo"; Rec."Acordo Colectivo")
                {
                    ApplicationArea = All;

                }
                field("Descrição IRCT"; Rec."Descrição IRCT")
                {
                    ApplicationArea = All;

                }
                field("Aplicabilidade do IRCT"; Rec."Aplicabilidade do IRCT")
                {
                    ApplicationArea = All;

                }
                field("Cód. Cat. Profissional"; Rec."Cód. Cat. Profissional")
                {
                    ApplicationArea = All;

                    Editable = false;
                    Enabled = false;
                }
                field("Descrição Cat Prof"; Rec."Descrição Cat Prof")
                {
                    ApplicationArea = All;

                    Editable = false;
                    Enabled = false;
                }
                field("Cód. Cat. Prof QP"; Rec."Cód. Cat. Prof QP")
                {
                    ApplicationArea = All;

                    Editable = false;
                    Enabled = false;
                }
                field("Descrição Cat Prof QP"; Rec."Descrição Cat Prof QP")
                {
                    ApplicationArea = All;

                    Editable = false;
                    Enabled = false;
                }
                field("Class. Nac. Profi."; Rec."Class. Nac. Profi.")
                {
                    ApplicationArea = All;

                }
                field("Descrição Class. Nac."; Rec."Descrição Class. Nac.")
                {
                    ApplicationArea = All;

                }
                field("Cód. Habilitações"; Rec."Cód. Habilitações")
                {
                    ApplicationArea = All;

                }
                field("Descrição Habilitações"; Rec."Descrição Habilitações")
                {
                    ApplicationArea = All;

                }
                field("Qualificação"; Rec."Qualificação")
                {
                    ApplicationArea = All;

                }
                field("Formação-Situação face à freq."; Rec."Formação-Situação face à freq.")
                {
                    ApplicationArea = All;

                }
                field("Situação Profissional"; Rec."Situação Profissional")
                {
                    ApplicationArea = All;

                }
                field("Regime Duração Trabalho"; Rec."Regime Duração Trabalho")
                {
                    ApplicationArea = All;

                }
                field("Duração do Tempo de Trabalho"; Rec."Duração do Tempo de Trabalho")
                {
                    ApplicationArea = All;

                }
                field("Desc. Duração Tempo Trabalho"; Rec."Desc. Duração Tempo Trabalho")
                {
                    ApplicationArea = All;

                }
                field("Cód. Horário"; Rec."Cód. Horário")
                {
                    ApplicationArea = All;

                    Editable = false;
                    Enabled = false;
                }
                field(Control1000000048; Rec."Grau Função")
                {
                    ApplicationArea = All;

                }
                field("Descrição Grau Função"; Rec."Descrição Grau Função")
                {
                    ApplicationArea = All;

                }
                field("Grau Função-Efeitos Progres."; Rec."Grau Função-Efeitos Progres.")
                {
                    ApplicationArea = All;

                }
                field("Descrição Grau Função Progr."; Rec."Descrição Grau Função Progr.")
                {
                    ApplicationArea = All;

                }
                field(Control1000000056; Rec."Profissionalização")
                {
                    ApplicationArea = All;

                    Editable = false;
                    Enabled = false;
                }
                field("Habilitação Docência"; Rec."Habilitação Docência")
                {
                    ApplicationArea = All;

                }
                field("Grupo Docência"; Rec."Grupo Docência")
                {
                    ApplicationArea = All;

                }
                field("Acumulação"; Rec."Acumulação")
                {
                    ApplicationArea = All;

                }
            }
            group(MISI)
            {
                Caption = 'MISI';
                Visible = false;
                group("Horas Semanais Letivas")
                {
                    Caption = 'Horas Semanais Letivas';
                    field("Nº Horas Sem. Lect Diurno Cont"; Rec."Nº Horas Sem. Lect Diurno Cont")
                    {
                        ApplicationArea = All;

                    }
                    field("Nº Horas Sem. Lect Diurno Tota"; Rec."Nº Horas Sem. Lect Diurno Tota")
                    {
                        ApplicationArea = All;

                    }
                    field("Nº Horas Sem. Lect Noct Cont"; Rec."Nº Horas Sem. Lect Noct Cont")
                    {
                        ApplicationArea = All;

                    }
                    field("Nº Horas Sem. Lect Noct Tota"; Rec."Nº Horas Sem. Lect Noct Tota")
                    {
                        ApplicationArea = All;

                    }
                }
                group("Horas Semanais Desporto Escolar")
                {
                    Caption = 'Horas Semanais Desporto Escolar';
                    field("Nº Horas Sem.-Desp Escolar Con"; Rec."Nº Horas Sem.-Desp Escolar Con")
                    {
                        ApplicationArea = All;

                    }
                    field("Nº Horas Sem.-Desp Escolar Tot"; Rec."Nº Horas Sem.-Desp Escolar Tot")
                    {
                        ApplicationArea = All;

                    }
                }
                group("Horas Semanais Direção Pedagógica")
                {

                    Caption = 'Horas Semanais Direção Pedagógica';
                    field("Nº Horas Sem.-Dir.Pedag Cont"; Rec."Nº Horas Sem.-Dir.Pedag Cont")
                    {
                        ApplicationArea = All;

                    }
                    field("Nº Horas Sem.-Dir.Pedag Tot"; Rec."Nº Horas Sem.-Dir.Pedag Tot")
                    {
                        ApplicationArea = All;

                    }
                }
                group("Substituição Temporária")
                {
                    Caption = 'Substituição Temporária';
                    field(Control1000000070; Rec."Substituição Temporária")
                    {
                        ApplicationArea = All;

                    }
                    field("NIF do Docente Substituido"; Rec."NIF do Docente Substituido")
                    {
                        ApplicationArea = All;

                    }
                    field("Data Inicio Substituição"; Rec."Data Inicio Substituição")
                    {
                        ApplicationArea = All;

                    }
                    field("Data Fim Substituição"; Rec."Data Fim Substituição")
                    {
                        ApplicationArea = All;

                    }
                }
                field(ContratoME; Rec.ContratoME)
                {
                    ApplicationArea = All;

                }
                field("Direcção Pedagógica"; Rec."Direcção Pedagógica")
                {
                    ApplicationArea = All;

                }
                field("Valor Desc. Conf. Religiosa"; Rec."Valor Desc. Conf. Religiosa")
                {
                    ApplicationArea = All;

                }
                field("Valor Desc. Seguro"; Rec."Valor Desc. Seguro")
                {
                    ApplicationArea = All;

                }
                field("Nº Dias Tempo Serviço"; Rec."Nº Dias Tempo Serviço")
                {
                    ApplicationArea = All;

                }
                field("Dias de Serviço - Estabelecim."; Rec."Dias de Serviço - Estabelecim.")
                {
                    ApplicationArea = All;

                }
                field("Situação"; Rec."Situação")
                {
                    ApplicationArea = All;

                }
                field("Descrição Situação"; Rec."Descrição Situação")
                {
                    ApplicationArea = All;

                }
                field("Afecto à Cantina"; Rec."Afecto à Cantina")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}