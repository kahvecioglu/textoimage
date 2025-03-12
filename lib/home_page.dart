import 'package:flutter/material.dart';
import 'package:textoimage/text_to_image.dart'; // AiTextToImageGenerator buradan gelecek

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Kırmızıdan mora degrade (gradient) efektli yazı stilli
    final gradientTextStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      foreground:
          Paint()
            ..shader = const LinearGradient(
              colors: <Color>[Colors.red, Colors.purple],
            ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text('Artificial Intelligence', style: gradientTextStyle),
        centerTitle: true,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            // Butona tıklayınca Text to Image sayfasına gider
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AiTextToImageGenerator(),
              ),
            );
          },
          child: Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.image, size: 40, color: Colors.white),
                SizedBox(height: 8),
                Text(
                  'Text to Image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'AI text analyzer',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
