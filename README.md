Detecção de Faltas de Alta Impedância com RNA — Implementação em PSCAD
Este repositório contém os códigos de implementação da rede neural artificial (RNA) utilizada no detector de faltas de alta impedância (FAI) do Trabalho de Conclusão de Curso de Engenharia Elétrica da EESC-USP.

A RNA foi treinada no MATLAB e embarcada no PSCAD por meio de uma sub-rotina em linguagem C, chamada a partir de um script em FORTRAN. O mesmo código em C também foi adaptado para o microcontrolador Texas Instruments F28379D nos testes em Hardware-in-the-Loop (HIL) com o RTDS.

Estrutura do repositório:

├── AUX_CSUB.f90      # Interface FORTRAN 90 para chamada da sub-rotina em C no PSCAD
├── test_csub.c       # Implementação da RNA em C (pesos, bias, ativações)
└── README.md
Arquivos
AUX_CSUB.f90
Script em FORTRAN 90 que faz a interface entre o PSCAD e o código em C. Define a assinatura da sub-rotina, os atributos de passagem por referência e realiza a chamada.

Entrada: in(7) — vetor com as amplitudes das harmônicas (1ª a 7ª) da corrente de sequência zero.

Saída: out(2) — vetor com as duas saídas da RNA (FAI e não FAI).

A integração é feita via compilação conjunta com o PSCAD, conforme a documentação oficial de interface com código C.

test_csub.c
Implementação da RNA em linguagem C. Contém:

Funções de ativação: relu e softmax;

Normalização zscore: médias e desvios padrão das 6 harmônicas de entrada, aplicadas no início da função;

Matrizes de pesos e bias: camada oculta (50 neurônios) e camada de saída (2 neurônios);

Propagação direta: cálculo das ativações e classificação final.

A rede tem a seguinte arquitetura:

Camada	Neurônios	Ativação
Entrada	6	—
Oculta	50	ReLU
Saída	2	Softmax
Contexto do trabalho
Objetivo: detectar faltas de alta impedância em sistemas de distribuição usando redes neurais artificiais, com validação em simulação (PSCAD) e em hardware (RTDS + microcontrolador).

Sistema elétrico: IEEE 34 barras, desequilibrado, com cargas distribuídas.

Dados de FAI: registros reais de campo (CARVALHO et al., 2015).

Extração de características: FFT, harmônicas de 2ª a 7ª da corrente de sequência zero.

Treinamento: MATLAB, algoritmo L-BFGS, validação hold-out (20%).

Mais detalhes estão disponíveis no documento do TCC.

Como usar
Compile o código em C junto com o script em FORTRAN no ambiente do PSCAD, seguindo a documentação de interface com código C.

Certifique-se de que as 6 harmônicas de entrada estão na mesma ordem usada no treinamento da RNA.

A saída res[0] indica FAI (1) ou não FAI (0); res[1] é o complementar.

Observações
O código em C contém duas implementações da RNA: uma de 10 neurônios na camada oculta (versão preliminar) e outra de 50 neurônios (versão final). Apenas a segunda é utilizada na saída — a primeira ficou como registro do desenvolvimento.

Os valores de médias e desvios padrão da normalização zscore estão hardcoded no início da função test_csub.

O mesmo código foi adaptado para o microcontrolador F28379D nos testes em HIL, com ajustes na interface de aquisição de sinais.
