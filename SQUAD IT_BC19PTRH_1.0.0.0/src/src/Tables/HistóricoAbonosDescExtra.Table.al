table 53107 "Histórico Abonos - Desc. Extra"
{
    DrillDownPageID = "Lista Hist. Abon. - Des. Extr.";
    LookupPageID = "Lista Hist. Abon. - Des. Extr.";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Empregado;
        }
        field(3; Data; Date)
        {
            Caption = 'Date';
        }
        field(8; "Payroll Item Code"; Code[20])
        {
            Caption = 'Cód. Rúbrica';
            TableRelation = "Payroll Item";
        }
        field(9; "Payroll Item Type"; Option)
        {
            Caption = 'Tipo Rubrica';
            OptionCaption = 'Abono,Desconto';
            OptionMembers = Abono,Desconto;
        }
        field(10; "Payroll Item Description"; Text[100])
        {
            Caption = 'Descrição Rubrica';
        }
        field(14; Quantity; Decimal)
        {
            Caption = 'Quantidade';
        }
        field(15; "Unit Value"; Decimal)
        {
            Caption = 'Valor Unitário';
        }
        field(16; "Total Amount"; Decimal)
        {
            Caption = 'Valor Total';
        }
        field(17; "Unit of Measure"; Code[20])
        {
            Caption = 'Unit Code';
            TableRelation = "Unid. Medida Recursos Humanos";
        }
        field(30; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(31; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(35; "Anular Falta"; Boolean)
        {
            Caption = 'Cancel Absence';
            Description = 'Para anular uma falta debitada por engano, no Fich SS';
        }
        field(36; "Reference Date"; Date)
        {
            Caption = 'Data a que se refere o Mov.';
            Description = 'Para aparecer no Fic. Seg. Social com a data do mês a que se refere a falta ou acerto de venc, etc...';
        }
        field(50; "Processamento Referencia"; Code[10])
        {
            Description = 'Usado na abertura processamento';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Employee No.", "Reference Date")
        {
        }
    }

    fieldgroups
    {
    }
}

