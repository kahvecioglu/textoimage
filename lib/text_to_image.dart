import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../services/text_to_image_service.dart';

class AiTextToImageGenerator extends StatefulWidget {
  const AiTextToImageGenerator({super.key});

  @override
  State<AiTextToImageGenerator> createState() => _AiTextToImageGeneratorState();
}

class _AiTextToImageGeneratorState extends State<AiTextToImageGenerator> {
  final TextEditingController _queryController = TextEditingController();
  bool isItems = false;
  late final TextToImageService textToImageService;

  @override
  void initState() {
    super.initState();
    textToImageService = TextToImageService();
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      resizeToAvoidBottomInset:
          false, // Klavye açıldığında UI yeniden boyutlanmasın
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("AI Image Creator", style: gradientTextStyle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // TextField en üstte
            Container(
              width: double.infinity,
              height: 80,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: 2),
                borderRadius: BorderRadius.circular(12),
                color: Colors.black,
              ),
              child: TextField(
                controller: _queryController,
                style: const TextStyle(color: Colors.white),
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Put Your Imagination in Writing',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Üretilen resim ortada görüntülenecek
            Expanded(
              child: Center(
                child:
                    isItems
                        ? FutureBuilder<Uint8List>(
                          future: textToImageService.generateImage(
                            _queryController.text,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasData) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.memory(snapshot.data!),
                              );
                            } else {
                              return const Center(
                                child: Text(
                                  'Failed to generate image',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }
                          },
                        )
                        : const SizedBox(),
              ),
            ),
            // Buton merkeze hizalanmış
            ElevatedButton(
              onPressed: () {
                if (_queryController.text.isNotEmpty) {
                  setState(() {
                    isItems = true;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 40,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.auto_awesome, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Imagine",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
