# Exercício 1 — Seu primeiro Bundle document (60 min)

**Objetivo**: partir de um template com defeitos, ler as mensagens do validador e
corrigir uma a uma até chegar a `Success: 0 errors, 0 warnings`.

O documento é um "Sumário simples": um Bundle `document` com **Composition + Patient**.
Sem perfis brasileiros ainda — só as regras universais do FHIR.

## Passo a passo

### 1. Valide o template do jeito que está (5 min)

```bash
# a partir da RAIZ do repositório
java -jar recursos/validador/validator_cli.jar \
     exercicios/exercicio-1-documento-minimo/template-documento.json -version 4.0.1
```

Resultado esperado: **4 erros e 3 warnings**. Isso é proposital — cada mensagem
ensina uma regra de documentos.

### 2. Leia cada mensagem e corrija (35 min)

Trabalhe **um erro por vez**: corrija → revalide → próximo. A ordem sugerida:

| # | Mensagem do validador | Regra | O que fazer |
|---|---|---|---|
| 1 | `bdl-9: A document must have an identifier with a system and a value` | Todo documento tem identidade própria, global e imutável | Acrescente `Bundle.identifier` com `system` (`urn:ietf:rfc:3986`) e `value` (um `urn:uuid:` que você gerar — [uuidgenerator.net](https://www.uuidgenerator.net)) |
| 2 | `bdl-10: A document must have a date` | O documento registra o instante da montagem | Acrescente `Bundle.timestamp` (dateTime com fuso, ex.: `2026-07-22T11:00:00-03:00`) |
| 3 | `bdl-11: A document must have a Composition as the first resource` | A Composition é o "sumário": abre o documento | Inverta a ordem das entries: Composition primeiro, Patient depois |
| 4 | `URN reference is not locally contained within the bundle urn:uuid:cccc…` | Referências resolvem por **igualdade de fullUrl** dentro do Bundle | O `Composition.subject.reference` aponta para um uuid que não existe — corrija para o `fullUrl` exato da entry do Patient |
| 5 | `dom-6: A resource should have narrative` (warning!) | Documento é para **humanos lerem** | Acrescente `text` (status `generated` + `div` XHTML) na Composition |

Repare na diferença: 1–4 são **erros** (documento inválido); 5 é **warning**
(válido, porém contra a boa prática — e num documento clínico, narrativa importa).

O warning "isn't reachable by traversing forwards from the Composition" desaparece
sozinho quando você corrigir o item 4 — entenda por quê antes de seguir.

### 3. Valide no servidor também (10 min)

Abra [pratica-documento.http](pratica-documento.http) (extensão REST Client) e
execute a requisição de `$validate`. Compare o `OperationOutcome` retornado com a
saída do validator_cli: mesmas regras, dois validadores.

### 4. Checkpoint (até 11:50)

`Success: 0 errors, 0 warnings` no arquivo final. Terminou cedo?

**Desafio extra**: acrescente uma 2ª seção "Alergias" **sem** `entry` e sem `text`
e revalide. O erro `cmp-1` é a Composition se defendendo de seção vazia. Tente resolver
só com `emptyReason` (código `nilknown` de
`http://terminology.hl7.org/CodeSystem/list-empty-reason`)… ainda falha! O cmp-1 exige
text, entry ou subseção — uma seção deliberadamente vazia precisa de **emptyReason E
uma narrativa** ("Nenhuma alergia conhecida."). Duas invariantes trabalhando juntas.

## Dica de leitura das mensagens

Cada linha do validador tem 3 partes: **severidade** (`Error`/`Warning`), **local**
(`Bundle.entry[1].resource.subject` + linha/coluna do arquivo) e **diagnóstico**
(qual regra falhou, ex.: `bdl-9`). Os códigos `bdl-*`, `cmp-*` e `dom-*` são as
invariantes da especificação — você pode procurá-los em
[hl7.org/fhir/R4/bundle.html](https://hl7.org/fhir/R4/bundle.html#bundle-rules).
