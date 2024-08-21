report 53095 "Declarações RH BC"
{
    //ProcessingOnly = true;
    //UsageCategory = Tasks;
    ApplicationArea = HumanResourcesAppArea;
    UsageCategory = ReportsAndAnalysis;

    //DefaultLayout = Word;
    DefaultLayout = RDLC;
    //WordLayout = 'Layouts\DeclaraçõesRHBC19.docx';
    RDLCLayout = 'Layouts\DeclaraçõesRHBC19.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(Empregado; Employee)
        {
            RequestFilterFields = "No.";

            column(nomeempresa1; rCompanyInformation.Name)
            {

            }

            column(nomeempresa2; rCompanyInformation."Name 2")
            {

            }
            column(endereço1; rCompanyInformation.Address)
            {

            }
            column(endereço2; rCompanyInformation."Address 2")
            {

            }
            column(codpostal; rCompanyInformation."Post Code")
            {

            }
            column(cidade; rCompanyInformation.City)
            {

            }
            column(telefone; rCompanyInformation."Phone No.")
            {

            }
            column(fax; rCompanyInformation."Fax No.")
            {

            }
            column(NIF; rCompanyInformation."VAT Registration No.")
            {

            }

            column(nome; Empregado.Name)
            {

            }
            column(tipodoc; Format(Empregado."Documento Identificação"))
            {

            }
            column(nDocIdentificação; Empregado."No. Doc. Identificação")
            {

            }
            column(localEmissão; Empregado."Local Emissão Doc. Ident.")
            {

            }
            column(dataValidade; ExpirationDate)
            {

            }
            column(dataAdmissão; Format(Empregado."Employment Date"))
            {

            }
            column(tipoContrato; ContractType)
            {

            }

            column(vencimentoBase; Format(VencimentoBase))
            {

            }
            column(localidade; rCompanyInformation.City)
            {

            }
            column(data; Format(Today, 0, '<day> de <month text> de <year4>'))
            {

            }
            column(nomePessoaAssina; NomePessoaAssina)
            {

            }
            column(cargo; cargo)
            {
            }
            trigger OnAfterGetRecord()
            begin
                Clear(VencimentoBase);

                if Empregado.Vitalício then
                    ExpirationDate := 'vitalício'
                else
                    ExpirationDate := Format(Empregado."Data Validade Doc. Ident.");


                //Empregado.CalcFields(Empregado."Emplymt. Contract Code");

                Contratos.Reset;
                if Contratos.Get(Empregado."Emplymt. Contract Code") then
                    ContractType := Format(Contratos."Tipo Contrato");
                TabRubricaSalEmpregado.Reset;
                TabRubricaSalEmpregado.SetRange(TabRubricaSalEmpregado."No. Empregado", Empregado."No.");
                TabRubricaSalEmpregado.SetFilter(TabRubricaSalEmpregado."Data Início", '<=%1', Today);
                TabRubricaSalEmpregado.SetFilter(TabRubricaSalEmpregado."Data Fim", '>%1|=%2', Today, 0D);
                if TabRubricaSalEmpregado.FindSet then begin
                    repeat
                        if (TabRubrica.Get(TabRubricaSalEmpregado."Cód. Rúbrica Salarial")) and
                          (TabRubrica.Genero = TabRubrica.Genero::"Vencimento Base") then begin
                            VencimentoBase := VencimentoBase + TabRubricaSalEmpregado."Valor Total";
                        end;
                    until TabRubricaSalEmpregado.Next = 0;
                end;

            end;

            trigger OnPreDataItem()
            begin
                if rCompanyInformation.Get then;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(NomePessoaAssina; NomePessoaAssina)
                {

                    Caption = 'Nome da Pessoa que assina';
                }
                field(cargo; cargo)
                {

                    Caption = 'Cargo';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
    end;

    var
        rCompanyInformation: Record "Company Information";
        Contratos: Record "Contrato Trabalho";
        TabRubricaSalEmpregado: Record "Rubrica Salarial Empregado";
        NomePessoaAssina: Text[75];
        cargo: Text[50];
        TabRubrica: Record "Rubrica Salarial";
        VencimentoBase: Decimal;
        ContractType: Text;
        ExpirationDate: Text;
}

