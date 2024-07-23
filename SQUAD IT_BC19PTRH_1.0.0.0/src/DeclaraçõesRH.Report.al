report 53094 "Declarações RH"
{
    //ProcessingOnly = true;
    //UsageCategory = Tasks;
    ApplicationArea = HumanResourcesAppArea;
    UsageCategory = ReportsAndAnalysis;

    DefaultLayout = Word;
    //WordLayout = 

    dataset
    {
        dataitem(Empregado; Employee)
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                //FIXME: Template layout needed to be created diferently
                //PATH
                //wdTemplate.
                if rTemplates.Get('DECRH') then;
                rTemplates.CalcFields(Attachment);

                //varTempBLOB.Reset;
                //varTempBLOB.Blob := rTemplates.Attachment;

                //JTP - Migration to AL
                //path := FILEMGT.BLOBExport(varTempBLOB, Empregado."No." + '.' + rTemplates."File Extension", true);
                path := rTemplates.Attachment.Export(Empregado."No." + '.' + rTemplates."File Extension");


                Clear(VencimentoBase);

                //wdApp := wdApp.ApplicationClass();
                //Create(wdApp, false, true);
                //wdAppAL.
                wdApp.Visible(true);
                wdApp.Documents.Open2002(path);

                //CABEÇALHO
                EscreveWord('«nomeempresa1»', rCompanyInformation.Name);

                if rCompanyInformation."Name 2" <> '' then
                    EscreveWord('«nomeempresa2»', rCompanyInformation."Name 2")
                else begin
                    varPesquisa := '«nomeempresa2»';
                    wdfindas := 0;
                    wdreplaceon := 1; //para não substituir
                    wdApp.Selection.Find.Execute(varPesquisa, fals, fals, fals, fals, fals, tru, wdfindas, fals, varPesquisa, wdreplaceon);
                    varx := 1;
                    varz := 2;
                    wdApp.Selection.Delete(varx, varz);
                end;

                EscreveWord('«endereço1»', rCompanyInformation.Address);

                if rCompanyInformation."Address 2" <> '' then
                    EscreveWord('«endereço2»', rCompanyInformation."Address 2")
                else begin
                    varPesquisa := '«endereço2»';
                    wdfindas := 0;
                    wdreplaceon := 1; //para não substituir
                    wdApp.Selection.Find.Execute(varPesquisa, fals, fals, fals, fals, fals, tru, wdfindas, fals, varPesquisa, wdreplaceon);
                    varx := 1;
                    varz := 2;
                    wdApp.Selection.Delete(varx, varz);
                end;

                EscreveWord('«cod.postal»', rCompanyInformation."Post Code");
                EscreveWord('«cidade»', rCompanyInformation.City);
                EscreveWord('«telefone»', rCompanyInformation."Phone No.");

                if rCompanyInformation."Fax No." <> '' then
                    EscreveWord('«fax»', rCompanyInformation."Fax No.")
                else begin
                    varPesquisa := '«fax»';
                    wdfindas := 0;
                    wdreplaceon := 1; //para não substituir
                    wdApp.Selection.Find.Execute(varPesquisa, fals, fals, fals, fals, fals, tru, wdfindas, fals, varSubs, wdreplaceon);
                end;

                EscreveWord('«NIF»', rCompanyInformation."VAT Registration No.");

                //TEXTO
                EscreveWord('«nome»', Empregado.Name);
                EscreveWord('«tipo doc»', Format(Empregado."Documento Identificação"));
                EscreveWord('«nº doc. Identificação»', Empregado."No. Doc. Identificação");
                EscreveWord('«local emissão»', Empregado."Local Emissão Doc. Ident.");

                if Empregado.Vitalício = true then
                    EscreveWord('«data validade»', 'vitalício')
                else
                    EscreveWord('«data validade»', Format(Empregado."Data Validade Doc. Ident."));

                EscreveWord('«nome empresa»', rCompanyInformation.Name);
                EscreveWord('«data admissão»', Format(Empregado."Employment Date"));

                Empregado.CalcFields(Empregado."Emplymt. Contract Code");

                Contratos.Reset;
                if Contratos.Get(Empregado."Emplymt. Contract Code") then
                    EscreveWord('«tipo contrato»', Format(Contratos."Tipo Contrato"));
                TabRubricaSalEmpregado.Reset;
                TabRubricaSalEmpregado.SetRange(TabRubricaSalEmpregado."No. Empregado", Empregado."No.");
                TabRubricaSalEmpregado.SetFilter(TabRubricaSalEmpregado."Data Início", '<=%1', Today);
                TabRubricaSalEmpregado.SetFilter(TabRubricaSalEmpregado."Data Fim", '>%1|=%2', Today, 0D);
                if TabRubricaSalEmpregado.FindSet then begin
                    repeat
                        if (TabRubrica.Get(TabRubricaSalEmpregado."Cód. Rúbrica Salarial")) and
                          (TabRubrica.Genero = TabRubrica.Genero::"Vencimento Base") then begin
                            VencimentoBase := VencimentoBase + TabRubricaSalEmpregado."Valor Total";
                        end;
                    until TabRubricaSalEmpregado.Next = 0;
                end;

                EscreveWord('«vencimento base»', Format(VencimentoBase));
                EscreveWord('«localidade»', rCompanyInformation.City);
                EscreveWord('«data»', Format(Today, 0, '<day> de <month text> de <year4>'));
                EscreveWord('«nome da pessoa assina»', NomePessoaAssina);
                EscreveWord('«cargo»', cargo);
            end;

            trigger OnPreDataItem()
            begin
                if rCompanyInformation.Get then;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(NomePessoaAssina; NomePessoaAssina)
                {
                    ApplicationArea = All;
                    Caption = 'Nome da Pessoa que assina';
                }
                field(cargo; cargo)
                {
                    ApplicationArea = All;
                    Caption = 'Cargo';
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

    trigger OnPreReport()
    begin
        fals := false;
        tru := true;

        //coordenadas da foto
        xPos := 45;
        yPos := 45;
        //width:= 78;
        //heigth:= 78;
    end;

    var
        rTemplates: Record "Importação Templates";
        wdfindas: Integer;
        wdreplaceon: Integer;
        path: Text[1024];
        text1: Text[250];
        text2: Text[250];
        fals: Boolean;
        tru: Boolean;
        rCompanyInformation: Record "Company Information";
        xPos: Integer;
        yPos: Integer;
        width: Integer;
        heigth: Integer;
        pathPicture: Text[1024];
        Contratos: Record "Contrato Trabalho";
        TabRubricaSalEmpregado: Record "Rubrica Salarial Empregado";
        NomePessoaAssina: Text[75];
        cargo: Text[50];
        varx: Integer;
        varz: Integer;
        varPesquisa: Text[30];
        varSubs: Text[30];
        TabRubrica: Record "Rubrica Salarial";
        VencimentoBase: Decimal;
        wdApp: DotNet WordApplicationClass;
        //environment: DotNet BCTestEnvironment;
        //CGA SQD commented dotnet
        //varTempBLOB: Record TempBlob;
        varTempBLOB: Codeunit "Temp Blob";
        FILEMGT: Codeunit "File Management";
        wdTemplate: Codeunit "Word Template";


    procedure EscreveWord(pText1: Text[1024]; pText2: Text[1024])
    begin
        wdfindas := 0;
        wdreplaceon := 2;
        wdApp.Width := 7;
        wdApp.Selection.Find.Execute(pText1, fals, fals, fals, fals, fals, tru, wdfindas, fals, pText2, wdreplaceon);
    end;
}

