import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImageViewer extends StatelessWidget {
  final String url;
  const FullScreenImageViewer({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(url),
          loadingBuilder:
              (context, progress) =>
                  const Center(child: CircularProgressIndicator()),
          errorBuilder:
              (context, error, stackTrace) => const Center(
                child: Icon(Icons.broken_image, color: Colors.white, size: 60),
              ),
        ),
      ),
    );
  }
}
