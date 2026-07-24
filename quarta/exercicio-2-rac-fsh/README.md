# Exercício 2 em FSH — o RAC como código-fonte

O gêmeo FSH do [exercício 2](../exercicio-2-rac/): mesmo RAC, mesmos TODOs — mas
editando FHIR Shorthand e compilando com o SUSHI. O caso clínico, os dados fictícios
e a explicação das referências lógicas estão no
[README do exercício 2](../exercicio-2-rac/README.md); aqui está só o que muda no FSH.

## Pré-requisito

O package precisa estar no cache do SUSHI (uma vez só):

```bash
mkdir -p ~/.fhir/packages/br.ufg.cgis.rnds-lite#0.5.0
tar -xzf ../../recursos/rnds-lite-0.5.0.tgz -C ~/.fhir/packages/br.ufg.cgis.rnds-lite#0.5.0
```

## Fluxo de trabalho

```bash
# nesta pasta:
sushi .          # compila → fsh-generated/resources/Bundle-rac-bundle-completo.json
# na raiz do repositório:
java -jar recursos/validador/validator_cli.jar \
     quarta/exercicio-2-rac-fsh/fsh-generated/resources/Bundle-rac-bundle-completo.json \
     -version 4.0.1 -ig recursos/rnds-lite-0.5.0.tgz
```

## Os dois portões (repare na divisão de trabalho!)

Rode `sushi .` no template **antes de mexer em qualquer coisa**:

- O **SUSHI acusa 3 erros** — os elementos obrigatórios que estão comentados
  (`period.end`, `valuePositiveInt` da quantidade, `performedDateTime`). Ele conhece
  os perfis (dependência no sushi-config.yaml) e cobra cardinalidade **no build**.
- Mesmo com erros, o SUSHI gera o JSON. O **validador acusa ~41 erros** — não se
  assuste: são os códigos `TODO-*` reprovando nos ValueSets, em cascata. Cada
  mensagem aponta o elemento e o CodeSystem onde buscar o código certo.

## Sua tarefa

Tudo em [input/fsh/rac-recursos.fsh](input/fsh/rac-recursos.fsh) e
[input/fsh/rac-bundle.fsh](input/fsh/rac-bundle.fsh):

| Etapa | Instance | TODOs |
|---|---|---|
| 1 | `RacContatoAssistencial` | 6 (status, class, CPF, period.end, desfecho, CNES) |
| 2 | `RacProblemaDiagnostico` | 3 (status clínico, CID-10, CPF) |
| 3 | `RacProcedimentoRealizado` | 4 (quantidade, código SUS, data, CBO) |
| 4 | demais Instances | nenhum — são os blocos prontos; leia-as! |
| 5 | `RacComposicao` + `rac-bundle.fsh` | 3 seções (urns) + identifier + timestamp |

Repare como o FSH endereça slices **por nome** — `section[prescricao]`,
`diagnosis[problemAndDiagnosis]`, `extension[team]` — sem contar índices de array.

Meta: SUSHI `0 Errors` e validador `Success: 0 errors, 8 warnings` (os 8 avisos
esperados — identifique cada um; a explicação de cada aviso será liberada com o
gabarito após o exercício, no repositório **curso-fhir-gabaritos**).

O gabarito completo (FSH e JSON) também estará no repositório **curso-fhir-gabaritos**.
Para validar no servidor e enviar: use os `.http` do [exercício 2](../exercicio-2-rac/).
