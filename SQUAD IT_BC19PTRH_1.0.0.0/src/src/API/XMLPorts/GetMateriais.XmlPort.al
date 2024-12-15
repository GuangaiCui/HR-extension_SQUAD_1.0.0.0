xmlport 50006 GetMateriais
{
    UseRequestPage = false;
    UseDefaultNamespace = true;

    schema
    {
        textelement(MaterialList)
        {
            tableelement(Material; Item)
            {
                textelement(No)
                {
                    trigger OnBeforePassVariable()
                    begin
                        No := Material."No.";
                    end;
                }

                textelement(NoFornecedor)
                {
                    trigger OnBeforePassVariable()
                    begin
                        NoFornecedor := Material."Vendor No.";
                    end;
                }

                textelement(NoRegisto)
                {
                    trigger OnBeforePassVariable()
                    begin
                        NoRegisto := '';
                    end;
                }

                textelement(Descricao)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Descricao := Material.Description + Material."Description 2";
                    end;
                }

                textelement(DataCriacao)
                {
                    trigger OnBeforePassVariable()
                    begin
                        DataCriacao := '';
                    end;
                }

                textelement(DataUltimaAtualizacao)
                {
                    trigger OnBeforePassVariable()
                    begin
                        if Material."Last Date Modified" <> 0D then
                            DataUltimaAtualizacao := Format(Material."Last Date Modified", 0, '<Year4>-<Month>-<Day>');
                        ;
                    end;
                }

                textelement(TamanhoCaixa)
                {
                    trigger OnAfterAssignVariable()
                    begin
                        TamanhoCaixa := '';
                    end;
                }

                textelement(NumeroUnidades)
                {
                    trigger OnAfterAssignVariable()
                    var
                        itemLedgerEntry: Record "Item Ledger Entry";
                    begin
                        itemLedgerEntry.Reset();
                        itemLedgerEntry.SetRange("Item No.", Material."No.");
                        itemLedgerEntry.CalcSums(Quantity);

                        NumeroUnidades := Format(itemLedgerEntry.Quantity);
                    end;
                }

                textelement(Fabricante)
                {
                    trigger OnAfterAssignVariable()
                    var
                        manufacturer: Record Manufacturer;
                    begin
                        manufacturer.Reset();
                        manufacturer.SetRange(Code, Material."Manufacturer Code");

                        if manufacturer.FindFirst() then begin
                            Fabricante := manufacturer.Name;
                        end else begin
                            Fabricante := '';
                        end;

                    end;
                }

                trigger OnPreXmlItem()
                begin
                    if DateFilter <> 0D then
                        Material.SetFilter("Last Date Modified", '>=%1', DateFilter);
                end;
            }
        }
    }

    var
        DateFilter: Date;

    procedure SetFilters(dateLastModified: Date)
    begin
        DateFilter := dateLastModified;
    end;
}