CREATE DATABASE if not exists OficinaMecanica;
USE OficinaMecanica;

-- tabela cliente
create table Cliente(
		idCliente INT PRIMARY KEY AUTO_INCREMENT,
        nome VARCHAR(45) NOT NULL,
        endereco VARCHAR(45),
        telefone VARCHAR(20),
        cpf VARCHAR(14),
        email VARCHAR(45)
);

-- tabela veículo
create table Veiculo(
			placa VARCHAR(10) PRIMARY KEY NOT NULL,
            modelo VARCHAR(45), 
            marca VARCHAR(45),
            ano INT,
            cor VARCHAR(45),
            idCliente INT,
            FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- tabela de referencia mão de obra
create table TabelaDeReferenciaMaoDeObra(
				idTabelaDeObra VARCHAR(45) PRIMARY KEY,
                descricaoServico VARCHAR(100) NOT NULL,
                valorObra DECIMAL(10,2) NOT NULL
);

-- tabela serviço
create table Servico(
			idServico INT PRIMARY KEY AUTO_INCREMENT,
            descricao VARCHAR(100) NOT NULL,
            TabelaDeReferencia_idTabelaDeObra VARCHAR(45),
            FOREIGN KEY (TabelaDeReferencia_idTabelaDeObra) REFERENCES TabelaDeReferenciaMaoDeObra(idTabelaDeObra)
);

-- tabela ordem de serviço
create table OrdemDeServico(
			idOrdemServico INT PRIMARY KEY AUTO_INCREMENT,
            dataEmissao DATE NOT NULL,
            valor DECIMAL(10, 2),
            status VARCHAR(20),
            dataConclusao DATE,
            placaVeiculo VARCHAR(10),
            idCliente INT,
            FOREIGN KEY (placaVeiculo) REFERENCES Veiculo(placa),
            FOREIGN KEY ( idCliente) REFERENCES Cliente(idCliente)
);

-- tabela ordem de serviço_serviço
create table OrdemDeServico_servico(
			ordemDeServico_numero INT,
            servico_idServico INT,
            PRIMARY KEY (ordemDeServico_numero, servico_idServico),
            FOREIGN KEY (ordemDeServico_numero) REFERENCES OrdemDeServico(idOrdemServico),
            FOREIGN KEY (servico_idServico) REFERENCES Servico(idServico)
);

-- tabela mecanico
create table Mecanico(
			idMecanico INT PRIMARY KEY AUTO_INCREMENT,
            nome VARCHAR(100) NOT NULL,
            cpf VARCHAR(14) UNIQUE,
            endereco VARCHAR(100),
            especialidade VARCHAR(50)
);

-- tabela mecanico ordem de serviço
create table MecanicoOrdemDeServico(
			mecanico_codigo INT,
            ordemDeServico_numero INT,
            PRIMARY KEY (mecanico_codigo, ordemDeServico_numero),
            FOREIGN KEY (mecanico_codigo) REFERENCES Mecanico(idMecanico),
            FOREIGN KEY (ordemDeServico_numero) REFERENCES OrdemDeServico(idOrdemServico)
);

-- tabela peça 
create table Peca(
			idPeca INT PRIMARY KEY AUTO_INCREMENT,
            nome VARCHAR(100) NOT NULL,
            valorUnitario DECIMAL(10, 2)
);

-- tabela ordem de serviço-peça
create table OrdemDeServicoPeca(
			ordemDeServico_numero INT,
            peca_codigo INT,
            quantidade INT NOT NULL DEFAULT 1,
            PRIMARY KEY (ordemDeServico_numero, peca_codigo),
            FOREIGN KEY (ordemDeServico_numero) REFERENCES OrdemDeServico(idOrdemServico),
            FOREIGN KEY (peca_codigo) REFERENCES Peca(idPeca)
);
 
-- persistencia de dados
--
-- inserindo dados na tabela Cliente  
INSERT INTO Cliente (nome, endereco, telefone, cpf, email) VALUES ('João Silva','Rua A, 123','1234-5678','123.456.789-00','joao.silva@email.com'),
																  ('Maria Souza','AV. B, 456','9876-','123.456.789-00','joao.silva@email.com'),
                                                                  ('Carlos Oliveira','Travessa C, 789','5555-1212','111.222.333-44','carlos.oliveira@email.com');
desc Cliente;
																
	-- inserindo dados na tabela veiculo
    INSERT INTO Veiculo (placa, modelo, marca, ano, cor, idCliente) VALUES ('ABC-1234','Gol','Volkswagen',2015,'Prata',1),
																		   ('DEF-5678','Uno','Fiat',2018,'Vermelho',2),
																		   ('GHI-9012','Civic','Honda',2020,'Branco',1),
																		   ('JKL-2456','Palio','Fiat',2016,'Azul',3);
desc Veiculo;
  
  -- inserindo dados na tabela referencia mão de obra
  INSERT INTO TabelaDeReferenciaMaoDeObra (idTabelaDeObra, descricaoServico, valorObra) VALUES ('HR-001','Troca de Óleo',50.00),
																							   ('HR-002','Revisão Geral',150.00),
																							   ('HR-003','Troca de Pneus',80.00),
																							   ('HR-004','Alinhamento e Balanceamento',70.00);
    
-- inserindo dados na tabela Serviço
INSERT INTO Servico (descricao, TabelaDeReferencia_idTabelaDeObra) VALUES ('Troca de óleo e filtro', 'HR-001'),
																		  ('Revisão completa do veículo', 'HR-002'),
                                                                          ('Substituição de dois pneus', 'HR-003'),
                                                                          ('Alinhamento e balanceamento', 'HR-004');
desc Servico;

-- inserindo dados na tabela ordem de serviço
INSERT INTO OrdemDeServico (dataEmissao, valor, status, dataConclusao, placaVeiculo, idCliente) VALUES ('2024-04-01','120.0','Concluído','2024-04-01','ABC-1234',1),
																									   ('2024-04-05','250.0','Em andamento',NULL,'DEF-5678',2),
                                                                                                       ('2024-04-10','180.0','Concluído','2024-04-11','GHI-9012',1),
                                                                                                       ('2024-04-15','80.0','Pendente',NULL,'JKL-2456',3);
desc OrdemDeServico;
                                                                                                       
-- insaerindo dados na tabela OrdemDeServico_servico
INSERT INTO OrdemDeServico_servico (ordemDeServico_numero,  servico_idServico) VALUES (9, 1),
																					  (10, 2),
                                                                                      (11, 3),
                                                                                      (12, 4);
desc OrdemDeServico_servico;
 
-- inserindo dados na tabela Mecanico
INSERT INTO Mecanico (nome, cpf, endereco, especialidade) VALUES ('Pedro Alves','444.555.666-77','Rua x, 10','Motor'),
																 ('Ana Paula','777.888.999-00','Av. Y, 20','Suspensão'),
                                                                 ('Ricardo Gomes','222.333.444-55','Travessa Z, 30','Elétrica');
desc  Mecanico;
                                                                 
-- inserindo dados na tabela mecanico ordem de serviço 
INSERT INTO MecanicoOrdemDeServico (mecanico_codigo, ordemDeServico_numero) VALUES  (1, 9),
																				    (2, 10),
																				    (1, 11),
																					(3, 10);
desc MecanicoOrdemDeServico;
                                                                                    
                                                                                    
-- inserindo dados na tabela Peca
INSERT INTO Peca (nome, valorUnitario) VALUES ('Filtro de Óleo',25.0),
											  ('Óleo de Motor 5W30 (Litro)',40.0),
                                              ('Pneu Aro 14',150.0),
                                              ('Amortecedor Dianteiro',120.0);
desc Peca;
											
-- inserindo dados na tabela 
  INSERT INTO OrdemDeServicoPeca (ordemDeServico_numero,  peca_codigo, quantidade)  VALUES (9, 1, 1),      
																						   (10, 2, 1),
                                                                                           (11, 3, 2),
                                                                                           (12, 4, 1);
  desc OrdemDeServicoPeca;    
  
  
  -- 1. Recuperação simples com SELECT Statement:
  -- listar todos os campos de todos os clientes
  select * from Cliente; 
  
  -- listar apenas o nome e o telefone dos mecânicos
  SELECT nome, telefone FROM Cliente;
  
  -- listar a descrição e o valor da mão de obra da tabela de referência
  SELECT descricaoServico, valorObra FROM TabelaDeReferenciaMaoDeObra;
  
  
  -- 2. filtros com WHERE Statement
  -- listar os veiculos fabricados após o ano de 2017
  select * from Veiculo where ano > 2017;
  
  -- listar as ordens de serviço com status 'Pendente'
  select * from OrdemDeServico where status = 'Pendente';
  
  -- listar os serviços que utilizam uma referencia de mão de obra especifica (HR-002)
  select * from Servico where TabelaDeReferencia_idTabelaDeObra = 'HR-002';
  
  -- 3. expressões para gerar atributos derivados
  -- Calcular o valor total de cada ordem de serviço, considerando o valor do serviço (da tabela OrdemDeServico)
   -- e o custo da mão de obra associada (da tabela TabelaDeReferenciaMaoDeObra atraves da tabela Servico)
  SELECT
		os.idOrdemServico,
        os.dataEmissao,
        os.valor AS valor_servico_base,
        t.valorObra AS custo_mao_de_obra,
        os.valor + t.valorObra AS valor_total_estimado
from OrdemDeServico os
join OrdemDeServico_servico oss ON os.idOrdemServico = oss.OrdemDeServico_numero
join Servico s ON oss.servico_idservico = s.idservico
join TabelaDeReferenciaMaoDeObra t ON s.TabelaDeReferencia_idTabelaDeObra = t.idTabelaDeObra;

  -- exibir o nome do cliente e o tempo desde a emissão da ordem de serviço 
  SELECT
		c.nome AS nome_cliente,
        DATE(os.dataEmissao) AS data_emissao,
        DATEDIFF (CURRENT_DATE(), os.dataEmissao) AS dias_desde_emissao
 from Cliente c
JOIN OrdemDeServico os ON c.idCliente = os.idCliente; 
        
  
  -- 4. ordenação dos dados com ORDER BY:
  -- listar os clientes em ordem alfabética decrescente por nome
  SELECT * FROM Cliente ORDER BY nome DESC;
  
  -- listar as ordens de serviço da mais antiga para a mais recente
  SELECT * FROM OrdemDeServico ORDER BY dataEmissao ASC;
  
  -- listar as peças com valor unitário do mais caro para o mais barato
  SELECT *  FROM Peca ORDER BY valorUnitario DESC;
  
  
  -- 5.  HAVING Statement:
  -- encontrar os clientes que tem mais de uma ordem de serviço registrada
  SELECT
		c.nome AS nome_cliente,
        COUNT(os.idOrdemServico) AS numero_ordens
FROM Cliente c
JOIN OrdemDeServico os ON c.idCliente = os.idCliente
GROUP BY c.nome
HAVING COUNT(os.idOrdemServico) > 1;

-- encontrar mecânicos que trabalham em mais de uma ordem de serviço
SELECT
	 m.nome AS nome_mecanico,
     COUNT(mos.OrdemDeServico_numero) AS numero_ordens
FROM Mecanico m
JOIN MecanicoOrdemDeServico mos ON m.idMecanico = mos.mecanico_codigo
GROUP BY m.nome
HAVING COUNT(mos.OrdemDeServico_numero) > 1;

-- encontrar os serviços que aparecem em mais de uma ordem de serviço 
SELECT
		s.descricao AS descricao_servico,
        COUNT(oss.OrdemDeServico_numero) AS numero_ocorrencias
FROM Servico s
JOIN OrdemDeServico_servico oss ON  s.idservico = oss.servico_idservico
GROUP BY s.descricao
HAVING COUNT(oss.OrdemDeServico_numero) > 1;


-- 6. perspectiva mais complexa dos dados
-- listar o nome do cliente, a placa do veículo e a descrição do serviço para cada ordem de serviço 
 SELECT
		c.nome AS nome_cliente,
        v.placa AS placa_veiculo,
        s.descricao AS descricao_servico
FROM OrdemDeServico os
JOIN Cliente c ON os.idCliente = c.idCliente
JOIN Veiculo v ON os.placaVeiculo = v.placa
JOIN OrdemDeServico_servico oss ON os.idOrdemServico = oss.OrdemDeServico_numero
JOIN Servico s ON oss.servico_idservico = s.idservico;
        
-- listar o nome do mecânico e as placas dos veículos em que ele trabalhou
SELECT
	m.nome AS nome_mecanico,
    GROUP_CONCAT(v.placa SEPARATOR ', ') AS placa_veiculos
FROM Mecanico m
JOIN MecanicoOrdemDeServico mos ON m.idMecanico = mos.mecanico_codigo
JOIN OrdemDeServico os ON mos.OrdemDeServico_numero = os.idOrdemServico
JOIN Veiculo v ON os.placaVeiculo = v.placa
GROUP BY m.nome;

-- listar o nome do cliente ,  a placa do veículo e as peças utilizadas em cada ordem de serviço, incluindo a quantidade e o valor unitario da peça
SELECT
	c.nome 	AS nome_cliente,
    v.placa AS placa_veiculo,
    os.idOrdemServico,
    p.nome AS nome_peca,
    op.quantidade,
    p.valorUnitario,
    (op.quantidade * p.valorUnitario) AS valor_total_peca
FROM Cliente c
JOIN Veiculo v ON c.idCliente = v.idCliente
JOIN OrdemDeServico os ON v.placa = os.placaVeiculo
JOIN OrdemDeServicoPeca op ON os.idOrdemServico = op.OrdemDeservico_numero
JOIN Peca p ON op.peca_codigo = p.idPeca;

-- listar as ordens de serviço e o custo  estimasdo da mão de obra associada
SELECT
	os.idOrdemServico,
    os.dataEmissao,
    t.descricaoServico AS tipo_mao_de_obra,
    t.valorObra AS custo_mao_de_obra
FROM OrdemDeServico os
JOIN OrdemDeServico_servico oss ON os.idOrdemServico = oss.OrdemDeServico_numero
JOIN Servico s ON oss.servico_idservico = s.idservico
JOIN TabelaDeReferenciaMaoDeObra t ON s.TabelaDeReferencia_idTabelaDeObra = t.idTabelaDeObra;   


-- Atributo Derivado e Junção:
-- Listar o nome do cliente, a placa do veículo e o valor total gasto em serviços por cada veículo.
-- Pergunta: Qual cliente gastou mais em serviços para cada um de seus veículos?
SELECT
    c.nome AS nome_cliente,
    v.placa AS placa_veiculo,
    SUM(t.valorObra) AS total_gasto_em_servicos
FROM CLIENTE c
JOIN VEICULO v ON c.idCliente = v.idCliente
JOIN ORDEMDESERVICO os ON v.placa = os.placaVeiculo
JOIN ORDEMDESERVICO_SERVICO oss ON os.idOrdemServico = oss.OrdemDeServico_numero
JOIN SERVICO s ON oss.servico_idservico = s.idservico
JOIN TabelaDeReferenciaMaoDeObra t ON s.TabelaDeReferencia_idTabelaDeObra = t.idTabelaDeObra
GROUP BY c.nome, v.placa
ORDER BY total_gasto_em_servicos DESC;
 
 
 -- Listar o nome dos mecânicos e as ordens de serviço (com data de emissão) em que trabalharam no ano de 2024, ordenado por data da ordem de serviço.
 -- Pergunta: Quais ordens de serviço foram realizadas por cada mecânico no ano passado?
SELECT
    m.nome AS nome_mecanico,
    os.idOrdemServico AS numero_os,
    os.dataEmissao
FROM MECANICO m
JOIN MECANICOORDEMDESERVICO mos ON m.idMecanico = mos.mecanico_codigo
JOIN ORDEMDESERVICO os ON mos.OrdemDeServico_numero = os.idOrdemServico
WHERE YEAR(os.dataEmissao) = 2024
ORDER BY os.dataEmissao ASC;


-- Listar os serviços que tiveram um custo total de mão de obra superior a R$ 100.
-- Pergunta: Quais serviços geraram um custo total de mão de obra mais alto?
SELECT
    s.descricao AS nome_servico,
    SUM(t.valorObra) AS custo_total_mao_de_obra,
    COUNT(oss.OrdemDeServico_numero) AS numero_vezes_realizado
FROM SERVICO s
JOIN TabelaDeReferenciaMaoDeObra t ON s.TabelaDeReferencia_idTabelaDeObra = t.idTabelaDeObra
JOIN ORDEMDESERVICO_SERVICO oss ON s.idservico = oss.servico_idservico
GROUP BY s.descricao
HAVING SUM(t.valorObra) > 100
ORDER BY custo_total_mao_de_obra DESC;


