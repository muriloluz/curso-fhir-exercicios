# Exercício 1 em FSH — o mesmo documento, agora como código-fonte

O gêmeo FSH do [exercício 1](../exercicio-1-documento-minimo/): mesmos defeitos,
mas você corrige o **FHIR Shorthand** e compila com o SUSHI.

## Fluxo de trabalho (o ciclo que importa)

```bash
# nesta pasta:
sushi .                       # compila FSH → fsh-generated/resources/
# na raiz do repositório:
java -jar recursos/validador/validator_cli.jar \
     quarta/exercicio-1-documento-minimo-fsh/fsh-generated/resources/Bundle-documento-minimo.json \
     -version 4.0.1
```

## Os dois portões

Este exercício ensina uma diferença fundamental:

1. **SUSHI (build)** — pega erros de *tipo e estrutura* (dateTime malformado,
   elemento inexistente, cardinalidade nas instâncias). Aqui o template compila
   limpo: **0 erros de SUSHI**.
2. **validator_cli (validação)** — pega *invariantes, terminologia e perfis*.
   É ele que acusa os **4 erros + 3 warnings** do template (bdl-9, bdl-10,
   bdl-11, referência não resolvida; dom-6 etc.).

Moral: *compilar não é estar conforme* — o FSH válido gera JSON bem-formado,
mas só o validador diz se o documento obedece às regras.

## Sua tarefa

Abra [input/fsh/documento-minimo.fsh](input/fsh/documento-minimo.fsh): os `// TODO`
marcam os 5 defeitos (são os mesmos do exercício em JSON — a tabela
mensagem→regra→correção está no [README do exercício 1](../exercicio-1-documento-minimo/README.md)).
Corrija um por vez: editar FSH → `sushi .` → validar → próximo.

Meta: `Success: 0 errors, 0 warnings`.

O gabarito será liberado após o exercício, no repositório **curso-fhir-gabaritos**.
