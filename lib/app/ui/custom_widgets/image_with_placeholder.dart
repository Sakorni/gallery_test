import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWithPlaceholder extends StatelessWidget {
  final double size;
  final String url;
  const ImageWithPlaceholder(this.size, this.url);
  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholder: AssetImage("assets/logo.png"),
      fit: BoxFit.fill,
      image: ResizeImage(
          CachedNetworkImageProvider(
            url,
          ),
          width: size.floor() * 3,
          height: size.floor() * 3),
    );
  }
}
