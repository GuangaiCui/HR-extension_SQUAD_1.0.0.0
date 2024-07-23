report 53066 "Ficha Empregado"
{
    // //-------------------------------------------------------
    //               Ficha de  Empregado
    // //--------------------------------------------------------
    //   É um Mapa para listar a principal informação, associada
    //   a um Empregado.
    //   Este Report está disponível a partir de Mapas.
    // //-------------------------------------------------------
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/FichaEmpregado.rdlc';

    Caption = 'Ficha Empregado';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(Empregado; Employee)
        {
            RequestFilterFields = "No.", Status;
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(N__Contribuinte______TabConfEmpresa__VAT_Registration_No__; 'Nº Contribuinte: ' + TabConfEmpresa."VAT Registration No.")
            {
            }
            column(N__Telefone______TabConfEmpresa__Phone_No__; 'Nº Telefone: ' + TabConfEmpresa."Phone No.")
            {
            }
            column(TabConfEmpresa_City; TabConfEmpresa.City)
            {
            }
            column(TabConfEmpresa_Address; TabConfEmpresa.Address)
            {
            }
            column(TabConfEmpresa__Name_2_; TabConfEmpresa."Name 2")
            {
            }
            column(TabConfEmpresa_Name; TabConfEmpresa.Name)
            {
            }
            column(TabConfEmpresa__Post_Code_; TabConfEmpresa."Post Code")
            {
            }
            column(TabConfEmpresa_Picture; TabConfEmpresa.Picture)
            {
            }
            column(Empregado_Picture; Image)
            {
            }
            column(Empregado__No__; "No.")
            {
            }
            column(Empregado_Name; Name)
            {
            }
            column(Address__________Address_2_; Address + ' ' + "Address 2")
            {
            }
            column(Empregado__Tipo_Empregado_; "Tipo Empregado")
            {
            }
            column(Empregado__Job_Title_; "Job Title")
            {
            }
            column(Empregado_No_Professor; "Nº Professor")
            {
            }
            column(Empregado_Extension; Extension)
            {
            }
            column(Empregado_Pager; CompanyMobilePhoneNo)
            {
            }
            column(Empregado__Company_E_Mail_; "Company E-Mail")
            {
            }
            column(Empregado__Phone_No__; "Phone No.")
            {
            }
            column(Empregado__Mobile_Phone_No__; "Mobile Phone No.")
            {
            }
            column(Empregado__E_Mail_; "E-Mail")
            {
            }
            column(Empregado_Status; Status)
            {
            }
            column(Empregado__Statistics_Group_Code_; "Statistics Group Code")
            {
            }
            column(Empregado_Estabelecimento; Estabelecimento)
            {
            }
            column(Empregado__No__NIB_; IBAN)
            {
            }
            column(Empregado_Swift; "SWIFT Code")
            {
            }
            column("Empregado__Cód__Banco_Transf__"; "Cód. Banco Transf.")
            {
            }
            column(Empregado__Birth_Date_; "Birth Date")
            {
            }
            column(varPais; varPais)
            {
            }
            column("Empregado__Documento_Identificação_"; "Documento Identificação")
            {
            }
            column("Empregado__No__Doc__Identificação_"; "No. Doc. Identificação")
            {
            }
            column("Empregado__Local_Emissão_Doc__Ident__"; "Local Emissão Doc. Ident.")
            {
            }
            column(Empregado__Data_Doc__Ident__; "Data Doc. Ident.")
            {
            }
            column(Empregado__Data_Validade_Doc__Ident__; "Data Validade Doc. Ident.")
            {
            }
            column(Empregado___IVA_; "IVA %")
            {
            }
            column(Empregado__No__Contribuinte_; "No. Contribuinte")
            {
            }
            column(Empregado__Tipo_Contribuinte_; "Tipo Contribuinte")
            {
            }
            column("Empregado__Cod__Repartição_Finanças_"; "Cod. Repartição Finanças")
            {
            }
            column("Empregado__Repartição_Finanças_"; "Repartição Finanças")
            {
            }
            column("Empregado__Data_Emissão_NIF_"; "Data Emissão NIF")
            {
            }
            column(Empregado__Tipo_Rendimento_; "Tipo Rendimento")
            {
            }
            column("Empregado__Local_Obtenção_Rendimento_"; "Local Obtenção Rendimento")
            {
            }
            column(Empregado_Deficiente; Deficiente)
            {
            }
            column(Empregado__Estado_Civil_; "Estado Civil")
            {
            }
            column(Empregado__Titular_Rendimentos_; "Titular Rendimentos")
            {
            }
            column(Empregado__Conjuge_Deficiente_; Format("Conjuge Deficiente"))
            {
            }
            column(Empregado__No__Dependentes_; "No. Dependentes")
            {
            }
            column(Empregado__No__Dependentes_Deficientes_; "No. Dependentes Deficientes")
            {
            }
            column(IRS; IRS)
            {
            }
            column("Empregado__No__Segurança_Social_"; "No. Segurança Social")
            {
            }
            column("Empregado__Data_da_Admissão_SS_"; "Data da Admissão SS")
            {
            }
            column("Empregado__Data_Emissão_SS_"; "Data Emissão SS")
            {
            }
            column(varInstSegSocial; varInstSegSocial)
            {
            }
            column(varRegimeSegSocial; varRegimeSegSocial)
            {
            }
            column(ADSE; "Nº ADSE")
            {
            }
            column(ADSE_Data_Admissao; "Data da Admissão ADSE")
            {
            }
            column(CGA; "Nº CGA")
            {
            }
            column(CGA_Data_Admissao; "Data da Admissão CGA")
            {
            }
            column(CGA_N_Horas_Docencia; "Nº Horas Docência Calc. Desct.")
            {
            }
            column(CGA_Prof_Acumulacao; Format("Professor Acumulação"))
            {
            }
            column(Empregado__Valor_Vencimento_Base_; "Valor Vencimento Base")
            {
            }
            column(Empregado__Valor_Dia_; "Valor Dia")
            {
            }
            column(Empregado__Valor_Hora_; "Valor Hora")
            {
            }
            column(Empregado__No__Horas_Semanais_; "No. Horas Semanais")
            {
            }
            column(Empregado__No__Horas_Semanais_Totais; "No. Horas Semanais Totais")
            {
            }
            column("Empregado__Cód__IRCT_"; "Cód. IRCT")
            {
            }
            column("Empregado__Descrição_IRCT_"; "Descrição IRCT")
            {
            }
            column("Empregado__Cód__Cat__Profissional_"; "Cód. Cat. Profissional")
            {
            }
            column("Empregado__Descrição_Cat_Prof_"; "Descrição Cat Prof")
            {
            }
            column("Empregado__Cód__Cat__Prof_QP_"; "Cód. Cat. Prof QP")
            {
            }
            column("Empregado__Descrição_Cat_Prof_QP_"; "Descrição Cat Prof QP")
            {
            }
            column(Empregado__Class__Nac__Profi__; "Class. Nac. Profi.")
            {
            }
            column("Empregado__Descrição_Class__Nac__"; "Descrição Class. Nac.")
            {
            }
            column("Empregado__Cód__Habilitações_"; "Cód. Habilitações")
            {
            }
            column("Empregado__Descrição_Habilitações_"; "Descrição Habilitações")
            {
            }
            column("Empregado__Situação_Profissional_"; "Situação Profissional")
            {
            }
            column("Empregado__Grau_Função_"; "Grau Função")
            {
            }
            column("Empregado__Descrição_Grau_Função_"; "Descrição Grau Função")
            {
            }
            column("Empregado__Cód__Horário_"; "Cód. Horário")
            {
            }
            column(varEstabelecimento; varEstabelecimento)
            {
            }
            column(Empregado__Employment_Date_; "Employment Date")
            {
            }
            column(Empregado__Post_Code__________Empregado_City; Empregado."Post Code" + ' ' + Empregado.City)
            {
            }
            column("Empregado__No__Apólice_________Empregado_Seguradora"; Empregado."No. Apólice" + ' ' + Empregado.Seguradora)
            {
            }
            column(Empregado__No__dias_de_Trabalho_Semanal_; "No. dias de Trabalho Semanal")
            {
            }
            column("Empregado_Profissionalização"; Format(Profissionalização))
            {
            }
            column("Empregado_Empregado__Regime_Duração_Trabalho_"; Empregado."Regime Duração Trabalho")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(FICHA_DE_EMPREGADOCaption; FICHA_DE_EMPREGADOCaptionLbl)
            {
            }
            column(Empregado__No__Caption; FieldCaption("No."))
            {
            }
            column(NomeCaption; NomeCaptionLbl)
            {
            }
            column(MoradaCaption; MoradaCaptionLbl)
            {
            }
            column(Empregado__Tipo_Empregado_Caption; FieldCaption("Tipo Empregado"))
            {
            }
            column(Empregado__Job_Title_Caption; FieldCaption("Job Title"))
            {
            }
            column(Empregado_ExtensionCaption; FieldCaption(Extension))
            {
            }
            column(Empregado_PagerCaption; FieldCaption(CompanyMobilePhoneNo))
            {
            }
            column(E_Mail_da_EmpresaCaption; E_Mail_da_EmpresaCaptionLbl)
            {
            }
            column(Empregado__Phone_No__Caption; FieldCaption("Phone No."))
            {
            }
            column(Empregado__Mobile_Phone_No__Caption; FieldCaption("Mobile Phone No."))
            {
            }
            column(Empregado__E_Mail_Caption; FieldCaption("E-Mail"))
            {
            }
            column(Empregado_StatusCaption; FieldCaption(Status))
            {
            }
            column(Empregado__Statistics_Group_Code_Caption; FieldCaption("Statistics Group Code"))
            {
            }
            column(Empregado_EstabelecimentoCaption; FieldCaption(Estabelecimento))
            {
            }
            column(Empregado__No__NIB_Caption; FieldCaption(IBAN))
            {
            }
            column("N___Conta_BancáriaCaption"; N___Conta_BancáriaCaptionLbl)
            {
            }
            column("Empregado__Cód__Banco_Transf__Caption"; FieldCaption("Cód. Banco Transf."))
            {
            }
            column(Empregado__Birth_Date_Caption; FieldCaption("Birth Date"))
            {
            }
            column(NacionalidadeCaption; NacionalidadeCaptionLbl)
            {
            }
            column("Doc__IdentificaçãoCaption"; Doc__IdentificaçãoCaptionLbl)
            {
            }
            column("Empregado__No__Doc__Identificação_Caption"; FieldCaption("No. Doc. Identificação"))
            {
            }
            column("Local_EmissãoCaption"; Local_EmissãoCaptionLbl)
            {
            }
            column("Data_EmissãoCaption"; Data_EmissãoCaptionLbl)
            {
            }
            column(Data_ValidadeCaption; Data_ValidadeCaptionLbl)
            {
            }
            column(GeralCaption; GeralCaptionLbl)
            {
            }
            column("ComunicaçãoCaption"; ComunicaçãoCaptionLbl)
            {
            }
            column("AdministraçãoCaption"; AdministraçãoCaptionLbl)
            {
            }
            column(PessoalCaption; PessoalCaptionLbl)
            {
            }
            column(Dados_LegaisCaption; Dados_LegaisCaptionLbl)
            {
            }
            column(Empregado___IVA_Caption; FieldCaption("IVA %"))
            {
            }
            column(Empregado__No__Contribuinte_Caption; FieldCaption("No. Contribuinte"))
            {
            }
            column(Empregado__Tipo_Contribuinte_Caption; FieldCaption("Tipo Contribuinte"))
            {
            }
            column("Repartição_FinançasCaption"; Repartição_FinançasCaptionLbl)
            {
            }
            column("Empregado__Data_Emissão_NIF_Caption"; FieldCaption("Data Emissão NIF"))
            {
            }
            column(Empregado__Tipo_Rendimento_Caption; FieldCaption("Tipo Rendimento"))
            {
            }
            column("Local_Obtenção_Rend_Caption"; Local_Obtenção_Rend_CaptionLbl)
            {
            }
            column(Empregado_DeficienteCaption; FieldCaption(Deficiente))
            {
            }
            column(Empregado__Estado_Civil_Caption; FieldCaption("Estado Civil"))
            {
            }
            column(Empregado__Titular_Rendimentos_Caption; FieldCaption("Titular Rendimentos"))
            {
            }
            column(Empregado__Conjuge_Deficiente_Caption; FieldCaption("Conjuge Deficiente"))
            {
            }
            column(Empregado__No__Dependentes_Caption; FieldCaption("No. Dependentes"))
            {
            }
            column(N__Dep__DeficientesCaption; N__Dep__DeficientesCaptionLbl)
            {
            }
            column(IRSCaption; IRSCaptionLbl)
            {
            }
            column("Empregado__No__Segurança_Social_Caption"; FieldCaption("No. Segurança Social"))
            {
            }
            column("Data_da_AdmissãoCaption"; Data_da_AdmissãoCaptionLbl)
            {
            }
            column("Data_EmissãoCaption_Control1101490102"; Data_EmissãoCaption_Control1101490102Lbl)
            {
            }
            column("Instituição_Seg__SocialCaption"; Instituição_Seg__SocialCaptionLbl)
            {
            }
            column(Regime_Seg__SocialCaption; Regime_Seg__SocialCaptionLbl)
            {
            }
            column(ProcessamentoCaption; ProcessamentoCaptionLbl)
            {
            }
            column(CategoriaCaption; CategoriaCaptionLbl)
            {
            }
            column(Valor_Vencimento_BaseCaption; Valor_Vencimento_BaseCaptionLbl)
            {
            }
            column(Empregado__Valor_Dia_Caption; FieldCaption("Valor Dia"))
            {
            }
            column(Empregado__Valor_Hora_Caption; FieldCaption("Valor Hora"))
            {
            }
            column(Empregado__No__Horas_Semanais_Caption; FieldCaption("No. Horas Semanais"))
            {
            }
            column(IRCTCaption; IRCTCaptionLbl)
            {
            }
            column(Cat__ProfissionalCaption; Cat__ProfissionalCaptionLbl)
            {
            }
            column(Cat__Prof_Quadros_Pes_Caption; Cat__Prof_Quadros_Pes_CaptionLbl)
            {
            }
            column("Class__Nac__ProfissõesCaption"; Class__Nac__ProfissõesCaptionLbl)
            {
            }
            column("Empregado__Cód__Habilitações_Caption"; FieldCaption("Cód. Habilitações"))
            {
            }
            column("Empregado__Situação_Profissional_Caption"; FieldCaption("Situação Profissional"))
            {
            }
            column("Empregado__Grau_Função_Caption"; FieldCaption("Grau Função"))
            {
            }
            column("Empregado__Cód__Horário_Caption"; FieldCaption("Cód. Horário"))
            {
            }
            column("Data_AdmissãoCaption"; Data_AdmissãoCaptionLbl)
            {
            }
            column(SeguradoraCaption; SeguradoraCaptionLbl)
            {
            }
            column(Empregado__No__dias_de_Trabalho_Semanal_Caption; FieldCaption("No. dias de Trabalho Semanal"))
            {
            }
            column("Empregado_ProfissionalizaçãoCaption"; FieldCaption(Profissionalização))
            {
            }
            dataitem("Contrato Empregado"; "Contrato Empregado")
            {
                DataItemLink = "Cód. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("Cód. Empregado", "Cód. Contrato", "No. Linha");
                column("Contrato_Empregado__Cód__Contrato_"; "Cód. Contrato")
                {
                }
                column("Contrato_Empregado_Descrição"; Descrição)
                {
                }
                column(Contrato_Empregado__Tipo_Contrato_; "Tipo Contrato")
                {
                }
                column("Contrato_Empregado__Duração_Contrato_"; "Duração Contrato")
                {
                }
                column(Contrato_Empregado__Data_Inicio_Contrato_; "Data Inicio Contrato")
                {
                }
                column(Contrato_Empregado__Data_Fim_Contrato_; "Data Fim Contrato")
                {
                }
                column("Contrato_Empregado__Cód__Motivo_Terminação_"; "Cód. Motivo Terminação")
                {
                }
                column("Contrato_Empregado__Cód__Contrato_Caption"; FieldCaption("Cód. Contrato"))
                {
                }
                column("Contrato_Empregado_DescriçãoCaption"; FieldCaption(Descrição))
                {
                }
                column(Contrato_Empregado__Tipo_Contrato_Caption; FieldCaption("Tipo Contrato"))
                {
                }
                column("Contrato_Empregado__Duração_Contrato_Caption"; FieldCaption("Duração Contrato"))
                {
                }
                column(Data_InicioCaption; Data_InicioCaptionLbl)
                {
                }
                column(Data_FimCaption; Data_FimCaptionLbl)
                {
                }
                column(Mot__TerminoCaption; Mot__TerminoCaptionLbl)
                {
                }
                column(Contratos_de_TrabalhoCaption; Contratos_de_TrabalhoCaptionLbl)
                {
                }
                column("Contrato_Empregado_Cód__Empregado"; "Cód. Empregado")
                {
                }
                column(Contrato_Empregado_No__Linha; "No. Linha")
                {
                }
            }
            dataitem("Qualificação Empregado"; "Qualificação Empregado")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Employee No.", Type, "Line No.");
                column("Qualificação_Empregado__From_Date_"; "From Date")
                {
                }
                column("Qualificação_Empregado__To_Date_"; "To Date")
                {
                }
                column("Qualificação_Empregado_Type"; Type)
                {
                }
                column("Qualificação_Empregado_Description"; Description)
                {
                }
                column("Qualificação_Empregado__Institution_Company_"; "Institution/Company")
                {
                }
                column(A_partir_deCaption; A_partir_deCaptionLbl)
                {
                }
                column("Até_à_DataCaption"; Até_à_DataCaptionLbl)
                {
                }
                column("Qualificação_Empregado_TypeCaption"; FieldCaption(Type))
                {
                }
                column("Qualificação_Empregado_DescriptionCaption"; FieldCaption(Description))
                {
                }
                column("Qualificação_Empregado__Institution_Company_Caption"; FieldCaption("Institution/Company"))
                {
                }
                column("QualificaçõesCaption"; QualificaçõesCaptionLbl)
                {
                }
                column("Qualificação_Empregado_Employee_No_"; "Employee No.")
                {
                }
                column("Qualificação_Empregado_Line_No_"; "Line No.")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                if TabEstabelecimento.Get(Empregado.Estabelecimento) then
                    varEstabelecimento := TabEstabelecimento.Descrição;

                if TabInstSegSocial.Get(Empregado."Cod. Instituição SS") then
                    varInstSegSocial := TabInstSegSocial.Description;

                if TabRegimeSegSocial.Get(Empregado."Cod. Regime SS") then
                    varRegimeSegSocial := TabRegimeSegSocial.Descrição;

                TabPais.Reset;
                TabPais.SetRange(TabPais.Code, Empregado.Nacionalidade);
                if TabPais.FindFirst then
                    varPais := TabPais.Name;

                if Empregado."IRS %" <> 0 then
                    IRS := Empregado."IRS %";
                if Empregado."IRS % Fixa" <> 0 then
                    IRS := Empregado."IRS % Fixa";

                SetFilter("Data Filtro Inicio", '<=%1', WorkDate);
                SetFilter("Data Filtro Fim", '>=%1|=%2', WorkDate, 0D);
                Empregado.CalcFields(Empregado."Grau Função", Empregado."Descrição Grau Função", Empregado."Cód. Cat. Profissional");
                Empregado.CalcFields(Empregado."Descrição Cat Prof", Empregado."Cód. Cat. Prof QP", Empregado."Descrição Cat Prof QP");
                Empregado.CalcFields(Empregado."Cód. Horário");
                Empregado.CalcFields(Empregado.Image);
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("No.");
            end;
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

    labels
    {
        No_Professor_lbl = 'No. Professor';
        Swift = 'SWIFT';
        IBAN = 'IBAN';
        ADSE_lbl = 'ADSE';
        CGA_lbl = 'CGA';
        Data_Admissao_lbl = 'Data Admissão';
        N_Horas_Docencia = 'No. Horas Docência';
        CGA_Prof_Acum = 'Professor Acumulação';
        N_Horas_Sem_totais = 'Nº Horas Sem. Totais';
    }

    trigger OnPreReport()
    begin
        EmployeeFilter := Empregado.GetFilters;
        TabConfEmpresa.Get;
        TabConfEmpresa.CalcFields(Picture);
    end;

    var
        LastFieldNo: Integer;
        EmployeeFilter: Text[250];
        TabEstabelecimento: Record "Estabelecimentos da Empresa";
        varEstabelecimento: Text[100];
        TabInstSegSocial: Record "Instituição Seg. Social";
        varInstSegSocial: Text[100];
        TabRegimeSegSocial: Record "Regime Seg. Social";
        varRegimeSegSocial: Text[100];
        TabPais: Record "Country/Region";
        varPais: Text[100];
        TabConfEmpresa: Record "Company Information";
        IRS: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        FICHA_DE_EMPREGADOCaptionLbl: Label 'FICHA DE EMPREGADO';
        NomeCaptionLbl: Label 'Nome';
        MoradaCaptionLbl: Label 'Morada';
        E_Mail_da_EmpresaCaptionLbl: Label 'E-Mail da Empresa';
        "N___Conta_BancáriaCaptionLbl": Label 'N.º Conta Bancária';
        NacionalidadeCaptionLbl: Label 'Nacionalidade';
        "Doc__IdentificaçãoCaptionLbl": Label 'Doc. Identificação';
        "Local_EmissãoCaptionLbl": Label 'Local Emissão';
        "Data_EmissãoCaptionLbl": Label 'Data Emissão';
        Data_ValidadeCaptionLbl: Label 'Data Validade';
        GeralCaptionLbl: Label 'Geral';
        "ComunicaçãoCaptionLbl": Label 'Comunicação';
        "AdministraçãoCaptionLbl": Label 'Administração';
        PessoalCaptionLbl: Label 'Pessoal';
        Dados_LegaisCaptionLbl: Label 'Dados Legais';
        "Repartição_FinançasCaptionLbl": Label 'Repartição Finanças';
        "Local_Obtenção_Rend_CaptionLbl": Label 'Local Obtenção Rend.';
        N__Dep__DeficientesCaptionLbl: Label 'Nº Dep. Deficientes';
        IRSCaptionLbl: Label 'IRS';
        "Data_da_AdmissãoCaptionLbl": Label 'Data da Admissão';
        "Data_EmissãoCaption_Control1101490102Lbl": Label 'Data Emissão';
        "Instituição_Seg__SocialCaptionLbl": Label 'Instituição Seg. Social';
        Regime_Seg__SocialCaptionLbl: Label 'Regime Seg. Social';
        ProcessamentoCaptionLbl: Label 'Processamento';
        CategoriaCaptionLbl: Label 'Categoria';
        Valor_Vencimento_BaseCaptionLbl: Label 'Valor Vencimento Base';
        IRCTCaptionLbl: Label 'IRCT';
        Cat__ProfissionalCaptionLbl: Label 'Cat. Profissional';
        Cat__Prof_Quadros_Pes_CaptionLbl: Label 'Cat. Prof Quadros Pes.';
        "Class__Nac__ProfissõesCaptionLbl": Label 'Class. Nac. Profissões';
        "Data_AdmissãoCaptionLbl": Label 'Data Admissão';
        SeguradoraCaptionLbl: Label 'Seguradora';
        Data_InicioCaptionLbl: Label 'Data Inicio';
        Data_FimCaptionLbl: Label 'Data Fim';
        Mot__TerminoCaptionLbl: Label 'Mot. Termino';
        Contratos_de_TrabalhoCaptionLbl: Label 'Contratos de Trabalho';
        A_partir_deCaptionLbl: Label 'A partir de';
        "Até_à_DataCaptionLbl": Label 'Até à Data';
        "QualificaçõesCaptionLbl": Label 'Qualificações';
}

