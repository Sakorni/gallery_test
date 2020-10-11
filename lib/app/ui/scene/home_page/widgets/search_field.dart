import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/app/resources/asset_images_path.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.5),
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.searchFieldColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            AssetImagePath.searchIcon,
            scale: 2.0,
          ),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(8.0),
                  hintText: AppStrings.seatchHint,
                  hintStyle: TextStyle(color: AppColors.searchTextColor)),
            ),
          ),
          Image.asset(
            AssetImagePath.voiceIcon,
            scale: 2.0,
          ),
        ],
      ),
    );
  }
}
