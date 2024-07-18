xmlport 53050 "Exporta Documentos"
{
    Direction = Export;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(ArrayOfEmployeeDocumentType)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            tableelement(Empregado; Empregado)
            {
                MinOccurs = Zero;
                XmlName = 'EmployeeDocumentType';
                SourceTableView = SORTING("No.") WHERE(Status = CONST(Active));
                fieldelement(EmployeeNumber; Empregado."No.")
                {
                    MinOccurs = Zero;
                }
                textelement(Type)
                {
                    MinOccurs = Zero;

                    trigger OnBeforePassVariable()
                    begin
                        Type := vType;
                    end;
                }
                textelement(Year)
                {
                    MinOccurs = Zero;

                    trigger OnBeforePassVariable()
                    begin
                        Year := Format(vAno);
                    end;
                }
                textelement(Month)
                {
                    MinOccurs = Zero;

                    trigger OnBeforePassVariable()
                    begin
                        Month := Format(vMes);
                    end;
                }
                textelement(Document)
                {
                    MinOccurs = Zero;

                    trigger OnBeforePassVariable()
                    var
                        DeclaracaoIRS: Report "Declaração Anual Rendimentos";
                        ReciboVenc: Report "Recibo Vencimentos A4";
                        FilePathAndName: Text;
                        FileManagement: Codeunit "File Management";
                        dnetByte: DotNet BCTestArray;
                        //dnetByte1: DotNet BCTestArray;
                        dnetConvert: DotNet BCTestConvert;
                        dnetMemoryStream: DotNet BCTestMemoryStream;
                        objInstream: InStream;
                        txtBase64Code: Text;
                        IFile: File;
                        i: Integer;
                        HistCabMovEmp: Record "Hist. Cab. Movs. Empregado";
                    begin

                        FilePathAndName := FileManagement.ServerTempFileName('pdf');
                        //insert a type and get a name
                        Flag := false;

                        if vType = 'DecIRS' then begin
                            DeclaracaoIRS.InitData(vAno);
                            DeclaracaoIRS.UseRequestPage(false);
                            DeclaracaoIRS.SaveAsPdf(FilePathAndName);
                            //Saves a report as a .pdf file.
                            Flag := true;
                            Clear(DeclaracaoIRS);
                        end else begin
                            HistCabMovEmp.Reset;
                            HistCabMovEmp.SetRange("Tipo Processamento", HistCabMovEmp."Tipo Processamento"::Vencimentos);
                            HistCabMovEmp.SetRange("Data Registo", DMY2Date(1, vMes, vAno), CalcDate('+1M-1D', DMY2Date(1, vMes, vAno)));
                            HistCabMovEmp.SetRange(HistCabMovEmp."No. Empregado", Empregado."No.");
                            if HistCabMovEmp.FindFirst then begin
                                ReciboVenc.InitData(HistCabMovEmp."Cód. Processamento", Empregado."No.");
                                ReciboVenc.UseRequestPage(false);
                                ReciboVenc.SaveAsPdf(FilePathAndName);
                                Flag := true;
                                Clear(DeclaracaoIRS);
                            end;
                        end;

                        if Flag then begin

                            //Transformar em Base64
                            IFile.Open(FilePathAndName);
                            dnetMemoryStream := dnetMemoryStream.MemoryStream;
                            IFile.CreateInStream(objInstream);
                            CopyStream(dnetMemoryStream, objInstream);

                            dnetByte := dnetMemoryStream.ToArray;
                            dnetMemoryStream.Dispose;
                            dnetMemoryStream := dnetMemoryStream.MemoryStream;
                            dnetMemoryStream.Write(dnetByte, 0, dnetByte.Length);
                            dnetMemoryStream.Close();
                            dnetByte := dnetMemoryStream.ToArray;

                            txtBase64Code := dnetConvert.ToBase64String(dnetByte);
                            dnetMemoryStream.Dispose;
                            Clear(objInstream);

                            Document := txtBase64Code
                        end;
                    end;
                }
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

    var
        vType: Text;
        vAno: Integer;
        vMes: Integer;
        Flag: Boolean;


    procedure Filtra(pType: Text; pAno: Text; pMes: Text)
    begin
        vType := pType;
        if Evaluate(vAno, pAno) then;
        if Evaluate(vAno, pAno) then;
    end;
}

