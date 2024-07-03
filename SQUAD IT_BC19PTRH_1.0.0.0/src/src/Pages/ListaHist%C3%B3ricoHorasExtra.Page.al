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
                field("No. Mov."; "No. Mov.")
                {
                    ApplicationArea = All;

                }
                field("No. Empregado"; "No. Empregado")
                {
                    ApplicationArea = All;

                }
                field(Data; Data)
                {
                    ApplicationArea = All;

                }
                field("Cód. Hora Extra"; "Cód. Hora Extra")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Descrição)
                {
                    ApplicationArea = All;

                }
                field("Cód. Rubrica"; "Cód. Rubrica")
                {
                    ApplicationArea = All;

                }
                field(Quantidade; Quantidade)
                {
                    ApplicationArea = All;

                }
                field(Factor; Factor)
                {
                    ApplicationArea = All;

                }
                field("Valor Unitário"; "Valor Unitário")
                {
                    ApplicationArea = All;

                }
                field("Comentário"; Comentário)
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
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

