table 53119 "Actividades dos Serviços"
{

    fields
    {
        field(1; "No. Mov."; Integer)
        {
            AutoIncrement = true;
            Caption = 'No. Mov.';
        }
        field(5; "Data Actividade"; Date)
        {
            Caption = 'Data Actividade';
        }
        field(6; Actividade; Option)
        {
            Caption = 'Actividade';
            OptionCaption = 'Programa de Prevenção de Riscos Profissionais,Programa de Promoção da Saúde,Programa de Vigilância da Saúde,Realização de Auditoria,Realização de Inspecção';
            OptionMembers = "Programa de Prevenção de Riscos Profissionais","Programa de Promoção da Saúde","Programa de Vigilância da Saúde","Realização de Auditoria","Realização de Inspecção";
        }
        field(7; "Descrição Actividade"; Text[250])
        {
            Caption = 'Descrição da Actividade';
        }
    }

    keys
    {
        key(Key1; "No. Mov.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

