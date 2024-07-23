xmlport 53048 "Tabelas Auxiliares"
{
    Direction = Export;
    UseDefaultNamespace = true;

    schema
    {
        textelement(AuxiliaryTable)
        {
            tableelement("Temporary Table"; "PTSS Temporary Table")
            {
                XmlName = 'Object';
                UseTemporary = true;
                fieldelement("Key"; "Temporary Table".Code1)
                {
                }
                fieldelement(Name; "Temporary Table".Text1)
                {
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
        rContTrabalho: Record "Contrato Trabalho";
        rCoutry: Record "Country/Region";
        rCurrency: Record Currency;
        rDepartmentsEmp: Record "Departamentos Empregado";
        rCatProf: Record "Categoria Profissional Interna";
        rEstabelecimento: Record "Estabelecimentos da Empresa";
        rCatProfQP: Record "Categoria Profissional QP";


    procedure Filtra(pTabela: Text)
    begin

        "Temporary Table".DeleteAll;
        //AdressTypes - não temos
        //Banks - não temos

        //CivilStates
        if pTabela = 'CivilState' then Option2Table(77);

        //Companies - não temos

        //ContratualRegimes
        if pTabela = 'ContratualRegimes' then begin
            rContTrabalho.Reset;
            if rContTrabalho.FindSet then begin
                repeat
                    "Temporary Table"."Entry No." += 1;
                    "Temporary Table".Code1 := rContTrabalho.Code;
                    "Temporary Table".Text1 := rContTrabalho.Description;
                    "Temporary Table".Insert;
                until rContTrabalho.Next = 0;
            end;
        end;

        //CostCenter - não passar pq temos vários

        //Countries
        if pTabela = 'Countries' then begin
            rCoutry.Reset;
            if rCoutry.FindSet then begin
                repeat
                    "Temporary Table"."Entry No." += 1;
                    "Temporary Table".Code1 := rCoutry.Code;
                    "Temporary Table".Text1 := rCoutry.Name;
                    "Temporary Table".Insert;
                until rCoutry.Next = 0;
            end;
        end;

        //Currencies
        if pTabela = 'Currencies' then begin
            rCurrency.Reset;
            if rCurrency.FindSet then begin
                repeat
                    "Temporary Table"."Entry No." += 1;
                    "Temporary Table".Code1 := rCurrency.Code;
                    "Temporary Table".Text1 := rCurrency.Description;
                    "Temporary Table".Insert;
                until rCurrency.Next = 0;
            end;
        end;

        //Departments
        if pTabela = 'Departments' then begin
            rDepartmentsEmp.Reset;
            if rDepartmentsEmp.FindSet then begin
                repeat
                    "Temporary Table"."Entry No." += 1;
                    "Temporary Table".Code1 := rDepartmentsEmp.Code;
                    "Temporary Table".Text1 := rDepartmentsEmp.Description;
                    "Temporary Table".Insert;
                until rDepartmentsEmp.Next = 0;
            end;
        end;

        //FiscalSituation
        if pTabela = 'FiscalSituation' then Option2Table(78);

        //Genders
        if pTabela = 'Genders' then Option2Table(24);

        //Jobs
        if pTabela = 'Jobs' then begin
            rCatProf.Reset;
            if rCatProf.FindSet then begin
                repeat
                    "Temporary Table"."Entry No." += 1;
                    "Temporary Table".Code1 := rCatProf.Código;
                    "Temporary Table".Text1 := rCatProf.Descrição;
                    "Temporary Table".Insert;
                until rCatProf.Next = 0;
            end;
        end;

        //JobsLocals
        if pTabela = 'JobsLocals' then begin
            rEstabelecimento.Reset;
            if rEstabelecimento.FindSet then begin
                repeat
                    "Temporary Table"."Entry No." += 1;
                    "Temporary Table".Code1 := rEstabelecimento."Número da Unidade Local";
                    "Temporary Table".Text1 := rEstabelecimento.Descrição;
                    "Temporary Table".Insert;
                until rEstabelecimento.Next = 0;
            end;
        end;

        //PaymentModes
        if pTabela = 'PaymentModes' then begin
            "Temporary Table"."Entry No." += 1;
            "Temporary Table".Code1 := '0';
            "Temporary Table".Text1 := 'Outro';
            "Temporary Table".Insert;
            "Temporary Table"."Entry No." += 1;
            "Temporary Table".Code1 := '1';
            "Temporary Table".Text1 := 'Transf. Bancária';
            "Temporary Table".Insert;
        end;
        //ProfessionalCategory
        if pTabela = 'ProfessionalCategory' then begin
            rCatProfQP.Reset;
            if rCatProfQP.FindSet then begin
                repeat
                    "Temporary Table"."Entry No." += 1;
                    "Temporary Table".Code1 := rCatProfQP.Código;
                    "Temporary Table".Text1 := rCatProfQP.Descrição;
                    "Temporary Table".Insert;
                until rCatProfQP.Next = 0;
            end;
        end;
    end;

    local procedure Option2Table(IDCampo: Integer)
    var
        vRecRef: RecordRef;
        vFieldRef: FieldRef;
        i: Integer;
        OptionString: Text;
        OptionStringAux: Text;
        total: Integer;
    begin
        Clear(OptionString);
        Clear(total);

        vRecRef.Open(53035);
        vFieldRef := vRecRef.Field(IDCampo);
        if Format(vFieldRef.Type) = 'Option' then begin
            OptionString := vFieldRef.OptionMembers;
            OptionStringAux := OptionString;
            while StrPos(OptionStringAux, ',') <> 0 do begin
                OptionStringAux := CopyStr(OptionStringAux, StrPos(OptionStringAux, ',') + 1);
                total := total + 1
            end;
            total := total + 1;
            for i := 1 to total do begin
                "Temporary Table"."Entry No." += 1;
                "Temporary Table".Code1 := Format(i - 1);
                "Temporary Table".Text1 := SelectStr(i, OptionString);
                "Temporary Table".Insert;
            end;
        end;
    end;
}

