# Exercício de narrativa — escreva o `text` deste Patient (5 min)

**Quando**: quarta-feira, ~09:50 (bloco de narrativa, mt-21 slide 14).
**Como**: papel e caneta OU editando este arquivo — sem validador, sem servidor.

## O recurso

```json
{
  "resourceType": "Patient",
  "name": [{ "family": "Rosa", "given": ["Maria"] }],
  "birthDate": "1980-03-12",
  "gender": "female"
}
```

## Sua tarefa

1. Escreva o conteúdo do `div` (XHTML) que você colocaria em `Patient.text`.
2. Escolha o `status` da narrativa: `generated`, `extensions`, `additional` ou `empty`.
3. Justifique o status em UMA frase.

```json
"text": {
  "status": "___________",
  "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\">

          ESCREVA AQUI

          </div>"
}
```

**Lembretes** (da teoria de agora há pouco):
- Deve ser **seguro renderizar só a narrativa** — tudo que importa do recurso aparece nela.
- XHTML restrito: parágrafos, listas, tabelas, negrito… sem script, sem head/body.
- XHTML é XML: nada de `&nbsp;` (use `&#160;` se precisar).

---

