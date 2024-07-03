codeunit 31003040 "WS Portal Empregado Employee"
{

    trigger OnRun()
    begin
    end;

    var
        XmlEmp2: XMLport "Exporta Empregados";
        Empregado: Record Empregado;
        xmlTabelas: XMLport "Tabelas Auxiliares";


    procedure GetAllEmployeeInformation(var XMLEmpExp: XMLport "Exporta Empregados")
    begin
    end;


    procedure GetEmployeeInformation(var XMLEmpExp: XMLport "Exporta Empregados"; employeeNumber: Code[20])
    var
        Empregado: Record Empregado;
    begin
        if employeeNumber <> '' then
            Empregado.SetFilter(Empregado."No.", employeeNumber);

        XMLEmpExp.SetTableView(Empregado);
    end;


    procedure UpdateEmployeeInformation(XMLEmpImp: XMLport "Importa Empregados"): Boolean
    begin
        XMLEmpImp.Import;
        exit(true);
    end;


    procedure GetEmployeeDocuments(var xmlDocum: XMLport "Exporta Documentos"; Type: Text; Year: Text; Month: Text)
    begin
        xmlDocum.Filtra(Type, Year, Month);
    end;
}

