import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/ui/scene/home_page/widgets/top_bar_item.dart';

class TopNavigationBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _TopNavigationBarState createState() => _TopNavigationBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(15);
}

class _TopNavigationBarState extends State<TopNavigationBar> {
  int selectedIndex;
  bool enabledNew;
  bool enabledPopular;
  @override
  void initState() {
    enabledNew = true;
    enabledPopular = false;
    selectedIndex = 0;
    super.initState();
  }

  void _selectIndex(int index) {
    if (index != selectedIndex) {
      setState(() {
        selectedIndex = index;
        enabledNew = !enabledNew;
        enabledPopular = !enabledPopular;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            Expanded(
              child: TopBarItem(
                enabled: enabledNew,
                selectIndex: () => _selectIndex(1),
                text: "New",
              ),
            ),
            Expanded(
              child: TopBarItem(
                  enabled: enabledPopular,
                  selectIndex: () => _selectIndex(2),
                  text: "Popular"),
            )
          ],
        ),
      ),
    );
  }
}
