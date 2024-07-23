tableextension 53040 "Employee Ext" extends Employee
{
    // Tagus - novo campo 50000
    //CGA SQD - table employee to table extension
    //field no. starts from 53035, same as tables&pages
    //changed record empregado to record employee in functions

    Caption = 'Employee';
    DataCaptionFields = "No.", "First Name", "Last Name", Status;
    DrillDownPageID = "Lista Empregado";
    LookupPageID = "Lista Empregado";

    fields
    {
        field(53035; Name; Text[75])
        {
            CaptionML = ENU = 'Name', PTG = 'Nome Completo';

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
        field(53036; CompanyMobilePhoneNo; Text[30])
        {
            Caption = 'Company Mobile Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(53037; "Company Phone No."; Text[30])
        {
            Caption = 'Company Phone No.';
        }
        field(53038; "Tipo Empregado"; Code[20])
        {
            Caption = 'Employee Type';
            TableRelation = "Tipo Empregado";
        }
        field(53039; Estabelecimento; Code[4])
        {
            Caption = 'Estabelecimento';
            TableRelation = "Estabelecimentos da Empresa";
        }
        field(53040; Seguradora; Text[60])
        {
            Caption = 'Insurance Company';
        }
        field(53041; "No. Apólice"; Text[20])
        {
            Caption = 'Insurance Policy No.';
        }
        field(53042; "Documento Identificação"; Option)
        {
            Caption = 'Identification Document';
            OptionCaption = ' ,Cédula,BI,Passaporte,Cartão Cidadão,Autorização residência temporária,Autorização residência permanente,Cartão residência,Visto trabalho,Outros';
            OptionMembers = " ","Cédula",BI,Passaporte,"Cartão Cidadão","Autorização residência temporária","Autorização residência permanente","Cartão residência","Visto trabalho",Outros;
        }
        field(53043; "No. Doc. Identificação"; Text[14])
        {
            Caption = 'Identification Doc. No.';
        }
        field(53044; "Local Emissão Doc. Ident."; Text[30])
        {
            Caption = 'Ident. Doc. Issue Local';
        }
        field(53045; "Data Doc. Ident."; Date)
        {
            Caption = 'Ident. Doc.Date';
        }
        field(53046; "Data Validade Doc. Ident."; Date)
        {
            Caption = 'Ident. Doc. Expiration Date';
        }
        field(53047; Nacionalidade; Text[30])
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
        field(53048; "Nacionalidade Descrição"; Text[50])
        {
            Caption = 'Nationality Description';
        }
        field(53049; "No. Contribuinte"; Text[9])
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
        field(53050; "Tipo Contribuinte"; Option)
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
        field(53051; "Cod. Repartição Finanças"; Text[4])
        {
            Caption = 'Finance Allocation Code';
            Numeric = true;
        }
        field(53052; "Repartição Finanças"; Text[30])
        {
            Caption = 'Finance Allocation';
        }
        field(53053; "Data Emissão NIF"; Date)
        {
            Caption = 'Tax Information No. Issue Date';
        }
        field(53054; "Tipo Rendimento"; Option)
        {
            Caption = 'Salary Type';
            OptionCaption = 'A,B';
            OptionMembers = A,B;
        }
        field(53055; "Local Obtenção Rendimento"; Option)
        {
            Caption = 'Income Obtaining Location';
            OptionCaption = ' ,C,RA,RM';
            OptionMembers = " ",C,RA,RM;
        }
        field(53056; Deficiente; Option)
        {
            Caption = 'With disability';
            OptionCaption = ' ,Sim,Forças Armadas';
            OptionMembers = "Não",Sim,"Forças Armadas";
        }
        field(53057; "Estado Civil"; Option)
        {
            Caption = 'Marital Status';
            OptionCaption = 'Solteiro,Casado,Divorciado,Viúvo,Outro,União Facto';
            OptionMembers = Solteiro,Casado,Divorciado,"Viúvo",Outro,"União Facto";
        }
        field(53058; "Titular Rendimentos"; Option)
        {
            Caption = 'Income Holder';
            OptionCaption = ' ,Único Titular,Dois Titulares';
            OptionMembers = " ","Único Titular","Dois Titulares";
        }
        field(53059; "Conjuge Deficiente"; Boolean)
        {
            Caption = 'Disabled Spouse';
        }
        field(53060; "No. Dependentes"; Integer)
        {
            Caption = 'Dependents No.';
        }
        field(53061; "No. Dependentes Deficientes"; Integer)
        {
            Caption = 'Disabled Dependents No.';
        }
        field(53062; "Tabela IRS"; Text[3])
        {
            Caption = 'IRS Tables';
        }
        field(53063; "Descrição Tabela IRS"; Text[60])
        {
            Caption = 'IRS Tables Description';
        }
        field(53064; "IRS %"; Decimal)
        {
            Caption = 'IRS %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(53065; "IRS % Fixa"; Decimal)
        {
            Caption = 'IRS Fixed %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(53066; "Subscritor SS"; Boolean)
        {
            Caption = 'SS Subscriber';
        }
        field(53067; "No. Segurança Social"; Text[11])
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
        field(53068; "Data da Admissão SS"; Date)
        {
            Caption = 'SS Admission Date';
        }
        field(53069; "Data Emissão SS"; Date)
        {
            Caption = 'SS Emission Date';
        }
        field(53070; "Cod. Instituição SS"; Code[10])
        {
            Caption = 'SS Institution Code';
            TableRelation = "Instituição Seg. Social".Code;
        }
        field(53071; "Cod. Regime SS"; Code[10])
        {
            Caption = 'SS Regime Code';
            TableRelation = "Regime Seg. Social"."Código" WHERE("Código" = FIELD("Cod. Regime SS"));
        }
        field(53072; "Subscritor ADSE"; Boolean)
        {
        }
        field(53073; "Nº ADSE"; Text[11])
        {
            Caption = 'Nº ADSE';
        }
        field(53074; "Data da Admissão ADSE"; Date)
        {
            Caption = 'Data da Admissão ADSE';
        }
        field(53075; "Data de Emissão ADSE"; Date)
        {
            Caption = 'Data de Emissão ADSE';
        }
        field(53076; "Subsccritor CGA"; Boolean)
        {
            Caption = 'Subsccritor CGA';
        }
        field(53077; "Nº CGA"; Text[11])
        {
            Caption = 'Nº CGA';
            Numeric = true;
        }
        field(53078; "Data da Admissão CGA"; Date)
        {
            Caption = 'Data da Admissão CGA';
        }
        field(53079; "Data de Emissão CGA"; Date)
        {
            Caption = 'Data de Emissão CGA';
        }
        field(53080; "Nº Horas Docência Calc. Desct."; Integer)
        {
            Caption = 'Nº Horas Docência Calc. Desct.';
            Enabled = false;
        }
        field(53081; "Data de Antiguidade"; Date)
        {
            Caption = 'Seniority Date';
        }
        field(53082; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(53083; "Motivo de Terminação"; Code[10])
        {
            Caption = 'End Reason';
            Description = 'RU';
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(MotSai));
        }
        field(53084; "Cód. IRCT"; Code[5])
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
        field(53085; "Acordo Colectivo"; Code[20])
        {
            Caption = 'Collective Agreement';
        }
        field(53086; "Descrição IRCT"; Text[100])
        {
            Caption = 'IRCT Description';
        }
        field(53087; "Aplicabilidade do IRCT"; Option)
        {
            Caption = 'IRCT Applicability';
            Description = 'RU';
            OptionCaption = 'Filiação,Portaria de Extensão,Escolha,Acto de Gestão,Não sabe qual dos IRCT se aplica,Sem aplicabilidade,Automática';
            OptionMembers = "01","02","03","04","05","06","07";
        }
        field(53088; "Cód. Cat. Profissional"; Code[20])
        {
            CalcFormula = Lookup("Cat. Prof. Int. Empregado"."Cód. Cat. Prof." WHERE("No. Empregado" = FIELD("No."),
                                                                                      "Data Inicio Cat. Prof." = FIELD("Data Filtro Inicio"),
                                                                                      "Data Fim Cat. Prof." = FIELD("Data Filtro Fim")));
            Caption = 'Professional Category Code';
            FieldClass = FlowField;
        }
        field(53089; "Descrição Cat Prof"; Text[100])
        {
            CalcFormula = Lookup("Cat. Prof. Int. Empregado"."Descrição" WHERE("No. Empregado" = FIELD("No."),
                                                                                "Data Inicio Cat. Prof." = FIELD("Data Filtro Inicio"),
                                                                                "Data Fim Cat. Prof." = FIELD("Data Filtro Fim")));
            Caption = 'Prof. Cate. Description';
            FieldClass = FlowField;
        }
        field(53090; "Cód. Cat. Prof QP"; Code[20])
        {
            CalcFormula = Lookup("Cat. Prof. QP Empregado"."Cód. Cat. Prof. QP" WHERE("No. Empregado" = FIELD("No."),
                                                                                       "Data Inicio Cat. Prof." = FIELD("Data Filtro Inicio"),
                                                                                       "Data Fim Cat. Prof." = FIELD("Data Filtro Fim")));
            Caption = 'Prof. Cate. QP Code';
            FieldClass = FlowField;
        }
        field(53091; "Descrição Cat Prof QP"; Text[200])
        {
            CalcFormula = Lookup("Cat. Prof. QP Empregado".Description WHERE("No. Empregado" = FIELD("No."),
                                                                              "Data Inicio Cat. Prof." = FIELD("Data Filtro Inicio"),
                                                                              "Data Fim Cat. Prof." = FIELD("Data Filtro Fim")));
            Caption = 'Prof. Cate. QP Description';
            FieldClass = FlowField;
        }
        field(53092; "Class. Nac. Profi."; Code[20])
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
        field(53093; "Descrição Class. Nac."; Text[150])
        {
            Caption = 'Nac. Class. Description';
        }
        field(53094; "Cód. Habilitações"; Code[20])
        {
            Caption = 'Qualifications Code';
            TableRelation = "Habilitação"."Código";

            trigger OnValidate()
            begin
                if TabHabilitações.Get("Cód. Habilitações") then
                    "Descrição Habilitações" := TabHabilitações.Descrição;
            end;
        }
        field(53095; "Descrição Habilitações"; Text[200])
        {
            Caption = 'Qualifications Description';
        }
        field(53096; "Situação Profissional"; Option)
        {
            Caption = 'Professional Status';
            Description = 'RU';
            OptionCaption = ' ,Empregador,Trabalhador Familiar Não Remunerado,Trabalhador por Conta de Outrém,Membro Activo de Cooperativa de Produção,Outra Situação';
            OptionMembers = " ","1","2","3","4","8";
        }
        field(53097; "Grau Função"; Code[20])
        {
            CalcFormula = Lookup("Grau Função Empregado"."Cód. Grau Função" WHERE("No. Empregado" = FIELD("No."),
                                                                                   "Data Inicio Grau Função" = FIELD("Data Filtro Inicio"),
                                                                                   "Data Fim Grau Função" = FIELD("Data Filtro Fim")));
            Caption = 'Degree Role';
            FieldClass = FlowField;
        }
        field(53098; "Descrição Grau Função"; Text[200])
        {
            CalcFormula = Lookup("Grau Função Empregado"."Descrição" WHERE("No. Empregado" = FIELD("No."),
                                                                            "Data Inicio Grau Função" = FIELD("Data Filtro Inicio"),
                                                                            "Data Fim Grau Função" = FIELD("Data Filtro Fim")));
            Caption = 'Degree Role Description';
            FieldClass = FlowField;
        }
        field(53099; "Cód. Horário"; Code[20])
        {
            CalcFormula = Lookup("Horário Empregado"."Cód. Horário" WHERE("No. Empregado" = FIELD("No."),
                                                                           "Data Iníco Horário" = FIELD("Data Filtro Inicio"),
                                                                           "Data Fim Horário" = FIELD("Data Filtro Fim")));
            Caption = 'Schedule Code';
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;
        }
        field(53100; "Valor Vencimento Base"; Decimal)
        {
            Caption = 'Base Salary Amount';
        }
        field(53101; "Valor Dia"; Decimal)
        {
            Caption = 'Day Amount';
        }
        field(53102; "Valor Hora"; Decimal)
        {
            Caption = 'Hour Amount';
        }
        field(53103; "No. Horas Semanais"; Decimal)
        {
            Caption = 'Week Hours No.';
        }
        field(53104; "Mês Proc. Sub. Férias"; Integer)
        {
            Caption = 'Proc. Vacat. Benef. Month';
        }
        field(53105; "Nº Professor"; Code[20])
        {
            Caption = 'Nº Professor';
            Enabled = false;
        }
        field(53106; "Regime Duração Trabalho"; Option)
        {
            Caption = 'Work Duration Regime';
            Description = 'RU';
            OptionCaption = ' ,A tempo completo,A tempo parcial';
            OptionMembers = " ","1","2";
        }
        field(53107; "Usa Transf. Bancária"; Boolean)
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
        field(53108; "Cód. Banco Transf."; Code[20])
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
        field(53109; "IVA %"; Decimal)
        {
            Caption = 'IVA %';
            Description = 'Trabalhador Independente';
            MaxValue = 100;
            MinValue = 0;
        }
        field(53110; "Nome Livro Diario Pag."; Code[10])
        {
            Caption = 'Gen. Journal Name Pag.';
            Description = 'Pagamento';
            TableRelation = "Gen. Journal Template".Name;
        }
        field(53111; "Secção Diario Pag."; Code[10])
        {
            Caption = 'Gen. Journal Section';
            Description = 'Pagamento';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Nome Livro Diario Pag."));
        }
        field(53112; Pagamento; Option)
        {
            Caption = 'Payment';
            Description = 'Pagamento';
            OptionCaption = 'Conta Bancária,Conta CG';
            OptionMembers = "Bank Account","G/L Account";
        }
        field(53113; "Conta Pag."; Code[20])
        {
            Caption = 'Payment Acc.';
            Description = 'Pagamento';
            TableRelation = IF (Pagamento = CONST("Bank Account")) "Bank Account"."No."
            ELSE
            IF (Pagamento = CONST("G/L Account")) "G/L Account"."No.";
        }
        field(53114; "Envio Recibo via E-Mail"; Boolean)
        {
            Caption = 'Send Receipt via E-Mail';
            Description = 'Recibo PDF via Email';
            ExtendedDatatype = None;
        }
        field(53115; "Password Recibo em PDF"; Text[8])
        {
            Caption = 'Receipt Passord PDF';
            Description = 'Recibo PDF via Email';
        }
        field(53116; "Endereço de Envio"; Option)
        {
            Caption = 'Send to Email';
            Description = 'Recibo PDF via Email';
            OptionCaption = 'Empresa,Pessoal';
            OptionMembers = Empresa,Pessoal;
        }
        field(53117; "Última data Proc. Sub. Férias"; Date)
        {
            Caption = 'Last Date Proc. Vacation Benef.';
            Description = 'Para saber até que data o Sub. Férias está pago';
        }
        field(53118; "Data Filtro Inicio"; Date)
        {
            Caption = 'Start Date Filter';
            Description = 'Filtra os Contratos, Categorias Profissionais e Funções Actuais';
            FieldClass = FlowFilter;
        }
        field(53119; "Data Filtro Fim"; Date)
        {
            Caption = 'End Date Filter';
            Description = 'Filtra os Contratos, Categorias Profissionais e Funções Actuais';
            FieldClass = FlowFilter;
        }
        field(53120; "Total Férias"; Decimal)
        {
            CalcFormula = Sum("Férias Empregados"."Qtd." WHERE("No. Empregado" = FIELD("No."),
                                                                Data = FIELD("Date Filter"),
                                                                Tipo = CONST(ferias)));
            Caption = 'Total Vacations';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(53121; "Filtro Hora Extra"; Code[10])
        {
            Caption = 'Extra Hour Filter';
            FieldClass = FlowFilter;
            TableRelation = "Tipos Horas Extra";
        }
        field(53122; "Hora Extra Total (Base)"; Decimal)
        {
            CalcFormula = Sum("Histórico Horas Extra".Quantidade WHERE("No. Empregado" = FIELD("No."),
                                                                        "Cód. Hora Extra" = FIELD("Filtro Hora Extra"),
                                                                        Data = FIELD("Date Filter")));
            Caption = 'Extra Hour Total (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(53123; "Naturalidade - Concelho"; Text[60])
        {
            Caption = 'Birth - County';
        }
        field(53124; "No. dias de Trabalho Semanal"; Decimal)
        {
            Caption = 'Work Week No. of days';
        }
        field(53125; "Profissionalização"; Boolean)
        {
            CalcFormula = Exist("Profissionalização" WHERE("Cod Empregado" = FIELD("No.")));
            Caption = 'Professionalization';
            FieldClass = FlowField;
        }
        field(53126; "Data Profissionalização"; Date)
        {
            Caption = 'Professionalization Date';
        }
        field(53127; "Cód. Rúbrica Enc. Seg. Social"; Code[20])
        {
            Caption = 'Social Security Charges Rubric Code';
            TableRelation = "Rubrica Salarial";
        }
        field(53128; "Cód. Rúbrica Enc. CGA"; Code[20])
        {
            Caption = 'Cód. Rúbrica Enc. CGA';
            TableRelation = "Rubrica Salarial";
        }
        field(53129; "Cód. Rúbrica Enc. ADSE"; Code[20])
        {
            Caption = 'Cód. Rúbrica Enc. ADSE';
            TableRelation = "Rubrica Salarial";
        }
        field(53130; "Professor Acumulação"; Boolean)
        {
            Caption = 'Professor Acumulação';
            Description = 'O professor não desconta para a CGA';
            Enabled = false;
        }
        field(53131; "Nº dias Fich. Seg. Social"; Integer)
        {
            Caption = 'Nº dias Fich. Seg. Social';
            Description = 'CIDSCS';
        }
        field(53132; "No. antigo do Empregado"; Code[20])
        {
            Caption = 'Old Employee No.';
        }
        field(53133; "No. Horas Semanais Totais"; Decimal)
        {
            //Enabled = false;
            Enabled = true;
        }
        field(53134; "Vitalício"; Boolean)
        {
            Caption = 'Perpetual';
        }
        field(53135; "CGA - Requisição"; Boolean)
        {
            Caption = 'CGA - Requisição';
            Description = 'O Empregado desconta mas a entidade patronal não';
        }
        field(53136; "Grau Função-Efeitos Progres."; Code[20])
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
        field(53137; "Descrição Grau Função Progr."; Text[100])
        {
            Caption = 'Descrição Grau Função Progr.';
            Description = 'Registar o Grau de função no qual deveria estar';
            Enabled = false;
        }
        field(53138; Docente; Boolean)
        {
            Caption = 'Docente';
            Description = 'MISI';
            Enabled = false;
        }
        field(53139; "Cod. Freguesia"; Code[6])
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
        field(53140; Freguesia; Text[30])
        {
            Caption = 'Freguesia';
            Description = 'MISI';
        }
        field(53141; "Habilitação Docência"; Option)
        {
            Caption = 'Habilitação Docência';
            Description = 'MISI';
            Enabled = false;
            OptionCaption = ' ,Licenciado profissionalizado,Bacharel profissionalizado,Habilitação própria com grau superior,Habilitação própria sem grau superior,Autorização provisória de leccionação,Autorização de leccionação,Diploma de ensino particular e cooperativo,Certificado de aptidão pedagógica';
            OptionMembers = " ","1","2","3","4","5","6","7","8";
        }
        field(53142; "Grupo Docência"; Code[3])
        {
            Caption = 'Grupo Docência';
            Description = 'MISI';
            Enabled = false;
        }
        field(53143; "Acumulação"; Option)
        {
            Caption = 'Acumulação';
            Description = 'MISI';
            Enabled = false;
            OptionCaption = 'Não Acumula,Acumula funções no Ensino Oficial com o Particular,Acumula funções em escolas Particulares';
            OptionMembers = "0","1","2";
        }
        field(53144; "Nº Dias Tempo Serviço"; Integer)
        {
            Caption = 'Dias de Serviço - Ensino';
            Description = 'MISI';
            Enabled = false;
        }
        field(53145; "Nº Horas Sem. Lect Diurno Cont"; Integer)
        {
            Caption = 'Diurnas - Contrato Ass.';
            Description = 'MISI';
            Enabled = false;
        }
        field(53146; "Nº Horas Sem. Lect Diurno Tota"; Integer)
        {
            Caption = 'Diurnas - Totais (inc. Contrato Ass.)';
            Description = 'MISI';
            Enabled = false;
        }
        field(53147; "Nº Horas Sem. Lect Noct Cont"; Decimal)
        {
            Caption = 'Nocturnas - Contrato Ass.';
            DecimalPlaces = 1 : 1;
            Description = 'MISI';
            Enabled = false;
        }
        field(53148; "Nº Horas Sem. Lect Noct Tota"; Decimal)
        {
            Caption = 'Nocturnas - Totais (inc. Contrato Ass.)';
            DecimalPlaces = 1 : 1;
            Description = 'MISI';
            Enabled = false;
        }
        field(53149; "Nº Horas Sem.-Desp Escolar Con"; Integer)
        {
            Caption = 'Contrato Ass.';
            Description = 'MISI';
            Enabled = false;
        }
        field(53150; "Nº Horas Sem.-Desp Escolar Tot"; Integer)
        {
            Caption = 'Totais';
            Description = 'MISI';
            Enabled = false;
        }
        field(53151; "Nº Horas Sem.-Cargos Diur Cont"; Integer)
        {
            Caption = 'Diurnas - Contrato Ass.';
            Description = 'MISI';
            Enabled = false;
        }
        field(53152; "Nº Horas Sem.-Cargos Diur Tota"; Integer)
        {
            Caption = 'Diurnas - Totais (inc. Contrato Ass.)';
            Description = 'MISI';
            Enabled = false;
        }
        field(53153; "Nº Horas Sem.-Cargos Noct Cont"; Integer)
        {
            Caption = 'Nocturnas - Contrato Ass.';
            Description = 'MISI';
            Enabled = false;
        }
        field(53154; "Nº Horas Sem.-Cargos Noct Tota"; Integer)
        {
            Caption = 'Nocturnas - Totais (inc. Contrato Ass.)';
            Description = 'MISI';
            Enabled = false;
        }
        field(53155; "Nº Horas Sem.-Dir.Pedag Cont"; Integer)
        {
            Caption = 'Contrato Ass.';
            Description = 'MISI';
            Enabled = false;
        }
        field(53156; "Nº Horas Sem.-Dir.Pedag Tot"; Integer)
        {
            Caption = 'Totais (inc. Contrato Ass.)';
            Description = 'MISI';
            Enabled = false;
        }
        field(53157; ContratoME; Option)
        {
            Caption = 'ContratoME';
            Description = 'MISI';
            Enabled = false;
            OptionCaption = 'Associação,Patrocínio,Simples,Desenvolvimento,Cooperação,Não Abrangido,Programa (DRELVT)';
            OptionMembers = "1","2","3","4","5","6","7";
        }
        field(53158; "Direcção Pedagógica"; Boolean)
        {
            Caption = 'Direcção Pedagógica';
            Description = 'MISI';
            Enabled = false;
        }
        field(53159; "Valor Desc. Conf. Religiosa"; Decimal)
        {
            Caption = 'Valor Desc. Conf. Religiosa';
            Description = 'MISI';
            Enabled = false;
        }
        field(53160; "Valor Desc. Seguro"; Decimal)
        {
            Caption = 'Valor Desc. Seguro';
            Description = 'MISI';
            Enabled = false;
        }
        field(53161; "Dias de Serviço - Estabelecim."; Integer)
        {
            Caption = 'Dias de Serviço - Estabelecim.';
            Description = 'MISI';
            Enabled = false;
        }
        field(53162; "Substituição Temporária"; Boolean)
        {
            Caption = 'Substituição Temporária';
            Description = 'MISI';
            Enabled = false;
        }
        field(53163; "NIF do Docente Substituido"; Text[9])
        {
            Caption = 'NIF do Docente Substituido';
            Description = 'MISI';
            Enabled = false;
        }
        field(53164; "Data Inicio Substituição"; Date)
        {
            Caption = 'Data Inicio Substituição';
            Description = 'MISI';
            Enabled = false;
        }
        field(53165; "Data Fim Substituição"; Date)
        {
            Caption = 'Data Fim Substituição';
            Description = 'MISI';
            Enabled = false;
        }
        field(53166; "Situação"; Code[4])
        {
            Caption = 'Situação';
            Description = 'MISI';
            Enabled = false;
        }
        field(53167; "Descrição Situação"; Text[128])
        {
            Caption = 'Descrição Situação';
            Description = 'MISI';
            Enabled = false;
        }
        field(53168; "Afecto à Cantina"; Boolean)
        {
            Caption = 'Afecto à Cantina';
            Description = 'MISI';
            Enabled = false;
        }
        field(53169; "Exportar para o MISI"; Boolean)
        {
            Caption = 'Exportar para o MISI';
            Description = 'MISI';
            Enabled = false;
        }
        field(53170; "Cod. Cliente"; Code[20])
        {
            Caption = 'Customer Code';
            Description = 'Funcionalidade Contratos - Usado para criar um cliente para facturar Imp. Selo dos Contratos';
            TableRelation = Customer."No.";
        }
        field(53171; "Qualificação"; Code[50])
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
        field(53172; "Cod. Regime Reforma Aplicado"; Code[10])
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
        field(53173; "Regime Reforma Aplicado"; Text[30])
        {
            Caption = 'Applied Regime Reform';
            Description = 'RU';
        }
        field(53174; "Duração do Tempo de Trabalho"; Code[20])
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
        field(53175; "Desc. Duração Tempo Trabalho"; Text[200])
        {
            Caption = 'Work Time Duration Description';
            Description = 'RU';
        }
        field(53176; "Formação-Situação face à freq."; Code[20])
        {
            Caption = 'Training-Situation face the freq.';
            Description = 'RU - passou para uma tabela';
            //Enabled = false;
            TableRelation = "RU - Tabelas"."Código" WHERE(Tipo = CONST(SitFF));
        }
        field(53177; Marcado; Boolean)
        {
            Caption = 'Marked';
            Description = 'RU - usado para fazer filtros';
        }
        field(53178; "Orgão Social"; Boolean)
        {
            Caption = 'Social Organ';
        }
        field(53179; "No. Dias Trabalho Mensal"; Decimal)
        {
            Caption = 'Month Work Days No.';
            Description = 'por causa dos trabalhadores a tempo parcial';
            Editable = false;
        }
        field(53180; Intern; Boolean)
        {
            Caption = 'Intern';
            DataClassification = ToBeClassified;
        }
        field(53181; "Civil State Date"; Date)
        {
            Caption = 'Civil State Date';
            DataClassification = ToBeClassified;
            Description = 'portal empregado';
        }
        field(53182; Locality; Text[30])
        {
            Caption = 'Locality';
            DataClassification = ToBeClassified;
            Description = 'portal empregado';
        }
        field(53183; "Vacation Balance"; Decimal)
        {
            CalcFormula = Sum("Hist. Cab. Movs. Empregado"."Vacation Days Balance" WHERE("Tipo Processamento" = CONST(Vencimentos),
                                                                                          "No. Empregado" = FIELD("No.")));
            Caption = 'Saldo Férias';
            FieldClass = FlowField;
        }
        field(53184; "NAV User Id"; Text[50])
        {
            Caption = 'NAV User Id';

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
            end;
        }
        field(53185; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(53186; "NIB Cartao Ref"; Text[30])
        {
            Caption = 'Meal Card';
            DataClassification = ToBeClassified;
            Description = 'tagus';
        }
    }

    keys
    {
        key(Key7; Estabelecimento, "Cód. IRCT")
        {
        }
        key(Key8; "Birth Date")
        {
        }
        key(Key10; Seguradora, "No. Apólice")
        {
        }
        key(Key11; "No. Horas Semanais")
        {
        }
        key(Key12; Status, Gender)
        {
        }
        key(Key13; Name)
        {
        }
        key(Key14; Estabelecimento, "Cod. Regime SS", Name)
        {
        }
        key(Key15; Status, "No.")
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
        DimMgt.DeleteDefaultDim(DATABASE::Employee, "No.");
        TabHistLinhasMovEmpregado.Reset;
        TabHistLinhasMovEmpregado.SetRange(TabHistLinhasMovEmpregado."No. Empregado", "No.");
        if not TabHistLinhasMovEmpregado.FindFirst then begin
            TabContratoEmpregado.SetRange(TabContratoEmpregado."Cód. Empregado", "No.");
            TabContratoEmpregado.DeleteAll;

            TabCategoriaProfIntEmp.SetRange(TabCategoriaProfIntEmp."No. Empregado", "No.");
            TabCategoriaProfIntEmp.DeleteAll;

            TabCategoriaProfQPEmp.SetRange(TabCategoriaProfQPEmp."No. Empregado", "No.");
            TabCategoriaProfQPEmp.DeleteAll;

            TabFormacao.SetRange(TabFormacao."No. Empregado", "No.");
            TabFormacao.DeleteAll;

            EmployeeQualification.SetRange(EmployeeQualification."Employee No.", "No.");
            EmployeeQualification.DeleteAll;

            TabHorario.SetRange(TabHorario."No. Empregado", "No.");
            TabHorario.DeleteAll;

            TabConsultasMedicas.SetRange(TabConsultasMedicas."No. Empregado", "No.");
            TabConsultasMedicas.DeleteAll;

            MiscArticleInformation.SetRange(MiscArticleInformation."Employee No.", "No.");
            MiscArticleInformation.DeleteAll;

            TabInactividade.SetRange(TabInactividade."No. Empregado", "No.");
            TabInactividade.DeleteAll;

            TabProfissionalizacao.SetRange(TabProfissionalizacao."Cod Empregado", "No.");
            TabProfissionalizacao.DeleteAll;

            EmployeeAbsence.SetRange(EmployeeAbsence."Employee No.", "No.");
            EmployeeAbsence.DeleteAll;

            TabHorasExtra.SetRange(TabHorasExtra."No. Empregado", "No.");
            TabHorasExtra.DeleteAll;

            TabAbonoDescExtra.SetRange(TabAbonoDescExtra."No. Empregado", "No.");
            TabAbonoDescExtra.DeleteAll;

            TabFeriasEmpregado.SetRange(TabFeriasEmpregado."No. Empregado", "No.");
            TabFeriasEmpregado.DeleteAll;

            HumanResComment.SetRange(HumanResComment."No.", "No.");
            HumanResComment.DeleteAll;

            Relative.SetRange(Relative."Employee No.", "No.");
            Relative.DeleteAll;

            AlternativeAddr.SetRange(AlternativeAddr."Employee No.", "No.");
            AlternativeAddr.DeleteAll;

            ConfidentialInformation.SetRange(ConfidentialInformation."Employee No.", "No.");
            ConfidentialInformation.DeleteAll;

            TabRubricasEmpregado.SetRange(TabRubricasEmpregado."No. Empregado", "No.");
            TabRubricasEmpregado.DeleteAll;

            TabDistCentroCusto.SetRange(TabDistCentroCusto."No. Empregado", "No.");
            TabDistCentroCusto.DeleteAll;

            TabLinhasMovsEmpregado.SetRange(TabLinhasMovsEmpregado."No. Empregado", "No.");
            TabLinhasMovsEmpregado.DeleteAll;

            TabCabMovsEmpregado.SetRange(TabCabMovsEmpregado."No. Empregado", "No.");
            TabCabMovsEmpregado.DeleteAll;

            TabGrauFuncaoEmpr.SetRange(TabGrauFuncaoEmpr."No. Empregado", "No.");
            TabGrauFuncaoEmpr.DeleteAll;
        end;
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            HumanResSetup.Get;
            HumanResSetup.TestField("Employee Nos.");
            NoSeriesMgt.InitSeries(HumanResSetup."Employee Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        DimMgt.UpdateDefaultDim(
          DATABASE::Employee, "No.",
          "Global Dimension 1 Code", "Global Dimension 2 Code");

        //Preenche o campo Seguradora e Nº Apolice com os dados vindos da Conf. RH
        if HumanResSetup.Get then;
        Seguradora := HumanResSetup.Seguradora;
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
        Employee: Record Employee;
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
        NoSeriesMgt: Codeunit NoSeriesManagement;
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
        Text75: Label 'The password must have more then 6 characters.';
        RUTabelas: Record "RU - Tabelas";
        RespCenter: Record "Responsibility Center";
        CompanyInfo: Record "Company Information";


    procedure AssistEdit(OldEmployee: Record Employee): Boolean
    begin
        Employee := Rec;
        HumanResSetup.Get;
        HumanResSetup.TestField("Employee Nos.");
        if NoSeriesMgt.SelectSeries(HumanResSetup."Employee Nos.", OldEmployee."No. Series", Employee."No. Series") then begin
            HumanResSetup.Get;
            HumanResSetup.TestField("Employee Nos.");
            NoSeriesMgt.SetSeries(Employee."No.");
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
        DimMgt.SaveDefaultDim(DATABASE::Employee, "No.", FieldNumber, ShortcutDimCode);
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
        rEmpregado: Record Employee;
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


    procedure Calculo(pEmpregado: Record Employee)
    var
        Text50001: Label 'Não existe em vigor nenhuma Rúbrica do tipo Vencimento Base para o Empregado %1 - %2';
        TabelaIRS: Record "Tabela IRS";
        TabEmpregado: Record Employee;
    begin
        TabEmpregado := pEmpregado;
        if TabEmpregado."IRS % Fixa" = 0 then begin
            TabEmpregado."Valor Vencimento Base" := FuncoesRH.CalcularVencimentoBase(WorkDate, TabEmpregado);
            TabEmpregado.Modify;

            if TabEmpregado."Valor Vencimento Base" <> 0 then begin
                TabEmpregado."IRS %" := FuncoesRH.CalcularTaxaIRS(TabEmpregado."Valor Vencimento Base",
                                                   TabEmpregado, Date2DMY(WorkDate, 3));
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

    procedure GerarContrato(Empregado: Record Employee)
    var
        rTemplates: Record "Importação Templates";
        path: Text[1024];
        rCompanyInformation: Record "Company Information";
        TabQualificacoes: Record "Qualificação Empregado";
        MyFile: File;
        MyOutStream: OutStream;
        NumberOfChars: Integer;
        wdApp2: DotNet WordApplicationClass;
    begin
        //FIXME: Template layout needed to be created diferently
        path := Format('C:\Temp') + 'Contrato' + Empregado."No." + '.Doc';
        rTemplates.Get('RH-CONTRAC');
        rTemplates.ExportAttachment(path);
        wdApp2.Visible(true);
        wdApp2.Documents.Open2002(path);

        //TEXTO
        EscreveWord2('«nome»', Empregado.Name, wdApp2);

        if Empregado."Documento Identificação" = Empregado."Documento Identificação"::BI then
            EscreveWord2('«tipo doc»', 'Bilhete de Identidade', wdApp2)
        else
            EscreveWord2('«tipo doc»', Format(Empregado."Documento Identificação"), wdApp2);

        EscreveWord2('«nº doc. Identificação»', Empregado."No. Doc. Identificação", wdApp2);
        EscreveWord2('«data emissão»', Format(Empregado."Data Doc. Ident."), wdApp2);
        EscreveWord2('«local emissão»', Empregado."Local Emissão Doc. Ident.", wdApp2);
        EscreveWord2('«NIF»', Empregado."No. Contribuinte", wdApp2);
        EscreveWord2('«morada»', Empregado.Address + ' ' + Empregado."Address 2", wdApp2);
        EscreveWord2('«cidade»', Empregado.City, wdApp2);
        EscreveWord2('«cod. postal»', Empregado."Post Code", wdApp2);

        Empregado.CalcFields(Empregado.Profissionalização);
        if Empregado.Profissionalização = true then
            EscreveWord2('«profissionalizado»', 'Profissionalizado', wdApp2)
        else
            EscreveWord2('«profissionalizado»', 'não Profissionalizado', wdApp2);

        TabQualificacoes.Reset;
        TabQualificacoes.SetRange(TabQualificacoes."Employee No.", Empregado."No.");
        TabQualificacoes.SetRange(TabQualificacoes.Type, TabQualificacoes.Type::"Habilitações Académicas");
        if TabQualificacoes.Find('+') then
            EscreveWord2('«Descrição código habilitação»', '', wdApp2);

        EscreveWord2('«data de trabalho»', Format(Today, 0, '<day> de <month text> de <year4>'), wdApp2);
    end;

    procedure EscreveWord2(pText1: Text[1024]; pText2: Text[1024]; wdApp2: DotNet WordApplicationClass)
    var
        wdfindas: Integer;
        wdreplaceon: Integer;
        fals: Boolean;
        tru: Boolean;
    begin
        fals := false;
        tru := true;


        wdfindas := 0;
        wdreplaceon := 2;
        wdApp2.Width := 7;
        wdApp2.Selection.Find.Execute(pText1, fals, fals, fals, fals, fals, tru, wdfindas, fals, pText2, wdreplaceon);
    end;
}