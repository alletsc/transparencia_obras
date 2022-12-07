--  extrair todos os valores distintos de programa_id da tabelas programas
select DISTINCT programa_id from programas;

SELECT string_field_0, string_field_0, string_field_0 FROM `rj-segovi-dev.dashboard_obras.auxiliar_sigla_orgao` LIMIT 1000

--  renomear colunas de `rj-smi.infraestrutura_siscob_obras.obra`

ALTER TABLE `rj-segovi-dev.dashboard_obras.auxiliar_sigla_orgao` RENAME COLUMN `string_field_0` TO `sigla`;
ALTER TABLE `rj-segovi-dev.dashboard_obras.auxiliar_sigla_orgao` RENAME COLUMN `string_field_1` TO `nome`;
ALTER TABLE `rj-segovi-dev.dashboard_obras.auxiliar_sigla_orgao` RENAME COLUMN `string_field_2` TO `nome_sigla`;

--  appagar linhas de `rj-smi.infraestrutura_siscob_obras.obra`
DELETE FROM `rj-segovi-dev.dashboard_obras.auxiliar_situacao` WHERE xxx =  xxx;

ALTER TABLE `rj-segovi-dev.dashboard_obras.auxiliar_situacao` RENAME COLUMN `string_field_0` TO `situacao`;
ALTER TABLE `rj-segovi-dev.dashboard_obras.auxiliar_situacao` RENAME COLUMN `string_field_1` TO `nova_situaco`;
ALTER TABLE `rj-segovi-dev.dashboard_obras.auxiliar_situacao` RENAME COLUMN `string_field_2` TO `descricao`;