codeunit 50000 ItimeAPI
{
    //XML port
    [ServiceEnabled]
    procedure GetEmpregados(var empregados: XmlPort GetEmpregados; lastDateModified: Text)
    var
        dateLastMod: Date;
    begin

        if lastDateModified <> '' then begin
            if Evaluate(dateLastMod, lastDateModified) then begin
                empregados.SetFilters(dateLastMod);
            end else begin
                Error('Formato de data inválido.');
            end;
        end;

        empregados.Export();
    end;

    [ServiceEnabled]
    procedure GetProjectos(var projectos: XmlPort GetProjectos)
    begin
        projectos.Export();
    end;

    [ServiceEnabled]
    procedure GetCentrosCusto(var centrosCusto: XmlPort GetCentrosCusto)
    begin
        centrosCusto.Export();
    end;

    [ServiceEnabled]
    procedure GetClientes(var clientes: XmlPort GetClientes; lastDateModified: Text)
    var
        dateLastMod: Date;
    begin
        if lastDateModified <> '' then begin
            if Evaluate(dateLastMod, lastDateModified) then begin
                clientes.SetFilters(dateLastMod);
            end else begin
                Error('Formato de data inválido.');
            end;
        end;

        clientes.Export();
    end;

    [ServiceEnabled]
    procedure GetFornecedores(var fornecedores: XmlPort GetFornecedores; lastDateModified: Text)
    var
        dateLastMod: Date;
    begin
        if lastDateModified <> '' then begin
            if Evaluate(dateLastMod, lastDateModified) then begin
                fornecedores.SetFilters(dateLastMod);
            end else begin
                Error('Formato de data inválido.');
            end;
        end;

        fornecedores.Export();
    end;

    [ServiceEnabled]
    procedure GetArmazens(var armazens: XmlPort GetArmazens)
    begin
        armazens.Export();
    end;

    [ServiceEnabled]
    procedure GetMateriais(var materiais: XmlPort GetMateriais; lastDateModified: Text)
    var
        dateLastMod: Date;
    begin
        if lastDateModified <> '' then begin
            if Evaluate(dateLastMod, lastDateModified) then begin
                materiais.SetFilters(dateLastMod);
            end else begin
                Error('Formato de data inválido.');
            end;
        end;

        materiais.Export();
    end;
}