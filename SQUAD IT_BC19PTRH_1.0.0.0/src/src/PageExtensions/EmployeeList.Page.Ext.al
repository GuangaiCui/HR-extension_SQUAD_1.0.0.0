pageextension 53041 "Employee List Ext" extends "Employee List"
{
    //Adjusted the order of fields and actions
    //TODO: Check again with consultants and clients - if set some fields invisible
    layout
    {
        addafter("No.")
        {
            field(Name; Rec.Name)
            {
                ApplicationArea = BasicHR;

                Style = Strong;
                StyleExpr = TRUE;
            }
        }
        addafter("Job Title")
        {
            field(Address; Rec.Address)
            {
                ApplicationArea = BasicHR;

            }
            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = BasicHR;

            }
            field(City; Rec.City)
            {
                ApplicationArea = BasicHR;

            }
            field(County; Rec.County)
            {
                ApplicationArea = BasicHR;

            }
        }
        addafter("Comment")
        {
            field("Alt. Address Code"; Rec."Alt. Address Code")
            {
                ApplicationArea = Basic, Suite;

            }
            field("Alt. Address Start Date"; Rec."Alt. Address Start Date")
            {
                ApplicationArea = Basic, Suite;

            }
            field("Alt. Address End Date"; Rec."Alt. Address End Date")
            {
                ApplicationArea = Basic, Suite;

            }
            field("Birth Date"; Rec."Birth Date")
            {
                ApplicationArea = BasicHR;

            }
            field("Union Code"; Rec."Union Code")
            {
                ApplicationArea = Basic, Suite;

            }
            field("Union Membership No."; Rec."Union Membership No.")
            {
                ApplicationArea = Basic, Suite;

            }
            field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
            {
                ApplicationArea = Basic, Suite;

            }
            field("Employment Date"; Rec."Employment Date")
            {
                ApplicationArea = BasicHR;

            }
            field(Status; Rec.Status)
            {
                ApplicationArea = BasicHR;

            }
            field("Inactive Date"; Rec."Inactive Date")
            {
                ApplicationArea = Basic, Suite;

            }
            field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
            {
                ApplicationArea = Basic, Suite;

            }
            field("Termination Date"; Rec."Termination Date")
            {
                ApplicationArea = BasicHR;

            }
            field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
            {
                ApplicationArea = Basic, Suite;

            }
            field("Last Date Modified"; Rec."Last Date Modified")
            {
                ApplicationArea = BasicHR;

            }
        }
        addbefore(Extension)
        {
            field(CompanyMobilePhoneNo; Rec.CompanyMobilePhoneNo)
            {
                ApplicationArea = BasicHR;

            }
            field("Company E-Mail"; Rec."Company E-Mail")
            {
                ApplicationArea = BasicHR;

            }
        }
        addafter("E-Mail")
        {
            field(Title; Rec.Title)
            {
                ApplicationArea = BasicHR;

            }
            field("Tipo Empregado"; Rec."Tipo Empregado")
            {
                ApplicationArea = BasicHR;

            }
            field(Estabelecimento; Rec.Estabelecimento)
            {
                ApplicationArea = BasicHR;

            }
            field(Seguradora; Rec.Seguradora)
            {
                ApplicationArea = BasicHR;

            }
            field("No. Apólice"; Rec."No. Apólice")
            {
                ApplicationArea = BasicHR;

            }
            field("Documento Identificação"; Rec."Documento Identificação")
            {
                ApplicationArea = BasicHR;

            }
            field("No. Doc. Identificação"; Rec."No. Doc. Identificação")
            {
                ApplicationArea = BasicHR;

            }
            field("Local Emissão Doc. Ident."; Rec."Local Emissão Doc. Ident.")
            {
                ApplicationArea = BasicHR;

            }
            field("Data Doc. Ident."; Rec."Data Doc. Ident.")
            {
                ApplicationArea = BasicHR;

            }
            field("Data Validade Doc. Ident."; Rec."Data Validade Doc. Ident.")
            {
                ApplicationArea = BasicHR;

            }
            field(Naturalidade; Rec."Birth Date")
            {
                ApplicationArea = BasicHR;

            }
            field(Nacionalidade; Rec.Nacionalidade)
            {
                ApplicationArea = BasicHR;

            }
            field("Nacionalidade Descrição"; Rec."Nacionalidade Descrição")
            {
                ApplicationArea = BasicHR;

            }
            field("No. Contribuinte"; Rec."No. Contribuinte")
            {
                ApplicationArea = BasicHR;

            }
            field("Tipo Contribuinte"; Rec."Tipo Contribuinte")
            {
                ApplicationArea = BasicHR;

            }
            field("Cod. Repartição Finanças"; Rec."Cod. Repartição Finanças")
            {
                ApplicationArea = BasicHR;

            }
            field("Repartição Finanças"; Rec."Repartição Finanças")
            {
                ApplicationArea = BasicHR;

            }
            field("Data Emissão NIF"; Rec."Data Emissão NIF")
            {
                ApplicationArea = BasicHR;

            }
            field("Tipo Rendimento"; Rec."Tipo Rendimento")
            {
                ApplicationArea = BasicHR;

            }
            field("Local Obtenção Rendimento"; Rec."Local Obtenção Rendimento")
            {
                ApplicationArea = BasicHR;

            }
            field(Deficiente; Rec.Deficiente)
            {
                ApplicationArea = BasicHR;

            }
            field("Estado Civil"; Rec."Estado Civil")
            {
                ApplicationArea = BasicHR;

            }
            field("Titular Rendimentos"; Rec."Titular Rendimentos")
            {
                ApplicationArea = BasicHR;

            }
            field("Conjuge Deficiente"; Rec."Conjuge Deficiente")
            {
                ApplicationArea = BasicHR;

            }
            field("No. Dependentes"; Rec."No. Dependentes")
            {
                ApplicationArea = BasicHR;

            }
            field("No. Dependentes Deficientes"; Rec."No. Dependentes Deficientes")
            {
                ApplicationArea = BasicHR;

            }
            field("Tabela IRS"; Rec."Tabela IRS")
            {
                ApplicationArea = BasicHR;

            }
            field("Descrição Tabela IRS"; Rec."Descrição Tabela IRS")
            {
                ApplicationArea = BasicHR;

            }
            field("IRS %"; Rec."IRS %")
            {
                ApplicationArea = BasicHR;

            }
            field("IRS % Fixa"; Rec."IRS % Fixa")
            {
                ApplicationArea = BasicHR;

            }
            field("Subscritor SS"; Rec."Subscritor SS")
            {
                ApplicationArea = BasicHR;

            }
            field("No. Segurança Social"; Rec."No. Segurança Social")
            {
                ApplicationArea = BasicHR;

            }
            field("Data da Admissão SS"; Rec."Data da Admissão SS")
            {
                ApplicationArea = BasicHR;

            }
            field("Data Emissão SS"; Rec."Data Emissão SS")
            {
                ApplicationArea = BasicHR;

            }
            field("Cod. Instituição SS"; Rec."Cod. Instituição SS")
            {
                ApplicationArea = BasicHR;

            }
            field("Cod. Regime SS"; Rec."Cod. Regime SS")
            {
                ApplicationArea = BasicHR;

            }
            field("Data de Antiguidade"; Rec."Data de Antiguidade")
            {
                ApplicationArea = BasicHR;

            }
            field("End Date"; Rec."End Date")
            {
                ApplicationArea = BasicHR;

            }
            field("Motivo de Terminação"; Rec."Motivo de Terminação")
            {
                ApplicationArea = BasicHR;

            }
            field("Cód. IRCT"; Rec."Cód. IRCT")
            {
                ApplicationArea = BasicHR;

            }
            field("Acordo Colectivo"; Rec."Acordo Colectivo")
            {
                ApplicationArea = BasicHR;

            }
            field("Descrição IRCT"; Rec."Descrição IRCT")
            {
                ApplicationArea = BasicHR;

            }
            field("Cód. Cat. Profissional"; Rec."Cód. Cat. Profissional")
            {
                ApplicationArea = BasicHR;

            }
            field("Descrição Cat Prof"; Rec."Descrição Cat Prof")
            {
                ApplicationArea = BasicHR;

            }
            field("Cód. Cat. Prof QP"; Rec."Cód. Cat. Prof QP")
            {
                ApplicationArea = BasicHR;

            }
            field("Descrição Cat Prof QP"; Rec."Descrição Cat Prof QP")
            {
                ApplicationArea = BasicHR;

            }
            field("Class. Nac. Profi."; Rec."Class. Nac. Profi.")
            {
                ApplicationArea = BasicHR;

            }
            field("Descrição Class. Nac."; Rec."Descrição Class. Nac.")
            {
                ApplicationArea = BasicHR;

            }
            field("Cód. Habilitações"; Rec."Cód. Habilitações")
            {
                ApplicationArea = BasicHR;

            }
            field("Descrição Habilitações"; Rec."Descrição Habilitações")
            {
                ApplicationArea = BasicHR;

            }
            field("Situação Profissional"; Rec."Situação Profissional")
            {
                ApplicationArea = BasicHR;

            }
            field("Grau Função"; Rec."Grau Função")
            {
                ApplicationArea = BasicHR;

            }
            field("Descrição Grau Função"; Rec."Descrição Grau Função")
            {
                ApplicationArea = BasicHR;

            }
            field("Cód. Horário"; Rec."Cód. Horário")
            {
                ApplicationArea = BasicHR;

            }
            field("Valor Vencimento Base"; Rec."Valor Vencimento Base")
            {
                ApplicationArea = BasicHR;

            }
            field("Valor Dia"; Rec."Valor Dia")
            {
                ApplicationArea = BasicHR;

            }
            field("Valor Hora"; Rec."Valor Hora")
            {
                ApplicationArea = BasicHR;

            }
            field("No. Horas Semanais"; Rec."No. Horas Semanais")
            {
                ApplicationArea = BasicHR;

            }
            field("Mês Proc. Sub. Férias"; Rec."Mês Proc. Sub. Férias")
            {
                ApplicationArea = BasicHR;

            }
            field("Regime Duração Trabalho"; Rec."Regime Duração Trabalho")
            {
                ApplicationArea = BasicHR;

            }
            field(IBAN; Rec.IBAN)
            {
                ApplicationArea = BasicHR;

            }
            field("SWIFT Code"; Rec."SWIFT Code")
            {
                ApplicationArea = BasicHR;

            }
            field("Usa Transf. Bancária"; Rec."Usa Transf. Bancária")
            {
                ApplicationArea = BasicHR;

            }
            field("Cód. Banco Transf."; Rec."Cód. Banco Transf.")
            {
                ApplicationArea = BasicHR;

            }
            field("IVA %"; Rec."IVA %")
            {
                ApplicationArea = BasicHR;

            }
            field("Nome Livro Diario Pag."; Rec."Nome Livro Diario Pag.")
            {
                ApplicationArea = BasicHR;

            }
            field("Secção Diario Pag."; Rec."Secção Diario Pag.")
            {
                ApplicationArea = BasicHR;

            }
            field(Pagamento; Rec.Pagamento)
            {
                ApplicationArea = BasicHR;

            }
            field("Conta Pag."; Rec."Conta Pag.")
            {
                ApplicationArea = BasicHR;

            }
            field("Naturalidade - Concelho"; Rec."Naturalidade - Concelho")
            {
                ApplicationArea = BasicHR;

            }
            field("Profissionalização"; Rec."Profissionalização")
            {
                ApplicationArea = BasicHR;

            }
            field("Data Profissionalização"; Rec."Data Profissionalização")
            {
                ApplicationArea = BasicHR;

            }
            field("Cód. Rúbrica Enc. Seg. Social"; Rec."Cód. Rúbrica Enc. Seg. Social")
            {
                ApplicationArea = BasicHR;

            }
            field("No. antigo do Empregado"; Rec."No. antigo do Empregado")
            {
                ApplicationArea = BasicHR;

            }

            field(varEmpActivos; varEmpActivos)
            {
                ApplicationArea = Basic, Suite;

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
                ApplicationArea = Basic, Suite;

                Caption = 'Rubricas Salariais';
                Image = SalesTaxStatement;
                RunObject = Page "Lista Rubrica Salarial Emp.";
                RunPageLink = "No. Empregado" = FIELD("No.");
            }
            action("Hist. Ausências")
            {
                ApplicationArea = Basic, Suite;

                Caption = 'Hist. Ausências';
                Image = Absence;
                RunObject = Page "Ausências Empregado";
                RunPageLink = "Employee No." = FIELD("No.");
            }
            action("Hist. Horas Extra")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Hist. Ausências';
                Image = Absence;
                RunObject = Page "Ausências Empregado";
                RunPageLink = "Employee No." = FIELD("No.");
            }
            action("Hist. Abonos e Descontos extra")
            {
                ApplicationArea = Basic, Suite;

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

