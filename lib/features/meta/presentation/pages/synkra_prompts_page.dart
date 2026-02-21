import 'package:flutter/material.dart';

class SynkraPromptsPage extends StatelessWidget {
  const SynkraPromptsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Synkra Prompt Flow')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const <Widget>[
          _PromptCard(
            title: '@analyst',
            description: 'Define contexto e requisitos da feature',
            prompt: '''
Quero implementar [NOME DA FEATURE] no app Flutter.
Defina requisitos funcionais, nao funcionais e criterios de aceite.
''',
          ),
          SizedBox(height: 12),
          _PromptCard(
            title: '@architect',
            description: 'Desenha arquitetura por camadas',
            prompt: '''
Com base nos requisitos, defina a arquitetura da feature em Clean Architecture
com Provider + GoRouter + GetIt, incluindo classes e responsabilidades.
''',
          ),
          SizedBox(height: 12),
          _PromptCard(
            title: '@sm',
            description: 'Quebra em stories executaveis',
            prompt: '''
Crie stories em docs/stories com:
User Story, Acceptance Criteria, Tasks checklist e File list.
''',
          ),
          SizedBox(height: 12),
          _PromptCard(
            title: '@dev',
            description: 'Implementa story por story',
            prompt: '''
Implemente a proxima story completa.
Atualize checklist e file list ao final.
''',
          ),
          SizedBox(height: 12),
          _PromptCard(
            title: '@qa',
            description: 'Valida qualidade e riscos',
            prompt: '''
Revise a story implementada:
valide os criterios de aceite, riscos, testes e regressao.
''',
          ),
          SizedBox(height: 20),
          Text(
            'Comandos de terminal por story:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          SelectableText('flutter analyze\nflutter test'),
        ],
      ),
    );
  }
}

class _PromptCard extends StatelessWidget {
  const _PromptCard({
    required this.title,
    required this.description,
    required this.prompt,
  });

  final String title;
  final String description;
  final String prompt;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(description),
            const SizedBox(height: 8),
            SelectableText(prompt.trim()),
          ],
        ),
      ),
    );
  }
}
