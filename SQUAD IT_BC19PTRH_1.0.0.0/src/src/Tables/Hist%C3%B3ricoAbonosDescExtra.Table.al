table 53107 "Histórico Abonos - Desc. Extra"
{
    DrillDownPageID = "Lista Hist. Abon. - Des. Extr.";
    LookupPageID = "Lista Hist. Abon. - Des. Extr.";

    fields
    {
        field(1; "No. Mov."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "No. Empregado"; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Empregado;
        }
        field(3; Data; Date)
        {
            Caption = 'Date';
        }
        field(8; "Cód. Rubrica"; Code[20])
        {
            Caption = 'Salary Item Code';
            TableRelation = "Rubrica Salarial";
        }
        field(9; "Tipo Rubrica"; Option)
        {
            Caption = 'Salary Item Type';
            OptionCaption = 'Abono,Desconto';
            OptionMembers = Abono,Desconto;
        }
        field(10; "Descrição Rubrica"; Text[100])
        {
            Caption = 'Salary Item Description';
        }
        field(14; Quantidade; Decimal)
        {
            Caption = 'Quantity';
        }
        field(15; "Valor Unitário"; Decimal)
        {
            Caption = 'Unit Value';
        }
        field(16; "Valor Total"; Decimal)
        {
            Caption = 'Total Amount';
        }
        field(17; UnidadeMedida; Code[20])
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
        field(36; "Data a que se refere o Mov."; Date)
        {
            Caption = 'Reference Date';
            Description = 'Para aparecer no Fic. Seg. Social com a data do mês a que se refere a falta ou acerto de venc, etc...';
        }
        field(50; "Processamento Referencia"; Code[10])
        {
            Description = 'Usado na abertura processamento';
        }
    }

    keys
    {
        key(Key1; "No. Mov.")
        {
            Clustered = true;
        }
        key(Key2; "No. Empregado", "Data a que se refere o Mov.")
        {
        }
    }

    fieldgroups
    {
    }
}

