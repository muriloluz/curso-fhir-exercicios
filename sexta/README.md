# Sexta-feira — validação contra o perfil do projeto final

À tarde construímos juntos o projeto final: a **Central de Atestado Médico**
(um IG com o perfil `AtestadoMedico` + uma mini-app Java). O projeto completo
será distribuído no repositório **curso-fhir-gabaritos**; aqui fica o exercício
que você executa na sala.

## Exercício — validar as duas instâncias (15 min)

Pasta: [exercicio-validacao-atestado/](exercicio-validacao-atestado/)

1. Abra `validacao-atestado.http` (REST Client) e ajuste o `@host` para o HAPI da sala.
2. Requisição 1: valida `instancias/atestado-exemplo-01.json` → esperado **0 errors**
   (1 warning de NamingSystem de CPF — o mesmo do RAC de quarta!).
3. Requisição 2: valida `instancias/atestado-exemplo-02-invalido.json` → esperado
   **erro de slice legível**: `Slice 'Composition.section:afastamento': a matching
   slice is required, but not found`. Leia e explique o porquê.
4. Bônus (requisição 3): a MESMA Composition **sem** `meta.profile` passa na validação
   base — validar contra o quê é decisão de quem valida (lembra do mt-26?).
