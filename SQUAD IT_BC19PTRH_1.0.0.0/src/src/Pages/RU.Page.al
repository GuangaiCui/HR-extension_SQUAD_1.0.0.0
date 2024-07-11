#pragma implicitwith disable
page 53165 RU
{
    PageType = Card;
    SourceTable = RU;
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            field(Ano; Rec.Ano)
            {
                ApplicationArea = All;

            }
            group("Dados Complementares")
            {

                Caption = 'Dados Complementares';
                group("Valor Acrescentado Bruto (VAB) do ano de referência do relatório")
                {
                    Caption = 'Valor Acrescentado Bruto (VAB) do ano de referência do relatório';
                    field("Valor Acrescentado Bruto (VAB)"; Rec."Valor Acrescentado Bruto (VAB)")
                    {
                        ApplicationArea = All;

                    }
                    field("Custos com Pessoal"; Rec."Custos com Pessoal")
                    {
                        ApplicationArea = All;

                    }
                    field("Amortizações do Exercício"; Rec."Amortizações do Exercício")
                    {
                        ApplicationArea = All;

                    }
                    field("Provisões do Exercício"; Rec."Provisões do Exercício")
                    {
                        ApplicationArea = All;

                    }
                    field("Custos e Perdas Financeiras"; Rec."Custos e Perdas Financeiras")
                    {
                        ApplicationArea = All;

                    }
                    field("Imposto sobre Rendimento"; Rec."Imposto sobre Rendimento")
                    {
                        ApplicationArea = All;

                    }
                    field("Resultado Líquido do Exercício"; Rec."Resultado Líquido do Exercício")
                    {
                        ApplicationArea = All;

                    }
                }
                group("Encargos com regimes complementares de protecção social")
                {
                    Caption = 'Encargos com regimes complementares de protecção social';
                    group("Encargos suportados e administrados, pela entidade empregadora")
                    {
                        Caption = 'Encargos suportados e administrados, pela entidade empregadora';
                        field("Enc. Adm. Subsídio por Doença"; Rec."Enc. Adm. Subsídio por Doença")
                        {
                            ApplicationArea = All;

                        }
                        field("Origem Enc. A- Subsídio Doen"; Rec."Origem Enc. A- Subsídio Doen")
                        {
                            ApplicationArea = All;

                        }
                        field("Enc. Adm. Pensões Velhice"; Rec."Enc. Adm. Pensões Velhice")
                        {
                            ApplicationArea = All;

                        }
                        field("Origem Enc. A- Pensões Velhice"; Rec."Origem Enc. A- Pensões Velhice")
                        {
                            ApplicationArea = All;

                        }
                        field("Enc. Adm. Outras Prestações"; Rec."Enc. Adm. Outras Prestações")
                        {
                            ApplicationArea = All;

                        }
                        field("Origem Enc. A- Outras Prestaç"; Rec."Origem Enc. A- Outras Prestaç")
                        {
                            ApplicationArea = All;

                        }
                    }
                    group("Encargos suportados, mas não administrados, pela entidade empregadora")
                    {
                        Caption = 'Encargos suportados, mas não administrados, pela entidade empregadora';
                        field("Enc. não Adm. Subsídio por Doe"; Rec."Enc. não Adm. Subsídio por Doe")
                        {
                            ApplicationArea = All;

                        }
                        field("Origem Enc. NA- Subsídio Doen"; Rec."Origem Enc. NA- Subsídio Doen")
                        {
                            ApplicationArea = All;

                        }
                        field("Enc. não Adm. Pensões Velhice"; Rec."Enc. não Adm. Pensões Velhice")
                        {
                            ApplicationArea = All;

                        }
                        field("Origem Enc. NA- Pensões Velhic"; Rec."Origem Enc. NA- Pensões Velhic")
                        {
                            ApplicationArea = All;

                        }
                        field("Enc. não Adm. Outras Prestaç"; Rec."Enc. não Adm. Outras Prestaç")
                        {
                            ApplicationArea = All;

                        }
                        field("Origem Enc. NA- Outras Prestaç"; Rec."Origem Enc. NA- Outras Prestaç")
                        {
                            ApplicationArea = All;

                        }
                    }
                }
                field("Enc. de Acção e Apoio Social"; Rec."Enc. de Acção e Apoio Social")
                {
                    ApplicationArea = All;

                }
            }
            group("Dados Económicos")
            {

                Caption = 'Dados Económicos';
                group("Encargos de Formação Profissional")
                {
                    Caption = 'Encargos de Formação Profissional';
                    group("Montante Financiado pela Entidade Empregadora")
                    {
                        Caption = 'Montante Financiado pela Entidade Empregadora';
                        field("ForProf. Mont. Horas Form."; Rec."ForProf. Mont. Horas Form.")
                        {
                            ApplicationArea = All;

                        }
                        field("ForProf. Restanre Financia."; Rec."ForProf. Restanre Financia.")
                        {
                            ApplicationArea = All;

                        }
                    }
                    group("Financiamento Externo à Entidade Empregadora")
                    {
                        Caption = 'Financiamento Externo à Entidade Empregadora';
                        field("ForProf. Fundo Social Europeu"; Rec."ForProf. Fundo Social Europeu")
                        {
                            ApplicationArea = All;

                        }
                        field("ForProf. Outras Fontes Finan."; Rec."ForProf. Outras Fontes Finan.")
                        {
                            ApplicationArea = All;

                        }
                    }
                }
            }
            group("Trabalho Suplementar")
            {
                Caption = 'Trabalho Suplementar';
                field("Trab. Suplementar visado"; Rec."Trab. Suplementar visado")
                {
                    ApplicationArea = All;

                }
            }
            group("Trabalho Temporário")
            {
                Caption = 'Trabalho Temporário';
                field("Núm. Trab. Temp 31 Out"; Rec."Núm. Trab. Temp 31 Out")
                {
                    ApplicationArea = All;

                }
                field("Núm. Trab. Temp 31 Dez"; Rec."Núm. Trab. Temp 31 Dez")
                {
                    ApplicationArea = All;

                }
                field("Núm. Trab. Médio durante ano"; Rec."Núm. Trab. Médio durante ano")
                {
                    ApplicationArea = All;

                }
                field("Entradas durante ano - H"; Rec."Entradas durante ano - H")
                {
                    ApplicationArea = All;

                }
                field("Entradas durante ano - M"; Rec."Entradas durante ano - M")
                {
                    ApplicationArea = All;

                }
                field("Saídas durante ano - H"; Rec."Saídas durante ano - H")
                {
                    ApplicationArea = All;

                }
                field("Saídas durante ano - M"; Rec."Saídas durante ano - M")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

