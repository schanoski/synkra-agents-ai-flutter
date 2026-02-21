# flutter_ai_agent_synkra

Projeto Flutter com base em Clean Architecture e fluxo de desenvolvimento orientado por Synkra AIOS.

## Stack atual

- Flutter
- Provider
- GoRouter
- GetIt
- Synkra AIOS para orquestracao de desenvolvimento

## Instalar Synkra via npm

Pré-requisitos:

- Node.js 20+
- npm 9+

Instalacao no projeto atual:

```bash
cd flutter_ai_agent_synkra
npx @synkra/aios-core@latest install
```

Atualizar instalacao existente:

```bash
npx @synkra/aios-core@latest install --force-upgrade
```

## Como ajustar o Synkra para este projeto

Arquivos que devem ficar alinhados com a realidade do app:

- `AGENTS.md`: regras operacionais do projeto e atalhos de agentes
- `.aios-core/core-config.yaml`: paths de stories/docs e configuracao de IDE
- `docs/USO-SYNKRA-FLUTTER.md`: playbook oficial de prompts e fluxo
- `docs/stories/`: backlog e execucao por story
- `.env` e `.env.example`: variaveis de ambiente do app/API

Ajustes obrigatorios deste projeto:

- Base URL global da API: `http://localhost:3000/api`
- Recurso de exemplo oficial: `products`
- Contrato de produto: `idProduct`, `name`, `price`

## Como trabalhar neste projeto (fluxo padrao Synkra)

1. Escolha a story em `docs/stories/`
2. Use o fluxo de agentes (`@analyst -> @architect -> @sm -> @dev -> @qa`)
3. Rode validacoes locais:

```bash
flutter analyze
flutter test
```

## Regras de implementacao

- Todas as regras de implementacao ficam centralizadas em `AGENTS.md`.

## Prompt padrao para nova feature (exemplo: Products CRUD)

### 1) Analyst

```text
@analyst
Nova feature: Products CRUD.
Base URL obrigatoria: http://localhost:3000/api
Endpoint: /products
Campos: idProduct, name, price
Defina requisitos funcionais, nao funcionais e criterios de aceite.
Considere as regras globais de implementacao definidas em AGENTS.md.
```

### 2) Architect

```text
@architect
Desenhe a arquitetura da feature Products CRUD em Clean Architecture:
entity, repository, datasource HTTP, use cases (create/list/get/update/delete),
provider, rotas e DI.
Siga as regras globais definidas em AGENTS.md.
```

### 3) Scrum Master

```text
@sm
Crie/atualize story da feature Products CRUD em docs/stories com:
User Story, Acceptance Criteria, Tasks checklist e File list.
```

### 4) Dev

```text
@dev
Implemente a story de Products CRUD usando:
http://localhost:3000/api/products
No fim, atualize checklist/file list e rode flutter analyze + flutter test.
Siga as regras globais definidas em AGENTS.md.
```

### 5) QA

```text
@qa
Revise a story de Products CRUD:
valide ACs, riscos de regressao e evidencias de analyze/test.
```

## Prompt padrao para corrigir bug (exemplo: Products)

Exemplo de bug: falha ao atualizar produto no `PUT /products/{idProduct}`.

### 1) Analyst (triagem)

```text
@analyst
Temos um bug na feature Products.
Sintoma: update de produto falha.
Contexto: API base http://localhost:3000/api, endpoint /products/{idProduct}.
Documente causa provavel, impacto, criterio de aceite da correcao e casos de teste.
Considere as regras globais definidas em AGENTS.md.
```

### 2) Architect (estrategia de correcao)

```text
@architect
Proponha correcao tecnica para o bug de update em Products,
incluindo ajuste de contrato, fluxo de erro e impacto em camadas/DI/provider.
Siga as regras globais definidas em AGENTS.md.
```

### 3) Scrum Master (story de bugfix)

```text
@sm
Crie uma story de bugfix para Products com:
reproducao, ACs de correcao, tasks e file list.
```

### 4) Dev (fix)

```text
@dev
Implemente a correcao do bug em Products.
Inclua/ajuste testes para reproduzir e prevenir regressao.
Finalize com flutter analyze + flutter test e atualize a story.
Siga as regras globais definidas em AGENTS.md.
```

### 5) QA (validacao final)

```text
@qa
Valide o bugfix de Products:
1) reproduz bug antes
2) confirma correcao depois
3) valida regressao do CRUD completo
```

## Documentacao Synkra do projeto

- Guia principal de uso do AIOS no app: `docs/USO-SYNKRA-FLUTTER.md`
- Story base da arquitetura: `docs/stories/story-FL-1-clean-arch-foundation.md`
- Story da feature de exemplo (Products CRUD): `docs/stories/story-FL-2-products-crud-api.md`

## Apoio visual no app

- Rota interna: `/synkra-prompts`
- Tela: `lib/features/meta/presentation/pages/synkra_prompts_page.dart`
# synkra-agents-ai-flutter
