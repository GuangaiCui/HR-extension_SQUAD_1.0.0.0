codeunit 60000 MyCodeunit
{
    trigger OnRun()
    begin

    end;

    var



    //writes a file to the Azure File Share
    procedure WriteFileToShare(StorageAccount: Text; FileShare: Text; Authorization: Interface "Storage Service Authorization"; FilePath: Text; var FileContent: InStream)
    var
        AFSFileClient: Codeunit "AFS File Client";
        AFSOperationResponse: Codeunit "AFS Operation Response";
    begin
        AFSFileClient.initialize(StorageAccount, FileShare, Authorization);
        AFSOperationResponse := AFSFileClient.CreateFile(filepath, FileContent);
        if not AFSOperationResponse.IsSuccessful() then
            Error(AFSOperationResponse.GetError());

        AFSOperationResponse := AFSFileClient.PutFileStream(FilePath, FileContent);
        if not AFSOperationResponse.IsSuccessful() then
            Error(AFSOperationResponse.GetError());
    end;

    //reads a file from the Azure File Share and downloads it to the client
    procedure GetFileFromShare(StorageAccount: Text; FileShare: Text; Authorization: Interface "Storage Service Authorization"; FilePath: Text)
    var
        AFSFileClient: Codeunit "AFS File Client";
        AFSOperationResponse: Codeunit "AFS Operation Response";
        FIleContent: InStream;
    begin
        AFSFileClient.Initialize(StorageAccount, FileShare, Authorization);
        AFSOperationResponse := AFSFileClient.GetFileAsStream(filepath, FIleContent);
        if not AFSOperationResponse.IsSuccessful() then
            Error(AFSOperationResponse.GetError());

        DownloadFromStream(FIleContent, '', '', '', FilePath);
    end;

    //lists all files in an Azure File Share folder and loads them into a List object
    procedure GetFilesInFolder(StorageAccount: Text; FileShare: Text; Authorization: Interface "Storage Service Authorization"; DirectoryPath: Text[2048]): List of [Text[2048]]
    var
        AFSDirectoryContent: Record "AFS Directory Content";
        AFSFileClient: Codeunit "AFS File Client";
        AFSOperationResponse: Codeunit "AFS Operation Response";
        FileNames: List of [Text[2048]];
    begin
        AFSOperationResponse := AFSFileClient.ListDirectory(DirectoryPath, AFSDirectoryContent);
        if not AFSOperationResponse.IsSuccessful() then
            Error(AFSOperationResponse.GetError());

        AFSDirectoryContent.SetRange("Resource Type", AFSDirectoryContent."Resource Type"::FIle);
        if AFSDirectoryContent.FindSet() then
            repeat
                FileNames.Add(AFSDirectoryContent."Full Name");
            until AFSDirectoryContent.Next() = 0;

        exit(FileNames);
    end;

    local procedure AuthorizeSourceFile(StorageAccount: Text; FileShareName: Text; var StorageServiceAuthorization: Interface "Storage Service Authorization"; SourcePath: Text): Text
    var
        HttpRequestMessage: HttpRequestMessage;
        SourceFileURILbl: Label 'https://%1.file.core.windows.net/%2/%3', Comment = '%1 = Storage Account, %2 = File Share Name, %3 = Source Path';
        SourceFileURI: Text;
    begin
        SourceFileURI := StrSubstNo(SourceFileURILbl, StorageAccount, FileShareName, SourcePath);
        HttpRequestMessage.SetRequestUri(SourceFileURI);
        StorageServiceAuthorization.Authorize(HttpRequestMessage, StorageAccount);
        exit(HttpRequestMessage.GetRequestUri());
    end;

}