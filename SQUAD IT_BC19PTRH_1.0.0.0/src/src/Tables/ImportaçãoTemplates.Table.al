table 53114 "Importação Templates"
{
    // //Tabela usada para guardar os templates (doc / xml) usados no modulo de RH

    Caption = 'Attachment';
    DataPerCompany = false;

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(2; Attachment; BLOB)
        {
            Caption = 'Attachment';
        }
        field(3; "Storage Type"; Option)
        {
            Caption = 'Storage Type';
            OptionCaption = 'Embedded,Disk File,Exchange Storage';
            OptionMembers = Embedded,"Disk File","Exchange Storage";
        }
        field(4; "Storage Pointer"; Text[250])
        {
            Caption = 'Storage Pointer';
        }
        field(5; "File Extension"; Text[250])
        {
            Caption = 'File Extension';
        }
        field(6; "Read Only"; Boolean)
        {
            Caption = 'Read Only';
        }
        field(7; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
        }
        field(8; "Last Time Modified"; Time)
        {
            Caption = 'Last Time Modified';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Last Date Modified" := Today;
        "Last Time Modified" := Time;

        RMSetup.Get;
        "Storage Type" := RMSetup."Attachment Storage Type";
        if "Storage Type" = "Storage Type"::"Disk File" then begin
            RMSetup.TestField("Attachment Storage Location");
            "Storage Pointer" := RMSetup."Attachment Storage Location";
        end;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
        "Last Time Modified" := Time;
    end;

    var
        Text002: Label 'The attachment is empty.';
        Text003: Label 'Attachment is already in use on this machine.';
        Text004: Label 'When you have saved your document, click Yes to import the document.';
        Text005: Label 'Export Attachment';
        Text006: Label 'Import Attachment';
        Text007: Label 'All Files (*.*)|*.*';
        Text008: Label 'Error during copying file.';
        Text009: Label 'Do you want to remove %1?';
        Text010: Label 'External file could not be removed.';
        Text012: Label '\Doc';
        Text013: Label 'Only Microsoft Word documents can be printed.';
        Text014: Label 'Only Microsoft Word documents can be faxed.';
        RMSetup: Record "Marketing Setup";
        EMailLogging: Codeunit "Email Logging Dispatcher";
        varTempBlob: Codeunit "Temp Blob";


    procedure OpenAttachment(Caption: Text[260]; IsTemporary: Boolean)
    var
        WordManagement: Codeunit "WordManagement HR";
        FileName: Text[260];
    begin
        if "Storage Type" = "Storage Type"::Embedded then begin
            CalcFields(Attachment);
            if not Attachment.HasValue then
                Error(Text002);
        end;

        FileName := ConstFilename;
        if Exists(FileName) then
            if not DeleteFile(FileName) then
                Error(Text003);
        ExportAttachment(FileName);
        HyperLink(FileName);
        if not "Read Only" then begin
            if Confirm(Text004, true) then begin
                ImportAttachment(FileName, IsTemporary);
                Modify(true);
            end;
        end else
            Sleep(10000);

        DeleteFile(FileName);
    end;


    procedure ShowAttachment(var SegLine: Record "Segment Line"; WordCaption: Text[260]; IsTemporary: Boolean)
    var
        WordManagement: Codeunit "WordManagement HR";
        FileName: Text[260];
    begin
        FileName := ConstFilename;
        if "Storage Type" = "Storage Type"::Embedded then
            CalcFields(Attachment);
        ExportAttachment(FileName);
        HyperLink(FileName);
        if not "Read Only" then begin
            if Confirm(Text004, true) then begin
                ImportAttachment(FileName, IsTemporary);
                Modify(true);
            end;
        end else
            Sleep(10000);
        DeleteFile(FileName);
    end;


    procedure ExportAttachment(ExportToFile: Text[260]): Boolean
    var
        FileName: Text[260];
        FileFilter: Text[260];
        FileMgt: Codeunit "File Management";
        OutStr: OutStream;
        InStr: InStream;
    begin
        RMSetup.Get;
        case "Storage Type" of
            "Storage Type"::Embedded:
                begin
                    if RMSetup."Attachment Storage Type" =
                       RMSetup."Attachment Storage Type"::"Disk File"
                    then
                        RMSetup.TestField("Attachment Storage Location");
                    CalcFields(Attachment);
                    if Attachment.HasValue then begin
                        if ExportToFile = '' then begin
                            FileFilter := UpperCase("File Extension") + ' ';
                            FileFilter := FileFilter + '(*.' + "File Extension" + ')|*.' + "File Extension";
                            FileName := FileMgt.OpenFileDialog(Text005, '', FileFilter);
                        end else
                            FileName := ExportToFile;
                        if FileName <> '' then begin
                            //varTempBlob.Reset;
                            //varTempBlob.Blob := Attachment;
                            Attachment.CreateOutStream((OutStr));
                            varTempBlob.CreateInStream(InStr);
                            CopyStream(OutStr, InStr);
                            FileMgt.BLOBExport(varTempBlob, FileMgt.GetFileName(ExportToFile), true); //2015.08.21
                            exit(true);
                        end else
                            exit(false)
                    end else
                        exit(false)
                end;

            "Storage Type"::"Disk File":
                begin
                    if RMSetup."Attachment Storage Type" =
                       RMSetup."Attachment Storage Type"::"Disk File"
                    then
                        RMSetup.TestField("Attachment Storage Location");
                    if ExportToFile = '' then begin
                        FileFilter := UpperCase("File Extension") + ' ';
                        FileFilter := FileFilter + '(*.' + "File Extension" + ')|*.' + "File Extension";
                        FileName := FileMgt.OpenFileDialog(Text005, '', FileFilter);
                    end else
                        FileName := ExportToFile;
                    if FileName <> '' then begin
                        if FILE.Copy(ConstDiskFileName, FileName) then
                            exit(true)
                        else
                            exit(false);
                    end else
                        exit(false)
                end;
        end;
    end;


    procedure ImportAttachment(ImportFromFile: Text[260]; IsTemporary: Boolean): Boolean
    var
        AttachmentManagement: Codeunit AttachmentManagement;
        FileName: Text[260];
        FileMgt: Codeunit "File Management";
    begin
        if IsTemporary then begin
            if ImportFromFile = '' then
                FileName := FileMgt.OpenFileDialog(Text006, ImportFromFile, Text007)
            else
                FileName := ImportFromFile;
            if FileName <> '' then begin
                Attachment.Import(FileName);
                "File Extension" := UpperCase(FileMgt.GetExtension(FileName));
                exit(true)
            end else
                exit(false);
        end;

        TestField("Read Only", false);
        RMSetup.Get;
        if RMSetup."Attachment Storage Type" = RMSetup."Attachment Storage Type"::"Disk File" then
            RMSetup.TestField("Attachment Storage Location");

        if ImportFromFile = '' then
            FileName := FileMgt.OpenFileDialog(Text006, '', Text007)
        else
            FileName := ImportFromFile;

        if FileName <> '' then begin
            if "Storage Pointer" = '' then
                "Storage Pointer" := RMSetup."Attachment Storage Location";
            if RMSetup."Attachment Storage Type" =
              RMSetup."Attachment Storage Type"::"Disk File"
            then begin
                if not FILE.Copy(FileName, ConstDiskFileName) then
                    Error(
                      Text008);
                "File Extension" := UpperCase(FileMgt.GetExtension(FileName));
                "Storage Pointer" := RMSetup."Attachment Storage Location";
                "Storage Type" := "Storage Type"::"Disk File";
                Modify(true);
            end else begin
                Attachment.Import(FileName);
                "File Extension" := UpperCase(FileMgt.GetExtension(FileName));
                "Storage Type" := "Storage Type"::Embedded;
                if Modify(true) then;
            end;
            exit(true);
        end else
            exit(false);
    end;


    procedure RemoveAttachment(Prompt: Boolean) DeleteOK: Boolean
    var
        DeleteYesNo: Boolean;
    begin
        DeleteOK := false;
        DeleteYesNo := true;
        if Prompt then
            if not Confirm(
              Text009, false, TableCaption)
            then
                DeleteYesNo := false;

        if DeleteYesNo then begin
            if "Storage Type" = "Storage Type"::"Disk File" then begin
                if not DeleteFile(ConstDiskFileName) then
                    Message(Text010);
            end;
            Rec.Delete(true);
            DeleteOK := true;
        end;
    end;


    procedure WizEmbeddAttachment(FromAttachment: Record "Importação Templates")
    begin
        Rec := FromAttachment;
        "No." := '';
        "Storage Type" := "Storage Type"::Embedded;
        FromAttachment.TestField("No.");
        case FromAttachment."Storage Type" of
            FromAttachment."Storage Type"::"Disk File":
                Attachment.Import(FromAttachment.ConstDiskFileName);
            FromAttachment."Storage Type"::Embedded:
                begin
                    FromAttachment.CalcFields(Attachment);
                    if FromAttachment.Attachment.HasValue then
                        Attachment := FromAttachment.Attachment;
                end;
        end;
    end;


    procedure WizSaveAttachment()
    var
        Attachment2: Record "Importação Templates";
        FileName: Text[260];
    begin
        RMSetup.Get;
        if RMSetup."Attachment Storage Type" = RMSetup."Attachment Storage Type"::Embedded then begin
            "Storage Pointer" := '';
            exit;
        end;

        "Storage Pointer" := RMSetup."Attachment Storage Location";
        if "No." <> '' then begin
            FileName := ConstDiskFileName;
            if FileName <> '' then
                Attachment.Export(FileName);
        end;

        Attachment2."No." := Rec."No.";
        Attachment2."Storage Type" := Attachment2."Storage Type"::"Disk File";
        Attachment2."Storage Pointer" := RMSetup."Attachment Storage Location";
        Attachment2."File Extension" := Rec."File Extension";
        Attachment2."Read Only" := Rec."Read Only";
        Attachment2."Last Date Modified" := Rec."Last Date Modified";
        Attachment2."Last Time Modified" := Rec."Last Time Modified";
        Clear(Rec);
        Rec := Attachment2;
    end;


    procedure DeleteFile(FileName: Text[260]): Boolean
    var
        I: Integer;
    begin
        if FileName = '' then
            exit(false);

        //if not Exists(FileName) then
        if FileName <> '' then
            exit(true);

        repeat
            Sleep(250);
            I := I + 1;
        until Erase(FileName) or (I = 25);
        exit(not Exists(FileName));
    end;


    procedure ConstFilename() FileName: Text[260]
    var
        I: Integer;
        DocNo: Text[30];
    begin
        repeat
            if I <> 0 then
                DocNo := Format(I);
            FileName := ('C:\temp') + Text012 + DocNo + '.' + "File Extension";
            if not Exists(FileName) then
                exit;
            I := I + 1;
        until I = 999;
    end;


    procedure ConstDiskFileName() DiskFileName: Text[260]
    begin
        DiskFileName := "Storage Pointer" + '\' + Format("No.") + '.';
    end;


    procedure CheckCorrespondenceType(CorrespondenceType: Option " ","Hard Copy","E-Mail",Fax) ErrorText: Text[80]
    begin
        case CorrespondenceType of
            CorrespondenceType::"Hard Copy":
                if UpperCase("File Extension") <> 'DOC' then
                    exit(Text013);
            CorrespondenceType::"E-Mail":
                exit('');
            CorrespondenceType::Fax:
                if UpperCase("File Extension") <> 'DOC' then
                    exit(Text014);
        end;
    end;
}

