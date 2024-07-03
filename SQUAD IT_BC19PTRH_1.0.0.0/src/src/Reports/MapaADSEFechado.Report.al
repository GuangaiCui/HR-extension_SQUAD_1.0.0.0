report 31003103 "Mapa ADSE - Fechado"
{
    // //-------------------------------------------------------
    //               Listagem ADSE
    // //--------------------------------------------------------
    //   Listagem dos empregados que nesse período de processamento
    //   estiveram sujeitos a retenção para a ADSE
    // //-------------------------------------------------------
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/MapaADSEFechado.rdlc';

    PreviewMode = PrintLayout;
    ProcessingOnly = false;
    UseRequestPage = true;

    dataset
    {
        dataitem("Periodos Processamento"; "Periodos Processamento")
        {
            DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento");
        }
        dataitem("Company Information"; "Company Information")
        {
            DataItemTableView = SORTING("Primary Key") ORDER(Ascending);
            column(Name_Cinfo; Name)
            {
            }
            column(Name2_Cinfo; "Name 2")
            {
            }
            column(Address_Cinfo; Address)
            {
            }
            column(Post_Code_Cinfo; "Post Code")
            {
            }
            column(City_Cinfo; City)
            {
            }
            column(Phone_No_Cinfo; "Phone No.")
            {
            }
            column(VATRegistrationNo_Cinfo; "VAT Registration No.")
            {
            }
            column(Date_Formated; Format(Today, 0, 4))
            {
            }
            column(UserID; UserId)
            {
            }
            column(Filtro; Filtro)
            {
            }
            column(Picture_Cinfo; Picture)
            {
            }
        }
        dataitem(Empregado; Empregado)
        {
            DataItemTableView = SORTING("No.");
            dataitem("Hist. Linhas Movs. Empregado"; "Hist. Linhas Movs. Empregado")
            {
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado", "No. Linha") WHERE("Tipo Processamento" = FILTER(Vencimentos | SubNatal | SubFerias));
                column(NumEmp; "Hist. Linhas Movs. Empregado"."No. Empregado")
                {
                }
                column(NomeEmp; Empregado.Name)
                {
                }
                column(NumADSE; Empregado."Nº ADSE")
                {
                }
                column(Valor; Abs("Hist. Linhas Movs. Empregado".Valor))
                {
                }

                trigger OnAfterGetRecord()
                var
                    encontrou: Boolean;
                begin
                    TabRubrica.Reset;
                    if TabRubrica.Get("Hist. Linhas Movs. Empregado"."Cód. Rubrica") then begin
                        if not (TabRubrica.Genero = TabRubrica.Genero::ADSE) then begin
                            CurrReport.Skip
                        end;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    //Filtro de Data
                    if CodProcess <> '' then
                        "Hist. Linhas Movs. Empregado".SetRange("Hist. Linhas Movs. Empregado"."Cód. Processamento", CodProcess)
                    else
                        "Hist. Linhas Movs. Empregado".SetRange("Hist. Linhas Movs. Empregado"."Data Registo", DataIni, DataFim);
                end;
            }

            trigger OnAfterGetRecord()
            var
                TabHistAboDesExtra: Record "Histórico Abonos - Desc. Extra";
                TempTabHistAboDesExtra: Record "Histórico Abonos - Desc. Extra" temporary;
                Encontrou: Boolean;
            begin
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Mapa ADSE")
                {
                    Caption = 'Mapa ADSE';
                    field(CodProcess; CodProcess)
                    {
                        ApplicationArea = All;
                        Caption = 'Cod. Processamento';
                        TableRelation = "Periodos Processamento";
                    }
                    field(DataIni; DataIni)
                    {
                        ApplicationArea = All;
                        Caption = 'Data Inicio';
                    }
                    field(DataFim; DataFim)
                    {
                        ApplicationArea = All;
                        Caption = 'Data Fim';
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
        PageLbl = 'Page';
        MapName = 'Mapa da Caixa Geral de Aposentações';
        CodProcessLbl = 'Code';
        NumEmpLbl = 'CGA No.';
        NomeLbl = 'Name';
        NumADSELbl = 'Emp.';
        ValorLbl = 'Valor da Dedução';
        ProcByPCLbl = 'Processed by Computer';
        PhoneLbl = 'Phone No.';
        VatRegNoLbl = 'Vat Registration No.';
        TotalLbl = 'Total:';
    }

    trigger OnPreReport()

    begin
        InfEmpresa.Get;
        //Filtro de Data
        if CodProcess <> '' then
            Filtro := CodProcess
        else
            Filtro := Format(DataIni) + ' - ' + Format(DataFim);
    end;

    var
        DataIni: Date;
        DataFim: Date;
        InfEmpresa: Record "Company Information";
        TabRubrica: Record "Rubrica Salarial";
        CodProcess: Code[10];
        Filtro: Text[30];
}

