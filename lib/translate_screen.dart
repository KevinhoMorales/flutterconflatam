import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:translate_this/api.dart';

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  String currentTranslation = "";
  bool isLoading = false;
  final TextEditingController toTranslateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text("¿Qué quieres traducir?"),
            TextField(
              controller: toTranslateController,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                getTranslation();
              },
              child: const Text("Traducir"),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
              ),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Text(currentTranslation),
            ),
          ],
        ),
      ),
    );
  }

  void getTranslation() async {
    var textToTranslate = toTranslateController.text;
    var translation = await ApiClient().translate(textToTranslate);
    setState(() {
      isLoading = false;
      currentTranslation = translation;
    });
    speak(translation);
  }

  static const platform = MethodChannel("translate.this.channel");

  void speak(String translation) async {
    // llamar a platform channel speak por plataforma
    try {
      final result = await platform.invokeMethod("speak", translation);
    } on MissingPluginException catch (e) {
      debugPrint(e.message);
    }
  }
}
