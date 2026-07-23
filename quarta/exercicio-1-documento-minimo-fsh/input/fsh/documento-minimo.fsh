// ============================================================
// Exercício 1 (versão FSH) — Bundle document mínimo com
// defeitos propositais. Corrija seguindo o README; a cada
// correção: sushi .  e valide o JSON gerado.
// ============================================================

Instance: PacienteMaria
InstanceOf: Patient
Usage: #inline
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml"><p><b>Maria Rosa</b>, feminino, nascida em 12/03/1980.</p></div>"""
* name.text = "Maria Rosa"
* gender = #female
* birthDate = "1980-03-12"

Instance: SumarioSimples
InstanceOf: Composition
Usage: #inline
// TODO (dom-6): este recurso está sem narrativa (text.status + text.div)
* status = #final
* type = http://loinc.org#60591-5 "Patient summary Document"
// TODO (referência): o uuid abaixo não existe no Bundle — aponte para o fullUrl real do Patient
* subject.reference = "urn:uuid:cccc9999-8888-4777-8666-555544443333"
* date = "2026-07-22T11:00:00-03:00"
* author.display = "Aluno do curso de FHIR"
* title = "Sumário simples da paciente"
* section.title = "Paciente"
* section.entry.reference = "urn:uuid:aaaa1111-2222-4333-8444-555566667777"

Instance: documento-minimo
InstanceOf: Bundle
Usage: #example
Title: "Documento mínimo — exercício 1"
// TODO (bdl-9): falta Bundle.identifier (system urn:ietf:rfc:3986 + value com um urn:uuid NOVO)
// TODO (bdl-10): falta Bundle.timestamp (instante da montagem, com fuso)
* type = #document
// TODO (bdl-11): num document, a Composition deve ser a PRIMEIRA entry
* entry[0].fullUrl = "urn:uuid:aaaa1111-2222-4333-8444-555566667777"
* entry[0].resource = PacienteMaria
* entry[1].fullUrl = "urn:uuid:bbbb1111-2222-4333-8444-555566667777"
* entry[1].resource = SumarioSimples
