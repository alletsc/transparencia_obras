-- obra

SELECT 
id_obra, 
id_processo, 
id_licitacao, 
id_contrato, 
titulo, 
orgao_contratante, 
orgao_executor, 
objeto, 
favorecido, 
cnpj, 
modalidade
situacao,
ano_inicio_contrato,
data_assinatura_contrato,
data_inicio,
data_termino_previsto,
data_termino_atual,
valor_orcado,
valor_contratado,
valor_vigente,
percentual_medido,
prazo_inicial
FROM
  `rj-smi.infraestrutura_siscob_obras.obra` AS o
WHERE
  EXTRACT(
    YEAR
    FROM
      o.data_inicio
  ) >= 2021
  OR o.situacao IN ("EXECUTANDO", "SUSPENSA");

-- cronograma_alteracao
SELECT
  ca.id_obra,
  ca.id_processo,
  ca.id_etapa,
  ca.tipo_alteracao,
  ca.data_publicacao,
  ca.data_validade,
  ca.dias_prazo,
  ca.observacao,
FROM
  `rj-smi.infraestrutura_siscob_obras.cronograma_alteracao` AS ca
  INNER JOIN `rj-smi.infraestrutura_siscob_obras.obra` AS o ON ca.id_obra = o.id_obra
WHERE
  EXTRACT(
    YEAR
    FROM
      o.data_inicio
  ) >= 2021
  OR o.situacao IN ("EXECUTANDO", "SUSPENSA");

-- cronograma_financeiro
SELECT
  cf.id_obra,
  cf.id_etapa,
  cf.data_inicio,
  cf.data_fim,
  cf.valor_estimado,
  cf.percentual_estimado,
FROM
  `rj-smi.infraestrutura_siscob_obras.cronograma_financeiro` AS cf
  INNER JOIN `rj-smi.infraestrutura_siscob_obras.obra` AS o ON cf.id_obra = o.id_obra
WHERE
  EXTRACT(
    YEAR
    FROM
      o.data_inicio
  ) >= 2021
  OR o.situacao IN ("EXECUTANDO", "SUSPENSA");

-- localizacao
SELECT
  l.id_obra,
  l.id_bairro,
  l.bairro,
  l.id_regiao_planejamento,
  l.endereco,
FROM
  `rj-smi.infraestrutura_siscob_obras.localizacao` AS l
  INNER JOIN `rj-smi.infraestrutura_siscob_obras.obra` AS o ON l.id_obra = o.id_obra
WHERE
  EXTRACT(
    YEAR
    FROM
      o.data_inicio
  ) >= 2021
  OR o.situacao IN ("EXECUTANDO", "SUSPENSA");

-- medicao
SELECT
  m.id_obra,
  m.id_medicao,
  m.id_etapa,
  m.tipo_medicao,
  m.data_inicio,
  m.data_fim,
  m.valor_final,
FROM
  `rj-smi.infraestrutura_siscob_obras.medicao` AS m
  INNER JOIN `rj-smi.infraestrutura_siscob_obras.obra` AS o ON m.id_obra = o.id_obra
WHERE
  EXTRACT(
    YEAR
    FROM
      o.data_inicio
  ) >= 2021
  OR o.situacao IN ("EXECUTANDO", "SUSPENSA");

-- programa_fonte
SELECT
DISTINCT
  pf.id_obra,
  pf.id_programa_trabalho,
  pf.programa_trabalho,
  pf.id_fonte_recurso,
  pf.fonte_recurso,
  pf.id_natureza_despesa,
  pf.natureza_despesa,
FROM
  `rj-smi.infraestrutura_siscob_obras.programa_fonte` AS pf
  INNER JOIN `rj-smi.infraestrutura_siscob_obras.obra` AS o ON pf.id_obra = o.id_obra
WHERE
  EXTRACT(
    YEAR
    FROM
      o.data_inicio
  ) >= 2021
  OR o.situacao IN ("EXECUTANDO", "SUSPENSA");

-- termo_aditivo
SELECT
  ta.id_obra,
  ta.tipo_acerto,
  ta.data_publicacao,
  ta.data_autorizacao,
  ta.valor_acerto,
FROM
  `rj-smi.infraestrutura_siscob_obras.termo_aditivo` AS ta
  INNER JOIN `rj-smi.infraestrutura_siscob_obras.obra` AS o ON ta.id_obra = o.id_obra
WHERE
  EXTRACT(
    YEAR
    FROM
      o.data_inicio
  ) >= 2021
  OR o.situacao IN ("EXECUTANDO", "SUSPENSA");
