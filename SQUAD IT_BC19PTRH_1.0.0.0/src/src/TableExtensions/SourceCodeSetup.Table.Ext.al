tableextension 53038 SourceCodeSetupRH extends "Source Code Setup"
{
    fields
    {
        //HR10.0
        field(53035; "Integração Vencimentos"; Code[10])
        {
            Caption = 'Integração Vencimentos';
            TableRelation = "Source Code";
        }

        //HR10.0
        field(53036; "Pagamento Vencimentos"; Code[10])
        {
            Caption = 'Pagamento Vencimentos';
            TableRelation = "Source Code";
        }
    }


}