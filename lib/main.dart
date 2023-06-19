import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // Informa ao Flutter que o app definido em MyApp será o app a se executar
  runApp(MyApp());
}

/* A classe MyApp estende Stateless Widget
   Widgets são elementos que servem como base para a criação de apps do Flutter. Até o próprio app é um widget! */

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /* O código em MyApp configura todo o app. 
     Nomeia o App, define o tema visual e o widget inicial (ponto de partida do app) */

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'flutter_1',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink.shade400),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

/* Classe MyAppState define o estado do app!
    - MyAppState: define dados necessários para o app funcionar.
    - "State" estende o ChangeNotifier: pode emitir notificações sobre suas próprias mudanças.
    - ChangeNotifierProvider: o estado é criado e fornecido a todo o app.                              */

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair
        .random(); // reatribui o widget current a um novo WordPair aleatório
    notifyListeners(); // método de ChangeNotifier q envia uma notificação a qlqr elemento que esteja observando MyAppState
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // cada widget define um método build() chamado automaticamente p atualizar mudanças no widget
    var appState = context.watch<
        MyAppState>(); // rastreia mudanças no estado atual do app usando o método watch
    var pair = appState.current;

// Cada método build precisa retornar um widget ou uma árvore aninhada de widgets!

    return Scaffold(
      // widget de nível superior
      body: Center(
        child: Column(
          // widget de layout: recebe um número de filhos e os coloca em uma coluna de cima p baixo
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCard(
                pair:
                    pair), // widget Text que usa o AppState e acessa o membro da classe (current -- um WordPair)
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                appState.getNext();
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
