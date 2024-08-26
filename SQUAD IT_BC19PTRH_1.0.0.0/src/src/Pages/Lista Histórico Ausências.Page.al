#pragma implicitwith disable
page 53088 "Lista Histórico Ausências"
{
    // //IT001 - CPA - 2017.02.16 . novo campo proc referencia

    AutoSplitKey = true;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Histórico Ausências";

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Employee No."; Rec."Employee No.")
                {


                }
                field("Entry No."; Rec."Entry No.")
                {


                }
                field("From Date"; Rec."From Date")
                {


                }
                field("To Date"; Rec."To Date")
                {


                }
                field("Cause of Absence Code"; Rec."Cause of Absence Code")
                {


                }
                field(Description; Rec.Description)
                {


                }
                field(Quantity; Rec.Quantity)
                {


                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {


                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {


                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {


                }
                field(Justificada; Rec.Justificada)
                {


                }
                field("Com Perca de Remuneração"; Rec."Com Perca de Remuneração")
                {


                }
                field("Com Perca Sub. Alimentação"; Rec."Com Perca Sub. Alimentação")
                {


                }
                field("Qtd. Perca Sub. Alimentação"; Rec."Qtd. Perca Sub. Alimentação")
                {


                }
                field("Influência No. dias férias"; Rec."Influência No. dias férias")
                {


                }
                field("Hora Inicio"; Rec."Hora Inicio")
                {


                }
                field("Hora Fim"; Rec."Hora Fim")
                {


                }
                field("Cód. Rubrica"; Rec."Cód. Rubrica")
                {


                }
                field(Comment; Rec.Comment)
                {


                }
                field("Processamento Referencia"; Rec."Processamento Referencia")
                {


                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("<HistoricoAusencias>")
            {
                Caption = 'A&bsence';
                action("Co&mentários")
                {


                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Folha Comentários RH";
                    RunPageLink = "Table Name" = CONST(HAus),
                                  "Table Line No." = FIELD("Entry No.");
                }
                separator(Action1101490043)
                {
                }
                action("Vista p/ &Categorias")
                {


                    Caption = 'Overview by &Categories';
                    Image = AbsenceCategory;
                    RunObject = Page "Vista Ausências por Categorias";
                    RunPageLink = "Employee No. Filter" = FIELD("Employee No.");
                }
                action("Vista p/ &Períodos")
                {


                    Caption = 'Overview by &Periods';
                    Image = AbsenceCalendar;
                    RunObject = Page "Vista Ausências por Per.";
                }
            }
        }
    }
}

#pragma implicitwith restore

