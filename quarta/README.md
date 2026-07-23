# Exercícios — Documentos Clínicos (quarta-feira)

Dois exercícios em sequência: de manhã você constrói **seu primeiro Bundle document**
(mínimo, sem perfis brasileiros); à tarde, o **RAC completo** com os perfis do package
`br.ufg.cgis.rnds-lite 0.5.0`.

| Exercício | Quando | Duração | Versão JSON | Versão FSH |
|---|---|---|---|---|
| 1. Documento mínimo | quarta, 11:00 | 60 min | [exercicio-1-documento-minimo/](exercicio-1-documento-minimo/) | [exercicio-1-documento-minimo-fsh/](exercicio-1-documento-minimo-fsh/) |
| 2. Construção do RAC | quarta, 14:30 | 90 min | [exercicio-2-rac/](exercicio-2-rac/) | [exercicio-2-rac-fsh/](exercicio-2-rac-fsh/) |

As versões **FSH** são os gêmeos dos exercícios em JSON: mesmos defeitos/TODOs, mas
editando FHIR Shorthand e compilando com o SUSHI — em aula fazemos o JSON; o FSH é a
trilha para refazer em casa (e o aquecimento perfeito para a sexta-feira).

## Antes de começar

1. Ambiente ok? Rode `../verificar-ambiente.sh` na raiz do repositório.
2. Abra a pasta do exercício no VS Code (os `.http` usam a extensão REST Client).
3. Regra de ouro do dia: **ninguém avança sem validar** — o erro do validador é
   parte do exercício, não um acidente.

## Como validar (o comando que você vai usar o dia todo)

```bash
# a partir da RAIZ do repositório:
java -jar recursos/validador/validator_cli.jar <arquivo.json> \
     -version 4.0.1 -ig recursos/rnds-lite-0.5.0.tgz
```

No exercício 1 o `-ig` é dispensável (não usamos perfis BR); no 2 é obrigatório.

---

*Os gabaritos serão liberados após cada exercício, no repositório **curso-fhir-gabaritos**.*
