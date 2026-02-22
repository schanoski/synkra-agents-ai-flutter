# Synkra Agents AI Flutter

PT-BR | [English](#english)

Projeto Flutter com **Clean Architecture** + **Synkra AIOS** para execução orientada por stories.

## O que o app faz hoje

- Fluxo básico de autenticação (login/home)
- CRUD de produtos via API REST
- Estrutura de features por contexto (`auth`, `products`, `meta`)
- Navegação com `GoRouter` e DI com `GetIt`

## Demo rápida

- Screenshots/GIF: adicione em `docs/assets/` e referencie aqui
- Exemplo:
  - `docs/assets/login.png`
  - `docs/assets/products-list.png`
  - `docs/assets/products-flow.gif`

## Rodar em 1 minuto

Pré-requisitos:

- Flutter SDK 3.35+
- Dart SDK 3.11+

Comandos:

```bash
flutter pub get
flutter run
```

## Quality Gates (Flutter)

```bash
dart format . --set-exit-if-changed
flutter analyze
flutter test
# opcional
flutter test --coverage
```

## Mini diagrama de arquitetura

```text
Presentation (pages/providers)
        |
Domain (entities/usecases/contracts)
        |
Data (datasources/models/repositories)
```

## Estrutura principal

```text
lib/
  app/
  core/
    di/
    error/
    router/
  features/
    auth/
    products/
    meta/
  main.dart

docs/
  stories/
  USO-SYNKRA-FLUTTER.md
```

## Linguagem do repositório no GitHub

A pasta `.aios-core/` é infraestrutura de automação e pode influenciar os gráficos de linguagem do GitHub.
Para reduzir esse ruído, o projeto marca essa pasta como `linguist-vendored` em `.gitattributes`.

## Fluxo Synkra (resumo)

1. Escolher story em `docs/stories/`
2. Executar fluxo de agentes (`@analyst -> @architect -> @sm -> @dev -> @qa`)
3. Validar com Quality Gates Flutter

## Documentação

- Guia principal: `docs/USO-SYNKRA-FLUTTER.md`
- Story base: `docs/stories/story-FL-1-clean-arch-foundation.md`
- Exemplo Products CRUD: `docs/stories/story-FL-2-products-crud-api.md`

---

## English

Flutter project with **Clean Architecture** + **Synkra AIOS** for story-driven development.

## What the app currently does

- Basic auth flow (login/home)
- Products CRUD using a REST API
- Feature-based structure (`auth`, `products`, `meta`)
- Navigation with `GoRouter` and DI with `GetIt`

## Quick demo

- Add screenshots/GIF files under `docs/assets/` and reference them here
- Example:
  - `docs/assets/login.png`
  - `docs/assets/products-list.png`
  - `docs/assets/products-flow.gif`

## Run in 1 minute

Prerequisites:

- Flutter SDK 3.35+
- Dart SDK 3.11+

Commands:

```bash
flutter pub get
flutter run
```

## Quality Gates (Flutter)

```bash
dart format . --set-exit-if-changed
flutter analyze
flutter test
# optional
flutter test --coverage
```

## Clean Architecture mini diagram

```text
Presentation (pages/providers)
        |
Domain (entities/usecases/contracts)
        |
Data (datasources/models/repositories)
```

## Main project structure

```text
lib/
  app/
  core/
    di/
    error/
    router/
  features/
    auth/
    products/
    meta/
  main.dart

docs/
  stories/
  USO-SYNKRA-FLUTTER.md
```

## GitHub language stats note

The `.aios-core/` folder is automation infrastructure and can skew GitHub language statistics.
To reduce this noise, the repository marks it as `linguist-vendored` in `.gitattributes`.

## Synkra workflow (summary)

1. Pick a story in `docs/stories/`
2. Run the agent flow (`@analyst -> @architect -> @sm -> @dev -> @qa`)
3. Validate with Flutter Quality Gates

## Docs

- Main guide: `docs/USO-SYNKRA-FLUTTER.md`
- Foundation story: `docs/stories/story-FL-1-clean-arch-foundation.md`
- Products CRUD example: `docs/stories/story-FL-2-products-crud-api.md`
