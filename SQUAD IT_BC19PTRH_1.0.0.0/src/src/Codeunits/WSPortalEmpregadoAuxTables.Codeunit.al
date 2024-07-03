codeunit 53041 "WS Portal Empregado AuxTables"
{

    trigger OnRun()
    begin
    end;


    procedure GetAuxiliaryTable(var XMLAuxTable: XMLport "Tabelas Auxiliares"; TableName: Text)
    begin
        XMLAuxTable.Filtra(TableName);
        //preciso de colocar o  xmlAuxTable.RUN???
    end;
}

