import 'dart:typed_data';
import 'package:stability_image_generation/stability_image_generation.dart';

class TextToImageService {
  final StabilityAI _ai = StabilityAI();
  // API key burada sabit olarak tanımlanmıştır.
  final String apiKey = 'sk-LmT6tmOM2gCMC4N4BoxDTx2gDtG5SMuUHYMhy6k7EgURr5VW';
  final ImageAIStyle imageAIStyle;

  TextToImageService({this.imageAIStyle = ImageAIStyle.digitalPainting});

  Future<Uint8List> generateImage(String query) async {
    return await _ai.generateImage(
      apiKey: apiKey,
      imageAIStyle: imageAIStyle,
      prompt: query,
    );
  }
}
