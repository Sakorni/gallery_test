import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/ui/custom_widgets/error_snack_bar.dart';
import 'package:gallery_test/app/ui/scene/auth_page/bloc/auth_bloc.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/fields_screen.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/cancel_button.dart';
import 'package:gallery_test/app/ui/scene/navigation_page/bloc/repository_bloc.dart';
import 'package:gallery_test/app/ui/scene/navigation_page/navigation_screen.dart';

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
                showErrorSnackBar(context, state.message);
              } else if (state is AuthSuccess) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (context) => RepositoryBloc(state.user),
                        child: NavigationScreen(),
                      ),
                    ),
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
