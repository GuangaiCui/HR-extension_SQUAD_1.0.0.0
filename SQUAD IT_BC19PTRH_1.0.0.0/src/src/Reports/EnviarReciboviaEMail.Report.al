report 53100 "Enviar Recibo via EMail"
{
    // #001 SQD RTV 20200428
    //   Changed email body text;
    //     New text constants "Text50000" and "Text 50001"
    //    Changed email usage from Outlook to SMTP

    UsageCategory = Tasks;
    ApplicationArea = HumanResourcesAppArea;

    Permissions = TableData "Hist. Cab. Movs. Empregado" = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Periodos Processamento"; "Periodos Processamento")
        {
            DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento") WHERE("Tipo Processamento" = FILTER(<> Encargos));
            dataitem("Hist. Cab. Movs. Empregado"; "Hist. Cab. Movs. Empregado")
            {
                DataItemLink = "Cód. Processamento" = FIELD("Cód. Processamento");
                DataItemTableView = SORTING("Cód. Processamento", "Tipo Processamento", "No. Empregado") WHERE("Tipo Processamento" = FILTER(<> Encargos));
                RequestFilterFields = "No. Empregado";

                trigger OnAfterGetRecord()
                begin
                    Clear(Mail);

                    //Testar se já foi enviado o Recibo para este empregado
                    //*******************************************************************
                    if "Hist. Cab. Movs. Empregado"."Recibo enviado via E-Mail" then
                        if not Confirm(Text0004, false, "Hist. Cab. Movs. Empregado"."Cód. Processamento", "Hist. Cab. Movs. Empregado"."No. Empregado") then
                            CurrReport.Skip;

                    //Só apanhar os empregados que têm o pisco no Envio Recibo via E-Mail
                    //*******************************************************************
                    Empregado.Reset;
                    Empregado.SetRange(Empregado."No.", "Hist. Cab. Movs. Empregado"."No. Empregado");
                    if Empregado.FindFirst then
                        if (EnviarTodos) and (not Empregado."Envio Recibo via E-Mail") then
                            CurrReport.Skip;

                    if not Empregado."Envio Recibo via E-Mail" then begin
                        Message(Text0003, Empregado."No.");
                        CurrReport.Skip;
                    end;

                    //Saber o endereço de envio
                    //*************************
                    if Empregado."Endereço de Envio" = Empregado."Endereço de Envio"::Empresa then
                        EnderecoEmail := Empregado."Company E-Mail"
                    else
                        EnderecoEmail := Empregado."E-Mail";

                    if EnderecoEmail = '' then begin
                        Message(Text0005, "Hist. Cab. Movs. Empregado"."Cód. Processamento", "Hist. Cab. Movs. Empregado"."No. Empregado");
                        CurrReport.Skip;
                    end else
                        ValidaEmail(EnderecoEmail);

                    FileName := Text0009 + ' ' + Format("Hist. Cab. Movs. Empregado"."Cód. Processamento") +
                                 '_' + Format("Hist. Cab. Movs. Empregado"."No. Empregado") + '.pdf';


                    // REPORT A IMPRIMIR, DIRECTORIO E NOME DO FICHEIRO
                    //*************************************************
                    //Correr o report do Recibo
                    //********************************
                    ServerAttachmentFilePath := FileManagement.ServerTempFileName('pdf');

                    RReciboVencimentos.InitData("Periodos Processamento"."Cód. Processamento", "Hist. Cab. Movs. Empregado"."No. Empregado");
                    RReciboVencimentos.UseRequestPage(false);
                    RReciboVencimentos.SaveAsPdf(ServerAttachmentFilePath);

                    Clear(RReciboVencimentos);

                    //#001 START SQD RTV 20200429
                    //Deixou de ser necessário, no entanto mantenho aqui
                    LineBreak := 'xx';
                    LineBreak[1] := 13;   //line feed
                    LineBreak[2] := 10;   //carriage return
                                          //#001 STOP SQD RTV 20200429

                    //OPCAO 1 -  ENVIO DO EMAIL POR SMTP
                    //********************************

                    //#001 START SQD RTV 20200429
                    //CreateMessage('','',EnderecoEmail,STRSUBSTNO(Text0006,"Hist. Cab. Movs. Empregado"."Cód. Processamento"),'',FALSE,
                    //ServerAttachmentFilePath,FileName);
                    Recipients.Add(EnderecoEmail);
                    smtpMail.CreateMessage('RH Taguspark', 'no-reply@taguspark.pt', Recipients, Text0001, StrSubstNo(Text50000, Format("Data Registo", 0, '<Month Text>'), Format(Date2DMY("Data Registo", 3)))
                    , false);
                    smtpMail.AddAttachment(ServerAttachmentFilePath, FileName);
                    smtpMail.Send;
                    //#001 STOP SQD RTV 20200429

                    //Registar o envio
                    //********************************
                    "Hist. Cab. Movs. Empregado"."Recibo enviado via E-Mail" := true;
                    "Hist. Cab. Movs. Empregado".Modify;

                    Commit;


                    //Opcao 2- ENVIO DO EMAIL POR Outlook
                    //********************************
                    /*
                    FileName := MailManagement.DownloadPdfOnClient(ServerAttachmentFilePath);
                    
                    TemporaryFolder := FileManagement.CreateClientTempSubDirectory;
                    FileNameNew := TemporaryFolder+'\'+Text0009+' '+ FORMAT("Hist. Cab. Movs. Empregado"."Cód. Processamento") +
                                 '_' + FORMAT("Hist. Cab. Movs. Empregado"."No. Empregado") + '.pdf';
                    
                    FileManagement.MoveFile(FileName,FileNameNew);
                    //#001 START SQD RTV 20200428
                    //IF Mail.NewMessage(EnderecoEmail,'','',Text0001,STRSUBSTNO(Text0006,"Hist. Cab. Movs. Empregado"."Cód. Processamento")
                                       //,FileNameNew,FALSE) = FALSE THEN
                    IF Mail.NewMessage(EnderecoEmail,'','',Text0001,STRSUBSTNO(Text50000,FORMAT("Data Registo",0,'<Month Text>'),FORMAT(DATE2DMY("Data Registo",3))) + LineBreak + Text50001
                                       ,FileNameNew,FALSE) = FALSE THEN
                       ERROR(Text0002,EnderecoEmail);
                    //#001 STOP SQD RTV 20200428
                    */

                    //Registar o envio
                    //********************************
                    "Hist. Cab. Movs. Empregado"."Recibo enviado via E-Mail" := true;
                    "Hist. Cab. Movs. Empregado".Modify;

                end;
            }

            trigger OnPostDataItem()
            begin
                Message(Text0010);
            end;

            trigger OnPreDataItem()
            begin
                SetFilter("Cód. Processamento", CodProcess);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Enviar Recibo Via Email")
                {
                    Caption = 'Enviar Recibo Via Email';
                    field(EnviarTodos; EnviarTodos)
                    {
                        ApplicationArea = All;
                        Caption = 'Enviar para todos os Empregados com a opção "Envio Recibo via E-Mail"';
                    }
                    field(CodProcess; CodProcess)
                    {
                        ApplicationArea = All;
                        Caption = 'Processamento';
                        TableRelation = "Periodos Processamento";
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

    trigger OnPreReport()
    begin
        ContMail := 0;
    end;

    var
        RReciboVencimentos: Report "Recibo Vencimentos A4";
        PeriodosProce: Record "Periodos Processamento";
        Empregado: Record Empregado;
        ReportID: Integer;
        "Object": Record "Object";
        FileDirectory: Text;
        FileName: Text;
        num: Integer;
        DefaultPrinter: Text[200];
        DefaultPrinter2: Text[200];
        EnviarTodos: Boolean;
        Mail: Codeunit Mail;
        Text0001: Label 'Recibo de Vencimentos';
        Text0002: Label 'Não foi possivel o envio do ficheiro para o endereço %1.';
        EnderecoEmail: Text;
        Text0003: Label 'O Empregado %1, não pretende receber o Recibo via E-Mail.';
        Text0004: Label 'O recibo referente ao processamento %1 do Empregado %2 já foi enviado anteriormente.\Confirma que deseja enviar novamente?';
        Text0005: Label 'O recibo referente ao processamento %1 do Empregado %2 não pode ser enviado porque não existe Endereço de Email configurado.\Proceda à sua configuração e volte a enviar.';
        Text0006: Label 'Segue em anexo o PDF do Recibo de Vencimentos referente ao processamento %1.';
        ProgressWindow: Dialog;
        TimeProgress: Time;
        FileMgt: Codeunit "File Management";
        environment: DotNet BCTestEnvironment;
        FuncoesRH: Codeunit "Funções RH";
        CodProcess: Code[10];
        FileManagement: Codeunit "File Management";
        ServerAttachmentFilePath: Text;
        SMTPFields: Record "SMTP Mail Setup";
        varMail: DotNet BCTestSmtpMessage;
        Text0007: Label 'The SMTP mail system returned the following error: %1';
        Text0008: Label 'The email address "%1" is invalid.';
        Text0009: Label 'Receipt';
        Text0010: Label 'Processed Completed.';
        ContMail: Integer;
        MailManagement: Codeunit "Mail Management";
        TemporaryFolder: Text;
        FileNameNew: Text;
        Text50000: Label 'Junto anexo recibo de vencimento referente ao mês de %1 de %2.';
        Text50001: Label 'Se necessitar de qualquer esclarecimento, entre, por favor, em contacto através do endereço de e-mail: rh@taguspark.pt';
        LineBreak: Text;
        smtpMail: Codeunit "SMTP Mail";
        Recipients: List of [Text];


    procedure ValidaEmail(EmailAddress: Text[80])
    var
        i: Integer;
        NoOfAtSigns: Integer;
        Text0008: Label 'O Endereço de email "%1" é inválido.';
    begin
        if EmailAddress = '' then
            Error(Text0008, EmailAddress);

        if (EmailAddress[1] = '@') or (EmailAddress[StrLen(EmailAddress)] = '@') then
            Error(Text0008, EmailAddress);

        for i := 1 to StrLen(EmailAddress) do begin
            if EmailAddress[i] = '@' then
                NoOfAtSigns := NoOfAtSigns + 1;
            if not (
              ((EmailAddress[i] >= 'a') and (EmailAddress[i] <= 'z')) or
              ((EmailAddress[i] >= 'A') and (EmailAddress[i] <= 'Z')) or
              ((EmailAddress[i] >= '0') and (EmailAddress[i] <= '9')) or
              (EmailAddress[i] in ['@', '.', '-', '_']))
            then
                Error(Text0008, EmailAddress);
        end;

        if NoOfAtSigns <> 1 then
            Error(Text0008, EmailAddress);
    end;


    procedure CreateMessage(SenderName: Text[100]; SenderAddress: Text[50]; Recipients: Text[1024]; Subject: Text[200]; Body: Text[1024]; HtmlFormatted: Boolean; FileN: Text[260]; FileDir: Text[260])
    var
        char10: Char;
        char13: Char;
    begin
        SMTPFields.Get;
        SMTPFields.TestField("SMTP Server");

        if not IsNull(varMail) then begin
            varMail.Dispose;
            Clear(varMail);
        end;

        varMail := varMail.SmtpMessage;

        varMail.FromAddress := SMTPFields."User ID";
        varMail."To" := Recipients;
        varMail.CC := SMTPFields."User ID";
        varMail.Subject := Subject;
        varMail.Body := Body;
        varMail.HtmlFormatted := HtmlFormatted;
        varMail.AddAttachmentWithName(FileN, FileDir);
        varMail.Timeout(50000);

        Send;
    end;

    local procedure CheckValidEmailAddresses(Recipients: Text[1024])
    var
        s: Text[1024];
    begin
        if Recipients = '' then
            Error(Text0008, Recipients);

        s := Recipients;
        while StrPos(s, ';') > 1 do begin
            CheckValidEmailAddress(CopyStr(s, 1, StrPos(s, ';') - 1));
            s := CopyStr(s, StrPos(s, ';') + 1);
        end;
        CheckValidEmailAddress(s);
    end;


    procedure Send()
    var
        Result: Text[1024];
    begin
        Result := '';
        Result :=
              varMail.Send(
                SMTPFields."SMTP Server",
                SMTPFields."SMTP Server Port",
                SMTPFields.Authentication <> SMTPFields.Authentication::Anonymous,
                SMTPFields."User ID",
                SMTPFields."Password Key",
                SMTPFields."Secure Connection");

        varMail.Dispose;
        Clear(varMail);
        if Result <> '' then
            Error(Text0007, Result);
    end;

    local procedure CheckValidEmailAddress(EmailAddress: Text[250])
    var
        i: Integer;
        NoOfAtSigns: Integer;
    begin
        if EmailAddress = '' then
            Error(Text0008, EmailAddress);

        if (EmailAddress[1] = '@') or (EmailAddress[StrLen(EmailAddress)] = '@') then
            Error(Text0008, EmailAddress);

        for i := 1 to StrLen(EmailAddress) do begin
            if EmailAddress[i] = '@' then
                NoOfAtSigns := NoOfAtSigns + 1;
            if not (
              ((EmailAddress[i] >= 'a') and (EmailAddress[i] <= 'z')) or
              ((EmailAddress[i] >= 'A') and (EmailAddress[i] <= 'Z')) or
              ((EmailAddress[i] >= '0') and (EmailAddress[i] <= '9')) or
              (EmailAddress[i] in ['@', '.', '-', '_']))
            then
                Error(Text0008, EmailAddress);
        end;

        if NoOfAtSigns <> 1 then
            Error(Text0008, EmailAddress);
    end;
}

