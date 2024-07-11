#pragma implicitwith disable
page 53068 "Config. Recursos Humanos"
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
                field("Employee Nos."; Rec."Employee Nos.")
                {
                    ApplicationArea = All;

                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = All;

                }
                field("Nome Livro Diario"; Rec."Nome Livro Diario")
                {
                    ApplicationArea = All;

                }
                field("Secção Diario"; Rec."Secção Diario")
                {
                    ApplicationArea = All;

                }
                field("Nos. Contratos"; Rec."Nos. Contratos")
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field("Balance Cash-Flow Code"; Rec."Balance Cash-Flow Code")
                {
                    ApplicationArea = All;

                }
            }
            group("Ausências")
            {
                Caption = 'Ausências';
                field("Valor Cálculo Ausências"; Rec."Valor Cálculo Ausências")
                {
                    ApplicationArea = All;

                }
                field("Atribuição dias extra de féria"; Rec."Atribuição dias extra de féria")
                {
                    ApplicationArea = All;

                }
                field("Limite dias falta abate SN/F"; Rec."Limite dias falta abate SN/F")
                {
                    ApplicationArea = All;

                }
            }
            group("Sub. Alimentação")
            {
                Caption = 'Sub. Alimentação';
                field("Mês Abate Sub. Alimentação"; Rec."Mês Abate Sub. Alimentação")
                {
                    ApplicationArea = All;

                }
                field("Abate Sub. Alim. dias gozo fer"; Rec."Abate Sub. Alim. dias gozo fer")
                {
                    ApplicationArea = All;

                }
                field("Usar Feriados calculo Sub Ali"; Rec."Usar Feriados calculo Sub Ali")
                {
                    ApplicationArea = All;

                }
            }
            group("Responsável")
            {
                Caption = 'Responsável';
                field("Nome responsável RH"; Rec."Nome responsável RH")
                {
                    ApplicationArea = All;

                }
                field("Telefone responsável RH"; Rec."Telefone responsável RH")
                {
                    ApplicationArea = All;

                }
                field("Fax responsável RH"; Rec."Fax responsável RH")
                {
                    ApplicationArea = All;

                }
                field("E-mail responsável RH"; Rec."E-mail responsável RH")
                {
                    ApplicationArea = All;

                }
            }
            group("Trab. Independentes")
            {
                Caption = 'Trab. Independentes';
                field("%IRS"; Rec."%IRS")
                {
                    ApplicationArea = All;

                }
                field("%IVA"; Rec."%IVA")
                {
                    ApplicationArea = All;

                }
            }
            group(CGA)
            {
                Caption = 'CGA';
                field("Nº Serviço"; Rec."Nº Serviço")
                {
                    ApplicationArea = All;

                }
                field("Nome Serviço"; Rec."Nome Serviço")
                {
                    ApplicationArea = All;

                }
                field("Taxa Contributiva Empregado"; Rec."Taxa Contributiva Empregado")
                {
                    ApplicationArea = All;

                }
                field("Taxa Contributiva Ent Patronal"; Rec."Taxa Contributiva Ent Patronal")
                {
                    ApplicationArea = All;

                }
                field("NIPC CGA"; Rec."NIPC CGA")
                {
                    ApplicationArea = All;

                }
            }
            group(ADSE)
            {
                Caption = 'ADSE';
                field("Taxa Contr. Empregado ADSE"; Rec."Taxa Contr. Empregado ADSE")
                {
                    ApplicationArea = All;

                }
                field("Contribui. Ent. Patronal ADSE"; Rec."Contribui. Ent. Patronal ADSE")
                {
                    ApplicationArea = All;

                }
                field("NIPC ADSE"; Rec."NIPC ADSE")
                {
                    ApplicationArea = All;

                }
            }
            group(Outros)
            {
                Caption = 'Outros';
                field(Seguradora; Rec.Seguradora)
                {
                    ApplicationArea = All;

                }
                field("No. Apólice"; Rec."No. Apólice")
                {
                    ApplicationArea = All;

                }
                field("Cod. Seguradora"; Rec."Cod. Seguradora")
                {
                    ApplicationArea = All;

                }
                field("Mod10 - Incluir Fornecedores"; Rec."Mod10 - Incluir Fornecedores")
                {
                    ApplicationArea = All;

                }
                field("Mod10-Forn - Conta Valor Sujei"; Rec."Mod10-Forn - Conta Valor Sujei")
                {
                    ApplicationArea = All;

                }
                field("Mod10-Forn - Conta Valor Reten"; Rec."Mod10-Forn - Conta Valor Reten")
                {
                    ApplicationArea = All;

                }
                field("Ordenado Mínimo"; Rec."Ordenado Mínimo")
                {
                    ApplicationArea = All;

                }
                field("Sobretaxa %"; Rec."Sobretaxa %")
                {
                    ApplicationArea = All;

                    Caption = 'Sobretaxa %';
                }
            }
            group(Pagamentos)
            {
                Caption = 'Pagamentos';
                field("No. Conta Pag. Enc. SSocialEmp"; Rec."No. Conta Pag. Enc. SSocialEmp")
                {
                    ApplicationArea = All;

                    Caption = 'No. Conta Pag. Enc. Seg. Social Empregado';
                }
                field("No. Conta Pag. Enc. SSocialPat"; Rec."No. Conta Pag. Enc. SSocialPat")
                {
                    ApplicationArea = All;

                    Caption = 'No. Conta Pag. Enc. Seg. Social Ent. Patronal';
                }
                field("No. Conta Pag. Enc. CGA Emp"; Rec."No. Conta Pag. Enc. CGA Emp")
                {
                    ApplicationArea = All;

                }
                field("No. Conta Pag. Enc. CGA Pat"; Rec."No. Conta Pag. Enc. CGA Pat")
                {
                    ApplicationArea = All;

                }
                field("No. Conta Pag. IRS"; Rec."No. Conta Pag. IRS")
                {
                    ApplicationArea = All;

                    Caption = 'No. Conta Pag. IRS';
                }
                field("No. Conta Pag. Enc. ADSE"; Rec."No. Conta Pag. Enc. ADSE")
                {
                    ApplicationArea = All;

                }
                field("No. Conta Pag. Enc. ADSE Pat"; Rec."No. Conta Pag. Enc. ADSE Pat")
                {
                    ApplicationArea = All;

                }
                field("No. Conta Pag. Enc. FCT-FGCT"; Rec."No. Conta Pag. Enc. FCT-FGCT")
                {
                    ApplicationArea = All;

                    Caption = 'No. Conta Pag. Enc. FCT-FGCT';
                }
            }
            group(Avisos)
            {
                Caption = 'Avisos';
                field("Aniversários"; Rec."Aniversários")
                {
                    ApplicationArea = All;

                }
                field("Dias de antecedência Aniversár"; Rec."Dias de antecedência Aniversár")
                {
                    ApplicationArea = All;

                    Caption = 'Dias de antecedência Aniversário';
                }
                field("Contratos a terminar"; Rec."Contratos a terminar")
                {
                    ApplicationArea = All;

                }
                field("Dias de antecedência Contrato"; Rec."Dias de antecedência Contrato")
                {
                    ApplicationArea = All;

                }
                field(Consultas; Rec.Consultas)
                {
                    ApplicationArea = All;

                }
                field("Dias de antecedência Consultas"; Rec."Dias de antecedência Consultas")
                {
                    ApplicationArea = All;

                }
            }
            group("Sub. Férias")
            {
                Caption = 'Sub. Férias';
                field("Mês Acerto Sub. Férias"; Rec."Mês Acerto Sub. Férias")
                {
                    ApplicationArea = All;

                }
                field("Pagamento total Sub. Férias"; Rec."Pagamento total Sub. Férias")
                {
                    ApplicationArea = All;

                    Visible = false;
                }
            }
            group("Provisão Duodécimos")
            {
                Caption = 'Provisão Duodécimos';
                field("Nome Diário Duodécimos"; Rec."Nome Diário Duodécimos")
                {
                    ApplicationArea = All;

                }
                field("Nome Secção Duodécimos"; Rec."Nome Secção Duodécimos")
                {
                    ApplicationArea = All;

                }
                field("No. Meses"; Rec."No. Meses")
                {
                    ApplicationArea = All;

                }
                group("Contas dos Duodécimos do Venc. Base")
                {
                    Caption = 'Contas dos Duodécimos do Venc. Base';
                    field("No. Conta Duo. SF"; Rec."No. Conta Duo. SF")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Duo. SN"; Rec."No. Conta Duo. SN")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Duo. F"; Rec."No. Conta Duo. F")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Contrap. Duo. SF"; Rec."No. Conta Contrap. Duo. SF")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Contrap. Duo. SN"; Rec."No. Conta Contrap. Duo. SN")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Contrap. Duo. F"; Rec."No. Conta Contrap. Duo. F")
                    {
                        ApplicationArea = All;

                    }
                }
                group("Contas dos Encargos dos Duodécimos")
                {
                    Caption = 'Contas dos Encargos dos Duodécimos';
                    field("No. Conta Enc. Duo. SF"; Rec."No. Conta Enc. Duo. SF")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Enc. Duo. SN"; Rec."No. Conta Enc. Duo. SN")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Enc. Duo. F"; Rec."No. Conta Enc. Duo. F")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Contrap. Enc. Duo.SF"; Rec."No. Conta Contrap. Enc. Duo.SF")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Contrap. Enc. Duo.SN"; Rec."No. Conta Contrap. Enc. Duo.SN")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Contrap. Enc. Duo.F"; Rec."No. Conta Contrap. Enc. Duo.F")
                    {
                        ApplicationArea = All;

                    }
                }
                group("Orgãos Sociais")
                {
                    Caption = 'Orgãos Sociais';
                    field("No. Conta Enc. Duo. SF OrgSoc"; Rec."No. Conta Enc. Duo. SF OrgSoc")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Enc. Duo. SN OrgSoc"; Rec."No. Conta Enc. Duo. SN OrgSoc")
                    {
                        ApplicationArea = All;

                    }
                    field("No. Conta Enc. Duo. F OrgSoc"; Rec."No. Conta Enc. Duo. F OrgSoc")
                    {
                        ApplicationArea = All;

                    }
                }
            }
            group("Relatório Único")
            {
                Caption = 'Relatório Único';
                field("Caminho Exportação Rel. Único"; Rec."Caminho Exportação Rel. Único")
                {
                    ApplicationArea = All;

                }
                field(Entidade; Rec.Entidade)
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
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;
}

#pragma implicitwith restore

