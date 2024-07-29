report 53104 "Reabrir Processamento"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\ReabrirProcessamento.rdlc';
    Permissions = TableData "Histórico Ausências" = rimd,
                  TableData "Histórico Horas Extra" = rimd,
                  TableData "Histórico Abonos - Desc. Extra" = rimd,
                  TableData "Hist. Cab. Movs. Empregado" = rimd,
                  TableData "Hist. Linhas Movs. Empregado" = rimd;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Periodos Processamento"; "Periodos Processamento")
        {
            RequestFilterFields = "Cód. Processamento";
            column(TODAY; Today)
            {
            }
            column(USERID; UserId)
            {
            }
            column(Processamento_eliminado_reabertoCaption; Processamento_eliminado_reabertoCaptionLbl)
            {
            }
            column("Periodos_Processamento_Cód__Processamento"; "Cód. Processamento")
            {
            }
            column(Periodos_Processamento_Tipo_Processamento; "Tipo Processamento")
            {
            }
            dataitem("Hist. Cab. Movs. Empregado"; "Hist. Cab. Movs. Empregado")
            {
                DataItemLink = "Cód. Processamento" = FIELD("Cód. Processamento");
                RequestFilterFields = "No. Empregado";
                column("Hist__Cab__Movs__Empregado_Cód__Processamento"; "Cód. Processamento")
                {
                }
                column(Hist__Cab__Movs__Empregado_Tipo_Processamento; "Tipo Processamento")
                {
                }
                column(Hist__Cab__Movs__Empregado_N__Empregado; "No. Empregado")
                {
                }
                dataitem("Hist. Linhas Movs. Empregado"; "Hist. Linhas Movs. Empregado")
                {
                    DataItemLink = "Cód. Processamento" = FIELD("Cód. Processamento"), "Tipo Processamento" = FIELD("Tipo Processamento"), "No. Empregado" = FIELD("No. Empregado");
                    DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado", "No. Linha");
                    column("Hist__Linhas_Movs__Empregado__Cód__Processamento_"; "Cód. Processamento")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado__Tipo_Processamento_; "Tipo Processamento")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado__N__Empregado_; "No. Empregado")
                    {
                    }
                    column("Hist__Linhas_Movs__Empregado__Designação_Empregado_"; "Designação Empregado")
                    {
                    }
                    column("Hist__Linhas_Movs__Empregado__Cód__Rubrica_"; "Cód. Rubrica")
                    {
                    }
                    column("Hist__Linhas_Movs__Empregado__Descrição_Rubrica_"; "Descrição Rubrica")
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado_Valor; Valor)
                    {
                    }
                    column("Hist__Linhas_Movs__Empregado__Cód__Processamento_Caption"; FieldCaption("Cód. Processamento"))
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado__Tipo_Processamento_Caption; FieldCaption("Tipo Processamento"))
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado__N__Empregado_Caption; FieldCaption("No. Empregado"))
                    {
                    }
                    column("Hist__Linhas_Movs__Empregado__Designação_Empregado_Caption"; FieldCaption("Designação Empregado"))
                    {
                    }
                    column("Hist__Linhas_Movs__Empregado__Cód__Rubrica_Caption"; FieldCaption("Cód. Rubrica"))
                    {
                    }
                    column("Hist__Linhas_Movs__Empregado__Descrição_Rubrica_Caption"; FieldCaption("Descrição Rubrica"))
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado_ValorCaption; FieldCaption(Valor))
                    {
                    }
                    column(Hist__Linhas_Movs__Empregado_N__Linha; "No. Linha")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        "Hist. Linhas Movs. Empregado".Delete;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    "Hist. Cab. Movs. Empregado".Delete;

                    "Periodos Processamento".Estado := "Periodos Processamento".Estado::Aberto;
                    "Periodos Processamento".Modify;
                end;

                trigger OnPreDataItem()
                begin
                    if "Hist. Cab. Movs. Empregado".GetFilter("Hist. Cab. Movs. Empregado"."No. Empregado") = '' then
                        Error(Text0002)
                    else
                        CodEmpregado := "Hist. Cab. Movs. Empregado".GetFilter("Hist. Cab. Movs. Empregado"."No. Empregado");
                end;
            }

            trigger OnPreDataItem()
            begin
                if "Periodos Processamento".GetFilter("Periodos Processamento"."Cód. Processamento") = '' then
                    Error(Text0001)
                else
                    CodProcessamento := "Periodos Processamento".GetFilter("Periodos Processamento"."Cód. Processamento");
            end;
        }
        dataitem("Histórico Ausências"; "Histórico Ausências")
        {
            DataItemTableView = SORTING("Employee No.", "From Date");
            column("Histórico_Ausências__Employee_No__"; "Employee No.")
            {
            }
            column("Histórico_Ausências__From_Date_"; "From Date")
            {
            }
            column("Histórico_Ausências__To_Date_"; "To Date")
            {
            }
            column("Histórico_Ausências__Cause_of_Absence_Code_"; "Cause of Absence Code")
            {
            }
            column("Histórico_Ausências_Description"; Description)
            {
            }
            column("Histórico_Ausências_Quantity"; Quantity)
            {
            }
            column("Histórico_Ausências__Unit_of_Measure_Code_"; "Unit of Measure Code")
            {
            }
            column("Histórico_Ausências_Entry_No_"; "Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                rAusenciasEmp.Reset;
                if rAusenciasEmp.Find('+') then
                    VarNMov := rAusenciasEmp."Entry No." + 1
                else
                    VarNMov := 1;

                rAusenciasEmp.Init;
                rAusenciasEmp.TransferFields("Histórico Ausências");
                rAusenciasEmp."Entry No." := VarNMov;
                rAusenciasEmp.Insert;

                "Histórico Ausências".Delete;
            end;

            trigger OnPreDataItem()
            begin
                "Histórico Ausências".SetFilter("Histórico Ausências"."Employee No.", CodEmpregado);
                "Histórico Ausências".SetRange("Histórico Ausências"."Processamento Referencia", CodProcessamento);
            end;
        }
        dataitem("Histórico Horas Extra"; "Histórico Horas Extra")
        {
            DataItemTableView = SORTING("No. Empregado", Data);
            column("Histórico_Horas_Extra_Data"; Data)
            {
            }
            column("Histórico_Horas_Extra__Cód__Hora_Extra_"; "Cód. Hora Extra")
            {
            }
            column("Histórico_Horas_Extra_Descrição"; Descrição)
            {
            }
            column("Histórico_Horas_Extra__Cód__Rubrica_"; "Cód. Rubrica")
            {
            }
            column("Histórico_Horas_Extra_Quantidade"; Quantidade)
            {
            }
            column("Histórico_Horas_Extra_Factor"; Factor)
            {
            }
            column("Histórico_Horas_Extra__Valor_Unitário_"; "Valor Unitário")
            {
            }
            column("Histórico_Horas_Extra__N__Empregado_"; "No. Empregado")
            {
            }
            column("Histórico_Horas_Extra_N__Mov_"; "No. Mov.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                rHorasExtraEmp.Reset;
                if rHorasExtraEmp.Find('+') then
                    VarNMov := rHorasExtraEmp."No. Mov." + 1
                else
                    VarNMov := 1;

                rHorasExtraEmp.Init;
                rHorasExtraEmp.TransferFields("Histórico Horas Extra");
                rHorasExtraEmp."No. Mov." := VarNMov;
                rHorasExtraEmp.Insert;


                "Histórico Horas Extra".Delete;
            end;

            trigger OnPreDataItem()
            begin
                "Histórico Horas Extra".SetFilter("Histórico Horas Extra"."No. Empregado", CodEmpregado);
                "Histórico Horas Extra".SetRange("Histórico Horas Extra"."Processamento Referencia", CodProcessamento);
            end;
        }
        dataitem("Histórico Abonos - Desc. Extra"; "Histórico Abonos - Desc. Extra")
        {
            DataItemTableView = SORTING("No. Empregado", "Data a que se refere o Mov.");
            column("Histórico_Abonos___Desc__Extra__N__Empregado_"; "No. Empregado")
            {
            }
            column("Histórico_Abonos___Desc__Extra_Data"; Data)
            {
            }
            column("Histórico_Abonos___Desc__Extra__Cód__Rubrica_"; "Cód. Rubrica")
            {
            }
            column("Histórico_Abonos___Desc__Extra__Descrição_Rubrica_"; "Descrição Rubrica")
            {
            }
            column("Histórico_Abonos___Desc__Extra_Quantidade"; Quantidade)
            {
            }
            column("Histórico_Abonos___Desc__Extra__Valor_Total_"; "Valor Total")
            {
            }
            column("Histórico_Abonos___Desc__Extra_UnidadeMedida"; UnidadeMedida)
            {
            }
            column("Histórico_Abonos___Desc__Extra_N__Mov_"; "No. Mov.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                rAbonosDescExtraEmp.Reset;
                if rAbonosDescExtraEmp.Find('+') then
                    VarNMov := rAbonosDescExtraEmp."No. Mov." + 1
                else
                    VarNMov := 1;

                rAbonosDescExtraEmp.Init;
                rAbonosDescExtraEmp.TransferFields("Histórico Abonos - Desc. Extra");
                rAbonosDescExtraEmp."No. Mov." := VarNMov;
                rAbonosDescExtraEmp.Insert;


                "Histórico Abonos - Desc. Extra".Delete;
            end;

            trigger OnPreDataItem()
            begin
                "Histórico Abonos - Desc. Extra".SetFilter("Histórico Abonos - Desc. Extra"."No. Empregado", CodEmpregado);
                "Histórico Abonos - Desc. Extra".SetRange("Histórico Abonos - Desc. Extra"."Processamento Referencia", CodProcessamento);
            end;
        }
        dataitem("Férias Empregados"; "Férias Empregados")
        {
            DataItemTableView = SORTING("No. Empregado", Data, Tipo);

            trigger OnAfterGetRecord()
            begin
                "Férias Empregados".Gozada := false;
                "Férias Empregados"."Processamento Referencia" := '';
                "Férias Empregados".Modify;
            end;

            trigger OnPreDataItem()
            begin
                "Férias Empregados".SetFilter("No. Empregado", CodEmpregado);
                "Férias Empregados".SetRange("Férias Empregados"."Processamento Referencia", CodProcessamento);
            end;
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

    labels
    {
        lblAusenciasEliminadas = 'Absence Deleted';
        lblHorasExtraEliminadas = 'Horas Extra Eliminadas';
        lblAbonosDescExtra = 'Abonos e Desc. Extra Eliminados';
        lblCodProc = 'Cód. Process.';
        lblNEmp = 'No. Empregado';
        lblDataIni = 'A partir da data';
        lblDataFim = 'À data';
        lblMotAus = 'Motivo Ausência';
        lblDescrição = 'Descrição';
        lblQtd = 'Quantidade';
        lblUniMed = 'Unidade Medida';
        lblData = 'Data';
        lblHoraExtra = 'Hora Extra';
        lblCodRubrica = 'Cód. Rubrica';
        lblFator = 'Factor';
        lblValorUni = 'Valor Unitário';
        lblValorTotal = 'Valor Total';
    }

    var
        Text0001: Label 'Tem de escolher um processamento.';
        Text0002: Label 'Tem de escolher um empregado.';
        CodProcessamento: Code[10];
        CodEmpregado: Code[100];
        rAusenciasEmp: Record "Ausência Empregado";
        rHorasExtraEmp: Record "Horas Extra Empregado";
        rAbonosDescExtraEmp: Record "Abonos - Descontos Extra";
        VarNMov: Integer;
        Processamento_eliminado_reabertoCaptionLbl: Label 'Processamento eliminado/reaberto';
        "Ausências_eliminadasCaptionLbl": Label 'Ausências eliminadas';
        Horas_Extra_eliminadasCaptionLbl: Label 'Horas Extra eliminadas';
        Abonos_e_Desc__Extra_eliminadosCaptionLbl: Label 'Abonos e Desc. Extra eliminados';
}

