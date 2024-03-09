abstract class LoginState{

}
class LoginInitial extends LoginState{

}

class errorMessage extends LoginState{
  String messageError;

  errorMessage(this.messageError);
}
class LoginLoading extends LoginState{

}
class LoginSuccess extends LoginState{
  String messageSuccess;
  String role;
  LoginSuccess(this.messageSuccess,this.role);
}
class LoginFailue extends LoginState{
  String messageFail;
  LoginFailue(this.messageFail);
}
