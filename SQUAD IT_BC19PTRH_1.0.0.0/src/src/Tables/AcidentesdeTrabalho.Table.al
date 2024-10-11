table 53083 "Acidentes de Trabalho"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'No. Mov.';
        }
        field(4; "Employee No."; Code[20])
        {
            Caption = 'No Empregado';
            TableRelation = Empregado;

            trigger OnValidate()
            begin
                TabEmpregado.Reset;
                if TabEmpregado.Get("Employee No.") then
                    Nome := TabEmpregado.Name
                else
                    Nome := '';
            end;
        }
        field(5; Nome; Text[75])
        {
            //Caption = 'Name';
        }
        field(6; "Data Acidente"; Date)
        {
            //Caption = 'Accident Date';
        }
        field(7; "Hora Acidente"; Time)
        {
            //Caption = 'Accident Tme';
        }
        field(8; "Local Acidente"; Option)
        {
            //Caption = 'Accident Local';
            OptionMembers = "Nas Instalações da Empresa","Fora das Instalações da Empresa","Nos Meios de Transporte";
        }
        field(10; "Cód. Localização"; Code[10])
        {
            //Caption = 'Location Code';
            TableRelation = "Cód. Freguesia/Conc/Distrito"."Código";

            trigger OnValidate()
            begin
                TabLocalidades.Reset;
                if TabLocalidades.Get("Cód. Localização") then
                    Localização := TabLocalidades.Freguesia
                else
                    Localização := '';
            end;
        }
        field(11; "Localização"; Text[30])
        {
            //Caption = 'Location Code';
        }
        field(14; "Descrição Acidente"; Text[250])
        {
            //Caption = 'Accident Description';
        }
        field(15; "Dias de trabalho perdidos"; Option)
        {
            //Caption = 'Workdays Lost';
            OptionCaption = 'Inferior a 1 dia (sem dar lugar a baixa),1 a 3 dias de baixa,4 a 30 dias de baixa,Superior a 30 dias baixa,Mortal';
            OptionMembers = inf1,"1a3","4a30",Sup30,Mortal;
        }
        field(16; "Data ínicio da interrupção"; Date)
        {
            //Caption = 'Stop Start Date';
        }
        field(17; "Data fim da interrupção"; Date)
        {
            //Caption = 'Stop End Date';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        TabEmpregado: Record Empregado;
        TabLocalidades: Record "Cód. Freguesia/Conc/Distrito";
}

