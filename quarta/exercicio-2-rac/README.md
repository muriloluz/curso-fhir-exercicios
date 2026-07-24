# Exercício 2 — Construindo o RAC, tijolo por tijolo (90 min)

**Objetivo**: montar o Bundle document do **Registro de Atendimento Clínico** conforme
os perfis do package `br.ufg.cgis.rnds-lite 0.5.0`, validando a cada etapa, até chegar a
`Success: 0 errors, 8 warnings` (sim, 8 avisos — todos esperados e explicados no final).

**Regra do bloco**: ninguém avança sem validar a etapa atual.

## O caso (dados 100% fictícios)

Paciente (CPF 12345678909) atendida na UBS (CNES 2337545) por médico
(CNS 898001160660034, CBO 225103, equipe INE 1234567): infecção de vias aéreas (J06.9),
consulta na APS, prescrição de salbutamol, peso/altura aferidos, alergia a dipirona
registrada, plano de cuidados com retorno em 7 dias.

## Um detalhe antes de começar

**Patient, Practitioner e Organization NÃO entram no Bundle.** Os perfis do RAC usam
*referências lógicas*: `identifier` com o `system` apontando para a URL do
StructureDefinition do alvo — quem resolve é o receptor (CADSUS/CNES), como na RNDS real:

| Quem | identifier.system termina em | valor |
|---|---|---|
| Paciente | `StructureDefinition/BRIndividuo-1.0` | CPF |
| Estabelecimento | `StructureDefinition/BREstabelecimentoSaude-1.0` | CNES |
| Profissional | `StructureDefinition/BRLotacaoProfissional-1.0` | `CNS-CNES` |

## Etapas

Valide cada arquivo assim (da raiz do repositório; ajuste o nome do arquivo):

```bash
java -jar recursos/validador/validator_cli.jar \
     quarta/exercicio-2-rac/etapas/etapa-1-encounter.json \
     -version 4.0.1 -ig recursos/rnds-lite-0.5.0.tgz
```

### Etapa 1 — Encounter (o contato assistencial) · ~15 min

Abra [etapas/etapa-1-encounter.json](etapas/etapa-1-encounter.json) e substitua os 6
`TODO-*`. Dicas: os códigos vêm dos CodeSystems do package (`BRModalidadeAssistencial`,
`BRMotivoDesfecho`); status de contato encerrado na terminologia base do Encounter;
datas com fuso `-03:00`. Valide — **os TODOs errados geram erros de terminologia que
apontam exatamente o campo**: use-os como bússola.

### Etapa 2 — Condition (o diagnóstico) · ~10 min

[etapas/etapa-2-condition.json](etapas/etapa-2-condition.json), 3 TODOs. Atenção: o
perfil proíbe `display` no CID-10 — só `system` + `code` (sem ponto: `J069`).

### Etapa 3 — Procedure (o procedimento) · ~10 min

[etapas/etapa-3-procedure.json](etapas/etapa-3-procedure.json), 4 TODOs. Pegadinha
instrutiva: a extensão de quantidade exige `valuePositiveInt` — tente `1.0` (decimal)
e leia o erro antes de corrigir para `1`.

### Etapa 4 — Blocos prontos · ~5 min

O RAC exige a seção de prescrição (cadeia RPM → MedicationRequest → Medication) e ainda
levamos observações, alergia, plano de cuidados, motivo e local — **9 recursos prontos**
em [etapas/etapa-4-blocos-prontos.json](etapas/etapa-4-blocos-prontos.json). Hoje vocês
os copiam; sexta-feira vocês saberão construí-los. Leia o Medication: por que ele não
tem `id` nem `text`? (resposta: o perfil proíbe — `..0`.)

### Etapa 5 — Composition + Bundle (o documento) · ~25 min

[etapas/etapa-5-bundle-esqueleto.json](etapas/etapa-5-bundle-esqueleto.json):

1. Preencha `Bundle.identifier.value` (padrão RNDS: `<CNES>-<uuid novo>`) e `timestamp`.
2. Na Composition (1ª entry), aponte as 3 primeiras seções para os `urn:uuid` corretos
   (os `fullUrl` já estão nas entries — copie-os exatamente).
3. Substitua cada `COLE-AQUI` pelo recurso correspondente (etapas 1–3 corrigidas e os
   9 blocos da etapa 4).
4. Salve como `meu-rac.json` nesta pasta e valide.

### Checkpoint final (16:00)

```
Success: 0 errors, 8 warnings, 20 notes
```

Os **8 avisos são esperados** — identifique cada um na saída e explique-o com suas
palavras (2 bindings extensible da base HL7; dom-6 no Medication; performer/effective
proibidos pelos perfis das Observations; o NamingSystem `BRRNDS-*` do solicitante).
A explicação completa será liberada com o gabarito, no repositório **curso-fhir-gabaritos**
(inclui o exemplo comentado com visualizador HTML).

## Depois (16:15 — validação e envio)

- [validacao-rac.http](validacao-rac.http): valide o seu `meu-rac.json` no HAPI da sala
  e compare com o validator_cli.
- [envio-rac.http](envio-rac.http): envie (POST), recupere pelo `id` e busque pelo
  `identifier` do documento — o fechamento do dia.

## Se travar

Chame o instrutor — o erro do validador é parte do exercício, e travar é o momento
didático mais rico. O gabarito completo será liberado após o exercício no repositório
**curso-fhir-gabaritos** (com o exemplo comentado e o visualizador HTML).
