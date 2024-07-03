page 55 "Lista Rubrica Salarial"
{
    CardPageID = "Ficha Rubrica Salarial";
    DelayedInsert = true;
    Editable = false;
    PageType = List;
    SourceTable = "Rubrica Salarial";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Código"; Código)
                {
                    ApplicationArea = All;

                }
                field("Tipo Rubrica"; "Tipo Rubrica")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Descrição)
                {
                    ApplicationArea = All;

                }
                field(Periodicidade; Periodicidade)
                {
                    ApplicationArea = All;

                }
                field("Mês Início Periocidade"; "Mês Início Periocidade")
                {
                    ApplicationArea = All;

                }
                field("No. Conta a Debitar"; "No. Conta a Debitar")
                {
                    ApplicationArea = All;

                }
                field("No. Conta a Creditar"; "No. Conta a Creditar")
                {
                    ApplicationArea = All;

                }
                field(Quantidade; Quantidade)
                {
                    ApplicationArea = All;

                }
                field("Valor Unitário"; "Valor Unitário")
                {
                    ApplicationArea = All;

                }
                field("Valor Total"; "Valor Total")
                {
                    ApplicationArea = All;

                }
                field(Genero; Genero)
                {
                    ApplicationArea = All;

                }
                field("Genero Rubrica Fecho"; "Genero Rubrica Fecho")
                {
                    ApplicationArea = All;

                }
                field(NATREM; NATREM)
                {
                    ApplicationArea = All;

                    OptionCaption = '';
                }
            }
        }
    }

    actions
    {
    }


    procedure GetSelectionFilter(): Code[80]
    var
        recRubrica: Record "Rubrica Salarial";
        FirstRubr: Code[30];
        LastRubr: Code[30];
        SelectionFilter: Code[250];
        RubrCount: Integer;
        More: Boolean;
    begin
        //RFV 25.01.2208
        CurrPage.SetSelectionFilter(recRubrica);
        RubrCount := recRubrica.Count;
        if RubrCount > 0 then begin
            recRubrica.Find('-');
            while RubrCount > 0 do begin
                RubrCount := RubrCount - 1;
                recRubrica.MarkedOnly(false);
                FirstRubr := recRubrica.Código;
                LastRubr := FirstRubr;
                More := (RubrCount > 0);
                while More do
                    if recRubrica.Next = 0 then
                        More := false
                    else
                        if not recRubrica.Mark then
                            More := false
                        else begin
                            LastRubr := recRubrica.Código;
                            RubrCount := RubrCount - 1;
                            if RubrCount = 0 then
                                More := false;
                        end;
                if SelectionFilter <> '' then
                    SelectionFilter := SelectionFilter + '|';
                if FirstRubr = LastRubr then
                    SelectionFilter := SelectionFilter + FirstRubr
                else
                    SelectionFilter := SelectionFilter + FirstRubr + '..' + LastRubr;
                if RubrCount > 0 then begin
                    recRubrica.MarkedOnly(true);
                    recRubrica.Next;
                end;
            end;
        end;
        exit(SelectionFilter);
        //RFV
    end;


    procedure SetSelection(var pRubrica: Record "Rubrica Salarial")
    begin
        //RFV 25.01.2008
        CurrPage.SetSelectionFilter(pRubrica);
        //RFV
    end;
}

