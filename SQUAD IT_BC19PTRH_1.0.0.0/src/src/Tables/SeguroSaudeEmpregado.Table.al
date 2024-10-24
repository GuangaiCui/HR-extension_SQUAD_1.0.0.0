table 53128 "Seguro Saude Empregado"
{
    DataCaptionFields = "Employee No.", "Nome Empregado";
    DrillDownPageID = "Seg Saude Empregado";
    LookupPageID = "Seg Saude Empregado";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = Empregado;

            trigger OnValidate()
            begin
                if Empregado.Get("Employee No.") then
                    "Nome Empregado" := Empregado.Name;
            end;
        }
        field(2; "No. Linha"; Integer)
        {
        }
        field(5; "Nome Empregado"; Text[75])
        {
        }
        field(6; "No. Seguro"; Text[30])
        {

        }
        field(7; Parentesco; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Familiar;

            trigger OnValidate()
            begin
                FamiliarEmp.Reset;
                FamiliarEmp.SetRange("Employee No.", "Employee No.");
                FamiliarEmp.SetRange("Relative Code", Parentesco);
                if FamiliarEmp.FindFirst then
                    "Nome Beneficiário" := FamiliarEmp.Name;
            end;
        }
        field(8; "Nome Beneficiário"; Text[150])
        {
        }
        field(9; "Data Inclusão"; Date)
        {
        }
        field(10; "Data Exclusão"; Date)
        {
        }
        field(11; Tipo; Option)
        {
            OptionMembers = "Saúde",Vida;
        }
        field(20; "Valor Anual"; Decimal)
        {
        }
        field(21; "Valor Suportado pela Empresa"; Decimal)
        {
        }
        field(22; "Valor Suportado pelo Colab."; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", "No. Linha")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*
        rSegSaude.RESET;
        rSegSaude.setrange(rSegSaude."Employee No.", "Employee No.");
        if not rSegSaude.FINDFIRST then begin
          rSegSaude.INIT;
          rSegSaude."Employee No." := "Employee No.";
          rSegSaude."Nome Empregado"
          rSegSaude."No. Médis"
          rSegSaude."Data Inclusão"
          rSegSaude."Data Exclusão"
          rSegSaude.INSERT;
        end;
         */

    end;

    var
        Empregado: Record Empregado;
        FamiliarEmp: Record "Familiar Empregado";
}

