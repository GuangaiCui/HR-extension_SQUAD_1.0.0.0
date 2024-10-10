report 53038 "Fecho Mês"
{
    // //-------------------------------------------------------
    //                       Fecho do Mês
    // //--------------------------------------------------------
    //   Este é o report que passa a informação para histórico.
    //   Para dizer que um processamento é definitivo e se poder
    //   tirar alguns mapas legais, há que fazer o fecho do mês.
    //   Está disponível a partir do Processamento Mensal.
    // //-------------------------------------------------------

    UsageCategory = Tasks;
    ApplicationArea = HumanResourcesAppArea;

    Permissions = TableData "Histórico Ausências" = rimd,
                  TableData "Histórico Horas Extra" = rimd,
                  TableData "Histórico Abonos - Desc. Extra" = rimd,
                  TableData "Hist. Cab. Movs. Empregado" = rimd,
                  TableData "Hist. Linhas Movs. Empregado" = rimd,
                  TableData "Historico Empregado" = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Periodos Processamento"; "Periodos Processamento")
        {
            DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento") WHERE(Estado = CONST(Aberto));
            dataitem("Cab. Movs. Empregado"; "Cab. Movs. Empregado")
            {
                DataItemLink = "Cód. Processamento" = FIELD("Cód. Processamento");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "Employee No.");

                trigger OnAfterGetRecord()
                begin
                    HistCabMovEmp.Init;
                    HistCabMovEmp.TransferFields("Cab. Movs. Empregado");
                    if "Cab. Movs. Empregado"."Tipo Processamento" = "Cab. Movs. Empregado"."Tipo Processamento"::Vencimentos then     //2009.02.18
                        HistCabMovEmp.Pendente := true;
                    HistCabMovEmp.Insert;
                    "Cab. Movs. Empregado".Delete;
                    //Marca os empregados deste processamento
                    //---------------------------------------
                    TabEmpregado.SetRange(TabEmpregado."No.", "Cab. Movs. Empregado"."Employee No.");
                    if TabEmpregado.Find('-') then
                        TabEmpregado.Mark(true);
                end;
            }
            dataitem("Linhas Movs. Empregado"; "Linhas Movs. Empregado")
            {
                DataItemLink = "Cód. Processamento" = FIELD("Cód. Processamento");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "Employee No.", "No. Linha");

                trigger OnAfterGetRecord()
                begin
                    HistLinhasMovEmp.Init;
                    HistLinhasMovEmp.TransferFields("Linhas Movs. Empregado");
                    HistLinhasMovEmp.Insert;
                    //2008.01.15 - Retroactivos
                    //quando fecho 1 mes com retroactivos processados tenho de actualizar a configRH que para aquele ano os retroactivos já foram feitos
                    if CopyStr("Linhas Movs. Empregado"."Payroll Item Description", 1, 19) = 'Retroactivos de IRS' then begin
                        if ConfRH.Get() then
                            ConfRH."Retroactivos Processados" := true;
                        ConfRH.Modify;
                    end;
                    //2008.01.15 - fim

                    //2008.01.26 - Proporcionais Sub. Férias
                    //quando fecho 1 mes com Sub. Férias processados tenho de actualizar a ficha do  empregado com a Ultima data Acerto SF
                    if ConfRH.Get() then;
                    RubricSalarial.Reset;
                    if (RubricSalarial.Get("Linhas Movs. Empregado"."Payroll Item Code")) and
                       (RubricSalarial.NATREM = RubricSalarial.NATREM::"Cód. Sub. Férias") and
                       (RubricSalarial.Genero <> RubricSalarial.Genero::DuoSF) then begin //Normatica 2014.07.14 acrescentei esta linha
                        if TabEmp.Get("Linhas Movs. Empregado"."Employee No.") then begin
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
                                //Excepto se: estamos a processar o mês de acerto e então tem de ser a data de fim do processamento
                                if Date2DMY("Periodos Processamento"."Data Registo", 2) = ConfRH."Mês Acerto Sub. Férias" then
                                    TabEmp."Última data Proc. Sub. Férias" := "Periodos Processamento"."Data Fim Processamento";
                                //Excepto se: o empregado saiu nesse mês
                                if (TabEmp."End Date" >= "Periodos Processamento"."Data Inicio Processamento") and
                                   (TabEmp."End Date" <= "Periodos Processamento"."Data Fim Processamento") then
                                    TabEmp."Última data Proc. Sub. Férias" := TabEmp."End Date";
                                TabEmp.Modify;
                            end;
                        end;
                    end;
                    //2008.01.26 - fim
                    "Linhas Movs. Empregado".Delete;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if "Periodos Processamento".Estado = "Periodos Processamento".Estado::Fechado then
                    Error(Text0001);

                if ("Periodos Processamento"."Tipo Processamento" <> "Periodos Processamento"."Tipo Processamento"::Vencimentos) then
                    Error(Text0002);

                "Periodos Processamento".Estado := "Periodos Processamento".Estado::Fechado;
                "Periodos Processamento".Modify;
            end;

            trigger OnPreDataItem()
            begin
                SetFilter("Cód. Processamento", PeriodoCode);
            end;
        }
        dataitem(Empregado; Empregado)
        {
            DataItemTableView = SORTING("No.");
            dataitem("Ausência Empregado"; "Ausência Empregado")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.");

                trigger OnAfterGetRecord()
                begin
                    //Passar para Histórico as ausências deste processamento
                    //------------------------------------------------------
                    if (("Ausência Empregado"."From Date" >= "Periodos Processamento"."Data Inicio Proces. Faltas") and
                    ("Ausência Empregado"."From Date" <= "Periodos Processamento"."Data Fim Proces. Faltas")) or
                    (("Ausência Empregado"."To Date" >= "Periodos Processamento"."Data Inicio Proces. Faltas") and
                    ("Ausência Empregado"."To Date" <= "Periodos Processamento"."Data Fim Proces. Faltas")) then begin
                        //Processa a ausência por inteiro
                        if "Ausência Empregado"."To Date" <= "Periodos Processamento"."Data Fim Proces. Faltas" then
                            QtdAProcessar := "Ausência Empregado".Quantity;

                        //Processa parte da ausência
                        if "Ausência Empregado"."To Date" > "Periodos Processamento"."Data Fim Proces. Faltas" then begin
                            QtdAProcessar := Abs("Ausência Empregado"."Quantity (Base)" /
                            (("Ausência Empregado"."From Date" - "Ausência Empregado"."To Date") + 1) *
                            (("Periodos Processamento"."Data Fim Proces. Faltas" - "Ausência Empregado"."From Date") + 1));
                        end;
                        HistAusencia.Reset;
                        if HistAusencia.Find('+') then
                            VarNMov := HistAusencia."Entry No." + 1
                        else
                            VarNMov := 1;

                        HistAusencia.Init;
                        HistAusencia.TransferFields("Ausência Empregado");
                        HistAusencia."Entry No." := VarNMov;
                        HistAusencia.Validate(HistAusencia.Quantity, QtdAProcessar);
                        //2015.04.17 - Para poder abrir o processamento
                        HistAusencia."Processamento Referencia" := "Periodos Processamento"."Cód. Processamento";
                        HistAusencia.Insert;

                        //Passar os comentários da Ausência para Histórico
                        TabLinhaComentRH.Reset;
                        TabLinhaComentRH.SetRange(TabLinhaComentRH."Table Name", TabLinhaComentRH."Table Name"::Aus);
                        TabLinhaComentRH.SetRange(TabLinhaComentRH."Table Line No.", "Ausência Empregado"."Entry No.");
                        if TabLinhaComentRH.Find('-') then begin
                            TabLinhaComentRH.Rename(TabLinhaComentRH."Table Name"::HAus,
                            TabLinhaComentRH."No.", VarNMov, TabLinhaComentRH."Alternative Address Code",
                            TabLinhaComentRH."Line No.");
                        end;

                        if ("Ausência Empregado"."Quantidade Pendente" = 0) or
                           (not "Ausência Empregado"."Com Perda de Remuneração") then
                            "Ausência Empregado".Delete;
                    end;
                end;
            }
            dataitem("Horas Extra Empregado"; "Horas Extra Empregado")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.");

                trigger OnAfterGetRecord()
                begin
                    //Passar para Histórico as Horas Extra deste processamento
                    //------------------------------------------------------
                    if ("Horas Extra Empregado".Data >= "Periodos Processamento"."Data Inicio Processamento") and
                      ("Horas Extra Empregado".Data <= "Periodos Processamento"."Data Fim Processamento") then begin
                        HistHorasExtra.Reset;
                        if HistHorasExtra.Find('+') then
                            VarNMov := HistHorasExtra."Entry No." + 1
                        else
                            VarNMov := 1;

                        HistHorasExtra.Init;
                        HistHorasExtra.TransferFields("Horas Extra Empregado");
                        HistHorasExtra."Entry No." := VarNMov;
                        //2015.04.17 - Para poder abrir o processamento
                        HistHorasExtra."Processamento Referencia" := "Periodos Processamento"."Cód. Processamento";
                        HistHorasExtra.Insert;

                        //Passar os comentários das Horas Extra para Histórico
                        TabLinhaComentRH.Reset;
                        TabLinhaComentRH.SetRange(TabLinhaComentRH."Table Name", TabLinhaComentRH."Table Name"::HorEx);
                        TabLinhaComentRH.SetRange(TabLinhaComentRH."Table Line No.", "Horas Extra Empregado"."Entry No.");
                        if TabLinhaComentRH.FindFirst then begin
                            TabLinhaComentRH.Rename(TabLinhaComentRH."Table Name"::HHorEx,
                            TabLinhaComentRH."No.", VarNMov, TabLinhaComentRH."Alternative Address Code",
                            TabLinhaComentRH."Line No.");
                        end;
                        "Horas Extra Empregado".Delete;
                    end;
                end;
            }
            dataitem("Abonos - Descontos Extra"; "Abonos - Descontos Extra")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING();

                trigger OnAfterGetRecord()
                begin
                    //Passar para Histórico as Abonos/Descontos deste processamento
                    //------------------------------------------------------
                    if ("Abonos - Descontos Extra".Date >= "Periodos Processamento"."Data Inicio Processamento") and
                      ("Abonos - Descontos Extra".Date <= "Periodos Processamento"."Data Fim Processamento") then begin
                        HistAboDesExtra.Reset;
                        if HistAboDesExtra.FindLast then
                            VarNMov := HistAboDesExtra."Entry No." + 1
                        else
                            VarNMov := 1;

                        HistAboDesExtra.Init;
                        HistAboDesExtra.TransferFields("Abonos - Descontos Extra");
                        HistAboDesExtra."Entry No." := VarNMov;
                        //2015.04.17 - Para poder abrir o processamento
                        HistAboDesExtra."Processamento Referencia" := "Periodos Processamento"."Cód. Processamento";
                        HistAboDesExtra.Insert;
                        "Abonos - Descontos Extra".Delete;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            var
                rPenhora: Record Penhoras;
            begin
                //2009.02.26
                i := i + 1;
                Window.Update(1, Round(i * 100 / varTotalEmpregado * 100, 1));

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

    trigger OnPostReport()
    begin
        Window.Close;
    end;

    trigger OnPreReport()
    begin
        //C+ 2009.02.26
        TabEmpregado.Reset;
        TabEmpregado.SetRange(TabEmpregado.Status, TabEmpregado.Status::Active);
        if TabEmpregado.FindLast then
            varTotalEmpregado := TabEmpregado.Count;
        Window.Open(Text0003);
    end;

    var
        HistCabMovEmp: Record "Hist. Cab. Movs. Empregado";
        HistLinhasMovEmp: Record "Hist. Linhas Movs. Empregado";
        TabEmpregado: Record Empregado;
        HistAusencia: Record "Histórico Ausências";
        HistHorasExtra: Record "Histórico Horas Extra";
        HistAboDesExtra: Record "Histórico Abonos - Desc. Extra";
        TabLinhaComentRH: Record "Linha Coment. Recurso Humano";
        QtdAProcessar: Decimal;
        Text0001: Label 'Este processamento já está fechado.';
        VarNMov: Integer;
        Text0002: Label 'Escolha um Processamento do tipo Vencimentos.';
        ConfRH: Record "Config. Recursos Humanos";
        RubricSalarial: Record "Payroll Item";
        TabEmp: Record Empregado;
        ContratoEmp: Record "Contrato Empregado";
        varTotalEmpregado: Integer;
        Window: Dialog;
        Text0003: Label 'A processar @1@@@@@@@@@';
        i: Integer;
        PeriodoCode: Code[10];
}

