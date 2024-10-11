table 53094 "Consultas Médicas Empregado"
{
    LookupPageID = "Consultas Médicas Empregado";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'No. Empregado';
            TableRelation = Empregado."No.";
        }
        field(3; "Data Consulta"; Date)
        {
            //Caption = 'Date of Medical Appointment';

            trigger OnValidate()
            begin
                //Eurotrials
                rEmpregado.Reset;
                if (rEmpregado.Get("Employee No.")) and (rEmpregado."Birth Date" <> 0D) then begin
                    I := Today - rEmpregado."Birth Date";
                    if (I / 365) > 50 then
                        NovaData := CalcDate('+1A', "Data Consulta")
                    else
                        NovaData := CalcDate('+2A', "Data Consulta");

                    if Date2DWY(NovaData, 1) = 6 then NovaData := CalcDate('+2D', NovaData);
                    if Date2DWY(NovaData, 1) = 7 then NovaData := CalcDate('+1D', NovaData);
                    "Data Próxima Consulta" := NovaData;
                end;
            end;
        }
        field(12; "Data Próxima Consulta"; Date)
        {
            //Caption = 'Next Medical Appointment';
        }
        field(13; Resultado; Option)
        {
            //Caption = 'Conclusion';
            OptionCaption = ' ,Apto,Inapto,Outro';
            OptionMembers = " ",Apto,Inapto,Outro;
        }
        field(14; "No. de Diagnóstico"; Text[30])
        {
            //Caption = 'Diagnostic No.';
        }
        field(15; "Observações"; Text[250])
        {
            //Caption = 'Observations';
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Data Consulta")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        rEmpregado: Record Empregado;
        I: Integer;
        NovaData: Date;
}

