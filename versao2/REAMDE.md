<!-- Sumário -->
<h2>Sumário</h2>

- [Sobre](#sobre)
- [Fonte de dados](#fonte)
- [Tables e colunas de interesse](#tables)
- [Transformações](#transformacoes)



<div id='transformacoes'/>
<h2>Transformações</h2>

<h3>obra</h3>

| Tabela                                    | Coluna       | Tipo   | Transformação                                          |
| ----------------------------------------- | ------------ | ------ | ------------------------------------------------------ |
| `rj-smi.infraestrutura_siscob_obras.obra` | `modalidade` | string | substituir `"TOMADA_PRECO"` por `"Tomada de preço"`    |
| `rj-smi.infraestrutura_siscob_obras.obra` | `modalidade` | string | substituir `"CONCORRENCIA"` por `"Concorrência"`       |
| `rj-smi.infraestrutura_siscob_obras.obra` | `modalidade` | string | substituir `"CONVITE"` por `"Convite"`                 |
| `rj-smi.infraestrutura_siscob_obras.obra` | `modalidade` | string | substituir `"DISPENSA"` por `"Dispensa"`               |
| `rj-smi.infraestrutura_siscob_obras.obra` | `modalidade` | string | substituir `"INEXIGIBILIDADE"` por `"Inexigibilidade"` |
| `rj-smi.infraestrutura_siscob_obras.obra` | `situacao`   | string | substituir `"EXECUTANDO"` por `"Executando"`           |
| `rj-smi.infraestrutura_siscob_obras.obra` | `situacao`   | string | substituir `"SUSPENSA"` por `"Suspensa"`               |
| `rj-smi.infraestrutura_siscob_obras.obra` | `situacao`   | string | substituir `"CANCELADA"` por `"Cancelada"`             |
| `rj-smi.infraestrutura_siscob_obras.obra` | `situacao`   | string | substituir `""` por `""`                               |
| `rj-smi.infraestrutura_siscob_obras.obra` | `situacao`   | string | substituir `""` por `""`                               |
| `rj-smi.infraestrutura_siscob_obras.obra` | `situacao`   | string | substituir `""` por `""`                               |

<h4>Novos dados</h4>

Inserir coluna com nome do orgão responsável pela obra e detalhamento.

Exemplo:

IHC/SUBI/CGP - Coordenadoria Geral de Projetos
SECONSERVA - Secretaria Municipal de Conservação
SEMESQV - Secretaria Municipal do Envelhecimento Saudável e Qualidade de Vida
SECONSERVA - Secretaria Municipal de Conservação e Serviços Públicos

- Primeiro: separar a sigla antes do "/" e fazer sua correspondencia com a tabela de siglas e orgaos corrigindo os casos em que houver necessidade.
- Segundo: fazer a correspondencia com o nome do orgão responsável e inserir a sigla no final concatenada por " - ".
- Terceiro: se atentar para os casos em que a sigla for "SECONSERVA" pois  o nome do orgão responsável é "Secretaria Municipal de Conservação e Serviços Públicos" e em aguns casos é "Secretaria Municipal de Conservação".

O detalhamento é o nome que já se encontra na tabela.

<h3>localizacao</h3>

| Tabela                                           | Coluna                   | Tipo   | Transformação                                            |
| ------------------------------------------------ | ------------------------ | ------ | -------------------------------------------------------- |
| `rj-smi.infraestrutura_siscob_obras.localizacao` | `id_regiao_planejamento` | string | Inserir `"AP "` antes do número e nome do bairro depois. |

<h3>programa_fonte</h3>

Unir as tabelas `rj-smi.infraestrutura_siscob_obras.obra` e `rj-smi.infraestrutura_siscob_obras.programa_fonte` em uma só tabela. Quando houver obras com `fonte_recurso`diferentes concatenar os valores em uma única linha e quando não houver `fonte_recurso` preencher com `Não preenchido`.



<div id='fonte'/>
## Fonte de dados

Obras de interesse: aquela com `data_inicio` de contratro a partir de 2021 ou com `situacao` igual a  `IN ("EXECUTANDO", "SUSPENSA")`.

```sql
SELECT
  *
FROM
  `rj-smi.infraestrutura_siscob_obras.obra` AS o
WHERE
  EXTRACT(
    YEAR
    FROM
      o.data_inicio
  ) >= 2021
  OR o.situacao IN ("EXECUTANDO", "SUSPENSA")
```
<div id='tables'/>
## Tabelas e colunas de interesse

#### `rj-smi.infraestrutura_siscob_obras.obra`
```sql

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
modalidade,
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

```

#### `rj-smi.infraestrutura_siscob_obras.cronograma_alteracao`

```sql
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
  OR o.situacao IN ("EXECUTANDO", "SUSPENSA")
```
#### `rj-smi.infraestrutura_siscob_obras.cronograma_financeiro`

```sql
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
  OR o.situacao IN ("EXECUTANDO", "SUSPENSA")
```

#### `rj-smi.infraestrutura_siscob_obras.localizacao`

```sql
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
  OR o.situacao IN ("EXECUTANDO", "SUSPENSA")
```
#### `rj-smi.infraestrutura_siscob_obras.medicao`

```sql
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
  OR o.situacao IN ("EXECUTANDO", "SUSPENSA")
```

#### `rj-smi.infraestrutura_siscob_obras.progrma_fonte`

```sql
SELECT
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
  OR o.situacao IN ("EXECUTANDO", "SUSPENSA")
```

#### `rj-smi.infraestrutura_siscob_obras.termo_aditivo`

```sql
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
```

