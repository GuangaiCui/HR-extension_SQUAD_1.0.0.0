xmlport 53047 "Exporta Empregados"
{
    Direction = Export;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(ArrayOfEmployeeInformation)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            tableelement(Empregado; Empregado)
            {
                MinOccurs = Zero;
                XmlName = 'EmployeeInformation';
                fieldelement(InternalNumber; Empregado."No.")
                {
                    MinOccurs = Zero;
                }
                textelement(IsActive)
                {
                    MinOccurs = Zero;

                    trigger OnBeforePassVariable()
                    begin
                        if Empregado.Status = Empregado.Status::Active then
                            IsActive := 'TRUE'
                        else
                            IsActive := 'FALSE';
                    end;
                }
                fieldelement(Name; Empregado.Name)
                {
                    MinOccurs = Zero;
                }
                fieldelement(NIF; Empregado."No. Contribuinte")
                {
                    MinOccurs = Zero;
                }
                textelement(Gender)
                {
                    MinOccurs = Zero;

                    trigger OnBeforePassVariable()
                    begin
                        vGender := Empregado.Sex;
                        Gender := Format(vGender);
                    end;
                }
                fieldelement(NationalityCountry; Empregado.Nacionalidade)
                {
                    MinOccurs = Zero;
                }
                textelement(BirthDate)
                {
                    MinOccurs = Zero;

                    trigger OnBeforePassVariable()
                    begin
                        BirthDate := Format(Empregado."Birth Date", 0, '<year4>-<Month,2>-<Day,2>');
                    end;
                }
                textelement(CivilState)
                {
                    MinOccurs = Zero;

                    trigger OnBeforePassVariable()
                    begin
                        vCivilState := Empregado."Estado Civil";
                        CivilState := Format(vCivilState);
                    end;
                }
                textelement(CivilStateDate)
                {
                    MinOccurs = Zero;

                    trigger OnBeforePassVariable()
                    begin
                        CivilStateDate := Format(Empregado."Civil State Date", 0, '<year4>-<Month,2>-<Day,2>');
                    end;
                }
                fieldelement(ID_Number; Empregado."No. Doc. Identificação")
                {
                    MinOccurs = Zero;
                }
                textelement(ID_ExpireDate)
                {
                    MinOccurs = Zero;

                    trigger OnBeforePassVariable()
                    begin
                        ID_ExpireDate := Format(Empregado."Data Validade Doc. Ident.", 0, '<year4>-<Month,2>-<Day,2>');
                    end;
                }
                fieldelement(Telephone; Empregado."Phone No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(MobilePhone; Empregado."Mobile Phone No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Email; Empregado."E-Mail")
                {
                    MinOccurs = Zero;
                }
                textelement(AddressType)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Adress; Empregado.Address)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Locality; Empregado.Locality)
                {
                    MinOccurs = Zero;
                }
                fieldelement(PostalCode; Empregado."Post Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(County; Empregado."Cod. Freguesia")
                {
                    MinOccurs = Zero;
                }
                textelement(Emergency_Name)
                {
                    MinOccurs = Zero;

                    trigger OnBeforePassVariable()
                    begin
                        rFamiliar.Reset;
                        rFamiliar.SetRange(rFamiliar."Employee No.", Empregado."No.");
                        rFamiliar.SetFilter(rFamiliar."Emergency Contact", '%1', true);
                        if rFamiliar.FindFirst then
                            Emergency_Name := rFamiliar.Name
                        else
                            Emergency_Name := '';
                    end;
                }
                textelement(Emergency_Contact)
                {
                    MinOccurs = Zero;

                    trigger OnBeforePassVariable()
                    begin
                        rFamiliar.Reset;
                        rFamiliar.SetRange(rFamiliar."Employee No.", Empregado."No.");
                        rFamiliar.SetFilter(rFamiliar."Emergency Contact", '%1', true);
                        if rFamiliar.FindFirst then
                            Emergency_Contact := rFamiliar."Phone No."
                        else
                            Emergency_Contact := '';
                    end;
                }
                textelement(FiscalSituation)
                {
                    MinOccurs = Zero;

                    trigger OnBeforePassVariable()
                    begin
                        vFiscalSituation := Empregado."Titular Rendimentos";
                        FiscalSituation := Format(vFiscalSituation);
                    end;
                }
                fieldelement(NumberOfDependents; Empregado."No. Dependentes")
                {
                    MinOccurs = Zero;
                }
                fieldelement(NumberOfDependentsWithDisabilities; Empregado."No. Dependentes Deficientes")
                {
                    MinOccurs = Zero;
                }
                textelement(PaymentMode)
                {
                    MinOccurs = Zero;

                    trigger OnBeforePassVariable()
                    begin
                        if Empregado."Usa Transf. Bancária" then
                            PaymentMode := '1'
                        else
                            PaymentMode := '0';
                    end;
                }
                textelement(Bank)
                {
                    MinOccurs = Zero;
                }
                fieldelement(IBAN; Empregado.IBAN)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Internal_Telephone; Empregado."Company Phone No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Internal_Mobilephone; Empregado.CompanyMobilePhoneNo)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Internal_Email; Empregado."Company E-Mail")
                {
                    MinOccurs = Zero;
                }
                textelement(Company)
                {
                    MinOccurs = Zero;
                }
                fieldelement(AdmissionDate; Empregado."Employment Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(ContractualRegime; Empregado."Emplymt. Contract Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Department; Empregado."Statistics Group Code")
                {
                    MinOccurs = Zero;
                }
                textelement(CostCentre)
                {
                    MinOccurs = Zero;
                }
                fieldelement(ProfessionalCategory; Empregado."Cód. Cat. Prof QP")
                {
                    MinOccurs = Zero;
                }
                fieldelement(JobLocal; Empregado.Estabelecimento)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Job; Empregado."Cód. Cat. Profissional")
                {
                    MinOccurs = Zero;
                }
            }
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

    var
        rFamiliar: Record "Familiar Empregado";
        vGender: Integer;
        vCivilState: Integer;
        vFiscalSituation: Integer;
}

