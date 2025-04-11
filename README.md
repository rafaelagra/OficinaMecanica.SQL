# Projeto de Banco de Dados para Gestão de Oficina Mecânica

## 🚀 Sobre o Projeto

Este projeto consiste na modelagem e implementação de um banco de dados relacional desenvolvido como parte do Bootcamp Heineken Coding the Future. O objetivo principal é criar uma estrutura eficiente e robusta para gerenciar as operações essenciais de uma oficina mecânica. O sistema visa otimizar o controle de clientes, veículos, ordens de serviço detalhadas, serviços especializados, mecânicos qualificados e o inventário de peças.

Este banco de dados servirá como a espinha dorsal para futuras aplicações que buscam automatizar e aprimorar a gestão da oficina, facilitando a organização, a tomada de decisões baseada em dados e a melhoria da experiência do cliente.

## 💾 Esquema do Banco de Dados

O esquema relacional deste projeto é composto por 10 tabelas cuidadosamente interligadas.

* Cliente
* Veiculo
* OrdemDeServico
* OrdemDeServico_servico
* Mecanico
* MecanicoOrdemDeServico
* Peca
* Servico
* OrdemDeServicoPdeca
* TabelaDeReferenciaMaoDeObra

## 📊 Queries Complexas

As seguintes consultas SQL complexas foram elaboradas para demonstrar a capacidade do banco de dados de responder a perguntas de negócios importantes:

1. **Análise de Gastos por Cliente/Veículo:**
    ```sql
    SELECT
        c.nome AS nome_cliente,
        v.placa AS placa_veiculo,
        SUM(t.valorObra) AS total_gasto_em_servicos
    FROM CLIENTE c
    JOIN VEICULO v ON c.idCliente = v.idCliente
    JOIN ORDEMDESERVICO os ON v.placa = os.placaVeiculo
    JOIN ORDEMDESERVICO_SERVICO oss ON os.idOrdemServico = oss.OrdemDeServico_numero
    JOIN SERVICO s ON oss.servico_idservico = s.idservico
    JOIN `TABELADE REFERENCIA MAO DE OBRA` t ON s.TabelaDeReferencia_idTabelaDeObra = t.idTabelaDeObra
    GROUP BY c.nome, v.placa
    ORDER BY total_gasto_em_servicos DESC;
    ```
    *Pergunta:* Qual cliente gastou mais em serviços para cada um de seus veículos?

2. **Atividade dos Mecânicos em 2024:**
    ```sql
    SELECT
        m.nome AS nome_mecanico,
        os.idOrdemServico AS numero_os,
        os.dataEmissao
    FROM MECANICO m
    JOIN MECANICOORDEMDESERVICO mos ON m.idMecanico = mos.mecanico_codigo
    JOIN ORDEMDESERVICO os ON mos.OrdemDeServico_numero = os.idOrdemServico
    WHERE YEAR(os.dataEmissao) = 2024
    ORDER BY os.dataEmissao ASC;
    ```
    *Pergunta:* Quais ordens de serviço foram realizadas por cada mecânico no ano de 2024?

3. **Serviços com Custo de Mão de Obra Elevado:**
    ```sql
    SELECT
        s.descricao AS nome_servico,
        SUM(t.valorObra) AS custo_total_mao_de_obra,
        COUNT(oss.OrdemDeServico_numero) AS numero_vezes_realizado
    FROM SERVICO s
    JOIN `TABELADE REFERENCIA MAO DE OBRA` t ON s.TabelaDeReferencia_idTabelaDeObra = t.idTabelaDeObra
    JOIN ORDEMDESERVICO_SERVICO oss ON s.idservico = oss.servico_idservico
    GROUP BY s.descricao
    HAVING SUM(t.valorObra) > 100
    ORDER BY custo_total_mao_de_obra DESC;
    ```
    *Pergunta:* Quais serviços tiveram um custo total de mão de obra superior a R$ 100?

## 🏆 Avaliação no Bootcamp
Este projeto demonstra a aplicação dos conceitos de modelagem de dados, a criação de um esquema relacional para uma oficina mecânica e a elaboração de queries complexas para análise de dados, conforme solicitado no Bootcamp Heineken Coding the Future.
