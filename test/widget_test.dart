// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_absensi/bloc/login_bloc/bloc.dart';
import 'package:mobile_absensi/bloc/login_bloc/login_event.dart';
import 'package:mobile_absensi/bloc/login_bloc/login_state.dart';

import 'package:mobile_absensi/main.dart';

void main() {
  group("login bloc test", () {
    test("deffault", () async {
      var login = LoginBloc();
      await emitsExactly(login, [isA<LoginState>()]);
    });
    test("login fail", () async {
      var login = LoginBloc();
      login.add(LoginButtonPress("email", "password"));
      emitsExactly(login, [isA<LoginLoading>(), isA<LoginFail>()]);
    });
    test("login succes", () async {
      var login = LoginBloc();
      login.add(LoginButtonPress("falakh@mail.com", "fahmi134679"));
      emitsExactly(login, [isA<LoginLoading>(), isA<LoginSucces>()]);
    });

     test("login loading", () async {
      var login = LoginBloc();
      login.add(LoginButtonPress("falakh@mail.com", "fahmi134679"));
      emitsExactly(login, [isA<LoginLoading>()]);
    });
  });


}
