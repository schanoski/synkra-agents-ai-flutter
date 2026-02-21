import 'package:flutter/material.dart';
import 'package:flutter_ai_agent_synkra/core/di/injection.dart';
import 'package:flutter_ai_agent_synkra/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_ai_agent_synkra/features/auth/presentation/pages/home_page.dart';
import 'package:flutter_ai_agent_synkra/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_ai_agent_synkra/features/meta/presentation/pages/synkra_prompts_page.dart';
import 'package:flutter_ai_agent_synkra/features/products/presentation/pages/product_detail_page.dart';
import 'package:flutter_ai_agent_synkra/features/products/presentation/pages/product_form_page.dart';
import 'package:flutter_ai_agent_synkra/features/products/presentation/pages/product_list_page.dart';
import 'package:flutter_ai_agent_synkra/features/products/presentation/providers/product_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter buildAppRouter(AuthProvider authProvider) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/login',
    refreshListenable: authProvider,
    redirect: (context, state) {
      final isLoggedIn = authProvider.isAuthenticated;
      final isInLogin = state.matchedLocation == '/login';

      if (!isLoggedIn && !isInLogin) {
        return '/login';
      }

      if (isLoggedIn && isInLogin) {
        return '/home';
      }

      return null;
    },
    routes: <RouteBase>[
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
      GoRoute(
        path: '/synkra-prompts',
        builder: (context, state) => const SynkraPromptsPage(),
      ),
      GoRoute(
        path: '/products',
        builder: (context, state) => ChangeNotifierProvider<ProductProvider>(
          create: (context) => sl<ProductProvider>(),
          child: const ProductListPage(),
        ),
      ),
      GoRoute(
        path: '/products/new',
        builder: (context, state) => ChangeNotifierProvider<ProductProvider>(
          create: (context) => sl<ProductProvider>(),
          child: const ProductFormPage(idProduct: null),
        ),
      ),
      GoRoute(
        path: '/products/:idProduct',
        builder: (context, state) {
          final idProduct = state.pathParameters['idProduct'] ?? '';
          return ChangeNotifierProvider<ProductProvider>(
            create: (context) => sl<ProductProvider>(),
            child: ProductDetailPage(idProduct: idProduct),
          );
        },
      ),
      GoRoute(
        path: '/products/:idProduct/edit',
        builder: (context, state) {
          final idProduct = state.pathParameters['idProduct'] ?? '';
          return ChangeNotifierProvider<ProductProvider>(
            create: (context) => sl<ProductProvider>(),
            child: ProductFormPage(idProduct: idProduct),
          );
        },
      ),
    ],
  );
}
