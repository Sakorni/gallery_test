import 'package:flutter/material.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/resources/asset_images_path.dart';
import 'package:gallery_test/app/ui/scene/add_photo_page/screen/add_photo_page.dart';
import 'package:gallery_test/app/ui/scene/home_page/home_page.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int index;
  double _size = 23;
  @override
  void initState() {
    index = 0;
    super.initState();
  }

  void tapHandler(int index) {
    setState(() {
      this.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: tapHandler,
          items: [
            BottomNavigationBarItem(
                label: '',
                icon: Image.asset(
                  NavBarIconAssetsPath.home,
                  width: _size,
                  height: _size,
                )),
            BottomNavigationBarItem(
              label: '',
              icon: Image.asset(
                NavBarIconAssetsPath.photo,
                width: _size,
                height: _size,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Image.asset(
                NavBarIconAssetsPath.profile,
                width: _size,
                height: _size,
              ),
            )
          ],
          unselectedItemColor: AppColors.mainGray,
          selectedItemColor: AppColors.underLineColor,
        ),
        body: IndexedStack(
          children: [HomePage(), AddPhotoPage(), Center(child: Text("3"))],
          index: index,
        ));
  }
}
