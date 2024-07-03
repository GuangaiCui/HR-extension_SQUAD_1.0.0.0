page 53035 "Ficha Empregado"
{
    // ww
    // Tagus - Novo campo NIB cartao Ref

    CaptionML = ENU = 'Employee Card', PTG = 'Ficha Empregado';
    PageType = Card;
    SourceTable = Empregado;

    layout
    {
        area(content)
        {
            group(Geral)
            {
                CaptionML = ENU = 'General', PTG = 'Geral';
                field("No."; Rec."No.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field(Initials; Initials)
                {
                    ApplicationArea = All;
                }
                field(Address; Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; "Address 2")
                {
                    ApplicationArea = All;
                }
                field(Locality; Locality)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = All;
                }
                field(City; City)
                {
                    ApplicationArea = All;
                }
                field("Cod. Freguesia"; "Cod. Freguesia")
                {
                    ApplicationArea = All;
                }
                field(Freguesia; Freguesia)
                {
                    ApplicationArea = All;
                }
                field(County; County)
                {
                    ApplicationArea = All;
                }
                field("Country Code"; "Country Code")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; "Job Title")
                {
                    ApplicationArea = All;
                }
                field("Tipo Empregado"; "Tipo Empregado")
                {
                    ApplicationArea = All;
                }
                field("Search Name"; "Search Name")
                {
                    ApplicationArea = All;
                }
                field(Sex; Sex)
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    ApplicationArea = All;
                }
                field("No. antigo do Empregado"; "No. antigo do Empregado")
                {
                    ApplicationArea = All;
                }
                field("NAV User Id"; "NAV User Id")
                {
                    ApplicationArea = All;
                }
                field(Docente; Docente)
                {
                    ApplicationArea = All;
                }
                field("Nº Professor"; "Nº Professor")
                {
                    ApplicationArea = All;
                }
                field("Exportar para o MISI"; "Exportar para o MISI")
                {
                    ApplicationArea = All;
                }
                field(Intern; Intern)
                {
                    ApplicationArea = All;
                }
                field("Orgão Social"; "Orgão Social")
                {
                    ApplicationArea = All;
                }
            }
            group("Comunicação")
            {
                Caption = 'Communication';
                field("Company Phone No."; "Company Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Extension; Extension)
                {
                    ApplicationArea = All;
                }
                field(CompanyMobilePhoneNo; CompanyMobilePhoneNo)
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Phone No.2"; "Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Mobile Phone No."; "Mobile Phone No.")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = EMail;
                }
                field("Company E-Mail"; "Company E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Envio Recibo via E-Mail"; "Envio Recibo via E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Endereço de Envio"; "Endereço de Envio")
                {
                    ApplicationArea = All;
                }
                field("Alt. Address Code"; "Alt. Address Code")
                {
                    ApplicationArea = All;
                }
                field("Alt. Address Start Date"; "Alt. Address Start Date")
                {
                    ApplicationArea = All;
                }
                field("Alt. Address End Date"; "Alt. Address End Date")
                {
                    ApplicationArea = All;
                }
            }
            group("Administração")
            {
                Caption = 'Administration';
                field(Status; Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Statistics Group Code"; "Statistics Group Code")
                {
                    ApplicationArea = All;
                }
                field(Estabelecimento; Estabelecimento)
                {
                    ApplicationArea = All;
                }
                field(Seguradora; Seguradora)
                {
                    ApplicationArea = All;
                }
                field("No. Apólice"; "No. Apólice")
                {
                    ApplicationArea = All;
                }
                field("Employment Date"; "Employment Date")
                {
                    ApplicationArea = All;
                }
                field("Data de Antiguidade"; "Data de Antiguidade")
                {
                    ApplicationArea = All;
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = All;
                }
                field("Motivo de Terminação"; "Motivo de Terminação")
                {
                    ApplicationArea = All;
                }
                field("Cod. Regime Reforma Aplicado"; "Cod. Regime Reforma Aplicado")
                {
                    ApplicationArea = All;
                }
                field("Regime Reforma Aplicado"; "Regime Reforma Aplicado")
                {
                    ApplicationArea = All;
                }
                field(IBAN; IBAN)
                {
                    ApplicationArea = All;
                }
                field("SWIFT Code"; "SWIFT Code")
                {
                    ApplicationArea = All;
                }
                field("Usa Transf. Bancária"; "Usa Transf. Bancária")
                {
                    ApplicationArea = All;
                }
                field("Cód. Banco Transf."; "Cód. Banco Transf.")
                {
                    ApplicationArea = All;
                }
                field(Pagamento; Pagamento)
                {
                    ApplicationArea = All;
                }
                field("Nome Livro Diario Pag."; "Nome Livro Diario Pag.")
                {
                    ApplicationArea = All;
                }
                field("Secção Diario Pag."; "Secção Diario Pag.")
                {
                    ApplicationArea = All;

                }
                field("Conta Pag."; "Conta Pag.")
                {
                    ApplicationArea = All;

                }
                field("NIB Cartao Ref"; "NIB Cartao Ref")
                {
                }
            }
            group(Pessoal)
            {

                Caption = 'Personal';
                field("Birth Date"; "Birth Date")
                {
                    ApplicationArea = All;

                    Importance = Promoted;
                }
                field(Naturalidade; Naturalidade)
                {
                    ApplicationArea = All;

                }
                field("Naturalidade - Concelho"; "Naturalidade - Concelho")
                {
                    ApplicationArea = All;

                }
                field(Nacionalidade; Nacionalidade)
                {
                    ApplicationArea = All;

                }
                field("Nacionalidade Descrição"; "Nacionalidade Descrição")
                {
                    ApplicationArea = All;

                }
                field("Documento Identificação"; "Documento Identificação")
                {
                    ApplicationArea = All;

                    Importance = Promoted;
                }
                field("No. Doc. Identificação"; "No. Doc. Identificação")
                {
                    ApplicationArea = All;

                    Importance = Promoted;
                }
                field("Local Emissão Doc. Ident."; "Local Emissão Doc. Ident.")
                {
                    ApplicationArea = All;

                }
                field("Data Doc. Ident."; "Data Doc. Ident.")
                {
                    ApplicationArea = All;

                }
                field("Data Validade Doc. Ident."; "Data Validade Doc. Ident.")
                {
                    ApplicationArea = All;

                }
                field("Vitalício"; Vitalício)
                {
                    ApplicationArea = All;

                }
                field("Union Code"; "Union Code")
                {
                    ApplicationArea = All;

                }
                field("Union Membership No."; "Union Membership No.")
                {
                }
            }
            group(IRS)
            {

                field("No. Contribuinte"; "No. Contribuinte")
                {
                    ApplicationArea = All;

                    Importance = Promoted;
                }
                field("Tipo Contribuinte"; "Tipo Contribuinte")
                {
                    ApplicationArea = All;

                    Importance = Promoted;
                }
                field("Cod. Repartição Finanças"; "Cod. Repartição Finanças")
                {
                    ApplicationArea = All;

                }
                field("Repartição Finanças"; "Repartição Finanças")
                {
                    ApplicationArea = All;

                }
                field("Data Emissão NIF"; "Data Emissão NIF")
                {
                    ApplicationArea = All;

                }
                field("Tipo Rendimento"; "Tipo Rendimento")
                {
                    ApplicationArea = All;

                }
                field("Local Obtenção Rendimento"; "Local Obtenção Rendimento")
                {
                    ApplicationArea = All;

                }
                field("Estado Civil"; "Estado Civil")
                {
                    ApplicationArea = All;

                }
                field("Civil State Date"; "Civil State Date")
                {
                    ApplicationArea = All;

                }
                field("Titular Rendimentos"; "Titular Rendimentos")
                {
                    ApplicationArea = All;

                }
                field(Deficiente; Deficiente)
                {
                    ApplicationArea = All;

                }
                field("Conjuge Deficiente"; "Conjuge Deficiente")
                {
                    ApplicationArea = All;

                }
                field("No. Dependentes"; "No. Dependentes")
                {
                    ApplicationArea = All;

                }
                field("No. Dependentes Deficientes"; "No. Dependentes Deficientes")
                {
                    ApplicationArea = All;

                }
                field("Tabela IRS"; "Tabela IRS")
                {
                    ApplicationArea = All;

                    Caption = 'Tabela IRS';
                    Editable = false;
                }
                field("Descrição Tabela IRS"; "Descrição Tabela IRS")
                {
                    ApplicationArea = All;

                    Editable = false;
                }
                field("IRS %"; "IRS %")
                {
                    ApplicationArea = All;

                    Editable = false;
                }
                field("IRS % Fixa"; "IRS % Fixa")
                {
                    ApplicationArea = All;

                }
                field("IVA %"; "IVA %")
                {
                    ApplicationArea = All;

                }
            }
            group("Seg. Social")
            {

                field("Subscritor SS"; "Subscritor SS")
                {
                    ApplicationArea = All;

                }
                field("No. Segurança Social"; "No. Segurança Social")
                {
                    ApplicationArea = All;

                    Importance = Promoted;
                }
                field("Data da Admissão SS"; "Data da Admissão SS")
                {
                    ApplicationArea = All;

                }
                field("Data Emissão SS"; "Data Emissão SS")
                {
                    ApplicationArea = All;

                }
                field("Cod. Instituição SS"; "Cod. Instituição SS")
                {
                    ApplicationArea = All;

                }
                field("Cod. Regime SS"; "Cod. Regime SS")
                {
                    ApplicationArea = All;

                }
                field("Cód. Rúbrica Enc. Seg. Social"; "Cód. Rúbrica Enc. Seg. Social")
                {
                    ApplicationArea = All;

                }
            }
            group(CGA)
            {
                Caption = 'CGA';
                field("Subsccritor CGA"; "Subsccritor CGA")
                {
                    ApplicationArea = All;

                }
                field("Nº CGA"; "Nº CGA")
                {
                    ApplicationArea = All;

                }
                field("Data da Admissão CGA"; "Data da Admissão CGA")
                {
                    ApplicationArea = All;

                }
                field("Data de Emissão CGA"; "Data de Emissão CGA")
                {
                    ApplicationArea = All;

                }
                field("Nº Horas Docência Calc. Desct."; "Nº Horas Docência Calc. Desct.")
                {
                    ApplicationArea = All;

                }
                field("Professor Acumulação"; "Professor Acumulação")
                {
                    ApplicationArea = All;

                }
                field("CGA - Requisição"; "CGA - Requisição")
                {
                    ApplicationArea = All;

                }
                field("Cód. Rúbrica Enc. CGA"; "Cód. Rúbrica Enc. CGA")
                {
                    ApplicationArea = All;

                }
            }
            group(ADSE)
            {
                Caption = 'ADSE';
                field("Subscritor ADSE"; "Subscritor ADSE")
                {
                    ApplicationArea = All;

                }
                field("Nº ADSE"; "Nº ADSE")
                {
                    ApplicationArea = All;

                }
                field("Data da Admissão ADSE"; "Data da Admissão ADSE")
                {
                    ApplicationArea = All;

                }
                field("Data de Emissão ADSE"; "Data de Emissão ADSE")
                {
                    ApplicationArea = All;

                }
                field("Cód. Rúbrica Enc. ADSE"; "Cód. Rúbrica Enc. ADSE")
                {
                    ApplicationArea = All;

                }
            }
            group(Processamentos)
            {
                Caption = 'Processing';
                field("Valor Vencimento Base"; "Valor Vencimento Base")
                {
                    ApplicationArea = All;

                    Editable = false;
                    Importance = Promoted;
                }
                field("Valor Dia"; "Valor Dia")
                {
                    ApplicationArea = All;

                    Editable = false;
                }
                field("Valor Hora"; "Valor Hora")
                {
                    ApplicationArea = All;

                    Editable = false;
                }
                field("No. Horas Semanais"; "No. Horas Semanais")
                {
                    ApplicationArea = All;

                    Caption = 'Week Hours No.';
                }
                field("No. Horas Semanais Totais"; "No. Horas Semanais Totais")
                {
                    ApplicationArea = All;

                }
                field("No. dias de Trabalho Semanal"; "No. dias de Trabalho Semanal")
                {
                    ApplicationArea = All;

                }
                field("No. Dias Trabalho Mensal"; "No. Dias Trabalho Mensal")
                {
                    ApplicationArea = All;

                }
                field("Mês Proc. Sub. Férias"; "Mês Proc. Sub. Férias")
                {
                    ApplicationArea = All;

                }
                field("Última data Proc. Sub. Férias"; "Última data Proc. Sub. Férias")
                {
                    ApplicationArea = All;

                }
                field("Vacation Balance"; "Vacation Balance")
                {
                    ApplicationArea = All;

                }
            }
            group(Categoria)
            {
                Caption = 'Category';
                field("Cód. IRCT"; "Cód. IRCT")
                {
                    ApplicationArea = All;

                }
                field("Acordo Colectivo"; "Acordo Colectivo")
                {
                    ApplicationArea = All;

                }
                field("Descrição IRCT"; "Descrição IRCT")
                {
                    ApplicationArea = All;

                }
                field("Aplicabilidade do IRCT"; "Aplicabilidade do IRCT")
                {
                    ApplicationArea = All;

                }
                field("Cód. Cat. Profissional"; "Cód. Cat. Profissional")
                {
                    ApplicationArea = All;

                    Editable = false;
                    Enabled = false;
                }
                field("Descrição Cat Prof"; "Descrição Cat Prof")
                {
                    ApplicationArea = All;

                    Editable = false;
                    Enabled = false;
                }
                field("Cód. Cat. Prof QP"; "Cód. Cat. Prof QP")
                {
                    ApplicationArea = All;

                    Editable = false;
                    Enabled = false;
                }
                field("Descrição Cat Prof QP"; "Descrição Cat Prof QP")
                {
                    ApplicationArea = All;

                    Editable = false;
                    Enabled = false;
                }
                field("Class. Nac. Profi."; "Class. Nac. Profi.")
                {
                    ApplicationArea = All;

                }
                field("Descrição Class. Nac."; "Descrição Class. Nac.")
                {
                    ApplicationArea = All;

                }
                field("Cód. Habilitações"; "Cód. Habilitações")
                {
                    ApplicationArea = All;

                }
                field("Descrição Habilitações"; "Descrição Habilitações")
                {
                    ApplicationArea = All;

                }
                field("Qualificação"; Qualificação)
                {
                    ApplicationArea = All;

                }
                field("Formação-Situação face à freq."; "Formação-Situação face à freq.")
                {
                    ApplicationArea = All;

                }
                field("Situação Profissional"; "Situação Profissional")
                {
                    ApplicationArea = All;

                }
                field("Emplymt. Contract Code"; "Emplymt. Contract Code")
                {
                    ApplicationArea = All;

                    Editable = false;
                    Enabled = false;
                }
                field("Regime Duração Trabalho"; "Regime Duração Trabalho")
                {
                    ApplicationArea = All;

                }
                field("Duração do Tempo de Trabalho"; "Duração do Tempo de Trabalho")
                {
                    ApplicationArea = All;

                }
                field("Desc. Duração Tempo Trabalho"; "Desc. Duração Tempo Trabalho")
                {
                    ApplicationArea = All;

                }
                field("Cód. Horário"; "Cód. Horário")
                {
                    ApplicationArea = All;

                    Editable = false;
                    Enabled = false;
                }
                field(Control1000000048; "Grau Função")
                {
                    ApplicationArea = All;

                }
                field("Descrição Grau Função"; "Descrição Grau Função")
                {
                    ApplicationArea = All;

                }
                field("Grau Função-Efeitos Progres."; "Grau Função-Efeitos Progres.")
                {
                    ApplicationArea = All;

                }
                field("Descrição Grau Função Progr."; "Descrição Grau Função Progr.")
                {
                    ApplicationArea = All;

                }
                field(Control1000000056; Profissionalização)
                {
                    ApplicationArea = All;

                    Editable = false;
                    Enabled = false;
                }
                field("Habilitação Docência"; "Habilitação Docência")
                {
                    ApplicationArea = All;

                }
                field("Grupo Docência"; "Grupo Docência")
                {
                    ApplicationArea = All;

                }
                field("Acumulação"; Acumulação)
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
                    field("Nº Horas Sem. Lect Diurno Cont"; "Nº Horas Sem. Lect Diurno Cont")
                    {
                        ApplicationArea = All;

                    }
                    field("Nº Horas Sem. Lect Diurno Tota"; "Nº Horas Sem. Lect Diurno Tota")
                    {
                        ApplicationArea = All;

                    }
                    field("Nº Horas Sem. Lect Noct Cont"; "Nº Horas Sem. Lect Noct Cont")
                    {
                        ApplicationArea = All;

                    }
                    field("Nº Horas Sem. Lect Noct Tota"; "Nº Horas Sem. Lect Noct Tota")
                    {
                        ApplicationArea = All;

                    }
                }
                group("Horas Semanais Desporto Escolar")
                {
                    Caption = 'Horas Semanais Desporto Escolar';
                    field("Nº Horas Sem.-Desp Escolar Con"; "Nº Horas Sem.-Desp Escolar Con")
                    {
                        ApplicationArea = All;

                    }
                    field("Nº Horas Sem.-Desp Escolar Tot"; "Nº Horas Sem.-Desp Escolar Tot")
                    {
                        ApplicationArea = All;

                    }
                }
                group("Horas Semanais Direção Pedagógica")
                {

                    Caption = 'Horas Semanais Direção Pedagógica';
                    field("Nº Horas Sem.-Dir.Pedag Cont"; "Nº Horas Sem.-Dir.Pedag Cont")
                    {
                        ApplicationArea = All;

                    }
                    field("Nº Horas Sem.-Dir.Pedag Tot"; "Nº Horas Sem.-Dir.Pedag Tot")
                    {
                        ApplicationArea = All;

                    }
                }
                group("Substituição Temporária")
                {
                    Caption = 'Substituição Temporária';
                    field(Control1000000070; "Substituição Temporária")
                    {
                        ApplicationArea = All;

                    }
                    field("NIF do Docente Substituido"; "NIF do Docente Substituido")
                    {
                        ApplicationArea = All;

                    }
                    field("Data Inicio Substituição"; "Data Inicio Substituição")
                    {
                        ApplicationArea = All;

                    }
                    field("Data Fim Substituição"; "Data Fim Substituição")
                    {
                        ApplicationArea = All;

                    }
                }
                field(ContratoME; ContratoME)
                {
                    ApplicationArea = All;

                }
                field("Direcção Pedagógica"; "Direcção Pedagógica")
                {
                    ApplicationArea = All;

                }
                field("Valor Desc. Conf. Religiosa"; "Valor Desc. Conf. Religiosa")
                {
                    ApplicationArea = All;

                }
                field("Valor Desc. Seguro"; "Valor Desc. Seguro")
                {
                    ApplicationArea = All;

                }
                field("Nº Dias Tempo Serviço"; "Nº Dias Tempo Serviço")
                {
                    ApplicationArea = All;

                }
                field("Dias de Serviço - Estabelecim."; "Dias de Serviço - Estabelecim.")
                {
                    ApplicationArea = All;

                }
                field("Situação"; Situação)
                {
                    ApplicationArea = All;

                }
                field("Descrição Situação"; "Descrição Situação")
                {
                    ApplicationArea = All;

                }
                field("Afecto à Cantina"; "Afecto à Cantina")
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
                SubPageLink = "Table ID" = CONST(53035),
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
                    RunPageLink = "Table ID" = CONST(53035),
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

                        CalcTaxaIRSEmpregado;
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
                            TestField("No. Horas Semanais");
                            //2009.02.26 -  fim

                            "Valor Vencimento Base" := FuncoesRH.CalcularVencimentoBase(WorkDate, Rec);
                            if "Valor Vencimento Base" <> 0 then begin
                                "No. Dias Trabalho Mensal" := FuncoesRH.CalcularDiasMes(Rec);
                                Modify;
                                Commit;
                                //FBC - RH-019
                                "Valor Dia" := FuncoesRH.CalcularValorDia("Valor Vencimento Base", Rec);
                                "Valor Hora" := FuncoesRH.CalcularValorHora("Valor Vencimento Base", Rec);
                                Modify;
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
                        Emp.SetRange(Emp."No.", "No.");
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
                        REPORT.RunModal(53037, true, false, TabEmpregado);
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
                        REPORT.RunModal(53041, true, false, TabEmpregado);
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
                        REPORT.RunModal(53040, true, false, TabEmpregado);
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
                    TabEmpregado.SetRange(TabEmpregado."No.", "No.");
                    REPORT.Run(53082, true, false, TabEmpregado);
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
        TabHistCabMovEmpr.SetRange(TabHistCabMovEmpr."No. Empregado", "No.");
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

        SetFilter("Data Filtro Inicio", '<=%1', WorkDate);
        SetFilter("Data Filtro Fim", '>=%1|=%2', WorkDate, 0D);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        exit(ValidaDatas);
    end;

    var
        [InDataSet]
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

        if ("Employment Date" = 0D) and (Status = Status::Active) and ("No." <> '') then begin  //HG 18.10.2007
            Message(Text0002, "No.");
            exit(false);
        end;

        if (Status = Status::Terminated) then begin
            if ("End Date" = 0D) then begin
                Message(Text0003, "No.");
                exit(false);
            end else
                if ("Motivo de Terminação" = '') then begin
                    Message(Text0004, "No.");
                    exit(false);
                end;
        end;

        exit(true);
    end;
}

