#pragma implicitwith disable
page 53035 "Ficha Empregado"
{
    // ww
    // Tagus - Novo campo NIB cartao Ref
    Caption = 'Ficha Empregado SQUAD';
    //TODO: to change name after hide original
    PageType = Card;
    SourceTable = Empregado;

    layout
    {
        area(content)
        {
            group(Geral)
            {
                field("No."; Rec."No.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field(Locality; Rec.Locality)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Cod. Freguesia"; Rec."Cod. Freguesia")
                {
                    ApplicationArea = All;
                }
                field(Freguesia; Rec.Freguesia)
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Tipo Empregado"; Rec."Tipo Empregado")
                {
                    ApplicationArea = All;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                }
                field(Sex; Rec.Sex)
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
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
            }
            group("Comunicação")
            {
                Caption = 'Communication';
                field("Company Phone No."; Rec."Company Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Extension; Rec.Extension)
                {
                    ApplicationArea = All;
                }
                field(CompanyMobilePhoneNo; Rec.CompanyMobilePhoneNo)
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Phone No.2"; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = EMail;
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
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
                field("Alt. Address Code"; Rec."Alt. Address Code")
                {
                    ApplicationArea = All;
                }
                field("Alt. Address Start Date"; Rec."Alt. Address Start Date")
                {
                    ApplicationArea = All;
                }
                field("Alt. Address End Date"; Rec."Alt. Address End Date")
                {
                    ApplicationArea = All;
                }
            }
            group("Administração")
            {
                Caption = 'Administration';
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Statistics Group Code"; Rec."Statistics Group Code")
                {
                    ApplicationArea = All;
                }
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
                field("Employment Date"; Rec."Employment Date")
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
                field(IBAN; Rec.IBAN)
                {
                    ApplicationArea = All;
                }
                field("SWIFT Code"; Rec."SWIFT Code")
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
                field("Birth Date"; Rec."Birth Date")
                {
                    ApplicationArea = All;

                    Importance = Promoted;
                }
                field(Naturalidade; Rec.Naturalidade)
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
                field("Union Code"; Rec."Union Code")
                {
                    ApplicationArea = All;

                }
                field("Union Membership No."; Rec."Union Membership No.")
                {
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
                field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
                {
                    ApplicationArea = All;

                    Editable = false;
                    Enabled = false;
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
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = All;

                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = All;

                Visible = true;
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(31003035),
                              "No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(BotaoEmp)
            {
                Caption = 'E&mployee';
                action("Co&mentários")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Folha Comentários RH";
                    RunPageLink = "Table Name" = CONST(Emp),
                                  "No." = FIELD("No.");
                }
                action("Dimensões")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(31003035),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                action("Ima&gem")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Picture';
                    Image = User;
                    RunObject = Page "Imagem Empregado";
                    RunPageLink = "No." = FIELD("No.");
                }
                action("F&amiliares")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Relatives';
                    Image = Relatives;
                    RunObject = Page "Familiares Empregado";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("E&ndereço Alternativo")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'E&ndereço Alternativo';
                    Image = Addresses;
                    RunObject = Page "Ficha Endç. Alternativo";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Informação Confidencial")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Confidential Information';
                    Image = ConfidentialOverview;
                    RunObject = Page "Informação Confidencial";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action(Attachments)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal;
                    end;
                }
            }
            group("Histórico")
            {
                Caption = '&History';
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
        area(processing)
        {
            group("Funções")
            {
                Caption = 'Funções';
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
                        TabEmpregado: Record Empregado;
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
                        Emp: Record Empregado;
                    begin
                        Emp.SetRange(Emp."No.", Rec."No.");
                        rCriarFichaEmp.SetTableView(Emp);
                        rCriarFichaEmp.Run;
                    end;
                }
            }
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
        area(reporting)
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
                    REPORT.Run(31003082, true, false, TabEmpregado);
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

    trigger OnDeleteRecord(): Boolean
    begin

        TabHistCabMovEmpr.Reset;
        TabHistCabMovEmpr.SetRange(TabHistCabMovEmpr."No. Empregado", Rec."No.");
        if TabHistCabMovEmpr.Find('-') then begin
            Message(Text0005);
            exit(false);
        end;
    end;

    trigger OnInit()
    begin
        MapPointVisible := true;
    end;

    trigger OnOpenPage()
    var
        MapMgt: Codeunit "Online Map Management";
    begin
        if not MapMgt.TestSetup then
            MapPointVisible := false;

        Rec.SetFilter("Data Filtro Inicio", '<=%1', WorkDate);
        Rec.SetFilter("Data Filtro Fim", '>=%1|=%2', WorkDate, 0D);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        exit(ValidaDatas);
    end;

    var
        MapPointVisible: Boolean;
        TabEmpregado: Record Empregado;
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

