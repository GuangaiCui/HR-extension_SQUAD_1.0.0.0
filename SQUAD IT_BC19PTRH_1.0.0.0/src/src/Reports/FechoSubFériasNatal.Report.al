report 53039 "Fecho Sub. Férias/Natal"
{
    // //-------------------------------------------------------
    //               Fecho do Mês Sub. Natal e Férias
    // //--------------------------------------------------------
    //   Este é o report que passa a informação referente a
    //   processamentos de Sub. de Natal e Férias para histórico.
    //   Para dizer que um processamento é definitivo e se poder
    //   tirar alguns mapas legais, há que fazer o fecho.
    //   Está disponível a partir do Processamento Anual.
    // //-------------------------------------------------------
    UsageCategory = Tasks;
    ApplicationArea = HumanResourcesAppArea;

    Permissions = TableData "Histórico Ausências" = rimd,
                  TableData "Histórico Horas Extra" = rimd,
                  TableData "Histórico Abonos - Desc. Extra" = rimd,
                  TableData "Hist. Cab. Movs. Empregado" = rimd,
                  TableData "Hist. Linhas Movs. Empregado" = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Periodos Processamento"; "Periodos Processamento")
        {
            DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento");
            dataitem("Cab. Movs. Empregado"; "Cab. Movs. Empregado")
            {
                DataItemLink = "Cód. Processamento" = FIELD("Cód. Processamento");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado");

                trigger OnAfterGetRecord()
                begin
                    HistCabMovEmp.Init;
                    HistCabMovEmp.TransferFields("Cab. Movs. Empregado");
                    if ("Cab. Movs. Empregado"."Tipo Processamento" = "Cab. Movs. Empregado"."Tipo Processamento"::SubFerias) or
                       ("Cab. Movs. Empregado"."Tipo Processamento" = "Cab. Movs. Empregado"."Tipo Processamento"::SubNatal) then
                        HistCabMovEmp.Pendente := true;

                    HistCabMovEmp.Insert;
                    "Cab. Movs. Empregado".Delete;

                    //Marca os empregados deste processamento
                    //---------------------------------------
                    TabEmpregado.SetRange(TabEmpregado."No.", "Cab. Movs. Empregado"."No. Empregado");
                    if TabEmpregado.FindFirst then
                        TabEmpregado.Mark(true);
                end;
            }
            dataitem("Linhas Movs. Empregado"; "Linhas Movs. Empregado")
            {
                DataItemLink = "Cód. Processamento" = FIELD("Cód. Processamento");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado", "No. Linha");

                trigger OnAfterGetRecord()
                begin
                    HistLinhasMovEmp.Init;
                    HistLinhasMovEmp.TransferFields("Linhas Movs. Empregado");
                    HistLinhasMovEmp.Insert;

                    //Proporcionais Sub. Férias
                    //quando fecho 1 mes com Sub. Férias processados tenho de actualizar a ficha do  empregado com a Ultima data Acerto SF
                    if ConfRH.Get() then;
                    RubricSalarial.Reset;
                    if (RubricSalarial.Get("Linhas Movs. Empregado"."Cód. Rubrica")) and
                       (RubricSalarial.NATREM = RubricSalarial.NATREM::"Cód. Sub. Férias") then begin
                        if TabEmp.Get("Linhas Movs. Empregado"."No. Empregado") then begin
                            ContratoEmp.Reset;
                            ContratoEmp.SetRange(ContratoEmp."Cód. Empregado", TabEmp."No.");
                            ContratoEmp.SetFilter(ContratoEmp."Data Inicio Contrato", '<=%1', "Periodos Processamento"."Data Fim Processamento");
                            ContratoEmp.SetFilter(ContratoEmp."Data Fim Contrato", '>=%1|%2', "Periodos Processamento"."Data Inicio Processamento", 0D);
                            if ContratoEmp.FindFirst then begin
                                //Por defeito a última data proc. Sub. férias é sempre igual à data fim processamento
                                TabEmp."Última data Proc. Sub. Férias" := "Periodos Processamento"."Data Fim Processamento";
                                //Excepto se: a data do contrato for do ano transacto e emgregado sem termo
                                if (ContratoEmp."Tipo Contrato" = ContratoEmp."Tipo Contrato"::"Sem Termo") and
                                  (Date2DMY(TabEmp."Employment Date", 3) < Date2DMY("Periodos Processamento"."Data Fim Processamento", 3)) then
                                    TabEmp."Última data Proc. Sub. Férias" := DMY2Date(31, 12, Date2DMY("Periodos Processamento"."Data Fim Processamento", 3));
                                //Excepto se: o empregado tem contrato sem termo e a opção escolhida é sem termo
                                if (ContratoEmp."Tipo Contrato" = ContratoEmp."Tipo Contrato"::"Sem Termo") and
                                   ((ConfRH."Pagamento total Sub. Férias" = ConfRH."Pagamento total Sub. Férias"::"Contratos Sem Termo") or
                                   (ConfRH."Pagamento total Sub. Férias" = ConfRH."Pagamento total Sub. Férias"::"Para ambos")) then
                                    TabEmp."Última data Proc. Sub. Férias" := DMY2Date(31, 12, Date2DMY("Periodos Processamento"."Data Fim Processamento", 3));
                                //Excepto se: o empregado tem contrato a termo e a opção escolhida é a termo
                                if (ContratoEmp."Tipo Contrato" = ContratoEmp."Tipo Contrato"::"A Termo") and
                                   ((ConfRH."Pagamento total Sub. Férias" = ConfRH."Pagamento total Sub. Férias"::"Contratos a Termo") or
                                   (ConfRH."Pagamento total Sub. Férias" = ConfRH."Pagamento total Sub. Férias"::"Para ambos")) then
                                    TabEmp."Última data Proc. Sub. Férias" := ContratoEmp."Data Fim Contrato";
                                TabEmp.Modify;
                            end;
                        end;
                    end;
                    "Linhas Movs. Empregado".Delete;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Fechado then
                    Error(Text0001);

                if ("Periodos Processamento"."Tipo Processamento" = "Periodos Processamento"."Tipo Processamento"::Vencimentos) or
                   ("Periodos Processamento"."Tipo Processamento" = "Periodos Processamento"."Tipo Processamento"::Encargos) then
                    Error(Text0002);
                "Periodos Processamento".Estado := "Periodos Processamento".Estado::Fechado;
                "Periodos Processamento".Modify;
            end;

            trigger OnPreDataItem()
            begin
                SetFilter("Cód. Processamento", PeriodoCode);
            end;
        }
        dataitem(Empregado; Employee)
        {
            DataItemTableView = SORTING("No.");
            dataitem("Abonos - Descontos Extra"; "Abonos - Descontos Extra")
            {
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("No. Mov.");

                trigger OnAfterGetRecord()
                begin
                    //Passar para Histórico as Abonos/Descontos deste processamento
                    //------------------------------------------------------
                    if ("Abonos - Descontos Extra".Data >= "Periodos Processamento"."Data Inicio Processamento") and
                      ("Abonos - Descontos Extra".Data <= "Periodos Processamento"."Data Fim Processamento") then begin
                        HistAboDesExtra.Reset;
                        if HistAboDesExtra.FindLast then
                            VarNMov := HistAboDesExtra."No. Mov." + 1
                        else
                            VarNMov := 1;
                        HistAboDesExtra.Init;
                        HistAboDesExtra.TransferFields("Abonos - Descontos Extra");
                        HistAboDesExtra."No. Mov." := VarNMov;
                        HistAboDesExtra.Insert;
                        "Abonos - Descontos Extra".Delete;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            var
                rPenhora: Record Penhoras;
            begin
                //Penhoras
                rPenhora.Reset;
                rPenhora.SetRange("Employee No.", Empregado."No.");
                if rPenhora.FindSet then begin
                    repeat
                        rPenhora.CalcFields("Amount Already Garnishment");
                        if (rPenhora."Garnishment Amount" = rPenhora."Amount Already Garnishment") and
                           (rPenhora.Status <> rPenhora.Status::Closed) then begin
                            rPenhora.Status := rPenhora.Status::Closed;
                            rPenhora.Modify;
                        end;
                    until rPenhora.Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin
                //Filtrar a tabela empregado para que só apareçam os empregados que se filtrou anteriormente
                //----------------------------------------------------------------------------------------
                TabEmpregado.MarkedOnly(true);
                TabEmpregado.SetRange("No.");
                TabEmpregado.FindSet;
                repeat
                    if Empregado.Get(TabEmpregado."No.") then
                        Empregado.Mark(true);

                until TabEmpregado.Next = 0;
                Empregado.MarkedOnly(true);
                Empregado.SetRange("No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Periodo Processamento")
                {
                    Caption = 'Periodo Processamento';
                    field(PeriodoCode; PeriodoCode)
                    {
                        ;
                        Caption = 'Periodo Processamento';
                        TableRelation = "Periodos Processamento";
                    }
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

    var
        HistCabMovEmp: Record "Hist. Cab. Movs. Empregado";
        HistLinhasMovEmp: Record "Hist. Linhas Movs. Empregado";
        Text0001: Label 'Este processamento já está fechado.';
        Text0002: Label 'Escolha um Processamento do tipo Sub. Férias ou Natal.';
        TabEmpregado: Record Employee;
        HistAboDesExtra: Record "Histórico Abonos - Desc. Extra";
        VarNMov: Integer;
        ConfRH: Record "Config. Recursos Humanos";
        RubricSalarial: Record "Rubrica Salarial";
        TabEmp: Record Employee;
        ContratoEmp: Record "Contrato Empregado";
        PeriodoCode: Code[10];
}

