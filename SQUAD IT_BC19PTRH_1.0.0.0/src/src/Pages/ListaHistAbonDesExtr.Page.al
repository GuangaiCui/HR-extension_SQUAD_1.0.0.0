#pragma implicitwith disable
page 53097 "Lista Hist. Abon. - Des. Extr."
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Histórico Abonos - Desc. Extra";

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
                field("Payroll Item Code"; Rec."Payroll Item Code")
                {


                }
                field("Payroll Item Type"; Rec."Payroll Item Type")
                {


                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {


                }
                field(Quantity; Rec.Quantity)
                {


                }
                field("Unit Value"; Rec."Unit Value")
                {


                }
                field("Total Amount"; Rec."Total Amount")
                {


                }
                field("Anular Falta"; Rec."Anular Falta")
                {


                }
                field("Reference Date"; Rec."Reference Date")
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
    }
}

#pragma implicitwith restore

