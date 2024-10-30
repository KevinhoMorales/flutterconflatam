import 'package:flutter/material.dart';

import 'translate_screen.dart';

void main() {
  runApp(const TranslateThisApp());
}

class TranslateThisApp extends StatelessWidget {
  const TranslateThisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Translate This"),
        ),
        body: const TranslateScreen(),
      ),
    );
  }
}
