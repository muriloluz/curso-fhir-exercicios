# hapi-local — seu próprio servidor FHIR (o mesmo da sala)

Suba na sua máquina o mesmo HAPI FHIR usado no curso, já com os perfis
brasileiros (`br.ufg.cgis.rnds-lite`) e o perfil do projeto final
(`br.curso.atestado`) carregados.

**Pré-requisito**: [Docker](https://docs.docker.com/get-docker/) instalado e porta 8080 livre.

## Subir (um comando, a partir DESTA pasta)

```bash
docker run -d --name hapi-curso -p 8080:8080 \
  -v $(pwd)/application.yaml:/app/config/application.yaml:ro \
  -v $(pwd)/packages:/packages:ro \
  hapiproject/hapi:latest
```

Aguarde ~90 segundos (primeira vez baixa a imagem, ~1GB) e confira:

```bash
curl -s http://localhost:8080/fhir/metadata | head -c 200
# deve responder um CapabilityStatement JSON
```

Pronto: todos os `.http` dos exercícios funcionam com o `@host` padrão
(`http://localhost:8080/fhir`) sem alterar nada.

## Comandos úteis

```bash
docker logs -f hapi-curso      # acompanhar o boot (procure "Started Application")
docker stop hapi-curso         # parar (os dados ficam)
docker start hapi-curso        # subir de novo
docker rm -f hapi-curso        # remover TUDO (dados inclusive) e recomeçar
```

## O que está carregado (via [application.yaml](application.yaml))

| Package | Para quê |
|---|---|
| `br.ufg.cgis.rnds-lite 0.5.0` | perfis/terminologias BR — validação do RAC (quarta) |
| `br.curso.atestado 0.1.0` | perfil `AtestadoMedico` — exercício de validação (sexta) |
| `br.go.saude.fhir.loinc 0.0.5` | CodeSystem LOINC 2.78 (~124k códigos) — elimina os warnings `CodeSystem could not be found: http://loinc.org` no `$validate` |

Os `.tgz` estão em [packages/](packages/). O servidor indexa os packages no boot —
o `POST /Bundle/$validate` valida contra esses perfis automaticamente quando a
instância declara `meta.profile`.

## Problemas comuns

- **Porta 8080 ocupada**: troque `-p 8080:8080` por `-p 8090:8080` e ajuste o
  `@host` nos `.http` para `http://localhost:8090/fhir`.
- **`$validate` lento na primeira chamada**: normal — o servidor monta o
  snapshot dos perfis na primeira validação.
- **Busca não acha o que acabou de criar**: servidores cacheiam resultados de
  busca (HAPI: 60s). Adicione o header `Cache-Control: no-cache` na requisição.
