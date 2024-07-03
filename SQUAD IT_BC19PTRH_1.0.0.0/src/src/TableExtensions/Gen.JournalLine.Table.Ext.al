tableextension 31003037 GenJournalLineRH extends "Gen. Journal Line"
{
    fields
    {
        //HR10.0
        field(31003035; "No. Empregado"; Code[20])
        {
            CaptionML = PTG = 'No. Empregado';
            TableRelation = "Empregado";
        }

        //HR10.0- Pagamento
        field(31003036; "Não deixa alterar No.Doc"; Boolean)
        {
            CaptionML = PTG = 'Não deixa alterar No.Doc';
        }
        field(31003037; "Cód. Processamento"; Code[20])
        {
            CaptionML = PTG = 'Cód. Processamento';
            TableRelation = "Empregado";
        }

        //HR10.0
        field(31003038; "Integrado na Contabilidade"; Boolean)
        {
            CaptionML = PTG = 'Integrado na Contabilidade';
        }
    }


}