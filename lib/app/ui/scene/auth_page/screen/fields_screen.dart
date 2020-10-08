import 'package:flutter/widgets.dart';
import 'package:gallery_test/app/ui/scene/auth_page/bloc/auth_bloc.dart';
import 'package:gallery_test/app/ui/scene/auth_page/screen/signIn_page.dart';
import 'package:gallery_test/app/ui/scene/auth_page/screen/signUp_page.dart';

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
    return screens[screenIndex];
  }
}
