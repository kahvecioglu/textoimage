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
          apiKey: 'sk-LmT6tmOM2gCMC4N4BoxDTx2gDtG5SMuUHYMhy6k7EgURr5VW',
        ),
      ),
    );
  }
}
