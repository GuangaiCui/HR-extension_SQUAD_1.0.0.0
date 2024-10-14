table 53101 "RU - Tabelas"
{
    LookupPageID = "RU - Tabelas";

    fields
    {
        field(1; Tipo; Option)
        {
            //Caption = 'Type';
            OptionMembers = TEmp,AcInf,AcCon,AcFor,RF,RFMed,RQ,RQMed,RB,RBMed,RM,RMMed,RP,RPMed,"OR",ORMed,ExAd,ExP,ExO,ExC,ExCFR,Vac,ActDes,RDoeProf,DoeProf,SitAct,MotSit,AssEmp,OriEnc,MotHNTrab,RRef,TCont,RQMF,DTT,MEnt,AreaEdu,ModFor,EntFor,Cert,PRF,QualFor,Grv,Rvd,MotSai,CNP,SitFF;
        }
        field(2; "Código"; Code[20])
        {
            //Caption = 'Code';
        }
        field(3; "Descrição"; Text[250])
        {
            //Caption = 'Description';
        }
        field(4; "Classificação"; Text[10])
        {
            //Caption = 'Classification';
        }
        field(5; "Mot. Terminação"; Option)
        {
            //Caption = 'Termination Reason';
            OptionCaption = ' ,Iniciativa da Empresa durante o período exp.,Iniciativa do Trabalhador durante o período exp.,Mútuo Acordo,Despedimento impútavel ao Trabalhador,Despedimento Colectivo,Despedimento,Reforma p/ velhice,Reforma por Invalidez,Iniciativa do Trabalhador c/ justa causa,Iniciativa do Trabalhador c/ aviso,Iniciativa do Trabalhador s/ aviso,Cessação contr. termo certo,Cessação contr. termo incerto,Pré-Reforma,Sit. especial saida imped. prolong.';
            OptionMembers = " ","Inic Emp período exp.","Inic Trab período exp.","Mútuo Acordo","Desp Imp.Trab","Desp Colect",Desp,"Ref velhice","Ref Invali","Inic Trab justa causa","Inic Trab c aviso","Inic Trab s aviso","Ces contr. t-certo","Ces contr. t-incerto","Pré-Ref","Sit. esp. saida imped. prolong.";
        }
    }

    keys
    {
        key(Key1; Tipo, "Código", "Classificação")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Código", "Descrição", "Classificação")
        {
        }
    }
}

