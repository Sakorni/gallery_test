import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/ui/scene/auth_page/bloc/auth_bloc.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/fields_screen.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/cancel_button.dart';
import 'package:gallery_test/app/ui/scene/home_page/home_page.dart';

class AuthPage extends StatelessWidget {
  final bool signIn;
  const AuthPage(this.signIn);
  @override
  Widget build(BuildContext context) {
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
                color: AppColors.mainGray,
              ),
            ),
          ),
          body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is AuthSuccess) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (_) => HomePage(
                              id: state.userId,
                            )),
                    (route) => false);
              }
            },
            child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  FieldsScreen(
                    signIn: signIn,
                  ),
                ]),
          )),
    );
  }
}
