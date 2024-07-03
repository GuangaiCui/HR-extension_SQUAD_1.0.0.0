xmlport 53046 "Escalões Vencimento"
{
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Grau Função"; "Grau Função")
            {
                XmlName = 'GrauFuncao';
                fieldelement(Codigo; "Grau Função"."Código")
                {
                }
                fieldelement(Descricao; "Grau Função".Description)
                {
                }
                fieldelement(ValorMin; "Grau Função"."Min Value")
                {
                }
                fieldelement(ValorMax; "Grau Função"."Max Value")
                {
                }
                fieldelement(ValorHoraSemanal; "Grau Função"."Valor Hora Semanal")
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

