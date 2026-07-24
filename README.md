# curso-fhir-exercicios — Interoperabilidade em Saúde com HL7® FHIR®

Exercícios práticos do curso (quarta e sexta). Clone, prepare o ambiente e
traga o repositório pronto para a aula.

> Curso independente: não representa a RNDS/Ministério da Saúde nem a HL7 International.
> Artefatos em rascunho, dados 100% fictícios.

## Estrutura

| Pasta | Dia | Conteúdo |
|---|---|---|
| [quarta/](quarta/) | quarta-feira | Documento mínimo (60 min), narrativa (5 min), construção do RAC (90 min) — versões JSON e FSH |
| [sexta/](sexta/) | sexta-feira | Validação de instâncias contra o perfil do projeto final (Central de Atestado Médico) |
| [hapi-local/](hapi-local/) | — | **Seu servidor FHIR** (docker, 1 comando) com os packages do curso já carregados |
| [recursos/](recursos/) | — | `rnds-lite-0.5.0.tgz` (package de perfis do curso) + pasta do validador |

Os **gabaritos** serão liberados após cada exercício, no repositório
**curso-fhir-gabaritos** (que inclui também o projeto final completo: IG + mini-app).

## Ambiente

| Ferramenta | Versão | Para quê |
|---|---|---|
| Java (JDK) | 21 | validator_cli |
| validator_cli.jar | 6.9.12 | validação oficial HL7 |
| Node.js | 20.x | SUSHI |
| SUSHI (fsh-sushi) | 3.16.x+ | compilar FSH → JSON |
| VS Code + extensão REST Client | atual | exercícios .http |

## Setup

```bash
git clone <URL-deste-repositorio>
cd curso-fhir-exercicios
./baixar-validador.sh      # baixa o validator_cli.jar para recursos/validador/
./verificar-ambiente.sh    # confere java/node/sushi/docker/jar
cd hapi-local && docker run -d --name hapi-curso -p 8080:8080 \
  -v $(pwd)/application.yaml:/app/config/application.yaml:ro \
  -v $(pwd)/packages:/packages:ro hapiproject/hapi:latest   # seu servidor FHIR
```

Os `.http` dos exercícios já apontam para `http://localhost:8080/fhir` — com o
servidor local no ar, nada precisa ser ajustado (na sala também haverá um HAPI
compartilhado como alternativa).

Conexão com a internet é necessária na primeira validação (o validador baixa
packages base e consulta o servidor de terminologia `tx.fhir.org`).

## O comando que você vai usar o dia todo

```bash
# a partir da RAIZ do repositório:
java -jar recursos/validador/validator_cli.jar <arquivo.json> \
     -version 4.0.1 -ig recursos/rnds-lite-0.5.0.tgz
```
