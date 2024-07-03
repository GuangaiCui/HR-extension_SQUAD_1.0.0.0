page 31003068 "Config. Recursos Humanos"
{
    // 
    //  IT004 - Tagus - 20191121 - novo campo Balance Cash-Flow Code utilizado no pagamento de vencientos

    Caption = 'Human Resources Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Config. Recursos Humanos";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            group("Numeração")
            {
                Caption = 'Numbering';
                field("Employee Nos."; "Employee Nos.")
                {
                    ApplicationArea = All;

                }
                field("Base Unit of Measure"; "Base Unit of Measure")
                {
                    ApplicationArea = All;

                }
                field("Nome Livro Diario"; "Nome Livro Diario")
                {
                    ApplicationArea = All;

                }
                field("Secção Diario"; "Secção Diario")
                {
                    ApplicationArea = All;

                }
                field("Nos. Contratos"; "Nos. Contratos")
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field("Balance Cash-Flow Code"; "Balance Cash-Flow Code")
                {
                    ApplicationArea = All;

                }
            }
            group("Ausências")
            {
                Caption = 'Ausências';
                field("Valor Cálculo Ausências"; "Valor Cálculo Ausências")
                {
                    ApplicationArea = All;

                }
                field("Atribuição dias extra de féria"; "Atribuição dias extra de féria")
                {
                    ApplicationArea = All;

                }
                field("Limite dias falta abate SN/F"; "Limite dias falta abate SN/F")
                {
                    ApplicationArea = All;

                }
            }
            group("Sub. Alimentação")
            {
                Caption = 'Sub. Alimentação';
                field("Mês Abate Sub. Alimentação"; "Mês Abate Sub. Alimentação")
                {
                    ApplicationArea = All;

                }
                field("Abate Sub. Alim. dias gozo fer"; "Abate Sub. Alim. dias gozo fer")
                {
                    ApplicationArea = All;

                }
                field("Usar Feriados calculo Sub Ali"; "Usar Feriados calculo Sub Ali")
                {
                    ApplicationArea = All;

                }
            }
            group("Responsável")
            {
                Caption = 'Responsável';
                field("Nome responsável RH"; "Nome responsável RH")
                {
                    ApplicationArea = All;

                }
                field("Telefone responsável RH"; "Telefone responsável RH")
                {
                    ApplicationArea = All;

                }
                field("Fax responsável RH"; "Fax responsável RH")
                {
                    ApplicationArea = All;

                }
                field("E-mail responsável RH"; "E-mail responsável RH")
                {
                    ApplicationArea = All;

                }
            }
            group("Trab. Independentes")
            {
                Caption = 'Trab. Independentes';
                field("%IRS"; "%IRS")
                {
                    ApplicationArea = All;

                }
                field("%IVA"; "%IVA")
                {
                    ApplicationArea = All;

                }
            }
            group(CGA)
            {
                Caption = 'CGA';
                field("Nº Serviço"; "Nº Serviço")
                {
                    ApplicationArea = All;

                }
                field("Nome Serviço"; "Nome Serviço")
                {
                    ApplicationArea = All;

                }
                field("Taxa Contributiva Empregado"; "Taxa Contributiva Empregado")
                {
                    ApplicationArea = All;

                }
                field("Taxa Contributiva Ent Patronal"; "Taxa Contributiva Ent Patronal")
                {
                    ApplicationArea = All;

                }
                field("NIPC CGA"; "NIPC CGA")
                {
                    ApplicationArea = All;

                }
            }
            group(ADSE)
            {
                Caption = 'ADSE';
                field("Taxa Contr. Empregado ADSE"; "Taxa Contr. Empregado ADSE")
                {
                    ApplicationArea = All;

                }
                field("Contribui. Ent. Patronal ADSE"; "Contribui. Ent. Patronal ADSE")
                {
                    ApplicationArea = All;

                }
                field("NIPC ADSE"; "NIPC ADSE")
                {
                    ApplicationArea = All;

                }
            }
            group(Outros)
            {
                Caption = 'Outros';
                field(Seguradora; Seguradora)
                {
                    ApplicationArea = All;

                }
                field("No. Apólice"; "No. Apólice")
                {
                    ApplicationArea = All;

                }
                field("Cod. Seguradora"; "Cod. Seguradora")
                {
                    ApplicationArea = All;

                }
                field("Mod10 - Incluir Fornecedores"; "Mod10 - Incluir Fornecedores")
                {
                    ApplicationArea = All;

                }
                field("Mod10-Forn - Conta Valor Sujei"; "Mod10-Forn - Conta Valor Sujei")
                {
                    ApplicationArea = All;

                }
                field("Mod10-Forn - Conta Valor Reten"; "Mod10-Forn - Conta Valor Reten")
                {
                    ApplicationArea = All;

                }
                field("Ordenado Mínimo"; "Ordenado Mínimo")
                {
                    ApplicationArea = All;

                }
                field("Sobretaxa %"; "Sobretaxa %")
                {
                    ApplicationArea = All;

                    Caption = 'Sobretaxa %';
                }
            }
            group(Pagamentos)
            {
                Caption = 'Pagamentos';
                field("No. Conta Pag. Enc. SSocialEmp"; "No. Conta Pag. Enc. SSocialEmp")
                {
                    ApplicationArea = All;

                    Caption = 'No. Conta Pag. Enc. Seg. Social Empregado';
                }
                field("No. Conta Pag. Enc. SSocialPat"; "No. Conta Pag. Enc. SSocialPat")
                {
                    ApplicationArea = All;

                    Caption = 'No. Conta Pag. Enc. Seg. Social Ent. Patronal';
                }
                field("No. Conta Pag. Enc. CGA Emp"; "No. Conta Pag. Enc. CGA Emp")
                {
                    ApplicationArea = All;

                }
                field("No. Conta Pag. Enc. CGA Pat"; "No. Conta Pag. Enc. CGA Pat")
                {
                    ApplicationArea = All;

                }
                field("No. Conta Pag. IRS"; "No. Conta Pag. IRS")
                {
                    ApplicationArea = All;

                    Caption = 'No. Conta Pag. IRS';
                }
                field("No. Conta Pag. Enc. ADSE"; "No. Conta Pag. Enc. ADSE")
                {
                    ApplicationArea = All;

                }
                field("No. Conta Pag. Enc. ADSE Pat"; "No. Conta Pag. Enc. ADSE Pat")
                {
                    ApplicationArea = All;

                }
                field("No. Conta Pag. Enc. FCT-FGCT"; "No. Conta Pag. Enc. FCT-FGCT")
                {
                    ApplicationArea = All;

                    Caption = 'No. Conta Pag. Enc. FCT-FGCT';
                }
            }
            group(Avisos)
            {
                Caption = 'Avisos';
                field("Aniversários"; Aniversários)
                {
                    ApplicationArea = All;

                }
                field("Dias de antecedência Aniversár"; "Dias de antecedência Aniversár")
                {
                    ApplicationArea = All;

                    Caption = 'Dias de antecedência Aniversário';
                }
                field("Contratos a terminar"; "Contratos a terminar")
                {
                    ApplicationArea = All;

                }
                field("Dias de antecedência Contrato"; "Dias de antecedência Contrato")
                {
                    ApplicationArea = All;

                }
                field(Consultas; Consultas)
                {
                    ApplicationArea = All;

                }
                field("Dias de antecedência Consultas"; "Dias de antecedência Consultas")
                {
                    ApplicationArea = All;

                }
            }
            group("Sub. Férias")
            {
                Caption = 'Sub. Férias';
                field("Mês Acerto Sub. Férias"; "Mês Acerto Sub. Férias")
                {
                    ApplicationArea = All;

                }
                field("Pagamento total Sub. Férias"; "Pagamento total Sub. Férias")
                {
                    ApplicationArea = All;

                    Visible = false;
                }
            }
            group("Provisão Duodécimos")
            {
                Caption = 'Provisão Duodécimos';
                field("Nome Diário Duodécimos"; "Nome Diário Duodécimos")
                {
                    ApplicationArea = All;

                }
                field("Nome Secção Duodécimos"; "Nome Secção Duodécimos")
                {
                    ApplicationArea = All;

                }
                field("No. Meses"; "No. Meses")
                {
                    ApplicationArea = All;

                }
                group("Contas dos Duodécimos do Venc. Base")
                {
                    Caption = 'Contas dos Duodécimos do Venc. Base';
                    field("No. Conta Duo. SF"; "No. Conta Duo. SF")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Duo. SN"; "No. Conta Duo. SN")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Duo. F"; "No. Conta Duo. F")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Contrap. Duo. SF"; "No. Conta Contrap. Duo. SF")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Contrap. Duo. SN"; "No. Conta Contrap. Duo. SN")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Contrap. Duo. F"; "No. Conta Contrap. Duo. F")
                    {
                        ApplicationArea = All;

                    }
                }
                group("Contas dos Encargos dos Duodécimos")
                {
                    Caption = 'Contas dos Encargos dos Duodécimos';
                    field("No. Conta Enc. Duo. SF"; "No. Conta Enc. Duo. SF")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Enc. Duo. SN"; "No. Conta Enc. Duo. SN")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Enc. Duo. F"; "No. Conta Enc. Duo. F")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Contrap. Enc. Duo.SF"; "No. Conta Contrap. Enc. Duo.SF")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Contrap. Enc. Duo.SN"; "No. Conta Contrap. Enc. Duo.SN")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Contrap. Enc. Duo.F"; "No. Conta Contrap. Enc. Duo.F")
                    {
                        ApplicationArea = All;

                    }
                }
                group("Orgãos Sociais")
                {
                    Caption = 'Orgãos Sociais';
                    field("No. Conta Enc. Duo. SF OrgSoc"; "No. Conta Enc. Duo. SF OrgSoc")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Enc. Duo. SN OrgSoc"; "No. Conta Enc. Duo. SN OrgSoc")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Enc. Duo. F OrgSoc"; "No. Conta Enc. Duo. F OrgSoc")
                    {
                        ApplicationArea = All;

                    }
                }
            }
            group("Relatório Único")
            {
                Caption = 'Relatório Único';
                field("Caminho Exportação Rel. Único"; "Caminho Exportação Rel. Único")
                {
                    ApplicationArea = All;

                }
                field(Entidade; Entidade)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Reset;
        if not Get then begin
            Init;
            Insert;
        end;
    end;
}

