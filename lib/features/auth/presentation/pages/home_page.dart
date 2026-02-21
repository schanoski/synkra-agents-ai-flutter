import 'package:flutter/material.dart';
import 'package:flutter_ai_agent_synkra/features/auth/presentation/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final email = authProvider.currentUser?.email ?? 'sem usuario';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            onPressed: () => context.push('/products'),
            icon: const Icon(Icons.inventory_2_outlined),
            tooltip: 'Produtos',
          ),
          IconButton(
            onPressed: () => context.push('/synkra-prompts'),
            icon: const Icon(Icons.menu_book_outlined),
            tooltip: 'Ver prompts Synkra',
          ),
          TextButton(
            onPressed: () {
              context.read<AuthProvider>().logout();
              context.go('/login');
            },
            child: const Text('Sair'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Autenticado como: $email'),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => context.push('/products'),
              icon: const Icon(Icons.inventory_2_outlined),
              label: const Text('Abrir Produtos'),
            ),
          ],
        ),
      ),
    );
  }
}
