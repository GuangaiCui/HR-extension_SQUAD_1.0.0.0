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
                field("Entry No."; Rec."Entry No.")
                {


                }
                field("Employee No."; Rec."Employee No.")
                {


                }
                field(Data; Rec.Data)
                {


                }
                field("Cód. Hora Extra"; Rec."Cód. Hora Extra")
                {


                }
                field("Descrição"; Rec."Descrição")
                {


                }
                field("Cód. Rubrica"; Rec."Cód. Rubrica")
                {


                }
                field(Quantity; Rec.Quantity)
                {


                }
                field(Factor; Rec.Factor)
                {


                }
                field("Unit Value"; Rec."Unit Value")
                {


                }
                field("Comentário"; Rec."Comentário")
                {


                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {


                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {


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


                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Folha Comentários RH";
                    RunPageLink = "Table Name" = CONST(HHorEx),
                                  "Table Line No." = FIELD("Entry No.");
                }
                separator(Action1101490026)
                {
                }
                action("Vista p/ &Categorias")
                {


                    Caption = 'Vista p/ &Categorias';
                    Image = ServiceHours;
                    RunObject = Page "Vista HoraExtra por Categorias";
                    RunPageLink = "Employee No. Filter" = FIELD("Employee No.");
                }
            }
        }
    }
}

#pragma implicitwith restore

