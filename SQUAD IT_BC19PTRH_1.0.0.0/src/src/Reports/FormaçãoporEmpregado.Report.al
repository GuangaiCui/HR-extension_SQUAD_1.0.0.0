report 53089 "Formação por Empregado"
{
    // //-------------------------------------------------------
    //               Formação por Empregado
    // //--------------------------------------------------------
    //   É um Mapa para listar para cada Empregado as várias
    //   formações num determinado periodo.
    //   Este Report está disponível a partir de Mapas.
    // //-------------------------------------------------------
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\FormaçãoporEmpregado.rdl';

    Caption = 'Formação por Empregado';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Formação Empregado"; "Formação Empregado")
        {
            DataItemTableView = SORTING("No. Empregado", "Data Início", Tipo);
            RequestFilterFields = "No. Empregado", "Cód. Acção", "Data Início", "Data Fim";
            column(N__Contribuinte______TabConfEmpresa__VAT_Registration_No__; 'Nº Contribuinte: ' + TabConfEmpresa."VAT Registration No.")
            {
            }
            column(N__Telefone______TabConfEmpresa__Phone_No__; 'Nº Telefone: ' + TabConfEmpresa."Phone No.")
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
            column(TabConfEmpresa_Address; TabConfEmpresa.Address)
            {
            }
            column(USERID; UserId)
            {
            }
            column(TabConfEmpresa__Name_2_; TabConfEmpresa."Name 2")
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(TabConfEmpresa_Name; TabConfEmpresa.Name)
            {
            }
            column("Formação___________FormacaoFilter"; 'Formação' + ': ' + FormacaoFilter)
            {
            }
            column(Employee_FullName; Employee.FullName)
            {
            }
            column("Formação_Empregado__Formação_Empregado___No__Empregado_"; "Formação Empregado"."No. Empregado")
            {
            }
            column("Formação_Empregado__Formação_Empregado___Entidade_Prestadora_"; "Formação Empregado"."Entidade Prestadora")
            {
            }
            column("Formação_Empregado__Formação_Empregado__Avaliação"; "Formação Empregado".Avaliação)
            {
            }
            column("Formação_Empregado__Formação_Empregado___No__Horas_Acção_"; "Formação Empregado"."No. Horas Acção")
            {
            }
            column("Formação_Empregado__Formação_Empregado___Cód__Acção_"; "Formação Empregado"."Cód. Acção")
            {
            }
            column("Formação_Empregado__Formação_Empregado___Data_Fim_"; "Formação Empregado"."Data Fim")
            {
            }
            column("Formação_Empregado__Formação_Empregado___Data_Início_"; "Formação Empregado"."Data Início")
            {
            }
            column("Formação_Empregado__Formação_Empregado__Tipo"; "Formação Empregado".Tipo)
            {
            }
            column(Total; Total)
            {
            }
            column("FORMAÇÃO_POR_EMPREGADOCaption"; FORMAÇÃO_POR_EMPREGADOCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Entidade_FormadoraCaption; Entidade_FormadoraCaptionLbl)
            {
            }
            column("AvaliaçãoCaption"; AvaliaçãoCaptionLbl)
            {
            }
            column(N__HorasCaption; N__HorasCaptionLbl)
            {
            }
            column("DescriçãoCaption"; DescriçãoCaptionLbl)
            {
            }
            column("Código_AcçãoCaption"; Código_AcçãoCaptionLbl)
            {
            }
            column(Data_FimCaption; Data_FimCaptionLbl)
            {
            }
            column("Data_InícioCaption"; Data_InícioCaptionLbl)
            {
            }
            column(TipoCaption; TipoCaptionLbl)
            {
            }
            column(Total_Horas_Caption; Total_Horas_CaptionLbl)
            {
            }
            column(Descricao; AccaoFormacao.Descrição)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if AccaoFormacao.Get("Cód. Acção") then;

                Employee.Get("Formação Empregado"."No. Empregado");
                Total := Total + "Formação Empregado"."No. Horas Acção";
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Formação Empregado"."No. Empregado");
                //TODO: Check is Total has right value
                // CurrReport.CreateTotals(Total);
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
        FormacaoFilter := "Formação Empregado".GetFilters;
        TabConfEmpresa.Get;
        TabConfEmpresa.CalcFields(TabConfEmpresa.Picture);
    end;

    var
        Employee: Record Empregado;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        FormacaoFilter: Text[250];
        TabConfEmpresa: Record "Company Information";
        Total: Decimal;
        AccaoFormacao: Record "Acções Formação";
        Descricao: Text[100];
        "FORMAÇÃO_POR_EMPREGADOCaptionLbl": Label 'FORMAÇÃO POR EMPREGADO';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Entidade_FormadoraCaptionLbl: Label 'Entidade Formadora';
        "AvaliaçãoCaptionLbl": Label 'Avaliação';
        N__HorasCaptionLbl: Label 'Nº Horas';
        "DescriçãoCaptionLbl": Label 'Descrição';
        "Código_AcçãoCaptionLbl": Label 'Código Acção';
        Data_FimCaptionLbl: Label 'Data Fim';
        "Data_InícioCaptionLbl": Label 'Data Início';
        TipoCaptionLbl: Label 'Tipo';
        Total_Horas_CaptionLbl: Label 'Total Horas:';
}

