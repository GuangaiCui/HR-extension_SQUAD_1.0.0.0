report 53069 "Mapa Trabalho Suplementar"
{
    // //-------------------------------------------------------
    //               Mapa Trabalho Suplementar
    // //--------------------------------------------------------
    //   É um Mapa Legal a ser entregue Semestralmente à Inspecção
    //   Geral de Trabalho com as horas extra de cada Empregado.
    //   Este Report está disponível a partir de Mapas.
    // //-------------------------------------------------------
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/MapaTrabalhoSuplementar.rdlc';

    Caption = 'Mapa Trabalho Suplementar';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Histórico Horas Extra"; "Histórico Horas Extra")
        {
            DataItemTableView = SORTING("No. Empregado", Data);
            RequestFilterFields = "No. Empregado", "Cód. Hora Extra";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(TabConfEmpresa_Address; TabConfEmpresa.Address)
            {
            }
            column(TabConfEmpresa_Name; TabConfEmpresa.Name)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(TabConfEmpresa_City; TabConfEmpresa.City)
            {
            }
            column(TabConfEmpresa__Post_Code_; TabConfEmpresa."Post Code")
            {
            }
            column(TabConfEmpresa_Picture; TabConfEmpresa.Picture)
            {
            }
            column(N__Telefone______TabConfEmpresa__Phone_No__; 'Nº Telefone: ' + TabConfEmpresa."Phone No.")
            {
            }
            column(N__Contribuinte______TabConfEmpresa__VAT_Registration_No__; 'Nº Contribuinte: ' + TabConfEmpresa."VAT Registration No.")
            {
            }
            column(TabConfEmpresa__Name_2_; TabConfEmpresa."Name 2")
            {
            }
            column(txtSemestre; txtSemestre)
            {
            }
            column("Histórico_Horas_Extra__TABLECAPTION__________HoraExtraFiltro"; "Histórico Horas Extra".TableCaption + ': ' + HoraExtraFiltro)
            {
            }
            column(NomeMes_1_; NomeMes[1])
            {
            }
            column(NomeMes_2_; NomeMes[2])
            {
            }
            column(NomeMes_3_; NomeMes[3])
            {
            }
            column(NomeMes_4_; NomeMes[4])
            {
            }
            column(NomeMes_5_; NomeMes[5])
            {
            }
            column(NomeMes_6_; NomeMes[6])
            {
            }
            column(Employee_FullName; Employee.FullName)
            {
            }
            column("Histórico_Horas_Extra__Histórico_Horas_Extra___N__Empregado_"; "Histórico Horas Extra"."No. Empregado")
            {
            }
            column(ValorMes_1_; ValorMes[1])
            {
            }
            column(ValorMes_2_; ValorMes[2])
            {
            }
            column(ValorMes_3_; ValorMes[3])
            {
            }
            column(ValorMes_4_; ValorMes[4])
            {
            }
            column(ValorMes_5_; ValorMes[5])
            {
            }
            column(ValorMes_6_; ValorMes[6])
            {
            }
            column(ValorMes_1___ValorMes_2___ValorMes_3__ValorMes_4__ValorMes_5___ValorMes_6_; ValorMes[1] + ValorMes[2] + ValorMes[3] + ValorMes[4] + ValorMes[5] + ValorMes[6])
            {
            }
            column(ValorMes_1___ValorMes_2___ValorMes_3__ValorMes_4__ValorMes_5___ValorMes_6__Control1101490048; ValorMes[1] + ValorMes[2] + ValorMes[3] + ValorMes[4] + ValorMes[5] + ValorMes[6])
            {
            }
            column(ValorMes_6__Control1101490050; ValorMes[6])
            {
            }
            column(ValorMes_5__Control1101490053; ValorMes[5])
            {
            }
            column(ValorMes_4__Control1101490055; ValorMes[4])
            {
            }
            column(ValorMes_3__Control1101490056; ValorMes[3])
            {
            }
            column(ValorMes_2__Control1101490058; ValorMes[2])
            {
            }
            column(ValorMes_1__Control1101490061; ValorMes[1])
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(MAPA_TRABALHO_SUPLEMENTARCaption; MAPA_TRABALHO_SUPLEMENTARCaptionLbl)
            {
            }
            column(Semestre_Caption; Semestre_CaptionLbl)
            {
            }
            column(N__Emp_Caption; N__Emp_CaptionLbl)
            {
            }
            column(NomeCaption; NomeCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Total_N__HorasCaption; Total_N__HorasCaptionLbl)
            {
            }
            column("Histórico_Horas_Extra_N__Mov_"; "No. Mov.")
            {
            }
            column(Processado_por_ComputadorCaption; Processado_por_ComputadorCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Employee.Get("Histórico Horas Extra"."No. Empregado");
                for i := 1 to 6 do begin
                    if (Date2DMY("Histórico Horas Extra".Data, 2) = i) or (Date2DMY("Histórico Horas Extra".Data, 2) = i + 6) then
                        ValorMes[i] := ValorMes[i] + "Histórico Horas Extra".Quantidade;
                end;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("No. Empregado");

                if Semestre = Semestre::"1º semestre" then begin
                    NomeMes[1] := 'Jan';
                    NomeMes[2] := 'Fev';
                    NomeMes[3] := 'Mar';
                    NomeMes[4] := 'Abr';
                    NomeMes[5] := 'Mai';
                    NomeMes[6] := 'Jun';
                    "Histórico Horas Extra".SetRange("Histórico Horas Extra".Data, DMY2Date(1, 1, Ano), DMY2Date(30, 6, Ano));
                    txtSemestre := Format(DMY2Date(1, 1, Ano)) + ' a ' + Format(DMY2Date(30, 6, Ano));
                end else begin
                    NomeMes[1] := 'Jul';
                    NomeMes[2] := 'Ago';
                    NomeMes[3] := 'Set';
                    NomeMes[4] := 'Out';
                    NomeMes[5] := 'Nov';
                    NomeMes[6] := 'Dez';
                    "Histórico Horas Extra".SetRange("Histórico Horas Extra".Data, DMY2Date(1, 7, Ano), DMY2Date(31, 12, Ano));
                    txtSemestre := Format(DMY2Date(1, 7, Ano)) + ' a ' + Format(DMY2Date(31, 12, Ano));
                end;
                CurrReport.CreateTotals(ValorMes);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Trabalho Suplementar")
                {
                    Caption = 'Trabalho Suplementar';
                    field(Semestre; Semestre)
                    {
                        ApplicationArea = All;
                        Caption = 'Semester';
                    }
                    field(Ano; Ano)
                    {
                        ApplicationArea = All;
                        Caption = 'Year';
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

    trigger OnInitReport()
    begin
        Ano := Date2DMY(WorkDate, 3);
    end;

    trigger OnPreReport()
    begin
        HoraExtraFiltro := "Histórico Horas Extra".GetFilters;
        TabConfEmpresa.Get;
        TabConfEmpresa.CalcFields(TabConfEmpresa.Picture);
    end;

    var
        Employee: Record Employee;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        HoraExtraFiltro: Text[250];
        TabConfEmpresa: Record "Company Information";
        NomeMes: array[6] of Text[30];
        ValorMes: array[6] of Decimal;
        Semestre: Option "1º semestre","2º semestre";
        Ano: Integer;
        i: Integer;
        txtSemestre: Text[60];
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        MAPA_TRABALHO_SUPLEMENTARCaptionLbl: Label 'MAPA TRABALHO SUPLEMENTAR';
        Semestre_CaptionLbl: Label 'Semestre:';
        N__Emp_CaptionLbl: Label 'Nº Emp.';
        NomeCaptionLbl: Label 'Nome';
        TotalCaptionLbl: Label 'Total';
        Total_N__HorasCaptionLbl: Label 'Total Nº Horas';
        Processado_por_ComputadorCaptionLbl: Label 'Processado por Computador';
}

