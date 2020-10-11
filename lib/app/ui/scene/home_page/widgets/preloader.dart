import 'package:flutter/material.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/ui/scene/home_page/resources/home_page_styles.dart';

class Preloader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: Theme(
              data: Theme.of(context).copyWith(accentColor: AppColors.mainGray),
              child: CircularProgressIndicator(
                strokeWidth: 0.5,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Loading...", style: TopBarTextStyles.disabled),
        ],
      ),
    );
  }
}
