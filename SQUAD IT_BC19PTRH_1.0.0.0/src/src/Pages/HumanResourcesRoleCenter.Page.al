page 53170 "Human Resources Role Center"
{
    Caption = 'Human Resources Role Center';
    PageType = RoleCenter;
    UsageCategory = Administration;
    ApplicationArea = All;


    layout
    {
        area(rolecenter)
        {
            group(Control1000000006)
            {
                ShowCaption = false;
                part(Control1000000005; MyEmpregado)
                {


                    Caption = 'Empregado';
                }
                part(Control1000000004; "MyRegistoAusências")
                {


                    Caption = 'Registro de Ausência';
                }
            }
            group(Control1000000003)
            {
                ShowCaption = false;
                part("Hist. Movs. Emp."; MyHistMovsEmp)
                {


                    Caption = 'Hist. Movs. Emp.';
                }
                systempart(Control1; MyNotes)
                {


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


                Caption = 'Employee';
                RunObject = Page "Lista Empregado";
            }
            action("Registo Ausências")
            {


                Caption = 'Absense Register';
                RunObject = Page "Registo Ausência";
            }
            action("Registo Abonos - Descontos Extra")
            {


                Caption = 'Registo Abonos - Descontos Extra';
                RunObject = Page "Registo Abonos-Descontos Extra";
            }
            action(Processamento)
            {


                Caption = 'Processing';
                RunObject = Page "Periodos Processamento";
            }
            action("Movimentos Empregado")
            {


                Caption = 'Movimentos Empregado';
                RunObject = Page "Lista Movs. Empregado";
            }
            action("Hist. Mov. Empregado")
            {


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


                    Caption = 'Employee';
                    Image = HumanResources;
                    RunObject = Page "Lista Empregado";
                }
                group(Tarefas)
                {
                    Caption = 'Tarefas';
                    action("Registo Ausência")
                    {


                        Caption = 'Registo Ausência';
                        Image = Absence;
                        RunObject = Page "Registo Ausência";
                    }
                    action("Registo Horas Extra")
                    {


                        Caption = 'Registo Horas Extra';
                        Image = CreateLinesFromTimesheet;
                        RunObject = Page "Registo Horas Extra";
                    }
                    action("Preparação Fecho Contas")
                    {


                        Caption = 'Preparação Fecho Contas';
                        Image = AccountingPeriods;
                        RunObject = Page "Preparação Fecho Contas";
                    }
                    action("Enviar Recibo via E-mail")
                    {


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


                        Caption = 'Recibo Vencimentos';
                        RunObject = Report "Recibo Vencimentos A5";
                    }
                    action("Recibo Vencimentos A4")
                    {


                        Caption = 'Recibo Vencimentos A4';
                        RunObject = Report "Recibo Vencimentos A4";
                    }
                }
                group("Simulator")
                {
                    Caption = 'Simulador';
                    action("Simulador de Remunerações")
                    {


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


                        Caption = 'Períodos Processamento';
                        Image = ReopenPeriod;
                        RunObject = Page "Periodos Processamento";
                    }
                    action("Processamento Vencimentos")
                    {


                        Caption = 'Processamento Vencimentos';
                        Image = PaymentPeriod;
                        RunObject = Report "Processamento Vencimentos";
                    }
                    action("Fecho Processamento")
                    {


                        Caption = 'Fecho Processamento';
                        Image = ClosePeriod;
                        RunObject = Report "Fecho Mês";
                    }
                    action("Integração Contabilística")
                    {


                        Caption = 'Integração Contabilística';
                        Image = InsertAccount;
                        RunObject = Report "Integração Contabilística";
                    }
                    action("Reabrir Processamento")
                    {


                        Caption = 'Reabrir Processamento';
                        Image = ClosePeriod;
                        RunObject = Report "Reabrir Processamento";
                    }
                    group(Pagamentos)
                    {
                        Caption = 'Pagamentos';
                        action(Vencimentos)
                        {


                            Caption = 'Vencimentos';
                            Image = ElectronicPayment;
                            RunObject = Report "Pagamento Vencimentos";
                        }
                        action(Encargos)
                        {


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


                        Caption = 'Processamento Sub. Férias';
                        RunObject = report "Processamento Sub. Férias";
                    }
                    action("Processamento Sub. Natal")
                    {


                        Caption = 'Processamento Sub. Natal';
                        RunObject = report "Processamento Sub. Natal";
                    }
                    action("Fecho Processamento SF/SN")
                    {


                        Caption = 'Fecho Processamento SF/SN';
                        Image = ClosePeriod;
                        RunObject = Report "Fecho Sub. Férias/Natal";
                    }
                    action("Mapa Modelo 10")
                    {


                        Caption = 'Mapa Modelo 10';
                        RunObject = report "Mapa Modelo 10";
                    }
                    action("Ficheiro Modelo 10")
                    {


                        Caption = 'Ficheiro Modelo 10';
                        RunObject = report "Ficheiro Modelo 10";
                    }
                    action("Mapa Trabalho Suplementar")
                    {


                        Caption = 'Mapa Trabalho Suplementar';
                        RunObject = report "Mapa Trabalho Suplementar";
                    }
                    action("Gerar Relatório Único")
                    {


                        Caption = 'Gerar Relatório Único';
                        RunObject = codeunit "Gerar Relatório Único";
                    }
                    group("Férias")
                    {
                        Caption = 'Férias';
                        action("Importar Férias")
                        {


                            Caption = 'Importar Férias';
                            RunObject = report "Importar Férias";
                        }
                        action("Marcar Férias Empregado")
                        {


                            Caption = 'Marcar Férias Empregado';
                            RunObject = page "Lista Férias Empregado";
                        }
                        action("Vista Férias Empregados")
                        {


                            Caption = 'Vista Férias Empregados';
                            RunObject = page "Vista Férias Empregados";
                        }
                        action("Férias - Mapa Férias Empregado")
                        {


                            Caption = 'Mapa Férias Empregado';
                            RunObject = report "Mapa Férias Empregado";
                        }
                        action("Mapa Férias Global")
                        {


                            Caption = 'Mapa Férias Global';
                            RunObject = report "Mapa Férias Global";
                        }
                        action("Listagem de Férias")
                        {


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


                    Caption = 'Lista Acções Formação';
                    RunObject = Page "Lista Acções Formação";
                }
                action("Registo Formação")
                {


                    Caption = 'Registo Formação';
                    Image = TaxPayment;
                    RunObject = Page "Registo Formação";
                }
                action("Formação por Empregado")
                {


                    Caption = 'Formação por Empregado';
                    RunObject = Report "Formação por Empregado";
                }
                action("Formação por Acção")
                {


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


                        Caption = 'Actividades dos Serviços';
                        RunObject = Page "Actividades dos Serviços";
                    }
                    action("Acções de Inf. Cons. For")
                    {


                        Caption = 'Acções de Inf. Cons. Formação';
                        RunObject = Page "Acções de Inf. Cons. For";
                    }
                    action("Identificação Factores de Risco")
                    {


                        Caption = 'Identificação Factores de Risco';
                        RunObject = Page "Factores de Risco";
                    }
                    action("Acções Médicas")
                    {


                        Caption = 'Acções Médicas';
                        RunObject = Page "Acções Médicas";
                    }
                    action("Acções Promoção da Saúde")
                    {


                        Caption = 'Acções Promoção da Saúde';
                        RunObject = Page "Acções Promoção da Saúde";
                    }
                }
                group("Acidentes Trab. e Doenças")
                {
                    Caption = 'Acidentes Trab. e Doenças';
                    action("Acidentes de Trabalho")
                    {


                        Caption = 'Acidentes de Trabalho';
                        RunObject = Page "Acidentes de Trabalho";
                    }
                    action("Doenças Profissionais")
                    {


                        Caption = 'Doenças Profissionais';
                        RunObject = Page "Doenças Profissionais";
                    }
                }
                action("Pessoal dos Serviços")
                {


                    Caption = 'Pessoal dos Serviços';
                    RunObject = Page "Pess. dos Serviços Lista";
                }
            }
            group(Greves)
            {
                Caption = 'Greves';
                action("Greve")
                {


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


                        Caption = 'Ficha Empregado';
                        RunObject = Report "Ficha Empregado";
                    }
                    action("Ausência por Empregado")
                    {


                        Caption = 'Ausência por Empregado';
                        RunObject = Report "Ausência por Empregado";
                    }
                    action("Horas Extra por Empregado")
                    {


                        Caption = 'Horas Extra por Empregado';
                        RunObject = Report "Horas Extra por Empregado";
                    }
                    action("Mapa Férias Empregado")
                    {


                        Caption = 'Mapa Férias Empregado';
                        RunObject = Report "Mapa Férias Empregado";
                    }
                    action("Horario Empregado")
                    {


                        Caption = 'Horário Empregado';
                        RunObject = Report "Horario Empregado";
                    }
                    action("Empregado - Etiquetas")
                    {


                        Caption = 'Empregado - Etiquetas';
                        RunObject = Report "Empregado - Etiquetas";
                    }
                    action("Empregado - Inf. Artigos Div")
                    {


                        Caption = 'Empregado - Inf. Artigos Div';
                        RunObject = Report "Empregado - Inf. Artigos Div";
                    }
                    action("Empregado - Qualificações")
                    {


                        Caption = 'Empregado - Qualificações';
                        RunObject = Report "Empregado - Qualificações";
                    }
                    action("Empregado - Aniversários")
                    {


                        Caption = 'Empregado - Aniversários';
                        RunObject = Report "Empregado - Aniversários";
                    }
                    action("Empregado - Contratos")
                    {


                        Caption = 'Empregado - Contratos';
                        RunObject = Report "Empregado - Contratos";
                    }
                    action("Declaração")
                    {


                        Caption = 'Declaração';
                        RunObject = Report "Declarações RH BC";
                    }
                    action("Declaração Anual Rendimentos")
                    {


                        Caption = 'Declaração Anual Rendimentos';
                        RunObject = Report "Declaração Anual Rendimentos";
                    }
                    action("Ausências por Motivo")
                    {


                        Caption = 'Ausências por Motivo';
                        RunObject = Report "Ausências por Motivo";
                    }
                    action("Horas Extra por Tipo")
                    {


                        Caption = 'Horas Extra por Tipo';
                        RunObject = Report "Horas Extra por Tipo";
                    }
                }

                group(OpenProcess)
                {
                    Caption = 'Processamento Aberto';

                    action("Resumo Processamento Aberto")
                    {


                        Caption = 'Resumo Processamento';
                        Image = EntriesList;
                        RunObject = Report "Mapa Resumo Processamento";
                    }
                    action("Folha Remunerações Aberto")
                    {


                        Caption = 'Folha Remunerações';
                        Image = ContractPayment;
                        RunObject = Report "Folha Remunerações";
                    }
                    action("Segurança Social Aberto")
                    {


                        Caption = 'Segurança Social';
                        Image = SocialSecurityTax;
                        RunObject = Report "Mapa Seg. Social - Aberto";
                    }
                    action("Transferência Bancária Aberto")
                    {


                        Caption = 'Transferência Bancária';
                        Image = TransferFunds;
                        RunObject = Report "Mapa Transferência Bancária";
                    }
                    action("Companhia Seguros Aberto")
                    {


                        Caption = 'Companhia Seguros';
                        Image = Insurance;
                        RunObject = Report "Mapa Companhia Seguros";
                    }
                    action("Mapa ADSE Aberto")
                    {


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


                        Caption = 'Resumo Processamento';
                        Image = EntriesList;
                        RunObject = Report "Mapa Resumo Processamento";
                    }
                    action("Resumo Processamento B")
                    {


                        Caption = 'Resumo Processamento B';
                        Image = EntriesList;
                        RunObject = Report "Mapa Resumo Processamento B";
                    }
                    action("Folha Remunerações")
                    {


                        Caption = 'Folha Remunerações';
                        Image = ContractPayment;
                        RunObject = Report "Folha Remunerações";
                    }
                    action("Segurança Social")
                    {


                        Caption = 'Segurança Social';
                        Image = SocialSecurityTax;
                        RunObject = Report "Mapa Seg. Social - Fechado";
                    }
                    action("Transferência Bancária")
                    {


                        Caption = 'Transferência Bancária';
                        Image = TransferFunds;
                        RunObject = Report "Mapa Transferência Bancária";
                    }
                    action("Companhia Seguros")
                    {


                        Caption = 'Companhia Seguros';
                        Image = Insurance;
                        RunObject = Report "Mapa e Ficheiro - Seguros";
                    }
                    action("Retenção Mensal de IRS")
                    {


                        Caption = 'Retenção Mensal de IRS';
                        RunObject = Report "Retenção Mensal de IRS";
                    }
                    action("Declaração Mensal Remu. AT")
                    {


                        Caption = 'Declaração Mensal Remu. AT';
                        RunObject = Report "Declaração Mensal Remu. AT";
                    }
                    action("Mapa Dec. Mensal Remu. AT")
                    {


                        Caption = 'Mapa Dec. Mensal Remu. AT';
                        RunObject = Report "Mapa Dec. Mensal Remu. AT";
                    }
                    action("Mapa Fundos Compensação Trab.")
                    {


                        Caption = 'Mapa Fundos Compensação Trab.';
                        RunObject = Report "Mapa Fundos Compensação Trab.";
                    }
                    action("Mapa Sindicato")
                    {


                        Caption = 'Mapa Sindicato';
                        RunObject = Report "Mapa Sindicato";
                    }
                    action("Mapa Pagamento por Cheque/Num")
                    {


                        Caption = 'Mapa Pagamento por Cheque/Num';
                        RunObject = Report "Mapa Pagamento por Cheque/Num";
                    }
                    action("Mapa Acumulados")
                    {


                        Caption = 'Mapa Acumulados';
                        RunObject = Report "Mapa Acumulados";
                    }
                    action("Mapa Integração Contabilística")
                    {


                        Caption = 'Mapa Integração Contabilística';
                        RunObject = Report "Mapa Integração Contabilística";
                    }
                    action("Mapa ADSE")
                    {


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


                    Caption = 'Config. Recursos Humanos';
                    RunObject = page "Config. Recursos Humanos";
                }
                action("Estabelecimentos da Empresa")
                {


                    Caption = 'Estabelecimentos da Empresa';
                    RunObject = page "Estabelecimentos da Empresa";
                }
                action("Unid. Medida Recursos Humanos")
                {


                    Caption = 'Unid. Medida Recursos Humanos';
                    RunObject = page "Unid. Medida Recursos Humanos";
                }
                action("Feriados RH")
                {


                    Caption = 'Feriados';
                    RunObject = page "Feriados RH";
                }
                action("Contratos Trabalho")
                {


                    Caption = 'Contratos Trabalho';
                    RunObject = page "Contratos Trabalho";
                }
                action("Categoria Profissional Interna")
                {


                    Caption = 'Categoria Profissional Interna';
                    RunObject = page "Categoria Profissional Interna";
                }
                action("Categoria Profissional QP")
                {


                    Caption = 'Categoria Profissional QP';
                    RunObject = page "Categoria Profissional QP";
                }
                action("Qualificações")
                {


                    Caption = 'Qualificações';
                    RunObject = page "Qualificações";
                }
                action("Horário RH")
                {


                    Caption = 'Horário';
                    RunObject = page "Horário RH";
                }
                action("Artigos Diversos")
                {


                    Caption = 'Artigos Diversos';
                    RunObject = page "Artigos Diversos";
                }
                action("Departamentos Empregado")
                {


                    Caption = 'Departamentos Empregado';
                    RunObject = page "Departamentos Empregado";
                }
                action("Lista Rubrica Salarial")
                {


                    Caption = 'Lista Rubrica Salarial';
                    RunObject = page "Lista Rubrica Salarial";
                }
                action("Tabela IRS")
                {


                    Caption = 'Tabela IRS';
                    RunObject = page "Tabela IRS";
                }
                action("Tabelas Sobretaxa")
                {


                    Caption = 'Tabelas Sobretaxa';
                    RunObject = page "Tabelas Sobretaxa";
                }
                action("Instituição Seg. Social")
                {


                    Caption = 'Instituição Seg. Social';
                    RunObject = page "Instituição Seg. Social";
                }
                action("Regime Seg. Social")
                {


                    Caption = 'Regime Seg. Social';
                    RunObject = page "Regime Seg. Social";
                }
                action("Código IRCT")
                {


                    Caption = 'Código IRCT';
                    RunObject = page "Código IRCT";
                }
                action("Actividades Económicas")
                {


                    Caption = 'Actividades Económicas';
                    RunObject = page "Lista Actividades Económicas";
                }
                action("Natureza Jurídica")
                {


                    Caption = 'Natureza Jurídica';
                    RunObject = page "Lista Natureza Jurídica";
                }
                action("Motivos Ausência")
                {


                    Caption = 'Motivos Ausência';
                    RunObject = page "Motivos Ausência";
                }
                action("Tipos Horas Extra")
                {


                    Caption = 'Tipos Horas Extra';
                    RunObject = page "Tipos Horas Extra";
                }
                action("Habilitação")
                {


                    Caption = 'Habilitação';
                    RunObject = page "Habilitação";
                }
                action("Confidencial")
                {


                    Caption = 'Confidencial';
                    RunObject = page "Confidencial";
                }
                action("Familiares")
                {


                    Caption = 'Familiares';
                    RunObject = page "Familiares";
                }
                action("Sindicatos")
                {


                    Caption = 'Sindicatos';
                    RunObject = page "Sindicatos";
                }
                action("Tipo Empregado")
                {


                    Caption = 'Tipo Empregado';
                    RunObject = page "Lista Tipo Empregado";
                }
                action("Relatório Único")
                {


                    Caption = 'Relatório Único';
                    RunObject = page "RU";
                }
                action("Importação Templates")
                {


                    Caption = 'Importação Templates';
                    RunObject = page "Importação Templates";
                }
                action("Grau Função")
                {


                    Caption = 'Grau Função';
                    RunObject = page "Grau Função";
                }
                action("Códigos Situação")
                {


                    Caption = 'Códigos Situação';
                    RunObject = page "Lista Códigos Situação";
                }
            }
        }
    }
    var
        SimulPage: Page "Simulador de Remunerações";

}

