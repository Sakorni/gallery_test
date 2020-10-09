import 'package:flutter/widgets.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/app/ui/scene/auth_page/bloc/auth_bloc.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/screen_title.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/signIn_page.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/signUp_page.dart';

/// TODO ???
/// ну это вообще не годится
/// дебажить это будет нереально
/// а если у тебя потом
class FieldsScreen extends StatefulWidget {
  final bool signIn;
  final AuthBloc bloc;

  const FieldsScreen({Key key, this.signIn, this.bloc}) : super(key: key);
  @override
  _FieldsScreenState createState() => _FieldsScreenState();
}

class _FieldsScreenState extends State<FieldsScreen> {
  void swapScreen() {
    screenIndex = (screenIndex + 1) % 2;
    setState(() {});
  }

  List<Widget> screens = [];
  final List<String> titles = const [AppStrings.signIn, AppStrings.signUp];

  int screenIndex = 0;

  @override
  void initState() {
    screens = [
      SignInPage(
        swapScreens: swapScreen,
        signIn: widget.bloc.signIn,
      ),
      SignUpPage(
        swapScreens: swapScreen,
        signUp: widget.bloc.signUp,
      ),
    ];
    screenIndex = widget.signIn ? 0 : 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ScreenTitle(
        text: titles[screenIndex],
      ),
      SizedBox(height: 47),
      screens[screenIndex]
    ]);
  }
}
