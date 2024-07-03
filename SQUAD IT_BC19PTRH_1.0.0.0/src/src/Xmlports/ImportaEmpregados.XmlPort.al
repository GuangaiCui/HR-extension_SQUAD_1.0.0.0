xmlport 31003049 "Importa Empregados"
{
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(ArrayOfEmployeeInformation)
        {
            tableelement(Empregado; Empregado)
            {
                AutoSave = true;
                AutoUpdate = true;
                XmlName = 'EmployeeInformation';
                fieldelement(InternalNumber; Empregado."No.")
                {
                    MinOccurs = Zero;
                }
                textelement(IsActive)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Name; Empregado.Name)
                {
                    FieldValidate = yes;
                    MinOccurs = Zero;
                }
                fieldelement(NIF; Empregado."No. Contribuinte")
                {
                    FieldValidate = yes;
                    MinOccurs = Zero;
                }
                fieldelement(Gender; Empregado.Sex)
                {
                    FieldValidate = yes;
                    MinOccurs = Zero;
                }
                textelement(NationalityCountry)
                {
                    MinOccurs = Zero;
                }
                textelement(BirthDate)
                {
                    MinOccurs = Zero;
                }
                fieldelement(CivilState; Empregado."Estado Civil")
                {
                    MinOccurs = Zero;
                }
                textelement(CivilStateDate)
                {
                    MinOccurs = Zero;
                }
                fieldelement(ID_Number; Empregado."No. Doc. Identificação")
                {
                    MinOccurs = Zero;
                }
                textelement(ID_ExpireDate)
                {
                    MinOccurs = Zero;
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
                textelement(PostalCode)
                {
                    MinOccurs = Zero;
                }
                textelement(County)
                {
                    MinOccurs = Zero;
                }
                textelement(Emergency_Name)
                {
                    MinOccurs = Zero;
                }
                textelement(Emergency_Contact)
                {
                    MinOccurs = Zero;
                }
                fieldelement(FiscalSituation; Empregado."Titular Rendimentos")
                {
                    MinOccurs = Zero;
                }
                fieldelement(NumberOfDependents; Empregado."No. Dependentes")
                {
                    MinOccurs = Zero;
                }
                fieldelement(NumberOfDependentsWithDisabilities; Empregado."No. Dependentes Deficientes")
                {
                    MinOccurs = Zero;
                }
                fieldelement(PaymentMode; Empregado."Usa Transf. Bancária")
                {
                    MinOccurs = Zero;
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
                textelement(AdmissionDate)
                {
                    MinOccurs = Zero;
                }
                textelement(ContractualRegime)
                {
                    MinOccurs = Zero;
                }
                textelement(Department)
                {
                    MinOccurs = Zero;
                }
                textelement(CostCentre)
                {
                    MinOccurs = Zero;
                }
                textelement(ProfessionalCategory)
                {
                    MinOccurs = Zero;
                }
                textelement(JobLocal)
                {
                    MinOccurs = Zero;
                }
                textelement(Job)
                {
                    MinOccurs = Zero;
                }

                trigger OnBeforeModifyRecord()
                begin
                    Empregado."Birth Date" := Text2Date(BirthDate);
                    Empregado."Civil State Date" := Text2Date(CivilStateDate);
                    Empregado."Data Validade Doc. Ident." := Text2Date(ID_ExpireDate);
                    Clear(NLinha);
                    rFamiliar.Reset;
                    rFamiliar.SetRange(rFamiliar."Employee No.", Empregado."No.");
                    rFamiliar.SetFilter(rFamiliar."Emergency Contact", '%1', true);
                    if rFamiliar.FindFirst then begin
                        rFamiliar.Name := Emergency_Name;
                        rFamiliar."Phone No." := Emergency_Contact;
                        rFamiliar.Modify;
                    end else begin
                        rFamiliar.Reset;
                        rFamiliar.SetRange(rFamiliar."Employee No.", Empregado."No.");
                        if rFamiliar.FindLast then
                            NLinha := rFamiliar."Line No." + 10000
                        else
                            NLinha := 10000;
                        rFamiliar.Init;
                        rFamiliar."Employee No." := Empregado."No.";
                        rFamiliar."Line No." := NLinha;
                        rFamiliar.Name := Emergency_Name;
                        rFamiliar."Phone No." := Emergency_Contact;
                        rFamiliar."Emergency Contact" := true;
                        rFamiliar.Insert;
                    end;

                    Empregado.Validate(Empregado.Nacionalidade, NationalityCountry);
                    Empregado.Validate(Empregado."Post Code", PostalCode);
                    Empregado.Validate("Cod. Freguesia", County);
                end;
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
        vDate: Date;
        vBirthDate: Date;
        NLinha: Integer;

    local procedure Text2Date(xmlTagDate: Text): Date
    var
        vDay: Integer;
        vMonth: Integer;
        vYear: Integer;
    begin
        Clear(vDay);
        Clear(vMonth);
        Clear(vYear);
        if Evaluate(vDay, CopyStr(xmlTagDate, 9, 2)) then;
        if Evaluate(vMonth, CopyStr(xmlTagDate, 6, 2)) then;
        if Evaluate(vYear, CopyStr(xmlTagDate, 1, 4)) then;
        exit(DMY2Date(vDay, vMonth, vYear));
    end;
}

