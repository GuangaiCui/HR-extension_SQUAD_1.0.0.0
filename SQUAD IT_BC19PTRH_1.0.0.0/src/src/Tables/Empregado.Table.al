table 53035 "Empregado"
{
    // Tagus - novo campo 50000

    Caption = 'Employee SQUAD';
    //TODO: to change name after hide original
    DataCaptionFields = "No.", "First Name", "Last Name", Status;
    DrillDownPageID = "Lista Empregado";
    LookupPageID = "Lista Empregado";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    HumanResSetup.Get;
                    NoSeriesMgt.TestManual(HumanResSetup."Employee Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Name; Text[75])
        {

            trigger OnValidate()
            begin
                //Preenche o campo Nome Próprio e Último Nome
                if Name <> '' then begin
                    varNome := Name;
                    VarTotalNomes := 1;

                    //Tirar espaços à esquerda
                    while CopyStr(varNome, 1, 1) = ' ' do begin
                        varNome := CopyStr(varNome, 2);
                    end;

                    //Tirar espaços à direita
                    while CopyStr(varNome, StrLen(varNome), 1) = ' ' do begin
                        varNome := CopyStr(varNome, 1, StrLen(varNome) - 1);
                    end;

                    //Saber quantas palavras tem o nome
                    varNome3 := varNome;
                    while StrPos(varNome3, ' ') <> 0 do begin
                        varNome3 := CopyStr(varNome3, StrPos(varNome3, ' ') + 1);
                        VarTotalNomes := VarTotalNomes + 1
                    end;

                    if VarTotalNomes = 1 then
                        "First Name" := varNome;

                    if VarTotalNomes = 2 then begin
                        "First Name" := CopyStr(varNome, 1, StrPos(varNome, ' ') - 1);
                        "Last Name" := CopyStr(varNome, StrPos(varNome, ' ') + 1);
                    end;

                    if VarTotalNomes >= 3 then begin
                        "First Name" := CopyStr(varNome, 1, StrPos(varNome, ' ') - 1);

                        varNome3 := varNome;
                        while StrPos(varNome3, ' ') <> 0 do begin
                            varNome3 := CopyStr(varNome3, StrPos(varNome3, ' ') + 1);
                        end;
                        "Last Name" := CopyStr(varNome3, StrPos(varNome3, ' ') + 1);
                    end;
                end; // Fim do If do Nome completo
            end;
        }
        field(3; "First Name"; Text[65])
        {
        }
        field(4; "Last Name"; Text[65])
        {
        }
        field(5; Initials; Text[30])
        {

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Initials)) or ("Search Name" = '') then
                    "Search Name" := Initials;
            end;
        }
        field(6; "Job Title"; Text[100])
        {
        }
        field(7; "Search Name"; Code[30])
        {
        }
        field(8; Address; Text[75])
        {
        }
        field(9; "Address 2"; Text[75])
        {
        }
        field(10; City; Text[30])
        {

            trigger OnLookup()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;

            trigger OnValidate()
            begin
                //upgrade para nova versão
                PostCode.ValidateCity(City, "Post Code", County, "Country Code", false);
            end;
        }
        field(11; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(12; County; Text[30])
        {
        }
        field(13; "Phone No."; Text[30])
        {
            ExtendedDatatype = PhoneNo;
        }
        field(14; "Mobile Phone No."; Text[30])
        {
            ExtendedDatatype = PhoneNo;
        }
        field(15; "E-Mail"; Text[80])
        {
            ExtendedDatatype = EMail;
        }
        field(16; "Alt. Address Code"; Code[10])
        {
            TableRelation = "Endereço Alternativo".Code WHERE("Employee No." = FIELD("No."));
        }
        field(17; "Alt. Address Start Date"; Date)
        {
        }
        field(18; "Alt. Address End Date"; Date)
        {
        }
        field(19; Picture; BLOB)
        {
            SubType = Bitmap;
        }
        field(20; "Birth Date"; Date)
        {
        }
        field(21; "Social Security No."; Text[30])
        {
            Enabled = false;
        }
        field(22; "Union Code"; Code[10])
        {
            TableRelation = Sindicato;
        }
        field(23; "Union Membership No."; Text[30])
        {
        }
        field(24; Sex; Option)
        {
            OptionCaption = ' ,Feminino,Masculino';
            OptionMembers = " ",Female,Male;
        }
        field(25; "Country Code"; Code[10])
        {
            TableRelation = "Country/Region";
        }
        field(26; "Manager No."; Code[20])
        {
            TableRelation = Empregado;
        }
        field(27; "Emplymt. Contract Code"; Code[10])
        {
            CalcFormula = Lookup("Contrato Empregado"."Cód. Contrato" WHERE("Cód. Empregado" = FIELD("No."),
                                                                             "Data Inicio Contrato" = FIELD("Data Filtro Inicio"),
                                                                             "Data Fim Contrato" = FIELD("Data Filtro Fim")));
            FieldClass = FlowField;
        }
        field(28; "Statistics Group Code"; Code[10])
        {
            TableRelation = "Departamentos Empregado";
        }
        field(29; "Employment Date"; Date)
        {
        }
        field(31; Status; Enum "Employee Status")
        {

            trigger OnValidate()
            begin
                EmployeeQualification.SetRange("Employee No.", "No.");
                EmployeeQualification.ModifyAll("Employee Status", Status);
                Modify;
            end;
        }
        field(32; "Inactive Date"; Date)
        {
        }
        field(33; "Cause of Inactivity Code"; Code[10])
        {
            TableRelation = "Motivo Inactividade";
        }
        field(34; "Termination Date"; Date)
        {
        }
        field(35; "Grounds for Term. Code"; Code[10])
        {
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(MotSai));
        }
        field(36; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(37; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(38; "Resource No."; Code[20])
        {
            TableRelation = Resource WHERE(Type = CONST(Person));

            trigger OnValidate()
            begin
                if ("Resource No." <> '') and Res.WritePermission then
                    EmployeeResUpdate.ResUpdate(Rec)
            end;
        }
        field(39; Comment; Boolean)
        {
            CalcFormula = Exist("Linha Coment. Recurso Humano" WHERE("Table Name" = CONST(Emp),
                                                                      "No." = FIELD("No."),
                                                                      "Table Line No." = CONST(0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Last Date Modified"; Date)
        {
            Editable = false;
        }
        field(41; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(42; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(43; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(44; "Cause of Absence Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Absence Reason";
        }
        field(45; "Total Absence (Base)"; Decimal)
        {
            CalcFormula = Sum("Histórico Ausências"."Quantity (Base)" WHERE("Employee No." = FIELD("No."),
                                                                             "Cause of Absence Code" = FIELD("Cause of Absence Filter"),
                                                                             "From Date" = FIELD("Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(46; Extension; Text[30])
        {
        }
        field(47; "Employee No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Empregado;
        }
        field(48; CompanyMobilePhoneNo; Text[30])
        {
            ExtendedDatatype = PhoneNo;
        }
        field(49; "Company Phone No."; Text[30])
        {
        }
        field(50; "Company E-Mail"; Text[80])
        {
            ExtendedDatatype = EMail;
        }
        field(51; Title; Text[30])
        {
        }
        field(52; "Salespers./Purch. Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(53; "No. Series"; Code[10])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(54; "Tipo Empregado"; Code[20])
        {
            TableRelation = "Tipo Empregado";
        }
        field(55; IBAN; Code[50])
        {
            Description = 'SEPA';

            trigger OnValidate()
            var
                CompanyInfo: Record "Company Information";
            begin
                CompanyInfo.CheckIBAN(IBAN);
            end;
        }
        field(56; "SWIFT Code"; Code[20])
        {
            Description = 'SEPA';
        }
        field(57; Estabelecimento; Code[4])
        {
            TableRelation = "Estabelecimentos da Empresa";
        }
        field(58; "Bank Account No."; Text[20])
        {
        }
        field(59; Seguradora; Text[60])
        {
        }
        field(60; "No. Apólice"; Text[20])
        {
        }
        field(61; "Documento Identificação"; Option)
        {
            Caption = 'Identification Document';
            OptionCaption = ' ,Cédula,BI,Passaporte,Cartão Cidadão,Autorização residência temporária,Autorização residência permanente,Cartão residência,Visto trabalho,Outros';
            OptionMembers = " ","Cédula",BI,Passaporte,"Cartão Cidadão","Autorização residência temporária","Autorização residência permanente","Cartão residência","Visto trabalho",Outros;
        }
        field(62; "No. Doc. Identificação"; Text[14])
        {
            Caption = 'Identification Doc. No.';
        }
        field(63; "Local Emissão Doc. Ident."; Text[30])
        {
            Caption = 'Ident. Doc. Issue Local';
        }
        field(64; "Data Doc. Ident."; Date)
        {
            Caption = 'Ident. Doc.Date';
        }
        field(65; "Data Validade Doc. Ident."; Date)
        {
            Caption = 'Ident. Doc. Expiration Date';
        }
        field(66; Naturalidade; Text[60])
        {
            Caption = 'Birth';
        }
        field(67; Nacionalidade; Text[30])
        {
            Caption = 'Nationality';
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                TabPaises.Reset;
                TabPaises.SetRange(TabPaises.Code, Nacionalidade);
                if not TabPaises.Find('-') then
                    Error(Text0003)
                else
                    "Nacionalidade Descrição" := TabPaises.Name;
            end;
        }
        field(68; "Nacionalidade Descrição"; Text[50])
        {
            Caption = 'Nationality Description';
        }
        field(69; "No. Contribuinte"; Text[9])
        {
            Caption = 'Taxpayer No.';
            Numeric = true;

            trigger OnValidate()
            var
                i: Integer;
                x: Integer;
                num: Integer;
            begin
                //Testa se o Nº de Contribuinte é válido
                if "No. Contribuinte" <> '' then
                    CompanyInfo.CheckNIF("No. Contribuinte");
            end;
        }
        field(70; "Tipo Contribuinte"; Option)
        {
            Caption = 'Taxpayer Type';
            OptionCaption = ' ,Conta de Outrem,Trabalhador Independente,Pensionista';
            OptionMembers = " ","Conta de Outrem","Trabalhador Independente",Pensionista;

            trigger OnValidate()
            begin
                //Preenche automaticamento o campo %IVA se for um trabalahdor Independente
                if "Tipo Contribuinte" = "Tipo Contribuinte"::"Trabalhador Independente" then begin
                    HumanResSetup.Get();
                    "IRS %" := 0;
                    "IRS % Fixa" := HumanResSetup."%IRS";
                    "IVA %" := HumanResSetup."%IVA";
                end else begin
                    "IVA %" := 0;
                    "IRS % Fixa" := 0;
                end;
            end;
        }
        field(71; "Cod. Repartição Finanças"; Text[4])
        {
            Caption = 'Finance Allocation Code';
            Numeric = true;
        }
        field(72; "Repartição Finanças"; Text[30])
        {
            Caption = 'Finance Allocation';
        }
        field(73; "Data Emissão NIF"; Date)
        {
            Caption = 'Tax Information No. Issue Date';
        }
        field(74; "Tipo Rendimento"; Option)
        {
            Caption = 'Salary Type';
            OptionCaption = 'A,B';
            OptionMembers = A,B;
        }
        field(75; "Local Obtenção Rendimento"; Option)
        {
            Caption = 'Income Obtaining Location';
            OptionCaption = ' ,C,RA,RM';
            OptionMembers = " ",C,RA,RM;
        }
        field(76; Deficiente; Option)
        {
            Caption = 'With disability';
            OptionCaption = ' ,Sim,Forças Armadas';
            OptionMembers = "Não",Sim,"Forças Armadas";
        }
        field(77; "Estado Civil"; Option)
        {
            Caption = 'Marital Status';
            OptionCaption = 'Solteiro,Casado,Divorciado,Viúvo,Outro,União Facto';
            OptionMembers = Solteiro,Casado,Divorciado,"Viúvo",Outro,"União Facto";
        }
        field(78; "Titular Rendimentos"; Option)
        {
            Caption = 'Income Holder';
            OptionCaption = ' ,Único Titular,Dois Titulares';
            OptionMembers = " ","Único Titular","Dois Titulares";
        }
        field(79; "Conjuge Deficiente"; Boolean)
        {
            Caption = 'Disabled Spouse';
        }
        field(80; "No. Dependentes"; Integer)
        {
            Caption = 'Dependents No.';
        }
        field(81; "No. Dependentes Deficientes"; Integer)
        {
            Caption = 'Disabled Dependents No.';
        }
        field(82; "Tabela IRS"; Text[3])
        {
            Caption = 'IRS Tables';
        }
        field(83; "Descrição Tabela IRS"; Text[60])
        {
            Caption = 'IRS Tables Description';
        }
        field(84; "IRS %"; Decimal)
        {
            Caption = 'IRS %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(85; "IRS % Fixa"; Decimal)
        {
            Caption = 'IRS Fixed %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(86; "Subscritor SS"; Boolean)
        {
            Caption = 'SS Subscriber';
        }
        field(87; "No. Segurança Social"; Text[11])
        {
            Caption = 'Social Security No.';
            Numeric = true;

            trigger OnValidate()
            begin
                //Obriga a que o nº da Seg. social tenha 11 digitos
                if (StrLen("No. Segurança Social") > 0) and (StrLen("No. Segurança Social") < 11) then
                    Error(Text0002);
            end;
        }
        field(88; "Data da Admissão SS"; Date)
        {
            Caption = 'SS Admission Date';
        }
        field(89; "Data Emissão SS"; Date)
        {
            Caption = 'SS Emission Date';
        }
        field(90; "Cod. Instituição SS"; Code[10])
        {
            Caption = 'SS Institution Code';
            TableRelation = "Instituição Seg. Social".Code;
        }
        field(91; "Cod. Regime SS"; Code[10])
        {
            Caption = 'SS Regime Code';
            TableRelation = "Regime Seg. Social"."Código" WHERE("Código" = FIELD("Cod. Regime SS"));
        }
        field(92; "Subscritor ADSE"; Boolean)
        {
        }
        field(93; "Nº ADSE"; Text[11])
        {
            Caption = 'Nº ADSE';
        }
        field(94; "Data da Admissão ADSE"; Date)
        {
            Caption = 'Data da Admissão ADSE';
        }
        field(95; "Data de Emissão ADSE"; Date)
        {
            Caption = 'Data de Emissão ADSE';
        }
        field(96; "Subsccritor CGA"; Boolean)
        {
            Caption = 'Subsccritor CGA';
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
            Enabled = false;
        }
        field(101; "Data de Antiguidade"; Date)
        {
            Caption = 'Seniority Date';
        }
        field(102; "End Date"; Date)
        {
            Caption = 'Data Fim';
        }
        field(103; "Motivo de Terminação"; Code[10])
        {
            Caption = 'End Reason';
            Description = 'RU';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(MotSai));
        }
        field(104; "Cód. IRCT"; Code[5])
        {
            Caption = 'Cód. IRCT';
            TableRelation = "Código IRCT"."Código IRCT" WHERE("Código IRCT" = FIELD("Cód. IRCT"));

            trigger OnValidate()
            begin
                if TabIRCT.Get("Cód. IRCT") then
                    "Descrição IRCT" := TabIRCT.Descrição;
                "Acordo Colectivo" := TabIRCT."Acordo Colectivo";
            end;
        }
        field(105; "Acordo Colectivo"; Code[20])
        {
            Caption = 'Collective Agreement';
        }
        field(106; "Descrição IRCT"; Text[100])
        {
            Caption = 'IRCT Description';
        }
        field(107; "Aplicabilidade do IRCT"; Option)
        {
            Caption = 'IRCT Applicability';
            Description = 'RU';
            OptionCaption = 'Filiação,Portaria de Extensão,Escolha,Acto de Gestão,Não sabe qual dos IRCT se aplica,Sem aplicabilidade,Automática';
            OptionMembers = "01","02","03","04","05","06","07";
        }
        field(108; "Cód. Cat. Profissional"; Code[20])
        {
            CalcFormula = Lookup("Cat. Prof. Int. Empregado"."Cód. Cat. Prof." WHERE("Employee No." = FIELD("No."),
                                                                                      "Data Inicio Cat. Prof." = FIELD("Data Filtro Inicio"),
                                                                                      "Data Fim Cat. Prof." = FIELD("Data Filtro Fim")));
            Caption = 'Professional Category Code';
            FieldClass = FlowField;
        }
        field(109; "Descrição Cat Prof"; Text[100])
        {
            CalcFormula = Lookup("Cat. Prof. Int. Empregado"."Descrição" WHERE("Employee No." = FIELD("No."),
                                                                                "Data Inicio Cat. Prof." = FIELD("Data Filtro Inicio"),
                                                                                "Data Fim Cat. Prof." = FIELD("Data Filtro Fim")));
            Caption = 'Prof. Cate. Description';
            FieldClass = FlowField;
        }
        field(110; "Cód. Cat. Prof QP"; Code[20])
        {
            CalcFormula = Lookup("Cat. Prof. QP Empregado"."Cód. Cat. Prof. QP" WHERE("Employee No." = FIELD("No."),
                                                                                       "Data Inicio Cat. Prof." = FIELD("Data Filtro Inicio"),
                                                                                       "Data Fim Cat. Prof." = FIELD("Data Filtro Fim")));
            Caption = 'Prof. Cate. QP Code';
            FieldClass = FlowField;
        }
        field(111; "Descrição Cat Prof QP"; Text[200])
        {
            CalcFormula = Lookup("Cat. Prof. QP Empregado".Description WHERE("Employee No." = FIELD("No."),
                                                                              "Data Inicio Cat. Prof." = FIELD("Data Filtro Inicio"),
                                                                              "Data Fim Cat. Prof." = FIELD("Data Filtro Fim")));
            Caption = 'Prof. Cate. QP Description';
            FieldClass = FlowField;
        }
        field(112; "Class. Nac. Profi."; Code[20])
        {
            Caption = 'Nac. Profe. Class.';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(CNP));

            trigger OnValidate()
            begin
                RUTabelas.Reset;
                RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::CNP);
                RUTabelas.SetRange(RUTabelas.Código, "Class. Nac. Profi.");
                if RUTabelas.FindFirst then
                    "Descrição Class. Nac." := RUTabelas.Descrição;
            end;
        }
        field(113; "Descrição Class. Nac."; Text[150])
        {
            Caption = 'Nac. Class. Description';
        }
        field(114; "Cód. Habilitações"; Code[20])
        {
            Caption = 'Qualifications Code';
            TableRelation = "Habilitação"."Código";

            trigger OnValidate()
            begin
                if TabHabilitações.Get("Cód. Habilitações") then
                    "Descrição Habilitações" := TabHabilitações.Descrição;
            end;
        }
        field(115; "Descrição Habilitações"; Text[200])
        {
            Caption = 'Qualifications Description';
        }
        field(116; "Situação Profissional"; Option)
        {
            Caption = 'Professional Status';
            Description = 'RU';
            OptionCaption = ' ,Empregador,Trabalhador Familiar Não Remunerado,Trabalhador por Conta de Outrém,Membro Activo de Cooperativa de Produção,Outra Situação';
            OptionMembers = " ","1","2","3","4","8";
        }
        field(117; "Grau Função"; Code[20])
        {
            CalcFormula = Lookup("Grau Função Empregado"."Cód. Grau Função" WHERE("Employee No." = FIELD("No."),
                                                                                   "Data Inicio Grau Função" = FIELD("Data Filtro Inicio"),
                                                                                   "Data Fim Grau Função" = FIELD("Data Filtro Fim")));
            Caption = 'Degree Role';
            FieldClass = FlowField;
        }
        field(118; "Descrição Grau Função"; Text[200])
        {
            CalcFormula = Lookup("Grau Função Empregado"."Descrição" WHERE("Employee No." = FIELD("No."),
                                                                            "Data Inicio Grau Função" = FIELD("Data Filtro Inicio"),
                                                                            "Data Fim Grau Função" = FIELD("Data Filtro Fim")));
            Caption = 'Degree Role Description';
            FieldClass = FlowField;
        }
        field(119; "Cód. Horário"; Code[20])
        {
            CalcFormula = Lookup("Horário Empregado"."Cód. Horário" WHERE("Employee No." = FIELD("No."),
                                                                           "Data Iníco Horário" = FIELD("Data Filtro Inicio"),
                                                                           "Data Fim Horário" = FIELD("Data Filtro Fim")));
            Caption = 'Schedule Code';
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;
        }
        field(120; "Valor Vencimento Base"; Decimal)
        {
            Caption = 'Base Salary Amount';
        }
        field(121; "Valor Dia"; Decimal)
        {
            Caption = 'Day Amount';
        }
        field(122; "Valor Hora"; Decimal)
        {
            Caption = 'Hour Amount';
        }
        field(123; "No. Horas Semanais"; Decimal)
        {
            Caption = 'Week Hours No.';
        }
        field(124; "Mês Proc. Sub. Férias"; Integer)
        {
            Caption = 'Proc. Vacat. Benef. Month';
        }
        field(125; "Nº Professor"; Code[20])
        {
            Caption = 'Nº Professor';
            Enabled = false;
        }
        field(126; "Regime Duração Trabalho"; Option)
        {
            Caption = 'Work Duration Regime';
            Description = 'RU';
            OptionCaption = ' ,A tempo completo,A tempo parcial';
            OptionMembers = " ","1","2";
        }
        field(127; "Usa Transf. Bancária"; Boolean)
        {
            Caption = 'Use Bank Transfer';

            trigger OnValidate()
            begin
                //Se este campo estiver assinalado obriga a que o NIB esteja preenchido
                if "Usa Transf. Bancária" then
                    if StrLen(IBAN) < 25 then
                        Error(Text0001);
            end;
        }
        field(128; "Cód. Banco Transf."; Code[20])
        {
            Caption = 'Bank Transfer Code';
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                if Pagamento = Pagamento::"Bank Account" then begin
                    if "Conta Pag." = '' then
                        Validate("Conta Pag.", "Cód. Banco Transf.")
                    else
                        if Confirm(Text0006) then
                            Validate("Conta Pag.", "Cód. Banco Transf.");
                end;
            end;
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
            Caption = 'Gen. Journal Name Pag.';
            Description = 'Pagamento';
            TableRelation = "Gen. Journal Template".Name;
        }
        field(131; "Secção Diario Pag."; Code[10])
        {
            Caption = 'Gen. Journal Section';
            Description = 'Pagamento';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Nome Livro Diario Pag."));
        }
        field(132; Pagamento; Option)
        {
            Caption = 'Payment';
            Description = 'Pagamento';
            OptionCaption = 'Conta Bancária,Conta CG';
            OptionMembers = "Bank Account","G/L Account";
        }
        field(133; "Conta Pag."; Code[20])
        {
            Caption = 'Payment Acc.';
            Description = 'Pagamento';
            TableRelation = IF (Pagamento = CONST("Bank Account")) "Bank Account"."No."
            ELSE
            IF (Pagamento = CONST("G/L Account")) "G/L Account"."No.";
        }
        field(134; "Envio Recibo via E-Mail"; Boolean)
        {
            Caption = 'Send Receipt via E-Mail';
            Description = 'Recibo PDF via Email';
            ExtendedDatatype = None;
        }
        field(135; "Password Recibo em PDF"; Text[8])
        {
            Caption = 'Receipt Passord PDF';
            Description = 'Recibo PDF via Email';
        }
        field(136; "Endereço de Envio"; Option)
        {
            Caption = 'Send to Email';
            Description = 'Recibo PDF via Email';
            OptionCaption = 'Empresa,Pessoal';
            OptionMembers = Empresa,Pessoal;
        }
        field(137; "Última data Proc. Sub. Férias"; Date)
        {
            Caption = 'Last Date Proc. Vacation Benef.';
            Description = 'Para saber até que data o Sub. Férias está pago';
        }
        field(138; "Data Filtro Inicio"; Date)
        {
            Caption = 'Start Date Filter';
            Description = 'Filtra os Contratos, Categorias Profissionais e Funções Actuais';
            FieldClass = FlowFilter;
        }
        field(139; "Data Filtro Fim"; Date)
        {
            Caption = 'End Date Filter';
            Description = 'Filtra os Contratos, Categorias Profissionais e Funções Actuais';
            FieldClass = FlowFilter;
        }
        field(140; "Total Férias"; Decimal)
        {
            CalcFormula = Sum("Férias Empregados"."Qtd." WHERE("Employee No." = FIELD("No."),
                                                                Data = FIELD("Date Filter"),
                                                                Tipo = CONST(ferias)));
            Caption = 'Total Vacations';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(141; "Filtro Hora Extra"; Code[10])
        {
            Caption = 'Extra Hour Filter';
            FieldClass = FlowFilter;
            TableRelation = "Tipos Horas Extra";
        }
        field(142; "Hora Extra Total (Base)"; Decimal)
        {
            CalcFormula = Sum("Histórico Horas Extra".Quantity WHERE("Employee No." = FIELD("No."),
                                                                        "Cód. Hora Extra" = FIELD("Filtro Hora Extra"),
                                                                        Data = FIELD("Date Filter")));
            Caption = 'Extra Hour Total (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(143; "Naturalidade - Concelho"; Text[60])
        {
            Caption = 'Birth - County';
        }
        field(145; "No. dias de Trabalho Semanal"; Decimal)
        {
            Caption = 'Work Week No. of days';
        }
        field(146; "Profissionalização"; Boolean)
        {
            CalcFormula = Exist("Profissionalização" WHERE("Cod Empregado" = FIELD("No.")));
            Caption = 'Professionalization';
            FieldClass = FlowField;
        }
        field(147; "Data Profissionalização"; Date)
        {
            Caption = 'Professionalization Date';
        }
        field(148; "Cód. Rúbrica Enc. Seg. Social"; Code[20])
        {
            Caption = 'Social Security Charges Rubric Code';
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
            Caption = 'Professor Acumulação';
            Description = 'O professor não desconta para a CGA';
            Enabled = false;
        }
        field(152; "Nº dias Fich. Seg. Social"; Integer)
        {
            Caption = 'Nº dias Fich. Seg. Social';
            Description = 'CIDSCS';
        }
        field(153; "No. antigo do Empregado"; Code[20])
        {
            Caption = 'Old Employee No.';
        }
        field(154; "No. Horas Semanais Totais"; Decimal)
        {
            //Enabled = false;
            Enabled = true;
        }
        field(155; "Vitalício"; Boolean)
        {
            Caption = 'Perpetual';
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
            Enabled = false;
            TableRelation = "Grau Função"."Código";

            trigger OnValidate()
            begin
                if TabGrauFunção.Get("Grau Função-Efeitos Progres.") then
                    "Descrição Grau Função Progr." := TabGrauFunção.Description;
            end;
        }
        field(158; "Descrição Grau Função Progr."; Text[100])
        {
            Caption = 'Descrição Grau Função Progr.';
            Description = 'Registar o Grau de função no qual deveria estar';
            Enabled = false;
        }
        field(159; Docente; Boolean)
        {
            Caption = 'Docente';
            Description = 'MISI';
            Enabled = false;
        }
        field(160; "Cod. Freguesia"; Code[6])
        {
            Caption = 'Cód. Freguesia';
            Description = 'MISI';
            TableRelation = "Cód. Freguesia/Conc/Distrito"."Código";

            trigger OnValidate()
            begin
                TabFreguesias.Reset;
                TabFreguesias.SetRange(TabFreguesias.Código, "Cod. Freguesia");
                if TabFreguesias.Find('-') then begin
                    Freguesia := TabFreguesias.Freguesia;
                    County := TabFreguesias.Distrito;
                end;
            end;
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
            Enabled = false;
            OptionCaption = ' ,Licenciado profissionalizado,Bacharel profissionalizado,Habilitação própria com grau superior,Habilitação própria sem grau superior,Autorização provisória de leccionação,Autorização de leccionação,Diploma de ensino particular e cooperativo,Certificado de aptidão pedagógica';
            OptionMembers = " ","1","2","3","4","5","6","7","8";
        }
        field(163; "Grupo Docência"; Code[3])
        {
            Caption = 'Grupo Docência';
            Description = 'MISI';
            Enabled = false;
        }
        field(164; "Acumulação"; Option)
        {
            Caption = 'Acumulação';
            Description = 'MISI';
            Enabled = false;
            OptionCaption = 'Não Acumula,Acumula funções no Ensino Oficial com o Particular,Acumula funções em escolas Particulares';
            OptionMembers = "0","1","2";
        }
        field(165; "Nº Dias Tempo Serviço"; Integer)
        {
            Caption = 'Dias de Serviço - Ensino';
            Description = 'MISI';
            Enabled = false;
        }
        field(166; "Nº Horas Sem. Lect Diurno Cont"; Integer)
        {
            Caption = 'Diurnas - Contrato Ass.';
            Description = 'MISI';
            Enabled = false;
        }
        field(167; "Nº Horas Sem. Lect Diurno Tota"; Integer)
        {
            Caption = 'Diurnas - Totais (inc. Contrato Ass.)';
            Description = 'MISI';
            Enabled = false;
        }
        field(168; "Nº Horas Sem. Lect Noct Cont"; Decimal)
        {
            Caption = 'Nocturnas - Contrato Ass.';
            DecimalPlaces = 1 : 1;
            Description = 'MISI';
            Enabled = false;
        }
        field(169; "Nº Horas Sem. Lect Noct Tota"; Decimal)
        {
            Caption = 'Nocturnas - Totais (inc. Contrato Ass.)';
            DecimalPlaces = 1 : 1;
            Description = 'MISI';
            Enabled = false;
        }
        field(170; "Nº Horas Sem.-Desp Escolar Con"; Integer)
        {
            Caption = 'Contrato Ass.';
            Description = 'MISI';
            Enabled = false;
        }
        field(171; "Nº Horas Sem.-Desp Escolar Tot"; Integer)
        {
            Caption = 'Totais';
            Description = 'MISI';
            Enabled = false;
        }
        field(172; "Nº Horas Sem.-Cargos Diur Cont"; Integer)
        {
            Caption = 'Diurnas - Contrato Ass.';
            Description = 'MISI';
            Enabled = false;
        }
        field(173; "Nº Horas Sem.-Cargos Diur Tota"; Integer)
        {
            Caption = 'Diurnas - Totais (inc. Contrato Ass.)';
            Description = 'MISI';
            Enabled = false;
        }
        field(174; "Nº Horas Sem.-Cargos Noct Cont"; Integer)
        {
            Caption = 'Nocturnas - Contrato Ass.';
            Description = 'MISI';
            Enabled = false;
        }
        field(175; "Nº Horas Sem.-Cargos Noct Tota"; Integer)
        {
            Caption = 'Nocturnas - Totais (inc. Contrato Ass.)';
            Description = 'MISI';
            Enabled = false;
        }
        field(176; "Nº Horas Sem.-Dir.Pedag Cont"; Integer)
        {
            Caption = 'Contrato Ass.';
            Description = 'MISI';
            Enabled = false;
        }
        field(177; "Nº Horas Sem.-Dir.Pedag Tot"; Integer)
        {
            Caption = 'Totais (inc. Contrato Ass.)';
            Description = 'MISI';
            Enabled = false;
        }
        field(178; ContratoME; Option)
        {
            Caption = 'ContratoME';
            Description = 'MISI';
            Enabled = false;
            OptionCaption = 'Associação,Patrocínio,Simples,Desenvolvimento,Cooperação,Não Abrangido,Programa (DRELVT)';
            OptionMembers = "1","2","3","4","5","6","7";
        }
        field(179; "Direcção Pedagógica"; Boolean)
        {
            Caption = 'Direcção Pedagógica';
            Description = 'MISI';
            Enabled = false;
        }
        field(180; "Valor Desc. Conf. Religiosa"; Decimal)
        {
            Caption = 'Valor Desc. Conf. Religiosa';
            Description = 'MISI';
            Enabled = false;
        }
        field(181; "Valor Desc. Seguro"; Decimal)
        {
            Caption = 'Valor Desc. Seguro';
            Description = 'MISI';
            Enabled = false;
        }
        field(182; "Dias de Serviço - Estabelecim."; Integer)
        {
            Caption = 'Dias de Serviço - Estabelecim.';
            Description = 'MISI';
            Enabled = false;
        }
        field(183; "Substituição Temporária"; Boolean)
        {
            Caption = 'Substituição Temporária';
            Description = 'MISI';
            Enabled = false;
        }
        field(184; "NIF do Docente Substituido"; Text[9])
        {
            Caption = 'NIF do Docente Substituido';
            Description = 'MISI';
            Enabled = false;
        }
        field(185; "Data Inicio Substituição"; Date)
        {
            Caption = 'Data Inicio Substituição';
            Description = 'MISI';
            Enabled = false;
        }
        field(186; "Data Fim Substituição"; Date)
        {
            Caption = 'Data Fim Substituição';
            Description = 'MISI';
            Enabled = false;
        }
        field(187; "Situação"; Code[4])
        {
            Caption = 'Situação';
            Description = 'MISI';
            Enabled = false;
        }
        field(188; "Descrição Situação"; Text[128])
        {
            Caption = 'Descrição Situação';
            Description = 'MISI';
            Enabled = false;
        }
        field(189; "Afecto à Cantina"; Boolean)
        {
            Caption = 'Afecto à Cantina';
            Description = 'MISI';
            Enabled = false;
        }
        field(190; "Exportar para o MISI"; Boolean)
        {
            Caption = 'Exportar para o MISI';
            Description = 'MISI';
            Enabled = false;
        }
        field(191; "Cod. Cliente"; Code[20])
        {
            Caption = 'Customer Code';
            Description = 'Funcionalidade Contratos - Usado para criar um cliente para facturar Imp. Selo dos Contratos';
            TableRelation = Customer."No.";
        }
        field(192; "Qualificação"; Code[50])
        {
            Caption = 'Qualification';
            Description = 'RU';

            trigger OnLookup()
            var
                recQualificEmp: Record "Qualificação Empregado";
            begin
                recQualificEmp.Reset;
                recQualificEmp.SetRange("Employee No.", "No.");
                recQualificEmp.SetRange(Type, recQualificEmp.Type::"Qualificações RU");
                if PAGE.RunModal(PAGE::"Qualificações Empregado RU", recQualificEmp) = ACTION::LookupOK then
                    Qualificação := Format(recQualificEmp."Internal Qualification");
            end;
        }
        field(193; "Cod. Regime Reforma Aplicado"; Code[10])
        {
            Caption = 'Applied Code Regime Reform';
            Description = 'RU';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(RRef));

            trigger OnValidate()
            begin
                RUTabelas.Reset;
                RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::RRef);
                RUTabelas.SetRange(RUTabelas.Código, "Cod. Regime Reforma Aplicado");
                if RUTabelas.FindFirst then
                    "Regime Reforma Aplicado" := RUTabelas.Descrição;
            end;
        }
        field(194; "Regime Reforma Aplicado"; Text[30])
        {
            Caption = 'Applied Regime Reform';
            Description = 'RU';
        }
        field(195; "Duração do Tempo de Trabalho"; Code[20])
        {
            Caption = 'Work Time Duration';
            Description = 'RU';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(DTT));

            trigger OnValidate()
            begin
                RUTabelas.Reset;
                RUTabelas.SetRange(RUTabelas.Tipo, RUTabelas.Tipo::DTT);
                RUTabelas.SetRange(RUTabelas.Código, "Duração do Tempo de Trabalho");
                if RUTabelas.FindFirst then
                    "Desc. Duração Tempo Trabalho" := RUTabelas.Descrição;
            end;
        }
        field(196; "Desc. Duração Tempo Trabalho"; Text[200])
        {
            Caption = 'Work Time Duration Description';
            Description = 'RU';
        }
        field(197; "Formação-Situação face à freq."; Code[20])
        {
            // Caption = 'Training-Situation face the freq.';
            Description = 'RU - passou para uma tabela';
            //Enabled = false;
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(SitFF));
        }
        field(198; Marcado; Boolean)
        {
            Caption = 'Marked';
            Description = 'RU - usado para fazer filtros';
        }
        field(199; "Orgão Social"; Boolean)
        {
            Caption = 'Social Organ';
        }
        field(200; "No. Dias Trabalho Mensal"; Decimal)
        {
            Caption = 'Month Work Days No.';
            Description = 'por causa dos trabalhadores a tempo parcial';
            Editable = false;
        }
        field(230; Intern; Boolean)
        {
            Caption = 'Estagiário';
            DataClassification = ToBeClassified;
        }
        field(231; "Civil State Date"; Date)
        {
            Caption = 'Data Estado Civil';
            DataClassification = ToBeClassified;
            Description = 'portal empregado';
        }
        field(232; Locality; Text[30])
        {
            Caption = 'Localidade';
            DataClassification = ToBeClassified;
            Description = 'portal empregado';
        }
        field(250; "Vacation Balance"; Decimal)
        {
            CalcFormula = Sum("Hist. Cab. Movs. Empregado"."Vacation Days Balance" WHERE("Tipo Processamento" = CONST(Vencimentos),
                                                                                          "Employee No." = FIELD("No.")));
            Caption = 'Saldo Férias';
            FieldClass = FlowField;
        }
        field(300; "NAV User Id"; Text[50])
        {
            Caption = 'ID Utilizador NAV';

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
            end;
        }
        field(301; "Responsibility Center"; Code[10])
        {
            Caption = 'Centro Responsabilidade';
            TableRelation = "Responsibility Center";
        }
        field(50000; "NIB Cartao Ref"; Text[30])
        {
            Caption = 'NIB Cartão Refeição';
            DataClassification = ToBeClassified;
            Description = 'tagus';
        }

        field(302; "IRS Jovem"; Boolean)
        {
            Caption = 'IRS Jovem';
            DataClassification = ToBeClassified;
        }
        field(303; "Escalão IRS Jovem"; Code[60])
        {
            Caption = 'Escalão IRS Jovem';
            DataClassification = ToBeClassified;
            TableRelation = "Regimes IRS Jovem".Code;
        }
    }

    keys
    {
        key(Key1; "No.")
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
        key(Key9; "No. Horas Semanais")
        {
        }
        key(Key10; Status, Sex)
        {
        }
        key(Key11; Name)
        {
        }
        key(Key12; Estabelecimento, "Cod. Regime SS", Name)
        {
        }
        key(Key13; Status, "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        AlternativeAddr.SetRange("Employee No.", "No.");
        AlternativeAddr.DeleteAll;
        DimMgt.DeleteDefaultDim(DATABASE::Empregado, "No.");
        TabHistLinhasMovEmpregado.Reset;
        TabHistLinhasMovEmpregado.SetRange(TabHistLinhasMovEmpregado."Employee No.", "No.");
        if not TabHistLinhasMovEmpregado.FindFirst then begin
            TabContratoEmpregado.SetRange(TabContratoEmpregado."Cód. Empregado", "No.");
            TabContratoEmpregado.DeleteAll;

            TabCategoriaProfIntEmp.SetRange(TabCategoriaProfIntEmp."Employee No.", "No.");
            TabCategoriaProfIntEmp.DeleteAll;

            TabCategoriaProfQPEmp.SetRange(TabCategoriaProfQPEmp."Employee No.", "No.");
            TabCategoriaProfQPEmp.DeleteAll;

            TabFormacao.SetRange(TabFormacao."Employee No.", "No.");
            TabFormacao.DeleteAll;

            EmployeeQualification.SetRange(EmployeeQualification."Employee No.", "No.");
            EmployeeQualification.DeleteAll;

            TabHorario.SetRange(TabHorario."Employee No.", "No.");
            TabHorario.DeleteAll;

            TabConsultasMedicas.SetRange(TabConsultasMedicas."Employee No.", "No.");
            TabConsultasMedicas.DeleteAll;

            MiscArticleInformation.SetRange(MiscArticleInformation."Employee No.", "No.");
            MiscArticleInformation.DeleteAll;

            TabInactividade.SetRange(TabInactividade."Employee No.", "No.");
            TabInactividade.DeleteAll;

            TabProfissionalizacao.SetRange(TabProfissionalizacao."Cod Empregado", "No.");
            TabProfissionalizacao.DeleteAll;

            EmployeeAbsence.SetRange(EmployeeAbsence."Employee No.", "No.");
            EmployeeAbsence.DeleteAll;

            TabHorasExtra.SetRange(TabHorasExtra."Employee No.", "No.");
            TabHorasExtra.DeleteAll;

            TabAbonoDescExtra.SetRange(TabAbonoDescExtra."Employee No.", "No.");
            TabAbonoDescExtra.DeleteAll;

            TabFeriasEmpregado.SetRange(TabFeriasEmpregado."Employee No.", "No.");
            TabFeriasEmpregado.DeleteAll;

            HumanResComment.SetRange(HumanResComment."No.", "No.");
            HumanResComment.DeleteAll;

            Relative.SetRange(Relative."Employee No.", "No.");
            Relative.DeleteAll;

            AlternativeAddr.SetRange(AlternativeAddr."Employee No.", "No.");
            AlternativeAddr.DeleteAll;

            ConfidentialInformation.SetRange(ConfidentialInformation."Employee No.", "No.");
            ConfidentialInformation.DeleteAll;

            TabRubricasEmpregado.SetRange(TabRubricasEmpregado."Employee No.", "No.");
            TabRubricasEmpregado.DeleteAll;

            TabDistCentroCusto.SetRange(TabDistCentroCusto."Employee No.", "No.");
            TabDistCentroCusto.DeleteAll;

            TabLinhasMovsEmpregado.SetRange(TabLinhasMovsEmpregado."Employee No.", "No.");
            TabLinhasMovsEmpregado.DeleteAll;

            TabCabMovsEmpregado.SetRange(TabCabMovsEmpregado."Employee No.", "No.");
            TabCabMovsEmpregado.DeleteAll;

            TabGrauFuncaoEmpr.SetRange(TabGrauFuncaoEmpr."Employee No.", "No.");
            TabGrauFuncaoEmpr.DeleteAll;
        end;
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            HumanResSetup.Get;
            HumanResSetup.TestField("Employee Nos.");
            if NoSeriesMgt.AreRelated(HumanResSetup."Employee Nos.", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeriesMgt.GetNextNo("No. Series");
        end;

        DimMgt.UpdateDefaultDim(
          DATABASE::Empregado, "No.",
          "Global Dimension 1 Code", "Global Dimension 2 Code");

        //Preenche o campo Seguradora e Nº Apolice com os dados vindos da Conf. RH
        if HumanResSetup.Get then;
        Seguradora := HumanResSetup."Insurance Company";
        "No. Apólice" := HumanResSetup."No. Apólice";
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
        if Res.ReadPermission then
            EmployeeResUpdate.HumanResToRes(xRec, Rec);
        if SalespersonPurchaser.ReadPermission then
            EmployeeSalespersonUpdate.HumanResToSalesPerson(xRec, Rec);
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
    end;

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
        NoSeriesMgt: Codeunit "No. Series";
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
        Text0001: Label 'Defina o IBAN com 25 caracteres.';
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
        Text73100: Label 'The password must have more then 6 characters.';
        RUTabelas: Record "RU - Tabelas";
        RespCenter: Record "Responsibility Center";
        CompanyInfo: Record "Company Information";


    procedure AssistEdit(OldEmployee: Record Empregado): Boolean
    begin
        Employee := Rec;
        HumanResSetup.Get;
        HumanResSetup.TestField("Employee Nos.");


        if NoSeriesMgt.LookupRelatedNoSeries(HumanResSetup."Employee Nos.", OldEmployee."No. Series", Employee."No. Series") then begin
            HumanResSetup.Get;
            HumanResSetup.TestField("Employee Nos.");
            NoSeriesMgt.GetNextNo(Employee."No.");
            Rec := Employee;
            exit(true);
        end;
    end;


    procedure FullName(): Text[100]
    begin
        exit(Name);
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::Empregado, "No.", FieldNumber, ShortcutDimCode);
        Modify;
    end;


    procedure PrePadString(InString: Text[250]; Maxlen: Integer): Text[250]
    begin
        exit(PadStr('', Maxlen - StrLen(InString), '0') + InString);
    end;


    procedure CalcTaxaIRSEmpregado()
    var
        Text001: Label 'Deseja também actualizar os restantes empregados?';
    begin
        if not Confirm(Text001, false) then
            Calculo(Rec)
        else
            CalcTaxaIRSTodosEmpregados;
    end;


    procedure CalcTaxaIRSTodosEmpregados()
    var
        rEmpregado: Record Empregado;
    begin
        rEmpregado.Reset;
        rEmpregado.SetRange(Status, rEmpregado.Status::Active);
        rEmpregado.SetFilter("Tipo Contribuinte", '<>%1&<>%2', 0, 2);
        rEmpregado.SetFilter("Local Obtenção Rendimento", '<>%1', 0);
        if rEmpregado.FindSet then
            repeat
                Calculo(rEmpregado);
            until rEmpregado.Next = 0;
    end;


    procedure Calculo(pEmpregado: Record Empregado)
    var
        Text50001: Label 'Não existe em vigor nenhuma Rúbrica do tipo Vencimento Base para o Empregado %1 - %2';
        TabelaIRS: Record "Tabela IRS";
        TabEmpregado: Record Empregado;
        DeductValue: Decimal;
    begin
        TabEmpregado := pEmpregado;
        if TabEmpregado."IRS % Fixa" = 0 then begin
            TabEmpregado."Valor Vencimento Base" := FuncoesRH.CalcularVencimentoBase(WorkDate, TabEmpregado);
            TabEmpregado.Modify;

            if TabEmpregado."Valor Vencimento Base" <> 0 then begin
                TabEmpregado."IRS %" := FuncoesRH.CalcularTaxaIRS2024(TabEmpregado."Valor Vencimento Base", TabEmpregado,
                                            WORKDATE, DeductValue);
                TabEmpregado.Modify;
                //Trazer o Nome da Tabela de IRS
                if (pEmpregado."Tipo Contribuinte" = 1) and (pEmpregado."Estado Civil" <> 1) and (pEmpregado."Estado Civil" <> 5)
                   and (pEmpregado.Deficiente = 0) then begin
                    TabelaIRS.SetRange(TabelaIRS.Tabela, 1);
                end;


                if (pEmpregado."Tipo Contribuinte" = 1) and ((pEmpregado."Estado Civil" = 1) or (pEmpregado."Estado Civil" = 5))
                    and (pEmpregado.Deficiente = 0) and (pEmpregado."Titular Rendimentos" = 1) then begin
                    TabelaIRS.SetRange(TabelaIRS.Tabela, 2);
                end;

                if (pEmpregado."Tipo Contribuinte" = 1) and ((pEmpregado."Estado Civil" = 1) or (pEmpregado."Estado Civil" = 5))
                   and (pEmpregado.Deficiente = 0) and (pEmpregado."Titular Rendimentos" = 2) then begin
                    TabelaIRS.SetRange(TabelaIRS.Tabela, 3);
                end;


                if (pEmpregado."Tipo Contribuinte" = 1) and (pEmpregado."Estado Civil" <> 1) and (pEmpregado."Estado Civil" <> 5)
                   and (pEmpregado.Deficiente = 1) then begin
                    TabelaIRS.SetRange(TabelaIRS.Tabela, 4);
                end;

                if (pEmpregado."Tipo Contribuinte" = 1) and ((pEmpregado."Estado Civil" = 1) or (pEmpregado."Estado Civil" = 5))
                   and (pEmpregado.Deficiente = 1) and
                   (pEmpregado."Titular Rendimentos" = 1) then begin
                    TabelaIRS.SetRange(TabelaIRS.Tabela, 5);
                end;


                if (pEmpregado."Tipo Contribuinte" = 1) and ((pEmpregado."Estado Civil" = 1) or (pEmpregado."Estado Civil" = 5))
                   and (pEmpregado.Deficiente = 1) and (pEmpregado."Titular Rendimentos" = 2) then begin
                    TabelaIRS.SetRange(TabelaIRS.Tabela, 6);
                end;

                if (pEmpregado."Tipo Contribuinte" = 3) and (pEmpregado.Deficiente = 0) then begin
                    TabelaIRS.SetRange(TabelaIRS.Tabela, 7);
                end;

                if (pEmpregado."Tipo Contribuinte" = 3) and (pEmpregado.Deficiente = 1) then begin
                    TabelaIRS.SetRange(TabelaIRS.Tabela, 8);
                end;

                if (pEmpregado."Tipo Contribuinte" = 3) and (pEmpregado.Deficiente = 2) then begin
                    TabelaIRS.SetRange(TabelaIRS.Tabela, 9);
                end;

                if TabelaIRS.Find('-') then begin

                    TabEmpregado."Tabela IRS" := Format(TabelaIRS.Tabela);
                    TabEmpregado."Descrição Tabela IRS" := TabelaIRS.Descrição;
                    TabEmpregado.Modify;
                end;
            end else begin
                Message(Text50001, pEmpregado."No.", pEmpregado.Name);
            end;
        end;
    end;


    //VC.MIG.S
    /* NOTES: Commented because is not called anywhere in the code
        procedure OpenFile(WindowTitle: Text[50]; DefaultFileName: Text[250]; DefaultFileType: Option " ",Text,Excel,Word,Custom; FilterString: Text[250]; "Action": Option Open,Save; var FileNameImport: Text[250]; var "extensão": Code[50]; var Path: Text[250]): Text[260]
        var
            Text0031: Label '.txt';
            Text0032: Label '.xls';
            Text0033: Label '.doc';
            pos: Integer;
            fileName: Text[250];
            FileMgt: Codeunit "File Management";
        begin
            if DefaultFileType = DefaultFileType::Custom then begin
                if StrPos(UpperCase(FilterString), '.DOC') > 0 then
                    DefaultFileType := DefaultFileType::Word;
                if StrPos(UpperCase(FilterString), '.XL') > 0 then
                    DefaultFileType := DefaultFileType::Excel;
            end;

            if Action = Action::Open then
                FileNameImport := FileMgt.OpenFileDialog('Abrir Ficheiro', '', FilterString)
            else
                FileNameImport := FileMgt.SaveFileDialog('Gravar Ficheiro', '', FilterString);
            Path := FileNameImport;
            exit(FileMgt.GetFileName(FileNameImport));
        end;
    */

    procedure GerarContrato(Empregado: Record Empregado)
    var
        rTemplates: Record "Importação Templates";
        path: Text[1024];
        rCompanyInformation: Record "Company Information";
        TabQualificacoes: Record "Qualificação Empregado";
        MyFile: File;
        MyOutStream: OutStream;
        NumberOfChars: Integer;
        "g_recImportaçãoTemplates": Record "Importação Templates";
    // wdApp2: DotNet WordApplicationClass;
    begin
        //TODO:NEEDS TESTING
        g_recImportaçãoTemplates.Reset;
        g_recImportaçãoTemplates.SetRange("No.", 'RH-CONTRAC');
        if g_recImportaçãoTemplates.Find() then begin
            Report.RunModal(g_recImportaçãoTemplates."Report ID", true, false, Rec);
        end;
    end;
}

