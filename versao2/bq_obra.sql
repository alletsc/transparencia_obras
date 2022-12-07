SELECT
  id_obra,
  id_processo,
  id_licitacao,
  id_contrato,
  titulo,
  orgao_contratante,
  orgao_executor,
  -- concatenar favorecido e cnpj CONCAT (favorecido, " - ", cnpj) AS favorecido_cnpj,
  -- corriginddo tipo de obra
  CASE
    WHEN objeto = "OBRA" THEN "Obra"
    WHEN objeto = "SERVICO" THEN "Serviço"
    WHEN objeto = "CONTINUO" THEN "Continuo"
  ELSE
  objeto
END
  AS objeto,
  ano_inicio_contrato,
  data_assinatura_contrato,
  data_inicio,
  data_termino_previsto,
  data_termino_atual,
  valor_orcado,
  valor_contratado,
  valor_vigente,
  percentual_medido,
  prazo_inicial,
  -- corrigindo modalidade
  CASE
    WHEN modalidade = "DISPENSA" THEN "Dispensa"
    WHEN modalidade = "TOMADA_PRECO" THEN "Tomada de preço"
    WHEN modalidade = "CONCORRENCIA" THEN "Concorrência"
    WHEN modalidade = "CONVITE" THEN "Convite"
    WHEN modalidade = "INEXIGIBILIDADE" THEN "Inexigibilidade"
    WHEN modalidade = "PREGAO_ELETRONICO" THEN "Pregão eletrônico"
  ELSE
  modalidade
END
  AS modalidade,
  -- correspondencas de situacao
  CASE
    WHEN situacao = "CONCL_FINANC" THEN "CONCL_FINANC"
    WHEN situacao = "DEVOLV_GARANTIA" THEN "Concluída"
    WHEN situacao = "EXECUTANDO" THEN "Executando"
    WHEN situacao = "PROC_AC_DEF" THEN "Concluída"
    WHEN situacao = "REPACTUADO" THEN "Repactuada"
    WHEN situacao = "CONTRATO_RESCINDIDO" THEN "Rescindida"
    WHEN situacao = "CANCELADO" THEN "Cancelada"
    WHEN situacao = "PROC_AC_PROV" THEN "Em processo de aceitação"
    WHEN situacao = "SUSPENSA" THEN "Suspensa"
END
  AS situacao,
FROM
  `rj-smi.infraestrutura_siscob_obras.obra`
WHERE
  EXTRACT( YEAR
  FROM
    data_inicio ) >= 2021
  OR situacao IN ("EXECUTANDO",
    "SUSPENSA");