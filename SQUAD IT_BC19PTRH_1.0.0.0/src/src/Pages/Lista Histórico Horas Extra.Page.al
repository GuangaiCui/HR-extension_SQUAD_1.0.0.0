#pragma implicitwith disable
page 53091 "Lista Histórico Horas Extra"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Histórico Horas Extra";

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("No. Mov."; Rec."No. Mov.")
                {
                    ApplicationArea = All;

                }
                field("No. Empregado"; Rec."No. Empregado")
                {
                    ApplicationArea = All;

                }
                field(Data; Rec.Data)
                {
                    ApplicationArea = All;

                }
                field("Cód. Hora Extra"; Rec."Cód. Hora Extra")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Rec."Descrição")
                {
                    ApplicationArea = All;

                }
                field("Cód. Rubrica"; Rec."Cód. Rubrica")
                {
                    ApplicationArea = All;

                }
                field(Quantidade; Rec.Quantidade)
                {
                    ApplicationArea = All;

                }
                field(Factor; Rec.Factor)
                {
                    ApplicationArea = All;

                }
                field("Valor Unitário"; Rec."Valor Unitário")
                {
                    ApplicationArea = All;

                }
                field("Comentário"; Rec."Comentário")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
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
            group("<HistoricoHoraExtra>")
            {
                Caption = 'Ex. Hour';
                action("Co&mentários")
                {
                    ApplicationArea = All;

                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Folha Comentários RH";
                    RunPageLink = "Table Name" = CONST(HHorEx),
                                  "Table Line No." = FIELD("No. Mov.");
                }
                separator(Action1101490026)
                {
                }
                action("Vista p/ &Categorias")
                {
                    ApplicationArea = All;

                    Caption = 'Vista p/ &Categorias';
                    Image = ServiceHours;
                    RunObject = Page "Vista HoraExtra por Categorias";
                    RunPageLink = "Employee No. Filter" = FIELD("No. Empregado");
                }
            }
        }
    }
}

#pragma implicitwith restore

