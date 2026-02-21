# AGENTS.md - Synkra AIOS (Codex CLI)

Este arquivo define as instrucoes do projeto para o Codex CLI.

## Estrutura do Projeto Flutter

Arquitetura base (manter este padrao):

- `lib/main.dart`: bootstrap do app
- `lib/app/`: composicao da aplicacao
- `lib/core/`: infraestrutura compartilhada
- `lib/core/di/`: injecao de dependencia (`GetIt`)
- `lib/core/router/`: roteamento e navegacao
- `lib/core/error/`: failures e erros de dominio
- `lib/features/<feature>/`: features por contexto
- `lib/features/<feature>/domain/`: entidades, contratos e use cases
- `lib/features/<feature>/data/`: datasources, models e repositorios
- `lib/features/<feature>/presentation/`: pages e providers/controllers
- `docs/stories/`: backlog executavel por story

## Flutter Rules (Projeto)

- Nao usar `WidgetsBinding` callback (`addPostFrameCallback`) para fluxo de tela.
- Nao usar `if (mounted)` em pages/widgets.
- Nao fazer validacao de regra de negocio dentro de `pages`.
- Toda validacao deve ficar em controller/provider/usecase (camada de controle/dominio).
- Pages devem apenas renderizar estado e disparar acoes do provider/controller.

## Regras de Provider (Obrigatorio)

- Toda feature nova deve ter provider/controller proprio na camada `presentation`.
- Estado de tela deve ser exposto pelo provider (`loading`, `success`, `error`).
- A page nao executa regra de negocio; somente chama metodos do provider/controller.
- Provider/controller orquestra use cases; use case nao acessa UI diretamente.
- Validacoes de formulario e regra de dominio ficam fora da page.

## Regras de Navegacao (NavigatorKey)

- Navegacao deve ser centralizada em `core/router`.
- Todo novo fluxo que exigir navegacao programatica/global deve usar `NavigatorKey`.
- Nao criar navegacao espalhada por widgets sem passar pelo roteador central.
- Em componentes reutilizaveis, evitar acoplamento com rota literal; delegar intencao ao provider/controller e ao router.
- Qualquer novo padrao de navegacao deve manter compatibilidade com `GoRouter`.

<!-- AIOS-MANAGED-START: core -->
## Core Rules

1. Siga a Constitution em `.aios-core/constitution.md`
2. Priorize `CLI First -> Observability Second -> UI Third`
3. Trabalhe por stories em `docs/stories/`
4. Nao invente requisitos fora dos artefatos existentes
<!-- AIOS-MANAGED-END: core -->

<!-- AIOS-MANAGED-START: quality -->
## Quality Gates

- Rode `npm run lint`
- Rode `npm run typecheck`
- Rode `npm test`
- Atualize checklist e file list da story antes de concluir
<!-- AIOS-MANAGED-END: quality -->

<!-- AIOS-MANAGED-START: codebase -->
## Project Map

- Core framework: `.aios-core/`
- CLI entrypoints: `bin/`
- Shared packages: `packages/`
- Tests: `tests/`
- Docs: `docs/`
<!-- AIOS-MANAGED-END: codebase -->

<!-- AIOS-MANAGED-START: commands -->
## Common Commands

- `npm run sync:ide`
- `npm run sync:ide:check`
- `npm run sync:skills:codex`
- `npm run sync:skills:codex:global` (opcional; neste repo o padrao e local-first)
- `npm run validate:structure`
- `npm run validate:agents`
<!-- AIOS-MANAGED-END: commands -->

<!-- AIOS-MANAGED-START: shortcuts -->
## Agent Shortcuts

Preferencia de ativacao no Codex CLI:
1. Use `/skills` e selecione `aios-<agent-id>` vindo de `.codex/skills` (ex.: `aios-architect`)
2. Se preferir, use os atalhos abaixo (`@architect`, `/architect`, etc.)

Interprete os atalhos abaixo carregando o arquivo correspondente em `.aios-core/development/agents/` (fallback: `.codex/agents/`), renderize o greeting via `generate-greeting.js` e assuma a persona ate `*exit`:

- `@architect`, `/architect`, `/architect.md` -> `.aios-core/development/agents/architect.md`
- `@dev`, `/dev`, `/dev.md` -> `.aios-core/development/agents/dev.md`
- `@qa`, `/qa`, `/qa.md` -> `.aios-core/development/agents/qa.md`
- `@pm`, `/pm`, `/pm.md` -> `.aios-core/development/agents/pm.md`
- `@po`, `/po`, `/po.md` -> `.aios-core/development/agents/po.md`
- `@sm`, `/sm`, `/sm.md` -> `.aios-core/development/agents/sm.md`
- `@analyst`, `/analyst`, `/analyst.md` -> `.aios-core/development/agents/analyst.md`
- `@devops`, `/devops`, `/devops.md` -> `.aios-core/development/agents/devops.md`
- `@data-engineer`, `/data-engineer`, `/data-engineer.md` -> `.aios-core/development/agents/data-engineer.md`
- `@ux-design-expert`, `/ux-design-expert`, `/ux-design-expert.md` -> `.aios-core/development/agents/ux-design-expert.md`
- `@squad-creator`, `/squad-creator`, `/squad-creator.md` -> `.aios-core/development/agents/squad-creator.md`
- `@aios-master`, `/aios-master`, `/aios-master.md` -> `.aios-core/development/agents/aios-master.md`
<!-- AIOS-MANAGED-END: shortcuts -->
