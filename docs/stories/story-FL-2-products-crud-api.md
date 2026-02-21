# Story FL-2: Products CRUD com API REST

**Status:** Done  
**Priority:** High  
**Type:** Feature  
**Executor:** @dev  
**Quality Gate:** @qa

## User Story

Como usuario do app,  
Quero cadastrar, consultar, editar e remover produtos,  
Para gerenciar produtos via API REST padronizada do projeto.

## Technical Context

- Base URL global do app: `http://localhost:3000/api`
- Endpoint do recurso: `/products`
- Contrato do produto: `idProduct` (String), `name` (String), `price` (num)
- Arquitetura obrigatoria: Clean Architecture (`presentation/domain/data`)
- Seguir regras globais de implementacao em `AGENTS.md`

## Acceptance Criteria

- [x] AC1: CRUD completo funcionando no endpoint `/products` (`POST`, `GET`, `GET/{idProduct}`, `PUT/{idProduct}`, `DELETE/{idProduct}`)
- [x] AC2: Payload de produto respeita contrato (`idProduct`, `name`, `price`)
- [x] AC3: Fluxo de erro de API/rede mapeado para `Failure` e refletido em estado de tela
- [x] AC4: Feature integrada no `GetIt` (DI) e no `GoRouter` (rotas)
- [x] AC5: Regras globais de `AGENTS.md` respeitadas
- [x] AC6: `flutter analyze` e `flutter test` executados com sucesso

## Tasks

- [x] Implementar camada domain (entidade, contrato de repositorio, use cases CRUD)
- [x] Implementar camada data (model, datasource HTTP, repository)
- [x] Implementar camada presentation (provider/controller + pages de lista/form/detalhe)
- [x] Integrar dependencias no `GetIt`
- [x] Integrar rotas da feature no `GoRouter`
- [x] Escrever/atualizar testes da feature
- [x] Executar `flutter analyze` e `flutter test`

## File List (target)

- `lib/features/products/domain/entities/product.dart`
- `lib/features/products/domain/repositories/product_repository.dart`
- `lib/features/products/domain/usecases/create_product_usecase.dart`
- `lib/features/products/domain/usecases/list_products_usecase.dart`
- `lib/features/products/domain/usecases/get_product_by_id_usecase.dart`
- `lib/features/products/domain/usecases/update_product_usecase.dart`
- `lib/features/products/domain/usecases/delete_product_usecase.dart`
- `lib/features/products/data/models/product_model.dart`
- `lib/features/products/data/datasources/product_remote_data_source.dart`
- `lib/features/products/data/repositories/product_repository_impl.dart`
- `lib/features/products/presentation/providers/product_provider.dart`
- `lib/features/products/presentation/pages/product_list_page.dart`
- `lib/features/products/presentation/pages/product_form_page.dart`
- `lib/features/products/presentation/pages/product_detail_page.dart`
- `lib/core/di/injection.dart`
- `lib/core/router/app_router.dart`
- `lib/features/auth/presentation/pages/home_page.dart`
- `test/features/products/presentation/providers/product_provider_test.dart`
- `test/widget_test.dart`

## Synkra Execution Steps

1. `@dev`: implementar FL-2 completa seguindo `AGENTS.md`
2. `@qa`: revisar ACs, riscos e regressao
3. Rodar quality gates: `flutter analyze` e `flutter test`
