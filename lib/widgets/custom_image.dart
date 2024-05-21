import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomImage extends StatelessWidget {
  final String imageUrl;

  const CustomImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: CircularProgressIndicator(),
        ),
        Center(
          child: FractionallySizedBox(
            widthFactor: 0.5, // 25% of the screen width
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(16.0), // Rounded corners
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0), // Rounded corners
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}