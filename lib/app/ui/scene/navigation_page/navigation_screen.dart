import 'package:flutter/material.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/resources/asset_images_path.dart';
import 'package:gallery_test/app/ui/scene/home_page/home_page.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int index;
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
                  width: 23,
                  height: 23,
                )),
            BottomNavigationBarItem(
              label: '',
              icon: Image.asset(
                NavBarIconAssetsPath.photo,
                width: 23,
                height: 23,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Image.asset(
                NavBarIconAssetsPath.profile,
                width: 23,
                height: 23,
              ),
            )
          ],
          unselectedItemColor: AppColors.mainGray,
          selectedItemColor: AppColors.underLineColor,
        ),
        body: IndexedStack(
          children: [
            HomePage(),
            Center(child: Text("2")),
            Center(child: Text("3"))
          ],
          index: index,
        ));
  }
}
