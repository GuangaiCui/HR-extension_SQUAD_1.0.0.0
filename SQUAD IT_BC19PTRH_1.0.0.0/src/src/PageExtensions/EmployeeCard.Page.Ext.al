#pragma implicitwith disable
pageextension 53040 "Employee Card Ext" extends "Employee Card"
{
    //Adjusted the order of fields and actions
    //TODO: Check again with consultants and clients - if set some fields invisible

    layout
    {
        addafter("No.")
        {
            field(Name; Rec.Name)
            {
                ApplicationArea = BasicHR;
                Style = Strong;
                StyleExpr = TRUE;
            }
        }
        addafter("Address 2")
        {
            field(Locality; Rec.Locality)
            {
                ApplicationArea = BasicHR;
                //CGA SQD
            }
        }
        addafter(City)
        {
            field("Cod. Freguesia"; Rec."Cod. Freguesia")
            {
                ApplicationArea = BasicHR;
            }
            field(Freguesia; Rec.Freguesia)
            {
                ApplicationArea = BasicHR;
            }
        }
        addafter("Job Title")
        {
            field("Tipo Empregado"; Rec."Tipo Empregado")
            {
                ApplicationArea = BasicHR;
            }
        }
        addafter("Last Date Modified")
        {
            field("No. antigo do Empregado"; Rec."No. antigo do Empregado")
            {
                ApplicationArea = BasicHR;
            }
            field("NAV User Id"; Rec."NAV User Id")
            {
                ApplicationArea = BasicHR;
            }
            field(Docente; Rec.Docente)
            {
                ApplicationArea = BasicHR;
            }
            field("Nº Professor"; Rec."Nº Professor")
            {
                ApplicationArea = BasicHR;
            }
            field("Exportar para o MISI"; Rec."Exportar para o MISI")
            {
                ApplicationArea = BasicHR;
            }
            field(Intern; Rec.Intern)
            {
                ApplicationArea = BasicHR;
            }
            field("Orgão Social"; Rec."Orgão Social")
            {
                ApplicationArea = BasicHR;
            }
        }
        addafter("Alt. Address End Date")
        {
            field(CompanyMobilePhoneNo; Rec.CompanyMobilePhoneNo)
            {
                Importance = Promoted;
                ApplicationArea = BasicHR;
            }
            field("Envio Recibo via E-Mail"; Rec."Envio Recibo via E-Mail")
            {
                ApplicationArea = BasicHR;
            }
            field("Endereço de Envio"; Rec."Endereço de Envio")
            {
                ApplicationArea = BasicHR;
            }
        }
        addafter("Salespers./Purch. Code")
        {
            field(Estabelecimento; Rec.Estabelecimento)
            {
                ApplicationArea = BasicHR;
            }
            field(Seguradora; Rec.Seguradora)
            {
                ApplicationArea = BasicHR;
            }
            field("No. Apólice"; Rec."No. Apólice")
            {
                ApplicationArea = BasicHR;
            }
            field("Data de Antiguidade"; Rec."Data de Antiguidade")
            {
                ApplicationArea = BasicHR;
            }
            field("End Date"; Rec."End Date")
            {
                ApplicationArea = BasicHR;
            }
            field("Motivo de Terminação"; Rec."Motivo de Terminação")
            {
                ApplicationArea = BasicHR;
            }
            field("Cod. Regime Reforma Aplicado"; Rec."Cod. Regime Reforma Aplicado")
            {
                ApplicationArea = BasicHR;
            }
            field("Regime Reforma Aplicado"; Rec."Regime Reforma Aplicado")
            {
                ApplicationArea = BasicHR;
            }
        }
        addafter("Bank Account No.")
        {
            field("Usa Transf. Bancária"; Rec."Usa Transf. Bancária")
            {
                ApplicationArea = BasicHR;
            }
            field("Cód. Banco Transf."; Rec."Cód. Banco Transf.")
            {
                ApplicationArea = BasicHR;
            }
            field(Pagamento; Rec.Pagamento)
            {
                ApplicationArea = BasicHR;
            }
            field("Nome Livro Diario Pag."; Rec."Nome Livro Diario Pag.")
            {
                ApplicationArea = BasicHR;
            }
            field("Secção Diario Pag."; Rec."Secção Diario Pag.")
            {
                ApplicationArea = BasicHR;

            }
            field("Conta Pag."; Rec."Conta Pag.")
            {
                ApplicationArea = BasicHR;

            }
            field("NIB Cartao Ref"; Rec."NIB Cartao Ref")
            {
                ApplicationArea = BasicHR;
            }
        }
        addafter("Union Membership No.")
        {
            field("Naturalidade - Concelho"; Rec."Naturalidade - Concelho")
            {
                ApplicationArea = BasicHR;

            }
            field(Nacionalidade; Rec.Nacionalidade)
            {
                ApplicationArea = BasicHR;

            }
            field("Nacionalidade Descrição"; Rec."Nacionalidade Descrição")
            {
                ApplicationArea = BasicHR;

            }
            field("Documento Identificação"; Rec."Documento Identificação")
            {
                ApplicationArea = BasicHR;

                Importance = Promoted;
            }
            field("No. Doc. Identificação"; Rec."No. Doc. Identificação")
            {
                ApplicationArea = BasicHR;

                Importance = Promoted;
            }
            field("Local Emissão Doc. Ident."; Rec."Local Emissão Doc. Ident.")
            {
                ApplicationArea = BasicHR;

            }
            field("Data Doc. Ident."; Rec."Data Doc. Ident.")
            {
                ApplicationArea = BasicHR;

            }
            field("Data Validade Doc. Ident."; Rec."Data Validade Doc. Ident.")
            {
                ApplicationArea = BasicHR;

            }
            field("Vitalício"; Rec."Vitalício")
            {
                ApplicationArea = BasicHR;

            }
        }
        addafter(Payments)
        {
            group(IRS)
            {

                field("No. Contribuinte"; Rec."No. Contribuinte")
                {
                    ApplicationArea = BasicHR;

                    Importance = Promoted;
                }
                field("Tipo Contribuinte"; Rec."Tipo Contribuinte")
                {
                    ApplicationArea = BasicHR;

                    Importance = Promoted;
                }
                field("Cod. Repartição Finanças"; Rec."Cod. Repartição Finanças")
                {
                    ApplicationArea = BasicHR;

                }
                field("Repartição Finanças"; Rec."Repartição Finanças")
                {
                    ApplicationArea = BasicHR;

                }
                field("Data Emissão NIF"; Rec."Data Emissão NIF")
                {
                    ApplicationArea = BasicHR;

                }
                field("Tipo Rendimento"; Rec."Tipo Rendimento")
                {
                    ApplicationArea = BasicHR;

                }
                field("Local Obtenção Rendimento"; Rec."Local Obtenção Rendimento")
                {
                    ApplicationArea = BasicHR;

                }
                field("Estado Civil"; Rec."Estado Civil")
                {
                    ApplicationArea = BasicHR;

                }
                field("Civil State Date"; Rec."Civil State Date")
                {
                    ApplicationArea = BasicHR;

                }
                field("Titular Rendimentos"; Rec."Titular Rendimentos")
                {
                    ApplicationArea = BasicHR;

                }
                field(Deficiente; Rec.Deficiente)
                {
                    ApplicationArea = BasicHR;

                }
                field("Conjuge Deficiente"; Rec."Conjuge Deficiente")
                {
                    ApplicationArea = BasicHR;

                }
                field("No. Dependentes"; Rec."No. Dependentes")
                {
                    ApplicationArea = BasicHR;

                }
                field("No. Dependentes Deficientes"; Rec."No. Dependentes Deficientes")
                {
                    ApplicationArea = BasicHR;

                }
                field("Tabela IRS"; Rec."Tabela IRS")
                {
                    ApplicationArea = BasicHR;

                    Caption = 'Tabela IRS';
                    Editable = false;
                }
                field("Descrição Tabela IRS"; Rec."Descrição Tabela IRS")
                {
                    ApplicationArea = BasicHR;

                    Editable = false;
                }
                field("IRS %"; Rec."IRS %")
                {
                    ApplicationArea = BasicHR;

                    Editable = false;
                }
                field("IRS % Fixa"; Rec."IRS % Fixa")
                {
                    ApplicationArea = BasicHR;

                }
                field("IVA %"; Rec."IVA %")
                {
                    ApplicationArea = BasicHR;

                }
            }
            group("Seg. Social")
            {

                field("Subscritor SS"; Rec."Subscritor SS")
                {
                    ApplicationArea = BasicHR;

                }
                field("No. Segurança Social"; Rec."No. Segurança Social")
                {
                    ApplicationArea = BasicHR;

                    Importance = Promoted;
                }
                field("Data da Admissão SS"; Rec."Data da Admissão SS")
                {
                    ApplicationArea = BasicHR;

                }
                field("Data Emissão SS"; Rec."Data Emissão SS")
                {
                    ApplicationArea = BasicHR;

                }
                field("Cod. Instituição SS"; Rec."Cod. Instituição SS")
                {
                    ApplicationArea = BasicHR;

                }
                field("Cod. Regime SS"; Rec."Cod. Regime SS")
                {
                    ApplicationArea = BasicHR;

                }
                field("Cód. Rúbrica Enc. Seg. Social"; Rec."Cód. Rúbrica Enc. Seg. Social")
                {
                    ApplicationArea = BasicHR;

                }
            }
            group(CGA)
            {
                Caption = 'CGA';
                field("Subsccritor CGA"; Rec."Subsccritor CGA")
                {
                    ApplicationArea = BasicHR;

                }
                field("Nº CGA"; Rec."Nº CGA")
                {
                    ApplicationArea = BasicHR;

                }
                field("Data da Admissão CGA"; Rec."Data da Admissão CGA")
                {
                    ApplicationArea = BasicHR;

                }
                field("Data de Emissão CGA"; Rec."Data de Emissão CGA")
                {
                    ApplicationArea = BasicHR;

                }
                field("Nº Horas Docência Calc. Desct."; Rec."Nº Horas Docência Calc. Desct.")
                {
                    ApplicationArea = BasicHR;

                }
                field("Professor Acumulação"; Rec."Professor Acumulação")
                {
                    ApplicationArea = BasicHR;

                }
                field("CGA - Requisição"; Rec."CGA - Requisição")
                {
                    ApplicationArea = BasicHR;

                }
                field("Cód. Rúbrica Enc. CGA"; Rec."Cód. Rúbrica Enc. CGA")
                {
                    ApplicationArea = BasicHR;

                }
            }
            group(ADSE)
            {
                Caption = 'ADSE';
                field("Subscritor ADSE"; Rec."Subscritor ADSE")
                {
                    ApplicationArea = BasicHR;

                }
                field("Nº ADSE"; Rec."Nº ADSE")
                {
                    ApplicationArea = BasicHR;

                }
                field("Data da Admissão ADSE"; Rec."Data da Admissão ADSE")
                {
                    ApplicationArea = BasicHR;

                }
                field("Data de Emissão ADSE"; Rec."Data de Emissão ADSE")
                {
                    ApplicationArea = BasicHR;

                }
                field("Cód. Rúbrica Enc. ADSE"; Rec."Cód. Rúbrica Enc. ADSE")
                {
                    ApplicationArea = BasicHR;

                }
            }
            group(Processamentos)
            {
                Caption = 'Processing';
                field("Valor Vencimento Base"; Rec."Valor Vencimento Base")
                {
                    ApplicationArea = BasicHR;

                    Editable = false;
                    Importance = Promoted;
                }
                field("Valor Dia"; Rec."Valor Dia")
                {
                    ApplicationArea = BasicHR;

                    Editable = false;
                }
                field("Valor Hora"; Rec."Valor Hora")
                {
                    ApplicationArea = BasicHR;

                    Editable = false;
                }
                field("No. Horas Semanais"; Rec."No. Horas Semanais")
                {
                    ApplicationArea = BasicHR;

                    Caption = 'Week Hours No.';
                }
                field("No. Horas Semanais Totais"; Rec."No. Horas Semanais Totais")
                {
                    ApplicationArea = BasicHR;

                }
                field("No. dias de Trabalho Semanal"; Rec."No. dias de Trabalho Semanal")
                {
                    ApplicationArea = BasicHR;

                }
                field("No. Dias Trabalho Mensal"; Rec."No. Dias Trabalho Mensal")
                {
                    ApplicationArea = BasicHR;

                }
                field("Mês Proc. Sub. Férias"; Rec."Mês Proc. Sub. Férias")
                {
                    ApplicationArea = BasicHR;

                }
                field("Última data Proc. Sub. Férias"; Rec."Última data Proc. Sub. Férias")
                {
                    ApplicationArea = BasicHR;

                }
                field("Vacation Balance"; Rec."Vacation Balance")
                {
                    ApplicationArea = BasicHR;

                }
            }
            group(Categoria)
            {
                Caption = 'Category';
                field("Cód. IRCT"; Rec."Cód. IRCT")
                {
                    ApplicationArea = BasicHR;

                }
                field("Acordo Colectivo"; Rec."Acordo Colectivo")
                {
                    ApplicationArea = BasicHR;

                }
                field("Descrição IRCT"; Rec."Descrição IRCT")
                {
                    ApplicationArea = BasicHR;

                }
                field("Aplicabilidade do IRCT"; Rec."Aplicabilidade do IRCT")
                {
                    ApplicationArea = BasicHR;

                }
                field("Cód. Cat. Profissional"; Rec."Cód. Cat. Profissional")
                {
                    ApplicationArea = BasicHR;

                    Editable = false;
                    Enabled = false;
                }
                field("Descrição Cat Prof"; Rec."Descrição Cat Prof")
                {
                    ApplicationArea = BasicHR;

                    Editable = false;
                    Enabled = false;
                }
                field("Cód. Cat. Prof QP"; Rec."Cód. Cat. Prof QP")
                {
                    ApplicationArea = BasicHR;

                    Editable = false;
                    Enabled = false;
                }
                field("Descrição Cat Prof QP"; Rec."Descrição Cat Prof QP")
                {
                    ApplicationArea = BasicHR;

                    Editable = false;
                    Enabled = false;
                }
                field("Class. Nac. Profi."; Rec."Class. Nac. Profi.")
                {
                    ApplicationArea = BasicHR;

                }
                field("Descrição Class. Nac."; Rec."Descrição Class. Nac.")
                {
                    ApplicationArea = BasicHR;

                }
                field("Cód. Habilitações"; Rec."Cód. Habilitações")
                {
                    ApplicationArea = BasicHR;

                }
                field("Descrição Habilitações"; Rec."Descrição Habilitações")
                {
                    ApplicationArea = BasicHR;

                }
                field("Qualificação"; Rec."Qualificação")
                {
                    ApplicationArea = BasicHR;

                }
                field("Formação-Situação face à freq."; Rec."Formação-Situação face à freq.")
                {
                    ApplicationArea = BasicHR;

                }
                field("Situação Profissional"; Rec."Situação Profissional")
                {
                    ApplicationArea = BasicHR;

                }
                field("Regime Duração Trabalho"; Rec."Regime Duração Trabalho")
                {
                    ApplicationArea = BasicHR;

                }
                field("Duração do Tempo de Trabalho"; Rec."Duração do Tempo de Trabalho")
                {
                    ApplicationArea = BasicHR;

                }
                field("Desc. Duração Tempo Trabalho"; Rec."Desc. Duração Tempo Trabalho")
                {
                    ApplicationArea = BasicHR;

                }
                field("Cód. Horário"; Rec."Cód. Horário")
                {
                    ApplicationArea = BasicHR;

                    Editable = false;
                    Enabled = false;
                }
                field(Control1000000048; Rec."Grau Função")
                {
                    ApplicationArea = BasicHR;

                }
                field("Descrição Grau Função"; Rec."Descrição Grau Função")
                {
                    ApplicationArea = BasicHR;

                }
                field("Grau Função-Efeitos Progres."; Rec."Grau Função-Efeitos Progres.")
                {
                    ApplicationArea = BasicHR;

                }
                field("Descrição Grau Função Progr."; Rec."Descrição Grau Função Progr.")
                {
                    ApplicationArea = BasicHR;

                }
                field(Control1000000056; Rec."Profissionalização")
                {
                    ApplicationArea = BasicHR;

                    Editable = false;
                    Enabled = false;
                }
                field("Habilitação Docência"; Rec."Habilitação Docência")
                {
                    ApplicationArea = BasicHR;

                }
                field("Grupo Docência"; Rec."Grupo Docência")
                {
                    ApplicationArea = BasicHR;

                }
                field("Acumulação"; Rec."Acumulação")
                {
                    ApplicationArea = BasicHR;

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
                        ApplicationArea = BasicHR;

                    }
                    field("Nº Horas Sem. Lect Diurno Tota"; Rec."Nº Horas Sem. Lect Diurno Tota")
                    {
                        ApplicationArea = BasicHR;

                    }
                    field("Nº Horas Sem. Lect Noct Cont"; Rec."Nº Horas Sem. Lect Noct Cont")
                    {
                        ApplicationArea = BasicHR;

                    }
                    field("Nº Horas Sem. Lect Noct Tota"; Rec."Nº Horas Sem. Lect Noct Tota")
                    {
                        ApplicationArea = BasicHR;

                    }
                }
                group("Horas Semanais Desporto Escolar")
                {
                    Caption = 'Horas Semanais Desporto Escolar';
                    field("Nº Horas Sem.-Desp Escolar Con"; Rec."Nº Horas Sem.-Desp Escolar Con")
                    {
                        ApplicationArea = BasicHR;

                    }
                    field("Nº Horas Sem.-Desp Escolar Tot"; Rec."Nº Horas Sem.-Desp Escolar Tot")
                    {
                        ApplicationArea = BasicHR;

                    }
                }
                group("Horas Semanais Direção Pedagógica")
                {

                    Caption = 'Horas Semanais Direção Pedagógica';
                    field("Nº Horas Sem.-Dir.Pedag Cont"; Rec."Nº Horas Sem.-Dir.Pedag Cont")
                    {
                        ApplicationArea = BasicHR;

                    }
                    field("Nº Horas Sem.-Dir.Pedag Tot"; Rec."Nº Horas Sem.-Dir.Pedag Tot")
                    {
                        ApplicationArea = BasicHR;

                    }
                }
                group("Substituição Temporária")
                {
                    Caption = 'Substituição Temporária';
                    field(Control1000000070; Rec."Substituição Temporária")
                    {
                        ApplicationArea = BasicHR;

                    }
                    field("NIF do Docente Substituido"; Rec."NIF do Docente Substituido")
                    {
                        ApplicationArea = BasicHR;

                    }
                    field("Data Inicio Substituição"; Rec."Data Inicio Substituição")
                    {
                        ApplicationArea = BasicHR;

                    }
                    field("Data Fim Substituição"; Rec."Data Fim Substituição")
                    {
                        ApplicationArea = BasicHR;

                    }
                }
                field(ContratoME; Rec.ContratoME)
                {
                    ApplicationArea = BasicHR;

                }
                field("Direcção Pedagógica"; Rec."Direcção Pedagógica")
                {
                    ApplicationArea = BasicHR;

                }
                field("Valor Desc. Conf. Religiosa"; Rec."Valor Desc. Conf. Religiosa")
                {
                    ApplicationArea = BasicHR;

                }
                field("Valor Desc. Seguro"; Rec."Valor Desc. Seguro")
                {
                    ApplicationArea = BasicHR;

                }
                field("Nº Dias Tempo Serviço"; Rec."Nº Dias Tempo Serviço")
                {
                    ApplicationArea = BasicHR;

                }
                field("Dias de Serviço - Estabelecim."; Rec."Dias de Serviço - Estabelecim.")
                {
                    ApplicationArea = BasicHR;

                }
                field("Situação"; Rec."Situação")
                {
                    ApplicationArea = BasicHR;

                }
                field("Descrição Situação"; Rec."Descrição Situação")
                {
                    ApplicationArea = BasicHR;

                }
                field("Afecto à Cantina"; Rec."Afecto à Cantina")
                {
                    ApplicationArea = BasicHR;

                }
            }
        }
    }

    actions
    {

        addafter("Sent Emails")
        {
            action("Hist. Ausências")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Hist. Ausências';
                Image = Absence;
                RunObject = Page "Lista Histórico Ausências";
                RunPageLink = "Employee No." = FIELD("No.");
            }
            action("Hist. Horas Extra")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Hist. Horas Extra';
                Image = ServiceHours;
                RunObject = Page "Lista Histórico Horas Extra";
                RunPageLink = "No. Empregado" = FIELD("No.");
            }
            action("Hist. Abonos/Descontos Extra")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Hist. Abonos/Descontos Extra';
                Image = ChangePaymentTolerance;
                RunObject = Page "Lista Hist. Abon. - Des. Extr.";
                RunPageLink = "No. Empregado" = FIELD("No.");
            }
            separator(Action177)
            {
            }
            action("Hist. Mov. Empregado")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Hist. Mov. Empregado';
                Image = PaymentPeriod;
                RunObject = Page "Lista Hist. Cab. Movs. Emp";
                RunPageLink = "No. Empregado" = FIELD("No.");
            }
        }
        addafter(History)
        {
            group(Cadastro)
            {
                Caption = '&Cadastro';
                action("Contratos &Trabalho")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Contratos &Trabalho';
                    Image = EmployeeAgreement;
                    RunObject = Page "Lista Contrato Empregado";
                    RunPageLink = "Cód. Empregado" = FIELD("No.");
                }
                action("Cat. Profissional Interna")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cat. Profissional Interna';
                    Image = QualificationOverview;
                    RunObject = Page "Lista Cat. Prof. Int. Emp.";
                    RunPageLink = "No. Empregado" = FIELD("No.");
                }
                action("Cat. Profissional QP")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cat. Profissional QP';
                    Image = QualificationOverview;
                    RunObject = Page "Lista Cat. Prof. Emp. QP";
                    RunPageLink = "No. Empregado" = FIELD("No.");
                }
                action("Formação")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Formação';
                    Image = Campaign;
                    RunObject = Page "Registo Formação";
                    RunPageLink = "No. Empregado" = FIELD("No.");
                }
                action("Qualificações/Habilitações")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Qualificações/Habilitações';
                    Image = UserCertificate;
                    RunObject = Page "Qualificações Empregado";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Qualificações RU")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Qualificações RU';
                    Image = UserCertificate;
                    RunObject = Page "Qualificações Empregado RU";
                    RunPageLink = "Employee No." = FIELD("No."),
                                  Type = FILTER("Qualificações RU");
                }
                action("Grau Função")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Grau Função';
                    Image = JobResponsibility;
                    RunObject = Page "Lista Grau Função Empregado";
                    RunPageLink = "No. Empregado" = FIELD("No.");
                }
                action("Horário")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Horário';
                    Image = Timesheet;
                    RunObject = Page "Lista Horário Empregado";
                    RunPageLink = "No. Empregado" = FIELD("No.");
                }
                action("Consultas Médicas")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Consultas Médicas';
                    Image = CampaignEntries;
                    RunObject = Page "Consultas Médicas Empregado";
                    RunPageLink = "No. Empregado" = FIELD("No.");
                }
                action("Informação Artigo&s Div.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Mi&sc. Article Information';
                    Image = Filed;
                    RunObject = Page "Informação Artigos Div.";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action(Inactividade)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inactividade';
                    Image = InactivityDescription;
                    RunObject = Page "Lista Inactividade Empregado";
                    RunPageLink = "No. Empregado" = FIELD("No.");
                }
                action("Profissionalização")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Profissionalização';
                    Image = CustomerRating;
                    RunObject = Page "Profissionalização";
                    RunPageLink = "Cod Empregado" = FIELD("No.");
                }
                action("Perdas e Anomalias")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Perdas e Anomalias';
                    Image = CapableToPromise;
                    RunObject = Page "Perdas e Anomalias Emp.";
                    RunPageLink = "No. Empregado" = FIELD("No.");
                }
                action(Destacamentos)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Destacamentos';
                    Image = ChangeCustomer;
                    RunObject = Page Destacamentos;
                    RunPageLink = "No. Emp." = FIELD("No.");
                }
                action(Seguros)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Seguros';
                    Image = CoupledUsers;
                    RunObject = Page "Seg Saude Empregado";
                    RunPageLink = "No. Empregado" = FIELD("No.");
                }
            }
            group("Férias")
            {
                Caption = 'Férias';
                action("Marcação de Férias")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Marcação de Férias';
                    Image = Holiday;
                    RunObject = Page "Lista Férias Empregado";
                    RunPageLink = "No. Empregado" = FIELD("No.");
                }
            }
        }
        addafter(SaveAsTemplate)
        {
            action("Rubricas Salariais")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Rubricas Salariais';
                Image = SalesTaxStatement;
                RunObject = Page "Lista Rubrica Salarial Emp.";
                RunPageLink = "No. Empregado" = FIELD("No.");
            }
            action("Distribuição de Custos - Dimensões")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Distribuição de Custos - Dimensões';
                Image = MapDimensions;
                RunObject = Page "Distribuição Custos -Dimensões";
                RunPageLink = "No. Empregado" = FIELD("No.");
            }
            action("Calcular Taxa IRS")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Calcular Taxa IRS';
                Image = CalculateSalesTax;

                trigger OnAction()
                begin
                    //Actualiza a taxa de IRS na Ficha do empregado caso este não use uma % de IRS Fixa
                    //Para o calculo da taxa de IRS, tem em conta todos os abonos em vigor à data de Trabalho
                    //e que sejam do tipo Vencimento Base

                    Rec.CalcTaxaIRSEmpregado;
                end;
            }
            action("Calcular Valor Dia e Hora")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Calcular Valor Dia e Hora';
                Image = CheckRulesSyntax;

                trigger OnAction()
                var
                    TabEmpregado: Record Employee;
                begin

                    //Actualiza o Valor Dia e Hora na Ficha do empregado tendo em conta todos os abonos
                    // em vigor à data de Trabalho e que sejam do tipo Vencimento Base

                    //2009.02.26 - permitir actualizar todos os empregados de uma só vez
                    if Confirm(Text0007) then begin
                        TabEmpregado.Reset;
                        TabEmpregado.SetRange(TabEmpregado.Status, TabEmpregado.Status::Active);
                        TabEmpregado.SetRange(TabEmpregado."Tipo Contribuinte", TabEmpregado."Tipo Contribuinte"::"Conta de Outrem");
                        if TabEmpregado.Find('-') then begin
                            repeat
                                TabEmpregado.TestField(TabEmpregado."No. Horas Semanais");
                                TabEmpregado."Valor Vencimento Base" := FuncoesRH.CalcularVencimentoBase(WorkDate, TabEmpregado);
                                if TabEmpregado."Valor Vencimento Base" <> 0 then begin
                                    TabEmpregado."No. Dias Trabalho Mensal" := FuncoesRH.CalcularDiasMes(TabEmpregado);
                                    TabEmpregado.Modify;
                                    Commit;
                                    TabEmpregado."Valor Dia" := FuncoesRH.CalcularValorDia(TabEmpregado."Valor Vencimento Base", TabEmpregado);
                                    TabEmpregado."Valor Hora" := FuncoesRH.CalcularValorHora(TabEmpregado."Valor Vencimento Base", TabEmpregado);
                                    TabEmpregado.Modify;
                                end else begin
                                    Message(Text0001, TabEmpregado."No.");
                                end;
                            until TabEmpregado.Next = 0;
                        end;
                    end else begin
                        Rec.TestField("No. Horas Semanais");
                        //2009.02.26 -  fim

                        Rec."Valor Vencimento Base" := FuncoesRH.CalcularVencimentoBase(WorkDate, Rec);
                        if Rec."Valor Vencimento Base" <> 0 then begin
                            Rec."No. Dias Trabalho Mensal" := FuncoesRH.CalcularDiasMes(Rec);
                            Rec.Modify;
                            Commit;
                            //FBC - RH-019
                            Rec."Valor Dia" := FuncoesRH.CalcularValorDia(Rec."Valor Vencimento Base", Rec);
                            Rec."Valor Hora" := FuncoesRH.CalcularValorHora(Rec."Valor Vencimento Base", Rec);
                            Rec.Modify;
                        end else begin
                            Message('%1', Text0001);
                        end;
                    end;
                end;
            }
            action(Penhoras)
            {
                Image = CalculateConsumption;
                RunObject = Page Penhoras;
                RunPageLink = "Employee No." = FIELD("No.");
            }
            action("Copiar Empregado")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Copiar Empregado';
                Image = Copy;

                trigger OnAction()
                var
                    Emp: Record Employee;
                begin
                    Emp.SetRange(Emp."No.", Rec."No.");
                    rCriarFichaEmp.SetTableView(Emp);
                    rCriarFichaEmp.Run;
                end;
            }
        }
        addafter("F&unctions")
        {
            group(Registo)
            {
                Caption = '&Registo';
                action("Ausências")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ausências';
                    Image = Absence;
                    RunObject = Page "Registo Ausência";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Horas Extra")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Horas Extra';
                    Image = ServiceHours;
                    RunObject = Page "Registo Horas Extra";
                    RunPageLink = "No. Empregado" = FIELD("No.");
                }
                action("Abono-Desconto Extra")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Abono-Desconto Extra';
                    Image = ChangePaymentTolerance;
                    RunObject = Page "Registo Abonos-Descontos Extra";
                    RunPageLink = "No. Empregado" = FIELD("No.");
                }
            }
            group(Processamento)
            {
                Caption = '&Processamento';
                action("Processamento Vencimento")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Processar Vencimento';
                    Image = PaymentDays;

                    trigger OnAction()
                    begin

                        TabEmpregado.SetRange(TabEmpregado."No.", Rec."No.");
                        REPORT.RunModal(31003037, true, false, TabEmpregado);
                    end;
                }
                action("Processamento Sub. Férias")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Processar Sub. Férias';
                    Image = PostedPayment;

                    trigger OnAction()
                    begin

                        TabEmpregado.SetRange(TabEmpregado."No.", Rec."No.");
                        REPORT.RunModal(31003041, true, false, TabEmpregado);
                    end;
                }
                action("Processamento Sub. Natal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Processar Sub. Natal';
                    Image = PostedPayment;

                    trigger OnAction()
                    begin

                        TabEmpregado.SetRange(TabEmpregado."No.", Rec."No.");
                        REPORT.RunModal(31003040, true, false, TabEmpregado);
                    end;
                }
                action("Movs. empregado")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Movs. empregado';
                    Image = PaymentPeriod;
                    RunObject = Page "Cab. Movs. Empregado";
                    RunPageLink = "No. Empregado" = FIELD(FILTER("No."));
                    RunPageView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado");
                }
            }


        }


        addlast(Processing)
        {
            group(Reports)
            {
                action("Recibo Vencimentos A5")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Recibo Vencimento';
                    Image = Payment;

                    trigger OnAction()
                    begin

                        TabEmpregado.Reset;
                        TabEmpregado.SetRange(TabEmpregado."No.", Rec."No.");
                        REPORT.Run(Report::"Recibo Vencimentos A4", true, false, TabEmpregado);
                    end;
                }
                action("<Report Ficha Empregado>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ficha Empregado';
                    Image = Employee;
                    RunObject = Report "Ficha Empregado";
                }
                action("Ausência Empregado")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ausência Empregado';
                    Image = Absence;
                    RunObject = Report "Ausência por Empregado";
                }
                action("Horas Extra Emp.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Horas Extra Emp.';
                    Image = ServiceHours;
                    RunObject = Report "Horas Extra por Empregado";
                }
                action("Férias Empregado")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Férias Empregado';
                    Image = Holiday;
                    RunObject = Report "Mapa Férias Empregado";
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin

        TabHistCabMovEmpr.Reset;
        TabHistCabMovEmpr.SetRange(TabHistCabMovEmpr."No. Empregado", Rec."No.");
        if TabHistCabMovEmpr.Find('-') then begin
            Message(Text0005);
            exit(false);
        end;
    end;



    var
        MapPointVisible: Boolean;
        TabEmpregado: Record Employee;
        Text0001: Label 'Não existe em vigor nenhuma Rúbrica do tipo Vencimento Base para o empregado %1.';
        Text0002: Label 'Por favor preencha a data de admissão do novo empregado %1.';
        Text0003: Label 'Por favor preencha a data de fim do empregado %1.';
        Text0004: Label 'Por favor preencha o motivo de terminação do empregado %1.';
        Text0005: Label 'Não pode apagar um empregado com processamentos já fechados.';
        Text0006: Label 'Funcionalidade indisponível.';
        Text0007: Label 'Deseja calcular o Valor Dia e Hora de todos os Empregados?';
        Text0008: Label 'Não pode apagar este empregado, enquanto existir ligação aos Professores.';
        FuncoesRH: Codeunit "Funções RH";
        FileNameImport: Text[250];
        "extensão": Code[20];
        Path: Text[250];
        NLinha: Integer;
        TabHistCabMovEmpr: Record "Hist. Cab. Movs. Empregado";
        EditaEmp: Boolean;
        IsInsert: Boolean;
        rCriarFichaEmp: Report "Copiar Ficha Empregado";


    procedure ValidaDatas(): Boolean
    begin

        if (Rec."Employment Date" = 0D) and (Rec.Status = Rec.Status::Active) and (Rec."No." <> '') then begin  //HG 18.10.2007
            Message(Text0002, Rec."No.");
            exit(false);
        end;

        if (Rec.Status = Rec.Status::Terminated) then begin
            if (Rec."End Date" = 0D) then begin
                Message(Text0003, Rec."No.");
                exit(false);
            end else
                if (Rec."Motivo de Terminação" = '') then begin
                    Message(Text0004, Rec."No.");
                    exit(false);
                end;
        end;

        exit(true);
    end;
}
#pragma implicitwith restore
