page 53170 "Human Resources Role Center"
{
    Caption = 'Human Resources Role Center';
    PageType = RoleCenter;
    UsageCategory = Tasks;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(rolecenter)
        {
            group(Control1000000006)
            {
                ShowCaption = false;
                part(Control1000000005; MyEmpregado)
                {
                    ApplicationArea = All;

                    Caption = 'Employee';
                }
                part(Control1000000004; "MyRegistoAusências")
                {
                    ApplicationArea = All;

                    Caption = 'Absense Registration';
                }
            }
            group(Control1000000003)
            {
                ShowCaption = false;
                part("Hist. Movs. Emp."; MyHistMovsEmp)
                {
                    ApplicationArea = All;

                    Caption = 'Hist. Movs. Emp.';
                }
                systempart(Control1; MyNotes)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(Embedding)
        {
            action(Empregados)
            {
                ApplicationArea = All;

                Caption = 'Employee';
                RunObject = Page "Lista Empregado";
            }
            action("Registo Ausências")
            {
                ApplicationArea = All;

                Caption = 'Absense Register';
                RunObject = Page "Registo Ausência";
            }
            action("Registo Abonos - Descontos Extra")
            {
                ApplicationArea = All;

                Caption = 'Registo Abonos - Descontos Extra';
                RunObject = Page "Registo Abonos-Descontos Extra";
            }
            action(Processamento)
            {
                ApplicationArea = All;

                Caption = 'Processing';
                RunObject = Page "Periodos Processamento";
            }
            action("Movimentos Empregado")
            {
                ApplicationArea = All;

                Caption = 'Movimentos Empregado';
                RunObject = Page "Lista Cab. Movs. Empregado";
            }
            action("Hist. Mov. Empregado")
            {
                ApplicationArea = All;

                Caption = 'Hist. Mov. Empregado';
                RunObject = Page "Lista Hist. Cab. Movs. Emp";
            }
        }
        area(Sections)
        {
            group(Action1000000013)
            {
                Caption = 'Empregados';
                action(Action1000000014)
                {
                    ApplicationArea = All;

                    Caption = 'Employee';
                    Image = HumanResources;
                    RunObject = Page "Lista Empregado";
                }
                group(Tarefas)
                {
                    Caption = 'Tarefas';
                    action("Registo Ausência")
                    {
                        ApplicationArea = All;

                        Caption = 'Registo Ausência';
                        Image = Absence;
                        RunObject = Page "Registo Ausência";
                    }
                    action("Registo Horas Extra")
                    {
                        ApplicationArea = All;

                        Caption = 'Registo Horas Extra';
                        Image = CreateLinesFromTimesheet;
                        RunObject = Page "Registo Horas Extra";
                    }
                    action("Preparação Fecho Contas")
                    {
                        ApplicationArea = All;

                        Caption = 'Preparação Fecho Contas';
                        Image = AccountingPeriods;
                        RunObject = Page "Preparação Fecho Contas";
                    }
                    action("Enviar Recibo via E-mail")
                    {
                        ApplicationArea = All;

                        Caption = 'Enviar Recibo via E-mail';
                        Image = Email;
                        RunObject = Report "Enviar Recibo via EMail";
                    }
                }
                group("Documents")
                {
                    Caption = 'Documentos';
                    action("Recibo Vencimentos A5")
                    {
                        ApplicationArea = All;

                        Caption = 'Recibo Vencimentos';
                        RunObject = Report "Recibo Vencimentos A5";
                    }
                    action("Recibo Vencimentos A4")
                    {
                        ApplicationArea = All;

                        Caption = 'Recibo Vencimentos A4';
                        RunObject = Report "Recibo Vencimentos A4";
                    }
                }
                group("Simulator")
                {
                    Caption = 'Simulador';
                    action("Simulador de Remunerações")
                    {
                        ApplicationArea = All;

                        Caption = 'Simulador de Remunerações';
                        RunObject = Page "Simulador de Remunerações";
                    }
                }
            }
            group(Action1000000015)
            {
                Caption = 'Processamento';
                group("Mounthly Processing")
                {
                    Caption = 'Processamento Mensal';
                    action("Períodos Processamento")
                    {
                        ApplicationArea = All;

                        Caption = 'Períodos Processamento';
                        Image = ReopenPeriod;
                        RunObject = Page "Periodos Processamento";
                    }
                    action("Processamento Vencimentos")
                    {
                        ApplicationArea = All;

                        Caption = 'Processamento Vencimentos';
                        Image = PaymentPeriod;
                        RunObject = Report "Processamento Vencimentos";
                    }
                    action("Fecho Processamento")
                    {
                        ApplicationArea = All;

                        Caption = 'Fecho Processamento';
                        Image = ClosePeriod;
                        RunObject = Report "Fecho Mês";
                    }
                    action("Integração Contabilística")
                    {
                        ApplicationArea = All;

                        Caption = 'Integração Contabilística';
                        Image = InsertAccount;
                        RunObject = Report "Integração Contabilística";
                    }
                    action("Reabrir Processamento")
                    {
                        ApplicationArea = All;

                        Caption = 'Reabrir Processamento';
                        Image = ClosePeriod;
                        RunObject = Report "Reabrir Processamento";
                    }
                    group(Pagamentos)
                    {
                        Caption = 'Pagamentos';
                        action(Vencimentos)
                        {
                            ApplicationArea = All;

                            Caption = 'Vencimentos';
                            Image = ElectronicPayment;
                            RunObject = Report "Pagamento Vencimentos";
                        }
                        action(Encargos)
                        {
                            ApplicationArea = All;

                            Caption = 'Encargos';
                            Image = TaxPayment;
                            RunObject = Report "Pagamento Encargos";
                        }
                    }
                }
                group("Anual Processing")
                {
                    Caption = 'Processamento Anual';
                    action("Processamento Sub. Férias")
                    {
                        ApplicationArea = All;

                        Caption = 'Processamento Sub. Férias';
                        RunObject = report "Processamento Sub. Férias";
                    }
                    action("Processamento Sub. Natal")
                    {
                        ApplicationArea = All;

                        Caption = 'Processamento Sub. Natal';
                        RunObject = report "Processamento Sub. Natal";
                    }
                    action("Fecho Processamento SF/SN")
                    {
                        ApplicationArea = All;

                        Caption = 'Fecho Processamento SF/SN';
                        Image = ClosePeriod;
                        RunObject = Report "Fecho Sub. Férias/Natal";
                    }
                    action("Mapa Modelo 10")
                    {
                        ApplicationArea = All;

                        Caption = 'Mapa Modelo 10';
                        RunObject = report "Mapa Modelo 10";
                    }
                    action("Ficheiro Modelo 10")
                    {
                        ApplicationArea = All;

                        Caption = 'Ficheiro Modelo 10';
                        RunObject = report "Ficheiro Modelo 10";
                    }
                    action("Mapa Trabalho Suplementar")
                    {
                        ApplicationArea = All;

                        Caption = 'Mapa Trabalho Suplementar';
                        RunObject = report "Mapa Trabalho Suplementar";
                    }
                    action("Gerar Relatório Único")
                    {
                        ApplicationArea = All;

                        Caption = 'Gerar Relatório Único';
                        RunObject = codeunit "Gerar Relatório Único";
                    }
                    group("Férias")
                    {
                        Caption = 'Férias';
                        action("Importar Férias")
                        {
                            ApplicationArea = All;

                            Caption = 'Importar Férias';
                            RunObject = report "Importar Férias";
                        }
                        action("Marcar Férias Empregado")
                        {
                            ApplicationArea = All;

                            Caption = 'Marcar Férias Empregado';
                            RunObject = page "Lista Férias Empregado";
                        }
                        action("Vista Férias Empregados")
                        {
                            ApplicationArea = All;

                            Caption = 'Vista Férias Empregados';
                            RunObject = page "Vista Férias Empregados";
                        }
                        action("Férias - Mapa Férias Empregado")
                        {
                            ApplicationArea = All;

                            Caption = 'Mapa Férias Empregado';
                            RunObject = report "Mapa Férias Empregado";
                        }
                        action("Mapa Férias Global")
                        {
                            ApplicationArea = All;

                            Caption = 'Mapa Férias Global';
                            RunObject = report "Mapa Férias Global";
                        }
                        action("Listagem de Férias")
                        {
                            ApplicationArea = All;

                            Caption = 'Listagem de Férias';
                            RunObject = report "Listagem de Férias";
                        }
                    }
                }
            }
            group(Formação)
            {
                Caption = 'Formação';
                action("Lista Acções Formação")
                {
                    ApplicationArea = All;

                    Caption = 'Lista Acções Formação';
                    RunObject = Page "Lista Acções Formação";
                }
                action("Registo Formação")
                {
                    ApplicationArea = All;

                    Caption = 'Registo Formação';
                    Image = TaxPayment;
                    RunObject = Page "Registo Formação";
                }
                action("Formação por Empregado")
                {
                    ApplicationArea = All;

                    Caption = 'Formação por Empregado';
                    RunObject = Report "Formação por Empregado";
                }
                action("Formação por Acção")
                {
                    ApplicationArea = All;

                    Caption = 'Formação por Acção';
                    RunObject = Report "Formação por Acção";
                }
            }
            group("Segurança e Saúde no Trabalho")
            {
                Caption = 'Segurança e Saúde no Trabalho';
                group(Actividades)
                {
                    Caption = 'Actividades';
                    action("Actividades dos Serviços")
                    {
                        ApplicationArea = All;

                        Caption = 'Actividades dos Serviços';
                        RunObject = Page "Actividades dos Serviços";
                    }
                    action("Acções de Inf. Cons. For")
                    {
                        ApplicationArea = All;

                        Caption = 'Acções de Inf. Cons. Formação';
                        RunObject = Page "Acções de Inf. Cons. For";
                    }
                    action("Identificação Factores de Risco")
                    {
                        ApplicationArea = All;

                        Caption = 'Identificação Factores de Risco';
                        RunObject = Page "Factores de Risco";
                    }
                    action("Acções Médicas")
                    {
                        ApplicationArea = All;

                        Caption = 'Acções Médicas';
                        RunObject = Page "Acções Médicas";
                    }
                    action("Acções Promoção da Saúde")
                    {
                        ApplicationArea = All;

                        Caption = 'Acções Promoção da Saúde';
                        RunObject = Page "Acções Promoção da Saúde";
                    }
                }
                group("Acidentes Trab. e Doenças")
                {
                    Caption = 'Acidentes Trab. e Doenças';
                    action("Acidentes de Trabalho")
                    {
                        ApplicationArea = All;

                        Caption = 'Acidentes de Trabalho';
                        RunObject = Page "Acidentes de Trabalho";
                    }
                    action("Doenças Profissionais")
                    {
                        ApplicationArea = All;

                        Caption = 'Doenças Profissionais';
                        RunObject = Page "Doenças Profissionais";
                    }
                }
                action("Pessoal dos Serviços")
                {
                    ApplicationArea = All;

                    Caption = 'Pessoal dos Serviços';
                    RunObject = Page "Pess. dos Serviços Lista";
                }
            }
            group(Greves)
            {
                Caption = 'Greves';
                action("Greve")
                {
                    ApplicationArea = All;

                    Caption = 'Greve';
                    RunObject = Page "Greve Lista";
                }
            }
            group(Mapas)
            {
                Caption = 'Mapas';

                group(Employee)
                {
                    Caption = 'Empregados';

                    action("Ficha Empregado")
                    {
                        ApplicationArea = All;

                        Caption = 'Ficha Empregado';
                        RunObject = Report "Ficha Empregado";
                    }
                    action("Ausência por Empregado")
                    {
                        ApplicationArea = All;

                        Caption = 'Ausência por Empregado';
                        RunObject = Report "Ausência por Empregado";
                    }
                    action("Horas Extra por Empregado")
                    {
                        ApplicationArea = All;

                        Caption = 'Horas Extra por Empregado';
                        RunObject = Report "Horas Extra por Empregado";
                    }
                    action("Mapa Férias Empregado")
                    {
                        ApplicationArea = All;

                        Caption = 'Mapa Férias Empregado';
                        RunObject = Report "Mapa Férias Empregado";
                    }
                    action("Horario Empregado")
                    {
                        ApplicationArea = All;

                        Caption = 'Horário Empregado';
                        RunObject = Report "Horario Empregado";
                    }
                    action("Empregado - Etiquetas")
                    {
                        ApplicationArea = All;

                        Caption = 'Empregado - Etiquetas';
                        RunObject = Report "Empregado - Etiquetas";
                    }
                    action("Empregado - Inf. Artigos Div")
                    {
                        ApplicationArea = All;

                        Caption = 'Empregado - Inf. Artigos Div';
                        RunObject = Report "Empregado - Inf. Artigos Div";
                    }
                    action("Empregado - Qualificações")
                    {
                        ApplicationArea = All;

                        Caption = 'Empregado - Qualificações';
                        RunObject = Report "Empregado - Qualificações";
                    }
                    action("Empregado - Aniversários")
                    {
                        ApplicationArea = All;

                        Caption = 'Empregado - Aniversários';
                        RunObject = Report "Empregado - Aniversários";
                    }
                    action("Empregado - Contratos")
                    {
                        ApplicationArea = All;

                        Caption = 'Empregado - Contratos';
                        RunObject = Report "Empregado - Contratos";
                    }
                    action("Declaração")
                    {
                        ApplicationArea = All;

                        Caption = 'Declaração';
                        RunObject = Report "Declarações RH BC";
                    }
                    action("Declaração Anual Rendimentos")
                    {
                        ApplicationArea = All;

                        Caption = 'Declaração Anual Rendimentos';
                        RunObject = Report "Declaração Anual Rendimentos";
                    }
                    action("Ausências por Motivo")
                    {
                        ApplicationArea = All;

                        Caption = 'Ausências por Motivo';
                        RunObject = Report "Ausências por Motivo";
                    }
                    action("Horas Extra por Tipo")
                    {
                        ApplicationArea = All;

                        Caption = 'Horas Extra por Tipo';
                        RunObject = Report "Horas Extra por Tipo";
                    }
                }

                group(OpenProcess)
                {
                    Caption = 'Processamento Aberto';

                    action("Resumo Processamento Aberto")
                    {
                        ApplicationArea = All;

                        Caption = 'Resumo Processamento';
                        Image = EntriesList;
                        RunObject = Report "Mapa Resumo Processamento";
                    }
                    action("Folha Remunerações Aberto")
                    {
                        ApplicationArea = All;

                        Caption = 'Folha Remunerações';
                        Image = ContractPayment;
                        RunObject = Report "Folha Remunerações";
                    }
                    action("Segurança Social Aberto")
                    {
                        ApplicationArea = All;

                        Caption = 'Segurança Social';
                        Image = SocialSecurityTax;
                        RunObject = Report "Mapa Seg. Social - Aberto";
                    }
                    action("Transferência Bancária Aberto")
                    {
                        ApplicationArea = All;

                        Caption = 'Transferência Bancária';
                        Image = TransferFunds;
                        RunObject = Report "Mapa Transferência Bancária";
                    }
                    action("Companhia Seguros Aberto")
                    {
                        ApplicationArea = All;

                        Caption = 'Companhia Seguros';
                        Image = Insurance;
                        RunObject = Report "Mapa Companhia Seguros";
                    }
                    action("Mapa ADSE Aberto")
                    {
                        ApplicationArea = All;

                        Caption = 'Mapa ADSE';
                        Image = Insurance;
                        RunObject = Report "Mapa ADSE - Aberto";
                    }
                }

                group(ClosedProcess)
                {
                    Caption = 'Processamento Fechado';

                    action("Resumo Processamento")
                    {
                        ApplicationArea = All;

                        Caption = 'Resumo Processamento';
                        Image = EntriesList;
                        RunObject = Report "Mapa Resumo Processamento";
                    }
                    action("Resumo Processamento B")
                    {
                        ApplicationArea = All;

                        Caption = 'Resumo Processamento B';
                        Image = EntriesList;
                        RunObject = Report "Mapa Resumo Processamento B";
                    }
                    action("Folha Remunerações")
                    {
                        ApplicationArea = All;

                        Caption = 'Folha Remunerações';
                        Image = ContractPayment;
                        RunObject = Report "Folha Remunerações";
                    }
                    action("Segurança Social")
                    {
                        ApplicationArea = All;

                        Caption = 'Segurança Social';
                        Image = SocialSecurityTax;
                        RunObject = Report "Mapa Seg. Social - Fechado";
                    }
                    action("Transferência Bancária")
                    {
                        ApplicationArea = All;

                        Caption = 'Transferência Bancária';
                        Image = TransferFunds;
                        RunObject = Report "Mapa Transferência Bancária";
                    }
                    action("Companhia Seguros")
                    {
                        ApplicationArea = All;

                        Caption = 'Companhia Seguros';
                        Image = Insurance;
                        RunObject = Report "Mapa e Ficheiro - Seguros";
                    }
                    action("Retenção Mensal de IRS")
                    {
                        ApplicationArea = All;

                        Caption = 'Retenção Mensal de IRS';
                        RunObject = Report "Retenção Mensal de IRS";
                    }
                    action("Declaração Mensal Remu. AT")
                    {
                        ApplicationArea = All;

                        Caption = 'Declaração Mensal Remu. AT';
                        RunObject = Report "Declaração Mensal Remu. AT";
                    }
                    action("Mapa Dec. Mensal Remu. AT")
                    {
                        ApplicationArea = All;

                        Caption = 'Mapa Dec. Mensal Remu. AT';
                        RunObject = Report "Mapa Dec. Mensal Remu. AT";
                    }
                    action("Mapa Fundos Compensação Trab.")
                    {
                        ApplicationArea = All;

                        Caption = 'Mapa Fundos Compensação Trab.';
                        RunObject = Report "Mapa Fundos Compensação Trab.";
                    }
                    action("Mapa Sindicato")
                    {
                        ApplicationArea = All;

                        Caption = 'Mapa Sindicato';
                        RunObject = Report "Mapa Sindicato";
                    }
                    action("Mapa Pagamento por Cheque/Num")
                    {
                        ApplicationArea = All;

                        Caption = 'Mapa Pagamento por Cheque/Num';
                        RunObject = Report "Mapa Pagamento por Cheque/Num";
                    }
                    action("Mapa Acumulados")
                    {
                        ApplicationArea = All;

                        Caption = 'Mapa Acumulados';
                        RunObject = Report "Mapa Acumulados";
                    }
                    action("Mapa Integração Contabilística")
                    {
                        ApplicationArea = All;

                        Caption = 'Mapa Integração Contabilística';
                        RunObject = Report "Mapa Integração Contabilística";
                    }
                    action("Mapa ADSE")
                    {
                        ApplicationArea = All;

                        Caption = 'Mapa ADSE';
                        RunObject = Report "Mapa ADSE - Aberto";
                    }

                }
            }

            group("Administration")
            {
                Caption = 'Administração';
                action("Config. Recursos Humanos")
                {
                    ApplicationArea = All;

                    Caption = 'Config. Recursos Humanos';
                    RunObject = page "Config. Recursos Humanos";
                }
                action("Estabelecimentos da Empresa")
                {
                    ApplicationArea = All;

                    Caption = 'Estabelecimentos da Empresa';
                    RunObject = page "Estabelecimentos da Empresa";
                }
                action("Unid. Medida Recursos Humanos")
                {
                    ApplicationArea = All;

                    Caption = 'Unid. Medida Recursos Humanos';
                    RunObject = page "Unid. Medida Recursos Humanos";
                }
                action("Feriados RH")
                {
                    ApplicationArea = All;

                    Caption = 'Feriados';
                    RunObject = page "Feriados RH";
                }
                action("Contratos Trabalho")
                {
                    ApplicationArea = All;

                    Caption = 'Contratos Trabalho';
                    RunObject = page "Contratos Trabalho";
                }
                action("Categoria Profissional Interna")
                {
                    ApplicationArea = All;

                    Caption = 'Categoria Profissional Interna';
                    RunObject = page "Categoria Profissional Interna";
                }
                action("Categoria Profissional QP")
                {
                    ApplicationArea = All;

                    Caption = 'Categoria Profissional QP';
                    RunObject = page "Categoria Profissional QP";
                }
                action("Qualificações")
                {
                    ApplicationArea = All;

                    Caption = 'Qualificações';
                    RunObject = page "Qualificações";
                }
                action("Horário RH")
                {
                    ApplicationArea = All;

                    Caption = 'Horário';
                    RunObject = page "Horário RH";
                }
                action("Artigos Diversos")
                {
                    ApplicationArea = All;

                    Caption = 'Artigos Diversos';
                    RunObject = page "Artigos Diversos";
                }
                action("Departamentos Empregado")
                {
                    ApplicationArea = All;

                    Caption = 'Departamentos Empregado';
                    RunObject = page "Departamentos Empregado";
                }
                action("Lista Rubrica Salarial")
                {
                    ApplicationArea = All;

                    Caption = 'Lista Rubrica Salarial';
                    RunObject = page "Lista Rubrica Salarial";
                }
                action("Tabela IRS")
                {
                    ApplicationArea = All;

                    Caption = 'Tabela IRS';
                    RunObject = page "Tabela IRS";
                }
                action("Tabelas Sobretaxa")
                {
                    ApplicationArea = All;

                    Caption = 'Tabelas Sobretaxa';
                    RunObject = page "Tabelas Sobretaxa";
                }
                action("Instituição Seg. Social")
                {
                    ApplicationArea = All;

                    Caption = 'Instituição Seg. Social';
                    RunObject = page "Instituição Seg. Social";
                }
                action("Regime Seg. Social")
                {
                    ApplicationArea = All;

                    Caption = 'Regime Seg. Social';
                    RunObject = page "Regime Seg. Social";
                }
                action("Código IRCT")
                {
                    ApplicationArea = All;

                    Caption = 'Código IRCT';
                    RunObject = page "Código IRCT";
                }
                action("Actividades Económicas")
                {
                    ApplicationArea = All;

                    Caption = 'Actividades Económicas';
                    RunObject = page "Lista Actividades Económicas";
                }
                action("Natureza Jurídica")
                {
                    ApplicationArea = All;

                    Caption = 'Natureza Jurídica';
                    RunObject = page "Lista Natureza Jurídica";
                }
                action("Motivos Ausência")
                {
                    ApplicationArea = All;

                    Caption = 'Motivos Ausência';
                    RunObject = page "Motivos Ausência";
                }
                action("Tipos Horas Extra")
                {
                    ApplicationArea = All;

                    Caption = 'Tipos Horas Extra';
                    RunObject = page "Tipos Horas Extra";
                }
                action("Habilitação")
                {
                    ApplicationArea = All;

                    Caption = 'Habilitação';
                    RunObject = page "Habilitação";
                }
                action("Confidencial")
                {
                    ApplicationArea = All;

                    Caption = 'Confidencial';
                    RunObject = page "Confidencial";
                }
                action("Familiares")
                {
                    ApplicationArea = All;

                    Caption = 'Familiares';
                    RunObject = page "Familiares";
                }
                action("Sindicatos")
                {
                    ApplicationArea = All;

                    Caption = 'Sindicatos';
                    RunObject = page "Sindicatos";
                }
                action("Tipo Empregado")
                {
                    ApplicationArea = All;

                    Caption = 'Tipo Empregado';
                    RunObject = page "Lista Tipo Empregado";
                }
                action("Relatório Único")
                {
                    ApplicationArea = All;

                    Caption = 'Relatório Único';
                    RunObject = page "RU";
                }
                action("Importação Templates")
                {
                    ApplicationArea = All;

                    Caption = 'Importação Templates';
                    RunObject = page "Importação Templates";
                }
                action("Grau Função")
                {
                    ApplicationArea = All;

                    Caption = 'Grau Função';
                    RunObject = page "Grau Função";
                }
                action("Códigos Situação")
                {
                    ApplicationArea = All;

                    Caption = 'Códigos Situação';
                    RunObject = page "Lista Códigos Situação";
                }
            }
        }
    }
    var
        SimulPage: Page "Simulador de Remunerações";

}

