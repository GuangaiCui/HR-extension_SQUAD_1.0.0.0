enum 53035 "Rubrica Salarial Genero"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; " ") { Caption = ' '; }
    value(1; "Vencimento Base") { Caption = 'Rúbrica de Vencimento Base'; }
    value(2; IRS) { Caption = 'Rúbrica de IRS'; }
    value(3; SS) { Caption = 'Rúbrica de Seg. Social'; }
    value(4; "Sub. Alimentação") { Caption = 'Rúbrica Sub. Alimentação'; }
    value(5; "IRS Sub. Férias") { Caption = 'Rúbrica IRS Sub. Férias'; }
    value(6; "IRS Sub. Natal") { Caption = 'Rúbrica IRS Sub. Natal'; }
    value(7; "Enc. SS") { Caption = 'Rúbrica Enc. Seg. Social'; }
    value(8; IVA) { Caption = 'Rúbrica IVA'; }
    value(9; CGA) { Caption = 'Rúbrica CGA'; }
    value(10; Falta) { Caption = 'Rúbrica Falta'; }
    value(11; "Hora Extra") { Caption = 'Rúbrica Hora Extra'; }
    value(12; "Enc. CGA") { Caption = 'Rúbrica Enc. CGA'; }
    value(13; Sindicato) { Caption = 'Sindicato'; }
    value(14; ADSE) { Caption = 'ADSE'; }
    value(15; "Admissão-Demissão") { Caption = 'Admissão-Demissão'; }
    value(16; "Enc. ADSE") { Caption = 'Enc. ADSE'; }
    value(17; DuoSF) { Caption = 'Duo. Sub. Férias'; }
    value(18; DuoSN) { Caption = 'Duo. Sub. Natal'; }
    value(19; "FCT-FGCT") { Caption = 'Fundo Compensação Trabalho / FGCT'; }

}

enum 53036 "Rubrica Salarial Genero Fecho"
{
    Extensible = true;
    AssignmentCompatibility = true;


    value(0; " ") { Caption = ' '; }
    value(1; "Indem. Mútuo Acordo ou Despedimento") { Caption = 'Indem. Mútuo Acordo ou Despedimento'; }
    value(2; "Indem. Falta Aviso Prévio do Empregado") { Caption = 'Indem. Falta Aviso Prévio do Empregado'; }
    value(3; "Indem. Falta Aviso Prévio da Empresa") { Caption = 'Indem. Falta Aviso Prévio da Empresa'; }
    value(4; "Compensação fim contrato") { Caption = 'Compensação fim contrato'; }
    value(5; "Férias não gozadas") { Caption = 'Férias não gozadas'; }
    value(6; "Proporcional Sub. Férias") { Caption = 'Proporcional Sub. Férias'; }
    value(7; "Proporcional Sub. Natal") { Caption = 'Proporcional Sub. Natal'; }
    value(8; "Sub. Férias Ano Anterior") { Caption = 'Sub. Férias Ano Anterior'; }
    value(9; "Prop. Férias") { Caption = 'Prop. Férias'; }
    value(10; "Cred. Formacao") { Caption = 'Crédito Formação'; }
}

enum 53037 "Rubrica Salarial Nat. Rem."
{
    Extensible = true;
    AssignmentCompatibility = true;


    value(0; " ") { Caption = ' '; }
    value(1; "Cód. Comissões") { Caption = 'Comissões - C'; }
    value(2; "Cód. Sub. Férias") { Caption = 'Cód. Sub. Férias - F'; }
    value(3; "Cód. Sub. Natal") { Caption = 'Cód. Sub. Natal - N'; }
    value(4; "Remuneração Permanente") { Caption = 'Remuneração Permanente - P'; }
    value(5; "Subsídios Reg. Não Mensal") { Caption = 'Subsídios Reg. Não Mensal - X'; }
    value(6; "Forças Armadas") { Caption = 'Forças Armadas'; }
    value(7; "Férias Pagas não Gozadas") { Caption = 'Férias Pagas não Gozadas - 2'; }
    value(8; "Diferenças de Vencimento") { Caption = 'Diferenças de Vencimento - 6'; }
    value(9; "Ajudas Custo e Trans.") { Caption = 'Ajudas Custo e Trans. - A'; }
    value(10; "Prémios-Bonus Mensal") { Caption = 'Prémios Bonus e outras Prest. Mensais - B'; }
    value(11; "Compensação") { Caption = 'Compensação Cessação Contrato - D'; }
    value(12; "Honorários") { Caption = 'Honorários - H'; }
    value(13; "Subsídios regulares") { Caption = 'Subsídios Regulares Mensais - M'; }
    value(14; "Prémios-bonus Não mensal") { Caption = 'Prémios Bonus e outras Prest. Não Mensais - O'; }
    value(15; "Sub. Ref.") { Caption = 'Sub. Ref. - R'; }
    value(16; "Trab. Supl.") { Caption = 'Trab. Supl. - S'; }
    value(17; "Trab. Noct.") { Caption = 'Trab. Noct. - T'; }
    value(18; "Compensação Cont. Intermitente") { Caption = 'Compensação Cont. Intermitente - I'; }
}

enum 53038 "Period Type"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; Day) { Caption = 'Day'; }
    value(1; "Week") { Caption = 'Week'; }
    value(2; "Quarter") { Caption = 'Quarter'; }
    value(3; "Year") { Caption = 'Year'; }
    value(4; "Accounting Period") { Caption = 'Accounting Period'; }
}

enum 53039 EmployeeStatus
{
    Extensible = true;

    value(0; Active) { Caption = 'Active'; }
    value(1; "Inactive") { Caption = 'Inactive'; }
    value(2; "Terminated") { Caption = 'Terminated'; }
}