tableextension 53037 GenJournalLineRH extends "Gen. Journal Line"
{
    fields
    {
        //HR10.0
        field(53035; "No. Empregado"; Code[20])
        {
            CaptionML = PTG = 'No. Empregado';
            TableRelation = "Employee";
        }

        //HR10.0- Pagamento
        field(53036; "Não deixa alterar No.Doc"; Boolean)
        {
            CaptionML = PTG = 'Não deixa alterar No.Doc';
        }
        field(53037; "Cód. Processamento"; Code[20])
        {
            CaptionML = PTG = 'Cód. Processamento';
            TableRelation = "Employee";
        }

        //HR10.0
        field(53038; "Integrado na Contabilidade"; Boolean)
        {
            CaptionML = PTG = 'Integrado na Contabilidade';
        }
    }


}