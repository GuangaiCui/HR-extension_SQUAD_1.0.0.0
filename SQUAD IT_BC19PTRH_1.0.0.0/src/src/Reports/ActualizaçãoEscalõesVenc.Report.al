report 53079 "Actualização Escalões Venc."
{
    ProcessingOnly = true;
    UseRequestPage = false;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(Empregado; Empregado)
        {
            DataItemTableView = SORTING("No.") WHERE(Status = CONST(Active));

            trigger OnAfterGetRecord()
            begin
                NewLine := false;
                Empregado.CalcFields(Empregado."Grau Função");
                if TabGrauFuncao.Get(Empregado."Grau Função") then begin
                    if Round(Empregado."No. Horas Semanais", 0.01) <> 0 then begin
                        TabRubricaSal.Reset;
                        TabRubricaSal.SetRange(TabRubricaSal."Actualização Vencimento", true);
                        if TabRubricaSal.FindSet then begin
                            repeat
                                TabRubricaSalEmp.Reset;
                                TabRubricaSalEmp.SetRange(TabRubricaSalEmp."Employee No.", Empregado."No.");
                                TabRubricaSalEmp.SetRange(TabRubricaSalEmp."Cód. Rúbrica Salarial", TabRubricaSal.Código);
                                TabRubricaSalEmp.SetFilter(TabRubricaSalEmp."Data Início", '<=%1', WorkDate);
                                TabRubricaSalEmp.SetFilter(TabRubricaSalEmp."Data Fim", '>=%1|=%2', WorkDate, 0D);
                                if TabRubricaSalEmp.FindSet then begin
                                    repeat
                                        if not NewLine then begin
                                            ValidaLineNo(Empregado."No.");
                                            if Round(TabGrauFuncao."Valor Hora Semanal", 0.01) <> 0 then begin
                                                InsereLinha(TabRubricaSalEmp, ValorTotal);
                                                TabRubricaSalEmp."Data Fim" := CalcDate('-1D', DataInicio);
                                                TabRubricaSalEmp.Modify;
                                            end else begin
                                                ValorTotal := TabGrauFuncao."Max Value";
                                                InsereLinha(TabRubricaSalEmp, ValorTotal);
                                                TabRubricaSalEmp."Data Fim" := CalcDate('-1D', DataInicio);
                                                TabRubricaSalEmp.Modify;
                                            end;
                                        end else
                                            CurrReport.Skip;
                                    until TabRubricaSalEmp.Next = 0;
                                end;
                            until TabRubricaSal.Next = 0;
                        end;
                    end else
                        Message(Text0001, Empregado."No.");
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Opções")
                {
                    Caption = 'Options';
                    field(DataInicio; DataInicio)
                    {

                        Caption = 'Introduza a Data em que entrará em vigor os novos vencimentos e pressione a tecla Enter.';
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
        Message(Text0002);
    end;

    trigger OnInitReport()
    begin
        if not Confirm(Text0003) then
            CurrReport.Quit
    end;

    trigger OnPreReport()
    begin
        //JPC
        //else begin
        //    Window.Open(Text0005 + '#1#########\', DataInicio);


        //EntryNo := 0;
        //NewEntryNo := 1;
        //while (NewEntryNo > 0) and (EntryNo <> NewEntryNo) do begin
        //    EntryNo := NewEntryNo;
        //    case EntryNo of
        //        1:
        //            NewEntryNo := Window.InputBox(Text0005, 'INPUT','', 100, 100)(1, DataInicio);
        //
        //    end;
        //end;
        //Window.Close;

        if DataInicio = 0D then
            Error(Text0004);

        //
    end;

    var
        TabGrauFuncao: Record "Grau Função";
        TabRubricaSal: Record "Payroll Item";
        TabRubricaSalEmp: Record "Rubrica Salarial Empregado";
        Text0001: Label 'O Empregado %1 não tem horas semanais preenchidas.';
        Text0002: Label 'Processo concluído.';
        Text0003: Label 'Para actualizar os vencimentos é necessário ter previamente:\   - Importado a nova tabela dos Escalões Vencimento;\   - Actualizado o Grau de função na Ficha do Empregado;\   - Actualizado o Nº horas Semanais na Ficha Empregado.\ Deseja continuar?';
        DataInicio: Date;
        Window: Dialog;
        EntryNo: Integer;
        NewEntryNo: Integer;
        Text0004: Label 'Data Inicio não preenchida.';
        rRubSalarialEmp: Record "Rubrica Salarial Empregado";
        LineNo: Integer;
        ValorTotal: Decimal;
        DataFim: Date;
        NewLine: Boolean;
        Text0005: Label 'Introduza a Data em que entrará em vigor os novos vencimentos e pressione a tecla Enter.';

    procedure ValidaLineNo(pNoEmpregado: Code[20])
    begin
        rRubSalarialEmp.Reset;
        rRubSalarialEmp.SetRange("Employee No.", pNoEmpregado);
        //2009.01.21 - comentei porque o empregado pode ter uma rubrica já criada para o futuro e que ainda não está em vigor
        //rRubSalarialEmp.SETFILTER("Data Início",'<=%1',WORKDATE);
        //rRubSalarialEmp.SETFILTER("Data Fim",'>=%1|=%2',WORKDATE,0D);
        if rRubSalarialEmp.FindLast then begin
            LineNo := rRubSalarialEmp."Line No." + 10000;
            NewLine := true;
        end else begin
            LineNo := 10000;
            NewLine := true;
        end;
    end;

    procedure InsereLinha(pRubricaSalarialEmpregado: Record "Rubrica Salarial Empregado"; pValorTotal: Decimal)
    var
        rRubricaSalarialEmp: Record "Rubrica Salarial Empregado";
    begin
        rRubricaSalarialEmp.Init;
        rRubricaSalarialEmp.TransferFields(pRubricaSalarialEmpregado);
        if pRubricaSalarialEmpregado."Unit Value" <> 0 then
            rRubricaSalarialEmp."Unit Value" := pValorTotal;
        rRubricaSalarialEmp."Line No." := LineNo;
        rRubricaSalarialEmp."Data Início" := DataInicio;
        //2009.01.21 - os vencimentos agora são de Janeiro a Dezembro
        rRubricaSalarialEmp."Data Fim" := DMY2Date(31, 12, Date2DMY(DataInicio, 3));
        rRubricaSalarialEmp."Valor Total" := pValorTotal;
        rRubricaSalarialEmp.Insert;
    end;
}

