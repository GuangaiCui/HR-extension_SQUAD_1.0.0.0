xmlport 31003044 "Export Ficheiro Texto"
{
    Direction = Export;
    FieldDelimiter = '<None>';
    FieldSeparator = '<None>';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(root)
        {
            tableelement("Tabela Temp Ficheiros Texto"; "Tabela Temp Ficheiros Texto")
            {
                XmlName = 'TabelaTempFT';
                fieldelement(Texto1; "Tabela Temp Ficheiros Texto".Texto1)
                {

                    trigger OnBeforePassField()
                    begin
                        if CopyStr("Tabela Temp Ficheiros Texto".Texto1, 3, 6) = 'FOLHAF' then
                            currXMLport.Filename(CopyStr("Tabela Temp Ficheiros Texto".Texto1, 39, 4) +
                                                 CopyStr("Tabela Temp Ficheiros Texto".Texto1, 19, 20) +
                                                 CopyStr("Tabela Temp Ficheiros Texto".Texto1, 17, 2) +
                                                 CopyStr("Tabela Temp Ficheiros Texto".Texto1, 15, 2) +
                                                 '.EUR');
                    end;
                }
                fieldelement(Texto2; "Tabela Temp Ficheiros Texto".Texto2)
                {
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
}

