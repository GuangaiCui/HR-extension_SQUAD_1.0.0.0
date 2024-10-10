tableextension 53037 GenJournalLineRH extends "Gen. Journal Line"
{
    fields
    {
        //HR10.0
        field(53035; "Employee No."; Code[20])
        {
            Caption = 'No. Empregado';
            TableRelation = "Empregado";
        }

        //HR10.0- Pagamento
        field(53036; "Não deixa alterar No.Doc"; Boolean)
        {
            Caption = 'Não deixa alterar No.Doc';
        }
        field(53037; "Cód. Processamento"; Code[20])
        {
            Caption = 'Cód. Processamento';
            TableRelation = "Empregado";
        }

        //HR10.0
        field(53038; "Integrado na Contabilidade"; Boolean)
        {
            Caption = 'Integrado na Contabilidade';
        }
    }


}