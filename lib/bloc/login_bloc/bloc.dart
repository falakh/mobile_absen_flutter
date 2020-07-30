import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:mobile_absensi/bloc/login_bloc/login_event.dart';
import 'package:mobile_absensi/bloc/login_bloc/login_state.dart';
import 'package:mobile_absensi/model/LoginResponseModel.dart';
import 'package:mobile_absensi/repository/Client.dart';
import 'package:mobile_absensi/repository/user_sharedpref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>  {


  

  @override
  // TODO: implement initialState
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    try{
      print("ebent");
    if(event is LoginButtonPress){
      var loginEvent = event;
      yield  (LoginLoading());
      var response = await Client.LoginUser(loginEvent.email, loginEvent.password);
      print("await");
      var user = LoginResponseModel.fromJson(jsonDecode(response)).data;
      UserSharedPref.SetUserID(user.id);


      yield LoginSucces(user);
      print(user.email);
      
    }
    }catch(e){
      yield (new LoginFail());
      print("fail"+e);
    }
  }  

}