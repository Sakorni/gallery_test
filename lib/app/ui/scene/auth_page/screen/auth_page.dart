import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/app/ui/scene/auth_page/bloc/auth_bloc.dart';
import 'package:gallery_test/app/ui/scene/auth_page/screen/fields_screen.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/cancel_button.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/screen_title.dart';
import 'package:gallery_test/data/gateway/auth_mode.dart';

class AuthPage extends StatelessWidget {
  final bool signIn;

  const AuthPage(
    AuthMode mode, {
    Key key,
  })  : signIn = mode == AuthMode.signIn,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    AuthBloc bloc = BlocProvider.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: CancelButton(),
            backgroundColor: Colors.white,
            elevation: 0,
            shape: Border(
              bottom: BorderSide(
                color: AppColors.appBarShapeColor,
              ),
            ),
          ),
          body: BlocListener(
            cubit: bloc,
            listener: (context, state) {
              if (state is AuthError) {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  ScreenTitle(
                      text: signIn ? AppStrings.signIn : AppStrings.signUp),
                  SizedBox(height: 47),
                  FieldsScreen(
                    key: Key('FieldsScreen'),
                    signIn: signIn,
                    bloc: bloc,
                  ),
                ]),
          )),
    );
  }
}
