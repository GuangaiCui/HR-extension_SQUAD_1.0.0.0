xmlport 53043 "Tabelas IRS"
{
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Root)
        {
            tableelement("Tabela IRS"; "Tabela IRS")
            {
                AutoUpdate = true;
                XmlName = 'TabelaIRS';
                fieldelement(NoLinha; "Tabela IRS"."Line No.")
                {
                }
                fieldelement(Regiao; "Tabela IRS"."Região")
                {
                }
                fieldelement(Ate; "Tabela IRS"."Até")
                {

                    trigger OnAfterAssignField()
                    begin
                        "Tabela IRS".Até := Conv.Ansi2Ascii("Tabela IRS".Até);
                    end;
                }
                fieldelement(Tabela; "Tabela IRS".Tabela)
                {
                }
                fieldelement(Descri; "Tabela IRS"."Descrição")
                {
                }
                fieldelement(Valor; "Tabela IRS".Valor)
                {
                }
                fieldelement(TD0; "Tabela IRS"."TD 0 Dependentes")
                {
                }
                fieldelement(TD1; "Tabela IRS"."TD 1 Dependentes")
                {
                }
                fieldelement(TD2; "Tabela IRS"."TD 2 Dependentes")
                {
                }
                fieldelement(TD3; "Tabela IRS"."TD 3 Dependentes")
                {
                }
                fieldelement(TD4; "Tabela IRS"."TD 4 Dependentes")
                {
                }
                fieldelement(TD5; "Tabela IRS"."TD 5ou Mais Dependentes")
                {
                }
                fieldelement(PenCas; "Tabela IRS".PenCas2Tit)
                {
                }
                fieldelement(PenNCas; "Tabela IRS".PenNCas)
                {
                }
                fieldelement(PenCas1; "Tabela IRS".PenCas1Tit)
                {
                }
                fieldelement(Ano; "Tabela IRS".Ano)
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

    trigger OnPostXmlPort()
    begin
        /*
        //2009.02.26
        IF currXMLport.IMPORT = TRUE THEN BEGIN
         IF ConfRH.GET() THEN BEGIN
          IF VarAno <> FORMAT(ConfRH."Ano Tabela IRS") THEN BEGIN
            EVALUATE(ConfRH."Ano Tabela IRS",VarAno);
            ConfRH."Data Importação Tabela IRS" := TODAY;
            ConfRH."Retroactivos Processados" := FALSE;
            ConfRH.MODIFY;
          END;
         END;
        END;
        */
        Message(text001);

    end;

    var
        Conv: Codeunit "Funções RH";
        ConfRH: Record "Config. Recursos Humanos";
        VarAno: Text[30];
        text001: Label 'Processo concluido.';
}

