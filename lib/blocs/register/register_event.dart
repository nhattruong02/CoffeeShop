abstract class RegisterEvent{

}
class Register extends RegisterEvent{
  final String fullname;
  final String username;
  final String password;
  final String phone;


  Register({required this.fullname,required this.username,required this.password,required this.phone});

}