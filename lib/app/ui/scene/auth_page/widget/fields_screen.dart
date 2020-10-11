import 'package:flutter/widgets.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/signIn_page.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/signUp_page.dart';

class FieldsScreen extends StatefulWidget {
  final bool signIn;

  const FieldsScreen({
    Key key,
    this.signIn,
  }) : super(key: key);
  @override
  _FieldsScreenState createState() => _FieldsScreenState();
}

class _FieldsScreenState extends State<FieldsScreen> {
  int screenIndex = 0;
  List<Widget> screens = [];
  void swapScreen() {
    screenIndex = (screenIndex + 1) % 2;
    setState(() {});
  }

  @override
  void initState() {
    screens = [
      SignInPage(
        swapScreens: swapScreen,
      ),
      SignUpPage(
        swapScreens: swapScreen,
      ),
    ];
    screenIndex = widget.signIn ? 0 : 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [screens[screenIndex]]);
  }
}
