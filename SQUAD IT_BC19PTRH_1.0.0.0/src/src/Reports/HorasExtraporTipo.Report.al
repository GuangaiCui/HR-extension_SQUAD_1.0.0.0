report 53065 "Horas Extra por Tipo"
{
    // //-------------------------------------------------------
    //               Horas Extra por Tipos
    // //--------------------------------------------------------
    //   É um Mapa para listar as Horas Extra registadas agrupadas
    //   por tipo de Hora Extra.
    //   Este Report está disponível a partir de Mapas.
    // //-------------------------------------------------------
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\HorasExtraporTipo.rdl';

    Caption = 'Horas Extra por Tipo';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Histórico Horas Extra"; "Histórico Horas Extra")
        {
            DataItemTableView = SORTING("Cód. Hora Extra", Data);
            RequestFilterFields = "No. Empregado", Data, "Cód. Hora Extra";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(TabConfEmpresa_Picture; TabConfEmpresa.Picture)
            {
            }
            column(N__Contribuinte______TabConfEmpresa__VAT_Registration_No__; 'Nº Contribuinte: ' + TabConfEmpresa."VAT Registration No.")
            {
            }
            column(N__Telefone______TabConfEmpresa__Phone_No__; 'Nº Telefone: ' + TabConfEmpresa."Phone No.")
            {
            }
            column(TabConfEmpresa_City; TabConfEmpresa.City)
            {
            }
            column(TabConfEmpresa_Address; TabConfEmpresa.Address)
            {
            }
            column(TabConfEmpresa__Name_2_; TabConfEmpresa."Name 2")
            {
            }
            column(TabConfEmpresa_Name; TabConfEmpresa.Name)
            {
            }
            column(TabConfEmpresa__Post_Code_; TabConfEmpresa."Post Code")
            {
            }
            column("Histórico_Horas_Extra__TABLECAPTION__________EmpregadoHoraExtraFiltro"; "Histórico Horas Extra".TableCaption + ': ' + EmpregadoHoraExtraFiltro)
            {
            }
            column("Histórico_Horas_Extra_Descrição"; Descrição)
            {
            }
            column("Histórico_Horas_Extra__Cód__Hora_Extra_"; "Cód. Hora Extra")
            {
            }
            column("Histórico_Horas_Extra_Data"; Data)
            {
            }
            column("Histórico_Horas_Extra_Quantidade"; Quantidade)
            {
            }
            column("Histórico_Horas_Extra__N__Empregado_"; "No. Empregado")
            {
            }
            column(Employee_FullName; Employee.FullName)
            {
            }
            column(TotalHoraExtra; TotalHoraExtra)
            {
                DecimalPlaces = 0 : 2;
            }
            column("Histórico_Horas_Extra_Descrição_Control10"; Descrição)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(HORAS_EXTRA_POR_TIPOCaption; HORAS_EXTRA_POR_TIPOCaptionLbl)
            {
            }
            column("Histórico_Horas_Extra_DataCaption"; FieldCaption(Data))
            {
            }
            column("Histórico_Horas_Extra__N__Empregado_Caption"; FieldCaption("No. Empregado"))
            {
            }
            column(Full_NameCaption; Full_NameCaptionLbl)
            {
            }
            column("Histórico_Horas_Extra_QuantidadeCaption"; FieldCaption(Quantidade))
            {
            }
            column(Total_de_Horas_ExtraCaption; Total_de_Horas_ExtraCaptionLbl)
            {
            }
            column("Histórico_Horas_Extra_N__Mov_"; "No. Mov.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Employee.Get("No. Empregado");
                TotalHoraExtra := TotalHoraExtra + Quantidade;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Cód. Hora Extra");
                //TODO: Check if this total is right
                //CurrReport.CreateTotals(TotalHoraExtra);
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
    }

    trigger OnPreReport()
    begin
        EmpregadoHoraExtraFiltro := "Histórico Horas Extra".GetFilters;
        TabConfEmpresa.Get();
    end;

    var
        Employee: Record Employee;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        EmpregadoHoraExtraFiltro: Text[250];
        TotalHoraExtra: Decimal;
        TabConfEmpresa: Record "Company Information";
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        HORAS_EXTRA_POR_TIPOCaptionLbl: Label 'HORAS EXTRA POR TIPO';
        Full_NameCaptionLbl: Label 'Full Name';
        Total_de_Horas_ExtraCaptionLbl: Label 'Total de Horas Extra';
}

