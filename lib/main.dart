import 'package:flutter/material.dart';
import 'package:textoimage/text_to_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AiTextToImageGenerator(
        textToImageService: TextToImageService(
          apiKey: 'sk-fj8aMPYtOiIW5tSW1rhTKSYeomP28x3T0nBqNNfIdP8sIge1',
        ),
      ),
    );
  }
}
