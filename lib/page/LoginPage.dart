import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_absensi/bloc/login_bloc/bloc.dart';
import 'package:mobile_absensi/bloc/login_bloc/login_event.dart';
import 'package:mobile_absensi/bloc/login_bloc/login_state.dart';
import 'package:mobile_absensi/page/AbsenPage.dart';
import 'package:progress_dialog/progress_dialog.dart';

class LoginPage extends StatelessWidget {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  LoginBloc loginBlock = new LoginBloc();

  @override
  Widget build(BuildContext context) {
    var progressDialog = ProgressDialog(context, isDismissible: false);
    return BlocBuilder<LoginBloc,LoginState>(
        bloc: loginBlock,
        builder: (context, snapshot) {
          if (snapshot is LoginLoading) {
            Future.delayed(Duration.zero, () => progressDialog.show());
            print("loading");
          } else if (snapshot is LoginSucces) {
            Future.delayed(Duration.zero, () {
              progressDialog.hide();
              print("sukses");
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> new AbsenPage()));
            });
          } else if (snapshot is LoginFail) {
            Future.delayed(Duration.zero,(){
              progressDialog.hide();
            });

            print("fail");
          }

          return LoginForm(
              email: email, password: password, loginBlock: loginBlock);
        });
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key key,
    @required this.email,
    @required this.password,
    @required this.loginBlock,
  }) : super(key: key);

  final TextEditingController email;
  final TextEditingController password;
  final LoginBloc loginBlock;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: new Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: new Card(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                new TextField(
                  controller: this.email,
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.account_circle),
                      labelText: "UserName"),
                ),
                new TextField(
                  controller: this.password,
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.vpn_key),
                      labelText: "Password"),
                ),
                new MaterialButton(
                  onPressed: () => loginBlock.add(new LoginButtonPress(
                      email.value.text, password.value.text)),
                  color: Theme.of(context).primaryColor,
                  child: new Text("Login"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
