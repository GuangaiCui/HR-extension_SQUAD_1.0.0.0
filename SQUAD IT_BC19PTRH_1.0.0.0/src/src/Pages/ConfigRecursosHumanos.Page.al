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
            group("Pastas Azure")
            {
                Caption = 'Pastas Azure';
                field("Azure Files Storage Account"; Rec."Azure Files Storage Account")
                {

                }
                field("Azure Files Share Folder"; Rec."Azure Files Share Folder")
                {

                }

                field("Azure Files SaS Token"; Rec."Azure Files SaS Token")
                {

                }

                field("Azure Files Client Folder"; Rec."Azure Files Client Folder")
                {

                }
                field("Caminho Exportação Rel. Único "; Rec."Caminho Exportação Rel. Único")
                {


                }

            }
            group("Numeração")
            {
                Caption = 'Numbering';
                field("Employee Nos."; Rec."Employee Nos.")
                {


                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {


                }
                field("Nome Livro Diario"; Rec."Journal Template Name")
                {


                }
                field("Secção Diario"; Rec."Journal Batch Name")
                {


                }
                field("Nos. Contratos"; Rec."Nos. Contratos")
                {


                    Visible = false;
                }
                field("Balance Cash-Flow Code"; Rec."Balance Cash-Flow Code")
                {


                }
            }
            group("Ausências")
            {
                Caption = 'Ausências';
                field("Valor Cálculo Ausências"; Rec."Valor Cálculo Ausências")
                {


                }
                field("Atribuição dias extra de féria"; Rec."Atribuição dias extra de féria")
                {


                }
                field("Limite dias falta abate SN/F"; Rec."Limite dias falta abate SN/F")
                {


                }
            }
            group("Sub. Alimentação")
            {
                Caption = 'Sub. Alimentação';
                field("Mês Abate Sub. Alimentação"; Rec."Mês Abate Sub. Alimentação")
                {


                }
                field("Abate Sub. Alim. dias gozo fer"; Rec."Abate Sub. Alim. dias gozo fer")
                {


                }
                field("Usar Feriados calculo Sub Ali"; Rec."Use Holidays to Calc Lunch Sub")
                {


                }
            }
            group("Responsável")
            {
                Caption = 'Responsável';
                field("Nome responsável RH"; Rec."Name of HR Responsable")
                {


                }
                field("Telefone responsável RH"; Rec."Phone of HR Responsable")
                {


                }
                field("Fax responsável RH"; Rec."Fax of HR Responsable")
                {


                }
                field("E-mail responsável RH"; Rec."E-mail of HR Responsable")
                {


                }
            }
            group("Trab. Independentes")
            {
                Caption = 'Trab. Independentes';
                field("%IRS"; Rec."%IRS")
                {


                }
                field("%IVA"; Rec."%IVA")
                {


                }
            }
            group(CGA)
            {
                Caption = 'CGA';
                field("Nº Serviço"; Rec."Nº Serviço")
                {


                }
                field("Nome Serviço"; Rec."Nome Serviço")
                {


                }
                field("Taxa Contributiva Empregado"; Rec."Taxa Contributiva Empregado")
                {


                }
                field("Taxa Contributiva Ent Patronal"; Rec."Taxa Contributiva Ent Patronal")
                {


                }
                field("NIPC CGA"; Rec."NIPC CGA")
                {


                }
            }
            group(ADSE)
            {
                Caption = 'ADSE';
                field("Taxa Contr. Empregado ADSE"; Rec."Taxa Contr. Empregado ADSE")
                {


                }
                field("Contribui. Ent. Patronal ADSE"; Rec."Contribui. Ent. Patronal ADSE")
                {


                }
                field("NIPC ADSE"; Rec."NIPC ADSE")
                {


                }
            }
            group(Outros)
            {
                Caption = 'Outros';
                field(Seguradora; Rec."Insurance Company")
                {


                }
                field("No. Apólice"; Rec."No. Apólice")
                {


                }
                field("Cod. Seguradora"; Rec."Cod. Seguradora")
                {


                }
                field("Mod10 - Incluir Fornecedores"; Rec."Mod10 - Incluir Fornecedores")
                {


                }
                field("Mod10-Forn - Conta Valor Sujei"; Rec."Mod10-Forn - Conta Valor Sujei")
                {


                }
                field("Mod10-Forn - Conta Valor Reten"; Rec."Mod10-Forn - Conta Valor Reten")
                {


                }
                field("Ordenado Mínimo"; Rec."Ordenado Mínimo")
                {


                }
                field("Sobretaxa %"; Rec."Sobretaxa %")
                {


                    Caption = 'Sobretaxa %';
                }
                field("Version Model 10"; Rec."Version Model 10")
                { }
                field("Start Of New Table IRS"; Rec."Start Of New Table IRS")
                { }
            }
            group(Pagamentos)
            {
                Caption = 'Pagamentos';
                field("No. Conta Pag. Enc. SSocialEmp"; Rec."No. Conta Pag. Enc. SSocialEmp")
                {


                    Caption = 'No. Conta Pag. Enc. Seg. Social Empregado';
                }
                field("No. Conta Pag. Enc. SSocialPat"; Rec."No. Conta Pag. Enc. SSocialPat")
                {


                    Caption = 'No. Conta Pag. Enc. Seg. Social Ent. Patronal';
                }
                field("No. Conta Pag. Enc. CGA Emp"; Rec."No. Conta Pag. Enc. CGA Emp")
                {


                }
                field("No. Conta Pag. Enc. CGA Pat"; Rec."No. Conta Pag. Enc. CGA Pat")
                {


                }
                field("No. Conta Pag. IRS"; Rec."No. Conta Pag. IRS")
                {


                    Caption = 'No. Conta Pag. IRS';
                }
                field("No. Conta Pag. Enc. ADSE"; Rec."No. Conta Pag. Enc. ADSE")
                {


                }
                field("No. Conta Pag. Enc. ADSE Pat"; Rec."No. Conta Pag. Enc. ADSE Pat")
                {


                }
                field("No. Conta Pag. Enc. FCT-FGCT"; Rec."No. Conta Pag. Enc. FCT-FGCT")
                {


                    Caption = 'No. Conta Pag. Enc. FCT-FGCT';
                }
            }
            group(Avisos)
            {
                Caption = 'Avisos';
                field("Aniversários"; Rec."Aniversários")
                {


                }
                field("Dias de antecedência Aniversár"; Rec."Dias de antecedência Aniversár")
                {


                    Caption = 'Dias de antecedência Aniversário';
                }
                field("Contratos a terminar"; Rec."Contratos a terminar")
                {


                }
                field("Dias de antecedência Contrato"; Rec."Dias de antecedência Contrato")
                {


                }
                field(Consultas; Rec.Consultas)
                {


                }
                field("Dias de antecedência Consultas"; Rec."Dias de antecedência Consultas")
                {


                }
            }
            group("Sub. Férias")
            {
                Caption = 'Sub. Férias';
                field("Mês Acerto Sub. Férias"; Rec."Mês Acerto Sub. Férias")
                {


                }
                field("Pagamento total Sub. Férias"; Rec."Pagamento total Sub. Férias")
                {


                    Visible = false;
                }
            }
            group("Provisão Duodécimos")
            {
                Caption = 'Provisão Duodécimos';
                field("Nome Diário Duodécimos"; Rec."Nome Diário Duodécimos")
                {


                }
                field("Nome Secção Duodécimos"; Rec."Nome Secção Duodécimos")
                {


                }
                field("No. Meses"; Rec."No. Meses")
                {


                }
                group("Contas dos Duodécimos do Venc. Base")
                {
                    Caption = 'Contas dos Duodécimos do Venc. Base';
                    field("No. Conta Duo. SF"; Rec."No. Conta Duo. SF")
                    {


                    }
                    field("No. Conta Duo. SN"; Rec."No. Conta Duo. SN")
                    {


                    }
                    field("No. Conta Duo. F"; Rec."No. Conta Duo. F")
                    {


                    }
                    field("No. Conta Contrap. Duo. SF"; Rec."No. Conta Contrap. Duo. SF")
                    {


                    }
                    field("No. Conta Contrap. Duo. SN"; Rec."No. Conta Contrap. Duo. SN")
                    {


                    }
                    field("No. Conta Contrap. Duo. F"; Rec."No. Conta Contrap. Duo. F")
                    {


                    }
                }
                group("Contas dos Encargos dos Duodécimos")
                {
                    Caption = 'Contas dos Encargos dos Duodécimos';
                    field("No. Conta Enc. Duo. SF"; Rec."No. Conta Enc. Duo. SF")
                    {


                    }
                    field("No. Conta Enc. Duo. SN"; Rec."No. Conta Enc. Duo. SN")
                    {


                    }
                    field("No. Conta Enc. Duo. F"; Rec."No. Conta Enc. Duo. F")
                    {


                    }
                    field("No. Conta Contrap. Enc. Duo.SF"; Rec."No. Conta Contrap. Enc. Duo.SF")
                    {


                    }
                    field("No. Conta Contrap. Enc. Duo.SN"; Rec."No. Conta Contrap. Enc. Duo.SN")
                    {


                    }
                    field("No. Conta Contrap. Enc. Duo.F"; Rec."No. Conta Contrap. Enc. Duo.F")
                    {


                    }
                }
                group("Orgãos Sociais")
                {
                    Caption = 'Orgãos Sociais';
                    field("No. Conta Enc. Duo. SF OrgSoc"; Rec."No. Conta Enc. Duo. SF OrgSoc")
                    {


                    }
                    field("No. Conta Enc. Duo. SN OrgSoc"; Rec."No. Conta Enc. Duo. SN OrgSoc")
                    {


                    }
                    field("No. Conta Enc. Duo. F OrgSoc"; Rec."No. Conta Enc. Duo. F OrgSoc")
                    {


                    }
                }
            }
            group("Relatório Único")
            {
                Caption = 'Relatório Único';
                field("Caminho Exportação Rel. Único"; Rec."Caminho Exportação Rel. Único")
                {


                }
                field(Entidade; Rec.Entidade)
                {


                }
            }
        }
    }

    actions
    {
        area(Creation)
        {
            //HR_MIG_VC.S
            action("Criar Pastas Azure")
            {


                trigger OnAction()
                begin
                    //Criar pasta base
                    Rec.CreateDirectory(rec."Azure Files Client Folder");
                    //Criar pasta Caminho Relatorio Unico
                    Rec.CreateDirectory(rec."Caminho Exportação Rel. Único");

                end;
            }
            //HR_MIG_VC.E
        }
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

