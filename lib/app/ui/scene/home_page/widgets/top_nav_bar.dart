import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_test/app/ui/scene/home_page/widgets/top_bar_item.dart';

class TopNavigationBar extends StatefulWidget implements PreferredSizeWidget {
  final void Function(int) tapHandler;

  const TopNavigationBar({@required this.tapHandler});
  @override
  _TopNavigationBarState createState() => _TopNavigationBarState();

  @override
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
      widget.tapHandler(index);
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
                selectIndex: () => _selectIndex(0),
                text: "New",
              ),
            ),
            Expanded(
              child: TopBarItem(
                  enabled: enabledPopular,
                  selectIndex: () => _selectIndex(1),
                  text: "Popular"),
            )
          ],
        ),
      ),
    );
  }
}
