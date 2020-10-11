import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/app/utils/errors.dart';
import 'package:gallery_test/repository/firebase/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    try {
      if (event is SignIn) {
        String userId =
            await FireAuth.signIn(email: event.email, password: event.password);
        yield AuthSuccess(userId);
      }
      if (event is SignUp) {
        String userId = await FireAuth.signUp(
            email: event.email,
            oldPassword: event.oldPassword,
            confrimPassword: event.confirmPassword,
            name: event.name,
            dayOfBirth: event.bDayDate);
        yield AuthSuccess(userId);
      }
    } on AuthException catch (e) {
      yield AuthError(e.message);
    } on SocketException {
      yield AuthError(AppStrings.onSocketException);
    }
  }
}
