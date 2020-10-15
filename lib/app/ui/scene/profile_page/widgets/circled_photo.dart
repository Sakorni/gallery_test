import 'package:flutter/widgets.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/resources/asset_images_path.dart';

class CircledPhoto extends StatelessWidget {
  final double size;

  const CircledPhoto({this.size});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: AppColors.mainGray),
              image: DecorationImage(
                image: AssetImage(NavBarIconAssetsPath.photo),
              ))),
    );
  }
}
