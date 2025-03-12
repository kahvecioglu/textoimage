import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:stability_image_generation/stability_image_generation.dart';

class TextToImageService {
  final StabilityAI _ai = StabilityAI();
  final String apiKey;
  final ImageAIStyle imageAIStyle;

  TextToImageService({
    required this.apiKey,
    this.imageAIStyle = ImageAIStyle.digitalPainting,
  });

  Future<Uint8List> generateImage(String query) async {
    return await _ai.generateImage(
      apiKey: apiKey,
      imageAIStyle: imageAIStyle,
      prompt: query,
    );
  }
}

class AiTextToImageGenerator extends StatefulWidget {
  final TextToImageService textToImageService;

  const AiTextToImageGenerator({super.key, required this.textToImageService});

  @override
  State<AiTextToImageGenerator> createState() => _AiTextToImageGeneratorState();
}

class _AiTextToImageGeneratorState extends State<AiTextToImageGenerator> {
  final TextEditingController _queryController = TextEditingController();
  bool isItems = false;

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Text to Image", style: TextStyle(fontSize: 30)),
            Container(
              width: double.infinity,
              height: 55,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: TextField(
                controller: _queryController,
                decoration: const InputDecoration(
                  hintText: 'Enter your prompt',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15, top: 5),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child:
                  isItems
                      ? FutureBuilder<Uint8List>(
                        future: widget.textToImageService.generateImage(
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
                              child: Text('Failed to generate image'),
                            );
                          }
                        },
                      )
                      : const Center(
                        child: Text(
                          'No image generated yet',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_queryController.text.isNotEmpty) {
                  setState(() {
                    isItems = true;
                  });
                }
              },
              child: const Text("Generate Image"),
            ),
          ],
        ),
      ),
    );
  }
}
