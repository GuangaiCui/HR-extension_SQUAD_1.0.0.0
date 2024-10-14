table 53111 "Historico Empregado"
{
    Caption = 'Employee';
    DataCaptionFields = "No.", "First Name", "Last Name";
    DrillDownPageID = "Lista Empregado";
    LookupPageID = "Lista Empregado";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Name; Text[75])
        {
            Caption = 'Nome Completo';
        }
        field(3; "First Name"; Text[65])
        {
            Caption = 'Nome Próprio';
        }
        field(4; "Last Name"; Text[65])
        {
            Caption = 'Último Nome';
        }
        field(5; Initials; Text[30])
        {
            Caption = 'Iniciais';
        }
        field(6; "Job Title"; Text[30])
        {
            Caption = 'Cargo';
        }
        field(7; "Search Name"; Code[30])
        {
            Caption = 'Alias Nome';
        }
        field(8; Address; Text[75])
        {
            Caption = 'Endereço';
        }
        field(9; "Address 2"; Text[75])
        {
            Caption = 'Endereço 2';
        }
        field(10; City; Text[30])
        {
            Caption = 'Cidade';
        }
        field(11; "Post Code"; Code[20])
        {
            Caption = 'Cód. Postal';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(12; County; Text[30])
        {
            Caption = 'Distrito';
        }
        field(13; "Phone No."; Text[30])
        {
            Caption = 'Telefone';
            ExtendedDatatype = PhoneNo;
        }
        field(14; "Mobile Phone No."; Text[30])
        {
            Caption = 'Nº Telefone Móvel';
            ExtendedDatatype = PhoneNo;
        }
        field(15; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(16; "Alt. Address Code"; Code[10])
        {
            Caption = 'Cód. Endereço Alter.';
            TableRelation = "Endereço Alternativo".Code WHERE("Employee No." = FIELD("No."));
        }
        field(17; "Alt. Address Start Date"; Date)
        {
            Caption = 'Data Início Endç. Alter.';
        }
        field(18; "Alt. Address End Date"; Date)
        {
            Caption = 'Data Final Endç. Alter.';
        }
        field(19; Picture; BLOB)
        {
            Caption = 'Imagem';
            SubType = Bitmap;
        }
        field(20; "Birth Date"; Date)
        {
            Caption = 'Data Nascimento';
        }
        field(21; "Social Security No."; Text[30])
        {
            Caption = 'No. Segurança Social';
            Enabled = false;
        }
        field(22; "Union Code"; Code[10])
        {
            Caption = 'Cód. Sindicato';
            TableRelation = Sindicato;
        }
        field(23; "Union Membership No."; Text[30])
        {
            Caption = 'Nº Afiliação Sindicato';
        }
        field(24; Sex; Option)
        {
            Caption = 'Sexo';
            OptionCaption = ' ,Female,Male';
            OptionMembers = " ",Female,Male;
        }
        field(25; "Country Code"; Code[10])
        {
            Caption = 'Cód. País';
            TableRelation = "Country/Region";
        }
        field(26; "Manager No."; Code[20])
        {
            Caption = 'No. Director';
            TableRelation = Empregado;
        }
        field(27; "Emplymt. Contract Code"; Code[10])
        {
            CalcFormula = Lookup("Contrato Empregado"."Cód. Contrato" WHERE("Cód. Empregado" = FIELD("No."),
                                                                             "Data Inicio Contrato" = FIELD("Data Filtro Inicio"),
                                                                             "Data Fim Contrato" = FIELD("Data Filtro Fim")));
            Caption = 'Cód. Contrato Trabalho';
            FieldClass = FlowField;
        }
        field(28; "Statistics Group Code"; Code[10])
        {
            Caption = 'Cód. Departamento';
            TableRelation = "Departamentos Empregado";
        }
        field(29; "Employment Date"; Date)
        {
            Caption = 'Data Admissão';
        }
        field(31; Status; Option)
        {
            Caption = 'Estado';
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active,Inactive,Terminated;
        }
        field(32; "Inactive Date"; Date)
        {
            Caption = 'Data Inactividade';
        }
        field(33; "Cause of Inactivity Code"; Code[10])
        {
            Caption = 'Cód. Motivo Inactividade';
            TableRelation = "Motivo Inactividade";
        }
        field(34; "Termination Date"; Date)
        {
            Caption = 'Data Terminação';
        }
        field(35; "Grounds for Term. Code"; Code[10])
        {
            Caption = 'Cód. Motivo Terminação';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(MotSai));
        }
        field(36; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Cód. Dimensão 1 Global';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(37; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Cód. Dimensão 2 Global';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(38; "Resource No."; Code[20])
        {
            Caption = 'No. Recurso';
            TableRelation = Resource WHERE(Type = CONST(Person));
        }
        field(39; Comment; Boolean)
        {
            CalcFormula = Exist("Linha Coment. Recurso Humano" WHERE("Table Name" = CONST(Emp),
                                                                      "No." = FIELD("No."),
                                                                      "Table Line No." = CONST(0)));
            Caption = 'Comentário';
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Last Date Modified"; Date)
        {
            Caption = 'Data Últ. Modif.';
            Editable = false;
        }
        field(41; "Date Filter"; Date)
        {
            Caption = 'Filtro Data';
            FieldClass = FlowFilter;
        }
        field(42; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Filtro Dimensão 1 Global';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(43; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Filtro Dimensão 2 Global';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(44; "Cause of Absence Filter"; Code[10])
        {
            Caption = 'Filtro Motivo Ausência';
            FieldClass = FlowFilter;
            TableRelation = "Absence Reason";
        }
        field(45; "Total Absence (Base)"; Decimal)
        {
            CalcFormula = Sum("Histórico Ausências"."Quantity (Base)" WHERE("Employee No." = FIELD("No."),
                                                                             "Cause of Absence Code" = FIELD("Cause of Absence Filter"),
                                                                             "From Date" = FIELD("Date Filter")));
            Caption = 'Ausência Total (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(46; Extension; Text[30])
        {
            Caption = 'Extensão';
        }
        field(47; "Employee No. Filter"; Code[20])
        {
            Caption = 'Filtro No. Empregado';
            FieldClass = FlowFilter;
            TableRelation = Empregado;
        }
        field(48; CompanyMobilePhoneNo; Text[30])
        {
            Caption = 'Nº Telefone Móvel Empresa';
            ExtendedDatatype = PhoneNo;
        }
        field(49; "Fax No."; Text[30])
        {
            Caption = 'No. Fax';
        }
        field(50; "Company E-Mail"; Text[80])
        {
            Caption = 'Empresa E-Mail';
            ExtendedDatatype = EMail;
        }
        field(51; Title; Text[30])
        {
            Caption = 'Título';
        }
        field(52; "Salespers./Purch. Code"; Code[10])
        {
            Caption = 'Cód. Vendedor/Comprador';
            TableRelation = "Salesperson/Purchaser";
        }
        field(53; "No. Series"; Code[10])
        {
            Caption = 'No Séries';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(54; "Tipo Empregado"; Code[20])
        {
            //Caption = 'Employee Type';
            TableRelation = "Tipo Empregado";
        }
        field(55; IBAN; Code[50])
        {
            Caption = 'IBAN';
            Description = 'SEPA';

            trigger OnValidate()
            var
                CompanyInfo: Record "Company Information";
            begin
            end;
        }
        field(56; "SWIFT Code"; Code[20])
        {
            Caption = 'SWIFT Code';
            Description = 'SEPA';
        }
        field(57; Estabelecimento; Code[4])
        {
            Caption = 'Estabelecimento';
            TableRelation = "Estabelecimentos da Empresa";
        }
        field(58; "N.º Conta Bancária"; Text[20])
        {
        }
        field(59; Seguradora; Text[60])
        {
            //Caption = 'Insurance Company';
        }
        field(60; "No. Apólice"; Text[20])
        {
            //Caption = 'Insurance Policy No.';
        }
        field(61; "Documento Identificação"; Option)
        {
            //Caption = 'Identification Document';
            OptionCaption = ' ,Cédula,BI,Passaporte,Cartão Cidadão,Autorização residência temporária,Autorização residência permanente,Cartão residência,Visto trabalho,Outros';
            OptionMembers = " ","Cédula",BI,Passaporte,"Cartão Cidadão","Autorização residência temporária","Autorização residência permanente","Cartão residência","Visto trabalho",Outros;
        }
        field(62; "No. Doc. Identificação"; Text[14])
        {
            //Caption = 'Identification Doc. No.';
        }
        field(63; "Local Emissão Doc. Ident."; Text[30])
        {
            //Caption = 'Ident. Doc. Issue Local';
        }
        field(64; "Data Doc. Ident."; Date)
        {
            //Caption = 'Ident. Doc.Date';
        }
        field(65; "Data Validade Doc. Ident."; Date)
        {
            //Caption = 'Ident. Doc. Expiration Date';
        }
        field(66; Naturalidade; Text[60])
        {
            //Caption = 'Birth';
        }
        field(67; Nacionalidade; Text[30])
        {
            //Caption = 'Nationality';
            TableRelation = "Country/Region";
        }
        field(68; "Nacionalidade Descrição"; Text[50])
        {
            //Caption = 'Nationality Description';
        }
        field(69; "No. Contribuinte"; Text[9])
        {
            //Caption = 'Taxpayer No.';
            Numeric = true;

            trigger OnValidate()
            var
                i: Integer;
                x: Integer;
                num: Integer;
            begin
            end;
        }
        field(70; "Tipo Contribuinte"; Option)
        {
            //Caption = 'Taxpayer Type';
            OptionCaption = ' ,Conta de Outrem,Trabalhador Independente,Pensionista';
            OptionMembers = " ","Conta de Outrem","Trabalhador Independente",Pensionista;
        }
        field(71; "Cod. Repartição Finanças"; Text[4])
        {
            //Caption = 'Finance Allocation Code';
            Numeric = true;
        }
        field(72; "Repartição Finanças"; Text[30])
        {
            //Caption = 'Finance Allocation';
        }
        field(73; "Data Emissão NIF"; Date)
        {
            //Caption = 'Tax Information No. Issue Date';
        }
        field(74; "Tipo Rendimento"; Option)
        {
            //Caption = 'Salary Type';
            OptionCaption = 'A,B';
            OptionMembers = A,B;
        }
        field(75; "Local Obtenção Rendimento"; Option)
        {
            //Caption = 'Income Obtaining Location';
            OptionCaption = ' ,C,RA,RM';
            OptionMembers = " ",C,RA,RM;
        }
        field(76; Deficiente; Option)
        {
            //Caption = 'With disability';
            OptionCaption = ' ,Sim,Forças Armadas';
            OptionMembers = "Não",Sim,"Forças Armadas";
        }
        field(77; "Estado Civil"; Option)
        {
            //Caption = 'Marital Status';
            OptionCaption = 'Solteiro,Casado,Divorciado,Viúvo,Outro,União Facto';
            OptionMembers = Solteiro,Casado,Divorciado,"Viúvo",Outro,"União Facto";
        }
        field(78; "Titular Rendimentos"; Option)
        {
            //Caption = 'Income Holder';
            OptionCaption = ' ,Único Titular,Dois Titulares';
            OptionMembers = " ","Único Titular","Dois Titulares";
        }
        field(79; "Conjuge Deficiente"; Boolean)
        {
            //Caption = 'Disabled Spouse';
        }
        field(80; "No. Dependentes"; Integer)
        {
            //Caption = 'Dependents No.';
        }
        field(81; "No. Dependentes Deficientes"; Integer)
        {
            //Caption = 'Disabled Dependents No.';
        }
        field(82; "Tabela IRS"; Text[3])
        {
            //Caption = 'IRS Tables';
        }
        field(83; "Descrição Tabela IRS"; Text[60])
        {
            //Caption = 'IRS Tables Description';
        }
        field(84; "IRS %"; Decimal)
        {
            Caption = 'IRS %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(85; "IRS % Fixa"; Decimal)
        {
            //Caption = 'IRS Fixed %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(86; "Subscritor SS"; Boolean)
        {
            //Caption = 'SS Subscriber';
        }
        field(87; "No. Segurança Social"; Text[11])
        {
            //Caption = 'Social Security No.';
            Numeric = true;
        }
        field(88; "Data da Admissão SS"; Date)
        {
            //Caption = 'SS Admission Date';
        }
        field(89; "Data Emissão SS"; Date)
        {
            //Caption = 'SS Emission Date';
        }
        field(90; "Cod. Instituição SS"; Code[10])
        {
            //Caption = 'SS Institution Code';
            TableRelation = "Instituição Seg. Social".Code;
        }
        field(91; "Cod. Regime SS"; Code[10])
        {
            //Caption = 'SS Regime Code';
            TableRelation = "Regime Seg. Social"."Código" WHERE("Código" = FIELD("Cod. Regime SS"));
        }
        field(92; "Subscritor ADSE"; Boolean)
        {
            Caption = 'Subscritor ADSE';
        }
        field(93; "Nº ADSE"; Text[11])
        {
            Caption = 'Nº ADSE';
            Numeric = true;
        }
        field(94; "Data da Admissão ADSE"; Date)
        {
            Caption = 'Data da Admissão ADSE';
        }
        field(95; "Data de Emissão ADSE"; Date)
        {
            Caption = 'Data de Emissão ADSE';
        }
        field(96; "Subscritor CGA"; Boolean)
        {
            Caption = 'Subscritor CGA';
        }
        field(97; "Nº CGA"; Text[11])
        {
            Caption = 'Nº CGA';
            Numeric = true;
        }
        field(98; "Data da Admissão CGA"; Date)
        {
            Caption = 'Data da Admissão CGA';
        }
        field(99; "Data de Emissão CGA"; Date)
        {
            Caption = 'Data de Emissão CGA';
        }
        field(100; "Nº Horas Docência Calc. Desct."; Integer)
        {
            Caption = 'Nº Horas Docência Calc. Desct.';
        }
        field(101; "Data de Antiguidade"; Date)
        {
            //Caption = 'Seniority Date';
        }
        field(102; "Data Fim"; Date)
        {
            //Caption = 'End Date';
        }
        field(103; "Motivo de Terminação"; Code[10])
        {
            //Caption = 'End Reason';
            Description = 'RU';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(MotSai));
        }
        field(104; "Cód. IRCT"; Code[5])
        {
            Caption = 'Cód. IRCT';
            TableRelation = "Código IRCT"."Código IRCT" WHERE("Código IRCT" = FIELD("Cód. IRCT"));
        }
        field(105; "Acordo Colectivo"; Code[20])
        {
            //Caption = 'Collective Agreement';
        }
        field(106; "Descrição IRCT"; Text[100])
        {
            Caption = 'IRCT Description';
        }
        field(107; "Aplicabilidade do IRCT"; Option)
        {
            //Caption = 'IRCT Applicability';
            Description = 'RU';
            OptionCaption = 'Filiação,Portaria de Extensão,Escolha,Acto de Gestão,Não sabe qual dos IRCT se aplica,Sem aplicabilidade,Automática';
            OptionMembers = "01","02","03","04","05","06","07";
        }
        field(108; "Cód. Cat. Profissional"; Code[20])
        {
            CalcFormula = Lookup("Cat. Prof. Int. Empregado"."Cód. Cat. Prof." WHERE("Employee No." = FIELD("No."),
                                                                                      "Data Inicio Cat. Prof." = FIELD("Data Filtro Inicio"),
                                                                                      "Data Fim Cat. Prof." = FIELD("Data Filtro Fim")));
            //Caption = 'Professional Category Code';
            FieldClass = FlowField;
        }
        field(109; "Descrição Cat Prof"; Text[100])
        {
            CalcFormula = Lookup("Cat. Prof. Int. Empregado"."Descrição" WHERE("Employee No." = FIELD("No."),
                                                                                "Data Inicio Cat. Prof." = FIELD("Data Filtro Inicio"),
                                                                                "Data Fim Cat. Prof." = FIELD("Data Filtro Fim")));
            //Caption = 'Prof. Cate. Description';
            FieldClass = FlowField;
        }
        field(110; "Cód. Cat. Prof QP"; Code[20])
        {
            CalcFormula = Lookup("Cat. Prof. QP Empregado"."Cód. Cat. Prof. QP" WHERE("Employee No." = FIELD("No."),
                                                                                       "Data Inicio Cat. Prof." = FIELD("Data Filtro Inicio"),
                                                                                       "Data Fim Cat. Prof." = FIELD("Data Filtro Fim")));
            //Caption = 'Prof. Cate. QP Code';
            FieldClass = FlowField;
        }
        field(111; "Descrição Cat Prof QP"; Text[200])
        {
            CalcFormula = Lookup("Cat. Prof. QP Empregado".Description WHERE("Employee No." = FIELD("No."),
                                                                              "Data Inicio Cat. Prof." = FIELD("Data Filtro Inicio"),
                                                                              "Data Fim Cat. Prof." = FIELD("Data Filtro Fim")));
            //Caption = 'Prof. Cate. QP Description';
            FieldClass = FlowField;
        }
        field(112; "Class. Nac. Profi."; Code[20])
        {
            //Caption = 'Nac. Profe. Class.';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(CNP));
        }
        field(113; "Descrição Class. Nac."; Text[150])
        {
            Caption = 'Nac. Class. Description';
        }
        field(114; "Cód. Habilitações"; Code[20])
        {
            //Caption = 'Qualifications Code';
            TableRelation = "Habilitação"."Código";
        }
        field(115; "Descrição Habilitações"; Text[200])
        {
            //Caption = 'Qualifications Description';
        }
        field(116; "Situação Profissional"; Option)
        {
            //Caption = 'Professional Status';
            Description = 'RU';
            OptionCaption = ' ,Empregador,Trabalhador Familiar Não Remunerado,Trabalhador por Conta de Outrém,Membro Activo de Cooperativa de Produção,Outra Situação';
            OptionMembers = " ","1","2","3","4","8";
        }
        field(117; "Grau Função"; Code[20])
        {
            CalcFormula = Lookup("Grau Função Empregado"."Cód. Grau Função" WHERE("Employee No." = FIELD("No."),
                                                                                   "Data Inicio Grau Função" = FIELD("Data Filtro Inicio"),
                                                                                   "Data Fim Grau Função" = FIELD("Data Filtro Fim")));
            //Caption = 'Degree Role';
            FieldClass = FlowField;
        }
        field(118; "Descrição Grau Função"; Text[200])
        {
            CalcFormula = Lookup("Grau Função Empregado"."Descrição" WHERE("Employee No." = FIELD("No."),
                                                                            "Data Inicio Grau Função" = FIELD("Data Filtro Inicio"),
                                                                            "Data Fim Grau Função" = FIELD("Data Filtro Fim")));
            //Caption = 'Degree Role Description';
            FieldClass = FlowField;
        }
        field(119; "Cód. Horário"; Code[20])
        {
            CalcFormula = Lookup("Horário Empregado"."Cód. Horário" WHERE("Employee No." = FIELD("No."),
                                                                           "Data Iníco Horário" = FIELD("Data Filtro Inicio"),
                                                                           "Data Fim Horário" = FIELD("Data Filtro Fim")));
            //Caption = 'Schedule Code';
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;
        }
        field(120; "Valor Vencimento Base"; Decimal)
        {
            //Caption = 'Base Salary Amount';
        }
        field(121; "Valor Dia"; Decimal)
        {
            //Caption = 'Day Amount';
        }
        field(122; "Valor Hora"; Decimal)
        {
            //Caption = 'Hour Amount';
        }
        field(123; "No. Horas Semanais"; Decimal)
        {
            //Caption = 'Week Hours No.';
        }
        field(124; "Mês Proc. Sub. Férias"; Integer)
        {
            //Caption = 'Proc. Vacat. Benef. Month';
        }
        field(125; "Nº Professor"; Code[20])
        {
        }
        field(126; "Regime Duração Trabalho"; Option)
        {
            //Caption = 'Work Duration Regime';
            Description = 'RU';
            OptionCaption = ' ,A tempo completo,A tempo parcial';
            OptionMembers = " ","1","2";
        }
        field(127; "Usa Transf. Bancária"; Boolean)
        {
            //Caption = 'Use Bank Transfer';
        }
        field(128; "Cód. Banco Transf."; Code[20])
        {
            //Caption = 'Bank Transfer Code';
            TableRelation = "Bank Account";
        }
        field(129; "IVA %"; Decimal)
        {
            Caption = 'IVA %';
            Description = 'Trabalhador Independente';
            MaxValue = 100;
            MinValue = 0;
        }
        field(130; "Nome Livro Diario Pag."; Code[10])
        {
            //Caption = 'Gen. Journal Name Pag.';
            Description = 'Pagamento';
            TableRelation = "Gen. Journal Template".Name;
        }
        field(131; "Secção Diario Pag."; Code[10])
        {
            //Caption = 'Gen. Journal Section';
            Description = 'Pagamento';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Nome Livro Diario Pag."));
        }
        field(132; Pagamento; Option)
        {
            //Caption = 'Payment';
            Description = 'Pagamento';
            OptionCaption = 'Conta Bancária,Conta CG';
            OptionMembers = "Bank Account","G/L Account";
        }
        field(133; "Conta Pag."; Code[20])
        {
            //Caption = 'Payment Acc.';
            Description = 'Pagamento';
            TableRelation = IF (Pagamento = CONST("Bank Account")) "Bank Account"."No."
            ELSE
            IF (Pagamento = CONST("G/L Account")) "G/L Account"."No.";
        }
        field(134; "Envio Recibo via E-Mail"; Boolean)
        {
            //Caption = 'Send Receipt via E-Mail';
            Description = 'Recibo PDF via Email';
            ExtendedDatatype = None;
        }
        field(135; "Password Recibo em PDF"; Text[8])
        {
            //Caption = 'Receipt Passord PDF';
            Description = 'Recibo PDF via Email';
        }
        field(136; "Endereço de Envio"; Option)
        {
            //Caption = 'Send to Email';
            Description = 'Recibo PDF via Email';
            OptionCaption = 'Empresa,Pessoal';
            OptionMembers = Empresa,Pessoal;
        }
        field(137; "Última data Proc. Sub. Férias"; Date)
        {
            //Caption = 'Last Date Proc. Vacation Benef.';
            Description = 'Para saber até que data o Sub. Férias está pago';
        }
        field(138; "Data Filtro Inicio"; Date)
        {
            //Caption = 'Start Date Filter';
            Description = 'Filtra os Contratos, Categorias Profissionais e Funções Actuais';
            FieldClass = FlowFilter;
        }
        field(139; "Data Filtro Fim"; Date)
        {
            //Caption = 'End Date Filter';
            Description = 'Filtra os Contratos, Categorias Profissionais e Funções Actuais';
            FieldClass = FlowFilter;
        }
        field(140; "Total Férias"; Decimal)
        {
            CalcFormula = Sum("Férias Empregados"."Qtd." WHERE("Employee No." = FIELD("No."),
                                                                Data = FIELD("Date Filter")));
            //Caption = 'Total Vacations';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(141; "Filtro Hora Extra"; Code[10])
        {
            //Caption = 'Extra Hour Filter';
            FieldClass = FlowFilter;
            TableRelation = "Tipos Horas Extra";
        }
        field(142; "Hora Extra Total (Base)"; Decimal)
        {
            CalcFormula = Sum("Histórico Horas Extra".Quantity WHERE("Employee No." = FIELD("No."),
                                                                        "Cód. Hora Extra" = FIELD("Filtro Hora Extra"),
                                                                        Data = FIELD("Date Filter")));
            //Caption = 'Extra Hour Total (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(143; "Naturalidade - Concelho"; Text[60])
        {
            //Caption = 'Birth - County';
        }
        field(144; "Tipo Horario"; Option)
        {
            //Caption = 'Schedule Type';
            Description = 'HR.02 - BS - Diversos tipos de Horarios';
            OptionMembers = " ","Normal fixo","Normal flexível","Turno fixo e/ou flexível","Irregular e/ou movel",Reduzido,"Insencão horario","Outros ";
        }
        field(145; "No. dias de Trabalho Semanal"; Decimal)
        {
            //Caption = 'Work Week No. of days';
            Description = 'HR.02 - BS';
        }
        field(146; "Profissionalização"; Boolean)
        {
            CalcFormula = Exist("Profissionalização" WHERE("Cod Empregado" = FIELD("No.")));
            //Caption = 'Professionalization';
            FieldClass = FlowField;
        }
        field(147; "Data Profissionalização"; Date)
        {
            //Caption = 'Professionalization Date';
        }
        field(148; "Cód. Rúbrica Enc. Seg. Social"; Code[20])
        {
            //Caption = 'Social Security Charges Rubric Code';
            TableRelation = "Payroll Item";
        }
        field(149; "Cód. Rúbrica Enc. CGA"; Code[20])
        {
            Caption = 'Cód. Rúbrica Enc. CGA';
            TableRelation = "Payroll Item";
        }
        field(150; "Cód. Rúbrica Enc. ADSE"; Code[20])
        {
            Caption = 'Cód. Rúbrica Enc. ADSE';
            TableRelation = "Payroll Item";
        }
        field(151; "Professor Acumulação"; Boolean)
        {
            Description = 'O professor não desconta para a CGA';
        }
        field(153; "No. antigo do Empregado"; Code[20])
        {
            //Caption = 'Old Employee No.';
        }
        field(154; "Nº Horas Semanais Totais"; Decimal)
        {
            Caption = 'Nº Horas Semanais Totais';
        }
        field(155; "Vitalício"; Boolean)
        {
            //Caption = 'Perpetual';
        }
        field(156; "CGA - Requisição"; Boolean)
        {
            Caption = 'CGA - Requisição';
            Description = 'O Empregado desconta mas a entidade patronal não';
        }
        field(157; "Grau Função-Efeitos Progres."; Code[20])
        {
            Caption = 'Grau Função-Efeitos Progres.';
            Description = 'Registar o Grau de função no qual deveria estar';
            TableRelation = "Grau Função"."Código";
        }
        field(158; "Descrição Grau Função Progr."; Text[100])
        {
            Caption = 'Descrição Grau Função Progr.';
            Description = 'Registar o Grau de função no qual deveria estar';
        }
        field(159; Docente; Boolean)
        {
            Caption = 'Docente';
            Description = 'MISI';
        }
        field(160; "Cod. Freguesia"; Code[6])
        {
            Caption = 'Cod. Freguesia';
            Description = 'MISI';
            TableRelation = "Cód. Freguesia/Conc/Distrito"."Código";
        }
        field(161; Freguesia; Text[30])
        {
            Caption = 'Freguesia';
            Description = 'MISI';
        }
        field(162; "Habilitação Docência"; Option)
        {
            Caption = 'Habilitação Docência';
            Description = 'MISI';
            OptionCaption = ' ,Licenciado profissionalizado,Bacharel profissionalizado,Habilitação própria com grau superior,Habilitação própria sem grau superior,Autorização provisória de leccionação,Autorização de leccionação,Diploma de ensino particular e cooperativo,Certificado de aptidão pedagógica';
            OptionMembers = " ","1","2","3","4","5","6","7","8";
        }
        field(163; "Grupo Docência"; Code[3])
        {
            Caption = 'Grupo Docência';
            Description = 'MISI';
        }
        field(164; "Acumulação"; Option)
        {
            Caption = 'Acumulação';
            Description = 'MISI';
            OptionCaption = 'Não Acumula,Acumula funções no Ensino Oficial com o Particular,Acumula funções em escolas Particulares';
            OptionMembers = "0","1","2";
        }
        field(165; "Nº Dias Tempo Serviço"; Integer)
        {
            Caption = 'Dias de Serviço - Ensino';
            Description = 'MISI';
        }
        field(166; "Nº Horas Sem. Lect Diurno Cont"; Integer)
        {
            Caption = 'Diurnas - Contrato Ass.';
            Description = 'MISI';
        }
        field(167; "Nº Horas Sem. Lect Diurno Tota"; Integer)
        {
            Caption = 'Diurnas - Totais (inc. Contrato Ass.)';
            Description = 'MISI';
        }
        field(168; "Nº Horas Sem. Lect Noct Cont"; Decimal)
        {
            Caption = 'Nocturnas - Contrato Ass.';
            DecimalPlaces = 1 : 1;
            Description = 'MISI';
        }
        field(169; "Nº Horas Sem. Lect Noct Tota"; Decimal)
        {
            Caption = 'Nocturnas - Totais (inc. Contrato Ass.)';
            DecimalPlaces = 1 : 1;
            Description = 'MISI';
        }
        field(170; "Nº Horas Sem.-Desp Escolar Con"; Integer)
        {
            Caption = 'Contrato Ass.';
            Description = 'MISI';
        }
        field(171; "Nº Horas Sem.-Desp Escolar Tot"; Integer)
        {
            Caption = 'Totais';
            Description = 'MISI';
        }
        field(172; "Nº Horas Sem.-Cargos Diur Cont"; Integer)
        {
            Caption = 'Diurnas - Contrato Ass.';
            Description = 'MISI';
        }
        field(173; "Nº Horas Sem.-Cargos Diur Tota"; Integer)
        {
            Caption = 'Diurnas - Totais (inc. Contrato Ass.)';
            Description = 'MISI';
        }
        field(174; "Nº Horas Sem.-Cargos Noct Cont"; Integer)
        {
            Caption = 'Nocturnas - Contrato Ass.';
            Description = 'MISI';
        }
        field(175; "Nº Horas Sem.-Cargos Noct Tota"; Integer)
        {
            Caption = 'Nocturnas - Totais (inc. Contrato Ass.)';
            Description = 'MISI';
        }
        field(176; "Nº Horas Sem.-Dir.Pedag Cont"; Integer)
        {
            Caption = 'Contrato Ass.';
            Description = 'MISI';
        }
        field(177; "Nº Horas Sem.-Dir.Pedag Tot"; Integer)
        {
            Caption = 'Totais (inc. Contrato Ass.)';
            Description = 'MISI';
        }
        field(178; ContratoME; Option)
        {
            Caption = 'ContratoME';
            Description = 'MISI';
            OptionCaption = 'Associação,Patrocínio,Simples,Desenvolvimento,Cooperação,Não Abrangido,Programa (DRELVT)';
            OptionMembers = "1","2","3","4","5","6","7";
        }
        field(179; "Direcção Pedagógica"; Boolean)
        {
            Caption = 'Direcção Pedagógica';
            Description = 'MISI';
        }
        field(180; "Valor Desc. Conf. Religiosa"; Decimal)
        {
            Caption = 'Valor Desc. Conf. Religiosa';
            Description = 'MISI';
        }
        field(181; "Valor Desc. Seguro"; Decimal)
        {
            Caption = 'Valor Desc. Seguro';
            Description = 'MISI';
        }
        field(182; "Dias de Serviço - Estabelecim."; Integer)
        {
            Caption = 'Dias de Serviço - Estabelecim.';
            Description = 'MISI';
        }
        field(183; "Substituição Temporária"; Boolean)
        {
            Caption = 'Substituição Temporária';
            Description = 'MISI';
        }
        field(184; "NIF do Docente Substituido"; Text[9])
        {
            Caption = 'NIF do Docente Substituido';
            Description = 'MISI';
        }
        field(185; "Data Inicio Substituição"; Date)
        {
            Caption = 'Data Inicio Substituição';
            Description = 'MISI';
        }
        field(186; "Data Fim Substituição"; Date)
        {
            Caption = 'Data Fim Substituição';
            Description = 'MISI';
        }
        field(187; "Situação"; Code[4])
        {
            Caption = 'Situação';
            Description = 'MISI';
        }
        field(188; "Descrição Situação"; Text[128])
        {
            Caption = 'Descrição Situação';
            Description = 'MISI';
        }
        field(189; "Afecto à Cantina"; Boolean)
        {
            Caption = 'Afecto à Cantina';
            Description = 'MISI';
        }
        field(190; "Exportar para o MISI"; Boolean)
        {
            Caption = 'Exportar para o MISI';
            Description = 'MISI';
        }
        field(191; "Cod. Cliente"; Code[20])
        {
            //Caption = 'Customer Code';
            Description = 'Funcionalidade Contratos - Usado para criar um cliente para facturar Imp. Selo dos Contratos';
            TableRelation = Customer."No.";
        }
        field(192; "Qualificação"; Code[50])
        {
            //Caption = 'Qualification';
            Description = 'RU';

            trigger OnLookup()
            var
                recQualificEmp: Record "Qualificação Empregado";
            begin
            end;
        }
        field(193; "Cod. Regime Reforma Aplicado"; Code[10])
        {
            //Caption = 'Applied Code Regime Reform';
            Description = 'RU';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(RRef));
        }
        field(194; "Regime Reforma Aplicado"; Text[30])
        {
            //Caption = 'Applied Regime Reform';
            Description = 'RU';
        }
        field(195; "Duração do Tempo de Trabalho"; Code[20])
        {
            //Caption = 'Work Time Duration';
            Description = 'RU';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(DTT));
        }
        field(196; "Desc. Duração Tempo Trabalho"; Text[200])
        {
            //Caption = 'Work Time Duration Description';
            Description = 'RU';
        }
        field(197; "Formação-Situação face à freq."; Code[20])
        {
            //Caption = 'Training-Situation face the freq.';
            Description = 'RU';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(SitFF));
        }
        field(198; Marcado; Boolean)
        {
            //Caption = 'Marked';
            Description = 'RU - usado para fazer filtros';
        }
        field(199; "Orgão Social"; Boolean)
        {
            //Caption = 'Social Organ';
        }
        field(200; "No. Dias Trabalho Mensal"; Decimal)
        {
            //Caption = 'Month Work Days No.';
            Description = 'por causa dos trabalhadores a tempo parcial';
            Editable = false;
        }
        field(300; "NAV User Id"; Text[50])
        {
            Caption = 'ID Utilizador NAV';

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
            end;

            trigger OnValidate()
            var
                LoginMgt: Codeunit "User Management";
            begin
            end;
        }
        field(62312; "Data Registo"; Date)
        {
            Caption = 'Data Registo';
            Description = 'Bal Soc';
        }
        field(62313; "Cod Processamento"; Code[10])
        {
            Caption = 'Cod Processamento';
            Description = 'Bal Soc';
        }
        field(62374; "No. Documento"; Text[11])
        {
            //Caption = 'Document No.';
        }
    }

    keys
    {
        key(Key1; "No.", "Cod Processamento", "Data Registo")
        {
            Clustered = true;
        }
        key(Key2; "Search Name")
        {
        }
        key(Key3; Status, "Union Code")
        {
        }
        key(Key4; Estabelecimento, "Cod. Regime SS", "No.")
        {
        }
        key(Key5; Estabelecimento, "Cód. IRCT")
        {
        }
        key(Key6; "Birth Date")
        {
        }
        key(Key7; "Tipo Rendimento", "No.", "Statistics Group Code")
        {
        }
        key(Key8; Seguradora, "No. Apólice")
        {
        }
        key(Key9; Status, Sex, "Data Registo", Nacionalidade)
        {
        }
        key(Key10; Sex)
        {
        }
        key(Key11; "No.", Sex)
        {
        }
    }

    fieldgroups
    {
    }

    var
        HumanResSetup: Record "Config. Recursos Humanos";
        Employee: Record Empregado;
        Res: Record Resource;
        PostCode: Record "Post Code";
        AlternativeAddr: Record "Endereço Alternativo";
        EmployeeQualification: Record "Qualificação Empregado";
        Relative: Record "Familiar Empregado";
        EmployeeAbsence: Record "Ausência Empregado";
        MiscArticleInformation: Record "Informação Artigos Div.";
        ConfidentialInformation: Record "Informação Confidencial";
        HumanResComment: Record "Linha Coment. Recurso Humano";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        EmployeeResUpdate: Codeunit "Empregado/Actual. Recurso";
        EmployeeSalespersonUpdate: Codeunit "Empregado/Actual. Vendedor";
        DimMgt: Codeunit DimensionManagement;
        TabContratoEmpregado: Record "Contrato Empregado";
        TabCategoriaProfInt: Record "Categoria Profissional Interna";
        TabCategoriaProfQP: Record "Categoria Profissional QP";
        "TabHabilitações": Record "Habilitação";
        "TabGrauFunção": Record "Grau Função";
        TabNacProf: Record "Class. Nac. Profissões";
        TabIRCT: Record "Código IRCT";
        TabPaises: Record "Country/Region";
        varNome: Text[250];
        VarTotalNomes: Integer;
        varNome3: Text[250];
        FuncoesRH: Codeunit "Funções RH";
        Text0001: Label 'Defina o NIB com 21 caracteres.';
        Text0002: Label 'O Nº Segurança Social tem de ter 11 caracteres.';
        Text0003: Label 'O Código de Nacionalidade não existe.';
        Text0004: Label 'O Nº de Contribuinte não é válido.';
        Text0005: Label 'O NIB não é válido.';
        Text0006: Label 'Deseja também actualizar o campo Conta Pag. com este valor?';
        TabCategoriaProfIntEmp: Record "Cat. Prof. Int. Empregado";
        TabCategoriaProfQPEmp: Record "Cat. Prof. QP Empregado";
        TabHistLinhasMovEmpregado: Record "Hist. Linhas Movs. Empregado";
        TabFormacao: Record "Formação Empregado";
        TabHorario: Record "Horário Empregado";
        TabConsultasMedicas: Record "Consultas Médicas Empregado";
        TabInactividade: Record "Inactividade Empregado";
        TabProfissionalizacao: Record "Profissionalização";
        TabHorasExtra: Record "Horas Extra Empregado";
        TabAbonoDescExtra: Record "Abonos - Descontos Extra";
        TabFeriasEmpregado: Record "Férias Empregados";
        TabRubricasEmpregado: Record "Rubrica Salarial Empregado";
        TabDistCentroCusto: Record "Distribuição Custos";
        TabLinhasMovsEmpregado: Record "Linhas Movs. Empregado";
        TabCabMovsEmpregado: Record "Cab. Movs. Empregado";
        TabGrauFuncaoEmpr: Record "Grau Função Empregado";
        Text0030: Label 'Importado com sucesso.';
        TabFreguesias: Record "Cód. Freguesia/Conc/Distrito";
        Text75: Label 'The password must have more then 6 characters.';
        RUTabelas: Record "RU - Tabelas";
}

