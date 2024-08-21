report 53060 "Ausência por Empregado"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\AusênciaporEmpregado.rdl';
    PreviewMode = PrintLayout;


    dataset
    {
        dataitem(Empregado; Employee)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(TabConfEmpresa_Name; TabConfEmpresa.Name)
            {
            }
            column(USERID; UserId)
            {
            }
            column(TabConfEmpresa__Name_2_; TabConfEmpresa."Name 2")
            {
            }
            column(TabConfEmpresa_Address; TabConfEmpresa.Address)
            {
            }
            column(TabConfEmpresa_City; TabConfEmpresa.City)
            {
            }
            column(N__Telefone______TabConfEmpresa__Phone_No__; 'Nº Telefone: ' + TabConfEmpresa."Phone No.")
            {
            }
            column(N__Contribuinte______TabConfEmpresa__VAT_Registration_No__; 'Nº Contribuinte: ' + TabConfEmpresa."VAT Registration No.")
            {
            }
            column(TabConfEmpresa__Post_Code_; TabConfEmpresa."Post Code")
            {
            }
            column(TabConfEmpresa_Picture; TabConfEmpresa.Picture)
            {
            }
            column(Empregado_FullName; Empregado.FullName)
            {
            }
            column(Empregado_Empregado__No__; Empregado."No.")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column("AUSÊNCIAS_POR_EMPREGADOCaption"; AUSÊNCIAS_POR_EMPREGADOCaptionLbl)
            {
            }
            column("Com_Perca_de_RemuneraçãoCaption"; Com_Perca_de_RemuneraçãoCaptionLbl)
            {
            }
            column(JustificadaCaption; JustificadaCaptionLbl)
            {
            }
            column("Cód__Unid__MedidaCaption"; Cód__Unid__MedidaCaptionLbl)
            {
            }
            column(QuantidadeCaption; QuantidadeCaptionLbl)
            {
            }
            column("DescriçãoCaption"; DescriçãoCaptionLbl)
            {
            }
            column("Cód__motivo_ausênciaCaption"; Cód__motivo_ausênciaCaptionLbl)
            {
            }
            column("À_dataCaption"; À_dataCaptionLbl)
            {
            }
            column(A_partir_da_dataCaption; A_partir_da_dataCaptionLbl)
            {
            }
            column(Total_Dias_Caption; Total_Dias_CaptionLbl)
            {
            }
            dataitem("Ausência Empregado"; "Ausência Empregado")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Employee No.", "From Date");
                column("Ausência_Empregado__Com_Perca_de_Remuneração_"; Format("Com Perda de Remuneração"))
                {
                }
                column("Ausência_Empregado_Justificada"; Format(Justificada))
                {
                }
                column("Ausência_Empregado__Unit_of_Measure_Code_"; "Unit of Measure Code")
                {
                }
                column("Ausência_Empregado_Quantity"; Quantity)
                {
                }
                column("Ausência_Empregado_Description"; Description)
                {
                }
                column("Ausência_Empregado__Cause_of_Absence_Code_"; "Cause of Absence Code")
                {
                }
                column("Ausência_Empregado__To_Date_"; "To Date")
                {
                }
                column("Ausência_Empregado__From_Date_"; "From Date")
                {
                }
                column("Ausência_Empregado__Ausência_Empregado___Quantity__Base__"; "Ausência Empregado"."Quantity (Base)")
                {
                }
                column("Ausência_Empregado_Entry_No_"; "Entry No.")
                {
                }
                column("Ausência_Empregado_Employee_No_"; "Employee No.")
                {
                }

                trigger OnPreDataItem()
                begin
                    if AbertoFechado = 2 then
                        CurrReport.Break;

                    if (FiltroDataIni <> 0D) and (FiltroDataFim <> 0D) then
                        "Ausência Empregado".SetFilter("Ausência Empregado"."From Date", '%1..%2', FiltroDataIni, FiltroDataFim);
                end;
            }
            dataitem("Histórico Ausências"; "Histórico Ausências")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Employee No.", "From Date");
                column("Histórico_Ausências__Com_Perca_de_Remuneração_"; Format("Com Perca de Remuneração"))
                {
                }
                column("Histórico_Ausências_Justificada"; Format(Justificada))
                {
                }
                column("Histórico_Ausências__Unit_of_Measure_Code_"; "Unit of Measure Code")
                {
                }
                column("Histórico_Ausências_Quantity"; Quantity)
                {
                }
                column("Histórico_Ausências_Description"; Description)
                {
                }
                column("Histórico_Ausências__Cause_of_Absence_Code_"; "Cause of Absence Code")
                {
                }
                column("Histórico_Ausências__To_Date_"; "To Date")
                {
                }
                column("Histórico_Ausências__From_Date_"; "From Date")
                {
                }
                column("Histórico_Ausências__Histórico_Ausências___Quantity__Base__"; "Histórico Ausências"."Quantity (Base)")
                {
                }
                column("Histórico_Ausências_Entry_No_"; "Entry No.")
                {
                }
                column("Histórico_Ausências_Employee_No_"; "Employee No.")
                {
                }

                trigger OnPreDataItem()
                begin
                    if AbertoFechado = 1 then
                        CurrReport.Break;

                    if (FiltroDataIni <> 0D) and (FiltroDataFim <> 0D) then
                        "Histórico Ausências".SetFilter("Histórico Ausências"."From Date", '%1..%2', FiltroDataIni, FiltroDataFim);
                end;
            }
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
                    field(AbertoFechado; AbertoFechado)
                    {
                        ;
                        Caption = 'Processamento';
                    }
                    field(FiltroDataIni; FiltroDataIni)
                    {
                        ;
                        Caption = 'Data Início';
                    }
                    field(FiltroDataFim; FiltroDataFim)
                    {
                        ;
                        Caption = 'Data Fim';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            FiltroDataIni := DMY2Date(1, 1, Date2DMY(Today, 3));
            FiltroDataFim := Today;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        TabConfEmpresa.Get;
        TabConfEmpresa.CalcFields(TabConfEmpresa.Picture);

        if AbertoFechado = 1 then
            Texto := Text0001;
        if AbertoFechado = 2 then
            Texto := Text0002;
        if AbertoFechado = 0 then
            Error(text0003);
    end;

    var
        TabConfEmpresa: Record "Company Information";
        FiltroDataIni: Date;
        AbertoFechado: Option ,Aberto,Fechado;
        Text0001: Label 'Mês Aberto';
        Text0002: Label 'Mês Fechado';
        text0003: Label 'Tem de escolher uma das opções.';
        Texto: Text[30];
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        "AUSÊNCIAS_POR_EMPREGADOCaptionLbl": Label 'AUSÊNCIAS POR EMPREGADO';
        "Com_Perca_de_RemuneraçãoCaptionLbl": Label 'Com Perca de Remuneração';
        JustificadaCaptionLbl: Label 'Justificada';
        "Cód__Unid__MedidaCaptionLbl": Label 'Cód. Unid. Medida';
        QuantidadeCaptionLbl: Label 'Quantidade';
        "DescriçãoCaptionLbl": Label 'Descrição';
        "Cód__motivo_ausênciaCaptionLbl": Label 'Cód. motivo ausência';
        "À_dataCaptionLbl": Label 'À data';
        A_partir_da_dataCaptionLbl: Label 'A partir da data';
        Total_Dias_CaptionLbl: Label 'Total Dias:';
        Total_Dias_Caption_Control1102056044Lbl: Label 'Total Dias:';
        FiltroDataFim: Date;
}

