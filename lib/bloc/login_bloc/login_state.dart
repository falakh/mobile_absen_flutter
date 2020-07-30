import 'package:equatable/equatable.dart';
import 'package:mobile_absensi/model/UserModel.dart';

class LoginState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => ["initial login state"];
}

class InitialLoginState extends LoginState {}

class LoginSucces extends LoginState {
  final UserModel result;
  LoginSucces(this.result);
  @override
  List<Object> get props => ["succes"];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => ["loading "];
}

class LoginFail extends LoginState {
  @override
  List<Object> get props => ["fail"];
}
