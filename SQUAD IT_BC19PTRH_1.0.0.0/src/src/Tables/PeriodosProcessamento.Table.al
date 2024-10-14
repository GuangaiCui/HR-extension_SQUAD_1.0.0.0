table 53081 "Periodos Processamento"
{
    Caption = 'Periodos Processamento';
    DataCaptionFields = "Cód. Processamento", "Tipo Processamento";
    DrillDownPageID = "Periodos Processamento";
    LookupPageID = "Periodos Processamento";

    fields
    {
        field(1; "Cód. Processamento"; Code[10])
        {
            //Caption = 'Payroll Code';

            trigger OnValidate()
            var
                l_CabMovsEmpregado: Record "Cab. Movs. Empregado";
                l_HistCabMovsEmpregado: Record "Hist. Cab. Movs. Empregado";
            begin

                //C+ -LCF- 30.08.2007

                //C+ - RSC - RH-006 - 09.01.2007
                recPeriodosProcessamento.Reset;
                recPeriodosProcessamento.SetRange(Estado, recPeriodosProcessamento.Estado::Aberto);
                recPeriodosProcessamento.SetFilter("Cód. Processamento", '<>%1', xRec."Cód. Processamento");
                if recPeriodosProcessamento.Find('-') then begin
                    Error(Text0010);
                end;
                //C+ - RSC - RH-006 - 09.01.2007


                if xRec."Cód. Processamento" <> "Cód. Processamento" then begin
                    l_CabMovsEmpregado.Reset;
                    l_CabMovsEmpregado.SetRange("Cód. Processamento", xRec."Cód. Processamento");
                    if l_CabMovsEmpregado.Find('-') then
                        Error(Text0012);

                    l_HistCabMovsEmpregado.Reset;
                    l_HistCabMovsEmpregado.SetRange("Cód. Processamento", xRec."Cód. Processamento");
                    if l_HistCabMovsEmpregado.Find('-') then
                        Error(Text0012);
                end;
                //C+ -LCF- 30.08.2007  -Fim-


                //HG 13.04.07 - Não deixar alterar o código de processamentos já fechados
                if ("Cód. Processamento" <> xRec."Cód. Processamento") and (Estado = Estado::Fechado) then
                    Error(Text0011);
                //HG fim


                //2009.03.18 - não deixar criar dois processamentos com o mesmo código
                recPeriodosProcessamento.Reset;
                recPeriodosProcessamento.SetRange("Cód. Processamento", "Cód. Processamento");
                if recPeriodosProcessamento.Find('-') then
                    Error(Text0013);
            end;
        }
        field(3; "Tipo Processamento"; Option)
        {
            //Caption = 'Payroll Type';
            OptionCaption = 'Vencimentos,Encargos,Sub. Natal,Sub. Férias';
            OptionMembers = Vencimentos,Encargos,SubNatal,SubFerias;
        }
        field(5; "Data Registo"; Date)
        {
            //Caption = 'Posting Date';
        }
        field(6; Estado; Option)
        {
            //Caption = 'Status';
            OptionCaption = 'Aberto,Fechado';
            OptionMembers = Aberto,Fechado;
        }
        field(7; "Data Inicio Processamento"; Date)
        {
            //Caption = 'Payroll Start Date';
        }
        field(8; "Data Fim Processamento"; Date)
        {
            //Caption = 'Payroll End Date';
        }
        field(15; "Integrado na Contabilidade"; Boolean)
        {
            //Caption = 'Posted in General Ledger';
        }
        field(20; "Data Inicio Proces. Faltas"; Date)
        {
            //Caption = 'Absence Start Date';
        }
        field(21; "Data Fim Proces. Faltas"; Date)
        {
            //Caption = 'Absence End Date';
        }
        field(30; Pendente; Boolean)
        {
            CalcFormula = Lookup("Hist. Cab. Movs. Empregado".Pendente WHERE("Cód. Processamento" = FIELD("Cód. Processamento"),
                                                                              "Tipo Processamento" = FIELD("Tipo Processamento")));
            //Caption = 'Open';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Cód. Processamento", "Tipo Processamento")
        {
            Clustered = true;
        }
        key(Key2; "Data Registo")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Cód. Processamento", "Tipo Processamento", Estado, "Data Registo")
        {
        }
    }

    trigger OnDelete()
    var
        HistCabMovsEmpregado: Record "Hist. Cab. Movs. Empregado";
        CabMovsEmpregado: Record "Cab. Movs. Empregado";
        LinhasMovsEmpregado: Record "Linhas Movs. Empregado";
    begin
        HistCabMovsEmpregado.Reset;
        HistCabMovsEmpregado.SetRange("Cód. Processamento", "Cód. Processamento");
        HistCabMovsEmpregado.SetRange("Tipo Processamento", "Tipo Processamento");
        if HistCabMovsEmpregado.Find('-') then
            Error(Text0001);

        CabMovsEmpregado.Reset;
        CabMovsEmpregado.SetRange("Cód. Processamento", "Cód. Processamento");
        //CabMovsEmpregado.SETRANGE("Tipo Processamento","Tipo Processamento");
        if CabMovsEmpregado.Find('-') then begin
            if not Confirm(StrSubstNo(Text0002, "Cód. Processamento"), false) then
                Error(Text0003);

            LinhasMovsEmpregado.Reset;
            LinhasMovsEmpregado.SetRange("Cód. Processamento", "Cód. Processamento");
            //LinhasMovsEmpregado.SETRANGE("Tipo Processamento","Tipo Processamento");
            if LinhasMovsEmpregado.Find('-') then
                LinhasMovsEmpregado.DeleteAll;

            CabMovsEmpregado.DeleteAll;
        end;
    end;

    trigger OnModify()
    var
        l_CabMovsEmpregado: Record "Cab. Movs. Empregado";
        l_HistCabMovsEmpregado: Record "Hist. Cab. Movs. Empregado";
    begin
    end;

    var
        recPeriodosProcessamento: Record "Periodos Processamento";
        Text0001: Label 'Já existem movimentos registados para este Processamento, não o pode eliminar.';
        Text0002: Label 'Este Processamento tem movimentos associados, confirma que deseja eliminar os movimentos do processamento %1?';
        Text0003: Label 'Operação abortada pelo utilizador.';
        Text0010: Label 'Não pode abrir meses de processamento enquanto não finalizar os anteriores.';
        Text0011: Label 'Não pode alterar o Código de um Processamento já fechado.';
        Text0012: Label 'Não pode alterar o Código de Processamento porque já existem movimentos associados a esse mesmo Código.';
        Text0013: Label 'Já existe um processamento com esse código.';
}

