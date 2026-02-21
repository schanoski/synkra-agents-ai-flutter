# Story FL-1: Foundation Clean Architecture + Synkra Orchestration

**Status:** In Progress  
**Priority:** High  
**Type:** Feature  
**Executor:** @dev  
**Quality Gate:** @qa

## User Story

Como time de desenvolvimento,  
Quero uma base Flutter com Clean Architecture usando `provider`, `go_router` e `get_it`,  
Para evoluir funcionalidades com separacao de camadas e fluxo de stories do Synkra AIOS.

## Acceptance Criteria

- [x] AC1: App inicia com bootstrap via `main.dart` + DI
- [x] AC2: Router centralizado em `core/router/app_router.dart`
- [x] AC3: Feature `auth` criada com camadas `domain`, `data`, `presentation`
- [x] AC4: Provider da feature integrado ao ciclo de login/logout
- [x] AC5: Teste de widget validando tela inicial de login
- [x] AC6: Fluxo de prompts Synkra visivel no app e documentado em `docs/`

## Tasks

- [x] Criar bootstrap de app (`App`, DI, Router)
- [x] Implementar fluxo fake de autenticacao para validar arquitetura
- [x] Criar tela visual de prompts Synkra (`/synkra-prompts`)
- [x] Documentar prompt pack em `docs/USO-SYNKRA-FLUTTER.md`
- [x] Atualizar teste base de widget
- [x] Executar `flutter analyze`
- [x] Executar `flutter test`

## File List

- `lib/main.dart`
- `lib/app/app.dart`
- `lib/core/di/injection.dart`
- `lib/core/router/app_router.dart`
- `lib/core/error/failure.dart`
- `lib/features/auth/domain/entities/user.dart`
- `lib/features/auth/domain/repositories/auth_repository.dart`
- `lib/features/auth/domain/usecases/login_usecase.dart`
- `lib/features/auth/data/models/user_model.dart`
- `lib/features/auth/data/datasources/auth_remote_data_source.dart`
- `lib/features/auth/data/repositories/auth_repository_impl.dart`
- `lib/features/auth/presentation/providers/auth_provider.dart`
- `lib/features/auth/presentation/pages/login_page.dart`
- `lib/features/auth/presentation/pages/home_page.dart`
- `lib/features/meta/presentation/pages/synkra_prompts_page.dart`
- `test/widget_test.dart`
- `docs/USO-SYNKRA-FLUTTER.md`

## Next Stories

- FL-2: Products CRUD com API REST (`http://localhost:3000/api/products`)
- FL-3: Auth real com datasource HTTP e armazenamento seguro
- FL-4: Design system base (theme, tokens, typography)
- FL-5: Core networking + interceptors + error mapping
