#pragma implicitwith disable
page 53131 "Importação Templates"
{
    // //C+  -LCF- Fiz uma reestruturação no form de modo a que se pode-se escolher os ficheiros
    // //a importar e deixar de se usar o HARDcode para ir buscar os nomes do ficheiros

    PageType = List;
    Permissions = TableData "Importação Templates" = rimd;
    SourceTable = "Importação Templates";
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;


                }

                field("Report ID"; Rec."Report ID")
                {
                    ApplicationArea = All;
                }

                field("Report Layout"; Rec."Report Layout")
                {
                    ApplicationArea = All;

                }

                /*
                field(Attachment; Rec.Attachment)
                {
                    ApplicationArea = All;

                    Editable = false;
                }
                */
                field("File Extension"; Rec."File Extension")
                {
                    ApplicationArea = All;

                    //Editable = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;

                    Editable = false;
                }
                field("Last Time Modified"; Rec."Last Time Modified")
                {
                    ApplicationArea = All;

                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Creation)
            {
                Caption = 'Documento';
                /*

                                action("&Importar")
                                {
                                    ApplicationArea = All;

                                    Caption = '&Importar';
                                    Image = Import;

                                    trigger OnAction()
                                    var
                                        Attachment: Record "Importação Templates";
                                    begin
                                        //Corre a funcao que permite selecionar o ficheiro
                                        OpenFile('Importar Ficheiro Movimentos', '', 2, '', 0);

                                        if FileNameImport <> '' then begin
                                            Attachment.Init;
                                            Attachment."No." := FileNameImport;
                                            Attachment."File Extension" := extensão;
                                            Attachment.ImportAttachment(Path, false);
                                            if not Attachment.Insert then Attachment.Modify;
                                            Message('Importado com sucesso');
                                        end;
                                    end;
                                }

                                */
                /*
                action("<Action1101490029>")
                {
                    ApplicationArea = All;

                    Caption = '&Exportar';
                    Image = Export;

                    trigger OnAction()
                    var
                        file1: Text[30];
                    //environment: DotNet BCTestEnvironment;
                    begin

                        //NOTES: This export function was changed due to no longer being supported in BC. Now it download the Attachment to the download folder.
                        //29.05.2008 - usar o environ em vez do c:
                        //path1 := ENVIRON('userprofile')+'\';

                        */
                /*
                file1 := Rec."No." + '.' + Rec."File Extension";
                path1 := FileMgt.BrowseForFolderDialog('', 'Navision', true);
                path1 := path1 + '\';
                Rec.ExportAttachment(path1 + file1);
                Message('Exportado com sucesso para: %1%2', path1, file1);
                */
                /*
                file1 := Rec."No." + '.' + Rec."File Extension";
                Rec.ExportAttachment(file1);
                    end;
                }
*/
            }
        }
    }

    var
        FileMgt: Codeunit "File Management";
        FileNameImport: Text[250];
        FicheiroAImportar: File;
        Text003: Label 'Text Files (*.txt)|*.txt|All Files (*.*)|*.*';
        Text004: Label 'Microsoft Excel Files (*.xl*)|*.xl*|All Files (*.*)|*.*';
        Text005: Label 'Word Documents (*.doc)|*.doc|All Files (*.*)|*.*';
        tamanho: Integer;
        caminho: Text[250];
        FileNameImport2: Text[250];
        tamanho2: Integer;
        "extensão": Code[20];
        Path: Text[250];

    procedure OpenFile(WindowTitle: Text[50]; DefaultFileName: Text[250]; DefaultFileType: Option " ",Text,Excel,Word,Custom; FilterString: Text[250]; "Action": Option Open,Save): Text[260]
    begin
        //CommonDialogControl.FileName := DefaultFileName;
        //CommonDialogControl.DialogTitle := WindowTitle;

        if DefaultFileType = DefaultFileType::Custom then begin
            if StrPos(UpperCase(FilterString), '.DOC') > 0 then
                DefaultFileType := DefaultFileType::Word;
            if StrPos(UpperCase(FilterString), '.XL') > 0 then
                DefaultFileType := DefaultFileType::Excel;
        end;

        case DefaultFileType of
            DefaultFileType::Text:
                FilterString := Text003;
            DefaultFileType::Excel:
                FilterString := Text004;
            DefaultFileType::Word:
                FilterString := Text005;
        end;

        //TODO: COMMENdED TO CREATE APP
        // if Action = Action::Open then
        //     FileNameImport := FileMgt.OpenFileDialog(WindowTitle, DefaultFileName, FilterString)
        // else
        //     FileNameImport := FileMgt.SaveFileDialog(WindowTitle, DefaultFileName, FilterString);

        //LCF

        if FileNameImport <> '' then begin
            Path := FileNameImport;
            // Achar a extensão do ficheiro
            extensão := CopyStr(FileNameImport, StrLen(FileNameImport) - 2);
            while StrPos(FileNameImport, '\') <> 0 do begin
                FileNameImport := CopyStr(FileNameImport, StrPos(FileNameImport, '\') + 1);
            end;
            FileNameImport := CopyStr(FileNameImport, 1, StrPos(FileNameImport, '.') - 1);
        end;


        exit(FileNameImport);
    end;
}

#pragma implicitwith restore

