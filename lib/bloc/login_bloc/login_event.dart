abstract class LoginEvent{

}

class LoginButtonPress extends LoginEvent {
   final String email,password;
   LoginButtonPress(this.email,this.password);
}

