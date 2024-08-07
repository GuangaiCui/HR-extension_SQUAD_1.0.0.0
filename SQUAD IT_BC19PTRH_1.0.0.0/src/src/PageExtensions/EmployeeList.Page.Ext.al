pageextension 53041 "Employee List Ext" extends "Employee List"
{
    //TODO: Check the order of fields
    layout
    {
        addafter("No.")
        {
            field(Name; Rec.Name)
            {
                ApplicationArea = All;

                Style = Strong;
                StyleExpr = TRUE;
            }
        }
        addafter("Search Name")
        {
            field(Address; Rec.Address)
            {
                ApplicationArea = All;

            }
            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = All;

            }
            field(City; Rec.City)
            {
                ApplicationArea = All;

            }
            field(County; Rec.County)
            {
                ApplicationArea = All;

            }
        }
        addafter("E-Mail")
        {
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
            field("Birth Date"; Rec."Birth Date")
            {
                ApplicationArea = All;

            }
            field("Union Code"; Rec."Union Code")
            {
                ApplicationArea = All;

            }
            field("Union Membership No."; Rec."Union Membership No.")
            {
                ApplicationArea = All;

            }
            field("Country Code"; Rec."Country/Region Code")
            {
                ApplicationArea = All;

            }
            field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
            {
                ApplicationArea = All;

            }
            field("Employment Date"; Rec."Employment Date")
            {
                ApplicationArea = All;

            }
            field(Status; Rec.Status)
            {
                ApplicationArea = All;

            }
            field("Inactive Date"; Rec."Inactive Date")
            {
                ApplicationArea = All;

            }
            field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
            {
                ApplicationArea = All;

            }
            field("Termination Date"; Rec."Termination Date")
            {
                ApplicationArea = All;

            }
            field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
            {
                ApplicationArea = All;

            }
            field("Last Date Modified"; Rec."Last Date Modified")
            {
                ApplicationArea = All;

            }
            field(CompanyMobilePhoneNo; Rec.CompanyMobilePhoneNo)
            {
                ApplicationArea = All;

            }
            field("Company Phone No."; Rec."Company Phone No.")
            {
                ApplicationArea = All;

            }
            field("Company E-Mail"; Rec."Company E-Mail")
            {
                ApplicationArea = All;

            }
            field(Title; Rec.Title)
            {
                ApplicationArea = All;

            }
            field("Tipo Empregado"; Rec."Tipo Empregado")
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
            field("Documento Identificação"; Rec."Documento Identificação")
            {
                ApplicationArea = All;

            }
            field("No. Doc. Identificação"; Rec."No. Doc. Identificação")
            {
                ApplicationArea = All;

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
            field(Naturalidade; Rec."Birth Date")
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
            field("No. Contribuinte"; Rec."No. Contribuinte")
            {
                ApplicationArea = All;

            }
            field("Tipo Contribuinte"; Rec."Tipo Contribuinte")
            {
                ApplicationArea = All;

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
            field(Deficiente; Rec.Deficiente)
            {
                ApplicationArea = All;

            }
            field("Estado Civil"; Rec."Estado Civil")
            {
                ApplicationArea = All;

            }
            field("Titular Rendimentos"; Rec."Titular Rendimentos")
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

            }
            field("Descrição Tabela IRS"; Rec."Descrição Tabela IRS")
            {
                ApplicationArea = All;

            }
            field("IRS %"; Rec."IRS %")
            {
                ApplicationArea = All;

            }
            field("IRS % Fixa"; Rec."IRS % Fixa")
            {
                ApplicationArea = All;

            }
            field("Subscritor SS"; Rec."Subscritor SS")
            {
                ApplicationArea = All;

            }
            field("No. Segurança Social"; Rec."No. Segurança Social")
            {
                ApplicationArea = All;

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
            field("Cód. Cat. Profissional"; Rec."Cód. Cat. Profissional")
            {
                ApplicationArea = All;

            }
            field("Descrição Cat Prof"; Rec."Descrição Cat Prof")
            {
                ApplicationArea = All;

            }
            field("Cód. Cat. Prof QP"; Rec."Cód. Cat. Prof QP")
            {
                ApplicationArea = All;

            }
            field("Descrição Cat Prof QP"; Rec."Descrição Cat Prof QP")
            {
                ApplicationArea = All;

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
            field("Situação Profissional"; Rec."Situação Profissional")
            {
                ApplicationArea = All;

            }
            field("Grau Função"; Rec."Grau Função")
            {
                ApplicationArea = All;

            }
            field("Descrição Grau Função"; Rec."Descrição Grau Função")
            {
                ApplicationArea = All;

            }
            field("Cód. Horário"; Rec."Cód. Horário")
            {
                ApplicationArea = All;

            }
            field("Valor Vencimento Base"; Rec."Valor Vencimento Base")
            {
                ApplicationArea = All;

            }
            field("Valor Dia"; Rec."Valor Dia")
            {
                ApplicationArea = All;

            }
            field("Valor Hora"; Rec."Valor Hora")
            {
                ApplicationArea = All;

            }
            field("No. Horas Semanais"; Rec."No. Horas Semanais")
            {
                ApplicationArea = All;

            }
            field("Mês Proc. Sub. Férias"; Rec."Mês Proc. Sub. Férias")
            {
                ApplicationArea = All;

            }
            field("Regime Duração Trabalho"; Rec."Regime Duração Trabalho")
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
            field("IVA %"; Rec."IVA %")
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
            field(Pagamento; Rec.Pagamento)
            {
                ApplicationArea = All;

            }
            field("Conta Pag."; Rec."Conta Pag.")
            {
                ApplicationArea = All;

            }
            field("Naturalidade - Concelho"; Rec."Naturalidade - Concelho")
            {
                ApplicationArea = All;

            }
            field("Profissionalização"; Rec."Profissionalização")
            {
                ApplicationArea = All;

            }
            field("Data Profissionalização"; Rec."Data Profissionalização")
            {
                ApplicationArea = All;

            }
            field("Cód. Rúbrica Enc. Seg. Social"; Rec."Cód. Rúbrica Enc. Seg. Social")
            {
                ApplicationArea = All;

            }
            field("No. antigo do Empregado"; Rec."No. antigo do Empregado")
            {
                ApplicationArea = All;

            }

            field(varEmpActivos; varEmpActivos)
            {
                ApplicationArea = All;

                Caption = 'Total de Empregados Activos';
            }
        }
    }

    actions
    {
        addafter("&Picture")
        {
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
                Image = Absence;
                RunObject = Page "Ausências Empregado";
                RunPageLink = "Employee No." = FIELD("No.");
            }
            action("Hist. Horas Extra")
            {
                ApplicationArea = All;
                Caption = 'Hist. Ausências';
                Image = Absence;
                RunObject = Page "Ausências Empregado";
                RunPageLink = "Employee No." = FIELD("No.");
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

    trigger OnOpenPage()
    begin

        //HG -Contar os empregados Activos
        TabEmpregado.SetRange(TabEmpregado.Status, TabEmpregado.Status::Active);
        varEmpActivos := TabEmpregado.Count;
    end;

    var
        TabEmpregado: Record Employee;
        varEmpActivos: Integer;
        ConfRH: Record "Config. Recursos Humanos";
}

#pragma implicitwith restore

