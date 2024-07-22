table 53066 "Horário Empregado"
{
    // //C+ -LCF-  21.05.2008
    // //tive de alterar a chave para "Nº Empregado,Data Iníco Horário,Data Fim Horário"

    DataCaptionFields = "No. Empregado";
    DrillDownPageID = "Lista Horário Empregado";
    LookupPageID = "Lista Horário Empregado";

    fields
    {
        field(1; "No. Empregado"; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
        }
        field(2; "No. Linha"; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Cód. Horário"; Code[20])
        {
            Caption = 'Schedule code';
            TableRelation = "Horário RH";

            trigger OnValidate()
            begin
                TabHorário.Get("Cód. Horário");
                Descrição := TabHorário.Descrição;
            end;
        }
        field(4; "Descrição"; Text[100])
        {
            Caption = 'Description';
        }
        field(5; "Data Iníco Horário"; Date)
        {
            Caption = 'Schedule Start Date';
        }
        field(6; "Data Fim Horário"; Date)
        {
            Caption = 'Schedule End Date';
        }
        field(9; "Dia da Semana"; Option)
        {
            Caption = 'Weekday';
            OptionCaption = ' ,Segunda,Terça,Quarta,Quinta,Sexta';
            OptionMembers = " ",Segunda,"Terça",Quarta,Quinta,Sexta;
        }
        field(10; "Mês"; Option)
        {
            Caption = 'Month';
            OptionCaption = ' ,Janeiro,Fevereiro,Março,Abril,Maio,Junho,Julho,Agosto,Setembro,Outubro,Novembro,Dezembro';
            OptionMembers = " ",Janeiro,Fevereiro,"Março",Abril,Maio,Junho,Julho,Agosto,Setembro,Outubro,Novembro,Dezembro;
        }
        field(11; "Organização Tempo Trabalho"; Option)
        {
            Caption = 'Schedule Type';
            Description = 'RU';
            OptionCaption = ' ,Horário de trabalho fixo,Horário de trabalho flexível,Horário de trabalho móvel,Horário de trabalho por turnos fixos,Horário de trabalho por turnos rotativos';
            OptionMembers = " ","1","2","3","4","5";
        }
    }

    keys
    {
        key(Key1; "No. Empregado", "Cód. Horário", "No. Linha")
        {
            Clustered = true;
        }
        key(Key2; "No. Empregado", "Mês", "Dia da Semana")
        {
        }
        key(Key3; "No. Empregado", "Data Iníco Horário", "Data Fim Horário")
        {
        }
        key(Key4; "No. Empregado", "Data Iníco Horário", "Dia da Semana")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*
        //Perguntar ao utilizador se quer actualizar na tabela empregado o campo Nº horas Semanais com o valor do horário escolhido
        
        TabHorário.GET("Cód. Horário");
        TabEmpregado.GET("Nº Empregado");
        
        IF ("Cód. Horário" <> TabEmpregado."Cód. Horário")  THEN BEGIN
           Pergunta := 'Quer actualizar o Horário na Ficha do empregado de ' + FORMAT(TabEmpregado."Cód. Horário")
                       + ' para ' +  FORMAT("Cód. Horário") + ' ?';
           IF CONFIRM(Pergunta) THEN BEGIN
              TabEmpregado.VALIDATE(TabEmpregado."Cód. Horário", "Cód. Horário");
              TabEmpregado.MODIFY;
           END;
        END;
        
        
        IF (TabHorário."Nº Horas Semanais" <>0) AND (TabHorário."Nº Horas Semanais" <> TabEmpregado."Nº Horas Semanais") THEN BEGIN
           Pergunta := 'Quer actualizar o Nº Horas Semanais na Ficha do empregado de ' + FORMAT(TabEmpregado."Nº Horas Semanais")
                       + ' para ' +  FORMAT(TabHorário."Nº Horas Semanais") + ' ?';
           IF CONFIRM(Pergunta) THEN BEGIN
              TabEmpregado.VALIDATE(TabEmpregado."Nº Horas Semanais", TabHorário."Nº Horas Semanais");
              TabEmpregado.MODIFY;
           END;
        END;
        */

    end;

    var
        "TabHorário": Record "Horário RH";
        TabEmpregado: Record Employee;
        Pergunta: Text[200];
}

