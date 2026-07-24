#!/usr/bin/env bash
# Confere se o ambiente do curso está pronto.
set -uo pipefail
cd "$(dirname "$0")"

ok=1
verificar() { # nome, comando, dica
  if eval "$2" >/dev/null 2>&1; then
    echo "  [ok]    $1: $(eval "$3" 2>/dev/null | head -1)"
  else
    echo "  [FALTA] $1 — $4"
    ok=0
  fi
}

echo "== Ferramentas =="
verificar "Java 21+"  "command -v java"  "java -version 2>&1"            "instale um JDK 21 (ex.: Temurin: https://adoptium.net)"
verificar "Node 20+"  "command -v node"  "node --version"                "instale o Node.js LTS: https://nodejs.org"
verificar "SUSHI"     "command -v sushi" "sushi --version"               "npm install -g fsh-sushi (necessário só para o rac-fsh)"
verificar "Docker"    "command -v docker" "docker --version"             "instale o Docker (para o servidor FHIR local: hapi-local/): https://docs.docker.com/get-docker/"

echo "== Servidor FHIR local (hapi-local/) =="
if curl -s -o /dev/null -m 3 http://localhost:8080/fhir/metadata 2>/dev/null; then
  echo "  [ok]    HAPI respondendo em http://localhost:8080/fhir"
else
  echo "  [info]  HAPI não está no ar — para subir: ver hapi-local/README.md"
fi

echo "== Arquivos =="
if [[ -f recursos/validador/validator_cli.jar ]]; then
  echo "  [ok]    validator_cli.jar ($(du -h recursos/validador/validator_cli.jar | cut -f1))"
else
  echo "  [FALTA] recursos/validador/validator_cli.jar — rode ./baixar-validador.sh"
  ok=0
fi
[[ -f recursos/rnds-lite-0.5.0.tgz ]] && echo "  [ok]    package rnds-lite-0.5.0.tgz" || { echo "  [FALTA] recursos/rnds-lite-0.5.0.tgz"; ok=0; }

echo "== Cache do SUSHI (só para o rac-fsh) =="
if [[ -d "$HOME/.fhir/packages/br.ufg.cgis.rnds-lite#0.5.0" ]]; then
  echo "  [ok]    br.ufg.cgis.rnds-lite#0.5.0 no cache"
else
  echo "  [info]  package fora do cache — para usar o SUSHI:"
  echo "          mkdir -p ~/.fhir/packages/br.ufg.cgis.rnds-lite#0.5.0"
  echo "          tar -xzf recursos/rnds-lite-0.5.0.tgz -C ~/.fhir/packages/br.ufg.cgis.rnds-lite#0.5.0"
fi

echo
if [[ $ok -eq 1 ]]; then
  echo "Ambiente pronto! Comece por: quarta/exercicio-1-documento-minimo/"
else
  echo "Pendências acima — resolva e rode de novo."
  exit 1
fi
