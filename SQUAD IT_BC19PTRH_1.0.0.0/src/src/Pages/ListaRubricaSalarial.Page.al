#pragma implicitwith disable
page 53100 "Lista Rubrica Salarial"
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
                field("Código"; Rec."Código")
                {
                    ;

                }
                field("Tipo Rubrica"; Rec."Tipo Rubrica")
                {
                    ;

                }
                field("Descrição"; Rec."Descrição")
                {
                    ;

                }
                field(Periodicidade; Rec.Periodicidade)
                {
                    ;

                }
                field("Mês Início Periocidade"; Rec."Mês Início Periocidade")
                {
                    ;

                }
                field("No. Conta a Debitar"; Rec."No. Conta a Debitar")
                {
                    ;

                }
                field("No. Conta a Creditar"; Rec."No. Conta a Creditar")
                {
                    ;

                }
                field(Quantidade; Rec.Quantidade)
                {
                    ;

                }
                field("Valor Unitário"; Rec."Valor Unitário")
                {
                    ;

                }
                field("Valor Total"; Rec."Valor Total")
                {
                    ;

                }
                field(Genero; Rec.Genero)
                {
                    ;

                }
                field("Genero Rubrica Fecho"; Rec."Genero Rubrica Fecho")
                {
                    ;

                }
                field(NATREM; Rec.NATREM)
                {
                    ;
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

#pragma implicitwith restore

