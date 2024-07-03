codeunit 53038 "WordManagement HR"
{

    trigger OnRun()
    begin
    end;

    var
        Text003: Label 'Merging Microsoft Word Documents...\\';
        Text004: Label 'Preparing';
        Text005: Label 'Program status';
        Text006: Label 'Preparing Merge...';
        Text007: Label 'Waiting for print job...';
        Text008: Label 'Transferring %1 data to Microsoft Word...';
        Text009: Label 'Sending individual email messages...';
        Text010: Label '%1 %2 must have %3 DOC or DOCX.', Comment = 'Attachment No. must have File Extension DOC or DOCX.';
        Text011: Label 'Attachment file error';
        Text012: Label 'Creating merge source...';
        Text013: Label 'Microsoft Word is opening merge source...';
        Text014: Label 'Merging %1 in Microsoft Word...';
        Text015: Label 'FaxMailTo';
        Text017: Label 'The merge source file is locked by another process.\';
        Text018: Label 'Please try again later.';
        Text019: Label ' Mail Address';
        Text020: Label 'Document ';
        Text021: Label 'Import attachment ';
        Text022: Label 'Delete %1?';
        Text023: Label 'Another user has modified the record for this %1\after you retrieved it from the database.\\Enter the changes again in the updated document.';
        FileMgt: Codeunit "File Management";
        AttachmentManagement: Codeunit AttachmentManagement;
        [RunOnClient]
        WordHelper: DotNet BCTestWordHelper;
        Window: Dialog;
        Text030: Label 'Formal Salutation';
        Text031: Label 'Informal Salutation';
        MergeSourceBufferFileName: Text;
        MergeSourceBufferFile: File;
        Text032: Label '*.htm|*.htm';


    procedure CreateWordAttachment(WordCaption: Text[260]; LanguageCode: Code[10]) NewAttachNo: Code[10]
    var
        Attachment: Record "Importação Templates";
        [RunOnClient]
        WordApplication: DotNet WordApplicationClass;
        [RunOnClient]
        WordDocument: DotNet WordDocument;
        [RunOnClient]
        WordMergefile: DotNet BCTestMergeHandler;
        FileName: Text;
        MergeFileName: Text;
        ParamInt: Integer;
    begin
        WordMergefile := WordMergefile.MergeHandler;

        MergeFileName := FileMgt.ClientTempFileName('HTM');
        CreateHeader(WordMergefile, true, MergeFileName, LanguageCode); // Header without data

        WordApplication := WordApplication.ApplicationClass;
        Attachment."File Extension" := GetWordDocumentExtension(WordApplication.Version);
        WordDocument := WordHelper.AddDocument(WordApplication);
        WordDocument.MailMerge.MainDocumentType := 0; // 0 = wdFormLetters
        ParamInt := 7; // 7 = HTML
        WordHelper.CallMailMergeOpenDataSource(WordDocument, MergeFileName, ParamInt);

        FileName := Attachment.ConstFilename;
        WordHelper.CallSaveAs(WordDocument, FileName);
        if WordHandler(WordDocument, Attachment, WordCaption, false, FileName, false) then
            NewAttachNo := Attachment."No."
        else
            NewAttachNo := '0';

        Clear(WordMergefile);
        Clear(WordDocument);
        WordHelper.CallQuit(WordApplication, false);
        Clear(WordApplication);

        DeleteFile(MergeFileName);
    end;


    procedure OpenWordAttachment(var Attachment: Record "Importação Templates"; FileName: Text; Caption: Text[260]; IsTemporary: Boolean; LanguageCode: Code[10])
    var
        [RunOnClient]
        WordApplication: DotNet WordApplicationClass;
        [RunOnClient]
        WordDocument: DotNet WordDocument;
        [RunOnClient]
        WordMergefile: DotNet BCTestMergeHandler;
        MergeFileName: Text;
        ParamInt: Integer;
    begin
        WordMergefile := WordMergefile.MergeHandler;
        MergeFileName := FileMgt.ClientTempFileName('HTM');
        CreateHeader(WordMergefile, true, MergeFileName, LanguageCode);
        WordApplication := WordApplication.ApplicationClass;
        WordDocument := WordHelper.CallOpen(WordApplication, FileName, false, Attachment."Read Only");
        // Handle Word documents without mergefields
        if DocumentContainMergefields(Attachment) then
            if IsNull(WordDocument.MailMerge.MainDocumentType) then begin
                WordDocument.MailMerge.MainDocumentType := 0; // 0 = wdFormLetters
                WordHelper.CallMailMergeOpenDataSource(WordDocument, MergeFileName, ParamInt);
            end;
        if WordDocument.MailMerge.Fields.Count > 0 then begin
            ParamInt := 7; // 7 = HTML
            WordHelper.CallMailMergeOpenDataSource(WordDocument, MergeFileName, ParamInt);
        end;

        WordHandler(WordDocument, Attachment, Caption, IsTemporary, FileName, false);
        Clear(WordMergefile);
        Clear(WordDocument);
        WordHelper.CallQuit(WordApplication, false);
        Clear(WordApplication);
        DeleteFile(MergeFileName);
    end;


    procedure Merge(var TempDeliverySorter: Record "Delivery Sorter" temporary)
    var
        TempDeliverySorter2: Record "Delivery Sorter" temporary;
        [RunOnClient]
        WordApplication: DotNet WordApplicationClass;
        LastAttachmentNo: Integer;
        LastCorrType: Integer;
        LastSubject: Text[50];
        LastSendWordDocsAsAttmt: Boolean;
        LineCount: Integer;
        NoOfRecords: Integer;
        WordHided: Boolean;
        Param: Boolean;
        FirstRecord: Boolean;
    begin
        Window.Open(
          Text003 +
          '#1############ @2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\' +
          '#3############ @4@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\\' +
          '#5############ #6################################');

        Window.Update(1, Text004);
        Window.Update(5, Text005);

        Window.Update(6, Text006);
        TempDeliverySorter.SetCurrentKey(
          "Attachment No.", "Correspondence Type", Subject, "Send Word Docs. as Attmt.");
        TempDeliverySorter.SetFilter("Correspondence Type", '<>0');
        NoOfRecords := TempDeliverySorter.Count;
        TempDeliverySorter.Find('-');

        WordApplication := WordApplication.ApplicationClass;
        if WordApplication.Documents.Count > 0 then begin
            WordApplication.Visible := false;
            WordHided := true;
        end;

        FirstRecord := true;
        repeat
            LineCount := LineCount + 1;
            Window.Update(2, Round(LineCount / NoOfRecords * 10000, 1));
            Window.Update(3, StrSubstNo('%1', TempDeliverySorter."Correspondence Type"));

            if not FirstRecord and
               ((TempDeliverySorter."Attachment No." <> LastAttachmentNo) or
                (TempDeliverySorter."Correspondence Type" <> LastCorrType) or
                (TempDeliverySorter.Subject <> LastSubject) or
                (TempDeliverySorter."Send Word Docs. as Attmt." <> LastSendWordDocsAsAttmt))
            then begin
                ExecuteMerge(WordApplication, TempDeliverySorter2);
                TempDeliverySorter2.DeleteAll;
                if TempDeliverySorter."Attachment No." <> LastAttachmentNo then
                    ImportMergeSourceFile(LastAttachmentNo)
            end;

            TempDeliverySorter2 := TempDeliverySorter;
            TempDeliverySorter2.Insert;
            LastAttachmentNo := TempDeliverySorter."Attachment No.";
            LastCorrType := TempDeliverySorter."Correspondence Type";
            LastSubject := TempDeliverySorter.Subject;
            LastSendWordDocsAsAttmt := TempDeliverySorter."Send Word Docs. as Attmt.";

            FirstRecord := false;
        until TempDeliverySorter.Next = 0;

        if TempDeliverySorter2.Find('-') then begin
            ExecuteMerge(WordApplication, TempDeliverySorter2);
            ImportMergeSourceFile(TempDeliverySorter2."Attachment No.")
        end;

        if WordHided then
            WordApplication.Visible := true
        else begin
            // Wait for print job to finish
            if WordApplication.BackgroundPrintingStatus <> 0 then
                repeat
                    Window.Update(6, Text007);
                    Sleep(500);
                until WordApplication.BackgroundPrintingStatus = 0;

            Param := false;
            WordHelper.CallQuit(WordApplication, Param);
        end;

        Clear(WordApplication);
        Window.Close;
    end;

    local procedure ExecuteMerge(var WordApplication: DotNet WordApplicationClass; var TempDeliverySorter: Record "Delivery Sorter" temporary)
    var
        Attachment: Record "Importação Templates";
        InteractLogEntry: Record "Interaction Log Entry";
        TempSegLine: Record "Segment Line" temporary;
        [RunOnClient]
        WordDocument: DotNet WordDocument;
        [RunOnClient]
        WordInlineShape: DotNet BCTestInlineShape;
        [RunOnClient]
        WordMergefile: DotNet BCTestMergeHandler;
        [RunOnClient]
        WordOLEFormat: DotNet BCTestOLEFormat;
        [RunOnClient]
        WordLinkFormat: DotNet BCTestLinkFormat;
        MergeFile: File;
        MergeClientFileName: Text;
        MainFileName: Text;
        NoOfRecords: Integer;
        ParamBln: Boolean;
        ParamInt: Integer;
        Row: Integer;
        ShapesIndex: Integer;
        HeaderIsReady: Boolean;
        FaxMailToValue: Text;
    begin
        Window.Update(
          6, StrSubstNo(Text008,
            Format(TempDeliverySorter."Correspondence Type")));

        if TempDeliverySorter.Find('-') then
            NoOfRecords := TempDeliverySorter.Count;

        Attachment.Get(TempDeliverySorter."Attachment No.");
        // Handle Word documents without mergefields
        if not DocumentContainMergefields(Attachment) then begin
            SendAttachmentWithoutMergeFields(WordApplication, TempDeliverySorter, Attachment);
            exit;
        end;

        with TempDeliverySorter do begin
            SetCurrentKey("Attachment No.", "Correspondence Type", Subject);
            Find('-');
        end;
        Row := 2;

        MainFileName := FileMgt.ServerTempFileName('DOC');
        TempDeliverySorter.Find('-');
        Attachment.Get(TempDeliverySorter."Attachment No.");
        if not IsWordDocumentExtension(Attachment."File Extension") then
            Error(StrSubstNo(Text010, Attachment.TableCaption, Attachment."No.", Attachment.FieldCaption("File Extension")));

        if not Attachment.ExportAttachment(MainFileName) then
            Error(Text011);

        Window.Update(6, Text012);
        MergeClientFileName := FileMgt.ClientTempFileName('HTM');
        WordMergefile := WordMergefile.MergeHandler;
        CreateHeader(WordMergefile, false, MergeClientFileName, TempDeliverySorter."Language Code");
        repeat
            InteractLogEntry.Get(TempDeliverySorter."No.");
            // This field must come last in the merge source file
            case TempDeliverySorter."Correspondence Type" of
                TempDeliverySorter."Correspondence Type"::Fax:
                    FaxMailToValue := AttachmentManagement.InteractionFax(InteractLogEntry);
                TempDeliverySorter."Correspondence Type"::Email:
                    FaxMailToValue := AttachmentManagement.InteractionEMail(InteractLogEntry);
                else
                    FaxMailToValue := '';
            end;

            AddFieldsToMergeSource(WordMergefile, InteractLogEntry, TempSegLine, FaxMailToValue);
            Row := Row + 1;
            Window.Update(4, Round(Row / NoOfRecords * 10000, 1))
        until TempDeliverySorter.Next = 0;
        WordMergefile.CloseMergeFile;
        //END;

        WordDocument := WordHelper.CallOpen(WordApplication, MainFileName, false, false);
        WordDocument.MailMerge.MainDocumentType := 0;

        Window.Update(6, Text013);
        ParamInt := 7; // 7 = HTML
        WordHelper.CallMailMergeOpenDataSource(WordDocument, MergeClientFileName, ParamInt);
        Window.Update(6, StrSubstNo(Text014, TempDeliverySorter."Correspondence Type"));

        for ShapesIndex := 1 to WordDocument.InlineShapes.Count do begin
            WordInlineShape := WordHelper.GetInlineShapeItem(WordDocument, ShapesIndex);
            if not IsNull(WordInlineShape) then begin
                WordLinkFormat := WordInlineShape.LinkFormat;
                WordOLEFormat := WordInlineShape.OLEFormat;
                if not IsNull(WordOLEFormat) then
                    WordDocument.MailMerge.MailAsAttachment := WordDocument.MailMerge.MailAsAttachment or WordOLEFormat.DisplayAsIcon;
                if not IsNull(WordLinkFormat) then
                    WordLinkFormat.SavePictureWithDocument := true;
            end;
        end;

        case TempDeliverySorter."Correspondence Type" of
            TempDeliverySorter."Correspondence Type"::Fax:
                begin
                    WordDocument.MailMerge.Destination := 3;
                    WordDocument.MailMerge.MailAddressFieldName := Text015;
                    WordDocument.MailMerge.MailAsAttachment := true;
                    WordHelper.CallMailMergeExecute(WordDocument);
                end;
            TempDeliverySorter."Correspondence Type"::Email:
                begin
                    WordDocument.MailMerge.Destination := 2;
                    WordDocument.MailMerge.MailAddressFieldName := Text015;
                    WordDocument.MailMerge.MailSubject := TempDeliverySorter.Subject;
                    WordDocument.MailMerge.MailAsAttachment :=
                      WordDocument.MailMerge.MailAsAttachment or TempDeliverySorter."Send Word Docs. as Attmt.";
                    WordHelper.CallMailMergeExecute(WordDocument);
                end;
            TempDeliverySorter."Correspondence Type"::"Hard Copy":
                begin
                    WordDocument.MailMerge.Destination := 0; // 0 = wdSendToNewDocument
                    WordHelper.CallMailMergeExecute(WordDocument);
                    WordHelper.CallPrintOut(WordApplication.ActiveDocument);
                end;
        end;

        // Update delivery status on Interaction Log Entry
        if TempDeliverySorter.Find('-') then begin
            InteractLogEntry.LockTable;
            repeat
                with InteractLogEntry do begin
                    Get(TempDeliverySorter."No.");
                    "Delivery Status" := "Delivery Status"::" ";
                    Modify;
                end;
            until TempDeliverySorter.Next = 0;
            Commit;
        end;

        ParamBln := false;
        WordHelper.CallClose(WordDocument, ParamBln);
        DeleteFile(MainFileName);
        DeleteFile(MergeClientFileName);

        if not IsNull(WordLinkFormat) then
            Clear(WordLinkFormat);
        if not IsNull(WordOLEFormat) then
            Clear(WordOLEFormat);
        Clear(WordMergefile);
        Clear(WordDocument);
    end;


    procedure ShowMergedDocument(var SegLine: Record "Segment Line"; var Attachment: Record "Importação Templates"; WordCaption: Text[260]; IsTemporary: Boolean)
    var
        TempInteractLogEntry: Record "Interaction Log Entry" temporary;
        [RunOnClient]
        WordMergefile: DotNet BCTestMergeHandler;
        [RunOnClient]
        WordApplication: DotNet WordApplicationClass;
        [RunOnClient]
        WordDocument: DotNet WordDocument;
        MergeClientFileName: Text;
        MainFileName: Text;
        ParamInt: Integer;
        IsInherited: Boolean;
        MergeFile: File;
        HeaderIsReady: Boolean;
    begin
        if not IsWordDocumentExtension(Attachment."File Extension") then
            Error(StrSubstNo(Text010, Attachment.TableCaption, Attachment."No.",
                Attachment.FieldCaption("File Extension")));

        if SegLine.AttachmentInherited then
            IsInherited := true;

        MainFileName := FileMgt.ServerTempFileName('DOC');

        // Handle Word documents without mergefields
        if not DocumentContainMergefields(Attachment) then begin
            Attachment.ExportAttachment(MainFileName);
            WordApplication := WordApplication.ApplicationClass;
            WordDocument := WordHelper.CallOpen(WordApplication, MainFileName, false, Attachment."Read Only");
        end else begin
            // Merge possible
            if not Attachment.ExportAttachment(MainFileName) then
                Error(Text011);
            MergeClientFileName := FileMgt.ClientTempFileName('HTM');
            WordMergefile := WordMergefile.MergeHandler;
            CreateHeader(WordMergefile, false, MergeClientFileName, SegLine."Language Code");

            AddFieldsToMergeSource(WordMergefile, TempInteractLogEntry, SegLine, '');
            WordMergefile.CloseMergeFile;
            WordApplication := WordApplication.ApplicationClass;
            WordDocument := WordHelper.CallOpen(WordApplication, MainFileName, false, false);
            WordDocument.MailMerge.MainDocumentType := 0;
            ParamInt := 7; // 7 = HTML
            WordHelper.CallMailMergeOpenDataSource(WordDocument, MergeClientFileName, ParamInt);
            ParamInt := 9999998; // 9999998 = wdToggle
            WordDocument.MailMerge.ViewMailMergeFieldCodes(ParamInt);
        end;

        WordHandler(WordDocument, Attachment, WordCaption, IsTemporary, MainFileName, IsInherited);

        Clear(WordMergefile);
        Clear(WordDocument);
        WordHelper.CallQuit(WordApplication, false);
        Clear(WordApplication);

        DeleteFile(MergeClientFileName);
    end;


    procedure CreateHeader(var WordMergefile: DotNet BCTestMergeHandler; MergeFieldsOnly: Boolean; MergeFileName: Text; LanguageCode: Code[10])
    var
        Salesperson: Record "Salesperson/Purchaser";
        Country: Record "Country/Region";
        Contact: Record Contact;
        SegLine: Record "Segment Line";
        CompanyInfo: Record "Company Information";
        RMSetup: Record "Marketing Setup";
        InteractionLogEntry: Record "Interaction Log Entry";
        Language: Record Language;
        I: Integer;
        MainLanguage: Integer;
        CreateOk: Boolean;
    begin
        CreateOk := true;
        if not WordMergefile.CreateMergeFile(MergeFileName) then
            Error(Text017 + Text018);

        // Create HTML Header source
        with WordMergefile do begin
            MainLanguage := GlobalLanguage;
            if LanguageCode = '' then begin
                RMSetup.Get;
                if RMSetup."Mergefield Language ID" <> 0 then
                    GlobalLanguage := RMSetup."Mergefield Language ID";
            end else
                GlobalLanguage := GetLanguageID(LanguageCode);

            AddField(InteractionLogEntry.FieldCaption("Entry No."));
            AddField(Contact.TableCaption + Text019);
            AddField(Contact.TableCaption + ' ' + Contact.FieldCaption(Contact."No."));
            AddField(Contact.TableCaption + ' ' + Contact.FieldCaption("Company Name"));
            AddField(Contact.TableCaption + ' ' + Contact.FieldCaption(Name));
            AddField(Contact.TableCaption + ' ' + Contact.FieldCaption("Name 2"));
            AddField(Contact.TableCaption + ' ' + Contact.FieldCaption(Address));
            AddField(Contact.TableCaption + ' ' + Contact.FieldCaption("Address 2"));
            AddField(Contact.TableCaption + ' ' + Contact.FieldCaption("Post Code"));
            AddField(Contact.TableCaption + ' ' + Contact.FieldCaption(City));
            AddField(Contact.TableCaption + ' ' + Contact.FieldCaption(County));
            AddField(Contact.TableCaption + ' ' + Country.TableCaption + ' ' + Country.FieldCaption(Name));
            AddField(Contact.TableCaption + ' ' + Contact.FieldCaption("Job Title"));
            AddField(Contact.TableCaption + ' ' + Contact.FieldCaption("Phone No."));
            AddField(Contact.TableCaption + ' ' + Contact.FieldCaption("Fax No."));
            AddField(Contact.TableCaption + ' ' + Contact.FieldCaption("E-Mail"));
            AddField(Contact.TableCaption + ' ' + Contact.FieldCaption("Mobile Phone No."));
            AddField(Contact.TableCaption + ' ' + Contact.FieldCaption("VAT Registration No."));
            AddField(Contact.TableCaption + ' ' + Contact.FieldCaption("Home Page"));
            AddField(Text030);
            AddField(Text031);
            AddField(Salesperson.TableCaption + ' ' + Salesperson.FieldCaption(Code));
            AddField(Salesperson.TableCaption + ' ' + Salesperson.FieldCaption(Name));
            AddField(Salesperson.TableCaption + ' ' + Salesperson.FieldCaption("Job Title"));
            AddField(Salesperson.TableCaption + ' ' + Salesperson.FieldCaption("Phone No."));
            AddField(Salesperson.TableCaption + ' ' + Salesperson.FieldCaption("E-Mail"));
            AddField(Text020 + SegLine.FieldCaption(Date));
            AddField(Text020 + SegLine.FieldCaption("Campaign No."));
            AddField(Text020 + SegLine.FieldCaption("Segment No."));
            AddField(Text020 + SegLine.FieldCaption(Description));
            AddField(Text020 + SegLine.FieldCaption(Subject));
            AddField(CompanyInfo.TableCaption + ' ' + CompanyInfo.FieldCaption(Name));
            AddField(CompanyInfo.TableCaption + ' ' + CompanyInfo.FieldCaption("Name 2"));
            AddField(CompanyInfo.TableCaption + ' ' + CompanyInfo.FieldCaption(Address));
            AddField(CompanyInfo.TableCaption + ' ' + CompanyInfo.FieldCaption("Address 2"));
            AddField(CompanyInfo.TableCaption + ' ' + CompanyInfo.FieldCaption("Post Code"));
            AddField(CompanyInfo.TableCaption + ' ' + CompanyInfo.FieldCaption(City));
            AddField(CompanyInfo.TableCaption + ' ' + CompanyInfo.FieldCaption(County));
            AddField(CompanyInfo.TableCaption + ' ' + Country.TableCaption + ' ' + Country.FieldCaption(Name));
            AddField(CompanyInfo.TableCaption + ' ' + CompanyInfo.FieldCaption("VAT Registration No."));
            AddField(CompanyInfo.TableCaption + ' ' + CompanyInfo.FieldCaption("Registration No."));
            AddField(CompanyInfo.TableCaption + ' ' + CompanyInfo.FieldCaption("Phone No."));
            AddField(CompanyInfo.TableCaption + ' ' + CompanyInfo.FieldCaption("Fax No."));
            AddField(CompanyInfo.TableCaption + ' ' + CompanyInfo.FieldCaption("Bank Branch No."));
            AddField(CompanyInfo.TableCaption + ' ' + CompanyInfo.FieldCaption("Bank Name"));
            AddField(CompanyInfo.TableCaption + ' ' + CompanyInfo.FieldCaption("Bank Account No."));
            AddField(CompanyInfo.TableCaption + ' ' + CompanyInfo.FieldCaption("Giro No."));
            GlobalLanguage := MainLanguage;
            AddField(Text015);
            WriteLine;

            // Mergesource must be at least two lines
            if MergeFieldsOnly then begin
                for I := 1 to 48 do
                    AddField('');
                WriteLine;
                CloseMergeFile;
            end;
        end;
    end;

    local procedure WordHandler(var WordDocument: DotNet WordDocument; var Attachment: Record "Importação Templates"; Caption: Text[260]; IsTemporary: Boolean; FileName: Text; IsInherited: Boolean) DocImported: Boolean
    var
        Attachment2: Record Attachment;
        [RunOnClient]
        WordHandler: DotNet BCTestWordHandler;
        NewFileName: Text;
    begin
        WordHandler := WordHandler.WordHandler;

        WordDocument.ActiveWindow.Caption := Caption;
        WordDocument.Application.Visible := true; // Visible before WindowState KB176866 - http://support.microsoft.com/kb/176866
        WordDocument.ActiveWindow.WindowState := 1; // 1 = wdWindowStateMaximize
        WordDocument.Saved := true;
        WordDocument.Application.Activate;

        NewFileName := WordHandler.WaitForDocument(WordDocument);

        if not Attachment."Read Only" then
            if WordHandler.IsDocumentClosed then
                if WordHandler.HasDocumentChanged then begin
                    Clear(WordHandler);
                    if Confirm(Text021 + Caption + '?', true) then begin
                        if (not IsTemporary) and Attachment2.Get(Attachment."No.") then
                            if Attachment2."Last Time Modified" <> Attachment."Last Time Modified" then begin
                                DeleteFile(FileName);
                                if NewFileName <> FileName then
                                    if Confirm(StrSubstNo(Text022, NewFileName), false) then
                                        DeleteFile(NewFileName);
                                Error(StrSubstNo(Text023, Attachment.TableCaption));
                            end;
                        Attachment.ImportAttachment(NewFileName, IsTemporary);
                        DeleteFile(NewFileName);
                        DocImported := true;
                    end;
                end;

        Clear(WordHandler);
        DeleteFile(FileName);
    end;

    local procedure DeleteFile(FileName: Text) DeleteOk: Boolean
    var
        I: Integer;
    begin
        // Wait for Word to release the files
        if FileName = '' then
            exit(false);

        if not FileMgt.ClientFileExists(FileName) then
            exit(true);

        repeat
            Sleep(250);
            I := I + 1;
        until FileMgt.DeleteClientFile(FileName) or (I = 25);
        exit(not FileMgt.ClientFileExists(FileName));
    end;

    local procedure DocumentContainMergefields(var Attachment: Record "Importação Templates") MergeFields: Boolean
    var
        [RunOnClient]
        WordApplication: DotNet WordApplicationClass;
        [RunOnClient]
        WordDocument: DotNet WordDocument;
        ParamBln: Boolean;
        FileName: Text;
    begin
        WordApplication := WordApplication.ApplicationClass;
        if (UpperCase(Attachment."File Extension") <> 'DOC') and
           (UpperCase(Attachment."File Extension") <> 'DOCX')
        then
            exit(false);
        FileName := Attachment.ConstFilename;
        Attachment.ExportAttachment(FileName);
        WordDocument := WordHelper.CallOpen(WordApplication, FileName, false, false);

        MergeFields := (WordDocument.MailMerge.Fields.Count > 0);
        ParamBln := false;
        WordHelper.CallClose(WordDocument, ParamBln);
        DeleteFile(FileName);

        Clear(WordDocument);
        WordHelper.CallQuit(WordApplication, false);
        Clear(WordApplication);
    end;

    local procedure CreateMergeSource(var MergeFile: File)
    var
        MergeServerFileName: Text;
    begin
        MergeServerFileName := FileMgt.ServerTempFileName('HTM');
        MergeFile.WriteMode := true;
        MergeFile.TextMode := true;
        MergeFile.Create(MergeServerFileName);
    end;

    local procedure CloseAndDownloadMergeSource(var MergeFile: File) MergeClientFileName: Text
    var
        MergeServerFileName: Text;
    begin
        MergeServerFileName := MergeFile.Name;
        MergeFile.Write('</table>');
        MergeFile.Write('</body>');
        MergeFile.Write('</html>');
        MergeFile.Close;

        MergeClientFileName := FileMgt.DownloadTempFile(MergeServerFileName);

        // We don't need the file any more on ServiceTier
        Erase(MergeServerFileName);

        exit(MergeClientFileName);
    end;


    procedure PopulateInterLogEntryToMergeSource(var MergeFile: File; var Attachment: Record Attachment; EntryNo: Integer; var HeaderIsReady: Boolean; CorrespondenceType: Option ,"Hard Copy","E-Mail",Fax)
    var
        InteractLogEntry: Record "Interaction Log Entry";
        InStreamBLOB: InStream;
        CurrentLine: Text[250];
        NewLine: Text[250];
        SearchValue: Text[30];
        LineIsFound: Boolean;
    begin
        Attachment.CalcFields("Merge Source");
        Attachment."Merge Source".CreateInStream(InStreamBLOB);
        SearchValue := '<td>' + Format(EntryNo) + '</td>';
        repeat
            InStreamBLOB.ReadText(CurrentLine);
            if (StrPos(CurrentLine, '<tr>') > 0) and HeaderIsReady then begin
                InStreamBLOB.ReadText(NewLine);
                if StrPos(NewLine, SearchValue) > 0 then begin
                    MergeFile.Write(CurrentLine);
                    MergeFile.Write(NewLine);
                    LineIsFound := true
                end
            end;

            if not HeaderIsReady then begin
                MergeFile.Write(CurrentLine);
                if StrPos(CurrentLine, '</tr>') > 0 then
                    HeaderIsReady := true
            end
        until LineIsFound or InStreamBLOB.EOS;

        if LineIsFound then begin
            InStreamBLOB.ReadText(NewLine);
            while StrPos(NewLine, '</tr>') = 0 do begin
                CurrentLine := NewLine;
                InStreamBLOB.ReadText(NewLine);
                if StrPos(NewLine, '</tr>') = 0 then
                    MergeFile.Write(CurrentLine);
            end;
            if InteractLogEntry.Get(EntryNo) then begin
                case CorrespondenceType of
                    CorrespondenceType::Fax:
                        MergeFile.Write('<td>' + AttachmentManagement.InteractionFax(InteractLogEntry) + '</td>');
                    CorrespondenceType::"E-Mail":
                        MergeFile.Write('<td>' + AttachmentManagement.InteractionEMail(InteractLogEntry) + '</td>')
                    else
                        MergeFile.Write('<td></td>')
                end
            end
        end;
    end;


    procedure AddFieldsToMergeSource(var WordMergefile: DotNet BCTestMergeHandler; var InteractLogEntry: Record "Interaction Log Entry"; var SegLine: Record "Segment Line"; FaxMailToValue: Text)
    var
        Salesperson: Record "Salesperson/Purchaser";
        Country: Record "Country/Region";
        Country2: Record "Country/Region";
        Contact: Record Contact;
        CompanyInfo: Record "Company Information";
        FormatAddr: Codeunit "Format Address";
        ContAddr: array[8] of Text[50];
        ContAddr2: array[8] of Text[50];
        LineNo: Text;
        SalesPersonCode: Code[10];
        ContactNo: Code[20];
        ContactAltAddressCode: Code[10];
        LanguageCode: Code[10];
        Date: Date;
        ContactAddressDimension: Integer;
    begin
        if InteractLogEntry.IsEmpty then begin
            ContactNo := SegLine."Contact No.";
            SalesPersonCode := SegLine."Salesperson Code";
            LineNo := Format(SegLine."Line No.");
            ContactAltAddressCode := SegLine."Contact Alt. Address Code";
            Date := SegLine.Date;
            LanguageCode := SegLine."Language Code";
        end else begin
            ContactNo := InteractLogEntry."Contact No.";
            SalesPersonCode := InteractLogEntry."Salesperson Code";
            LineNo := Format(InteractLogEntry."Entry No.");
            ContactAltAddressCode := InteractLogEntry."Contact Alt. Address Code";
            Date := InteractLogEntry.Date;
            LanguageCode := InteractLogEntry."Interaction Language Code";
        end;

        Contact.Get(ContactNo);
        CompanyInfo.Get;
        if not Country2.Get(CompanyInfo."Country/Region Code") then
            Clear(Country2);

        if not Country.Get(Contact."Country/Region Code") then
            Clear(Country);

        if not Salesperson.Get(SalesPersonCode) then
            Clear(Salesperson);

        // This field must come first in the merge source file
        WordMergefile.AddField(LineNo);

        // Add multiline fielddata
        ContactAddressDimension := 1;
        FormatAddr.ContactAddrAlt(ContAddr, Contact, ContactAltAddressCode, Date);

        WordMergefile.OpenNewMultipleValueField;
        CopyArray(ContAddr2, ContAddr, 1);
        CompressArray(ContAddr2);
        while ContAddr2[1] <> '' do begin
            if ContAddr[ContactAddressDimension] <> '' then begin
                WordMergefile.AddDataToMultipleValueField(ContAddr[ContactAddressDimension]);
                ContAddr2[1] := '';
                CompressArray(ContAddr2);
            end else
                WordMergefile.AddDataToMultipleValueField('&nbsp;');
            ContactAddressDimension := ContactAddressDimension + 1;
        end;
        WordMergefile.CloseMultipleValueField;

        with WordMergefile do begin
            AddField(Contact."No.");
            AddField(Contact."Company Name");
            AddField(Contact.Name);
            AddField(Contact."Name 2");
            AddField(Contact.Address);
            AddField(Contact."Address 2");
            AddField(Contact."Post Code");
            AddField(Contact.City);
            AddField(Contact.County);
            AddField(Country.Name);
            AddField(Contact."Job Title");
            AddField(Contact."Phone No.");
            AddField(Contact."Fax No.");
            AddField(Contact."E-Mail");
            AddField(Contact."Mobile Phone No.");
            AddField(Contact."VAT Registration No.");
            AddField(Contact."Home Page");
            AddField(Contact.GetSalutation(0, LanguageCode));
            AddField(Contact.GetSalutation(1, LanguageCode));
            AddField(Salesperson.Code);
            AddField(Salesperson.Name);
            AddField(Salesperson."Job Title");
            AddField(Salesperson."Phone No.");
            AddField(Salesperson."E-Mail");

            if InteractLogEntry.IsEmpty then begin
                AddField(Format(SegLine.Date));
                AddField(SegLine."Campaign No.");
                AddField(SegLine."Segment No.");
                AddField(SegLine.Description);
                AddField(SegLine.Subject);
            end else begin
                AddField(Format(InteractLogEntry.Date));
                AddField(InteractLogEntry."Campaign No.");
                AddField(InteractLogEntry."Segment No.");
                AddField(InteractLogEntry.Description);
                AddField(InteractLogEntry.Subject);
            end;

            AddField(CompanyInfo.Name);
            AddField(CompanyInfo."Name 2");
            AddField(CompanyInfo.Address);
            AddField(CompanyInfo."Address 2");
            AddField(CompanyInfo."Post Code");
            AddField(CompanyInfo.City);
            AddField(CompanyInfo.County);
            AddField(Country2.Name);
            AddField(CompanyInfo."VAT Registration No.");
            AddField(CompanyInfo."Registration No.");
            AddField(CompanyInfo."Phone No.");
            AddField(CompanyInfo."Fax No.");
            AddField(CompanyInfo."Bank Branch No.");
            AddField(CompanyInfo."Bank Name");
            AddField(CompanyInfo."Bank Account No.");
            AddField(CompanyInfo."Giro No.");

            AddField(FaxMailToValue);

            WriteLine
        end;
    end;

    local procedure ImportMergeSourceFile(AttachmentNo: Integer)
    var
        Attachment: Record "Importação Templates";
    begin
        Attachment.Get(AttachmentNo);
        if not DocumentContainMergefields(Attachment) then
            exit;
        MergeSourceBufferFile.Write('</table>');
        MergeSourceBufferFile.Write('</body>');
        MergeSourceBufferFile.Write('</html>');
        MergeSourceBufferFile.Close;
        Attachment.ImportAttachment(MergeSourceBufferFileName, false);
        Attachment.Modify;
        DeleteFile(MergeSourceBufferFileName);
        MergeSourceBufferFileName := '';
    end;

    local procedure AppendToMergeSource(MergeFileName: Text)
    var
        SourceFile: File;
        CurrentLine: Text[250];
        SkipHeader: Boolean;
        MergeFileNameServer: Text;
    begin
        if MergeSourceBufferFileName = '' then begin
            MergeSourceBufferFileName := FileMgt.ServerTempFileName('HTM');
            MergeSourceBufferFile.WriteMode := true;
            MergeSourceBufferFile.TextMode := true;
            MergeSourceBufferFile.Create(MergeSourceBufferFileName);
        end else
            SkipHeader := true;
        SourceFile.TextMode := true;

        MergeFileNameServer := FileMgt.ServerTempFileName('HTM');
        Upload(Text021, '', Text032, MergeFileName, MergeFileNameServer);

        SourceFile.Open(MergeFileNameServer);
        if SkipHeader then
            repeat
                SourceFile.Read(CurrentLine)
            until (StrPos(CurrentLine, '</tr>') <> 0);
        while (StrPos(CurrentLine, '</table>') = 0) and (SourceFile.Pos <> SourceFile.Len) do begin
            SourceFile.Read(CurrentLine);
            if StrPos(CurrentLine, '</table>') = 0 then
                MergeSourceBufferFile.Write(CurrentLine);
        end;
        SourceFile.Close;

        Erase(MergeFileNameServer);
    end;


    procedure GetWordDocumentExtension(VersionTxt: Text[30]): Code[4]
    var
        Version: Decimal;
        SeparatorPos: Integer;
        CommaStr: Code[1];
        DefaultStr: Code[10];
        EvalOK: Boolean;
    begin
        DefaultStr := 'DOC';
        SeparatorPos := StrPos(VersionTxt, '.');
        if SeparatorPos = 0 then
            SeparatorPos := StrPos(VersionTxt, ',');
        if SeparatorPos = 0 then
            EvalOK := Evaluate(Version, VersionTxt)
        else begin
            CommaStr := CopyStr(Format(11 / 10), 2, 1);
            EvalOK := Evaluate(Version, CopyStr(VersionTxt, 1, SeparatorPos - 1) + CommaStr + CopyStr(VersionTxt, SeparatorPos + 1));
        end;
        if EvalOK and (Version >= 12.0) then
            exit('DOCX');
        exit(DefaultStr);
    end;

    local procedure HandleWordDocumentWithoutMerge(var WordDocument: DotNet WordDocument; var DeliverySorter: Record "Delivery Sorter"; MainFileName: Text)
    var
        InteractLogEntry: Record "Interaction Log Entry";
        Contact: Record Contact;
        Mail: Codeunit Mail;
    begin
        with InteractLogEntry do
            repeat
                LockTable;
                Get(DeliverySorter."No.");
                if DeliverySorter."Correspondence Type" = DeliverySorter."Correspondence Type"::Email then begin
                    Contact.Get("Contact No.");
                    Mail.NewMessage(
                      AttachmentManagement.InteractionEMail(InteractLogEntry), '', '',
                      DeliverySorter.Subject, '', MainFileName, false);
                end else
                    WordHelper.CallPrintOut(WordDocument);
                "Delivery Status" := "Delivery Status"::" ";
                Modify;
                Commit;
            until DeliverySorter.Next = 0;
    end;


    procedure SendAttachmentWithoutMergeFields(var WordApplication: DotNet WordApplicationClass; var TempDeliverySorter: Record "Delivery Sorter" temporary; var Attachment: Record "Importação Templates")
    var
        [RunOnClient]
        WordDocument: DotNet WordDocument;
        FileName: Text;
    begin
        FileName := FileMgt.ServerTempFileName('DOC');
        Attachment.ExportAttachment(FileName);
        case TempDeliverySorter."Correspondence Type" of
            TempDeliverySorter."Correspondence Type"::"Hard Copy":
                begin
                    WordDocument := WordHelper.CallOpen(WordApplication, FileName, false, false);
                    HandleWordDocumentWithoutMerge(WordDocument, TempDeliverySorter, FileName);
                    WordHelper.CallClose(WordDocument, false);
                end;
            TempDeliverySorter."Correspondence Type"::Email:
                begin
                    // Send attachment to all contacts in buffer
                    Window.Update(6, Text009);
                    Attachment.TestField("File Extension");
                    HandleWordDocumentWithoutMerge(WordDocument, TempDeliverySorter, FileName);
                    DeleteFile(FileName);
                end;
        end;
    end;


    procedure IsWordDocumentExtension(FileExtension: Text): Boolean
    begin
        if (UpperCase(FileExtension) <> 'DOC') and
           (UpperCase(FileExtension) <> 'DOCX') and
           (UpperCase(FileExtension) <> '.DOC') and
           (UpperCase(FileExtension) <> '.DOCX')
        then
            exit(false);

        exit(true);
    end;

    local procedure GetLanguageId(LanguageCode: Code[10]): integer
    var
        Language: record Language;

    begin
        IF LanguageCode <> '' THEN
            IF Language.GET(LanguageCode) THEN
                EXIT(Language."Windows Language ID");

        exit(GLOBALLANGUAGE);

    end;
}

