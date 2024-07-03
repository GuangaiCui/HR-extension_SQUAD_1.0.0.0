page 31003036 "Lista Empregado"
{
    CaptionML = ENU = 'Employee List', PTG = 'Lista Empregado';

    CardPageID = "Ficha Empregado";
    Editable = false;
    PageType = List;
    SourceTable = Empregado;
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                FreezeColumn = Name;
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;

                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field(Initials; Initials)
                {
                    ApplicationArea = All;

                    Visible = false;
                }
                field("Job Title"; "Job Title")
                {
                    ApplicationArea = All;

                }
                field("Search Name"; "Search Name")
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
                field(City; City)
                {
                    ApplicationArea = All;

                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = All;

                }
                field(County; County)
                {
                    ApplicationArea = All;

                }
                field("Phone No."; "Phone No.")
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
                field("Birth Date"; "Birth Date")
                {
                    ApplicationArea = All;

                }
                field("Union Code"; "Union Code")
                {
                    ApplicationArea = All;

                }
                field("Union Membership No."; "Union Membership No.")
                {
                    ApplicationArea = All;

                }
                field(Sex; Sex)
                {
                    ApplicationArea = All;

                }
                field("Country Code"; "Country Code")
                {
                    ApplicationArea = All;

                }
                field("Emplymt. Contract Code"; "Emplymt. Contract Code")
                {
                    ApplicationArea = All;

                }
                field("Statistics Group Code"; "Statistics Group Code")
                {
                    ApplicationArea = All;

                }
                field("Employment Date"; "Employment Date")
                {
                    ApplicationArea = All;

                }
                field(Status; Status)
                {
                    ApplicationArea = All;

                }
                field("Inactive Date"; "Inactive Date")
                {
                    ApplicationArea = All;

                }
                field("Cause of Inactivity Code"; "Cause of Inactivity Code")
                {
                    ApplicationArea = All;

                }
                field("Termination Date"; "Termination Date")
                {
                    ApplicationArea = All;

                }
                field("Grounds for Term. Code"; "Grounds for Term. Code")
                {
                    ApplicationArea = All;

                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    ApplicationArea = All;

                }
                field(Extension; Extension)
                {
                    ApplicationArea = All;

                }
                field(CompanyMobilePhoneNo; CompanyMobilePhoneNo)
                {
                    ApplicationArea = All;

                }
                field("Company Phone No."; "Company Phone No.")
                {
                    ApplicationArea = All;

                }
                field("Company E-Mail"; "Company E-Mail")
                {
                    ApplicationArea = All;

                }
                field(Title; Title)
                {
                    ApplicationArea = All;

                }
                field("Tipo Empregado"; "Tipo Empregado")
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
                field("Documento Identificação"; "Documento Identificação")
                {
                    ApplicationArea = All;

                }
                field("No. Doc. Identificação"; "No. Doc. Identificação")
                {
                    ApplicationArea = All;

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
                field(Naturalidade; Naturalidade)
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
                field("No. Contribuinte"; "No. Contribuinte")
                {
                    ApplicationArea = All;

                }
                field("Tipo Contribuinte"; "Tipo Contribuinte")
                {
                    ApplicationArea = All;

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
                field(Deficiente; Deficiente)
                {
                    ApplicationArea = All;

                }
                field("Estado Civil"; "Estado Civil")
                {
                    ApplicationArea = All;

                }
                field("Titular Rendimentos"; "Titular Rendimentos")
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

                }
                field("Descrição Tabela IRS"; "Descrição Tabela IRS")
                {
                    ApplicationArea = All;

                }
                field("IRS %"; "IRS %")
                {
                    ApplicationArea = All;

                }
                field("IRS % Fixa"; "IRS % Fixa")
                {
                    ApplicationArea = All;

                }
                field("Subscritor SS"; "Subscritor SS")
                {
                    ApplicationArea = All;

                }
                field("No. Segurança Social"; "No. Segurança Social")
                {
                    ApplicationArea = All;

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
                field("Cód. Cat. Profissional"; "Cód. Cat. Profissional")
                {
                    ApplicationArea = All;

                }
                field("Descrição Cat Prof"; "Descrição Cat Prof")
                {
                    ApplicationArea = All;

                }
                field("Cód. Cat. Prof QP"; "Cód. Cat. Prof QP")
                {
                    ApplicationArea = All;

                }
                field("Descrição Cat Prof QP"; "Descrição Cat Prof QP")
                {
                    ApplicationArea = All;

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
                field("Situação Profissional"; "Situação Profissional")
                {
                    ApplicationArea = All;

                }
                field("Grau Função"; "Grau Função")
                {
                    ApplicationArea = All;

                }
                field("Descrição Grau Função"; "Descrição Grau Função")
                {
                    ApplicationArea = All;

                }
                field("Cód. Horário"; "Cód. Horário")
                {
                    ApplicationArea = All;

                }
                field("Valor Vencimento Base"; "Valor Vencimento Base")
                {
                    ApplicationArea = All;

                }
                field("Valor Dia"; "Valor Dia")
                {
                    ApplicationArea = All;

                }
                field("Valor Hora"; "Valor Hora")
                {
                    ApplicationArea = All;

                }
                field("No. Horas Semanais"; "No. Horas Semanais")
                {
                    ApplicationArea = All;

                }
                field("Mês Proc. Sub. Férias"; "Mês Proc. Sub. Férias")
                {
                    ApplicationArea = All;

                }
                field("Regime Duração Trabalho"; "Regime Duração Trabalho")
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
                field("IVA %"; "IVA %")
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
                field(Pagamento; Pagamento)
                {
                    ApplicationArea = All;

                }
                field("Conta Pag."; "Conta Pag.")
                {
                    ApplicationArea = All;

                }
                field("Naturalidade - Concelho"; "Naturalidade - Concelho")
                {
                    ApplicationArea = All;

                }
                field("Profissionalização"; Profissionalização)
                {
                    ApplicationArea = All;

                }
                field("Data Profissionalização"; "Data Profissionalização")
                {
                    ApplicationArea = All;

                }
                field("Cód. Rúbrica Enc. Seg. Social"; "Cód. Rúbrica Enc. Seg. Social")
                {
                    ApplicationArea = All;

                }
                field("No. antigo do Empregado"; "No. antigo do Empregado")
                {
                    ApplicationArea = All;

                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;

                }
            }
            field(varEmpActivos; varEmpActivos)
            {
                ApplicationArea = All;

                Caption = 'Total de Empregados Activos';
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
        }
    }

    actions
    {
        area(navigation)
        {

            group("E&mployee")
            {

                Caption = 'E&mpregado';
                Image = Employee;
                action("Comentários")
                {
                    ApplicationArea = All;

                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Folha Comentários RH";
                    RunPageLink = "Table Name" = CONST(Emp),
                                  "No." = FIELD("No.");
                }
                group("Dimensões")
                {

                    Caption = 'Dimensions';
                    Image = Dimensions;
                    action("Dimensões-Single")
                    {
                        ApplicationArea = All;

                        Caption = 'Dimensions-Single';
                        Image = Dimensions;
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST(31003035),
                                      "No." = FIELD("No.");
                        ShortCutKey = 'Shift+Ctrl+D';
                    }
                }
                action(Imagem)
                {
                    ApplicationArea = All;

                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = Page "Imagem Empregado";
                    RunPageLink = "No." = FIELD("No.");
                }
                action("Rubricas Salariais")
                {
                    ApplicationArea = All;

                    Caption = 'Rubricas Salariais';
                    Image = SalesTaxStatement;
                    RunObject = Page "Lista Rubrica Salarial Emp.";
                    RunPageLink = "No. Empregado" = FIELD("No.");
                }
                action("Hist. Ausências")
                {
                    ApplicationArea = All;

                    Caption = 'Hist. Ausências';
                    Image = absence;
                    RunObject = Page "Ausências Empregado";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Hist. Horas Extra")
                {
                    ApplicationArea = All;

                    Caption = 'Hist. Horas Extra';
                    Image = ServiceHours;
                    RunObject = Page "Registo Horas Extra";
                    RunPageLink = "No. Empregado" = FIELD("No.");
                }
                action("Hist. Abonos e Descontos extra")
                {
                    ApplicationArea = All;

                    Caption = 'Hist. Abonos e Descontos extra';
                    Image = ChangePaymentTolerance;
                    RunObject = Page "Lista Hist. Abon. - Des. Extr.";
                    RunPageLink = "No. Empregado" = FIELD("No.");
                }
            }
        }
    }

    trigger OnOpenPage()
    begin

        //HG -Contar os empregados Activos
        TabEmpregado.SetRange(TabEmpregado.Status, TabEmpregado.Status::Active);
        varEmpActivos := TabEmpregado.Count;
    end;

    var
        TabEmpregado: Record Empregado;
        varEmpActivos: Integer;
        ConfRH: Record "Config. Recursos Humanos";
}

