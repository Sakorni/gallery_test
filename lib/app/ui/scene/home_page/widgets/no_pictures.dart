import 'package:flutter/material.dart';
import 'package:gallery_test/app/resources/asset_images_path.dart';
import 'package:gallery_test/app/ui/scene/home_page/resources/home_page_styles.dart';

class NoPictures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetImagePath.noPictures,
            scale: 2,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Sorry!",
            style: TopBarTextStyles.disabled,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "There is no pictures.\nPleace come back later.",
            style: TopBarTextStyles.disabled.copyWith(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
