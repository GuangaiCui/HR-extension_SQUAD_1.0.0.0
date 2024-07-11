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
                    ApplicationArea = All;

                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;

                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;

                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;

                }
                field("Cause of Absence Code"; Rec."Cause of Absence Code")
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;

                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;

                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;

                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;

                }
                field(Justificada; Rec.Justificada)
                {
                    ApplicationArea = All;

                }
                field("Com Perca de Remuneração"; Rec."Com Perca de Remuneração")
                {
                    ApplicationArea = All;

                }
                field("Com Perca Sub. Alimentação"; Rec."Com Perca Sub. Alimentação")
                {
                    ApplicationArea = All;

                }
                field("Qtd. Perca Sub. Alimentação"; Rec."Qtd. Perca Sub. Alimentação")
                {
                    ApplicationArea = All;

                }
                field("Influência No. dias férias"; Rec."Influência No. dias férias")
                {
                    ApplicationArea = All;

                }
                field("Hora Inicio"; Rec."Hora Inicio")
                {
                    ApplicationArea = All;

                }
                field("Hora Fim"; Rec."Hora Fim")
                {
                    ApplicationArea = All;

                }
                field("Cód. Rubrica"; Rec."Cód. Rubrica")
                {
                    ApplicationArea = All;

                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;

                }
                field("Processamento Referencia"; Rec."Processamento Referencia")
                {
                    ApplicationArea = All;

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
                    ApplicationArea = All;

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
                    ApplicationArea = All;

                    Caption = 'Overview by &Categories';
                    Image = AbsenceCategory;
                    RunObject = Page "Vista Ausências por Categorias";
                    RunPageLink = "Employee No. Filter" = FIELD("Employee No.");
                }
                action("Vista p/ &Períodos")
                {
                    ApplicationArea = All;

                    Caption = 'Overview by &Periods';
                    Image = AbsenceCalendar;
                    RunObject = Page "Vista Ausências por Per.";
                }
            }
        }
    }
}

#pragma implicitwith restore

