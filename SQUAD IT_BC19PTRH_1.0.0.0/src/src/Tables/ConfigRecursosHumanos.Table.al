table 53053 "Config. Recursos Humanos"
{
    //  IT004 - Tagus - 20191121 - novo campo Balance Cash-Flow Code utilizado no pagamento de vencientos

    Caption = 'Human Resources Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Employee Nos."; Code[10])
        {
            Caption = 'Employee Nos.';
            TableRelation = "No. Series";
        }
        field(3; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            TableRelation = "Unid. Medida Recursos Humanos";

            trigger OnValidate()
            var
                ResUnitOfMeasure: Record "Resource Unit of Measure";
                ResLedgEnty: Record "Res. Ledger Entry";
            begin
                if "Base Unit of Measure" <> xRec."Base Unit of Measure" then begin
                    if EmployeeAbsence.Find('-') then
                        Error(Text001, FieldCaption("Base Unit of Measure"), EmployeeAbsence.TableCaption);
                end;

                HumanResUnitOfMeasure.Get("Base Unit of Measure");
                ResUnitOfMeasure.TestField("Qty. per Unit of Measure", 1);
                ResUnitOfMeasure.TestField("Related to Base Unit of Meas.");
            end;
        }
        field(10; "Valor Cálculo Ausências"; Option)
        {
            Caption = 'Valor Cálculo Ausências';
            Enabled = false;
            OptionMembers = "Valor Hora Lectiva","Valor Hora Total";
        }
        field(20; "Nome Livro Diario"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template".Name;
        }
        field(21; "Secção Diario"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Nome Livro Diario"));
        }
        field(25; "Usar Feriados calculo Sub Ali"; Boolean)
        {
            Caption = 'Using Holidays to Calculate Lunch Subsidy';
        }
        field(30; "Nome responsável RH"; Text[60])
        {
            Caption = 'Name of HR Responsable';
            Description = 'Quadros Pessoal';
        }
        field(31; "Telefone responsável RH"; Text[9])
        {
            Caption = 'Phone of HR Responsable';
            Description = 'Quadros Pessoal';
        }
        field(32; "Fax responsável RH"; Text[9])
        {
            Caption = 'Fax of HR Responsable';
            Description = 'Quadros Pessoal';
        }
        field(33; "E-mail responsável RH"; Text[60])
        {
            Caption = 'E-mail of HR Responsable';
            Description = 'Quadros Pessoal';
        }
        field(40; "%IRS"; Decimal)
        {
            Caption = '% IRS';
            Description = 'Empregados Cat. B';
            MaxValue = 100;
            MinValue = 0;
        }
        field(41; "%IVA"; Decimal)
        {
            Caption = '% VAT';
            Description = 'Empregados Cat. B';
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                //IT001 - CPA - sn
                if Confirm(text50009, true) then
                    if xRec."%IVA" <> "%IVA" then
                        ValidaIVA("%IVA");
                //IT001 - CPA - en
            end;
        }
        field(50; "Nº Serviço"; Code[6])
        {
            Caption = 'Nº Serviço';
            Description = 'CGA';
            Numeric = true;
        }
        field(51; "Nome Serviço"; Text[60])
        {
            Caption = 'Nome Serviço';
            Description = 'CGA';
        }
        field(55; "Taxa Contributiva Empregado"; Decimal)
        {
            Caption = 'Taxa Contributiva Empregado';
            Description = 'CGA';
            MaxValue = 100;
            MinValue = 0;
        }
        field(56; "Taxa Contributiva Ent Patronal"; Decimal)
        {
            Caption = 'Taxa Contributiva Ent Patronal';
            Description = 'CGA';
            MaxValue = 100;
            MinValue = 0;
        }
        field(57; "NIPC CGA"; Text[9])
        {
            Caption = 'NIPC CGA';
            Description = 'DMR';
        }
        field(65; Seguradora; Text[60])
        {
            Caption = 'Insurance';

            trigger OnValidate()
            begin
                //JPC
                ValidaApolice(0);
            end;
        }
        field(66; "No. Apólice"; Text[20])
        {
            Caption = 'No. Apólice';

            trigger OnValidate()
            begin
                //JPC
                ValidaApolice(1);
            end;
        }
        field(67; "Cod. Seguradora"; Text[4])
        {
            DataClassification = ToBeClassified;
        }
        field(69; "NIPC ADSE"; Text[9])
        {
            Caption = 'NIPC ADSE';
            Description = 'DMR';
        }
        field(70; "Taxa Contr. Empregado ADSE"; Decimal)
        {
            Caption = 'Taxa Contr. Empregado ADSE';
            Description = 'ADSE';
        }
        field(71; "Contribui. Ent. Patronal ADSE"; Decimal)
        {
            Caption = 'Contribui. Ent. Patronal ADSE';
            Description = 'ADSE';
        }
        field(72; "Nos. Contratos"; Code[10])
        {
            Caption = 'Contracts Nos.';
            Description = 'Funcionalidade Contratos';
            TableRelation = "No. Series".Code;
        }
        field(100; "No. Conta Pag. Enc. SSocialEmp"; Code[20])
        {
            Caption = 'Acc. No. of Employee Social Security';
            Description = 'Pagamentos Encargos';
            TableRelation = "Bank Account";
        }
        field(101; "No. Conta Pag. Enc. SSocialPat"; Code[20])
        {
            Caption = 'Acc. No. of Company Social Security';
            Description = 'Pagamentos Encargos';
            TableRelation = "Bank Account";
        }
        field(102; "No. Conta Pag. Enc. CGA Emp"; Code[20])
        {
            Caption = 'Nº Conta Pag. Enc. CGA Empregado';
            Description = 'Pagamentos Encargos';
            TableRelation = "Bank Account";
        }
        field(103; "No. Conta Pag. Enc. CGA Pat"; Code[20])
        {
            Caption = 'Nº Conta Pag. Enc. CGA Ent. Patronal';
            Description = 'Pagamentos Encargos';
            TableRelation = "Bank Account";
        }
        field(104; "No. Conta Pag. IRS"; Code[20])
        {
            Caption = 'Acc. No. of IRS';
            Description = 'Pagamentos Encargos';
            TableRelation = "Bank Account";
        }
        field(105; "No. Conta Pag. Enc. ADSE"; Code[20])
        {
            Caption = 'No. Conta Pag. Enc. ADSE';
            Description = 'Pagamentos Encargos';
            TableRelation = "Bank Account";
        }
        field(106; "No. Conta Pag. Enc. ADSE Pat"; Code[20])
        {
            Caption = 'Nº Conta Pag. Enc. ADSE Ent. Patronal';
            Description = 'Pagamentos Encargos';
            TableRelation = "Bank Account";
        }
        field(107; "No. Conta Pag. Enc. FCT-FGCT"; Code[20])
        {
            Caption = 'Acc. No. of FCT-FGCT>';
            Description = 'Pagamentos Encargos';
            TableRelation = "Bank Account";
        }
        field(204; "Diário Imposto Selo"; Code[20])
        {
            Caption = 'Journal Template Stamp Duty';
            Description = 'Funcionalidade Contratos';
            Enabled = false;
            TableRelation = "Gen. Journal Template";
        }
        field(205; "Secção Imposto Selo"; Code[20])
        {
            Caption = 'Journal Batch Stamp Duty';
            Description = 'Funcionalidade Contratos';
            Enabled = false;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Diário Imposto Selo"));
        }
        field(206; "Cód. Imposto Selo"; Code[20])
        {
            Caption = 'Satm Duty Cod.';
            Description = 'Funcionalidade Contratos';
            Enabled = false;
            TableRelation = "PTSS Stamp Duty General Table";
        }
        field(207; "Conta Contrapartida Imp. Selo"; Text[30])
        {
            Caption = 'Bal. Account Stamp Duty';
            Description = 'Funcionalidade Contratos';
            Enabled = false;
            TableRelation = "G/L Account";
        }
        field(208; "Regista Imposto Selo"; Boolean)
        {
            Caption = 'Post Stamp Duty';
            Description = 'Funcionalidade Contratos';
            Enabled = false;
        }
        field(209; "Conta Outros Devedores"; Text[30])
        {
            Caption = 'Acc. No. Other Debtors';
            Description = 'Funcionalidade Contratos';
            Enabled = false;
            TableRelation = "G/L Account";
        }
        field(222; "Aniversários"; Boolean)
        {
            Caption = 'Birthdays';
            Description = 'Indica se é para aparecer um aviso com os aniversariantes';
        }
        field(223; "Dias de antecedência Aniversár"; Integer)
        {
            Caption = 'Days in advance of Birthdays';
            Description = 'Indica com qtos dias de antecedencia para o aniverário';
        }
        field(224; "Contratos a terminar"; Boolean)
        {
            Caption = 'Finish Contracts';
            Description = 'Indica se é para aparecer um aviso com os contratos a terminar';
        }
        field(225; "Dias de antecedência Contrato"; Integer)
        {
            Caption = 'Days in Advance of Contracts';
            Description = 'Indica a qtidade de dias de antecedencia de termino de contrato';
        }
        field(300; "Mod10 - Incluir Fornecedores"; Boolean)
        {
            Caption = 'Mod10 - Include Vendors';
            Description = 'Para os Fornecedores aparecerem no Mod. 10';
        }
        field(301; "Mod10-Forn - Conta Valor Sujei"; Code[20])
        {
            Caption = 'Mod10-Vendor - Acc. No. Exposure Value';
            Description = 'Para os Fornecedores aparecerem no Mod. 10 na cat. B e F';
        }
        field(302; "Mod10-Forn - Conta Valor Reten"; Code[20])
        {
            Caption = 'Mod10-Vendor - Acc. No. Retain value';
            Description = 'Para os Fornecedores aparecerem no Mod. 10 na cat. B e F';
        }
        field(310; "Área de Negócio"; Option)
        {
            Caption = 'Área de Negócio';
            Description = 'Serve para definir o perfil da empresa,para desta forma esconder ou mostrar determinados campos e funcionalidades';
            Enabled = false;
            OptionCaption = 'Ensino,Empresarial';
            OptionMembers = Ensino,Empresarial;
        }
        field(311; "Ano Tabela IRS"; Integer)
        {
            Caption = 'Year of IRS Table';
            Description = 'Serve para guardar o ano da ultima tabela de IRS importada';
        }
        field(312; "Data Importação Tabela IRS"; Date)
        {
            Caption = 'Import Date of IRS Table';
            Description = 'Guarda a 1ª data em que a tabela do ano do campo anterior foi importada';
        }
        field(313; "Retroactivos Processados"; Boolean)
        {
            Caption = 'Retroactives Posted';
            Description = 'Indica que para o ano do campo 311 os retroactivos já foram feitos';
        }
        field(314; "Pagamento total Sub. Férias"; Option)
        {
            Caption = 'Total Payment of Vacation Salary';
            Description = 'Significa que quando a empresa pagar o Sub. Férias paga logo até ao fim do ano, não havendo necessidade de acerto.';
            OptionCaption = ' ,Contratos Sem Termo,Contratos a Termo,Para ambos';
            OptionMembers = " ","Contratos Sem Termo","Contratos a Termo","Para ambos";
        }
        field(315; "Mês Acerto Sub. Férias"; Integer)
        {
            Caption = 'Month of Settlement of Vacation Salary';
            Description = 'Permite à empresa definir qual o mês em que pretende fazer o acerto.';
        }
        field(316; "Atribuição dias extra de féria"; Boolean)
        {
            Caption = 'Extra Vacation Days';
            Description = 'Indica se a empresa quer que o empregado tenha direito a mais 3 dias de férias no caso de n haver ausências';
        }
        field(317; "Limite dias falta abate SN/F"; Integer)
        {
            Caption = 'Number of Absence Days to Cut Vacation/Christmas Salary';
            Description = 'Se o empregado faltar mais de X dias, esses dias serão abatidos ao  Sub Natal e Ferias.';
        }
        field(400; "Gr. Contabilístico Negócio"; Code[10])
        {
            Caption = 'Gen. Business Posting Group';
            Description = 'Para criar um Cliente a partir de um Empregado quado regista o imposto selo do contrato de trabalho';
            Enabled = false;
            TableRelation = "Gen. Business Posting Group".Code;
        }
        field(401; "Gr. Contabilístico Cliente"; Code[10])
        {
            Caption = 'Customer Posting Group';
            Description = 'Para criar um Cliente a partir de um Empregado quado regista o imposto selo do contrato de trabalho';
            Enabled = false;
            TableRelation = "Customer Posting Group".Code;
        }
        field(402; "Gr. Registo IVA negócio"; Code[10])
        {
            Caption = 'VAT Business Posting Group';
            Description = 'Para criar um Cliente a partir de um Empregado quado regista o imposto selo do contrato de trabalho';
            Enabled = false;
            TableRelation = "VAT Business Posting Group".Code;
        }
        field(403; "Cód. Termos Pagamento"; Code[10])
        {
            Caption = 'Payment Terms';
            Description = 'Para criar um Cliente a partir de um Empregado quado regista o imposto selo do contrato de trabalho';
            Enabled = false;
            TableRelation = "Payment Terms".Code;
        }
        field(404; "Cód. Forma Pagamento"; Code[10])
        {
            Caption = 'Payment Method';
            Description = 'Para criar um Cliente a partir de um Empregado quado regista o imposto selo do contrato de trabalho';
            Enabled = false;
            TableRelation = "Payment Method".Code;
        }
        field(500; "Nome Diário Duodécimos"; Code[10])
        {
            Caption = 'Journal Template Twelfhs';
            Description = 'Diario que é usado para registar os duodécimos dos RH';
            TableRelation = "Gen. Journal Template".Name;
        }
        field(501; "Nome Secção Duodécimos"; Code[10])
        {
            Caption = 'Journal Batch Twelfhs';
            Description = 'Secção que é usada para registar os duodécimos dos RH';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Nome Diário Duodécimos"));
        }
        field(502; "No. Conta Duo. SF OrgSoc"; Code[20])
        {
            Caption = 'Nº Conta Duo. SF OrgSoc';
            Description = 'Contas a usar nos duodecimos dos RH';
            TableRelation = "G/L Account"."No.";
        }
        field(503; "No. Conta Duo. SN OrgSoc"; Code[20])
        {
            Caption = 'Nº Conta Duo. SN OrgSoc';
            Description = 'Contas a usar nos duodecimos dos RH';
            TableRelation = "G/L Account"."No.";
        }
        field(504; "No. Conta Duo. SF"; Code[20])
        {
            Caption = 'Acc. No. Twelfh Vacation Salary';
            Description = 'Contas a usar nos duodecimos dos RH';
            TableRelation = "G/L Account"."No.";
        }
        field(505; "No. Conta Duo. SN"; Code[20])
        {
            Caption = 'Acc. No. Twelfh Christmas Salary';
            Description = 'Contas a usar nos duodecimos dos RH';
            TableRelation = "G/L Account"."No.";
        }
        field(506; "No. Conta Contrap. Duo. SF"; Code[20])
        {
            Caption = 'Bal. Acc. No. Twelfh Vacation Salary';
            Description = 'Contas a usar nos duodecimos dos RH';
            TableRelation = "G/L Account"."No.";
        }
        field(507; "No. Conta Contrap. Duo. SN"; Code[20])
        {
            Caption = 'Bal. Acc. No. Twelfh Christmas Salary';
            Description = 'Contas a usar nos duodecimos dos RH';
            TableRelation = "G/L Account"."No.";
        }
        field(508; "No. Conta Enc. Duo. SF"; Code[20])
        {
            Caption = 'Acc. No. Twelfh Vacation Salary - Company';
            Description = 'Contas a usar nos duodecimos dos RH';
            TableRelation = "G/L Account"."No.";
        }
        field(509; "No. Conta Enc. Duo. SN"; Code[20])
        {
            Caption = 'Acc. No. Twelfh Christmas Salary - Company';
            Description = 'Contas a usar nos duodecimos dos RH';
            TableRelation = "G/L Account"."No.";
        }
        field(510; "No. Conta Contrap. Enc. Duo.SF"; Code[20])
        {
            Caption = 'Bal. Acc. No. Twelfh Vacation Salary - Company';
            Description = 'Contas a usar nos duodecimos dos RH';
            TableRelation = "G/L Account"."No.";
        }
        field(511; "No. Conta Contrap. Enc. Duo.SN"; Code[20])
        {
            Caption = 'Bal. Acc. No. Twelfh Christmas Salary - Company';
            Description = 'Contas a usar nos duodecimos dos RH';
            TableRelation = "G/L Account"."No.";
        }
        field(512; "No. Meses"; Integer)
        {
            Caption = 'No. Months';
            MaxValue = 12;
            MinValue = 1;
        }
        field(513; "No. Conta Duo. F OrgSoc"; Code[20])
        {
            Caption = 'Nº Conta Duo. Férias OrgSoc';
            DataClassification = ToBeClassified;
            Description = 'Contas a usar nos duodecimos dos RH';
            Enabled = false;
            TableRelation = "G/L Account"."No.";
        }
        field(514; "No. Conta Duo. F"; Code[20])
        {
            Caption = 'Acc. No. Twelfh Vacation Salary';
            DataClassification = ToBeClassified;
            Description = 'Contas a usar nos duodecimos dos RH';
            TableRelation = "G/L Account"."No.";
        }
        field(515; "No. Conta Contrap. Duo. F"; Code[20])
        {
            Caption = 'Bal. Acc. No. Twelfh Vacation Salary';
            DataClassification = ToBeClassified;
            Description = 'Contas a usar nos duodecimos dos RH';
            TableRelation = "G/L Account"."No.";
        }
        field(516; "No. Conta Enc. Duo. F"; Code[20])
        {
            Caption = 'Acc. No. Twelfh Vacation Salary - Company';
            DataClassification = ToBeClassified;
            Description = 'Contas a usar nos duodecimos dos RH';
            TableRelation = "G/L Account"."No.";
        }
        field(517; "No. Conta Contrap. Enc. Duo.F"; Code[20])
        {
            Caption = 'Bal. Acc. No. Twelfh Vacation Salary - Company';
            DataClassification = ToBeClassified;
            Description = 'Contas a usar nos duodecimos dos RH';
            TableRelation = "G/L Account"."No.";
        }
        field(518; "No. Conta Enc. Duo. SF OrgSoc"; Code[20])
        {
            Caption = 'Acc. No. Twelfh Vacation Salary - Company';
            DataClassification = ToBeClassified;
            Description = 'Contas a usar nos duodecimos dos RH';
            TableRelation = "G/L Account"."No.";
        }
        field(519; "No. Conta Enc. Duo. SN OrgSoc"; Code[20])
        {
            Caption = 'Acc. No. Twelfh Christmas Salary - Company';
            DataClassification = ToBeClassified;
            Description = 'Contas a usar nos duodecimos dos RH';
            TableRelation = "G/L Account"."No.";
        }
        field(520; "No. Conta Enc. Duo. F OrgSoc"; Code[20])
        {
            Caption = 'Acc. No. Twelfh Vacation Salary - Company';
            DataClassification = ToBeClassified;
            Description = 'Contas a usar nos duodecimos dos RH';
            TableRelation = "G/L Account"."No.";
        }
        field(600; "Caminho Exportação Rel. Único"; Text[250])
        {
            Caption = 'RU Exportation Path';
            Description = 'RU';

        }
        field(601; Entidade; Text[6])
        {
            Caption = 'Entity';
            Description = 'RU';
        }
        field(900; "Ordenado Mínimo"; Decimal)
        {
            Caption = 'Minimum Salary';
        }
        field(901; "Sobretaxa %"; Decimal)
        {
            Caption = 'Surcharge %';
        }
        field(1000; Consultas; Boolean)
        {
            Caption = 'Medical Appointment';
            Description = 'Indica se é para aparecer um aviso com os Consultas';
        }
        field(1001; "Dias de antecedência Consultas"; Integer)
        {
            Caption = 'Days Before Medical Appointment';
            Description = 'Indica com qtos dias de antecedencia para as Consultas';
        }
        field(1002; "Mês Abate Sub. Alimentação"; Integer)
        {
            Caption = 'Month of Lunch Subsidy Adjustment';
            Description = 'Indica que neste mês não se paga sub Alimentação';

            trigger OnValidate()
            begin
                if "Mês Abate Sub. Alimentação" <> 0 then
                    TestField("Abate Sub. Alim. dias gozo fer", false);
            end;
        }
        field(1003; "Abate Sub. Alim. dias gozo fer"; Boolean)
        {
            Caption = 'Abate Sub. Alim. nos dias gozo Férias';
            DataClassification = ToBeClassified;
            Description = 'Indica que o SA é abatido consoantes as férias gozadas';

            trigger OnValidate()
            begin
                if "Abate Sub. Alim. dias gozo fer" then
                    TestField("Mês Abate Sub. Alimentação", 0);
            end;
        }
        field(50000; "Balance Cash-Flow Code"; Code[10])
        {
            Caption = 'Balance Cash-Flow Code';
            Description = 'TAGUS - Pagamento Vencimentos';
            TableRelation = "PTSS Cash-Flow Plan"."No." WHERE(Type = CONST(Posting));

            trigger OnValidate()
            var
                BankAccPostGrp: Record "Bank Account Posting Group";
                GLAccount: Record "G/L Account";
                BankAcc: Record "Bank Account";
            begin
            end;
        }
        field(50001; "Azure Files Storage Account"; Text[100])
        {
            Caption = 'Azure Files Storage Account';
        }
        field(50002; "Azure Files Share Folder"; Text[100])
        {
            Caption = 'Azure Files Share Folder';
        }
        field(50003; "Azure Files SaS Token"; Text[2048])
        {
            Caption = 'Azure Files SaS Token';
            ExtendedDatatype = Masked;
        }
        field(50004; "Azure Files Client Folder"; Text[100])
        {
            Caption = 'Azure Files Client Folder';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        EmployeeAbsence: Record "Ausência Empregado";
        HumanResUnitOfMeasure: Record "Unid. Medida Recursos Humanos";
        Text001: Label 'You cannot change %1 because there are %2.';
        FuncoesRH: Codeunit "Funções RH";
        text50009: Label 'Deseja actualizar os empregados que tem o IVA diferente de zero?';

        AFSFileClientGbl: Codeunit "AFS File Client";

    //HR_MIG_VC.S
    local procedure Initialize()
    var
        StorageServiceAuthorizationLcl: Codeunit "Storage Service Authorization";
        StorageAccount: Text;
        FileShare: Text;
        SasToken: Text;
    begin
        Rec.TestField("Azure Files Storage Account");
        Rec.TestField("Azure Files Share Folder");
        Rec.TestField("Azure Files SaS Token");
        StorageAccount := Rec."Azure Files Storage Account";
        FileShare := Rec."Azure Files Share Folder";
        SasToken := Rec."Azure Files SaS Token";
        AFSFileClientGbl.Initialize(StorageAccount, FileShare, StorageServiceAuthorizationLcl.UseReadySAS(SasToken));
    end;

    procedure CreateFileFromInStream(FilePathPar: Text; InStreamPar: InStream)
    var
        AFSOperationResponseLcl: Codeunit "AFS Operation Response";
    begin
        Initialize();
        AFSOperationResponseLcl := AFSFileClientGbl.CreateFile(FilePathPar, InStreamPar);
        if not AFSOperationResponseLcl.IsSuccessful() then
            Error(AFSOperationResponseLcl.GetError());
    end;


    procedure DeleteFile(FilePathPar: Text)
    var
        AFSOperationResponseLcl: Codeunit "AFS Operation Response";
        InStreamPar: InStream;
    begin
        Initialize();
        AFSOperationResponseLcl := AFSFileClientGbl.DeleteFile(FilePathPar);
        if not AFSOperationResponseLcl.IsSuccessful() then
            Error(AFSOperationResponseLcl.GetError());
    end;


    procedure CheckIsFileExists(FolderDir: Text; FileName: Text): Boolean;
    var
        AFSDirectoryContent: Record "AFS Directory Content";
        AFSOperationResponse: Codeunit "AFS Operation Response";
        FileNames: List of [Text];
    begin
        Initialize();

        AFSOperationResponse := AFSFileClientGbl.ListDirectory(FolderDir, AFSDirectoryContent);
        if not AFSOperationResponse.IsSuccessful() then begin
            Error('Failed to list directory. Error: %1', AFSOperationResponse.GetError());
        end;
        AFSDirectoryContent.SetRange("Resource Type", AFSDirectoryContent."Resource Type"::File);
        AFSDirectoryContent.SetRange(Name, FileName);
        if AFSDirectoryContent.FindFirst() then
            exit(true)
        else
            exit(false)
    end;


    procedure CreateDirectory(DirectoryPar: Text)
    var
        AFSOperationResponseLcl: Codeunit "AFS Operation Response";
        DirectoriesLcl: List of [Text];
        DirectoryToCreateLcl, DirectoryLcl : Text;
        ErrorOccuredLcl: Boolean;
        LatestErrorLcl: Text;
    begin
        Initialize();
        if CopyStr(DirectoryPar, StrLen(DirectoryPar), 1) = '\' then
            DirectoryPar := CopyStr(DirectoryPar, 1, StrLen(DirectoryPar) - 1);

        DirectoriesLcl := DirectoryPar.Split('\');

        foreach DirectoryLcl in DirectoriesLcl do begin
            DirectoryToCreateLcl += DirectoryLcl + '\';
            AFSOperationResponseLcl := AFSFileClientGbl.CreateDirectory(DirectoryToCreateLcl);
            //only log if last directory creation failed, otherwise when creating nested directories will give error when parent directory exists and we only care about creation of last directory
            ErrorOccuredLcl := false;
            if not AFSOperationResponseLcl.IsSuccessful() then begin
                ErrorOccuredLcl := true;
                LatestErrorLcl := AFSOperationResponseLcl.GetError();
            end;
        end;

        if ErrorOccuredLcl then
            Message(LatestErrorLcl);
    end;
    //HR_MIG_VC.S


    procedure ValidaApolice(Opcao: Option Seguradora,"Nº Apolice")
    var
        rEmpregado: Record Empregado;
        text0001: Label 'Deseja actualizar o empregado %1  %2 que tem o nº de apólice  %3 da seguradora %4.';
        text0002: Label 'Deseja actualizar o empregado %1  %2 que não tem nº de apólice.';
    begin
        //JPC ACTUALIZA OS QUE ja tem nº d apolice preenchido com o antigo numero
        rEmpregado.Reset;
        if Opcao = Opcao::"Nº Apolice" then
            rEmpregado.SetFilter("No. Apólice", xRec."No. Apólice");
        if Opcao = Opcao::Seguradora then
            rEmpregado.SetFilter(Seguradora, '%1', xRec.Seguradora);

        if rEmpregado.Find('-') then begin
            repeat
                rEmpregado."No. Apólice" := "No. Apólice";
                rEmpregado.Seguradora := Seguradora;
                rEmpregado.Modify;
            until rEmpregado.Next = 0;
        end;
        //JPC pergunta se quer actualizar todos os empregados q nao tem nº d apolice preenchido
        rEmpregado.Reset;
        if Opcao = Opcao::"Nº Apolice" then
            rEmpregado.SetFilter("No. Apólice", '%1', '');
        if Opcao = Opcao::Seguradora then
            rEmpregado.SetFilter(Seguradora, '%1', '');

        if rEmpregado.Find('-') then begin

            repeat
                if Confirm(text0002, true, rEmpregado."No.", rEmpregado.Name) then begin
                    rEmpregado."No. Apólice" := "No. Apólice";
                    rEmpregado.Seguradora := Seguradora;
                    rEmpregado.Modify;
                end;
            until rEmpregado.Next = 0;

        end;
        //JPC pergunta se quer actualizar todos os empregados q nao tem nº d apolice preenchido
        rEmpregado.Reset;
        if Opcao = Opcao::"Nº Apolice" then
            rEmpregado.SetFilter("No. Apólice", '<>%1', "No. Apólice");
        if Opcao = Opcao::Seguradora then
            rEmpregado.SetFilter(Seguradora, '<>%1', Seguradora);


        if rEmpregado.Find('-') then begin

            repeat
                if Confirm(Text001, true, rEmpregado."No.", rEmpregado.Name, rEmpregado."No. Apólice", rEmpregado.Seguradora) then begin
                    rEmpregado."No. Apólice" := "No. Apólice";
                    rEmpregado.Seguradora := Seguradora;
                    rEmpregado.Modify;
                end;
            until rEmpregado.Next = 0;

        end;
    end;


    procedure ValidaIVA(varIVA: Decimal)
    var
        rEmpregado: Record Empregado;
    begin
        //IT001 - CPA - sn
        rEmpregado.Reset;
        rEmpregado.SetFilter("IVA %", '<>%1', 0);
        if rEmpregado.Find('-') then begin
            repeat
                rEmpregado."IVA %" := varIVA;
                rEmpregado.Modify;
            until rEmpregado.Next = 0;
        end;
        //IT001 - CPA - en
    end;
}

