import 'package:flutter/widgets.dart';
import 'package:gallery_test/app/resources/asset_images_path.dart';

class LogoPicture extends StatelessWidget {
  final double size;

  const LogoPicture({Key key, this.size = 140}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(AssetImagePath.logo),
        fit: BoxFit.contain,
        scale: 2,
      )),
    );
  }
}
