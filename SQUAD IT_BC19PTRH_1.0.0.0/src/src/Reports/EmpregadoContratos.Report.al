report 53099 "Empregado - Contratos"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\EmpregadoContratos.rdl';
    Caption = 'Employee - Contracts';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Contrato Trabalho"; "Contrato Trabalho")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
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
            column(TabConfEmpresa_City; TabConfEmpresa.City)
            {
            }
            column(N__Telefone______TabConfEmpresa__Phone_No__; 'Nº Telefone: ' + TabConfEmpresa."Phone No.")
            {
            }
            column(TabConfEmpresa__Post_Code_; TabConfEmpresa."Post Code")
            {
            }
            column(N__Contribuinte______TabConfEmpresa__VAT_Registration_No__; 'Nº Contribuinte: ' + TabConfEmpresa."VAT Registration No.")
            {
            }
            column(TabConfEmpresa_Picture; TabConfEmpresa.Picture)
            {
            }
            column(Contrato_Trabalho__Contrato_Trabalho__Description; "Contrato Trabalho".Description)
            {
            }
            column(Contrato_Trabalho__Contrato_Trabalho__Code; "Contrato Trabalho".Code)
            {
            }
            column(Contrato_Trabalho__Tipo_Contrato_; "Tipo Contrato")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(CONTRATOS_DOS_EMPREGADOSCaption; CONTRATOS_DOS_EMPREGADOSCaptionLbl)
            {
            }
            column("Código_Caption"; Código_CaptionLbl)
            {
            }
            column(Tipo_Contrato_Caption; Tipo_Contrato_CaptionLbl)
            {
            }
            dataitem("Contrato Empregado"; "Contrato Empregado")
            {
                DataItemLink = "Cód. Contrato" = FIELD(Code);
                DataItemTableView = SORTING("Tipo Contrato", "Data Fim Contrato");
                RequestFilterFields = "Data Fim Contrato";
                column("Contrato_Empregado__Cód__Empregado_"; "Cód. Empregado")
                {
                }
                column(Contrato_Empregado__Data_Inicio_Contrato_; "Data Inicio Contrato")
                {
                }
                column(Contrato_Empregado__Data_Fim_Contrato_; "Data Fim Contrato")
                {
                }
                column(Nome; Nome)
                {
                }
                column("Contrato_Empregado__Cód__Empregado_Caption"; FieldCaption("Cód. Empregado"))
                {
                }
                column(Data_InicioCaption; Data_InicioCaptionLbl)
                {
                }
                column(Data_FimCaption; Data_FimCaptionLbl)
                {
                }
                column(NomeCaption; NomeCaptionLbl)
                {
                }
                column("Contrato_Empregado_Cód__Contrato"; "Cód. Contrato")
                {
                }
                column(Contrato_Empregado_No__Linha; "No. Linha")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TabEmpregado.Reset;
                    if TabEmpregado.Get("Contrato Empregado"."Cód. Empregado") then
                        Nome := TabEmpregado.Name
                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FieldNo("Contrato Empregado"."Cód. Contrato");
                end;
            }
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
        EmploymentContractFilter := "Contrato Empregado".GetFilters;
        TabConfEmpresa.Get;
        TabConfEmpresa.CalcFields(TabConfEmpresa.Picture);
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        EmploymentContractFilter: Text[250];
        TabConfEmpresa: Record "Company Information";
        Nome: Text[250];
        TabEmpregado: Record Empregado;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        CONTRATOS_DOS_EMPREGADOSCaptionLbl: Label 'CONTRATOS DOS EMPREGADOS';
        "Código_CaptionLbl": Label 'Código:';
        Tipo_Contrato_CaptionLbl: Label 'Tipo Contrato:';
        Data_InicioCaptionLbl: Label 'Data Inicio';
        Data_FimCaptionLbl: Label 'Data Fim';
        NomeCaptionLbl: Label 'Nome';
}

