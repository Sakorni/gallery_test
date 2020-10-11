import 'package:flutter/material.dart';
import 'package:gallery_test/app/ui/scene/home_page/resources/top_bar_styles.dart';

class TopBarItem extends StatelessWidget {
  final bool enabled;
  final void Function() selectIndex;
  final String text;

  TopBarItem({this.enabled, this.selectIndex, this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          enabled ? TopBarBoxDecoration.enabled : TopBarBoxDecoration.disabled,
      child: FlatButton(
        onPressed: () => selectIndex(),
        child: Text(text,
            style:
                enabled ? TopBarTextStyles.enabled : TopBarTextStyles.disabled),
      ),
    );
  }
}
