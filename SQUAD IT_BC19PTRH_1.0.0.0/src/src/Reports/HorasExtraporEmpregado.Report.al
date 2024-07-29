report 53064 "Horas Extra por Empregado"
{
    // //-------------------------------------------------------
    //               Horas Extra por Empregado
    // //--------------------------------------------------------
    //   É um Mapa para listar para cada Empregado as várias
    //   horas extra num determinado periodo.
    //   Este Report está disponível a partir de Mapas.
    // //-------------------------------------------------------
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\HorasExtraporEmpregado.rdlc';

    Caption = 'Horas Extra por Empregado';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Histórico Horas Extra"; "Histórico Horas Extra")
        {
            DataItemTableView = SORTING("No. Empregado", Data);
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
            column("Histórico_Horas_Extra__TABLECAPTION__________HoraExtraFiltro"; "Histórico Horas Extra".TableCaption + ': ' + HoraExtraFiltro)
            {
            }
            column("Histórico_Horas_Extra__Histórico_Horas_Extra___N__Empregado_"; "Histórico Horas Extra"."No. Empregado")
            {
            }
            column(Employee_FullName; Employee.FullName)
            {
            }
            column("Histórico_Horas_Extra_Data"; Data)
            {
            }
            column("Histórico_Horas_Extra__Histórico_Horas_Extra___Cód__Hora_Extra_"; "Histórico Horas Extra"."Cód. Hora Extra")
            {
            }
            column("Histórico_Horas_Extra__Histórico_Horas_Extra__Descrição"; "Histórico Horas Extra".Descrição)
            {
            }
            column("Histórico_Horas_Extra_Quantidade"; Quantidade)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(HORAS_EXTRA_POR_EMPREGADOCaption; HORAS_EXTRA_POR_EMPREGADOCaptionLbl)
            {
            }
            column("Histórico_Horas_Extra_DataCaption"; FieldCaption(Data))
            {
            }
            column("Histórico_Horas_Extra__Histórico_Horas_Extra___Cód__Hora_Extra_Caption"; FieldCaption("Cód. Hora Extra"))
            {
            }
            column("Histórico_Horas_Extra__Histórico_Horas_Extra__DescriçãoCaption"; FieldCaption(Descrição))
            {
            }
            column("Histórico_Horas_Extra_QuantidadeCaption"; FieldCaption(Quantidade))
            {
            }
            column("Histórico_Horas_Extra_N__Mov_"; "No. Mov.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Employee.Get("No. Empregado");
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("No. Empregado");
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
        HoraExtraFiltro := "Histórico Horas Extra".GetFilters;
        TabConfEmpresa.Get;
        TabConfEmpresa.CalcFields(Picture);
    end;

    var
        Employee: Record Employee;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        HoraExtraFiltro: Text[250];
        TabConfEmpresa: Record "Company Information";
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        HORAS_EXTRA_POR_EMPREGADOCaptionLbl: Label 'HORAS EXTRA POR EMPREGADO';
}

