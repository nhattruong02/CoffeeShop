
abstract class RegisterState {

}
class RegisterInitial extends RegisterState{

}
class errorMessage extends RegisterState{
  String messageError;

  errorMessage(this.messageError);
}
class RegisterLoading extends RegisterState{

}

class RegisterSuccess extends RegisterState{

}
class RegisterFail extends RegisterState{

}

