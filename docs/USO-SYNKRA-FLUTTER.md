# Uso do Synkra AIOS no Flutter

## Objetivo

Usar o Synkra AIOS como sistema de orquestracao de desenvolvimento para evoluir o app Flutter em stories pequenas, verificaveis e com qualidade controlada.

## O que AIOS faz (e o que nao faz)

- AIOS organiza processo de desenvolvimento com agentes (`@analyst`, `@architect`, `@sm`, `@dev`, `@qa` etc.)
- AIOS gera e valida artefatos de engenharia (stories, arquitetura, checklists, fluxo de entrega)
- AIOS nao roda dentro do app Flutter em producao
- O app mobile continua um app Flutter normal; AIOS atua no workflow de engenharia

## Estado atual deste projeto

- Framework instalado em `.aios-core/`
- Versao de configuracao detectada: `2.1.0` (arquivo `.aios-core/core-config.yaml`)
- IDEs configuradas no core-config: `codex` e `claude-code`
- Story location: `docs/stories`

## Estrutura relevante para o uso do AIOS

- Regras de agentes do projeto: `AGENTS.md`
- Core do framework: `.aios-core/`
- Agentes para Codex: `.codex/agents/`
- Documentacao de uso no app: `docs/USO-SYNKRA-FLUTTER.md`
- Stories executaveis: `docs/stories/`

## Regras obrigatorias de implementacao Flutter

- As regras globais de implementacao ficam centralizadas em `AGENTS.md`.

## Decisoes tecnicas globais (API)

- Base URL unica para todo o app: `http://localhost:3000/api`
- Recurso inicial priorizado: `products`
- Endpoint de recurso: `http://localhost:3000/api/products`
- Contrato minimo do produto:
- `idProduct` (String)
- `name` (String)
- `price` (num)
- Escopo funcional: CRUD completo (Create, Read, Update, Delete)

## Fluxo recomendado por feature (end-to-end)

1. Discovery com `@analyst`
2. Design tecnico com `@architect`
3. Quebra em stories com `@sm`
4. Implementacao com `@dev`
5. Revisao de risco e aceite com `@qa`
6. Validacao tecnica no terminal (`flutter analyze` e `flutter test`)
7. Atualizacao da story (tasks checklist + file list)

## Prompt Pack (copiar e colar)

### 1) Analyst

```text
@analyst
Quero implementar [NOME DA FEATURE] no app Flutter.
Defina requisitos funcionais, nao funcionais e criterios de aceite.
Contexto tecnico atual:
- Clean Architecture
- Provider para estado
- GoRouter para navegacao
- GetIt para DI
```

### 2) Architect

```text
@architect
Com base nos requisitos aprovados, proponha arquitetura tecnica da feature:
- camadas (presentation/domain/data)
- contratos e implementacoes
- alteracoes de rotas e DI
- estrategia de testes
```

### 3) Scrum Master

```text
@sm
Crie ou atualize stories em docs/stories com:
- User Story
- Acceptance Criteria
- Tasks checklist
- File list
- Riscos e dependencias
```

### 4) Dev

```text
@dev
Implemente a proxima story completa no Flutter.
Ao finalizar:
- atualize a story (checklist e file list)
- rode flutter analyze
- rode flutter test
```

### 5) QA

```text
@qa
Revise a story implementada:
- valide todos os acceptance criteria
- liste riscos e regressao
- confirme cobertura de testes minima para a mudanca
```

## Prompt Pack especifico da feature Products CRUD

### Analyst (requisitos da API)

```text
@analyst
Nova feature: CRUD de produtos.
Base URL obrigatoria: http://localhost:3000/api
Recurso: /products
Campos do produto: idProduct, name, price
Defina requisitos funcionais, nao funcionais, regras de validacao e criterios de aceite.
Considere as regras globais definidas em AGENTS.md.
```

### Architect (desenho tecnico)

```text
@architect
Com base no requisito aprovado, desenhe a feature Products CRUD em Clean Architecture:
- entidade Product (idProduct, name, price)
- repository + datasource HTTP
- use cases: create, list, getById, update, delete
- mapeamento de erros para Failure
- impacto em DI, rotas e provider
Siga as regras globais definidas em AGENTS.md.
```

### Scrum Master (story executavel)

```text
@sm
Crie a story da feature Products CRUD em docs/stories com:
- User Story
- Acceptance Criteria para CRUD completo
- Tasks checklist por camada
- File list alvo
```

### Dev (implementacao)

```text
@dev
Implemente a story de Products CRUD.
Use base URL http://localhost:3000/api e endpoint /products.
Ao finalizar:
- atualize checklist e file list
- rode flutter analyze
- rode flutter test
Siga as regras globais definidas em AGENTS.md.
```

### QA (revisao)

```text
@qa
Revise a implementacao de Products CRUD:
- valide todos os ACs
- valide contrato de idProduct, name, price
- valide riscos de regressao
- confirme evidencias de flutter analyze e flutter test
```

## Passo a passo de uso do Synkra nesta feature

1. Abrir ou criar a story de produtos em `docs/stories/`
2. Rodar `@analyst` para fechar requisitos do CRUD e regras de validacao
3. Rodar `@architect` para fechar design de camadas e contratos
4. Rodar `@sm` para deixar a story executavel (ACs + tasks + file list)
5. Rodar `@dev` para implementar o CRUD por casos de uso
6. Rodar `@qa` para revisar aceite, risco e regressao
7. Executar no terminal:

```bash
flutter analyze
flutter test
```

8. Atualizar a story com evidencias e marcar como concluida

## Contrato de endpoints para Products CRUD

- `POST /products`: cria produto (`idProduct`, `name`, `price`)
- `GET /products`: lista produtos
- `GET /products/{idProduct}`: detalha produto
- `PUT /products/{idProduct}`: atualiza produto
- `DELETE /products/{idProduct}`: remove produto

## Exemplo de ciclo diario (pratico)

```text
1) Escolher uma story em docs/stories
2) Rodar discovery/detalhamento com @analyst (se necessario)
3) Confirmar desenho com @architect (se houver impacto de arquitetura)
4) Refinar tarefas com @sm
5) Implementar com @dev
6) Revisar com @qa
7) Validar no terminal: flutter analyze && flutter test
8) Fechar story com checklist e file list atualizados
```

## Validacao obrigatoria por story

```bash
flutter analyze
flutter test
```

Se algum comando falhar, a story nao deve ser considerada concluida.

## Como usar no Codex CLI (projeto atual)

- Ative agentes com atalhos definidos em `AGENTS.md`
- Atalhos principais: `@analyst`, `@architect`, `@sm`, `@dev`, `@qa`
- Encerrar persona ativa: `*exit`

## Integracao visual no app

- Rota de apoio: `/synkra-prompts`
- Tela: `lib/features/meta/presentation/pages/synkra_prompts_page.dart`
- Objetivo da tela: servir como referencia rapida de prompts e fluxo para o time

## Definition of Done para cada story

- Criteria de aceite marcados como concluidos
- Task checklist atualizado
- File list atualizado com todos os arquivos tocados
- `flutter analyze` sem erros
- `flutter test` passando
- Revisao de QA registrada

## Troubleshooting rapido

- Se um agente responder fora do escopo: reforce a story alvo e os arquivos permitidos
- Se surgir mudanca arquitetural nao planejada: voltar para `@architect` antes de codar
- Se faltar contexto: pedir ao `@sm` para atualizar a story com mais detalhes executaveis

## Referencias

- Guia local do framework: `.aios-core/user-guide.md`
- Regras locais do projeto: `AGENTS.md`
