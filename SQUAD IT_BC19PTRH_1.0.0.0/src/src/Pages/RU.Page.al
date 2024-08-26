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


            }
            group("Dados Complementares")
            {

                Caption = 'Dados Complementares';
                group("Valor Acrescentado Bruto (VAB) do ano de referência do relatório")
                {
                    Caption = 'Valor Acrescentado Bruto (VAB) do ano de referência do relatório';
                    field("Valor Acrescentado Bruto (VAB)"; Rec."Valor Acrescentado Bruto (VAB)")
                    {


                    }
                    field("Custos com Pessoal"; Rec."Custos com Pessoal")
                    {


                    }
                    field("Amortizações do Exercício"; Rec."Amortizações do Exercício")
                    {


                    }
                    field("Provisões do Exercício"; Rec."Provisões do Exercício")
                    {


                    }
                    field("Custos e Perdas Financeiras"; Rec."Custos e Perdas Financeiras")
                    {


                    }
                    field("Imposto sobre Rendimento"; Rec."Imposto sobre Rendimento")
                    {


                    }
                    field("Resultado Líquido do Exercício"; Rec."Resultado Líquido do Exercício")
                    {


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


                        }
                        field("Origem Enc. A- Subsídio Doen"; Rec."Origem Enc. A- Subsídio Doen")
                        {


                        }
                        field("Enc. Adm. Pensões Velhice"; Rec."Enc. Adm. Pensões Velhice")
                        {


                        }
                        field("Origem Enc. A- Pensões Velhice"; Rec."Origem Enc. A- Pensões Velhice")
                        {


                        }
                        field("Enc. Adm. Outras Prestações"; Rec."Enc. Adm. Outras Prestações")
                        {


                        }
                        field("Origem Enc. A- Outras Prestaç"; Rec."Origem Enc. A- Outras Prestaç")
                        {


                        }
                    }
                    group("Encargos suportados, mas não administrados, pela entidade empregadora")
                    {
                        Caption = 'Encargos suportados, mas não administrados, pela entidade empregadora';
                        field("Enc. não Adm. Subsídio por Doe"; Rec."Enc. não Adm. Subsídio por Doe")
                        {


                        }
                        field("Origem Enc. NA- Subsídio Doen"; Rec."Origem Enc. NA- Subsídio Doen")
                        {


                        }
                        field("Enc. não Adm. Pensões Velhice"; Rec."Enc. não Adm. Pensões Velhice")
                        {


                        }
                        field("Origem Enc. NA- Pensões Velhic"; Rec."Origem Enc. NA- Pensões Velhic")
                        {


                        }
                        field("Enc. não Adm. Outras Prestaç"; Rec."Enc. não Adm. Outras Prestaç")
                        {


                        }
                        field("Origem Enc. NA- Outras Prestaç"; Rec."Origem Enc. NA- Outras Prestaç")
                        {


                        }
                    }
                }
                field("Enc. de Acção e Apoio Social"; Rec."Enc. de Acção e Apoio Social")
                {


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


                        }
                        field("ForProf. Restanre Financia."; Rec."ForProf. Restanre Financia.")
                        {


                        }
                    }
                    group("Financiamento Externo à Entidade Empregadora")
                    {
                        Caption = 'Financiamento Externo à Entidade Empregadora';
                        field("ForProf. Fundo Social Europeu"; Rec."ForProf. Fundo Social Europeu")
                        {


                        }
                        field("ForProf. Outras Fontes Finan."; Rec."ForProf. Outras Fontes Finan.")
                        {


                        }
                    }
                }
            }
            group("Trabalho Suplementar")
            {
                Caption = 'Trabalho Suplementar';
                field("Trab. Suplementar visado"; Rec."Trab. Suplementar visado")
                {


                }
            }
            group("Trabalho Temporário")
            {
                Caption = 'Trabalho Temporário';
                field("Núm. Trab. Temp 31 Out"; Rec."Núm. Trab. Temp 31 Out")
                {


                }
                field("Núm. Trab. Temp 31 Dez"; Rec."Núm. Trab. Temp 31 Dez")
                {


                }
                field("Núm. Trab. Médio durante ano"; Rec."Núm. Trab. Médio durante ano")
                {


                }
                field("Entradas durante ano - H"; Rec."Entradas durante ano - H")
                {


                }
                field("Entradas durante ano - M"; Rec."Entradas durante ano - M")
                {


                }
                field("Saídas durante ano - H"; Rec."Saídas durante ano - H")
                {


                }
                field("Saídas durante ano - M"; Rec."Saídas durante ano - M")
                {


                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

